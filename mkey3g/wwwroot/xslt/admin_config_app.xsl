<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="root">
	<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	<tr class="list_title_bg">
		<td width="3%" class="list_title_bg">
			<div align="left"></div>
		</td>
		<td width="33%"><div align="center"><span class="blue_12_bold">插件名称</span></div></td>
		<td width="33%"><div align="center"><span class="blue_12_bold">业务系统ID</span></div></td>
		<td width="33%"><div align="center"><span class="blue_12_bold">操作</span></div></td>
		</tr>
		<xsl:apply-templates select="/root/list/item"></xsl:apply-templates>
</table>
</td></tr>
</table>
   </xsl:template>
		<xsl:template match="item">
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
	<td class="list_tr">
			</td>
			<td><div align="center"><xsl:value-of select="@plugin" /></div></td>
				<td><div align="center"><xsl:value-of select="@appcode" /></div></td>
		   <td><div align="center">
				<input type="button" value="修改"  class="button_2" onclick="javascript:modpluginapp('{@id}','{@plugin}','{@appcode}')"/>
				<input type="button" value="删除"  class="button_2" onclick="javascript:delpluginapp('{@id}')"/>
			</div></td>
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
