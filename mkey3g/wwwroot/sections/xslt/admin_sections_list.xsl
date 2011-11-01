<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header list_title_bg">
  <td width="10%"><div align="left"><a href="#" onclick="checkall()">全选</a>/<a href="#" onclick="inverse()">反选</a></div></td>
  <td width="15%"><div align="left">号段类型</div></td>
  <td width="18%"><div align="left">起始号码</div></td>
  <td width="18%"><div align="left">结束号码</div></td>
  <td width="18%"><div align="left">修改时间</div></td>
  <td width="10%"><div align="left">操作</div></td>
  
</tr>
<tr>
			<td colspan="9" class="list_line"></td>
		</tr>
<xsl:apply-templates select="/root/item" />
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
	<!-- item数据模块 -->
  <xsl:template match="item">	
    <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
     	<td><input type="checkbox" name="idmark" id="{@id}"></input></td>
     	<td><xsl:value-of select="@type"/>位号段</td>
     	<td><xsl:value-of select="@startnum"/></td>
     	<td><xsl:value-of select="@endnum"/></td>
     	<td><xsl:value-of select="@createtime"/></td>
     	<td><input type="button" value="修改" onclick="modsections('{@id}')"></input></td>
    </tr>
   <tr>
			<td colspan="9" class="list_line"></td>
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