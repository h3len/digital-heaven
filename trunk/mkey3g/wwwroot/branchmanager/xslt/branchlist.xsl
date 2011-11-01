<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<table class="text_align_center" width="98%" cellspacing="0"
			cellpadding="4">
			<tr class="list_title_bg">
				<td width="50%">部门名称</td>
				<td width="48%">操作</td>
			</tr>

			<xsl:apply-templates select="/root/branch"></xsl:apply-templates>
			<tr>
				<td colspan="5" align="center" class="page">
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

	<xsl:template match="branch">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';" height="24px">
			<td>
				<a href="#" onclick="showbranch('{@id}')">
					<xsl:value-of select="@branchname" />
				</a>
			</td>
			<td>
				<input type="button" class="button_2" value="修改"
					onclick="modbranch('{@id}')" />
				<xsl:if test="@candel='1'">
					<input type="button" class="button_2" value="删除"
						onclick="delbranch('{@id}')" />
				</xsl:if>

				<input type="button" class="button_2" value="详情"
					onclick="showbranch('{@id}')" />
			</td>
		</tr>
		<tr>
			<td colspan="2" class="list_line"></td>
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