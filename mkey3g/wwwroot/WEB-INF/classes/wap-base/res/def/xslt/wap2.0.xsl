<?xml version="1.0"?>
<!DOCTYPE html
[
  <!ENTITY nbsp "&#160;">
]
>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!-- 
* 全面解析MSC 2 WAP（XHTML)
* 日期：2007-2-28
* by yesun
*Comment: MSC WAP 2007 New！
 -->
<!--载入服务器配置xml 以前的老方法，基本可以废除，才用新方法，通过msc传递appfolder
<xsl:variable name="objXmlConfig" select="document('../config.xml')"/>-->
<!--根据服务器配置载入全局xml，各个app对应不同的global.xml-->
<xsl:variable name="objXmlGlobal" select="document(concat('../',/msc/@appfolder,'/global.xml'))"/>

<xsl:template match="/msc">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:wml="http://www.wapforum.org/2001/wml">
<head>
	<title><xsl:value-of select="@title" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="cache-control" content="max-age=0" />
	<meta http-equiv="cache-control" content="no-cache" />
  <xsl:if test="contains(//body/a[1]/@href ,'%7C%7C')"><!--MAS2.0-->
    <xsl:variable name="time" select="number(substring-before(//body/a[1]/@href,'%7C%7C'))"></xsl:variable>
    <xsl:if test="$time &gt; 0">
      <xsl:variable name="url_" select="substring-after(//body/a[1]/@href,'%7C%7C')"></xsl:variable>
      <xsl:if test="$url_ != ''">
        <meta http-equiv="refresh" content="{$time}; url=default.do?action=getXml&amp;serverurl={$url_}" />
      </xsl:if>
    </xsl:if>
  </xsl:if>
	<link href="xslt/css.css" rel="stylesheet" type="text/css" />
</head>

<body id ="list" title="{@title}">
<xsl:choose>
<xsl:when test="@type = 'login'">
<form id="frmLogin" method="post" action="default.do">
<xsl:apply-templates />
</form>
</xsl:when>
<xsl:when test="@type = 'form'">
<form id="frmFrom" method="post">
<xsl:attribute name="action">
<xsl:choose>
<xsl:when test="starts-with(@action,'?')">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@action" /></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@action" /></xsl:otherwise><!--MAS2.0-->
</xsl:choose>
</xsl:attribute>
<!-- 内容开始 -->
<xsl:apply-templates />
<!-- 内容结束 -->
</form>
</xsl:when>
<xsl:when test="@type = 'imageview'">
<!-- 内容开始 -->
<div class="navigation">
跳转：
<select>
<xsl:for-each select="body/img">
<option wml:onpick="default.do?action=ImageView&amp;serverurl={position()}">
<xsl:if test="@selected = 'selected' or @selected='true'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
第<xsl:value-of select="position()"/>张
</option>
</xsl:for-each>
</select>
</div>
<xsl:apply-templates select="body/img[@selected='selected']" />
<!-- 内容结束 -->
</xsl:when>

