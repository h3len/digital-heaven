<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="root">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<table width="100%" cellpadding="2" cellspacing="0"
						bgcolor="#ffffff">
						<tr class="header list_title_bg">
							<td>
								<div align="center">注册日期</div>
							</td>
							<td>
								<div align="center">注册企业名称</div>
							</td>
							<td>
								<div align="center">注册企业数</div>
							</td>
						</tr>
						<tr>
							<td colspan="3" class="list_line">
							</td>
						</tr>
							<xsl:apply-templates select="/root/list/item_frist" />
						<xsl:apply-templates select="/root/list/item" />
					
					
						
						<xsl:apply-templates select="/root/list/final_item_end"></xsl:apply-templates>
							<xsl:apply-templates select="/root/list/item_end" />
					</table>
				</td>
			</tr>

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
	<!-- item数据模块 -->
	
	
		<xsl:template match="item_frist">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td>
				<div align="center">
					<xsl:value-of select="@time" /> 之前
				</div>
			</td>
			<td >
				<div align="center"> </div>
			</td>
			<td>
				<div align="center">
					<xsl:value-of select="@num" />
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="list_line"></td>
		</tr>
	</xsl:template>
	
	
	<xsl:template match="item">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td  rowspan="{@num}" >
				<div align="center">
					<xsl:value-of select="@time" />
				</div>
			</td>
			<td >
				<div align="center">
					<xsl:value-of select="./enterprise_frist" />
				</div>
			</td>
			<td rowspan="{@num}">
				<div align="center">
					<xsl:value-of select="@finalnum" />
				</div>
			</td>
		</tr>
		<xsl:apply-templates select=".//enterprise" />
		<tr>
			<td colspan="3" class="list_line"></td>
		</tr>
	</xsl:template>
	
<xsl:template match="final_item_end">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td>
				<div align="center">
					<xsl:value-of select="@time" /> 之后
				</div>
			</td>
			<td >
				<div align="center"> </div>
			</td>
			<td>
				<div align="center">
					<xsl:value-of select="@num" />
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="list_line"></td>
		</tr>
	</xsl:template>
	
	
	<xsl:template match="item_end">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td style="font-weight:900;color:blue;">
				<div align="center">
					<xsl:value-of select="@time" />总计
				</div>
			</td>
			<td >
				<div align="center"> </div>
			</td>
			<td style="font-weight:900;color:blue;">
				<div align="center">
					<xsl:value-of select="@num" />
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="list_line"></td>
		</tr>
	</xsl:template>

	<xsl:template match="enterprise">
		<tr>
			<td>
				<div align="center">
					<xsl:value-of select="." />
				</div>
			</td>
		</tr>
	</xsl:template>

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
