<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<table class="table01" width="98%" cellspacing="0"
			cellpadding="2">
			<tr class="bold">

				<td width="15%">用户名</td>
				<td width="12%">登录次数</td>

			</tr>

			<xsl:apply-templates select="/root/list/data"></xsl:apply-templates>
			<tr>
				<td colspan="10" align="center" class="page">
					共
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@totalsize" />
					</font>
					条记录 共
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@totalpage" />
					</font>
					页 当前第
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@currentpage" />
					</font>
					页
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
						[ 首页 ]
					</font>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="/root/pagenumlist/pagenum" />
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
								select="/root/pagenumlist/@totalpage" />");</xsl:attribute>
						[ 末页 ]
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--应用模板结束-->
	<xsl:template match="data">
		<tr>
			<td style="text-align:center">
				<xsl:value-of select="@username" />
			</td>
			<td style="text-align:center">
				<xsl:value-of select="@count" />
			</td>


		</tr>
	</xsl:template>
	<!-- 分页模板 -->
	<xsl:template match="pagenum">
		<xsl:choose>
			<xsl:when test="@iscurrentpage='true'">
				[
				<font class="bolderred" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				]
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="@iscurrentpage='false'">
				<font class="bolder" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>