<xsl:when test="@type = 'mailcontent'">
<!-- Mail Heaer -->
<table>
<tr><td>From</td><td><xsl:value-of select="mail/@from"/></td></tr>
<tr><td>To</td><td><xsl:value-of select="mail/@to"/></td></tr>
<xsl:if test="mail/@cc!=''">
<tr><td>Cc</td><td><xsl:value-of select="mail/@cc"/></td></tr>
</xsl:if>
<xsl:if test="mail/@bcc!=''">
<tr><td>Bcc</td><td><xsl:value-of select="mail/@bcc"/></td></tr>
</xsl:if>
</table>
<hr/>
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
<xsl:if test="@enablereply = 'true'">
<a accesskey="1" href="default.do?action=LoadMailReply&amp;all=false&amp;id={mail/@mailid}">回复</a><br/>
<a accesskey="2" href="default.do?action=LoadMailReply&amp;all=true&amp;id={mail/@mailid}">回复所有</a><br/>
<a accesskey="3" href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=markunread@mail&amp;id={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">标记未读</a><br/>
</xsl:if>
<a accesskey="4" href="default.do?action=LoadMailForward&amp;id={mail/@mailid}">转发</a><br/>
<!--
<xsl:if test="mail/@mailbox != '草稿箱'">
<a accesskey="5" href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=movetotempbox@mail&amp;id={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">存入草稿箱</a><br/>
</xsl:if>
-->
<a accesskey="6" href="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=delmail@mail&amp;delid={mail/@mailid}&amp;urlreferer=?action=getmaillistform@mail">删除邮件</a><br/>
<a accesskey="7" href="default.do?action=getXml&amp;serverurl=wap/xml/createmail.xml">写邮件</a><br/>
</xsl:when>
<xsl:when test="@type = 'getmailsetting'">
<form id="frmFrom" method="post" action="default.do?action=ExecuteQueryAndAlertAndRedirect&amp;cmdText=action=setmailsetting@mail&amp;urlreferer=default.do?action=getXml%26serverurl=home.xml">
<table>
<tr><td>邮箱地址</td><td><input type="text" name="email" value="{@email}"/></td></tr>
<tr><td>帐号</td><td><input type="text" name="username" value="{@username}"/></td></tr>
<tr><td>密码</td><td><input type="password" name="password" value="{@password}"/></td></tr>
<tr><td>POP3服务器</td><td><input type="text" name="pop3server" value="{@pop3server}"/></td></tr>
<tr><td>POP3端口</td><td><input type="text" name="pop3port" value="{@pop3port}"/></td></tr>
<tr><td>SMTP服务器</td><td><input type="text" name="smtpserver" value="{@smtpserver}"/></td></tr>
<tr><td>SMTP端口</td><td><input type="text" name="smtpport" value="{@smtpport}"/></td></tr>
<tr><td align="right" colspan="2"><input type="submit" value="保存设置"/></td></tr>
</table>
</form>
<xsl:apply-templates />
</xsl:when>
  <xsl:when test="@type = 'servermsg'">
      <xsl:if test="msg/@isshow = '1'">
        <xsl:value-of select="msg/text()"/>
      </xsl:if>
    <xsl:if test="msg/@nextaction != '' and starts-with(msg/@nextaction,'redirect()')">
        <a target="_self">
        <xsl:attribute name="href">
        <xsl:choose>
        <xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of></xsl:when>
        <xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
        <xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
        <xsl:when test="contains(@href,'viewfileremote') or starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
        <xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
        </xsl:choose>
        </xsl:attribute>点击跳转
      </a>
    </xsl:if>
  </xsl:when>
<xsl:otherwise>
<!-- 内容开始 -->
<xsl:apply-templates />
<!-- 内容结束 -->
</xsl:otherwise>
</xsl:choose>

<!-- 分页 -->
<xsl:if test="@maxpage &gt; 1">
<xsl:call-template name="MutiPageNavigation" />
<br/>
</xsl:if>


<xsl:if test="@statusbar_caption != ''">
<div class="clear"></div>

<hr/>
<marquee>
<xsl:value-of select="@statusbar_caption" />
</marquee>
</xsl:if>
<xsl:if test="@isneedback = 'true'">
<br/>
<a href="default.do?action=getXml&amp;serverurl={$objXmlGlobal/msc/home/@href}">返回首页</a>
<br/>
<a href="default.do?appid={substring-after(/msc/@appfolder,'/')}">重新登录</a>
<br/>
</xsl:if>
<a href="setup.wml">客户端下载</a>
<br/>
<a href="default.do?wap=1.0">wml版本</a>
</body>
</html>
</xsl:template>

<!-- 模板开始 -->

<!-- MSC专有标签开始 -->
<xsl:template match="object">
<xsl:choose>
<xsl:when test="@type = 'login'">
<!-- object for login -->
<xsl:apply-templates select="../object[@type='login']" mode="login"/>
</xsl:when>
<xsl:when test="@type = 'toolbar'">
<!-- object for login -->
<xsl:apply-templates select="../object[@type='toolbar']" mode="toolbar"/>
</xsl:when>
<xsl:when test="@type = 'multiselect'">
<!-- object for multiselect -->
	<xsl:choose>
	<xsl:when test="@style='formtree'">
	<!-- 多级联动 -->
	<xsl:apply-templates select="." mode="multiselect-formtree"/>
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
<div class="navigation">
<xsl:text> </xsl:text>
<xsl:apply-templates select="child::*" />
</div>
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
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="2007" /><xsl:with-param name="end" select="2009" /><xsl:with-param name="value" select="substring-before(@value,'-')" /></xsl:call-template></select>年
<select name="MSCDATE_{@name}_Month">
<xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,'-'),'-')-1"/></xsl:attribute>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="12" /><xsl:with-param name="value" select="substring-before(substring-after(@value,'-'),'-')" /></xsl:call-template></select>月
<select name="MSCDATE_{@name}_Day">
<xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(@value,'-'),'-')-1"/></xsl:attribute>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="31" /><xsl:with-param name="value" select="substring-after(substring-after(@value,'-'),'-')" /></xsl:call-template></select>日
</xsl:template>

