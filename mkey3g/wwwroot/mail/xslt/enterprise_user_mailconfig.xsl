<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="root">
		<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
			<xsl:if test="/root/mailconfig/@errdesc">
				<tr>
					<td>
						<font color='red'>
							邮箱配置出错：
							<xsl:value-of
								select="/root/mailconfig/@errdesc">
							</xsl:value-of>
						</font>
					</td>
				</tr>
			 </xsl:if>
		</table>
		<table align="center" width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
			<input type="hidden" id="enemailstyle">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@enemailstyle" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="errdesc"></input>
			<input type="hidden" id="enpop3port">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@enpop3port" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="ensmtpport">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@ensmtpport" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="enpop3server">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@enpop3server" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="ensmtpserver">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@ensmtpserver" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="endominoaddress">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@endominoaddress" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="endominomaildomain">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/enterprisemail/@endominomaildomain" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="emailstylenew">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/mailconfig/@emailstylenew" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="enable">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/mailconfig/@enable" />
				</xsl:attribute>
			</input>
			<input type="hidden" id="alerttype">
				<xsl:attribute name="value"><xsl:value-of
						select="/root/mailconfig/@alerttype" />
				</xsl:attribute>
			</input>
			<tr style="display:none">
				<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="25%" height="24">快捷配置：</td>
				<td>
					<select id="outemailstyle"
						onchange="javascript:ChangeOutemailStyle()" class="input_180px"
						style="height:20px">

						<option id="self" value="self">
							自定义邮箱
						</option>
						<option id="enterprise"
							value="enterprise">
							本单位邮箱
						</option>
						<option id="sina" value="sina">新浪</option>
						<option id="163" value="163">网易</option>
						<option id="sohu" value="sohu">搜狐</option>
					</select>
				</td>
			</tr>

			<tr>
				<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="25%">邮箱地址：</td>
				<td>
					<input type="text" id="email" maxlength="50"
						class="input_text input_180px"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="checkmailstyle()"
						onmouseout="fEvent('mouseout',this)">
						<xsl:attribute name="value"><xsl:value-of
								select="/root/mailconfig/@email" />
						</xsl:attribute>
					</input>
					<span class="star">*</span>
				</td>
			</tr>
			<tr style="display:none">
				<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="25%">邮箱账号：</td>
				<td>
					<input type="text" id="username" maxlength="50"
						class="input_text input_180px"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
						onmouseout="fEvent('mouseout',this)">
						<xsl:attribute name="value"><xsl:value-of
								select="/root/mailconfig/@username" />
						</xsl:attribute>
					</input>
					<span class="star">*</span>
				</td>
			</tr>
			<tr>
				<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="25%">邮箱密码：</td>
				<td>
					<input type="password" id="mailpassword"
						maxlength="50" class="input_text input_180px"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
						onmouseout="fEvent('mouseout',this)">
						<xsl:attribute name="value"><xsl:value-of
								select="/root/mailconfig/@password" />
						</xsl:attribute>
					</input>
					<span class="star">*</span>
				</td>
			</tr>
			<tr>
				<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="25%" height="24">邮箱类型：</td>
				<td>
					<!-- 
						<input type="text" id="emailstyle" readonly="true" value="POP3" class="input_180px"  />
					-->
					<select id="emailstyle" class="input_180px"
						onclick="javascript:ChangeMailStyle(this.value);"
						style="height:20px">
						<option value="POP3">POP3</option>
						<option value="DOMINO">DOMINO</option>
						<option value="Exchange">Exchange 2003</option>
						<option value="Exchange2007">Exchange 2007</option>
						<option value="IMAP">IMAP4</option>
					</select>

				</td>
			</tr>
		</table>

		<table width="100%" bgcolor="" border="0" cellpadding="0"
			cellspacing="1">
			<tr>
				<td>

					<!--checkbox_div1-->
					<div id="checkbox_div1" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">POP3服务器：</td>
								<td>
									<input type="text" id="pop3server"
										class="input_text input_180px" maxlength="50"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value" maxlength="50">
											<xsl:value-of select="/root/mailconfig/@pop3server" />
										</xsl:attribute>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">POP3端口：</td>
								<td>
									<input type="text" id="pop3port"
										maxlength="50" class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										value="110"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if
											test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@pop3port" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">SMTP服务器：</td>
								<td>
									<input type="text" id="smtpserver"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@smtpserver" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">SMTP端口：</td>
								<td>
									<input type="text" id="smtpport"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										value="25"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@smtpport" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
					<!--checkbox_div1-->

					<!--checkbox_div5-->
					<div id="checkbox_div5" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">IMAP服务器：</td>
								<td>
									<input type="text" id="imapserver"
										class="input_text input_180px" maxlength="50"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value" maxlength="50">
											<xsl:value-of select="/root/mailconfig/@imapserver" />
										</xsl:attribute>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">IMAP端口：</td>
								<td>
									<input type="text" id="imapport"
										maxlength="50" class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										value="110"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@imapport" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">SMTP服务器：</td>
								<td>
									<input type="text" id="smtpserverforimap"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@smtpserverforimap" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">SMTP端口：</td>
								<td>
									<input type="text" id="smtpportforimap"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										value="25"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@smtpportforimap" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
					<!--checkbox_div5-->

					<!--checkbox_div2-->
					<div id="checkbox_div2" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">OWA地址：</td>
								<td>
									<input type="text" id="owa"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if	test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@owa" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>

							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">邮件域：</td>
								<td>
									<input type="text" id="maildomain2"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@maildomain2" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
					<!--checkbox_div2-->


					<!--checkbox_div3-->
					<div id="checkbox_div3" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">服务器地址：</td>
								<td>
									<input type="text" id="pushmailip3"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@pushmailip3" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>

							<tr style="display:none">
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">邮件域：</td>
								<td>
									<input type="text"
										id="pushmaildomain3" class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)">
										<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute name="onchange">
												changeSelectboxValue()
											</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@pushmaildomain3" />
										</xsl:attribute>
									</input>
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
					
					<!--checkbox_div4-->
				<div id="checkbox_div4" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">webservice地址：</td>
							<td>
								<input type="text" id="exchangeServer"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" readonly="readonly">
									<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if
											test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute
												name="onchange">
