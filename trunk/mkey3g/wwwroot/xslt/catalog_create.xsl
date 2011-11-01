<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">名称：</td><td><input type="text" id="catalogname" maxlength="20" chname="部门名称" notempty="true" size="30" style="width:200px"/><span class="star"> *</span></td></tr>
<tr><td align="right">简称：</td><td><input type="text" id="shortname" size="20" chname="简称" maxlength="10" style="width:200px"/><span class="star"> *</span></td></tr>
<tr style="display:none"><td align="right">ssoid：</td><td ><input type="text"  id="ssoid" size="20" chname="SSOID" maxlength="30"/></td></tr>
<tr><td align="right">备 注(限40字符)：</td><td><textarea id="commentbranch" style="width:200px"></textarea><span class="star"> </span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:CatalogCreate();" value=" 确认提交 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/cat/@parentid" />");GetUserList("<xsl:value-of select="/root/cat/@parentid" />");</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
