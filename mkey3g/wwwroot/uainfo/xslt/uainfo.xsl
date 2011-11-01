<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<input type="hidden" id="count" value="/root/@count" />
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<table width="100%" cellpadding="2" cellspacing="0"
						bgcolor="#ffffff">

						<tr class="list_title_bg">
							<td width="3%" class="list_title_bg">
								<div align="left"></div>
							</td>
							<td width="25%">
								<div align="left">
									<span class="blue_12_bold">
										型号
									</span>
								</div>
							</td>
							<td width="40%">
								<div align="left">
									<span class="blue_12_bold">
										GW-UA（长）
									</span>
								</div>
							</td>
							<td width="10%">
								<div align="left">
									<span class="blue_12_bold">
										分辨率
									</span>
								</div>
							</td>
							<td width="20%">
								<div align="center">
									<span class="blue_12_bold">操作</span>
								</div>
							</td>
						</tr>
						<!--应用模板开始-->
						<xsl:apply-templates select="/root/list/item"></xsl:apply-templates>
						<!--应用模板结束-->

						<tr>
							<td colspan="10" align="center"
								class="page">
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
								<font class="bolder"
									style="cursor:pointer;">
									<xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
									[ 首页 ]
								</font>
								<xsl:text> </xsl:text>
								<xsl:apply-templates
									select="/root/pagenumlist/pagenum" />
								<font class="bolder"
									style="cursor:pointer;">
									<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
											select="/root/pagenumlist/@totalpage" />");</xsl:attribute>
									[ 末页 ]
								</font>
							</td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
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

	<xsl:template match="item">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td class="list_tr">
				<div align="center">
					<img src="../theme/images/list_icon.gif" width="16"
						height="16" />
				</div>
			</td>
			<td class="hand">
				<div align="left"
					onclick="javascript:showuainfo('{@device_ua_id}')">
					<xsl:value-of select="@type_name" />
				</div>
			</td>
			<td class="hand">
				<div align="left"
					onclick="javascript:showuainfo('{@device_ua_id}')">
					<xsl:value-of select="@gw_ua_long" />
				</div>
			</td>
			<td class="hand">
				<div align="left"
					onclick="javascript:showuainfo('{@device_ua_id}')">
					<xsl:value-of select="@screensize" />
				</div>
			</td>
			<td>
				<div align="center">
					<input type="button" value="详情" class="button_2"
						onclick="javascript:showuainfo('{@device_ua_id}')" />
					<input type="button" value="修改" class="button_2"
						onclick="javascript:moduainfo('{@device_ua_id}','{@device_id}')" />
					<input type="button" value="删除" class="button_2"
						onclick="javascript:deleteuainfo('{@device_ua_id}','{@device_id}')" />
				</div>
			</td>

		</tr>
		<tr>
			<td colspan="5" class="list_line"></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
