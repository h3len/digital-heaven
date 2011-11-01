<?xml version="1.0"?>

<!-- ***********************************************************************
* 解析MSC3为WAP2.0（XHTML)
* 日期：2009-10-29
* by yesun
 ***********************************************************************-->
 
 
<!DOCTYPE html
[
  <!ENTITY nbsp "&#160;">
]
>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="menubutton.xsl"/>
  <!--<xsl:variable name="do" select="'/wap/m.do'"></xsl:variable>-->

  <xsl:template match="/error">
    <html xmlns="http://www.w3.org/1999/xhtml" xmlns:wml="http://www.wapforum.org/2001/wml">
      <head>
        <title>错误<xsl:value-of select="$wap20Title"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta name="MobileOptimized" content="240" />
        <link href="{concat($wapAction,$getskin,'msc3css.css')}" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <div style="width:100%" align="center">
          <xsl:value-of select="."/>
          <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">确定</a>
        </div>


      </body>
    </html>
  </xsl:template>

  <xsl:template match="/apps">
    <html xmlns="http://www.w3.org/1999/xhtml" xmlns:wml="http://www.wapforum.org/2001/wml">
      <head>
      	<title>
          <xsl:choose>
            <xsl:when test="/apps/@isCloud = 'true'">进入应用<xsl:value-of select="$wap20Title"/></xsl:when>
            <xsl:otherwise>应用列表<xsl:value-of select="$wap20Title"/></xsl:otherwise>
          </xsl:choose>
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta name="MobileOptimized" content="240" />
        <link href="{concat($wapAction,$getskin,'msc3css.css')}" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <xsl:choose>
          <xsl:when test="/apps/@isCloud = 'true'">
            <div class="app">
              <form action="{$wapAction}">
                请输入业务系统：<input type="text" name="appid" value=""/>
                <br />
                <input type="submit" value="进入" />
              </form>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="app" />
          </xsl:otherwise>
        </xsl:choose>
        <br />
        <xsl:call-template name="getMenuButtons">
          <xsl:with-param name="outputType" select="$wap20"></xsl:with-param>
          <xsl:with-param name="mode" select="'applist'"></xsl:with-param>
        </xsl:call-template>
        </body>
    </html>
  </xsl:template>

<xsl:template match="app">
    <div class="app">
      <div id="left">
      	<!-- 2010-07-30 by mc 修改绚版显示图片路径地址 -->
        <!--  <img src="{$wapfolder}/plugins.png" alt="" />-->
        <img src="{concat($wapAction,$getimg,@icon,'&amp;appid=',@appid)}" alt="" />
      </div>
      <div id="right">
        <a href="{$wapAction}?appid={@appid}">
          <xsl:value-of select="@appName"/>
        </a>
        <br />
        <font>
          <xsl:value-of select="@appver"/>&#160;<xsl:value-of select="@date"/>
        </font>
      </div>
    </div>
  </xsl:template>

    <xsl:template match="/servermsg">
    <html xmlns="http://www.w3.org/1999/xhtml" xmlns:wml="http://www.wapforum.org/2001/wml">
      <head>
        <title>提示<xsl:value-of select="$wap20Title"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta name="MobileOptimized" content="240" />
        <link href="{concat($wapAction,$getskin,'msc3css.css')}" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <div style="width:100%" align="center">
          <xsl:if test="@icon != 'none.png'">
            <img src="{concat($wapAction,$getimg,'res:',@icon)}" />
            <br />
          </xsl:if>
          <xsl:value-of select="text()"/>
          <br />
          <xsl:call-template name="handleScriptBtn">
            <xsl:with-param name="btn" select="@button" />
          </xsl:call-template>
        </div>

      </body>
    </html>
  </xsl:template>

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
        //2010-09-08 by machao 增加了标识，防止相同href地址的超链接无法单独点击
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel&amp;random=1">否</a>|
        <a href="{$wapAction}?action=script@wap&amp;cmd=cancel">取消</a>
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

  <xsl:variable name="suffix"><xsl:choose><xsl:when test="/msc/@nologin and /msc/@nologin = 'true'"><xsl:value-of select="concat('appid=',/msc/@appid,'&amp;nologin=',/msc/@nologin)" /></xsl:when><xsl:otherwise><xsl:value-of select="concat('appid=',/msc/@appid)" /></xsl:otherwise></xsl:choose></xsl:variable>
  
<xsl:template match="/msc">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:wml="http://www.wapforum.org/2001/wml">
<head>
	<title><xsl:value-of select="/msc/head/title/text()" /><xsl:value-of select="$wap20Title"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="cache-control" content="max-age=0" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta name="MobileOptimized" content="240" />
	<link href="{concat($wapAction,$getskin,'msc3css.css','&amp;',$suffix)}" rel="stylesheet" type="text/css" />
