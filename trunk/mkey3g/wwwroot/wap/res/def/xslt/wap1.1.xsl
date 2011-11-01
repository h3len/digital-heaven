<?xml version="1.0"?>
<!DOCTYPE html
[
  <!ENTITY nbsp "&#160;">
]
>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!-- 
* 全面解析MSC 2 WAP（WML)
* 日期：2007-1-6
* by yesun
 -->
<!--载入服务器配置xml  以前的老方法，基本可以废除，才用新方法，通过msc传递appfolder-->
<!--根据服务器配置载入全局xml，各个app对应不同的global.xml-->
<xsl:variable name="objXmlGlobal" select="document(concat('../',/msc/@appfolder,'/global.xml'))"/>

<xsl:template match="/msc">
<wml>
<head>
<meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
<meta http-equiv="Cache-Control" content="must-revalidate" forua="true"/>
<meta http-equiv="Cache-Control" content="no-cache" forua="true"/>
   
</head>
<card id="wml" title="{@title}">
<!--MAS2.0
  <xsl:if test="contains(//body/a[1]/@href ,'%7C%7C')">
    
    <xsl:variable name="time" select="number(substring-before(//body/a[1]/@href,'%7C%7C'))"></xsl:variable>
    <xsl:if test="$time &gt; 0">
      <xsl:variable name="url_" select="substring-after(//body/a[1]/@href,'%7C%7C')"></xsl:variable>
      <xsl:if test="$url_ != ''">
        <onevent type="ontimer">
          <go href="default.do?action=getXml&amp;serverurl={$url_}"></go>
        </onevent>
        <timer value="{$time}0"/>
      </xsl:if>
    </xsl:if>
  </xsl:if>
-->
<p>
<xsl:if test="@type = 'grid'">
<xsl:attribute name="align">left</xsl:attribute>
</xsl:if>
<!-- 内容开始 -->
<xsl:choose>
<xsl:when test="@type = 'mailcontent'">
<!-- Mail Heaer -->
<table align="center" title="邮件内容" columns="2">
<tr><td>From</td><td><xsl:value-of select="mail/@from"/></td></tr>
<tr><td>To</td><td><xsl:value-of select="mail/@to"/></td></tr>
<xsl:if test="mail/@cc!=''">
<tr><td>Cc</td><td><xsl:value-of select="mail/@cc"/></td></tr>
</xsl:if>
<xsl:if test="mail/@bcc!=''">
<tr><td>Bcc</td><td><xsl:value-of select="mail/@bcc"/></td></tr>
</xsl:if>
</table>
<br/>
<strong>主题：<xsl:value-of select="mail/@subject"/></strong><br/>
优先级：<xsl:choose>
<xsl:when test="mail/@piority = '1'">最高</xsl:when>
<xsl:when test="mail/@piority = '3'">普通</xsl:when>
<xsl:when test="mail/@piority = '5'">最低</xsl:when>
</xsl:choose>
<br/>
<!-- 内容开始 -->
<xsl:apply-templates />
<!-- 内容结束 -->
<!-- Mail Footer -->
<br/>

<xsl:if test="@enablesend = 'true'">
<a href="default.do?action=LoadCreateMail&amp;id={mail/@mailid}&amp;from=tempbox">发送邮件</a><br/>
</xsl:if>