<!-- date object -->
<xsl:template match="object" mode="time">
<xsl:value-of select="@caption"/>
<xsl:if test="not(@format) or contains(@format, 'hh')">
<select name="MSCTIME_{@name}_Hour"><xsl:attribute name="value"><xsl:value-of select="substring-before(@value,':')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="0" /><xsl:with-param name="end" select="23" /><xsl:with-param name="value" select="substring-before(@value,':')" /></xsl:call-template></select>时
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
<select name="MSCDATETIME_{@name}_Year"><xsl:attribute name="value"><xsl:value-of select="substring-before(@value,'-')"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="2007" /><xsl:with-param name="end" select="2009" /><xsl:with-param name="value" select="substring-before(@value,'-')" /></xsl:call-template></select>年
<select name="MSCDATETIME_{@name}_Month"><xsl:attribute name="value"><xsl:value-of select="substring-before(substring-after(@value,'-'),'-')-1"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="12" /><xsl:with-param name="value" select="substring-before(substring-after(@value,'-'),'-')" /></xsl:call-template></select>月
<select name="MSCDATETIME_{@name}_Day"><xsl:attribute name="value"><xsl:value-of select="substring-after(substring-after(substring-before(@value,' '),'-'),'-')-1"/></xsl:attribute><xsl:call-template name="DropDownList"><xsl:with-param name="start" select="1" /><xsl:with-param name="end" select="31" /><xsl:with-param name="value" select="substring-after(substring-after(@value,'-'),'-')" /></xsl:call-template></select>日
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
<xsl:if test="$value = $start">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="$start"/>
</option>
<xsl:call-template name="DropDownList"><xsl:with-param name="start" select="$start + 1" /><xsl:with-param name="end" select="$end" /><xsl:with-param name="value" select="$value" /></xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template match="ul">
<xsl:copy><xsl:apply-templates select="li" /></xsl:copy>
</xsl:template>

<xsl:template match="li">
<xsl:copy><xsl:apply-templates /></xsl:copy>
</xsl:template>


<!-- toolbar object -->
<xsl:template match="object" mode="toolbar">
<xsl:for-each select="input">
<!-- 通过position来定位没有子的input -->
<xsl:param name="currentPosition"><xsl:value-of select="position()" /></xsl:param>
<xsl:choose>
<xsl:when test="count(child::input) &gt; 0">
	<xsl:apply-templates select="input" />
</xsl:when>
<xsl:when test="count(child::input) = 0">
	<xsl:apply-templates select="../input[position()=$currentPosition]" />
</xsl:when>
</xsl:choose>
<br/>
</xsl:for-each>
</xsl:template>

<!-- login object -->
<xsl:template match="object" mode="login">
用户名：<input name="username" type="text" emptyok="false" maxlength="20" tabindex="1" /><br/>
密&nbsp;&nbsp;码：<input name="password" type="password" emptyok="false" maxlength="20" tabindex="2"/><br/>
验证码：<input name="rnd" type="text" emptyok="false" maxlength="20" tabindex="3"/><br/><img src="../rnd.do?type=wap_rnd" alt="验证码"/><br/>
<input type="submit" value="登 录"  tabindex="3"></input>
<!-- 根据Global.xml来判断是否需要加密传输 -->
<xsl:if test="$objXmlGlobal/msc/secure/@value !=''">
<input type="checkbox" name="chkSecureType" id="chkSecureType">
<xsl:attribute name="value">
<xsl:value-of select="$objXmlGlobal/msc/secure/@value"/></xsl:attribute>
<xsl:if test="$objXmlGlobal/msc/secure/@readonly = 'true'">
<xsl:attribute name="readonly">readonly</xsl:attribute>
</xsl:if>
</input>
<label for="chkSecureType">加密传输</label>
</xsl:if>

<!-- 固定参数，采用post方式传递 -->
<input name="logintype" type="hidden" value="wap"/>
<input name="action" type="hidden" value="login"/>
<input name="mscver" type="hidden" value="450"/>
<input name="phonemodel" type="hidden" value="{/msc/@UA}"/>
<input name="appid" type="hidden" value="{$objXmlGlobal/msc/@appid}"/>
<input name="appver" type="hidden" value="{$objXmlGlobal/msc/@appver}"/>
<input name="siid" type="hidden" value="{$objXmlGlobal/msc/@siid}"/>
<input name="ishide" type="hidden" value="1"/>

