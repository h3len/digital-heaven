<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<table class="table01" width="98%" cellspacing="0"
			cellpadding="4">
			<tr class="bold">
				<td width="70%">群组名称</td>
				<td width="30%">操作</td>
			</tr>
			<xsl:apply-templates select="/root/list/group"></xsl:apply-templates>
		</table>
	</xsl:template>
	<!--应用模板结束-->


	<xsl:template match="group">
		<tr>
			<td>
				<xsl:value-of select="@groupname" />
			</td>
			<!-- <td><xsl:value-of select="@createtime"/></td> -->
			<td>
				
				<input type="button" class="button_7" value="从该群组中删除" onclick="deluserfromgroup('{@groupid}','{@userid}')"/>
				
			</td>
		</tr>
	</xsl:template>


</xsl:stylesheet>
