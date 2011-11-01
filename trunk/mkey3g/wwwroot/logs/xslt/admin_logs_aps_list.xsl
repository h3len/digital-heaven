<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

<tr>
<td>

<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header">
<td width="5%" class="list_title_bg"><div align="left"><input type="checkbox" id="aps_selall" onclick="checkall()" title="全选/不选"/></div></td>
  <td width="15%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">创建时间</span></div></td>
  <td width="15%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">送达时间</span></div></td>
   <td width="10%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">状态</span></div></td>
  <td width="10%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">类型</span></div></td>
    <td width="15%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">目标用户</span></div></td>
	<td width="15%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold">企业名称</span></div></td>
	<td width="15%" class="list_title_bg"><div align="left"><span class="href_12px_blue_bold"></span></div></td>
</tr>

<xsl:apply-templates select="/root/aps" />

</table>

</td></tr>
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
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
	<!-- item数据模块 -->
  <xsl:template match="aps">
    <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
   		 <td ><div align="left"><input type="checkbox" value="{@id}" name="aps" onclick="isallsel('aps')"/></div></td>
			  <td ><div align="left" ><xsl:value-of select="@vdatetime" /></div></td>
			  <td ><div align="left" ><xsl:value-of select="@completetime" /></div></td>
			  <td><div align="left"><xsl:value-of select="@status" /></div></td>
			  <td><div align="left"><xsl:value-of select="@type" /></div></td>
			   <td><div align="left"><xsl:value-of select="@to" /></div></td>
			   <td><div align="left"><xsl:value-of select="@enterprise" /></div></td>
				 <td><div align="left">
				 <input type="button" class="button_2" onclick="javascript:showthislog('{@id}');return false;" id="search" value="详情" />
				</div></td>
			    </tr>
			    <tr>
					<td colspan="8" class="list_line"></td>
				</tr>
  </xsl:template>
</xsl:stylesheet>
