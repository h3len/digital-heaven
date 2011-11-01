<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr>
<td colspan="2">
<fieldset>
<legend>集团基本信息</legend>
<table width="100%">
<tr><td align="right" width="30%">名称：</td><td><input type="text" id="catalogname"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@catalogname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">简称：</td><td><input type="text" id="shortname"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@shortname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">企业代码：</td><td><input type="text" id="enterprisecode"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@enterprisecode" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">企业密码：</td><td><input type="password" id="password"/><span class="star"> *</span></td></tr>
<tr><td align="right">备 注(40字内)：</td><td><textarea id="comment" ><xsl:value-of select="/root/cat/@comment" /></textarea><span class="star"> </span></td></tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td colspan="2">
<fieldset>
<legend><input type="checkbox" id="enablesso" onclick="javascript:EnableSSO();" /> <label for="enablesso">是否启用SSO</label></legend>
<table width="100%">
<tr><td align="right" width="30%">sso类型：</td><td>
<select id="ssotype">
<option value="dhmi">DHMI</option>
<option value="si">IBM ADC平台</option>
<option value="sihw">华为 ADC平台</option>
<option value="ldap">LDAP鉴权</option>
</select></td></tr>
<tr><td align="right">sso地址：</td><td><input type="text" id="ssourl"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@ssourl" /></xsl:attribute></input></td></tr>
</table>
</fieldset>
</td>
</tr>

<tr>
<td colspan="2">
<fieldset>
<legend>WAG配置</legend>
<table width="100%">
<tr><td align="right" width="30%">扩展号码：</td><td><input type="text" id="extnumber"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@extnumber" /></xsl:attribute></input></td></tr>
</table>
</fieldset>
</td>
</tr>

<xsl:if test="/root/cat/@hasMipFile = 'true'">
<tr>
<td colspan="2">
<fieldset>
<legend>手机硬盘配置</legend>
<table width="100%">
<tr><td align="right" width="30%">公共区限额：</td><td><input type="text" id="branchdisksize"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@branchdisksize" /></xsl:attribute></input>(注：-1表示不受限制)</td></tr>
<tr><td align="right">用户个人区限额：</td><td><input type="text" id="persondisksize"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@persondisksize" /></xsl:attribute></input>(注：-1表示不受限制)</td></tr>
</table>
</fieldset>
</td>
</tr>
</xsl:if>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" value=" 确认提交 "><xsl:attribute name="onclick">javascript:EnterpriseModifyInfo("<xsl:value-of select="/root/cat/@id" />");</xsl:attribute></input></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