</xsl:template>

<!--mutiselect object for tree : 无级下拉列表树 -->
<xsl:template match="object" mode="multiselect-tree">
<xsl:value-of select="@caption" />
<select>
<xsl:attribute name="name"><xsl:value-of select="@name" /></xsl:attribute>
<option>请选择</option>
<xsl:apply-templates select="item" mode="multiselect-tree">
<xsl:with-param name="leftspace">┣</xsl:with-param>
</xsl:apply-templates>
</select>
</xsl:template>

<!-- 解析multiselect标签 ，树形菜单 -->
<xsl:template match="item" mode="multiselect-tree">
<!-- 接受传入的参数 -->
<xsl:param name="leftspace"></xsl:param>
<option>
<xsl:if test="@selected='selected' or @selected='true'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:if test="@href != ''">
<xsl:attribute name="onclick">javascript:location.href='default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>'</xsl:attribute>
<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/></xsl:attribute>
</xsl:if>


<xsl:if test="@childurl != ''">
<xsl:attribute name="onclick">javascript:location.href='default.do?action=getXml&amp;serverurl=<xsl:value-of select="@childurl"/>&amp;parentname=<xsl:value-of select="ancestor::object/@name"/>&amp;value=<xsl:value-of select="@value"/>&amp;target=<xsl:value-of select="@target"/>'</xsl:attribute>
<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@childurl"/>&amp;parentname=<xsl:value-of select="ancestor::object/@name"/>&amp;value=<xsl:value-of select="@value"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:if>

<xsl:attribute name="value"><xsl:value-of select="@value"></xsl:value-of></xsl:attribute>
<xsl:value-of select="$leftspace"></xsl:value-of><xsl:value-of select="@caption"></xsl:value-of>
</option>
<!-- 如果有子，则需要递归 -->
<xsl:apply-templates select="item" mode="multiselect-tree">
<xsl:with-param name="leftspace"> &nbsp; <xsl:value-of select="$leftspace"/></xsl:with-param>
</xsl:apply-templates>
</xsl:template>


<!--mutiselect object for formtree : 平普展开的一棵树-->
<xsl:template match="object" mode="multiselect-formtree">
<div>
<xsl:attribute name="name"><xsl:value-of select="@name" /></xsl:attribute>
<xsl:value-of select="@caption" />
<xsl:apply-templates select="item" mode="multiselect-formtree">
<xsl:with-param name="leftspace">┣</xsl:with-param>
</xsl:apply-templates>
</div>
</xsl:template>

<!-- 解析multiselect标签 ，树形菜单 -->
<xsl:template match="item" mode="multiselect-formtree">
<!-- 接受传入的参数 -->
<xsl:param name="leftspace"></xsl:param>
<li>
<xsl:if test="@selected='selected' or @selected='true'">
<xsl:attribute name="style">color:#ff0000;</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="@value"></xsl:value-of></xsl:attribute>
<xsl:value-of select="$leftspace"></xsl:value-of>
<xsl:choose>
<xsl:when test="@href != ''">
<a href="?action=getXml&amp;serverurl={@href}"><xsl:value-of select="@caption" /></a>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="@caption" />
</xsl:otherwise>
</xsl:choose>
</li>
<!-- 如果有子，则需要递归 -->
<xsl:apply-templates select="item" mode="multiselect-formtree">
<xsl:with-param name="leftspace"> &nbsp; <xsl:value-of select="$leftspace"/></xsl:with-param>
</xsl:apply-templates>
</xsl:template>



<!--mutiselect object for multicombox -->
<xsl:template match="object" mode="multiselect-multicombox">

<xsl:param name="objectname"><xsl:value-of select="@name" /></xsl:param>