<xsl:if test="@enablereply = 'true'">
<a href="default.do?action=LoadMailReply&amp;all=false&amp;id={mail/@mailid}">回复</a><br/>
<a href="default.do?action=LoadMailReply&amp;all=true&amp;id={mail/@mailid}">回复所有</a><br/>
<a href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=markunread@mail&amp;id={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">标记未读</a><br/>
</xsl:if>
<a href="default.do?action=LoadMailForward&amp;id={mail/@mailid}">转发</a><br/>
<!--
<xsl:if test="mail/@mailbox != '草稿箱'">
<a href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=movetotempbox@mail&amp;id={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">存入草稿箱</a><br/>
</xsl:if>
-->
<a href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=delmail@mail&amp;delid={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">删除邮件</a><br/>
<a href="default.do?action=getXml&amp;serverurl=wap/xml/createmail.xml">写邮件</a><br/>
</xsl:when>
<xsl:when test="@type = 'getmailsetting'">
邮箱地址<input type="text" name="email" value="{@email}"/><br/>
帐号<input type="text" name="username" value="{@username}"/><br/>
密码<input type="password" name="password" value="{@password}"/><br/>
POP3服务器<input type="text" name="pop3server" value="{@pop3server}"/><br/>
POP3端口<input type="text" name="pop3port" value="{@pop3port}"/><br/>
SMTP服务器<input type="text" name="smtpserver" value="{@smtpserver}"/><br/>
SMTP端口<input type="text" name="smtpport" value="{@smtpport}"/><br/>
<anchor>保存设置
<go method="post" href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=setmailsetting@mail&amp;urlreferer=default.do?action=getXml%26serverurl=home.xml">
<postfield name="email" value="$email"></postfield>
<postfield name="username" value="$username"></postfield>
<postfield name="password" value="$password"></postfield>
<postfield name="emailstyle" value="$emailstyle"></postfield>
<postfield name="pop3server" value="$pop3server"></postfield>
<postfield name="pop3port" value="$pop3port"></postfield>
<postfield name="smtpserver" value="$smtpserver"></postfield>
<postfield name="smtpport" value="$smtpport"></postfield>
</go>
</anchor>
<br/>

<xsl:apply-templates />
</xsl:when>

<xsl:when test="@type = 'imageview'">
<!-- 内容开始 -->
跳转：
<select>
<xsl:for-each select="body/img">
<xsl:attribute name="value"><xsl:value-of select="/msc/@selected"/></xsl:attribute>
<option value="{position()}" onpick="default.do?action=ImageView&amp;serverurl={position()}">
第<xsl:value-of select="position()"/>张
</option>
</xsl:for-each>
</select>
<br/>
<xsl:apply-templates select="body/img[@selected='selected']" />
<!-- by yesun 增加放大倍数 -->
<br/>
尺寸：<a href="default.do?action=RequestFile&amp;serverurl={body/img[@selected='selected']/@src}__a__dh_scale=1">1倍</a>
<xsl:text>&#160;</xsl:text>
<a href="default.do?action=RequestFile&amp;serverurl={body/img[@selected='selected']/@src}__a__dh_scale=2">2倍</a>
<xsl:text>&#160;</xsl:text>
<a href="default.do?action=RequestFile&amp;serverurl={body/img[@selected='selected']/@src}__a__dh_scale=3">3倍</a>
<!-- 内容结束 -->
</xsl:when>

<xsl:otherwise>
<!-- 内容开始 -->
<xsl:apply-templates />
<!-- 内容结束 -->
</xsl:otherwise>
</xsl:choose>


<!-- 分页 -->
<xsl:if test="@maxpage &gt; 1 and @pageid &gt; 0">
<xsl:call-template name="MutiPageNavigation" />
<br/>
</xsl:if>
<xsl:if test="@statusbar_caption!=''">
<br/>
<xsl:value-of select="@statusbar_caption" />
<br/>
</xsl:if>

<!-- 内容结束 -->
<xsl:if test="@isneedback = 'true'">
<br/>
<do type="prev" label="后退一步">
<prev/>
</do>
<br/>
<a href="default.do?action=getXml&amp;serverurl={$objXmlGlobal/msc/home/@href}&amp;target=_blank">返回首页</a>
<br/>
<a href="default.do?appid={substring-after(/msc/@appfolder,'/')}">重新登录</a>
<br/>
<a href="default.do?appid=all">应用列表</a>
</xsl:if>
<!-- 
<a href="setup.wml">客户端下载</a>
<br/>
<a href="default.do?wap=2.0">xhtml版本</a> -->
</p>
</card>
</wml>
</xsl:template>

<!-- 模板开始 -->


<!-- MSC专有标签开始 -->
<xsl:template match="object">
<xsl:choose>
<xsl:when test="@type = 'login'">
<!-- object for login -->
<xsl:apply-templates select="../object" mode="login"/>
</xsl:when>
<xsl:when test="@type = 'toolbar'">
<!-- object for login -->
<xsl:apply-templates select="../object" mode="toolbar"/>
<br/>
</xsl:when>
<xsl:when test="@type = 'multiselect'">
<!-- object for multiselect -->
	<xsl:choose>
	<xsl:when test="@style='formtree'">
	<!-- 多级联动 -->
	<xsl:apply-templates select="." mode="multiselect-tree"/>
	</xsl:when>
	<xsl:when test="@style='multicombox'">
	<!-- 多级联动 -->
	<xsl:apply-templates select="." mode="multiselect-multicombox"/>
	</xsl:when>
	<xsl:otherwise>
	<!-- 默认为树状 -->
	<xsl:apply-templates select="." mode="multiselect-tree"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:when>
<xsl:when test="@type = 'navigation'">
<xsl:apply-templates select="child::*" />
<br/>
</xsl:when>
<xsl:when test="@type = 'date'">
<xsl:apply-templates select="." mode="date"/>
</xsl:when>
<xsl:when test="@type = 'time'">
<xsl:apply-templates select="." mode="time"/>
</xsl:when>
<xsl:when test="@type = 'date_time'">
<xsl:apply-templates select="." mode="date_time"/>
</xsl:when>
<xsl:otherwise>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- date object -->
<xsl:template match="object" mode="date">
<xsl:value-of select="@caption"/>
<select name="MSCDATE_{@name}_Year">
<xsl:attribute name="value"><xsl:value-of select="substring-before(@value,'-')"/></xsl:attribute>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="2006" /><xsl:with-param name="end" select="2011" /><xsl:with-param name="value" select="substring-before(@value,'-')" /></xsl:call-template></select>年
<select name="MSCDATE_{@name}_Month">
<xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,'-'),'-')"/></xsl:attribute>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="12" /><xsl:with-param name="value" select="substring-before(substring-after(@value,'-'),'-')" /></xsl:call-template></select>月
<select name="MSCDATE_{@name}_Day">
<xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(@value,'-'),'-')"/></xsl:attribute>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="31" /><xsl:with-param name="value" select="substring-after(substring-after(@value,'-'),'-')" /></xsl:call-template></select>日
</xsl:template>

<!-- date object -->
<xsl:template match="object" mode="time">
<xsl:value-of select="@caption"/>
<xsl:if test="not(@format) or contains(@format, 'hh')">
<select name="MSCTIME_{@name}_Hour"><xsl:attribute name="value"><xsl:value-of select="substring-before(@value,':')"/></xsl:attribute>
  <xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="23" /><xsl:with-param name="value" select="substring-before(@value,':')" /></xsl:call-template></select>时
</xsl:if>
<xsl:if test="not(@format) or contains(@format, 'mm')">
<select name="MSCTIME_{@name}_Minute"><xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,':'),':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="59" /><xsl:with-param name="value" select="substring-before(substring-after(@value,':'),':')" /></xsl:call-template></select>分
</xsl:if>
<xsl:if test="not(@format) or contains(@format, 'ss')">
<select name="MSCTIME_{@name}_Second"><xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(@value,':'),':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="59" /><xsl:with-param name="value" select="substring-after(substring-after(@value,':'),':')" /></xsl:call-template></select>秒
</xsl:if>
</xsl:template>