</head>
  <xsl:choose>
    <xsl:when test="@type = 'imageview'">
      <body>
        <xsl:variable name="page" select="@page"></xsl:variable>
        <xsl:apply-templates select="image[position() = $page]" mode="imageview" >
          <xsl:with-param name="pre" select="@pre"></xsl:with-param>
          <xsl:with-param name="next" select="@next"></xsl:with-param>
          <xsl:with-param name="last" select="@count"></xsl:with-param>
          <xsl:with-param name="page" select="@page"></xsl:with-param>
        </xsl:apply-templates>
      </body>
    </xsl:when>
    <xsl:when test="@type = 'table'">
      <body>
        <div  class="wfull ac">
          <xsl:value-of select="@caption"/>
        </div>
        <div class="wfull ar">
          <xsl:if test="menu/item">
            <select>
              <xsl:apply-templates select="menu/item" mode="table" />
            </select>
          </xsl:if>
            <a href="{$wapAction}?action=script@wap&amp;cmd=cancel&amp;{$suffix}">关闭</a>
        </div>
        <br />
        <table border="1">
          <xsl:apply-templates select="table/tr" mode="table" />
        </table>
      </body>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="/msc/child::*[name() != 'head']"/>
    </xsl:otherwise>
  </xsl:choose>
</html>
</xsl:template>

  <xsl:template match="item" mode="table">
    <option>
      <xsl:attribute name="wml:onpick"><xsl:value-of select="concat($wapAction,@href,'&amp;',$QRY)"/></xsl:attribute>
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
    <div style="width:100%" align="center">
      <!-- 固定协议. do参数(1:放大两倍 ; 2:放大1.5倍 ; 3:向右旋转 ; 4:保持 ; 0:还原|默认 ;).-->
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=1&amp;{$suffix}">放大2倍</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=2&amp;{$suffix}">放大1.5倍</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;do=3&amp;{$suffix}">向右旋转</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$page}&amp;{$suffix}">还原</a>|
      <a href="{$wapAction}?action=script@wap&amp;cmd=cancel&amp;{$suffix}">关闭</a>
      <br />
      <img src="{$wapAction}{@src}&amp;force=true&amp;rotate=0&amp;width={@width}&amp;height={@height}&amp;_MSC_CMD_=QRY&amp;{$suffix}">
        <xsl:if test="@realWidth and @realHeight and @rotate">
          <xsl:attribute name="src">
            <xsl:value-of select="concat($wapAction,@src,'&amp;force=true&amp;rotate=',@rotate,'&amp;width=',@realWidth,'&amp;height=',@realHeight,'&amp;_MSC_CMD_=QRY','&amp;',$suffix)"/>
          </xsl:attribute>
        </xsl:if>
      </img>
      <br />
      <div style="width:100%" align="right">《<xsl:value-of select="$page"/>/<xsl:value-of select="$last"/>》</div>
      <a href="{$wapAction}?action=viewimage@wap&amp;page=1&amp;do=4&amp;{$suffix}">第一张</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$pre}&amp;do=4&amp;{$suffix}">上一张</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$next}&amp;do=4&amp;{$suffix}">下一张</a>|
      <a href="{$wapAction}?action=viewimage@wap&amp;page={$last}&amp;do=4&amp;{$suffix}">最后一张</a>
    </div>
  </xsl:template>

<!-- 普通标签开始-->

<!-- body template -->
<xsl:template match="body">
<body>
<!-- 处理bgcolor,background,backgroundalign三个属性 -->
  <!-- FIXME by wzc 这里需要改善一下,因为bgcolor有可能是0x.... background有可能是网络图片 -->
  <xsl:choose>
    <xsl:when test="@background and @background != ''">
      <xsl:attribute name="background">
        <xsl:call-template name="handleUrl">
          <xsl:with-param name="url" select="@background" />
          <xsl:with-param name="type" select="'image'" />
        </xsl:call-template>
      </xsl:attribute>
    </xsl:when>
    <xsl:when test="@bgcolor and @bgcolor != ''">
      <xsl:attribute name="bgcolor">
        <xsl:choose>
          <xsl:when test="starts-with(@bgcolor,'#')">
            <xsl:value-of select="@bgcolor"/>
          </xsl:when>
          <xsl:when test="starts-with(@bgcolor,'0x')">
            <xsl:value-of select="concat('#',substring-after(@bgcolor,'0x'))"/>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>

  <!-- 自动解析BODY子节点 -->
  <!--判断一下是否需要form by yesun-->
  <xsl:choose>
    <xsl:when test="/msc/@action !=''">
      <form id="frmPost" name="frmPost" method="post" action="{$wapAction}{/msc/@action}&amp;_MSC_CMD_=QRY&amp;{$suffix}">
        <xsl:if test="//span[@dock = 'top']">
          <xsl:apply-templates select="//span[@dock = 'top']" mode="dock" />
          <div id="clear">&#160;</div>
        </xsl:if>
        <xsl:if test="//fileset/@enableadd='true' or (//fileset and not(//fileset/@enableadd))">
          <xsl:attribute name="enctype">multipart/form-data</xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
        <xsl:if test="//span[@dock = 'bottom']">
          <div id="clear">&#160;</div>
          <xsl:apply-templates select="//span[@dock = 'bottom']" mode="dock" />
          <div id="clear">&#160;</div>
        </xsl:if>
        <xsl:if test="/msc/foot/item">
          <div id="clear">&#160;</div>
          <xsl:apply-templates select="/msc/foot" mode="foot" />
          <div id="clear">&#160;</div>
        </xsl:if>
      </form>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="//span[@dock = 'top']">
        <xsl:apply-templates select="//span[@dock = 'top']" mode="dock" />
        <div id="clear">&#160;</div>
      </xsl:if>
      <xsl:apply-templates />
      <xsl:if test="//span[@dock = 'bottom']">
        <div id="clear">&#160;</div>
        <xsl:apply-templates select="//span[@dock = 'bottom']" mode="dock" />
        <div id="clear">&#160;</div>
      </xsl:if>
      <xsl:if test="/msc/foot/item">
        <div id="clear">&#160;</div>
        <xsl:apply-templates select="/msc/foot" mode="foot" />
        <div id="clear">&#160;</div>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
  <br />

  <!--bottom-->
  <xsl:choose>
    <xsl:when test="/msc/@isLogin = 'true'">
      <xsl:call-template name="getMenuButtons">
        <xsl:with-param name="outputType" select="$wap20"></xsl:with-param>
        <xsl:with-param name="mode" select="'login'"></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="/msc/@isHome = 'true'">
      <xsl:call-template name="getMenuButtons">
        <xsl:with-param name="outputType" select="$wap20"></xsl:with-param>
        <xsl:with-param name="mode" select="'home'"></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="getMenuButtons">
        <xsl:with-param name="outputType" select="$wap20"></xsl:with-param>
        <xsl:with-param name="mode" select="'default'"></xsl:with-param>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
  <!--bottom-->

