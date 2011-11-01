<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/root">

	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	
	<tr class="list_title_bg">
		<td width="3%" class="list_title_bg">
			<div align="center"></div>
		</td>
		<td width="15%"><div align="center">用户真实姓名</div></td>
		<td width="15%"><div align="center">手机号码</div></td>
		<td width="30%"><div align="center">部门</div></td>
		<td width="20%"><div align="center">操作</div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/list/user"></xsl:apply-templates>         
      <!--应用模板结束-->
      
<tr>
	<input type="hidden" id="truename"><xsl:attribute name="value"><xsl:value-of select="/root/list/@truename" /></xsl:attribute></input>
	<td colspan="4" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>    
	</td>
</tr>
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
   
		<xsl:template match="user">
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
	<td class="list_tr">
				<div align="center">
					<img src="../theme/images/list_icon.gif" width="16"
						height="16" />
				</div>
			</td>
				<td><div align="center"><xsl:value-of select="@username" /></div></td>
				<td><div align="center"><xsl:value-of select="@mobile" /></div></td>
		   <td><div align="center"><xsl:value-of select="@branchname"/></div></td>
		   <td><div align="center">
							<input type="button" value="邮箱配置"  class="button_4" onclick="javascript:mailconfig('{@id}')">
								<xsl:if test="@permession='false'">
									<xsl:attribute name="disabled">true</xsl:attribute>
								</xsl:if>
							</input>
					</div></td>
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
