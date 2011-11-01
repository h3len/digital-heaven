<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root">
	<table width="100%" height="100%" class="text_align_center" border="0" cellspacing="0" cellpadding="0" style="background-color: #EEF5FF">
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/main">
      </xsl:apply-templates>
       <!--应用模板开始-->
      <xsl:apply-templates select="/root/list">
      </xsl:apply-templates>
      <!--应用模板结束-->
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/item">
      </xsl:apply-templates>
      <!--应用模板结束-->
  </table>
  </xsl:template>
  
   <xsl:template match="main">
   <tr class="text_align_center" style="height:30px">
   		<td width="5%">
   		</td>
   		<td style="font-size:14px;font-weight:bold" align="left" width="30%">
   			产品主版本信息:
		</td>
     <td align="left" style="color:#FF3300" width="65%" colspan="2">
       <xsl:value-of select="@productversion"/>
     </td>
   </tr>
   <tr>
		<td colspan="4">
			<div style="padding:0px; margin:0px; border-bottom:2px solid #CEDCED;"></div>
		</td>
	</tr>
 </xsl:template>
  <xsl:template match="list">
 	 <tr>
 	 	<td width="3%">
   		</td>
	</tr>
   <tr class="text_align_center" style="height:30px">
   <td width="5%">
   	</td>
   <xsl:choose>
   <xsl:when test="@serialupdate!='0'">
   <td>
   		<span style="display:none">升级包版本信息:</span>
	</td>
	</xsl:when>
	<xsl:otherwise>
		
		<td style="font-size:14px;font-weight:bold" align="left" width="30%">
   			升级包版本信息:
		</td>
	</xsl:otherwise>
	</xsl:choose>
     <td align="left"  style="color:#FF3300" width="65%" colspan="2">
       <xsl:value-of select="@updateverion"/>
     </td>
   </tr>
 </xsl:template>
  <xsl:template match="item">
  	<tr>
		<td colspan="4">
			<div style="padding:0px; margin:0px; border-bottom:2px solid #CEDCED;"></div>
		</td>
	</tr>
   <tr class="text_align_center" style="height:30px">
   <td weight="5%">
   	</td>
   <xsl:choose>
   <xsl:when test="@serialmodule!='0'">
   	<td>
   		<span style="display:none">核心模块版本信息:</span>
	</td>
	</xsl:when>
	<xsl:otherwise>
		<td style="font-size:14px;font-weight:bold" align="left" width="30%">
   			核心模块版本信息:
		</td>
	</xsl:otherwise>
	 </xsl:choose>
     <td align="left" width="20%">
       <xsl:value-of select="@modulename"/>
     </td>
     <td align="left" style="color:#FF3300" width="45%">
       <xsl:value-of select="@moduleversion"/>
     </td>
   </tr>
 </xsl:template>


</xsl:stylesheet>
