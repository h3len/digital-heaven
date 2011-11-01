<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1"><br/>
<tr><td align="right">邮箱类型：</td><td>
<select id="emailstyle" onclick="javascript:ChangeMailStyle(this.value);">
<option selected="selected" value="POP3">POP3</option>
</select>
</td></tr>
<tr><td align="right"><span id="spanServer"></span>服务器：</td><td><input type="text" id="pop3server"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pop3server" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right"><span id="spanPort"></span>端口：</td><td><input type="text" id="pop3port"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@pop3port" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">SMTP服务器：</td><td><input type="text" id="smtpserver"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpserver" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">SMTP端口：</td><td><input type="text" id="smtpport"><xsl:attribute name="value"><xsl:value-of select="/root/mailconfig/@smtpport" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">是否强制用户使用：</td><td>

<input type="radio" style="height:12px" id="enable_1" name="enable" value="1">
<xsl:if test="/root/mailconfig/@enable='true'">
<xsl:attribute name="checked"></xsl:attribute></xsl:if></input><label for="enable_1">是</label>
<input type="radio" style="height:12px" id="enable_0" name="enable" value="0">
<xsl:if test="/root/mailconfig/@enable='false'"><xsl:attribute name="checked"></xsl:attribute></xsl:if></input><label for="enable_0">否</label>

</td></tr>
<tr><td align="right" colspan="4" style="padding:10px;">
<input type="button" style="cursor:pointer;" id="btnReturnEnterpriseList" onclick="javascript:GetEnterpriseMailConfigList();" value="返回企业列表 "/>
<input type="button" style="cursor:pointer;" id="btnDeleteMailconfig" onclick="javascript:DeleteMailconfig();" value="取消邮箱绑定 "/> 
<input type="button" style="cursor:pointer;" id="btnOK" name="btnOK" onclick="javascript:UserMailconfig();" value=" 确认提交 "/>	</td></tr>

<tr><td colspan='2' align='center'><font color='red'>注意：标准的POP3端口为110；标准的SMTP端口为25。</font></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>