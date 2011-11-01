<?xml version="1.0"?>

<!-- ***********************************************************************
* 解析MSC3为WAP2.0（WML)
* 日期：2009-11-16
* by yesun
 ***********************************************************************-->
 
<!DOCTYPE wml
[
  <!ENTITY nbsp "&#160;">
]
>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- by wzc 引用外部文件. -->
  <xsl:import href="menubutton.xsl"/>
  
<!--入口-->
<xsl:template match="/msc">
<wml>
<head>
  <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
  <meta http-equiv="Cache-Control" content="must-revalidate" forua="true"/>
  <meta http-equiv="Cache-Control" content="no-cache" forua="true"/>
</head>
<card id="wml" title="{/msc/head/title}{$wap11Title}">
  <xsl:if test="/msc/@type = 'servermsg'">
    <xsl:attribute name="title">提示</xsl:attribute>
  </xsl:if>
  <p>
    <xsl:choose>
      <xsl:when test="/msc/@type = 'servermsg'"><xsl:apply-templates select="//msc" mode="servermsg"/></xsl:when>
      <xsl:when test="@type = 'imageview'">
        <xsl:variable name="page" select="@page"></xsl:variable>
        <xsl:apply-templates select="image[position() = $page]" mode="imageview" >
          <xsl:with-param name="pre" select="@pre"></xsl:with-param>
          <xsl:with-param name="next" select="@next"></xsl:with-param>
          <xsl:with-param name="last" select="@count"></xsl:with-param>
          <xsl:with-param name="page" select="@page"></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="@type = 'table'">
        <xsl:value-of select="@caption"/><br />
        <xsl:if test="menu/item">
          <select>
            <xsl:apply-templates select="menu/item" mode="table" />
          </select>
        </xsl:if>
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">关闭</a>
        <br />
        <table columns="{//table/@columns}">
          <xsl:apply-templates select="table/tr" mode="table" />
        </table>
      </xsl:when>
      <xsl:otherwise>
        <!--span top-->
        <xsl:apply-templates select="//span[@dock='top']" mode="dock"/>
        <!--两种情况，一是有body的，二是无body的-->
        <xsl:apply-templates select="/msc/child::*[name() != 'head']"/>
        <!--span bottom-->
        <xsl:apply-templates select="//span[@dock='bottom']" mode="dock"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- 内容结束 -->


  <!--bottom-->
  <xsl:choose>
    <xsl:when test="/msc/@isLogin = 'true'">
      <xsl:call-template name="getMenuButtons">
        <xsl:with-param name="outputType" select="$wap11"></xsl:with-param>
        <xsl:with-param name="mode" select="'login'"></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="/msc/@isHome = 'true'">
      <xsl:call-template name="getMenuButtons">
        <xsl:with-param name="outputType" select="$wap11"></xsl:with-param>
        <xsl:with-param name="mode" select="'home'"></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="/msc/@type = 'form'">
          <xsl:call-template name="getMenuButtons">
            <xsl:with-param name="outputType" select="$wap11"></xsl:with-param>
            <xsl:with-param name="mode" select="'default'"></xsl:with-param>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
  <!--bottom-->

  </p>
</card>
</wml>
</xsl:template>

  <xsl:template match="item" mode="table">
    <option onpick="{$wapAction}{@href}&amp;{$QRY}">
      <xsl:if test="@selected = 'true'">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="@caption"/>
    </option>
  </xsl:template>
  
  <xsl:template match="tr" mode="table">
    <tr>
      <xsl:apply-templates select="td" mode="table" />
    </tr>
  </xsl:template>

  <xsl:template match="td" mode="table">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  
  <xsl:template match="image" mode="imageview">
    <xsl:param name="pre"></xsl:param>
    <xsl:param name="next"></xsl:param>
    <xsl:param name="last"></xsl:param>
    <xsl:param name="page"></xsl:param>
    <!-- 固定协议. do参数(1:放大两倍 ; 2:放大1.5倍 ; 3:向右旋转 ; 4:保持 ; 0:还原|默认 ;).-->
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=1">放大2倍</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=2">放大1.5倍</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=3">向右旋转</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}">还原</a>|
    <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">关闭</a>
    <br />
    <img src="{$wapAction}{@src}&amp;force=true&amp;rotate=0&amp;width={@width}&amp;height={@height}&amp;_MSC_CMD_=QRY">
      <xsl:if test="@realWidth and @realHeight and @rotate">
        <xsl:attribute name="src">
          <xsl:value-of select="concat($wapAction,@src,'&amp;force=true&amp;rotate=',@rotate,'&amp;width=',@realWidth,'&amp;height=',@realHeight,'&amp;_MSC_CMD_=QRY')"/>
        </xsl:attribute>
      </xsl:if>
    </img>
    <br />
    《<xsl:value-of select="$page"/>/<xsl:value-of select="$last"/>》
    <br />
    <a href="{$wapAction}?action=viewimage@wap&amp;page=1&amp;do=4">第一张</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$pre}&amp;do=4">上一张</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$next}&amp;do=4">下一张</a>|
    <a href="{$wapAction}?action=viewimage@wap&amp;page={$last}&amp;do=4">最后一张</a>
    <br />
  </xsl:template>