<!-- date_time object -->
<xsl:template match="object" mode="date_time">
<xsl:value-of select="@caption"/>
<select name="MSCDATETIME_{@name}_Year"><xsl:attribute name="value"><xsl:value-of select="substring-before(@value,'-')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="2006" /><xsl:with-param name="end" select="2011" /><xsl:with-param name="value" select="substring-before(@value,'-')" /></xsl:call-template></select>年
<select name="MSCDATETIME_{@name}_Month"><xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,'-'),'-')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="12" /><xsl:with-param name="value" select="substring-before(substring-after(@value,'-'),'-')" /></xsl:call-template></select>月
<select name="MSCDATETIME_{@name}_Day"><xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(substring-before(@value,' '),'-'),'-')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="31" /><xsl:with-param name="value" select="substring-after(substring-after(@value,'-'),'-')" /></xsl:call-template></select>日
<select name="MSCDATETIME_{@name}_Hour"><xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,' '),':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="23" /><xsl:with-param name="value" select="substring-before(@value,':')" /></xsl:call-template></select>时
<select name="MSCDATETIME_{@name}_Minute"><xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,':'),':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="59" /><xsl:with-param name="value" select="substring-before(substring-after(@value,':'),':')" /></xsl:call-template></select>分
<select name="MSCDATETIME_{@name}_Second"><xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(@value,':'),':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="59" /><xsl:with-param name="value" select="substring-after(substring-after(@value,':'),':')" /></xsl:call-template></select>秒
</xsl:template>


<!-- DropDownList object -->
<xsl:template name="DropDownList">
<!-- 参数：起始数字，结束数字，默认值 -->
<xsl:param name="start"></xsl:param>
<xsl:param name="end"></xsl:param>
<xsl:param name="value"></xsl:param>
<xsl:if test="$start &lt; $end or $start = $end">
<option value="{$start}">
<xsl:value-of select="$start"/>
</option>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="$start + 1" /><xsl:with-param name="end" select="$end" /><xsl:with-param name="value" select="$value" /></xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template match="ul">
<xsl:apply-templates select="li" />
</xsl:template>

<xsl:template match="li">
<xsl:apply-templates /><br/>
</xsl:template>

<!-- toolbar object -->
<xsl:template match="object" mode="toolbar">
<xsl:for-each select="input">
<!-- 通过position来定位没有子的input -->
<xsl:param name="currentPosition"><xsl:value-of select="position()" /></xsl:param>
<xsl:choose>
<xsl:when test="count(child::input) &gt; 0">
	<xsl:apply-templates select="input"/>
</xsl:when>
<xsl:when test="count(child::input) = 0">
	<xsl:apply-templates select="../input[position()=$currentPosition]"/>
</xsl:when>
</xsl:choose>
</xsl:for-each>
</xsl:template>

<!-- login object -->
<xsl:template match="object" mode="login">
用户名：<input name="username" type="text" tabindex="1" /><br/>
密&nbsp;&nbsp;码：<input name="password" type="password" tabindex="2"/><br/>
验证码：<input name="rnd" type="text" tabindex="3"/><br/><img src="../rnd.do?type=wap_rnd" alt="验证码"/><br/>

<!-- 根据Global.xml来判断是否需要加密传输
<xsl:if test="$objXmlGlobal/msc/secure/@value !=''">
<input type="checkbox" name="chkSecureType" id="chkSecureType">
<xsl:attribute name="value">
<xsl:value-of select="$objXmlGlobal/msc/secure/@value"/></xsl:attribute>
<xsl:if test="$objXmlGlobal/msc/secure/@readonly = 'true'">
<xsl:attribute name="readonly">readonly</xsl:attribute>
</xsl:if>
</input>
<label for="chkSecureType">加密传输</label><br/>
</xsl:if>
 -->
<anchor>登录
<go method="post" href="default.do">
<postfield name="username" value="$username"></postfield>
<postfield name="password" value="$password"></postfield>
<postfield name="rnd" value="$rnd"></postfield>
<!-- 如果有隐藏的input，需要这里增加postfield -->
<xsl:for-each select="//input[@type='hidden']">
<postfield name="{@name}" value="{@value}"></postfield>
</xsl:for-each>

<!-- 固定参数，需要post给服务器 -->
<postfield name="logintype" value="wap"></postfield>
<postfield name="action" value="login"></postfield>
<postfield name="mscver" value="450"></postfield>
<postfield name="phonemodel" value="{/msc/@UA}"></postfield>
<postfield name="appid" value="{$objXmlGlobal/msc/@appid}"></postfield>
<postfield name="appver" value="{$objXmlGlobal/msc/@appver}"></postfield>
<postfield name="siid" value="{$objXmlGlobal/msc/@siid}"></postfield>
<postfield name="ishide" value="1"></postfield>

</go>
</anchor>
<br/>
</xsl:template>



<!--mutiselect object for tree : 无级下拉列表树 -->
<xsl:template match="object" mode="multiselect-tree">
<xsl:value-of select="@caption" />
<xsl:if test="@checkbox = 'true'">
<br/>
</xsl:if>
<select name="{@name}">
<xsl:if test="@value != ''">
<xsl:attribute name="value"><xsl:value-of select="@value"></xsl:value-of></xsl:attribute>
</xsl:if>
<xsl:if test="@checkbox = 'true'">
<xsl:attribute name="multiple">true</xsl:attribute>
</xsl:if>
<option value="">请选择</option>
<xsl:apply-templates select="item" mode="multiselect-tree"><xsl:with-param name="leftspace">┣</xsl:with-param></xsl:apply-templates>
</select>
</xsl:template>

<!-- 解析multiselect标签 ，树形菜单 -->
<xsl:template match="item" mode="multiselect-tree">
<!-- 接受传入的参数 -->
<xsl:param name="leftspace"></xsl:param>
<option value="{@value}">
<xsl:if test="@href != ''">
<xsl:attribute name="onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:if>