<xsl:value-of select="@caption" />
<select>
<xsl:attribute name="name"><xsl:value-of select="@name" /></xsl:attribute>
<xsl:apply-templates select="item" mode="multiselect-multicombox">
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
<xsl:when test="../item[@selected='selected' or @selected='true']/item[@caption!='']">
<xsl:value-of select="." />
<select>
<xsl:attribute name="name"><xsl:value-of select="$objectname" />_<xsl:value-of select="name()" /></xsl:attribute>
		<xsl:choose>
		<xsl:when test="position() = 1">
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 2">
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 3">
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 4">
		<xsl:apply-templates select="../item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item[@selected='selected' or @selected='true']/item" mode="multiselect-multicombox">
		<!-- 参数：caption级别 -->
		<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
		<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
		</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="position() = 5">
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
<select>
<xsl:attribute name="name"><xsl:value-of select="$objectname" />_<xsl:value-of select="name()" /></xsl:attribute>
<xsl:choose>
<xsl:when test="position() = 1">
<xsl:apply-templates select="../item[1]/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="position() = 2">
<xsl:apply-templates select="../item[1]/item[1]/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="position() = 3">
<xsl:apply-templates select="../item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="position() = 4">
<xsl:apply-templates select="../item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
<!-- 参数：caption级别 -->
<xsl:with-param name="captiontype">_<xsl:value-of select="name()" /></xsl:with-param>
<xsl:with-param name="objectname"><xsl:value-of select="$objectname" /></xsl:with-param>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="position() = 5">
<xsl:apply-templates select="../item[1]/item[1]/item[1]/item[1]/item[1]/item" mode="multiselect-multicombox">
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

<option>
<xsl:if test="@selected='selected' or @selected='true'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>

<xsl:choose>
<xsl:when test="@childurl!=''">
<xsl:attribute name="onclick">javascript:location.href='default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/>'</xsl:attribute>
<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/></xsl:attribute> 
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="item[1]/@caption!=''">
	<!-- 表示还有子类 -->
	<xsl:attribute name="onclick">javascript:location.href='default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/>'</xsl:attribute>
	<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>	
 <xsl:attribute name="onclick">javascript:location.href='default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/>'</xsl:attribute>
 	<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;objectname=<xsl:value-of select="$objectname"/>&amp;captiontype=<xsl:value-of select="$captiontype"/>&amp;ismultiselect=true&amp;serverurl=<xsl:value-of select="position()"/></xsl:attribute>
</xsl:otherwise>
	</xsl:choose>	
</xsl:otherwise>
</xsl:choose>
<xsl:attribute name="value"><xsl:value-of select="@caption"/></xsl:attribute>
<xsl:value-of select="@caption"></xsl:value-of>
</option>
</xsl:template>
<!--MAS2.0-->
  <xsl:template match="grid">
    <xsl:apply-templates select="group" />
  </xsl:template>


<!-- group for grid -->
<xsl:template match="group">
<div class="grid">
<h2><xsl:value-of select="@caption"></xsl:value-of></h2>
<ul>
<xsl:apply-templates select="item" mode="group"/>
</ul>
</div>
<br/>
</xsl:template>
<!-- group item for grid -->
<xsl:template match="item" mode="group">
<xsl:if test="@caption != '提醒方式'">
<li>
<a accesskey="{position()}">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<!--MAS2.0-->
  <xsl:if test="@icon!=''">
    <xsl:choose>
      <xsl:when test="starts-with(@icon, 'classpath')">
        <img src="images/{substring-after(@icon,':')}"/>
      </xsl:when>
      <xsl:otherwise>
        <img src="{/msc/@appfolder}/{@icon}" alt="{@caption}"/>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
  
<xsl:value-of select="@caption"></xsl:value-of>
</a>
<xsl:if test="substring-before(@href,':')='tel'">
（<a href="wtai://wp/mc;//17951{substring-after(@href,'://')}">IP拨叫</a>）
</xsl:if>
<br/><br/>
</li>
</xsl:if>
</xsl:template>

<!-- list item -->
<xsl:template match="item">
<li>
<xsl:choose>
<xsl:when test="@href != ''">
<xsl:value-of select="position()"></xsl:value-of>.
<xsl:element name="a">
<xsl:attribute name="accesskey">
<xsl:value-of select="position()"></xsl:value-of>
</xsl:attribute>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="contains(@href,'viewfileremote') or starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>


</xsl:attribute>
<xsl:if test="@icon!=''">
<xsl:choose>
<xsl:when test="starts-with(@icon, 'classpath')">
<img src="images/{substring-after(@icon,':')}"/>
</xsl:when>
<xsl:otherwise>
<img src="{/msc/@appfolder}/{@icon}" alt="{@caption}"/>
	<br/>
</xsl:otherwise>
</xsl:choose>	
</xsl:if>
<xsl:value-of select="@caption"></xsl:value-of>
</xsl:element>