</body>
</xsl:template>


<!-- div template -->
<xsl:template match="div">
  <!--//TODO-->
  <xsl:apply-templates />
</xsl:template>

<!-- script template -->
<xsl:template match="script">
</xsl:template>

<!-- span template -->
<xsl:template match="span">
  <xsl:choose>
    <xsl:when test="@dock and (@dock = 'top' or @dock='bottom')"></xsl:when>
    <xsl:when test="attribute::*">
      <div>
        <xsl:if test="@align and @align != 'left'">
          <xsl:attribute name="align">
            <xsl:value-of select="@align"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:variable name="style">
          <xsl:choose>
            <xsl:when test="@background and @background != ''">background-image:url(<xsl:call-template name="handleUrl"><xsl:with-param name="url" select="@background" /><xsl:with-param name="type" select="'image'" /></xsl:call-template>);</xsl:when>
            <xsl:otherwise>
              <xsl:if test="@bgcolor and starts-with(@bgcolor,'#')">background-color:<xsl:value-of select="@bgcolor" />;</xsl:if>
              <xsl:if test="@bgcolor and starts-with(@bgcolor,'0x')">background-color:#<xsl:value-of select="substring-after(@bgcolor,'0x')" />;</xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@visible and @visible = 'false'">display:none;</xsl:if>
          <xsl:if test="@width != ''">width:<xsl:value-of select="@width"/>;</xsl:if>
          <xsl:if test="@height != ''">height:<xsl:value-of select="@height"/>;</xsl:if>
          <xsl:choose>
            <xsl:when test="not(@width and @height) and @background">width:100%;height:100%;</xsl:when>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="$style != ''">
          <xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
        <xsl:text> </xsl:text>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
  <xsl:template match="span" mode="dock">
  <xsl:choose>
    <!--<xsl:when test="@dock and (@dock = 'top' or @dock='bottom')"></xsl:when>-->
    <xsl:when test="attribute::*">
      <div>
        <xsl:if test="@align and @align != 'left'">
          <xsl:attribute name="align">
            <xsl:value-of select="@align"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:variable name="style">
          <xsl:choose>
            <xsl:when test="@background and @background != ''">background-image:url(<xsl:call-template name="handleUrl"><xsl:with-param name="url" select="@background" /><xsl:with-param name="type" select="'image'" /></xsl:call-template>);</xsl:when>
            <xsl:otherwise>
              <xsl:if test="@bgcolor and starts-with(@bgcolor,'#')">background-color:<xsl:value-of select="@bgcolor" />;</xsl:if>
              <xsl:if test="@bgcolor and starts-with(@bgcolor,'0x')">background-color:#<xsl:value-of select="substring-after(@bgcolor,'0x')" />;</xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@visible and @visible = 'false'">display:none;</xsl:if>
          <xsl:if test="@width != ''">width:<xsl:value-of select="@width"/>;</xsl:if>
          <xsl:if test="@height != ''">height:<xsl:value-of select="@height"/>;</xsl:if>
          <!--<xsl:choose>
            <xsl:when test="not(@width and @height) and @background">width:100%;height:100%;</xsl:when>
          </xsl:choose>-->
        </xsl:variable>
        <xsl:if test="$style != ''">
          <xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
        <xsl:text> </xsl:text>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- font template -->
<xsl:template match="font">
  <!-- TODO by wzc  这里要进行判断,判断font不是listitem中caption、sndcaption、subcaption、digest节点的子节点,否则要特殊处理! -->
  <xsl:if test="1 = 1">
    <font class="{@size}">
      <xsl:if test="@color != '' and starts-with(@color,'#')">
        <xsl:attribute name="style">color:<xsl:value-of select="@color"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@color != '' and starts-with(@color,'0x')">
        <xsl:attribute name="style">color:#<xsl:value-of select="substring-after(@color,'0x')"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </font>
  </xsl:if>