<xsl:if test="@childurl != ''">
<xsl:attribute name="onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@childurl"/>&amp;parentname=<xsl:value-of select="ancestor::object/@name"/>&amp;value=<xsl:value-of select="@value"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:if>

<xsl:value-of select="$leftspace"></xsl:value-of><xsl:value-of select="@caption"></xsl:value-of>
</option>
<!-- 如果有子，则需要递归 -->
<xsl:apply-templates select="item" mode="multiselect-tree">
<xsl:with-param name="leftspace">&nbsp;&nbsp;<xsl:value-of select="$leftspace"/></xsl:with-param>
</xsl:apply-templates>
</xsl:template>




<!--mutiselect object for multicombox -->
<xsl:template match="object" mode="multiselect-multicombox">

<xsl:param name="objectname"><xsl:value-of select="@name" /></xsl:param>

<xsl:value-of select="@caption" />
<select name="{@name}">
<xsl:apply-templates select="item/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">caption</xsl:with-param>
<!-- 参数：object的名字 -->
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</select>

<!-- 如果该分类包含子分类，就去取子分类,caption1,caption2,caption3...,难点：xpath为动态的？！-->
<xsl:for-each select="@*[substring(name(),1,7) = 'caption' and name() !='caption']">
<!-- 读取caption的属性 -->	
<xsl:choose>
<xsl:when test="item/item[@selected='selected' or @selected='true']/item[@caption!='']">
<xsl:value-of select="." />
<select>
<xsl:attribute name="name"><xsl:value-of select="$objectname" />_<xsl:value-of select="name()" /></xsl:attribute>
  <!--设置默认值-->
		<xsl:choose>
		<xsl:when test="position() = 1">
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      <xsl:apply-templates select="item/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 2">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 3">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 4">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 5">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		</xsl:choose>
</select>


</xsl:when>
<xsl:otherwise>
<xsl:value-of select="."></xsl:value-of>
<select name="{$objectname}_{name()}">
<xsl:choose>
<xsl:when test="position() = 1">
  <!--设置默认值-->
  <xsl:attribute name="value"></xsl:attribute>
  <xsl:apply-templates select="item/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 2">
  <xsl:apply-templates select="item/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 3">
  <xsl:apply-templates select="item/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 4">
  <xsl:apply-templates select="item/item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 5">
  <xsl:apply-templates select="item/item[1]/item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  </xsl:choose>
</select>
</xsl:otherwise>
</xsl:choose>

</xsl:for-each>
</xsl:template>
<xsl:template match="object" mode="multiselect-multicombox">
<xsl:param name="objectname"><xsl:value-of select="@name" /></xsl:param>
<xsl:value-of select="@caption" />
<select name="{@name}">
  <xsl:choose>
    <xsl:when test="not(item/item[@selected='selected' or @selected='true']/@value) or item/item[@selected='selected' or @selected='true']/@value = ''">
      <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="value"><xsl:value-of select="item/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
  
  
<xsl:apply-templates select="item/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">caption</xsl:with-param>
<!-- 参数：object的名字 -->
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</select>

<!-- 如果该分类包含子分类，就去取子分类,caption1,caption2,caption3...,难点：xpath为动态的？！-->
<xsl:for-each select="@*[substring(name(),1,7) = 'caption' and name() !='caption']">
<!-- 读取caption的属性 -->	
<xsl:choose>
<xsl:when test="../item/item[@selected='selected' or @selected='true']/item">
<xsl:value-of select="." />
<select>
<xsl:attribute name="name"><xsl:value-of select="$objectname" />_<xsl:value-of select="name()" /></xsl:attribute>
  <!--设置默认值-->
		<xsl:choose>
		<xsl:when test="position() = 1">
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      <xsl:apply-templates select="../item/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 2">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="../item/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 3">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 4">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 5">
      
      <!--设置默认值-->
        <xsl:choose>
          <xsl:when test="not(../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value) or ../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value = ''">
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		</xsl:choose>
</select>


</xsl:when>
<xsl:otherwise>
<xsl:value-of select="."></xsl:value-of>
<select name="{$objectname}_{name()}">
<xsl:choose>
<xsl:when test="position() = 1">
  <!--设置默认值-->
  <xsl:choose>
    <xsl:when test="not(../item/item[1]/item[@selected='selected' or @selected='true']/@value) or ../item/item[1]/item[@selected='selected' or @selected='true']/@value = ''">
      <xsl:attribute name="value"><xsl:value-of select="../item/item[1]/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="value"><xsl:value-of select="../item/item[1]/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates select="../item/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 2">
   <xsl:choose>
    <xsl:when test="not(../item/item[1]/item[@selected='selected' or @selected='true']/@value) or ../item/item[1]/item[@selected='selected' or @selected='true']/@value = ''">
      <xsl:attribute name="value"><xsl:value-of select="../item/item[1]/item[@selected='selected' or @selected='true']/@caption"/></xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="value"><xsl:value-of select="../item/item[1]/item[@selected='selected' or @selected='true']/@value"/></xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
    
  <xsl:apply-templates select="../item/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 3">
  <xsl:apply-templates select="../item/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 4">
  <xsl:apply-templates select="../item/item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="position() = 5">
  <xsl:apply-templates select="../item/item[1]/item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
  <!-- 参数：caption级别 -->
  <xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
  </xsl:apply-templates>
  </xsl:when>
  </xsl:choose>
</select>
</xsl:otherwise>
</xsl:choose>

</xsl:for-each>
</xsl:template>


<!-- 解析multiselect标签 ，多级联动下拉 -->
<xsl:template match="item" mode="multiselect-multicombox">
<!-- 传入参数 -->
<xsl:param name="objectname"></xsl:param>
<xsl:param name="captiontype"></xsl:param>