<!-- 普通标签开始-->

<!-- body|div template -->
<xsl:template match="body|div">
    <xsl:apply-templates />
</xsl:template>


<!-- script template :: 暂时 -->
<xsl:template match="script">
</xsl:template>

<!-- span template wml 不支持p标签嵌套，所以这里没则，只能忽略 -->
<xsl:template match="span">
  <xsl:if test="not(@dock) or @dock = 'none'"><xsl:apply-templates /></xsl:if>
  <xsl:if test="@width='100%'">
    <br/>
  </xsl:if>
</xsl:template>

<!-- span template -->
<xsl:template match="span" mode="dock">
    <xsl:apply-templates />
</xsl:template>

<!-- font template size : xs，s，m，l，xl -->
  <xsl:template match="font">
    <xsl:choose>
      <xsl:when test="child::*">
        <xsl:apply-templates />
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@size = 'xs' or @size = 's'">
          <small>
            <xsl:value-of select="."></xsl:value-of>
          </small>
        </xsl:when>
        <xsl:when test="@size='m'">
          <xsl:value-of select="."></xsl:value-of>
        </xsl:when>
        <xsl:when test="@size='l' or @size = 'xl'">
          <big>
            <xsl:value-of select="."></xsl:value-of>
          </big>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."></xsl:value-of>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

<!-- u template -->
<xsl:template match="u">
  <xsl:choose>
    <xsl:when test="child::*">
      <xsl:apply-templates />
    </xsl:when>
    <xsl:otherwise>
      <u>
        <xsl:value-of select="."/>
      </u>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- i template -->
<xsl:template match="i">
  <xsl:choose>
    <xsl:when test="child::*">
      <xsl:apply-templates />
    </xsl:when>
    <xsl:otherwise>
      <em>
        <xsl:value-of select="."/>
      </em>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- strong template -->
<xsl:template match="strong">
  <xsl:choose>
    <xsl:when test="child::*">
      <xsl:apply-templates />
    </xsl:when>
    <xsl:otherwise>
      <strong>
        <xsl:value-of select="."/>
      </strong>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  
<!-- input template
同时处理所有的input，需要正确展现所有input控件，并且提交所有的input控件
注意点如下：
1、submit时需要提交按钮的name和value
-->
<xsl:template match="input">
<xsl:if test="@type != 'reset'">
<xsl:choose>
    <xsl:when test="@visible = 'false'"></xsl:when>
    <!--常见input-->
    <xsl:when test="@type = 'text' or @type = 'file' or @type = 'password' or @type = 'PASSWORD'">
    <input type="{@type}" name="{@name}" value="{@value}">
      <xsl:if test="@checked = 'true' or @selected='true' or @selected='selected'">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
    </input>
    </xsl:when>
    <!--input中的button-->
    <xsl:when test="@type = 'button'">
      <xsl:choose>
        <xsl:when test="@enable = 'false' or not(@href)"><xsl:value-of select="@caption"></xsl:value-of></xsl:when>
        <xsl:otherwise>
          <a href="#">
          <xsl:if test="@href != ''">
           <xsl:attribute name="href">
              <xsl:call-template name="handleUrl">
                <xsl:with-param name="url">
                  <xsl:choose>
                    <xsl:when test="@href != ''"><xsl:value-of select="@href"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="msc/@action"/></xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if><xsl:value-of select="@caption"/></a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>&#160;</xsl:text>
    </xsl:when>
    <xsl:when test="@type ='submit'">
    <!-- 提交 -->
    <anchor><xsl:value-of select="@caption"></xsl:value-of>
    <go method="post">
    <xsl:if test="/msc/@enableReferer = 'true'">
    <xsl:attribute name="sendreferer">true</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="href">
      <xsl:call-template name="handleUrl">
        <xsl:with-param name="url" select="/msc/@action">
        </xsl:with-param>
        <xsl:with-param name="append"><xsl:if test="@name!=''"><xsl:value-of select="concat('&amp;',@name,'=',@value)"/></xsl:if></xsl:with-param>
      </xsl:call-template>
    </xsl:attribute>

    <!-- 需要这里增加postfield -->
    <!-- all hidden input -->
    <xsl:for-each select="//input[@type='hidden']">
      <xsl:if test="@name != ''">
        <postfield name="{@name}" value="{@value}" />
      </xsl:if>
    </xsl:for-each>
    <!-- all input,select,textarea -->
    <xsl:for-each select="//*[(name()='input' and @type != 'hidden' and @type != 'submit') or name() ='select' or name() = 'textarea' or name() = 'date_time' or name() = 'combotree' or name() = 'tree']">
      <xsl:if test="@name != ''">
        <postfield name="{@name}" value="${@name}">
          <xsl:if test="name()='tree' or name()='combotree'">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('MSCTREE_',@name)"/>
            </xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="concat('$MSCTREE_',@name)"/>
            </xsl:attribute>
          </xsl:if>
        </postfield>
      </xsl:if>
    </xsl:for-each>
    </go>
    </anchor>
    <xsl:text>&#160;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:if>