</xsl:template>

<!-- u template -->
<xsl:template match="u">
  <!-- TODO by wzc  这里要进行判断,判断u不是listitem中caption、sndcaption、subcaption、digest节点的子节点,否则要特殊处理! -->
  <xsl:if test="1 = 1">
    <u>
      <xsl:apply-templates />
    </u>
  </xsl:if>
</xsl:template>

<!-- i template -->
<xsl:template match="i">
  <!-- TODO by wzc  这里要进行判断,判断i不是listitem中caption、sndcaption、subcaption、digest节点的子节点,否则要特殊处理! -->
  <xsl:if test="1 = 1">
    <i>
      <xsl:apply-templates />
    </i>
  </xsl:if>
</xsl:template>

<!-- strong template -->
<xsl:template match="strong">
  <!-- TODO by wzc  这里要进行判断,判断strong不是listitem中caption、sndcaption、subcaption、digest节点的子节点,否则要特殊处理! -->
  <xsl:if test="1 = 1">
    <strong>
      <xsl:apply-templates />
    </strong>
  </xsl:if>
</xsl:template>

<!-- input template -->
<xsl:template match="input">
  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="@type != ''">
        <xsl:value-of select="@type"/>
      </xsl:when>
      <xsl:otherwise>text</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="@type = 'password'">
      <input type="password">
        <xsl:if test="@enable = 'false'">
          <xsl:attribute name="readonly">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="@name != ''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@value != ''">
          <xsl:attribute name="value">
            <xsl:value-of select="@value"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@width != ''">
          <xsl:attribute name="style">width:<xsl:value-of select="@width"/>;</xsl:attribute>
        </xsl:if>
      </input>
    </xsl:when>
    <xsl:when test="@type = 'button'">
      <a>
        <xsl:choose>
          <xsl:when test="@enable = 'false'">
            <xsl:attribute name="style">color:#CCCCCC;</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="@href != ''">
              <xsl:attribute name="href">
                <xsl:call-template name="handleUrl">
                  <xsl:with-param name="url" select="@href" />
                  <xsl:with-param name="type" select="'bs'" />
                </xsl:call-template>
              </xsl:attribute>
              <xsl:if test="not(@target) or @target != '_blank'">
                <xsl:attribute name="target">_self</xsl:attribute>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of  select="@caption"/>
      </a>
    </xsl:when>
    <xsl:when test="@type = 'submit'">
      <!-- TODO by wzc 09-11-10 提交按钮不知道到底是显示caption好还是显示value好!!! -->
      <input type="submit">
        <xsl:if test="@enable = 'false'">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
        <xsl:if test="@name != ''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@value != ''">
            <xsl:attribute name="value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="@caption != ''">
            <xsl:attribute name="value">
              <xsl:value-of select="@caption"/>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </input>
    </xsl:when>
    <xsl:when test="@type = 'checkbox' or @type = 'radio'">
      <input type="{@type}">
        <!--<xsl:if test="@enable = 'false'">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>-->
        <xsl:if test="@name != ''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@value != ''">
          <xsl:attribute name="value">
            <xsl:value-of select="@value"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@checked = 'true'">
          <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
      </input>
      <xsl:if test="@caption != ''">
        <font>
          <xsl:value-of select="@caption"/>
        </font>
      </xsl:if>
    </xsl:when>
    <xsl:when test="@type = 'reset'">
      <input type="reset">
        <xsl:if test="@enable = 'false'">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
        <xsl:if test="@caption != ''">
          <xsl:attribute name="value">
            <xsl:value-of select="@caption"/>
          </xsl:attribute>
        </xsl:if>
      </input>
    </xsl:when>
    <xsl:when test="@type = 'hidden'">
      <input type="hidden">
        <xsl:if test="@name != ''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@value != ''">
          <xsl:attribute name="value">
            <xsl:value-of select="@value"/>
          </xsl:attribute>
        </xsl:if>
      </input>
    </xsl:when>
    <xsl:otherwise>
      <!--text 比较复杂,因为要处理format(email,phonenum,numeric,decimal,any) 俺能力有限,只处理了numeric...谁要想弄就自己来写吧..-->
      <xsl:variable name="format">
        <xsl:choose>
          <xsl:when test="@format = 'numeric'">numeric</xsl:when>
          <xsl:when test="@format = 'email'">email</xsl:when>
          <xsl:when test="@format = 'phonenum'">phonenum</xsl:when>
          <xsl:when test="@format = 'decimal'">decimal</xsl:when>
          <xsl:otherwise>any</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <input type="text">
        <xsl:if test="@enable = 'false'">
          <xsl:attribute name="readonly">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="@readonly = 'true'">
          <xsl:attribute name="readonly">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="@name != ''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@value != ''">
          <xsl:attribute name="value">
            <xsl:value-of select="@value"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@width != ''">
          <xsl:attribute name="style">width:<xsl:value-of select="@width"/>;</xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$format = 'numeric'">
            <xsl:attribute name="class">numeric</xsl:attribute>
          </xsl:when>
          <xsl:when test="$format = 'email'">
            <!-- TODO -->
          </xsl:when>
          <xsl:when test="$format = 'phonenum'">
            <!-- TODO -->
          </xsl:when>
          <xsl:when test="$format = 'decimal'">
            <!-- TODO -->
          </xsl:when>
        </xsl:choose>
      </input>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- br template -->