<option value="{@value}">
<xsl:choose>
<xsl:when test="@href != ''">
<xsl:attribute name="onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:when>
<xsl:when test="@childurl!=''">
<!--
<xsl:attribute name="onclick">location.href='default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/>'</xsl:attribute>
-->
<xsl:attribute name="onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="@childurl"/></xsl:attribute>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="item[1]/@caption!=''"><xsl:attribute name="onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/></xsl:attribute></xsl:when>
	<xsl:otherwise><xsl:attribute name="onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/></xsl:attribute></xsl:otherwise>
	</xsl:choose>	
</xsl:otherwise>
</xsl:choose>
  <xsl:if test="not(@value) or @value=''">
    <xsl:attribute name="value"><xsl:value-of select="@caption"/></xsl:attribute>
  </xsl:if>
<xsl:value-of select="@caption"></xsl:value-of>
</option>
</xsl:template>



<!--mutiselect object for formtree : 平普展开的一棵树-->
<xsl:template match="object" mode="multiselect-formtree">
<xsl:param name="objectname"><xsl:value-of select="@name" /></xsl:param>
<xsl:value-of select="@caption" />
<br/>
<xsl:apply-templates select="item" mode="multiselect-formtree">
<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
  <xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
<xsl:with-param name="leftspace">┣</xsl:with-param>
</xsl:apply-templates>
<br/>
</xsl:template>

<!-- 解析multiselect标签 ，树形菜单 -->
<xsl:template match="item" mode="multiselect-formtree">
<!-- 传入参数 -->
<xsl:param name="objectname"></xsl:param>
<xsl:param name="captiontype"></xsl:param>

<!-- 接受传入的参数 -->
<xsl:param name="leftspace"></xsl:param>
<xsl:value-of select="$leftspace"></xsl:value-of>
<xsl:choose>
<xsl:when test="@href != ''">
<a href="default.do?action=getXml&amp;serverurl={@href}"><xsl:value-of select="@caption" /></a>
</xsl:when>
<!-- by yesun 支持childurl -->
<xsl:when test="@childurl != ''">
<a href="default.do?action=getXml&amp;objectname={$objectname}&amp;captiontype={$captiontype}&amp;ismultiselect=true&amp;serverurl={@childurl}"><xsl:value-of select="@caption" /></a>
</xsl:when>
<xsl:otherwise><xsl:value-of select="@caption" /></xsl:otherwise>
</xsl:choose>

<br/>
<!-- 如果有子，则需要递归 -->
<xsl:apply-templates select="item" mode="multiselect-formtree">
<xsl:with-param name="leftspace">　<xsl:value-of select="$leftspace"/></xsl:with-param>
</xsl:apply-templates>
</xsl:template>

  
  <!-- group for grid -->
<xsl:template match="group">
<big>
<xsl:value-of select="@caption"></xsl:value-of>
</big>
<br/>
<xsl:apply-templates select="item" mode="group"/>
<br/>
</xsl:template>

<!-- group item for grid -->
<xsl:template match="item" mode="group">

<xsl:if test="@caption != '提醒方式'">
<a>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>

</xsl:attribute>
  <xsl:choose>
    <xsl:when test="@icon!=''">
      <xsl:choose>
        <xsl:when test="starts-with(@icon, 'classpath')">
          <img alt="{@caption}" src="images/{substring-after(@icon,':')}"/>
          <br/>
        </xsl:when>
        <xsl:otherwise>
          <img src="{/msc/@appfolder}/{@icon}" alt="{@caption}"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <img alt="" src="images/normal.png"/>
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

<!-- list item -  -->
<xsl:template match="item">
<xsl:if test="not(@icon)">
<img src="images/arr.gif"/>&#160;
</xsl:if>
<a>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="not(@href) or @href=''"></xsl:when>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:if test="@icon!=''">
<xsl:choose>
<xsl:when test="starts-with(@icon, 'classpath')">
<img alt="" src="images/{substring-after(@icon,':')}"/>
</xsl:when>
<xsl:otherwise><img src="{/msc/@appfolder}/{@icon}" alt=""/></xsl:otherwise>
</xsl:choose>
</xsl:if>
<xsl:value-of select="@caption"></xsl:value-of>
</a>
<xsl:if test="substring-before(@href,':')='tel'">
（<a href="wtai://wp/mc;17951{substring-after(@href,':')}">IP拨叫</a>）
</xsl:if>
<br/>
<xsl:if test="@sndcaption">
&#160;&#160;
<small>
<a>
  <xsl:attribute name="href">
    <xsl:choose>
    <xsl:when test="not(@href) or @href=''"></xsl:when>
    <xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
    <xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
    <xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
    <xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:value-of select="@sndcaption"></xsl:value-of></a></small>
<br/>
</xsl:if>
</xsl:template>


<!-- msg -->
<xsl:template match="msg">
<xsl:value-of select="."/>
<br/>
</xsl:template>


<!-- MSC专有标签结束 -->

<!-- 普通标签开始 -->

<!--font标签 -->
<xsl:template match="font">
<xsl:choose>
<xsl:when test="@bold='true'">
<strong>
<xsl:value-of select="."></xsl:value-of>
</strong>
</xsl:when>
<xsl:when test="@size='large'">
<big>
<xsl:value-of select="."></xsl:value-of>
</big>
</xsl:when>
<xsl:when test="@size='normal'">
<xsl:value-of select="."></xsl:value-of>
</xsl:when>
<xsl:when test="@size='small'">
<small>
<xsl:value-of select="."></xsl:value-of>
</small>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="."></xsl:value-of>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="strong">
<strong>
<xsl:value-of select="."></xsl:value-of>
</strong>
</xsl:template>

<!--title标签 -->
<xsl:template match="title">
<strong><xsl:value-of select="."></xsl:value-of></strong>
<br/>
</xsl:template>