</xsl:template>



<!--解析textarea标签 -->
<xsl:template match="textarea">
  <xsl:if test="@caption != ''">
  <br/>
  <xsl:value-of select="@caption"></xsl:value-of>
  </xsl:if>
  <br/>
  <input type="text" name="{@name}" value="{.}"/>
</xsl:template>

<!-- br template -->
<xsl:template match="br">
  <br />
</xsl:template>

<!-- hr template -->
<xsl:template match="hr">
  <br/>
  ---------------------
  <br/>
</xsl:template>

<!-- a template -->
<xsl:template match="a">
  <a href="#">
    <xsl:if test="@href != ''">
      <xsl:attribute name="href">
        <xsl:call-template name="handleUrl_20">
          <xsl:with-param name="url" select="@href" />
          <xsl:with-param name="type" select="'bs'" />
        </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;<xsl:value-of select="$target"/>=_blank</xsl:if>
      </xsl:attribute>
      <xsl:if test="not(@target) or @target != '_blank'">
        <xsl:attribute name="target">_self</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="." />
  </a>
</xsl:template>

<!-- img template,需要处理img上的href -->
<xsl:template match="img">
 <xsl:choose>
  <xsl:when test="not(@href) or @href = ''"><xsl:apply-templates select="." mode="bll" /></xsl:when>
  <xsl:otherwise>
    <a href="#">
    <xsl:if test="@href != ''">
      <xsl:attribute name="href">
        <xsl:call-template name="handleUrl_20">
          <xsl:with-param name="url" select="@href" />
          <xsl:with-param name="type" select="'bs'" />
        </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if>
      </xsl:attribute></xsl:if><xsl:apply-templates select="." mode="bll" />
    </a>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- 真正解析img-->
<xsl:template match="img" mode="bll">
<img alt="loading img...">
<xsl:attribute name="src">
<xsl:choose>
<xsl:when test="starts-with(@src,$wapAction) or starts-with(@src,'http')"><xsl:value-of select="@src" /></xsl:when>
<xsl:when test="starts-with(@src,'?')"><xsl:value-of select="$wapAction" />?_MSC_CMD_=QRY&amp;<xsl:value-of select="substring-after(@src,'?')" /></xsl:when>
<xsl:otherwise><xsl:value-of select="concat($wapAction,$getimg,@src)"/></xsl:otherwise>
  </xsl:choose>
</xsl:attribute>
<xsl:if test="@alt">
  <xsl:attribute name="alt"><xsl:value-of select="@alt" /></xsl:attribute>
</xsl:if>
</img>
</xsl:template>

<!-- select template -->
<xsl:template match="select">
  <br/>
  <xsl:value-of select="@caption" />
  <select>
    <xsl:if test="@multiple='true'">
      <xsl:attribute name="multiple">true</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="name">
      <xsl:choose>
      <xsl:when test="@name != ''"><xsl:value-of select="@name"></xsl:value-of></xsl:when>
      <xsl:otherwise>sel</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:if test="@value != ''">
      <xsl:attribute name="value"><xsl:value-of select="@value"></xsl:value-of></xsl:attribute>
    </xsl:if>
    <xsl:for-each select="option">
      <option value="{@value}">
      <xsl:if test="@href != ''">
      <!--
      <xsl:attribute name="onclick">location.href='m.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/>'</xsl:attribute>-->
      <xsl:attribute name="onpick"><xsl:call-template name="handleUrl_20">
          <xsl:with-param name="url" select="@href" />
          <xsl:with-param name="type" select="'bs'" />
        </xsl:call-template><xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if></xsl:attribute>
      </xsl:if>
      <xsl:choose>
      <xsl:when test="text() != ''">
      <xsl:value-of select="."></xsl:value-of>
      </xsl:when>
      <xsl:when test="child::*">
        <!--如果有子节点比如u、i、strong、span等，甚至嵌套-->
        <xsl:value-of select="child::*"></xsl:value-of>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="@value"></xsl:value-of></xsl:otherwise>
      </xsl:choose>
      </option>
    </xsl:for-each>
  </select>
