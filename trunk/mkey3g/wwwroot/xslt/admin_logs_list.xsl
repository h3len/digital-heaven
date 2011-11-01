<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

<tr>
<td>

<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header">
  <td width="2%" class="list_title_bg"><div align="center"></div></td>
  <td width="9%" class="list_title_bg"><div align="center" class="href_12px_blue_bold">日志类型</div></td>
  <td width="8%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">日志级别</span></div></td>
  <td width="18%" class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">日期</span></div></td>
  <td width="63%" class="list_title_bg"><span class="href_12px_blue_bold">日志内容</span></td>
</tr>

<xsl:apply-templates select="/root/list/item" />

<tr><td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
<xsl:apply-templates select="/root/pagenumlist/pagenum"/>
<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>    
</td></tr>
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
	
	<!-- item数据模块 -->
  <xsl:template match="item">	
    <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
      <td style="height:30px;"><div align="center"><img src="../skin/default/images/list_icon.gif" width="16" height="16" /></div></td>
      <td><div align="center">
      <xsl:choose>
      <xsl:when test="@logtype = '1'">
		     	 操作日志
      </xsl:when>
      <xsl:when test="@logtype = '2'">
		     	 运行日志
      </xsl:when>
      <xsl:when test="@logtype = '3'">
		     	 用户日志
      </xsl:when>
      <xsl:when test="@logtype = '4'">
		     	 安全日志
      </xsl:when>      
      </xsl:choose>
      
      </div></td>
      <td><div align="center">
      
          <xsl:choose>
      <xsl:when test="@loglever = '1'">
		     	 INFO
      </xsl:when>
      <xsl:when test="@loglever = '2'">
		     	 DEBUG
      </xsl:when>
      <xsl:when test="@loglever = '3'">
		     	 ERROR
      </xsl:when>
      </xsl:choose>
      
      </div></td>
      <td><div align="center"><xsl:value-of select="@createdate"/></div></td>
      <td style="width:63%!important;word-break:break-all;"><xsl:value-of select="@content"/></td>
    </tr>
    <tr>
      <td colspan="5" class="list_line"></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