changeSelectboxValue()
</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@exchangeServer" />
										</xsl:attribute>	
								</input>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">邮件域：</td>
							<td>
								<input type="text" id="pushmaildomain4"
									 class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)">
								<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if
											test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute
												name="onchange">
changeSelectboxValue()
</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@pushmaildomain4" />
										</xsl:attribute>		
									
								</input>
								<span class="star">*</span>
							</td>
						</tr>
						<tr style="display:none;">
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">服务器主机地址：</td>
							<td>
								<input type="text" id="exchangeHost"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)">
								<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if
											test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute
												name="onchange">
changeSelectboxValue()
</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@exchangeHost" />
										</xsl:attribute>		
								</input>
								<span class="star">*</span>
							</td>
						</tr>
						<tr style="display:none;">
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">Exchange端口：</td>
							<td>
								<input type="text" id="exchangePort"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)">
									<xsl:if
											test="/root/mailconfig/@enable = 'true'">
											<xsl:attribute
												name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if
											test="/root/mailconfig/@enable = 'false'">
											<xsl:attribute
												name="onchange">
changeSelectboxValue()
</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of
												select="/root/mailconfig/@exchangePort" />
										</xsl:attribute>	
								</input>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div4-->

					<!--checkbox_div3-->
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">
								手机号码：
							</td>
							<td  align="left">
								<xsl:value-of
									select="/root/mailconfig/@mobile" />
								<input type="hidden" id="phonenum"
									value="{/root/mailconfig/@mobile}" />
							</td>
						</tr>
						<tr>
							<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">
								提醒类型：
							</td>
							<td >
								<input type="radio" id="sms"
									name="alerttype">
									<xsl:choose>
										<xsl:when
											test="/root/mailconfig/@alerttype='0'">
											<xsl:attribute
												name="checked">
												true
									</xsl:attribute>
										</xsl:when>
									</xsl:choose>
								</input>
								短信
								<input type="radio" id="mms"
									name="alerttype">
									<xsl:choose>
										<xsl:when
											test="/root/mailconfig/@alerttype='1'">
											<xsl:attribute
												name="checked">
			true
		</xsl:attribute>
										</xsl:when>
									</xsl:choose>
								</input>
								彩信
								<input type="radio" id="wap"
									name="alerttype">
									<xsl:choose>
										<xsl:when
											test="/root/mailconfig/@alerttype='2'">
											<xsl:attribute
												name="checked">
			true
		</xsl:attribute>
										</xsl:when>
									</xsl:choose>
								</input>
								WAP
								<input type="radio" id="client"
									name="alerttype">
									<xsl:choose>
										<xsl:when
											test="/root/mailconfig/@alerttype='3'">
											<xsl:attribute
												name="checked">
			true
		</xsl:attribute>
										</xsl:when>
									</xsl:choose>
								</input>
								CLIENT
							</td>
						</tr>

					</table>
					<input type="hidden" id="mailname">
						<xsl:attribute name="value"><xsl:value-of
								select="/root/mailconfig/@mailtype" />
						</xsl:attribute>
					</input>
				</td>
			</tr>
		</table>

		<table width="100%" bgcolor="" border="0" cellpadding="0"
			cellspacing="1">
			<tr>
				<td height="10"></td>
			</tr>
			<tr>
				<td colspan='2'>
					<font color='red'>
						注意：标准的POP3端口为110、标准的SMTP端口为25，系统不支持要求安全连接(SSL)访问的邮件地址！Exchange 2007密码长度最大是14位！
					</font>
				</td>
			</tr>

			<tr>
				<td colspan="2" style="padding-right:20px;">


					<!-- 
						<input type="button" style="cursor:pointer;" id="btn3"  value="下载根证书"  onclick="downloadDiploma()"/>
						<input type="button" style="cursor:pointer;" id="btn4"  value="下载次级证书"  onclick="secondDiploma()"/>
						<input type="button" style="cursor:pointer;" id="btn5"  value="下载手机客户端 "  onclick="donwClient()"/>
					-->
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-left:150px;">
					<input type="button" class="button_6"
						style="cursor:pointer;" id="btnDeleteMailconfig"
						onclick="javascript:DeleteMailconfig();" value="取消邮箱绑定 " />
					<input type="button" class="button_4"
						style="cursor:pointer;" id="btnOK" name="btnOK"
						onclick="javascript:UserMailconfig();" value=" 确认提交 " />
				</td>
			</tr>
		</table>

	</xsl:template>
</xsl:stylesheet>