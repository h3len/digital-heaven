<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="98%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/></td>
</tr>
  <tr class="header">
  <td>序号</td>
  <td>升级维护内容</td>
  </tr>
      <!--应用模板开始-->
  <xsl:apply-templates select="/root/list/item"></xsl:apply-templates>         
      <!--应用模板结束-->
      <tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/></td>
</tr>
</table>
</xsl:template>

<xsl:template match="item">
  <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#eee'">
  <td><xsl:value-of select="position()" /></td>
  <td><xsl:value-of select="@content" /></td>
  </tr>
</xsl:template>
  
</xsl:stylesheet>
