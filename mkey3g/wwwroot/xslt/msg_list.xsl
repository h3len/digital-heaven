<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/></td>
</tr>
<tr>
<td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <tr class="header">
        <td width="5%" style="padding-left:6px;"></td>
        <td width="10%" align="center">发信人</td>
        <td width="10%" align="center">收信人</td>
        <td width="15%" align="center">发信时间</td>
        <td width="20%" align="center">内容</td>
        <td width="12%" align="center">已收到</td>
        <td width="12%" align="center">已读</td>
        <td align="center">详 情</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/msglist/msg">
      </xsl:apply-templates>
      <tr><td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>    
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
      </td></tr>
         
      <!--应用模板结束-->
</table>
</td></tr>
</table>

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
	
  <xsl:template match="msg">
	
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
       <td style="padding-left:6px;">
       	<input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute></input>
       </td>
      <td align="center"> 
        <xsl:value-of select="@msgfrom" />
      </td>
      <td align="center" class="number_border">
        <xsl:value-of select="@msgto" />
      </td>      
      <td align="center" class="number_border">
        <xsl:value-of select="@date" />
      </td>
      <td align="center" class="number_border" >
        <xsl:value-of select="@content" />
      </td>
 
      <td align="center" class="number_border">
      <xsl:if test="@remind='true'"> 
       		<img src="../images/icon_app_green.gif"/>
      </xsl:if>
      </td>      
      <td align="center" class="number_border">
       <xsl:if test="@read='true'"> 
       		<img src="../images/icon_app_green.gif"/>
      </xsl:if>        
      </td>
      
      <td align="center"><input type="button" value="详 情"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">JavaScript:MsgShow("<xsl:value-of select="@id"/>");</xsl:attribute></input></td>
      </tr>
  </xsl:template>
</xsl:stylesheet>