<xsl:template match="br">
  <br />
</xsl:template>

<!-- hr template -->
<xsl:template match="hr">
  <hr>
    <xsl:if test="attribute::*">
      <xsl:variable name="style">border:<xsl:choose><xsl:when test="@size"><xsl:value-of select="@size"/></xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose><xsl:value-of select="' '"/><xsl:if test="@color and starts-with(@color,'#')"><xsl:value-of select="concat(@color,' ')"/></xsl:if><xsl:if test="@color and starts-with(@color,'0x')"><xsl:value-of select="concat('#',substring-after(@color,'0x'),' ')"/></xsl:if>solid;</xsl:variable>
      <xsl:attribute name="style">
        <xsl:value-of select="$style"/>
      </xsl:attribute>
    </xsl:if>
  </hr>
</xsl:template>

<!-- a template -->
<xsl:template match="a">
  <a>
    <xsl:if test="@href != ''">
      <xsl:attribute name="href">
        <xsl:call-template name="handleUrl">
          <xsl:with-param name="url" select="@href" />
          <xsl:with-param name="type" select="'bs'" />
        </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if>
      </xsl:attribute>
      <xsl:if test="not(@target) or @target != '_blank'">
        <xsl:attribute name="target">_self</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="text()" />
  </a>
</xsl:template>

<!-- img template,需要处理img上的href -->
<xsl:template match="img">
 <xsl:choose>
  <xsl:when test="not(@href) or @href = ''">
    <xsl:apply-templates select="." mode="bll" />
  </xsl:when>
  <xsl:otherwise>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="handleUrl">
          <xsl:with-param name="url" select="@href" />
          <xsl:with-param name="type" select="'bs'" />
        </xsl:call-template>
        <xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="bll" />
    </a>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- 真正解析img-->
<xsl:template match="img" mode="bll">
<img alt="loading img...">
<xsl:attribute name="src">
  <xsl:call-template name="handleUrl">
    <xsl:with-param name="url" select="@src" />
    <xsl:with-param name="type" select="'image'" />
  </xsl:call-template>
</xsl:attribute>
  <xsl:if test="@alt">
    <xsl:attribute name="alt"><xsl:value-of select="@alt" /></xsl:attribute>
  </xsl:if>
</img>
</xsl:template>

<!-- select template -->
<xsl:template match="select">
  <select>
    <xsl:if test="@name != ''">
      <xsl:attribute  name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@width != ''">
      <xsl:attribute name="style">width:<xsl:value-of select="@width"/>;</xsl:attribute>
    </xsl:if>
    <xsl:if test="@readonly = 'true'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test="@enable = 'false'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test="option">
      <xsl:apply-templates select="option" mode="select" />
    </xsl:if>
  </select>
</xsl:template>

  <xsl:template match="option" mode="select" >
    <option>
      <xsl:if test="@selected = 'true'">
        <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
      <xsl:if test="@value != ''">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@href != ''">
        <xsl:attribute name="wml:onpick"><xsl:call-template name="handleUrl"><xsl:with-param name="url" select="@href" /><xsl:with-param name="type" select="'bs'" /></xsl:call-template></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test=". != ''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@value"/>
        </xsl:otherwise>
      </xsl:choose>
    </option>
  </xsl:template>

<!-- textarea template -->
<xsl:template match="textarea">
  <!--TODO by wzc 09-11-11 WAP上无法实现textarea的快捷短语...-->
  <xsl:if test="@caption">
    <font>
      <xsl:value-of select="@caption" />
    </font>
    <br />
  </xsl:if>
  <textarea name="{@name}">
    <xsl:if test="@line != ''">
      <xsl:attribute name="rows">
        <xsl:value-of select="@line"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@enable = 'false'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test="@readonly = 'true'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test=". = ''">&#160;</xsl:if>
    <xsl:value-of select="text()"/>
  </textarea><br />
</xsl:template>

<!-- 普通标签结束-->

<!-- MSC标签开始-->


