<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:template match="/root">
	<input type="hidden" id="count" value="/root/@count"/>
	<table width="100%" cellpadding="0" cellspacing="0">
	
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	<tr>
		
		<td width="20%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">业务系统名称</span></div></td>
		<td width="10%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">距离有效期天数</span></div></td>
		<td width="30%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">修改有效期</span></div></td>
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
			<td><div align="center">
				<xsl:value-of select="@appname" /></div>
			</td>
			
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
		   <td>
		   	<div align="center">
	   			<input type="button" value="修改" class="button_2" onclick="updatePeriod('{@appid}','{@appname}')"/>
			</div>
		  </td>
					
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
