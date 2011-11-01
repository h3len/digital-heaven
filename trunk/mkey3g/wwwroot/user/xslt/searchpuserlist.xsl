<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<div id="mainbox">
			<div class="center_list_box">
				<div class="center_list">
					<table width="98%" cellspacing="0"
						cellpadding="4">
						<tr class="list_title_bg">
							<td width="15%">姓名</td>
							<td width="15%">手机号</td>
							<td style="display:none;" width="15%">公司电话</td>
							<td style="display:none;" width="15%">家庭电话</td>
							<td style="display:none;" width="15%">家庭住址</td>
							<td align="center" width="25%">操作</td>
						</tr>

						<xsl:apply-templates select="/root/user"></xsl:apply-templates>
						<tr>
							<td colspan="6" align="center"
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
				</div>
			</div>
		</div>
	</xsl:template>
	<!--应用模板结束-->


	<xsl:template match="user">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';" height="24px">
			<td style="word-break:break-all">
				<a href="#" onclick="showuser('{@id}')">
					<xsl:value-of select="@username" />
				</a>
			</td>
			<td style="word-break:break-all">
				<xsl:value-of select="@mobile" /><xsl:text > </xsl:text>
				<xsl:if test="@ucEnable='true'">
					<a href="#" onclick="GB_showCenter('拨打电话', '../user/callOnly.jsp?mobile={@mobile}',550,878);"><img src="../images/list_call.gif" /></a>
				</xsl:if>
			</td>
			<td style="word-break:break-all;display:none;">
				<xsl:value-of select="@comtel" />
			</td>
			<td style="word-break:break-all;display:none;">
				<xsl:value-of select="@hometel" />
			</td>
			<td  style="word-break:break-all;display:none;">
				<xsl:value-of select="@city" />
			</td>
			<td align="center" style="word-break:break-all">
				<input type="button" class="button_2" value="详情"
					onclick="showuser('{@id}')" />
				<input type="button" class="button_2" value="修改"
					onclick="moduser('{@id}')" />
			</td>
		</tr>
		<tr>
			<td colspan="6" class="list_line" style="word-break:break-all"></td>
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
