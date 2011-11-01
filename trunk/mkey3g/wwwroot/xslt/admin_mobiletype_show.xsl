<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="90%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">手机类型：</td><td><xsl:value-of select="/root/item/@mobiletype"/></td></tr>
<tr><td align="right">屏幕宽度：</td><td><xsl:value-of select="/root/item/@width"/></td></tr>
<tr><td align="right">屏幕高度：</td><td><xsl:value-of select="/root/item/@height"/></td></tr>
<tr><td align="right">UA：</td><td><xsl:value-of select="/root/item/@ua"/></td></tr>
<tr><td align="right" colspan="4">
	<input type="button" id="btnOK" name="btnOK" onclick="javascript:LoadMobileTypeModify();" value="修改手机类型信息 "/>
	<input type="button" onclick="javascript:GetMobileTypeList();" value="返回手机类型列表 "></input>
	 </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
