<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="root">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<table width="100%" cellpadding="2" cellspacing="0"
						bgcolor="#ffffff" >
						<tr class="header list_title_bg">
							<td>
								<div align="center">企业名称</div>
							</td>
							<xsl:apply-templates
								select="/root/titles/title" />
							<td style="font-weight:900;color:blue;"   >
								<div align="center">总计</div>
							</td>
						</tr>
						<tr>
							<td 
							class="list_line">
							</td>
						</tr>
						<xsl:apply-templates select="/root/list/item" />
					<tr onmouseover="this.className='tr_over';"
			     onmouseout="this.className='tr_out';">
			<td style="font-weight:900;color:blue;" >
				<div align="center">
					<xsl:value-of select="/root/list/usercount/@name" />
				</div>
			</td>
			<xsl:apply-templates select="/root/list/usercount/usernum" />
			<td style="font-weight:900;color:blue;" >
				<div align="center">
					<xsl:value-of select="/root/list/usercount/@sum" />
				</div>
			</td>
		</tr>
		<tr>
			<td   style="font-weight:900;color:blue;"   colspan="{/root/titles/@size}" class="list_line"></td>
		</tr>
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
						<xsl:attribute name="onclick">javascript:changeNewRegisterPage("1");</xsl:attribute>
						[ 首页 ]
					</font>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="/root/pagenumlist/pagenum" />
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:changeNewRegisterPage("<xsl:value-of
								select="/root/pagenumlist/@totalpage" />");</xsl:attribute>
						[ 末页 ]
					</font>
				</td>
			</tr>

		</table>
	</xsl:template>
	<!-- item数据模块 -->
	<xsl:template match="item">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td>
				<div align="center">
					<xsl:value-of select="@name" />
				</div>
			</td>
			<xsl:apply-templates select=".//num" />
			<td  style="font-weight:900;color:blue;" >
				<div align="center">
					<xsl:value-of select="@sum" />
				</div>
			</td>
		</tr>
		<tr>
			<td    style="font-weight:900;color:blue;"    colspan="{/root/titles/@size}" class="list_line"></td>
		</tr>
	</xsl:template>

	<xsl:template match="num">
		<td>
			<div align="center">
				<xsl:choose>
					<xsl:when test="@id">
						<a href="javascript:shows('{@id}','{@starttime}','{@endtime}','{.}','{@name}');">
							<xsl:value-of select="." />
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</td>
	</xsl:template>
	
	<xsl:template match="usernum">
		<td style="font-weight:900;color:blue;" >
			<div align="center">
				<xsl:choose>
					<xsl:when test="@id">
						<a href="javascript:shows('{@id}','{@starttime}','{@endtime}','{.}','{@name}');">
							<xsl:value-of select="." />
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</td>
	</xsl:template>



	<xsl:template match="title">
		<td>
			<div align="center">
				<xsl:value-of select="." />
			</div>
		</td>
	</xsl:template>

	<xsl:template match="pagenum">
		<xsl:choose>
			<xsl:when test="@iscurrentpage='true'">
				[
				<font class="bolderred" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:changeNewRegisterPage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				]
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="@iscurrentpage='false'">
				<font class="bolder" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:changeNewRegisterPage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