<xsl:if test="substring-before(@href,':')='tel'">
（<a href="wtai://wp/mc;//17951{substring-after(@href,'://')}">IP拨叫</a>）
</xsl:if>

<xsl:if test="@sndcaption != ''">
<br/>
<xsl:value-of select="@sndcaption"></xsl:value-of>
</xsl:if>
</xsl:when>

<xsl:otherwise>
<xsl:value-of select="@caption"></xsl:value-of>
<xsl:if test="@sndcaption != ''">
<br/>
<xsl:value-of select="@sndcaption"></xsl:value-of>
</xsl:if>
</xsl:otherwise>

</xsl:choose>
</li>

<xsl:apply-templates select="item"></xsl:apply-templates>

</xsl:template>



<!-- msg -->
<xsl:template match="msg">
<br/>
<xsl:value-of select="."/>
<br/>
</xsl:template>


<!-- MSC专有标签结束 -->

<!-- 普通标签开始 -->

<!--font标签 -->
<xsl:template match="font">
<xsl:element name="font">
<xsl:choose>
<xsl:when test="@bold='true'">

<xsl:attribute name="color">
    <xsl:value-of select="@color"></xsl:value-of>
  </xsl:attribute>
  <xsl:attribute name="align">
    <xsl:value-of select="@align"></xsl:value-of>
  </xsl:attribute>
  
<b>
<xsl:value-of select="."></xsl:value-of>
</b>
  
</xsl:when>
<xsl:when test="@size='large'">
<xsl:attribute name="size">4</xsl:attribute>
</xsl:when>
<xsl:when test="@size='normal'">
<xsl:attribute name="size">2</xsl:attribute>
</xsl:when>
<xsl:when test="@size='small'">
<xsl:attribute name="size">1</xsl:attribute>
</xsl:when>
  <xsl:otherwise>
    <xsl:choose>
      <xsl:when test="@size='large'">
      <xsl:attribute name="size">4</xsl:attribute>
      </xsl:when>
      <xsl:when test="@size='normal'">
      <xsl:attribute name="size">2</xsl:attribute>
      </xsl:when>
      <xsl:when test="@size='small'">
      <xsl:attribute name="size">1</xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:attribute name="color">
      <xsl:value-of select="@color"></xsl:value-of>
    </xsl:attribute>
    <xsl:attribute name="align">
      <xsl:value-of select="@align"></xsl:value-of>
    </xsl:attribute>
    <xsl:value-of select="."></xsl:value-of>
  </xsl:otherwise>
</xsl:choose>
</xsl:element>
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
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:apply-templates />
</xsl:element>
<xsl:if test="substring-before(@href,':')='tel'">
（<a href="wtai://wp/mc;//17951{substring-after(@href,'://')}">IP拨叫</a>）
</xsl:if>
</xsl:template>

<!--p标签 -->
<xsl:template match="p">
<xsl:element name="p">
<xsl:attribute name="align">
<xsl:value-of select="@align"></xsl:value-of>
</xsl:attribute>
<xsl:apply-templates />	
</xsl:element>
</xsl:template>

<!-- Span -->
<xsl:template match="span">
<xsl:element name="span">
<xsl:attribute name="align">
<xsl:value-of select="@align"></xsl:value-of>
</xsl:attribute>
<xsl:attribute name="style">
<xsl:value-of select="@style"></xsl:value-of>
</xsl:attribute>
<xsl:apply-templates />	
</xsl:element>
</xsl:template>

<!--br标签 -->
<xsl:template match="br">
<br/>
</xsl:template>

<!--可扩展增加需要解析的标签 -->
<!-- 解析img标签 , 入口 -->
<xsl:template match="img">
<p>
<xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
<xsl:choose>
<xsl:when test="string-length(@href)>0">
<a>
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of></xsl:when>
<xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
<xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
<xsl:when test="contains(@href,'viewfileremote') or starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
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
</p>
</xsl:template>


<!-- 解析img标签， 真正解析img-->
<xsl:template match="img" mode="bll">
<img>
<xsl:attribute name="src">
<xsl:choose><xsl:when test="starts-with(@src,'default.do') or starts-with(@src,'http')"><xsl:value-of select="@src" /></xsl:when>
<xsl:otherwise>default.do?action=ImageView&amp;serverurl=<xsl:value-of select="@src" /></xsl:otherwise></xsl:choose>

<!-- 
<xsl:choose>
<xsl:when test="contains(@src,'http://')">
<xsl:value-of select="@src" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/msc/@appfolder" />/<xsl:value-of select="@src" />
</xsl:otherwise>
</xsl:choose>
 -->