</xsl:template>


<!-- 普通标签结束-->

<!-- MSC标签开始-->

 
 <!--servermsg-->
 <xsl:template match="msc" mode="servermsg">
   <!--msg, script, requestresult-->
   <xsl:if test="msg/@show = 'true' or msg/@isshow = '1'">
    <xsl:apply-templates select="msg"/>
   </xsl:if>
 </xsl:template>


<!-- foot template -->
  <xsl:template match="foot">
    <br/>
    <xsl:apply-templates select="item" mode="foot"/>
  </xsl:template>

  <!-- foot:item template -->
  <xsl:template match="item" mode="foot">
    <xsl:choose>
      <xsl:when test="child::*">
        <xsl:apply-templates select="item" mode="foot"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="input"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- foot:item 这个item和input差不多功能，忽略reset template -->
  <xsl:template match="item" mode="input">
  <xsl:choose>
    <xsl:when test="@type ='reset'"></xsl:when>
    <!--item中的button-->
    <xsl:when test="@type = 'button' or not(@type)">
      <xsl:choose>
        <xsl:when test="@enable = 'false' or not(@href)"><xsl:value-of select="@caption"></xsl:value-of></xsl:when>
        <xsl:otherwise>
          <xsl:if test="@icon"><img src="{@icon}"/></xsl:if>
          <a href="#">
            <xsl:if test="@href != ''"><xsl:attribute name="href">
              <xsl:call-template name="handleUrl">
                <xsl:with-param name="url">
                  <xsl:choose>
                    <xsl:when test="@href != ''"><xsl:value-of select="@href"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="msc/@action"/></xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute></xsl:if><xsl:value-of select="@caption"/></a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>&#160;</xsl:text>
    </xsl:when>
    <xsl:when test="@type ='submit'">
    <!-- 提交 -->
    <anchor><xsl:value-of select="@caption"></xsl:value-of>
    <go method="post">
    <xsl:if test="/msc/@enableReferer = 'true'">
    <xsl:attribute name="sendreferer">true</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="href">
      <xsl:call-template name="handleUrl">
        <xsl:with-param name="url" select="/msc/@action"/>
        <xsl:with-param name="append"><xsl:if test="@name!=''"><xsl:value-of select="concat('&amp;',@name,'=',@value)"/></xsl:if></xsl:with-param>
      </xsl:call-template>
    </xsl:attribute>

    <!-- 需要这里增加postfield -->
    <!-- all hidden input -->
    <xsl:for-each select="//input[@type='hidden']">
      <xsl:if test="@name != ''">
        <postfield name="{@name}" value="{@value}" />
      </xsl:if>
    </xsl:for-each>
    <!-- all input,select,textarea -->
    <xsl:for-each select="//*[(name()='input' and @type != 'hidden' and @type != 'submit') or name() ='select' or name() = 'textarea' or name() = 'date_time' or name() = 'combotree' or name() = 'tree']">
      <xsl:if test="@name != ''">
        <postfield name="{@name}" value="${@name}" >
        	<!-- 修正tree标签时提交值为空的BUG by zgh date：100611 -->
           <xsl:if test="name()='tree' or name()='combotree'">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('MSCTREE_',@name)"/>
            </xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="concat('$MSCTREE_',@name)"/>
            </xsl:attribute>
          </xsl:if>
        </postfield>
      </xsl:if>
    </xsl:for-each>
    </go>
    </anchor>
    <xsl:text>&#160;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>
  
  

<!-- grid template -->
<xsl:template match="grid">
  <!-- 只支持列表 -->
  <br/>
  <xsl:apply-templates select="item" mode="grid"/>
  <br/>
</xsl:template>
  
<!-- group item for grid -->
<xsl:template match="item" mode="grid">
  <xsl:if test="not(visible) or @visible != 'false'">
    <a href="#">
    <xsl:if test="@href != ''">
    <xsl:attribute name="href">
      <xsl:call-template name="handleUrl2">
        <xsl:with-param name="url" select="@href" />
        <xsl:with-param name="type" select="'bs'" />
      </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;<xsl:value-of select="$target"/>=_blank</xsl:if>
    </xsl:attribute></xsl:if>
    <xsl:choose>
      <xsl:when test="@icon!=''">
        <xsl:choose>
         <xsl:when test="starts-with(@icon,'?')">
          <img src="{$appfolder}{@icon}" alt="{@caption}">
          	<xsl:attribute name="src"><xsl:call-template name="handleUrl"><xsl:with-param name="url" select="@icon" /><xsl:with-param name="type" select="'image'" /></xsl:call-template></xsl:attribute>
          </img>
          </xsl:when>
		      <xsl:when test="starts-with(@icon, 'http:')">
            <img alt="{@caption}" src="{@icon}"/>
            <br/>
          </xsl:when>
          <xsl:otherwise>
            <img src="{concat($wapAction,$getimg,@icon)}" alt="{@caption}"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <img alt="" src="{concat($wapAction,$getimg,'res:normal.png')}"/>
      </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="@caption"></xsl:value-of>
    </a>
    <xsl:if test="substring-before(@href,':')='tel'">
    （<a href="wtai://wp/mc;17951{substring-after(@href,':')}">IP拨叫</a>）
    </xsl:if>
    <br/>
  </xsl:if>