<!--A标签 -->
<xsl:template match="a">
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="substring-before(@href,':')='mailto'">default.do?action=LoadCreateMail&amp;serverurl=<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:apply-templates />
</xsl:element>
<xsl:if test="substring-before(@href,':')='tel'">
（<a href="wtai://wp/mc;17951{substring-after(@href,':')}">IP拨叫</a>）
</xsl:if>
</xsl:template>

<!--p标签 -->
<xsl:template match="p">
<xsl:apply-templates />
</xsl:template>

<!-- Span -->
<xsl:template match="span">
<xsl:apply-templates />	
</xsl:template>

<!--br标签 -->
<xsl:template match="br">
<br/>
</xsl:template>

<!--可扩展增加需要解析的标签 -->
<!-- 解析img标签 , 入口 -->
<xsl:template match="img">
<xsl:choose>
<xsl:when test="string-length(@href)>0">
<a>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:apply-templates select="." mode="bll" />
</a>
</xsl:when>
<xsl:otherwise>
    <xsl:apply-templates select="." mode="bll" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- 解析img标签， 真正解析img-->
<xsl:template match="img" mode="bll">
<img src="default.do?action=ImageView&amp;serverurl={@src}" alt="{/msc/@title}" />
<!--  
<xsl:attribute name="src">
 />

根据MSC关于src的定义，无法使用xslt来实现，只有通过程序实现

<xsl:choose>
<xsl:when test="starts-with(@src,'default.do') or starts-with(@src,'http')"><xsl:value-of select="@src" /></xsl:when>
<xsl:otherwise>default.do?action=ImageView&amp;serverurl=<xsl:value-of select="@src" /></xsl:otherwise>
</xsl:choose> 
 -->
<!-- 
<xsl:choose>
<xsl:when test="contains(@src,'http://')">
<xsl:value-of select="@src" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/msc/@appfolder" />/<xsl:value-of select="@src" />
</xsl:otherwise>
</xsl:choose>

</xsl:attribute>
<xsl:attribute name="alt"><xsl:value-of select="" /></xsl:attribute>
</img> -->
</xsl:template>

<!-- 解析select标签  -->
<xsl:template match="select">
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
<xsl:if test="@checked != ''">
<xsl:attribute name="selected"><xsl:value-of select="@true"></xsl:value-of></xsl:attribute>
</xsl:if>
<xsl:if test="@selected != ''">
<xsl:attribute name="selected"><xsl:value-of select="@true"></xsl:value-of></xsl:attribute>
</xsl:if>

<xsl:if test="@href != ''">
<!---->
<xsl:attribute name="onclick">location.href='default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/>'</xsl:attribute>

<xsl:attribute name="onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:if>
<xsl:choose>
<xsl:when test="text() != ''">
<xsl:value-of select="."></xsl:value-of>
</xsl:when>
<xsl:otherwise><xsl:value-of select="@value"></xsl:value-of></xsl:otherwise>
</xsl:choose>

</option>
</xsl:for-each>
</select>
</xsl:template>

<!--解析hr标签 -->
<xsl:template match="hr">
<br/>
---------------------
<br/>
</xsl:template>

<!--解析input标签 -->
<xsl:template match="input">
<xsl:choose>
<xsl:when test="@type = 'text' or @type = 'file' or @type = 'password' or @type = 'PASSWORD'">
<xsl:value-of select="@caption"></xsl:value-of>
<input type="{@type}" name="{@name}" value="{@value}">
<xsl:if test="@checked = 'true' or @selected='true' or @selected='selected'">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
</input>
</xsl:when>

<xsl:when test="@type = 'textarea'">
<xsl:value-of select="@caption"></xsl:value-of>
<br/>
<input name="{@name}"><xsl:attribute name="value"><xsl:value-of select="."></xsl:value-of></xsl:attribute></input>
</xsl:when>

<!--<xsl:when test="@type = 'radio'">
<input type="{@type}" name="{@name}" value="{@value}">
<xsl:if test="@checked = 'true' or @selected='true' or @selected='selected'">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
</input>
<xsl:value-of select="@caption"></xsl:value-of>
</xsl:when>-->
<!--<xsl:when test="@type = 'checkbox'">
<input type="{@type}" name="{@name}">
<xsl:if test="@checked = 'true' or @selected='true' or @selected='selected'">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
<xsl:choose>
<xsl:when test="@value != ''">
<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="value">1</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
</input>
<xsl:value-of select="@caption"></xsl:value-of>
</xsl:when>-->
<xsl:when test="@type = 'button'">
<a>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="starts-with(/msc/@href,'default.do')"><xsl:value-of select="@href" />&amp;<xsl:value-of select="@name" />=<xsl:value-of select="@value" /></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href" />&amp;<xsl:value-of select="@name" />=<xsl:value-of select="@value" /></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:value-of select="@caption"></xsl:value-of></a>
</xsl:when>
<xsl:when test="@type = 'button' or @type ='reset'">
<input type="{@type}" name="{@name}" value="{@caption}"/>
</xsl:when>
<xsl:when test="@type ='submit'">
<!-- 提交 -->
<anchor><xsl:value-of select="@caption"></xsl:value-of>
<go method="post">
<xsl:if test="/msc/@enableReferer = 'true'">
<xsl:attribute name="sendreferer">true</xsl:attribute>
</xsl:if>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="starts-with(/msc/@action,'default.do')"><xsl:value-of select="/msc/@action" />&amp;<xsl:value-of select="@name" />=<xsl:value-of select="@value" /></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="/msc/@action" />&amp;<xsl:value-of select="@name" />=<xsl:value-of select="@value" /></xsl:otherwise>
</xsl:choose>
</xsl:attribute>