<!-- foot template -->
<xsl:template match="foot">
</xsl:template>

  <!-- foot template -->
  <xsl:template match="foot" mode="foot">
      <xsl:if test="/msc/foot//item[@align='primary']">
        <div style="width:49%;float:left;">
          <xsl:apply-templates select="/msc/foot//item[@align='primary']" mode="foot" />
          <xsl:text> </xsl:text>
        </div>
      </xsl:if>
      <div style="width:49%;float:right; ">
        <xsl:apply-templates select="/msc/foot//item[not(@align) or @align != 'primary']" mode="foot" />
        <xsl:text> </xsl:text>
      </div>
  </xsl:template>

  <xsl:template match="item" mode="foot">
    <xsl:choose>
      <xsl:when test="item">
        <xsl:apply-templates select="item" mode="foot" />
      </xsl:when>
      <xsl:when test="@type = 'submit'">
        <input type="submit">
          <xsl:if test="@enable = 'false'">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          <xsl:if test="@name != ''">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="@value != ''">
              <xsl:attribute name="value">
                <xsl:value-of select="@value"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="@caption != ''">
              <xsl:attribute name="value">
                <xsl:value-of select="@caption"/>
              </xsl:attribute>
            </xsl:when>
          </xsl:choose>
        </input>
      </xsl:when>
      <xsl:when test="@type = 'reset'">
        <input type="reset">
          <xsl:if test="@enable = 'false'">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          <xsl:if test="@caption != ''">
            <xsl:attribute name="value">
              <xsl:value-of select="@caption"/>
            </xsl:attribute>
          </xsl:if>
        </input>
      </xsl:when>
       <xsl:otherwise>
        <a>
          <xsl:choose>
            <xsl:when test="@enable = 'false'">
              <xsl:attribute name="style">color:#CCCCCC;</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="@href != ''">
                <xsl:attribute name="href">
                  <xsl:call-template name="handleUrl">
                    <xsl:with-param name="url" select="@href" />
                    <xsl:with-param name="type" select="'bs'" />
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:if test="not(@target) or @target != '_blank'">
                  <xsl:attribute name="target">_self</xsl:attribute>
                </xsl:if>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of  select="@caption"/>
        </a>
      </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

<!-- grid template -->
<xsl:template match="grid">
  <!-- 暂时只支持mode="1"|"2"|"3",不知道客户端以后又搞什么新花样. -->
  <div id="clear">&#160;</div>
  <div align="center" >
    <xsl:variable name="mode" select="@mode" />
    <xsl:apply-templates select="item" mode="grid">
      <xsl:with-param name="gridMode" select="$mode" />
    </xsl:apply-templates>
  </div>
</xsl:template>

  <!--处理grid中的item-->
  <xsl:template match="item" mode="grid">
    <xsl:param name="gridMode" />
    <div class="gridDiv_{$gridMode}">
      <!--<xsl:attribute name="align">center</xsl:attribute>-->
      <a><!-- class="gridHref"-->
        <xsl:attribute name="target">
          <xsl:choose>
            <xsl:when test="@target = '_blank'">_blank</xsl:when>
            <xsl:otherwise>_self</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:if test="@href != ''">
          <xsl:attribute name="href">
          <xsl:call-template name="handleUrl">
            <xsl:with-param name="url" select="@href" />
            <xsl:with-param name="type" select="'bs'" />
          </xsl:call-template>
          <xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if>
        </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@icon and @icon != ''">
            <img src="{concat($wapAction,$getimg,@icon)}&amp;{$suffix}" class="gridImg_{$gridMode}" >
            </img>
          </xsl:when>
          <xsl:otherwise>
            <img src="{concat($wapAction,$getimg,'res:normal.png')}&amp;{$suffix}" class="gridImg_{$gridMode}" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$gridMode != '1'">
          <br/>
        </xsl:if>
        <xsl:value-of select="@caption"/>
      </a>
    </div>
  </xsl:template>

<!-- listbox template -->
<xsl:template match="listbox">
  <xsl:apply-templates select="new_listbox" />
</xsl:template>

  <xsl:template match="new_listbox">
    <br />
    <xsl:copy-of select="div/."/>
    <div id="clear">&#160;</div>
  </xsl:template>

<!-- table template -->
<xsl:template match="table">
</xsl:template>

<!-- combotree/tree template @by yesun
处理combotree和tree，在WAP2.0上统一转化为展开的树形结构
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
  <div class="tree">
    <xsl:value-of select="@caption"/>
    <xsl:apply-templates select="treeitem">
      <xsl:with-param name="name" select="concat('MSCTREE_',@name)"/>
      <xsl:with-param name="checkbox" select="@checkbox"/>
      <xsl:with-param name="level" select="'0'"/>
      <xsl:with-param name="leftspace" select="''"/>
    </xsl:apply-templates>
  </div>
</xsl:template>
  
