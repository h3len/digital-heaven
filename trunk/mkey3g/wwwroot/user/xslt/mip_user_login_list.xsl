<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/root">
	<input type="hidden" id="count" value="/root/@count"/>
	<table width="100%" cellpadding="0" cellspacing="0">
	
	<tr>
	<td colspan="3" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
    <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
    <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	</td>
	</tr>
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	
	<tr class="list_title_bg">
		<td width="3%" class="list_title_bg">
			<div align="left"></div>
		</td>
		<td width="38%"><div align="center"><span class="blue_12_bold">用户名</span></div></td>
		<td width="48%"><div align="center"><span class="blue_12_bold">登录次数</span></div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/user"></xsl:apply-templates>         
      <!--应用模板结束-->
      
<tr>
	<td colspan="3" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
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
   
	<xsl:template match="user">
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
		<td class="list_tr">
			<div align="center">
				<img src="../theme/images/list_icon.gif" width="16"
					height="16" />
			</div>
		</td>
		<td><div align="center">
			<xsl:value-of select="@username" /></div>
		</td>
		<td><div align="center">
			<xsl:value-of select="@logincount" /></div>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