<!-- 需要这里增加postfield -->
<!-- all Hidden input -->
<xsl:for-each select="//input[@type='hidden']">
<xsl:if test="@name != ''">
<postfield name="{@name}" value="{@value}" />
</xsl:if>
</xsl:for-each>
<!-- all input -->
<xsl:for-each select="//input">
<xsl:if test="@name != ''">
<postfield name="{@name}" value="${@name}" />
</xsl:if>
</xsl:for-each>
<!-- all select -->
<xsl:for-each select="//select">
<xsl:if test="@name != ''">
<postfield name="{@name}" value="${@name}" />
</xsl:if>
</xsl:for-each>

<!-- all textarea -->
<xsl:for-each select="//textarea">
<xsl:if test="@name != ''">
<postfield name="{@name}" value="${@name}" />
</xsl:if>
</xsl:for-each>

<!-- all object -->
<xsl:for-each select="//object">
<xsl:if test="@name != ''">
	<xsl:choose>
	<xsl:when test="@type='date'">
	<postfield name="MSCDATE_{@name}_Year" value="$MSCDATE_{@name}_Year" />
	<postfield name="MSCDATE_{@name}_Month" value="$MSCDATE_{@name}_Month" />
	<postfield name="MSCDATE_{@name}_Day" value="$MSCDATE_{@name}_Day" />
	</xsl:when>
	<xsl:when test="@type='time'">
	<xsl:if test="not(@format) or contains(@format, 'hh')">
	<postfield name="MSCTIME_{@name}_Hour" value="$MSCTIME_{@name}_Hour" />
	</xsl:if>
	<xsl:if test="not(@format) or contains(@format, 'mm')">
	<postfield name="MSCTIME_{@name}_Minute" value="$MSCTIME_{@name}_Minute" />
	</xsl:if>
	<xsl:if test="not(@format) or contains(@format, 'ss')">
	<postfield name="MSCTIME_{@name}_Second" value="$MSCTIME_{@name}_Second" />
	</xsl:if>

	</xsl:when>
	<xsl:when test="@type='date_time'">
	<postfield name="MSCDATETIME_{@name}_Year" value="$MSCDATETIME_{@name}_Year" />
	<postfield name="MSCDATETIME_{@name}_Month" value="$MSCDATETIME_{@name}_Month" />
	<postfield name="MSCDATETIME_{@name}_Day" value="$MSCDATETIME_{@name}_Day" />
	<postfield name="MSCDATETIME_{@name}_Hour" value="$MSCDATETIME_{@name}_Hour" />
	<postfield name="MSCDATETIME_{@name}_Minute" value="$MSCDATETIME_{@name}_Minute" />
	<postfield name="MSCDATETIME_{@name}_Second" value="$MSCDATETIME_{@name}_Second" />
	</xsl:when>
	<xsl:when test="@type='sign'">
	</xsl:when>
	<xsl:otherwise>
	<postfield name="{@name}" value="${@name}" />
	</xsl:otherwise>
	</xsl:choose>
</xsl:if>
</xsl:for-each>

<!-- all object -->
<!-- //TODO 需要将toolbar里面的input 的 input 的value传给服务器 -->
</go>
</anchor>
<xsl:text>&#160;</xsl:text>
</xsl:when>
</xsl:choose>
</xsl:template>



<!--解析textarea标签 -->
<xsl:template match="textarea">
<xsl:value-of select="@caption"></xsl:value-of>
<br/>
<input type="text" name="{@name}"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<!-- 普通标签结束 -->

<!-- 其他标签开始 -->

<!-- FileSet -->
<xsl:template match="fileset">
<br/>
<xsl:apply-templates select="item" mode="fileset"/>
<xsl:if test="count(item[@ft = 'directory']) &gt; 0 or count(item[@ft != 'directory']) &gt; 0">
<!-- <br/>共<xsl:value-of select="count(item[@ft = 'directory'])"></xsl:value-of>文件夹&nbsp; <xsl:value-of select="count(item[@ft != 'directory'])"></xsl:value-of>文件 -->
</xsl:if>
</xsl:template>

<xsl:template match="item" mode="fileset">
<xsl:choose>
<xsl:when test="@ft = 'directory'">
<img src="images/folder.png" alt="文件夹"/>
<a href="default.do?action=getXml&amp;serverurl={@href}"><xsl:value-of select="@text"/></a>
<xsl:if test="@text != '返回上级目录'">
<xsl:if test="parent::*[name()='fileset']/@er = 'true'">
&nbsp;
<anchor>改名
<go sendreferer="true" href="default.do?action=LoadFileSetRename&amp;serverurl={@href}&amp;do=rename"></go>
</anchor>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@em = 'true'">
&nbsp;
<anchor>转移
<go sendreferer="true" href="default.do?action=LoadFileSetRemove&amp;serverurl={@href}&amp;do=mov"></go>
</anchor>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@ed = 'true'">
&nbsp;
<anchor>删除
<go sendreferer="true" href="default.do?action=LoadFileSetDelete&amp;serverurl={@href}&amp;do=del"></go>
</anchor>
</xsl:if>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<img alt="文件">
<xsl:attribute name="src">
<xsl:choose>
<xsl:when test="@ft='zip' or @ft='rar' or contains(@text,'.rar') or contains(@text,'.zip')">images/rar.png</xsl:when>
<xsl:when test="@ft='xls' or @ft='xlsx' or contains(@text,'.xls')">images/xls.png</xsl:when>
<xsl:when test="@ft='txt' or contains(@text,'.txt')">images/txt.png</xsl:when>
<xsl:when test="@ft='ppt' or @ft='pptx' or contains(@text,'.ppt')">images/ppt.png</xsl:when>
<xsl:when test="@ft='jpg' or @ft='jpeg'">images/jpg.png</xsl:when>
<xsl:when test="@ft='gif' or @ft='bmp' or @ft='tif' or @ft='png'">images/pic.png</xsl:when>
<xsl:when test="@ft='pdf' or contains(@text,'.pdf')">images/pdf.png</xsl:when>
<xsl:when test="@ft='doc' or @ft='odt' or @ft='docx' or contains(@text,'.doc')">images/doc.png</xsl:when>
<xsl:when test="@ft='htm' or @ft='shtml' or @ft='html'">images/html.png</xsl:when>
<xsl:otherwise>images/unknow.png</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
</img>
  <xsl:variable name="filename" select="@href">
    <!--
    <xsl:choose>
      <xsl:when test="contains(@href,'http')">http<xsl:value-of select="substring-after(@href,'http')"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="@href"/></xsl:otherwise>
    </xsl:choose>-->
  </xsl:variable>
