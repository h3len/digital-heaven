<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">
 
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1">
<xsl:if test="/root/mailconfig/@errdesc">
<tr>
<td width="16"><img src="../skin/default/images/text_icon.gif" /></td>
<td width="100"><font color='red'>邮箱配置出错：</font></td>
<td ><font color='red'><xsl:value-of select="/root/mailconfig/@errdesc"></xsl:value-of></font></td>
</tr>
</xsl:if>
<xsl:if test="/root/mailconfig/@enable = 'false'">
<tr style="display:none"><td width="16"><img src="../skin/default/images/text_icon.gif" /></td>
<td width="100">快捷配置：</td><td>
<select id="outemailstyle" onchange="javascript:ChangeOutemailStyle()" class="input_180px" disabled = "false">
<option id="self"  value="self" >自定义邮箱</option>
<option id="enterprise" value="enterprise" >本单位邮箱</option>
<option id="sina" value="sina" >新浪</option>
<option id="163" value="163" >网易</option>
<option id="sohu" value="sohu" >搜狐</option>
</select>
</td></tr>
</xsl:if>

<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td  width="100">邮箱地址：</td><td><input type="text" id="email" maxlength="50" style="border:none" readonly="readonly"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@email" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮箱账号：</td><td><input type="text" id="username" maxlength="50" style="border:none"  readonly="readonly" ><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@username" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮箱密码：</td><td><input type="password" id="mailpassword" maxlength="50" style="border:none"  readonly="readonly" ><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@password" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮箱类型：</td><td>
<input type="text" id="emailstyle" readonly="true" style="border:none"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@emailstyle" /></xsl:attribute></input>
</td></tr>

</table>

<table width="80%" bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td>

<!--checkbox_div1-->
<div id="checkbox_div1" >
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">POP3服务器：</td><td>
<input type="text" id="pop3server" maxlength="50" style="border:none;"  >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:attribute name="value" maxlength="50">
<xsl:value-of select="/root/mailconfig/@pop3server" />
</xsl:attribute>
<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
</input>
</td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>POP3端口：</td><td>
<input type="text" id="pop3port" maxlength="50" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pop3port" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>SMTP服务器：</td><td><input type="text" id="smtpserver" style="border:none">

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpserver" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>SMTP端口：</td><td><input type="text" id="smtpport" style="border:none"  >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpport" /></xsl:attribute></input>
</td></tr>
</table>
</div>
<!--checkbox_div1-->



<!--checkbox_div2-->
<div id="checkbox_div2" style="display:none;">
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">OWA地址：</td><td><input type="text" id="owa" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@owa" /></xsl:attribute></input></td></tr>

<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮件域：</td><td><input type="text" id="maildoain2" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@maildoain2" /></xsl:attribute></input>
</td></tr>
		</table>
</div>
<!--checkbox_div2-->


<!--checkbox_div3-->
<div id="checkbox_div3" style="display:none;">
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">服务器地址：</td><td><input type="text" id="pushmailip3" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>
<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pushmailip3" /></xsl:attribute></input></td></tr>

<!--<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮件域：</td><td><input type="text" id="pushmaildomain3" style="border:none">

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pushmaildomain3" /></xsl:attribute></input>
</td></tr>-->
</table>
</div>
<!--checkbox_div3-->

<!--checkbox_div4-->
<div id="checkbox_div4" >
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">webservice地址：</td><td>
<input type="text" id="exchangeServer" maxlength="50"   style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:attribute name="value" maxlength="50">
<xsl:value-of select="/root/mailconfig/@exchangeServer" />
</xsl:attribute>
<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
</input>
</td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>邮件域：</td><td>
<input type="text" id="pushmaildomain4" maxlength="50" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pushmaildomain4" /></xsl:attribute></input></td></tr>
<tr style="display:none"><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>服务器主机地址：</td><td><input type="text" id="exchangeHost" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@exchangeHost" /></xsl:attribute></input></td></tr>
<tr style="display:none"><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>Exchange端口：</td><td><input type="text" id="exchangePort" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@exchangePort" /></xsl:attribute></input>
</td></tr>
</table>
</div>
<!--checkbox_div4-->

