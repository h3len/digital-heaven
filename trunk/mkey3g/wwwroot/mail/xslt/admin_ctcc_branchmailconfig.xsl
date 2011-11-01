<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/root">
	<table width="100%" cellpadding="0" cellspacing="0">

<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	<tr class="list_title_bg">
		<td width="3%" class="list_title_bg">
			<div align="center"></div>
		</td>
		<td width="30%"><div align="center"><span class="blue_12_bold">集团名称</span></div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/list/item"></xsl:apply-templates>         
      <!--应用模板结束-->
</table>
</td></tr>
</table>
   </xsl:template>
   
		<xsl:template match="item">
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
	<td class="list_tr">
				<div align="center">
					<img src="../theme/images/list_icon.gif" width="16"
						height="16" />
				</div>
			</td>
				<td class="hand"><div align="left" onclick="javascript:mailconfig('{@enterprise}')"><xsl:value-of select="@branchname" /></div></td>
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
