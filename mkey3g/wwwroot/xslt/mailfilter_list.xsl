<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	</td>
</tr>
<tr><td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <tr class="list_title_bg">
        <td width="50%" style="text-align:left"><span class="href_12px_blue_bold" >内容</span></td>
        <td width="30%" style="text-align:left"><span class="href_12px_blue_bold">处理方式</span></td>
        <td width="20%" align="center"><span class="href_12px_blue_bold">操 作</span></td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/filterlist/filter">
      </xsl:apply-templates>
      <!--应用模板结束-->
</table>
</td></tr>
</table>

  </xsl:template>

  <xsl:template match="filter">
    <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
      <td style="padding-left:4px;text-align:left" >
      <xsl:value-of select="@content" />
      </td>
      <td class="number_border" style="text-align:left">
        <xsl:value-of select="@action" />
      </td>
      <td align="center"><button><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:FilterDelete("<xsl:value-of select="@id"/>");</xsl:attribute>删 除</button></td>
      </tr>
<tr>
	<td colspan="6" class="list_line"></td>
</tr>
  </xsl:template>
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
</xsl:stylesheet>
