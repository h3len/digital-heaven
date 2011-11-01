<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header list_title_bg">
  <td width="30%"><span class="margin_left_10">包名</span></td>
  <td width="30%">适应手机</td>
  <td width="20%">资源包</td>
  <td width="10%">操作</td>
</tr>
<xsl:apply-templates select="/root/list/mp" />
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
	<!-- item数据模块 -->
  <xsl:template match="mp">	
    <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@packetname"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@mobiletype"/></div></td>
      <td style="word-break: break-all"><div align="left"><a href="../mobiletype.do?action=download&amp;id={@id}"><xsl:value-of select="@filename"/></a></div></td>
      <td style="word-break: break-all"><div align="left"><input name="button" class="button_2" value="删除" type="button" id="del" onclick="javascript:delete_packet('{@id}');"></input></div></td>
    </tr>
   <tr>
			<td colspan="4" class="list_line"></td>
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
