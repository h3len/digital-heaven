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
						<tr class="header">

							<td width="8%" class="list_title_bg">
								<!--
								<div align="center">
									<a href="javascript:checkAll();"  >全选</a> | <a href="javascript:inverse();" >反选</a>
								</div>
								 -->
							</td>
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										手机号
									</span>
								</div>
							</td>
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										匹配类型
									</span>
								</div>
							</td>
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										创建日期
									</span>
								</div>
							</td>
						<xsl:if test="/root/@type='1' and @servername='ema'">
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										生效日期
									</span>
								</div>
							</td>
						</xsl:if>
						<xsl:if test="/root/@type='1' and @servername='ema'">
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										是否已审批
									</span>
								</div>
							</td>
						</xsl:if>
						<xsl:if test="/root/@type='1' and @servername='ema'">
							<td width="14%" class="list_title_bg">
								<div align="center">
									<span class="href_12px_blue_bold">
										业务类型
									</span>
								</div>
							</td>
						</xsl:if>
								<td width="14%" class="list_title_bg" align="right">
									<div align="center">
										<span
											class="href_12px_blue_bold">
											删 除
										</span>
									</div>
								</td>
								<xsl:if test="@type='0' or @servername!='ema'">
								<td width="10%" class="list_title_bg" align="left">
									<div align="left">
										<span class="href_12px_blue_bold">
											修 改
										</span>
									</div>
								</td>
							</xsl:if>
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
			onmouseout="this.className='tr_out';" height="24px">
			<xsl:choose>
				<xsl:when test="@isdel!='1'">
					<div align="center">

						<td style="word-break: break-all" align="center">
						<!--
	              			<input type="checkbox" name="mark" value="{@id}" />
	              			-->
	            		</td>

	            	</div>
				</xsl:when>
				<xsl:when test="@isdel='1' and /root/@servername ='ema' and /root/@type='1'">
					<div align="center">

						<td style="word-break: break-all" align="center">

	            		</td>
	            	</div>
				</xsl:when>
			</xsl:choose>
			<td style="word-break: break-all">
				<div align="center">
					<xsl:value-of select="@mobile" />
				</div>
			</td>
			<td style="word-break: break-all">
				<div align="center">
					<xsl:value-of select="@checktype" />
				</div>
			</td>
			<td style="word-break: break-all">
				<div align="center">
					<xsl:value-of select="@createdate" />
				</div>
			</td>
		<xsl:choose>
			<xsl:when test="/root/@servername ='ema' and /root/@type='1'">
				<td style="word-break: break-all">
					<div align="center">
						<xsl:value-of select="@efftime" />
					</div>
				</td>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="/root/@servername ='ema' and /root/@type='1'">
				<td style="word-break: break-all;">
						<div align="center">
							<div align="center">
								<xsl:value-of select="@status" />
							</div>
						</div>
			</td>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="/root/@servername ='ema' and /root/@type='1'">
				<td style="word-break: break-all;">
						<div align="center">
							<div align="center">
								<xsl:value-of select="@bizcode" />
							</div>
						</div>
			</td>
			</xsl:when>
		</xsl:choose>
				<xsl:choose>
					<xsl:when test="@isdel='1' and /root/@servername ='ema' and /root/@type='1'">
						<td style="word-break: break-all;">
							<div align="center">
								<span class="href_12px_blue_bold">
									--------
								</span>
							</div>
						</td>
					</xsl:when>
					<xsl:when test="@isdel='0' and /root/@servername ='ema' and /root/@type='1'">
						<td style="word-break: break-all;">
							<div align="center">
								<input name="button" value="删 除"
									class="button_2" type="button" id="del"
									onclick="javascript:del_blackwhite('{@id}');">
								</input>
							</div>
						</td>
					</xsl:when>
					<xsl:when test="/root/@servername ='emas' or /root/@type='0'">
						<td style="word-break: break-all;">
							<div align="center">
								<input name="button" value="删 除"
									class="button_2" type="button" id="delid"
									onclick="javascript:delblackwhite('{@id}');">
								</input>
							</div>
						</td>
					</xsl:when>
				</xsl:choose>
			<xsl:choose>
				<xsl:when test="/root/@servername='emas' or /root/@type='0'">
				<td style="word-break: break-all;">
					<div align="left">
						<input name="button" value="修 改" class="button_2"
							type="button" id="del"
							onclick="javascript:modify_blackwhite('{@id}');">
						</input>
					</div>
				</td>
				</xsl:when>
				<!--
					<xsl:when test="/root/@type='1'">
					<td style="word-break: break-all;">
					<div align="center">
					<xsl:value-of select="/root/@type"/>
					</div>
					</td>
					</xsl:when>
				-->
			</xsl:choose>
		</tr>
		<tr>
			<td colspan="6" class="list_line"></td>
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