</xsl:attribute>
<xsl:attribute name="alt"><xsl:value-of select="/msc/@title" /></xsl:attribute>
</img>
</xsl:template>

<!-- 解析select标签  -->
<xsl:template match="select">
<xsl:value-of select="@caption" />
<select>
<xsl:attribute name="name"><xsl:value-of select="@name" /></xsl:attribute>
<xsl:for-each select="option">
<option>
<xsl:if test="@checked = 'true' or @selected = 'true' or @selected = 'selected'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
<xsl:if test="@href != ''">

<xsl:attribute name="onclick">location.href='default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/>';</xsl:attribute>

<xsl:attribute name="wml:onpick">default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"/>&amp;target=<xsl:value-of select="@target"/></xsl:attribute>
</xsl:if>
<xsl:value-of select="."></xsl:value-of>
</option>
</xsl:for-each>
</select>
</xsl:template>


<!--解析input标签 -->
<xsl:template match="hr">
<hr/>
</xsl:template>


<!--解析input标签 -->
<xsl:template match="input">
<xsl:choose>
<xsl:when test="@type = 'text' or @type = 'file' or @type = 'password' or @type = 'hidden'">
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
<textarea name="{@name}"><xsl:text> </xsl:text><xsl:value-of select="."></xsl:value-of></textarea>
</xsl:when>
<xsl:when test="@type = 'radio'">
<input type="{@type}" name="{@name}" value="{@value}">
<xsl:if test="@checked = 'true' or @selected='true' or @selected='selected'">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
</input>
<xsl:value-of select="@caption"></xsl:value-of>
</xsl:when>
<xsl:when test="@type = 'checkbox'">
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
</xsl:when>
<xsl:when test="@type = 'button' or @type ='reset' or @type ='submit'">
  <!--MAS2.0-->
  <xsl:choose>
    <xsl:when test="@type = 'button' and @href != ''">
      <a>
        <xsl:attribute name="href">
        <xsl:choose>
        <xsl:when test="substring-before(@href,':')='http'"><xsl:value-of select="@href"></xsl:value-of></xsl:when>
        <xsl:when test="substring-before(@href,':')='tel'">wtai://wp/mc;<xsl:value-of select="substring-after(@href,':')"></xsl:value-of></xsl:when>
        <xsl:when test="starts-with(@href,'default.do')"><xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
        <xsl:when test="contains(@href,'viewfileremote') or starts-with(@href,'file:')">default.do?action=RequestFile&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:when>
        <xsl:otherwise>default.do?action=getXml&amp;serverurl=<xsl:value-of select="@href"></xsl:value-of>&amp;target=<xsl:value-of select="@target"/></xsl:otherwise>
        </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="@caption"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <input type="{@type}" name="{@name}" value="{@caption}"/>
    </xsl:otherwise>
  </xsl:choose>
  
</xsl:when>
</xsl:choose>
</xsl:template>


<!--解析textarea标签 -->
<xsl:template match="textarea">
<xsl:value-of select="@caption"></xsl:value-of>
<br/><!--MAS2.0-->
<textarea name="{@name}"><xsl:text> </xsl:text><xsl:value-of select="text()"></xsl:value-of></textarea>
</xsl:template>
<!-- 普通标签结束 -->


<!-- 其他标签开始 -->
<!-- FileSet -->
<xsl:template match="fileset">
<div>
<xsl:apply-templates select="item" mode="fileset"/>
<xsl:if test="count(item[@ft = 'directory']) &gt; 0 or count(item[@ft != 'directory']) &gt; 0">
<!--
<li class="ar">共<xsl:value-of select="count(item[@ft = 'directory'])"></xsl:value-of>文件夹&nbsp; <xsl:value-of select="count(item[@ft != 'directory'])"></xsl:value-of>文件</li>
-->
</xsl:if>
</div>
</xsl:template>

