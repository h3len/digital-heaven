<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">名称：</td><td><input type="text" id="catalogname" chname="部门名称" notempty="true" maxlength="20" style="width:200px"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@catalogname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right" width="30%">简称：</td><td><input type="text" id="shortname" chname="简称" maxlength="10" style="width:200px"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@shortname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr style="display:none"><td align="right" width="30%">ssoid：</td><td><input type="text" id="ssoid" chname="SSOID" maxlength="20" style="width:200px"><xsl:attribute name="value"><xsl:value-of select="/root/cat/@ssoid" /></xsl:attribute></input></td></tr>
<tr><td align="right">备 注(40字内)：</td><td><textarea id="commentbranch1" style="width:200px"><xsl:value-of select="/root/cat/@comment" /></textarea><span class="star"> </span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" value=" 确认提交 "><xsl:attribute name="onclick">javascript:CatalogModifyInfo("<xsl:value-of select="/root/cat/@id" />");</xsl:attribute></input> <input type="button" onclick="javascript:CatalogShow(currentCatalogId);" value=" 返回浏览部门信息 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/cat/@parentid" />");GetUserList("<xsl:value-of select="/root/cat/@parentid" />");</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