</xsl:template>

<!-- listbox template -->
<xsl:template match="listbox">
  <br/>
  <xsl:apply-templates select="listitem">
    <xsl:with-param name="mode" select="@mode"/>
  </xsl:apply-templates>
</xsl:template>


  <!-- listbox item template -->
  <xsl:template match="listitem">
    <!--checkbox-->
    <xsl:param name="mode"/>
    <xsl:if test="not(@icon)">
      <img src="{concat($wapAction,$getimg,'res:arr.gif')}"/>&#160;
    </xsl:if>
    <a href="#">
    <xsl:if test="@href != ''">
    	<xsl:attribute name="href">
        <xsl:call-template name="handleUrl_20">
        <xsl:with-param name="url" select="@href"/>
        <xsl:with-param name="type" select="'bs'"/>
        </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;<xsl:value-of select="$target"/>=_blank</xsl:if>
      </xsl:attribute>
    </xsl:if>
      <xsl:if test="@icon!=''">
        <xsl:choose>
          <xsl:when test="starts-with(@icon, 'http:')">
            <img alt="" src="{@icon}" />
          </xsl:when>
          <xsl:when test="starts-with(@icon,'?')">
           	<img>
        		<xsl:attribute name="src"><xsl:call-template name="handleUrl_20"><xsl:with-param name="url" select="@icon" /><xsl:with-param name="type" select="'image'" /></xsl:call-template></xsl:attribute>
        	</img>
        	</xsl:when>
          <xsl:otherwise>
            <img src="{concat($wapAction,$getimg,@icon)}"></img>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
        <font>
        <xsl:apply-templates select="caption"/>
        </font>
    </a>
    <xsl:if test="substring-before(@href,':')='tel'">
      （<a href="wtai://wp/mc;17951{substring-after(@href,':')}">IP拨叫</a>）
    </xsl:if>
    <br/>
    <!--读取摘要信息-->

    <xsl:if test="subcaption">
      <xsl:apply-templates select="subcaption" />
      <br/>
    </xsl:if>
    <xsl:if test="sndcaption">
      <xsl:apply-templates select="sndcaption" />
      <br/>
    </xsl:if>
   
    <!--读取摘要信息-->
    <xsl:if test="digest">
      <xsl:apply-templates select="digest" />
      <br/>
    </xsl:if>
  </xsl:template>

<!-- table template -->
<xsl:template match="table">
</xsl:template>


  <!-- combotree/tree template @by yesun
处理combotree和tree，在WAP1.0上统一转化为展开的select结构
需要支持的属性有：
name，名称
caption，显示的text
checkbox，是否需要多选框
href，链接地址
childurl，子节点url（点击+号时自动获取子节点数据，然后展开）
expandlvl，默认展开级别，当默认展开级别中有childurl的item，那么需要自动获取数据整合后展开
submitall，是否需要提交所有，默认为true，当为false时，只需要提交选中的item
icon，显示图标
selected，是否选中
target，开窗方式
-->
  <xsl:template match="combotree|tree">
    <xsl:value-of select="@caption"/>
    <select name="MSCTREE_{@name}">
      <xsl:if test="@checkbox = 'true'">
        <xsl:attribute name="multiple">true</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="treeitem">
        <xsl:with-param name="name" select="concat('MSCTREE_',@name)"/>
        <xsl:with-param name="checkbox" select="@checkbox"/>
        <xsl:with-param name="level" select="'0'"/>
        <xsl:with-param name="leftspace" select="''"/>
      </xsl:apply-templates>
    </select>
  </xsl:template>

  <!--树节点模板-->
  <xsl:template match="treeitem">
    <xsl:param name="name"/>
    <xsl:param name="checkbox"/>
    <xsl:param name="level"/>
    <xsl:param name="leftspace"/>

    <option value="{@nid}">
      <xsl:choose>
        <xsl:when test="@href">
          <xsl:attribute name="onpick">m.do<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
        </xsl:when>
        <xsl:when test="@childurl">
          <xsl:attribute name="onpick">m.do<xsl:value-of select="@childurl"/></xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <!--预留空格-->
      <xsl:value-of select="$leftspace"/>
      <!--系统图标-->
      <xsl:choose>
        <xsl:when test="count(following-sibling::*) &gt; 0 or treeitem">┣</xsl:when>
        <xsl:otherwise>┗</xsl:otherwise>
      </xsl:choose>

      <xsl:value-of select="@caption"/>

    </option>

    <xsl:apply-templates select="treeitem">
      <xsl:with-param name="name" select="$name"/>
      <xsl:with-param name="checkbox" select="$checkbox"/>
      <xsl:with-param name="level" select="number($level + 1)"/>
      <xsl:with-param name="leftspace" select="concat('┄',$leftspace)"/>
    </xsl:apply-templates>
  </xsl:template>
  
  