<!--树节点模板-->
<xsl:template match="treeitem">
  <xsl:param name="name"/>
  <xsl:param name="checkbox"/>
  <xsl:param name="level"/>
  <xsl:param name="leftspace"/>
  
  <!--预留空格-->
  <xsl:value-of select="$leftspace"/>
  
  <!--系统图标-->
  <xsl:choose>
    <xsl:when test="@childurl">
      <a>
        <xsl:attribute name="href"><xsl:call-template name="handleUrl"><xsl:with-param name="url" select="@childurl" /><xsl:with-param name="type" select="'bs'" /></xsl:call-template>&amp;tree_nid=<xsl:value-of select="@nid"/></xsl:attribute>
      <img src="{concat($wapAction,$getimg,'res:tree-plus.gif')}&amp;{$suffix}" alt="+"/>
      </a>
    </xsl:when>
    <xsl:when test="treeitem">
      <img src="{concat($wapAction,$getimg,'res:tree-minus.gif')}&amp;{$suffix}" alt="-"/>
    </xsl:when>
    <xsl:when test="count(following-sibling::*) &gt; 0">
      <img src="{concat($wapAction,$getimg,'res:tree-middle-line.gif')}&amp;{$suffix}" alt=""/>
    </xsl:when>
    <xsl:otherwise>
      <img src="{concat($wapAction,$getimg,'res:tree-bottom-line.gif')}&amp;{$suffix}" alt=""/>
    </xsl:otherwise>
  </xsl:choose>
  
  <!--checkbox-->
  <xsl:choose>
    <xsl:when test="$checkbox = 'true'">
      <input type="checkbox" name="{$name}" value="{@nid}">
        <xsl:if test="@selected = 'true'">
          <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
      </input>
    </xsl:when>
    <xsl:otherwise>
      <input type="radio" name="{$name}" value="{@nid}">
        <xsl:if test="@selected = 'true'">
          <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
      </input>
    </xsl:otherwise>
  </xsl:choose>
  
  <!--icon图标-->
  <xsl:choose>
    <xsl:when test="@icon != ''">
      <img src="{concat($wapAction,$getimg,@icon)}&amp;{$suffix}" style="width:14px; height:14px;" alt=""></img>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@childurl">
          <img src="{concat($wapAction,$getimg,'res:tree-folder.gif')}&amp;{$suffix}" alt="+"/>
        </xsl:when>
        <xsl:when test="treeitem">
          <img src="{concat($wapAction,$getimg,'res:tree-folder-open.gif')}&amp;{$suffix}" alt="-"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="{concat($wapAction,$getimg,'res:tree-node.gif')}&amp;{$suffix}" alt=""/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

  <!--caption href-->
  <xsl:choose>
    <xsl:when test="@href != ''">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="handleUrl">
            <xsl:with-param name="url" select="@href" />
            <xsl:with-param name="type" select="'bs'" />
          </xsl:call-template>
          <xsl:if test="@target = '_blank'">&amp;target=_blank</xsl:if>
        </xsl:attribute>
        <xsl:value-of select="@caption"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@caption"/> 
    </xsl:otherwise>
  </xsl:choose>
  <br />
    <xsl:apply-templates select="treeitem">
      <xsl:with-param name="name" select="$name"/>
      <xsl:with-param name="checkbox" select="$checkbox"/>
      <xsl:with-param name="level" select="number($level + 1)"/>
      <xsl:with-param name="leftspace" select="concat('　',$leftspace)"/>
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
  <input type="text" name="{@name}" value="{@value}">
    <xsl:if test="@readonly = 'true'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test="@enable = 'false'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
  </input>
</xsl:template>

<!-- login template -->
<xsl:template match="login">
   <form id="frmLogin" method="POST" action="{$wapAction}">
    用户名：
    <input name="username" type="text" maxlength="50" tabindex="1">
	    <xsl:if test="/msc/@username != ''">
	    	<xsl:attribute name="value"><xsl:value-of select="/msc/@username" /></xsl:attribute>
	    </xsl:if>
    </input>
    <br/>
    密&#160;&#160;码：
    <input name="password" type="password" maxlength="20" tabindex="2">
	    <xsl:if test="/msc/@password">
	    	<xsl:attribute name="value"><xsl:value-of select="/msc/@password" /></xsl:attribute>
	    </xsl:if>
    </input>
    <br/>
    <xsl:choose>
    	<xsl:when test="/msc/@isLogin = 'true' and /msc/@userNeedRnd = 'true'">
    		<input type="hidden" name="userdefined_chkrnd" value="true"/>
    	</xsl:when>
    	
    	 <xsl:when test="/msc/@isLogin = 'true' and /msc/@needRnd = 'true' and not(/msc/@userNeedRnd)">
      验证码：<input name="rnd" type="text" maxlength="10" tabindex="3" class="w100"/><img src="../rnd.do?type=wap_rnd" alt="验证码"/><br/>
      <input type="hidden" name="chkrnd" value="true"/>
    </xsl:when>
    
    </xsl:choose>
   
    
    <input type="submit" value=" 登 录 " tabindex="3"></input>
    <!-- 固定参数，采用POST方式传递 -->
    <input name="_MSC_CMD_" type="hidden" value="USR"/>
    <input name="action" type="hidden" value="login"/>
    <input name="logintype" type="hidden" value="wap"/>
    <input name="mscver" type="hidden" value="450"/>
    <input name="phonemodel" type="hidden" value="wap"/>
    <input name="appid" type="hidden" value="{/msc/@appid}"/>
    <input name="appver" type="hidden" value="{/msc/@appver}"/>
    <input name="siid" type="hidden" value="{/msc/@siid}"/>
    <input name="ishide" type="hidden" value="1"/>
    <input name="customername" type="hidden" value="{/msc/@customername}"/>
    <input name="partnerid" type="hidden" value="{/msc/@partnerid}"/>
    <input name="partnername" type="hidden" value="{/msc/@partnername}"/>
    <input name="screensize" type="hidden" value="240*320"/>
  </form>
</xsl:template>

