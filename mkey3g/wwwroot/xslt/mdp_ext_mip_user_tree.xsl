<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/list">
  	  <table width="100%" align="center">  				
		<tr class="header">
			<td width="30%">用户名</td>
			<td width="30%">OA ID</td>
			<td width="40%">操作</td>
		</tr>
		<xsl:apply-templates select="item"/>		
	  </table>
	 
 </xsl:template>
 <xsl:template match="item">
 	<tr>
 		<td width="30%"><a href="javascript:view('{@id}')"><xsl:value-of select="@oauser"/></a></td>
 		<td width="30%"><xsl:value-of select="@oaid"/></td>
 		<td width="40%"><input type="button"  class="button"  value="修改" onclick="loadUpdateWin('{@id}')"/><input type="button"  class="button"  value="删除" onclick="del('{@id}')"/></td> 		
 	</tr>
 </xsl:template>
</xsl:stylesheet>
