<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/root">
	<input type="hidden" id="count" value="/root/@count"/>
	<table width="100%" cellpadding="0" cellspacing="0">
	
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	
	<tr class="list_title_bg">
		<td width="3%" class="list_title_bg">
			<div align="center"></div>
		</td>
		<td width="20%"><div align="left"><span class="blue_12_bold">企业名称</span></div></td>
		<td width="20%"><div align="left"><span class="blue_12_bold">企业管理员</span></div></td>
		<td ><div align="center"><span class="blue_12_bold">操作</span></div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/list/item"></xsl:apply-templates>         
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
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
	<td class="list_tr">
		<div align="center">
			<img src="../theme/images/list_icon.gif" width="16"
				height="16" />
		</div>
	</td>
	<td ><div align="left" ><xsl:value-of select="@branchname" /></div></td>
	<td >
		<div align="left" >
			<xsl:choose>
				<xsl:when test="@adminname !=''">
					<xsl:value-of select="@adminname" />		
				</xsl:when>
				<xsl:otherwise>
					<font class="red">未创建管理员</font>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</td>
   <td>
   		<div align="center">
 			<xsl:choose>
				<xsl:when test="@adminname !=''">
					<xsl:if test="@canoperateapp='true'">
						<input type="button" value="创建"   class="button_2" onclick="javascript:createadmin('{@branch}')">
						<xsl:attribute name="disabled" >disabled</xsl:attribute>		
						</input>
					</xsl:if>
					<input type="button" value="修改"  class="button_2" onclick="javascript:modadmin('{@admin}','{@branchname}')"/>
					<xsl:if test="@canoperateapp='true'">
						<input type="button" value="删除"  class="button_2" onclick="javascript:deladmin('{@admin}')"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="@canoperateapp='true'">
						<input type="button" value="创建"  class="button_2" onclick="javascript:createadmin('{@branch}')"/>
					</xsl:if>
					<input type="button" value="修改"  class="button_2" onclick="javascript:modadmin('{@admin}')">
					<xsl:attribute name="disabled" >disabled</xsl:attribute>		
					</input>
					<xsl:if test="@canoperateapp='true'">
						<input type="button" value="删除"  class="button_2" onclick="javascript:deladmin('{@admin}')">
						<xsl:attribute name="disabled" >disabled</xsl:attribute>		
						</input>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>  			
		</div>
	</td>
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