<!-- fileset template -->
  <xsl:template match="fileset">
    <br/>
    <xsl:if test="@enableadd = 'true' or not(@enableadd)">
      <div class="al wfull">
        <input type="file" value="上传" >
          <xsl:if test="@enable = 'false'">
            <xsl:attribute name="readonly">true</xsl:attribute>
          </xsl:if>
        </input>
      </div> 
    </xsl:if>
    <div class="fileset">      
    <xsl:apply-templates select="fileitem" mode="fileset"/>
    </div>
  </xsl:template>

  <!-- fileset:fileitem template -->
  <xsl:template match="fileitem" mode="fileset">
    <xsl:choose>
      <xsl:when test="@filetype = 'directory'"><img src="images/folder.png" alt="文件夹"/><a href="{$wapAction}?action=getXml&amp;serverurl={@href}&amp;{$suffix}"><xsl:if test="../@enable = 'false'"><xsl:attribute name="href"></xsl:attribute></xsl:if><xsl:value-of select="@caption"/></a>
      </xsl:when>
      <xsl:otherwise>
        <img alt="文件">
        <xsl:attribute name="src"><xsl:value-of select="concat($wapAction,$getimg)"/><xsl:choose>
          <xsl:when test="@filetype='zip' or @filetype='rar' or @filetype='jar' or @filetype='war' or contains(@caption,'.rar') or contains(@caption,'.zip')">res:rar.png</xsl:when>
          <xsl:when test="@filetype='xls' or @filetype='xlsx' or contains(@caption,'.xls')">res:xls.png</xsl:when>
          <xsl:when test="@filetype='txt' or @filetype='vcf' or @filetype='ini' or @filetype='csv' or @filetype='xml' or @filetype='log' or contains(@text,'.txt')">res:txt.png</xsl:when>
          <xsl:when test="@filetype='ppt' or @filetype='pptx' or @filetype='pps' or contains(@caption,'.ppt')">res:ppt.png</xsl:when>
          <xsl:when test="@filetype='jpg' or @filetype='jpeg'">res:jpg.png</xsl:when>
          <xsl:when test="@filetype='gif' or @filetype='bmp' or @filetype='tif' or @filetype='png'">res:pic.png</xsl:when>
          <xsl:when test="@filetype='pdf' or contains(@caption,'.pdf')">res:pdf.png</xsl:when>
          <xsl:when test="@filetype='doc' or @filetype='rtf' or @filetype='odt' or @filetype='docx' or contains(@caption,'.doc')">res:doc.png</xsl:when>
          <xsl:when test="@filetype='htm' or @filetype='shtml' or @filetype='html'">res:html.png</xsl:when>
          <xsl:otherwise>res:unknow.png</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        </img>
        <xsl:variable name="filename" select="@href"/>
        <xsl:choose>
          <xsl:when test="../@enable='false'">
            <xsl:value-of select="@caption"/>
          </xsl:when>
          <xsl:otherwise>
            <a href="">
              <xsl:attribute name="href">
                <xsl:call-template name="handleUrl">
                  <xsl:with-param name="url" select="@href" />
                  <xsl:with-param name="type" select="'file'" />
                </xsl:call-template>
              </xsl:attribute>
              <xsl:value-of select="@caption"/>
            </a>
          </xsl:otherwise>
        </xsl:choose><xsl:text>&#160;</xsl:text>
        <xsl:choose>
          <xsl:when test="../@enable='false'">下载</xsl:when>
          <xsl:otherwise>
            <a href="">
              <xsl:attribute name="href">
                <xsl:call-template name="handleUrl">
                  <xsl:with-param name="url" select="@href" />
                  <xsl:with-param name="type" select="'file'" />
                </xsl:call-template>&amp;do=download</xsl:attribute>下载</a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <br/>
  </xsl:template>

<!-- object template -->
<xsl:template match="object">
</xsl:template>

<!-- MSC标签结束-->
  
  
  <!--公用处理URL的模板-->
  <xsl:template name="handleUrl">
    <xsl:param name="url" />
    <xsl:param name="type" />
    <xsl:if test="$url != ''">
      <xsl:choose>
        <xsl:when test="starts-with($url,'http')">
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of select="concat($wapAction,$bstransfer,$url,'&amp;',$suffix)"/>&amp;_MSC_CMD_=QRY</xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$viewimageremote,$url,'&amp;',$suffix)"/>&amp;_MSC_CMD_=QRY</xsl:when>
            <xsl:when test="$type = 'file'"><xsl:value-of select="concat($wapAction,$viewfileremote,$url,'&amp;',$suffix)"/>&amp;_MSC_CMD_=QRY</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($url,'?action=') or starts-with($url,$bstransfer) or starts-with($url,$viewfileremote) or starts-with($url,$viewimageremote) or starts-with($url,$localurl)"><xsl:value-of select="$wapAction"/><xsl:value-of select="concat($url,'&amp;',$suffix)"/>&amp;_MSC_CMD_=QRY</xsl:when>
        <xsl:when test="starts-with($url,'m.do')"><xsl:value-of select="concat($url,'&amp;',$suffix)"/></xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$type = 'bs'"><xsl:value-of  select="concat($wapAction,$getxml,$url,'&amp;',$suffix)"/></xsl:when>
            <xsl:when test="$type = 'image'"><xsl:value-of select="concat($wapAction,$getimg,$url,'&amp;',$suffix)"/></xsl:when>
            <xsl:when test="$type = 'file'"><xsl:value-of  select="$wapAction"/>?action=getfile@wap&amp;filename=<xsl:value-of select="concat($appfolder,$url,'&amp;',$suffix)"/></xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