<xsl:template match="item" mode="fileset">
<li>
<xsl:choose>
<xsl:when test="@ft = 'directory'">
<img src="images/folder.png" alt="文件夹"/>
<a href="default.do?action=getXml&amp;serverurl={@href}">
<xsl:value-of select="@text"/>
</a>
<xsl:if test="@text != '返回上级目录'">
<xsl:if test="parent::*[name()='fileset']/@er = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetRename&amp;serverurl={@href}&amp;do=rename">改名</a>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@em = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetRemove&amp;serverurl={@href}&amp;do=mov">转移</a>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@ed = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetDelete&amp;serverurl={@href}&amp;do=del">删除</a>
</xsl:if>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<img alt="文件">
<xsl:attribute name="src">
<xsl:choose>
<xsl:when test="@ft='zip' or @ft='rar'">images/rar.png</xsl:when>
<xsl:when test="@ft='xls'">images/xls.png</xsl:when>
<xsl:when test="@ft='txt'">images/txt.png</xsl:when>
<xsl:when test="@ft='ppt'">images/ppt.png</xsl:when>
<xsl:when test="@ft='xls' or @ft='xlsx'">images/xls.png</xsl:when>
<xsl:when test="@ft='jpg' or @ft='jpeg'">images/jpg.png</xsl:when>
<xsl:when test="@ft='gif' or @ft='bmp' or @ft='tif' or @ft='png'">images/pic.png</xsl:when>
<xsl:when test="@ft='pdf'">images/pdf.png</xsl:when>
<xsl:when test="@ft='doc' or @ft='odt'">images/doc.png</xsl:when>
<xsl:when test="@ft='htm' or @ft='shtml' or @ft='html'">images/html.png</xsl:when>
<xsl:otherwise>images/unknow.png</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
</img>
<a href="default.do?action=RequestFile&amp;serverurl={@href}"><xsl:value-of select="@text"/></a>
<xsl:if test="@size!=''">
&nbsp;<xsl:value-of select="@size"/>KB
</xsl:if>

&nbsp;
<a href="default.do?action=RequestFile&amp;serverurl={@href}&amp;do=download">下载</a>
<xsl:if test="parent::*[name()='fileset']/@er = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetRename&amp;serverurl={@href}&amp;do=rename">改名</a>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@em = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetRemove&amp;serverurl={@href}&amp;do=mov">转移</a>
</xsl:if>
<xsl:if test="parent::*[name()='fileset']/@ed = 'true'">
&nbsp;
<a href="default.do?action=LoadFileSetDelete&amp;serverurl={@href}&amp;do=del">删除</a>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</li>
</xsl:template>


<!-- Table Copy-->
<xsl:template match="table">
<table border="1">
<xsl:apply-templates select="tr"/>
</table>
</xsl:template>
<xsl:template match="tr">
<xsl:copy><xsl:apply-templates select="td"/></xsl:copy>
</xsl:template>
<xsl:template match="td">
<td>
<xsl:if test="@style != ''">
<xsl:attribute name="style">
<xsl:value-of select="@style"/>
</xsl:attribute>
</xsl:if>

<xsl:if test="@colspan!=''">
<xsl:attribute name="colspan">
<xsl:value-of select="@colspan"/>
</xsl:attribute>
</xsl:if>

<xsl:apply-templates />
</td>
</xsl:template>

<!-- 分页 -->
<xsl:template name="MutiPageNavigation">
<xsl:if test="@maxpage &gt; 1">
当前<xsl:value-of select="@pageid" />/<xsl:value-of select="@maxpage" />页
<br/>
<xsl:choose>
<xsl:when test="substring-before(/msc/@url,'&amp;pageid')=''">
<a href="{/msc/@url}&amp;pageid=1">首页</a>
<a><xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid - 1) &gt; 0"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="@pageid - 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="/msc/@url"/>&amp;pageid=1</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		上一页
</a>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid + 1) &lt; @maxpage"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="@pageid + 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="/msc/@url"/>&amp;pageid=2</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		下一页
</a>
<a href="{/msc/@url}&amp;pageid={@maxpage}">尾页</a>
</xsl:when>
<xsl:otherwise>

<a href="{substring-before(/msc/@url,'&amp;pageid')}&amp;pageid=1">首页</a>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid - 1) &gt; 0"><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="@pageid - 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=1</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		上一页
</a>
<a>
		<xsl:attribute name="href">
		<xsl:choose>
		<xsl:when test="(@pageid + 1) &lt; @maxpage"><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="@pageid + 1"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="@maxpage"/></xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		下一页
</a>
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
	<xsl:attribute name="wml:onpick">
		<xsl:choose>
		<xsl:when test="substring-before(/msc/@url,'&amp;pageid')=''"><xsl:value-of select="/msc/@url"/>&amp;pageid=<xsl:value-of select="$position"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(/msc/@url,'&amp;pageid')"/>&amp;pageid=<xsl:value-of select="$position"/>
		</xsl:otherwise>
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
