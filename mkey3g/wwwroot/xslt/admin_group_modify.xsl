<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">群组名称(限20字)：</td><td><input type="text" id="groupname" maxlength="20"><xsl:attribute name="value"><xsl:value-of select="/root/item/@groupname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">备 注(限20字)：</td><td><textarea id="description"  onkeydown="textmaxlentgh()"><xsl:value-of select="/root/item/@description" /></textarea><span class="star"> </span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" value=" 确认提交 "><xsl:attribute name="onclick">javascript:GroupModify("<xsl:value-of select="/root/item/@id" />");</xsl:attribute></input> <input type="button" onclick="javascript:GroupShow(currentGroupId);" value=" 返回浏览群组信息 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回群组列表 "><xsl:attribute name="onclick">javascript:GetGroupList();</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
</xsl:template>
</xsl:stylesheet>
