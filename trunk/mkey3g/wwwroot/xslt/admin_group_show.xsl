<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">群组名称：</td><td><xsl:value-of select="/root/item/@groupname" /></td></tr>
<tr><td align="right">备 注：</td><td><xsl:value-of select="/root/item/@description" /></td></tr>
<tr><td align="right" colspan="4">
<xsl:if test="/root/@hasGroupPermission = 'true'">
<input type="button" id="btnOK" name="btnOK" value="修改群组信息 "><xsl:attribute name="onclick">javascript:LoadGroupModify("<xsl:value-of select="/root/item/@id" />");</xsl:attribute></input> 
</xsl:if>
<input type="button" id="btnOK" name="btnOK" value="返回群组列表 "><xsl:attribute name="onclick">javascript:GetGroupList();</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