<a href="default.do?action=RequestFile&amp;serverurl={$filename}"><xsl:value-of select="@text"/></a>
<xsl:if test="@size!=''">
&nbsp;<xsl:value-of select="@size"/>KB
</xsl:if>
&nbsp;
<a href="default.do?action=RequestFile&amp;serverurl={$filename}&amp;do=download">
下载</a>
<xsl:if test="parent::*[name()='fileset']/@er = 'true'">
&nbsp;
<anchor>改名
<go sendreferer="true">
<xsl:attribute name="href">default.do?action=LoadFileSetRename&amp;serverurl=<xsl:value-of select="$filename"/>&amp;do=rename</xsl:attribute>
</go>
</anchor>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@em = 'true'">
&nbsp;
<anchor>转移
<go sendreferer="true">
<xsl:attribute name="href">default.do?action=LoadFileSetRemove&amp;serverurl=<xsl:value-of select="$filename"/>&amp;do=mov</xsl:attribute>
</go>
</anchor>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@ed = 'true'">
&nbsp;
<anchor>删除
<go sendreferer="true">
<xsl:attribute name="href">default.do?action=LoadFileSetDelete&amp;serverurl=<xsl:value-of select="$filename"/>&amp;do=del</xsl:attribute>
</go>
</anchor>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
<br/>
</xsl:template>

<!-- Table Copy-->
<xsl:template match="table">
<table align="center" title="{@caption}">
<!-- 取得列数，wml中必须 -->
<xsl:attribute name="columns">
<xsl:value-of select="count(tr[1]/td)"></xsl:value-of>
</xsl:attribute>
<xsl:apply-templates select="tr"/>
</table>
</xsl:template>
<xsl:template match="tr">
<tr>
<xsl:apply-templates select="td"/>
</tr>
</xsl:template>

<xsl:template match="td">
<td>
<xsl:apply-templates />
</td>
</xsl:template>
<!-- 分页 -->
<xsl:template name="MutiPageNavigation">
<xsl:if test="@maxpage &gt; 1">
<!-- -->
[<xsl:value-of select="@pageid" />/<xsl:value-of select="@maxpage" />] 
<br/>
<xsl:choose>
<xsl:when test="substring-before(/msc/@url,'&amp;pageid')=''">
<a href="{/msc/@url}&amp;pageid=1">首页</a><xsl:text>&#160;</xsl:text>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid - 1) &gt; 0"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="@pageid - 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="/msc/@url"/>&amp;pageid=1</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		上一页
</a><xsl:text>&#160;</xsl:text>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid + 1) &lt; @maxpage"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="@pageid + 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="/msc/@url"/>&amp;pageid=2</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		下一页
</a><xsl:text>&#160;</xsl:text>
<a href="{/msc/@url}&amp;pageid={@maxpage}">尾页</a>
</xsl:when>
<xsl:otherwise>

<a href="{substring-before(/msc/@url,'&amp;pageid')}&amp;pageid=1">首页</a><xsl:text>&#160;</xsl:text>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid - 1) &gt; 0"><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="@pageid - 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=1</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		上一页
</a><xsl:text>&#160;</xsl:text>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid + 1) &lt; @maxpage"><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="@pageid + 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=2</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		下一页
</a><xsl:text>&#160;</xsl:text>
<a href="{substring-before(/msc/@url,'&amp;pageid')}&amp;pageid={@maxpage}">尾页</a>
</xsl:otherwise>
</xsl:choose>
<!-- 
<select>
<xsl:call-template name="PageNumList">
	<xsl:with-param name="totalPage" select="@maxpage"/>
	<xsl:with-param name="currentPage" select="@pageid"/>
	<xsl:with-param name="position" select="1"/>
</xsl:call-template>
</select> -->
</xsl:if>
</xsl:template>

<xsl:template name="PageNumList">
<xsl:param name="totalPage"/>
<xsl:param name="currentPage"/>
<xsl:param name="position"/>
<xsl:choose>
	<xsl:when test="$currentPage = $position">
	<option selected="selected">第<xsl:value-of select="$position"/>页</option>
	</xsl:when>
	<xsl:otherwise>
	<option>
	<xsl:attribute name="onpick">
		<xsl:choose>
		<xsl:when test="substring-before(/msc/@url,'&amp;pageid')=''"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="$position"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="$position"/></xsl:otherwise>
		</xsl:choose>			
		</xsl:attribute>
	第<xsl:value-of select="$position"/>页</option>	
</xsl:otherwise>
</xsl:choose>
<xsl:if test="$position &lt; $totalPage">
<xsl:call-template name="PageNumList">
	<xsl:with-param name="totalPage" select="$totalPage"/>
	<xsl:with-param name="currentPage" select="$currentPage"/>
	<xsl:with-param name="position" select="$position+1"/>
</xsl:call-template>
</xsl:if>
</xsl:template>
<!-- 其他标签结束 -->

<!-- 模板结束-->
</xsl:stylesheet>