<!-- contentmenu template -->
<xsl:template match="contentmenu">
</xsl:template>

<!-- picbox template -->
<xsl:template match="picbox">
</xsl:template>

<!-- date_time template -->
<xsl:template match="date_time">
  <input name="{@name}" value="{@value}"/>
</xsl:template>

<!-- login template -->
<xsl:template match="login">
<br />用户名：<br /><input name="username" type="text" tabindex="1" /><br/>
密&nbsp;&nbsp;码：<br /><input name="password" type="password" tabindex="2"/><br/>
<xsl:if test="/msc/@isLogin = 'true' and /msc/@needRnd = 'true'">
  验证码：<br /><input name="rnd" type="text" tabindex="3"/><br/><img src="../rnd.do?type=wap_rnd" alt="验证码"/><br/>
</xsl:if>
  <anchor>登录
<go method="post" href="{$wapAction}">
<postfield name="username" value="$username"></postfield>
<postfield name="password" value="$password"></postfield>
<postfield name="rnd" value="$rnd"></postfield>
<xsl:if test="/msc/@isLogin = 'true' and /msc/@needRnd = 'true'">
  <postfield name="chkrnd" value="true"></postfield>
</xsl:if>
  <!-- 如果有隐藏的input，需要这里增加postfield -->
<xsl:for-each select="//input[@type='hidden']">
<postfield name="{@name}" value="{@value}"></postfield>
</xsl:for-each>

<!-- 固定参数，需要post给服务器 -->
<postfield name="_MSC_CMD_" value="USR"></postfield>
<postfield name="action" value="login"></postfield>
<postfield name="logintype" value="wap"></postfield>
<postfield name="mscver" value="450"></postfield>
<postfield name="phonemodel" value="wap"></postfield>
<postfield name="appid" value="{/msc/@appid}"></postfield>
<postfield name="appver" value="{/msc/@appver}"></postfield>
<postfield name="siid" value="{/msc/@siid}"></postfield>
<postfield name="ishide" value="1"></postfield>
<postfield name="customername" value="{/msc/@customername}"/>
<postfield name="partnerid" value="{/msc/@partnerid}"/>
<postfield name="partnername" value="{/msc/@partnername}"/>
<postfield name="screensize" value="240*320"/>

