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
							<td width="20%">
								<div align="center">运营商</div>
							</td>
							<td width="20%">
								<div align="center">路由方式</div>
							</td>
							<td width="40%">
								<div align="center">路由内容</div>
							</td>
							<td >
								<div align="center">路由操作</div>
							</td>
						</tr>
						<tr>
							<td colspan="9" class="list_line"></td>
						</tr>
						<xsl:apply-templates select="/root/list/item" />
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
	<xsl:template match="item">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td >
				<div align="center">
					<xsl:value-of select="@operator" />
				</div>
			</td>
			<td >
				<div align="center">
					<xsl:value-of select="@typename" />
				</div>
			</td>
			<td style="word-break: break-all">
				<div align="center">
					<xsl:value-of select="@regular" />
				</div>
			</td>
			<td style="word-break: break-all">
				<div align="center">
					<input name="button" class="button_2" value="修改"
						type="button" id="mod"
						onclick="javascript:updata_mobiletype('{@id}');">
					</input>
					<xsl:choose>
						<xsl:when test="@type=1">
							<input name="button" class="button_2"
								value="删除" type="button" id="del"
								onclick="javascript:delete_mobiletype('{@id}');" />
							<xsl:text> </xsl:text>
						</xsl:when>
						<xsl:when test="@type=0">
							<input name="button" class="button_2"
								value="删除" type="button" id="del" style="display:none" />
							<xsl:text> </xsl:text>
						</xsl:when>
					</xsl:choose>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="9" class="list_line"></td>
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
