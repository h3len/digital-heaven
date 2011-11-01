<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header list_title_bg">
  <td width="10%"><div align="left">手机型号</div></td>
  <td width="10%"><div align="left">屏幕宽度</div></td>
  <td width="10%"><div align="left">屏幕高度</div></td>
  <td width="10%"><div align="left">UA</div></td>
  <td width="10%"><div align="left">语言编码</div></td>
  <td width="10%"><div align="left">生产厂商</div></td>
  <td width="10%"><div align="left">操作系统</div></td>
  <td width="30%"><div align="left">操作</div></td>
</tr>
<tr>
			<td colspan="9" class="list_line"></td>
		</tr>
<xsl:apply-templates select="/root/list/item" />
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
     	<td style="word-break: break-all"><div align="left"><a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:onemobiletype("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@mobiletype"/></a></div></td>
     	<td style="word-break: break-all"><div align="left"><xsl:value-of select="@width"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@height"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@ua"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@languagecode"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@manufactory"/></div></td>
      <td style="word-break: break-all"><div align="left"><xsl:value-of select="@operationsystem"/></div></td>
      <td style="word-break: break-all"><div align="left"><input name="button" class="button_2" value="查看" type="button" id="mod" onclick="javascript:onemobiletype('{@id}');"></input>
      <input name="button" class="button_2" value="修改" type="button" id="mod" onclick="javascript:updata_mobiletype('{@id}');"></input>
      <input name="button" class="button_2" value="删除" type="button" id="del" onclick="javascript:delete_mobiletype('{@id}');"></input></div></td>
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