</go>
</anchor>
<br/>
</xsl:template>


  <!-- fileset template -->
  <xsl:template match="fileset">
    <br/>
    <xsl:apply-templates select="fileitem" mode="fileset"/>
  </xsl:template>

  <!-- fileset:fileitem template -->
  <xsl:template match="fileitem" mode="fileset">
    <xsl:choose>
      <xsl:when test="@filetype = 'directory'"><img src="images/folder.png" alt="文件夹"/><a href="{$wapAction}{@href}"><xsl:value-of select="@caption"/></a>
      </xsl:when>
      <xsl:otherwise>
        <img alt="文件">
        <xsl:attribute name="src"><xsl:value-of select="concat($wapAction,$getimg,'res:')"/><xsl:choose>
          <xsl:when test="@filetype='zip' or @filetype='rar' or @filetype='jar' or @filetype='war' or contains(@caption,'.rar') or contains(@caption,'.zip')">rar.png</xsl:when>
          <xsl:when test="@filetype='xls' or @filetype='xlsx' or contains(@caption,'.xls')">xls.png</xsl:when>
          <xsl:when test="@filetype='txt' or @filetype='vcf' or @filetype='ini' or @filetype='csv' or @filetype='xml' or @filetype='log' or contains(@text,'.txt')">txt.png</xsl:when>
          <xsl:when test="@filetype='ppt' or @filetype='pptx' or @filetype='pps' or contains(@caption,'.ppt')">ppt.png</xsl:when>
          <xsl:when test="@filetype='jpg' or @filetype='jpeg'">jpg.png</xsl:when>
          <xsl:when test="@filetype='gif' or @filetype='bmp' or @filetype='tif' or @filetype='png'">pic.png</xsl:when>
          <xsl:when test="@filetype='pdf' or contains(@caption,'.pdf')">pdf.png</xsl:when>
          <xsl:when test="@filetype='doc' or @filetype='rtf' or @filetype='odt' or @filetype='docx' or contains(@caption,'.doc')">doc.png</xsl:when>
          <xsl:when test="@filetype='htm' or @filetype='shtml' or @filetype='html'">html.png</xsl:when>
          <xsl:otherwise>unknow.png</xsl:otherwise>
          </xsl:choose></xsl:attribute>
        </img>
        <xsl:variable name="filename" select="@href"/>
        <a href="#">
        <xsl:if test="@href != ''">
          <xsl:attribute name="href">
            <xsl:call-template name="handleUrl_20">
              <xsl:with-param name="url" select="@href" />
              <xsl:with-param name="type" select="'file'" />
            </xsl:call-template>
          </xsl:attribute></xsl:if>
          <xsl:value-of select="@caption"/></a><xsl:text>&#160;</xsl:text>
        <a href="#">
         <xsl:if test="@href != ''"><xsl:attribute name="href">
            <xsl:call-template name="handleUrl_20">
              <xsl:with-param name="url" select="@href" />
              <xsl:with-param name="type" select="'file'" />
            </xsl:call-template>&amp;do=download</xsl:attribute>
         </xsl:if>下载</a>
      </xsl:otherwise>
    </xsl:choose>
    <br/>
  </xsl:template>

  <!-- object template -->
  <xsl:template match="object">
  </xsl:template>



  <!--error模板-->
  <xsl:template match="/error">
    <wml>
      <head>
        <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
        <meta http-equiv="Cache-Control" content="must-revalidate" forua="true"/>
        <meta http-equiv="Cache-Control" content="no-cache" forua="true"/>
      </head>
      <card id="wml" title="错误{$wap11Title}">
        <p>
          <xsl:value-of select="."/>
          <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">确定</a>
        </p>
      </card>
    </wml>
  </xsl:template>

  <!--apps模板-->
  <xsl:template match="/apps">
    <wml>
      <head>
        <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
        <meta http-equiv="Cache-Control" content="must-revalidate" forua="true"/>
        <meta http-equiv="Cache-Control" content="no-cache" forua="true"/>
      </head>
      <card id="wml" title="应用列表{$wap11Title}">
        <xsl:if test="/apps/@isCloud = 'true'">
          <xsl:attribute name="title">进入应用<xsl:value-of select="$wap11Title"/></xsl:attribute>
        </xsl:if>
        <p>
          <xsl:choose>
            <xsl:when test="/apps/@isCloud = 'true'">
              <br />请输入业务系统：<br /><input name="appid" type="text" tabindex="1" /><br/>
              <anchor>进入
                <go method="post" href="{$wapAction}">
                  <postfield name="appid" value="$appid"></postfield>
                </go>
              </anchor>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="app" />
            </xsl:otherwise>
          </xsl:choose>
          <br />
          <xsl:call-template name="getMenuButtons">
            <xsl:with-param name="outputType" select="$wap11"></xsl:with-param>
            <xsl:with-param name="mode" select="'applist'"></xsl:with-param>
          </xsl:call-template>
        </p>
      </card>
    </wml>
  </xsl:template>

  <!--app模板-->
  <!--
      在普版中应用列表显示图片
      by mc 2010-07-29 
  -->
  <xsl:template match="app">
    <div class="app">
      <!-- 2010-07-29 by mc 修改普版显示图片路径地址 -->
      <!--<img src="{$wapfolder}/plugins.png" alt="" />-->
      <div id="left">
        <img src="{concat($wapAction,$getimg,@icon,'&amp;appid=',@appid)}" alt="" />
      </div>
      <div>
        <a href="{$wapAction}?appid={@appid}">
          <xsl:value-of select="@appName"/>
        </a>
      </div>
    </div>
    <br />
  </xsl:template>

  <!--servermsg模板-->
  <xsl:template match="/servermsg">
    <wml>
      <head>
        <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
        <meta http-equiv="Cache-Control" content="must-revalidate" forua="true"/>
        <meta http-equiv="Cache-Control" content="no-cache" forua="true"/>
      </head>
      <card id="wml" title="提示{$wap11Title}">
        <p>
          <xsl:if test="@icon != 'none.png'">
            <img src="{concat($wapAction,$getimg,@icon)}" alt=""/>
            <br />
          </xsl:if>
          <xsl:value-of select="text()"/>
          <br />
          <xsl:call-template name="handleScriptBtn">
            <xsl:with-param name="btn" select="@button" />
          </xsl:call-template>
        </p>
      </card>
    </wml>
  </xsl:template>

  <!--handleScriptBtn模板-->
  <xsl:template name="handleScriptBtn">
    <xsl:param name="btn"></xsl:param>
    <xsl:choose>
     <xsl:when test="$btn = 'OK'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=execute&amp;script={@action}">确定</a>
      </xsl:when>
      <xsl:when test="$btn = 'OK_Cancel'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=execute&amp;script={@action}">确定</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">取消</a>
      </xsl:when>
      <xsl:when test="$btn = 'Abort_Retry_Ignore'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">放弃</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=retry">重试</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=execute&amp;script={@action}">忽略</a>
      </xsl:when>
      <xsl:when test="$btn = 'Yes_No_Cancel'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=execute&amp;script={@action}">是</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">否</a>|
        //2010-09-08 by machao 增加标识，防止相同href地址的超连接不能分别点击
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel&amp;random=1">取消</a>
      </xsl:when>
      <xsl:when test="$btn = 'Yes_No'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=execute&amp;script={@action}">是</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">否</a>
      </xsl:when>
      <xsl:when test="$btn = 'Retry_Cancel'">
        <a href="{$wapAction}?action=script@wap&amp;cmd=retry">重试</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">取消</a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- MSC标签结束-->
  
  
  
  <!--公用处理URL的模板-->
  <xsl:template name="handleUrl">
    <xsl:param name="url" />
    <xsl:param name="append" />
    <xsl:param name="type" />
    <xsl:if test="$url != ''">
      <xsl:choose>
        <xsl:when test="starts-with($url,'http') or starts-with($url,$wapAction)"><xsl:value-of select="$url"></xsl:value-of><xsl:if test="$append != ''"><xsl:value-of select="$append"/></xsl:if></xsl:when>
        <xsl:when test="starts-with($url,'tel')">wtai://wp/mc;<xsl:value-of select="substring-after($url,':')"></xsl:value-of></xsl:when>
        <xsl:when test="starts-with($url,'?')"><xsl:value-of select="$wapAction" />?_MSC_CMD_=QRY&amp;<xsl:value-of select="substring-after($url,'?')"></xsl:value-of><xsl:if test="$append != ''"><xsl:value-of select="$append"/></xsl:if></xsl:when>
        <xsl:otherwise><xsl:value-of select="$wapAction" /><xsl:value-of select="$url"></xsl:value-of><xsl:if test="$append != ''"><xsl:value-of select="$append"/></xsl:if></xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
    <!--公用处理URL的模板-->
  <xsl:template name="handleUrl2">
    <xsl:param name="url" />
    <xsl:param name="type" />
    <xsl:if test="$url != ''">
      <xsl:choose>
        <xsl:when test="starts-with($url,'http')">
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of select="concat($wapAction,$bstransfer,$url)"/></xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$viewimageremote,$url)"/></xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($url,'?action=') or starts-with($url,$bstransfer) or starts-with($url,$viewfileremote) or starts-with($url,$viewimageremote) or starts-with($url,$localurl)"><xsl:choose><xsl:when test="$type = 'bs'"><xsl:value-of select="$wapAction"/><xsl:value-of select="$url"/>&amp;_MSC_CMD_=QRY</xsl:when><xsl:when test="$type = 'image'"><xsl:value-of select="$wapAction"/><xsl:value-of select="$url"/>&amp;_MSC_CMD_=QRY</xsl:when></xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($url,$wapAction) or starts-with($url,'m.do')"><xsl:value-of select="$url"/></xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of select="concat($wapAction,$getxml,$url)"/></xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$getimg,$url)"/></xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
   <!--公用处理URL的模板-->
  <xsl:template name="handleUrl_20">
    <xsl:param name="url" />
    <xsl:param name="type" />
    <xsl:if test="$url != ''">
      <xsl:choose>
        <xsl:when test="starts-with($url,'http')">
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of select="concat($wapAction,$bstransfer,$url)"/>&amp;_MSC_CMD_=QRY</xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$viewimageremote,$url)"/>&amp;_MSC_CMD_=QRY</xsl:when>
            <xsl:when test="$type = 'file'"><xsl:value-of select="concat($wapAction,$viewfileremote,$url)"/>&amp;_MSC_CMD_=QRY</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($url,'?action=') or starts-with($url,$bstransfer) or starts-with($url,$viewfileremote) or starts-with($url,$viewimageremote) or starts-with($url,$localurl)"><xsl:value-of select="$wapAction"/><xsl:value-of select="$url"/>&amp;_MSC_CMD_=QRY</xsl:when>
        <xsl:when test="starts-with($url,'m.do') or starts-with($url,$wapAction)"><xsl:value-of select="$url"/></xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of  select="concat($wapAction,$getxml,$url)"/></xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$getimg,$url)"/></xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
