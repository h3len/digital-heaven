<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">名称：</td><td><xsl:value-of select="/root/cat/@catalogname" /></td></tr>
<tr><td align="right">简称：</td><td><xsl:value-of select="/root/cat/@shortname" /></td></tr>
<tr style="display:none"><td align="right">SSOID：</td><td><xsl:value-of select="/root/cat/@ssoid" /></td></tr>
<tr><td align="right">备 注：</td><td><xsl:value-of select="/root/cat/@comment" /></td></tr>
<tr><td align="right">子部门：</td><td><xsl:value-of select="/root/cat/@childcatalogcount" />个</td></tr>
<tr><td align="right">子用户：</td><td><xsl:value-of select="/root/cat/@childusercount" />个</td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/cat/@parentid" />");GetUserList("<xsl:value-of select="/root/cat/@parentid" />");</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
