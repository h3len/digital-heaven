<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">群组名称(限20字)：</td><td><input type="text" id="groupname" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">备 注(限20字)：</td><td><textarea id="description"></textarea><span class="star"> </span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:GroupCreate();" value=" 确认提交 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回群组列表 "><xsl:attribute name="onclick">javascript:GetGroupList();</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
