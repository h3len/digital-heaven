<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:template match="/root">
	<input type="hidden" id="count" value="/root/@count"/>
	<table width="100%" cellpadding="0" cellspacing="0">
	
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	<tr>
		<td width="5%" class="list_title_bg"><div align="center"></div></td>
		<td width="20%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">业务系统名称</span></div></td>
		<td width="15%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">业务系统ID</span></div></td>
		<td width="15%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">域名</span></div></td>
		<td width="10%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">序列号</span></div></td>
		<xsl:if test="@enableMutiEnterpriseRoot = '1'">
			<td width="15%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">有效期</span></div></td>
		</xsl:if>		
		<td width="35%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">操作</span></div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/item"></xsl:apply-templates>         
      <!--应用模板结束-->
      
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>    
	</td>
</tr>
</table>

</td></tr>
</table>
</xsl:template>
   
   <!-- 分页模板 -->   
 <xsl:template match="pagenum">  
  <xsl:choose>
  	<xsl:when test="@iscurrentpage='true'">
  	[<font class="bolderred" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute><xsl:value-of select="@page" /></font>]<xsl:text> </xsl:text>
  	</xsl:when>
    <xsl:when test="@iscurrentpage='false'">
  	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute><xsl:value-of select="@page" /></font><xsl:text> </xsl:text>
  	</xsl:when>
  </xsl:choose> 
  </xsl:template>
   
		<xsl:template match="item">
		<!-- CLOUD-71 应用关闭后,企业管理员页面/系统管理员页面不应该再显示已关闭的应用 -->
		<xsl:choose>
			<xsl:when
				test="@runenable = '3'">
			</xsl:when>
			<xsl:otherwise>
			<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
	<td class="list_tr" style="word-break:break-all"><div align="center"><img src="../skin/default/images/icon_run.gif" width="14" height="14" >
											<xsl:choose>
												<xsl:when
													test="@runenable = '0' and @online = '0'">
													<xsl:attribute name="src">../skin/default/images/icon_run.gif </xsl:attribute>
												</xsl:when>
												<xsl:when
													test="@online = '0' and @runenable!='0'">
													<xsl:attribute name="src">../skin/default/images/listicon_pause.gif </xsl:attribute>
												</xsl:when>
												<xsl:when
													test="@online = '1'">
													<xsl:attribute name="src">../skin/default/images/icon_pause.gif</xsl:attribute>
												</xsl:when>
											</xsl:choose>
			
			</img></div></td>
			<td><div align="center">
				<xsl:value-of select="@appname" /></div>
			</td>
			<td><div align="center">
				<xsl:value-of select="@appcode" /></div>
			</td>
			<td><div align="center">
				<xsl:value-of select="@nickname" /></div>
			</td>
			<td><div align="center">
				<xsl:value-of select="@cdk" /></div>
			</td>
			<xsl:if test="@enableMutiEnterprise = '1'">
				<td><div align="center">
					<xsl:choose>
						<xsl:when test="@period = '已过期'">
							<font color="red">
								<xsl:value-of select="@period" />		
							</font>		
						</xsl:when>
						<xsl:otherwise>
							<font color="green">
								<xsl:value-of select="@period" />		
							</font>
						</xsl:otherwise>
					</xsl:choose>
				</div></td>
			</xsl:if>
		   <td><div align="center">
	   					<xsl:choose>
	   						<xsl:when test="@canofficail = '0'">
	   							<input type="button" class="button_2" onclick="javascript:apponline(this,'{@appid}')">
			   					<xsl:choose>
									<xsl:when
										test="@online = '1'">
										<xsl:attribute name="value">下线</xsl:attribute>
										<xsl:attribute name="disabled" >disabled</xsl:attribute>
									</xsl:when>
									<xsl:when
										test="@online = '0'">
										<xsl:attribute name="value">下线</xsl:attribute>
									</xsl:when>
								</xsl:choose>
								</input>
		   					</xsl:when>
		   				</xsl:choose>
		   				<xsl:choose>
	   						<xsl:when test="@canofficail = '1' and @iscloud ='true'">
			   					<input type="button" value="上线" class="button_2" onclick="javascript:synchronization('{@appid}')"/>
		   					</xsl:when>
		   				</xsl:choose>
		   				<xsl:choose>
		   					<xsl:when test="@online = '0' and @canofficail = '0'">
		   						<input type="button" class="button_2" onclick="changeimg(this,'{@appid}')">
								<xsl:choose>
										<xsl:when
											test="@runenable = '1'">
											<xsl:attribute name="value">运行</xsl:attribute>
										</xsl:when>
										<xsl:when
											test="@runenable = '0'">
											<xsl:attribute name="value">暂停</xsl:attribute>
										</xsl:when>
										<xsl:when
											test="@runenable = '2'">
											<xsl:attribute name="value">运行</xsl:attribute>
											<xsl:attribute name="disabled" >disabled</xsl:attribute>
										</xsl:when>
								</xsl:choose>
							</input>
		   					</xsl:when>
		   				</xsl:choose>
		   					
							<input type="button" value="修改"  class="button_2" onclick="javascript:modclientapp('{@appid}')"/>
							<xsl:if test="@canoperateapp='true'">
								<input type="button" value="删除"  class="button_2" onclick="javascript:delclientapp('{@appid}')"/>
							</xsl:if>
							<xsl:choose>
		   						<xsl:when test="@canofficail = '1' and @iscloud='true'">
				   					<input type="button" value="上传配置"   class="button_4" onclick="javascript:GB_showCenter('上传配置文件','/mdp/upload.jsp?appid={@appcode}',550,878);"/>
			   					</xsl:when>
			   				</xsl:choose>
			   				<input type="button" value="WAP应用上传"   class="button_4" onclick="javascript:GB_showCenter('上传WAP({@appcode})','/wap/upload.jsp?appid={@appcode}',550,878);"/>
							<input type="button" value="登录方式配置"  class="button_6" onclick="javascript:loginConfig('{@appid}')"/>
							<input type="button" value="添加业务系统用户"  class="button_8" onclick="javascript:addAppUser('{@appid}')" />
					</div></td>
					
	</tr>
	<tr>
		<td colspan="5" class="list_line"></td>
	</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
