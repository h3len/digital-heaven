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
									<input type="text" id="catalogname"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@catalogname" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr style="display:none">
								<td align="right">简称：</td>
								<td>
									<input type="text" id="shortname"
										maxlength="10">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@shortname" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">企业简称：</td>
								<td>
									<input type="text"
										id="enterprisecode" maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@enterprisecode" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">corpId：</td>
								<td>
									<input type="text" id="ssoid"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@ssoid" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">ProductID：</td>
								<td>
									<input type="text" id="productid"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@productid" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">license：</td>
								<td>
									<input type="text" id="license"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@license" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">企业密码：</td>
								<td>
									<input type="password" id="password"
										maxlength="20" />
									<span class="star">*不需要修改则不输入</span>
								</td>
							</tr>
							<tr>
								<td align="right">联系方式：</td>
								<td>
									<input type="text" id="mobile"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@mobile" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">企业地址：</td>
								<td>
									<input type="text" id="address"
										maxlength="20">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@address" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td align="right">备 注(40字内)：</td>
								<td>
									<textarea id="commententerprise1"
										maxlength="1000">
										<xsl:value-of
											select="/root/cat/@comment" />
									</textarea>
									<span class="star"></span>
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
							<input type="checkbox" id="enablesso"
								onclick="javascript:EnableSSO();" />
							<label for="enablesso">是否启用SSO</label>
						</legend>
						<table width="100%">
							<tr>
								<td align="right" width="30%">
									sso类型：
								</td>
								<td>
									<select id="ssotype">
										<option value="dhmi">
											DHMI
										</option>
										<option value="si">
											IBM ADC平台
										</option>
										<option value="sihw">
											华为 ADC平台
										</option>
										<option value="ldap">
											LDAP鉴权
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td align="right">sso地址：</td>
								<td>
									<input type="text" id="ssourl">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@ssourl" />
										</xsl:attribute>
									</input>
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
									<input type="text" id="extnumber">
										<xsl:attribute name="value"><xsl:value-of
												select="/root/cat/@extnumber" />
										</xsl:attribute>
									</input>
								</td>
							</tr>
						</table>
					</fieldset>

				</td>
			</tr>
			<tr>
				<td align="right" colspan="4">
					<input type="button" id="btnOK" name="btnOK"
						value=" 确认提交 ">
						<xsl:attribute name="onclick">javascript:EnterpriseModifyInfo("<xsl:value-of
								select="/root/cat/@id" />");</xsl:attribute>
					</input>
					<input type="button"
						onclick="javascript:CatalogShow(currentCatalogId);"
						value=" 返回浏览部门信息 " />
					<input type="button" id="btnOK" name="btnOK"
						value=" 返回部门列表 ">
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