<!--checkbox_div5-->
<div id="checkbox_div5" >
<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">IMAP服务器：</td><td>
<input type="text" id="imapserver" maxlength="50"   style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:attribute name="value" maxlength="50">
<xsl:value-of select="/root/mailconfig/@imapserver" />
</xsl:attribute>
<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
</input>
</td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>IMAP端口：</td><td>
<input type="text" id="imapport" maxlength="50" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@imapport" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>SMTP服务器：</td><td><input type="text" id="smtpserverforimap" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpserverforimap" /></xsl:attribute></input></td></tr>
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td>SMTP端口：</td><td><input type="text" id="smtpportforimap" style="border:none" >

<xsl:attribute name="readonly">readonly</xsl:attribute>

<xsl:if test="/root/mailconfig/@enable = 'false'">
<xsl:attribute name="onchange">
changeSelectboxValue()
</xsl:attribute>
</xsl:if>
<xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpportforimap" /></xsl:attribute></input>
</td></tr>
</table>
</div>
<!--checkbox_div5-->

<table width="80%"  bgcolor="" border="0" cellpadding="0" cellspacing="1">
<tr><td width="16"><img src="../skin/default/images/text_icon.gif" /></td><td width="100">手机号码：</td><td><span id="spanPort" ></span></td><td><xsl:value-of select="/root/mailconfig/@mobile" /><input type="hidden" id="phonenum" value="{/root/mailconfig/@mobile}" /></td></tr>
<tr style="display: none;"><td ><img src="../skin/default/images/text_icon.gif" /></td><td>提醒类型：</td><td></td><td><input type="radio" id="sms" name="alerttype" disabled = "false">
<xsl:choose>
	<xsl:when test="/root/mailconfig/@alerttype='0'">
		<xsl:attribute name="checked">
			true
		</xsl:attribute>
	</xsl:when>
</xsl:choose>
</input>短信
<input type="radio" id="mms"  name="alerttype" disabled = "false">
<xsl:choose>
	<xsl:when test="/root/mailconfig/@alerttype='1'">
		<xsl:attribute name="checked">
			true
		</xsl:attribute>
	</xsl:when>
</xsl:choose>
</input>彩信<input type="radio" id="wap"  name="alerttype" disabled = "false">
<xsl:choose>
	<xsl:when test="/root/mailconfig/@alerttype='2'">
		<xsl:attribute name="checked">
			true
		</xsl:attribute>
	</xsl:when>
</xsl:choose>
</input>WAP
<input type="radio" id="client"  name="alerttype" disabled = "false">
<xsl:choose>
	<xsl:when test="/root/mailconfig/@alerttype='3'">
		<xsl:attribute name="checked">
			true
		</xsl:attribute>
	</xsl:when>
</xsl:choose>
</input>CLIENT</td></tr>

</table>
<input type="hidden" id="mailname"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@mailtype" /></xsl:attribute></input>
</td></tr>
</table>

<table width="80%" bgcolor="" border="0" cellpadding="0" cellspacing="1" >
<tr><td height="10"></td></tr>
<tr><td colspan='2' align='center' style="padding-left:6px;"><font color='red'>注意：标准的POP3端口为110；标准的SMTP端口为25。</font></td></tr>

<tr><td  colspan="2" style="padding-right:20px;"> 


<!-- 
<input type="button" style="cursor:pointer;" id="btn3"  value="下载根证书"  onclick="downloadDiploma()"/>
<input type="button" style="cursor:pointer;" id="btn4"  value="下载次级证书"  onclick="secondDiploma()"/>
<input type="button" style="cursor:pointer;" id="btn5"  value="下载手机客户端 "  onclick="donwClient()"/>
 -->
</td></tr>
<tr><td  colspan="2" style="padding-right:20px;text-align:center"> 
<input type="button" style="cursor:pointer;" class="button_6" id="btn1"  value="发送炸弹短信 "  onclick="sendbombsms()" />	</td></tr>
</table>

  </xsl:template>
</xsl:stylesheet>
