<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="70%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">手机类型：</td><td><input type="text" id="mobiletype" maxLength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">屏幕宽度：</td><td><input type="text" id="height" maxLength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">屏幕高度：</td><td><input type="text" id="width" maxLength="20"/><span class="star"> * </span></td></tr>
<tr><td align="right">UA：</td><td><input type="text" id="ua" maxLength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:MobileTypeCreate();" value=" 确认提交 "/> <input type="button" id="btnOK" name="btnOK" value="返回手机类型列表 "><xsl:attribute name="onclick">javascript:GetMobileTypeList(currentId);</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
