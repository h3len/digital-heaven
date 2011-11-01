<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="root">
		<table width="100%" align="center" bgcolor="" border="0"
			cellpadding="0" cellspacing="1"
			background="../images/center_bg.jpg">
			<br />
			<tr>
				<td align="right"></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="2">
					<fieldset>
						<legend>集团基本信息</legend>
						<table width="100%">
							<tr>
								<td align="right" width="30%">名称：</td>
								<td>
									<xsl:value-of select="/root/cat/@catalogname" />
								</td>
							</tr>
							<tr style="display:none">
								<td align="right">简称：</td>
								<td>
									<xsl:value-of select="/root/cat/@shortname" />
								</td>
							</tr>
							<tr>
								<td align="right">企业简称：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@enterprisecode" />
								</td>
							</tr>
							<tr>
								<td align="right">corpId：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@ssoid" />
								</td>
							</tr>
							<tr>
								<td align="right">ProductID：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@productid" />
								</td>
							</tr>
														<tr>
								<td align="right">license：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@license" />
								</td>
							</tr>
							<tr>
								<td align="right">联系方式：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@mobile" />
								</td>
							</tr>
							<tr>
								<td align="right">公司地址：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@address" />
								</td>
							</tr>
							<tr>
								<td align="right">备 注：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@comment" />
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<fieldset style="display:none">
						<legend>
							<xsl:choose>
								<xsl:when
									test="/root/cat/@enablesso= 'true'">
									已启用SSO
								</xsl:when>
								<xsl:when
									test="/root/cat/@enablesso= 'false'">
									未启用SSO
								</xsl:when>
							</xsl:choose>
						</legend>
						<table width="100%">
							<tr>
								<td align="right" width="30%">
									sso类型：
								</td>
								<td>
									<xsl:value-of
										select="/root/cat/@ssotype" />
								</td>
							</tr>
							<tr>
								<td align="right">sso地址：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@ssourl" />
								</td>
							</tr>
						</table>
					</fieldset>

				</td>
			</tr>

			<tr>
				<td colspan="2">
					<fieldset style="display:none">
						<legend>WAG配置</legend>
						<table width="100%">
							<tr>
								<td align="right" width="30%">扩展号码：</td>
								<td>
									<xsl:value-of
										select="/root/cat/@extnumber" />
								</td>
							</tr>
						</table>
					</fieldset>

				</td>
			</tr>
			<tr>
				<td align="right">子部门：</td>
				<td>
					<xsl:value-of select="/root/cat/@childcatalogcount" />
					个
				</td>
			</tr>
			<tr>
				<td align="right">子用户：</td>
				<td>
					<xsl:value-of select="/root/cat/@childusercount" />
					个
				</td>
			</tr>
			<tr>
				<td align="right" colspan="4">
					<input type="button" id="btnOK" name="btnOK"
						value=" 修改集团信息 ">
						<xsl:attribute name="onclick">javascript:LoadCatalogModifyInfo("<xsl:value-of
								select="/root/cat/@id" />");</xsl:attribute>
					</input>
					<input type="button" id="btnOK" name="btnOK"
						value=" 返回集团列表 ">
						<xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of
								select="/root/cat/@parentid" />");GetUserList("<xsl:value-of
								select="/root/cat/@parentid" />");</xsl:attribute>
					</input>
				</td>
			</tr>


			<tr>
				<td align="right"></td>
				<td></td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
