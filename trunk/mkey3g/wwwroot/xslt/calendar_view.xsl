<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<div>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<xsl:apply-templates select="/root/hour[@hour=0]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=1]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=2]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=3]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=4]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=5]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=6]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=7]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=8]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=9]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=10]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=11]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=12]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=13]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=14]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=15]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=16]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=17]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=18]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=19]"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=20]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=21]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=22]" mode="disabled"></xsl:apply-templates>
<xsl:apply-templates select="/root/hour[@hour=23]" mode="disabled"></xsl:apply-templates>

</table>
</div>


  </xsl:template>
  <xsl:template match="hour">
	<tr>
	<td width="1%" align="center" bgcolor="#999999" style="border-top: 1px solid #ffffff;"></td>
	<td width="9%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#d4d0c8">
	
	<div style="height:100%;background-color:#d4d0c8;" onMouseOver="javascript:this.style.backgroundColor='#f2f2f2'" onMouseOut="javascript:this.style.backgroundColor='#d4d0c8'">
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:14px;font-weight:bolder;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	</td>
	<td width="82%" valign="top" bgcolor="#f2f2f2" style="border-top: 1px solid #ffffff;">
		<xsl:apply-templates select="calendar"></xsl:apply-templates>	
	 </td>
	</tr>	
  </xsl:template>
  
  
  <xsl:template match="hour" mode="disabled">
	<tr>
	<td width="1%" align="center" bgcolor="#999999" style="border-top: 1px solid #ffffff;"></td>
	<td width="9%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#d7d7d7">
	
	<div style="height:100%;background-color:#d7d7d7;color:#999;" onMouseOver="javascript:this.style.backgroundColor='#f8f8f8'" onMouseOut="javascript:this.style.backgroundColor='#d7d7d7'">
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:14px;font-weight:bolder;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	
	</td>
	<td width="82%" valign="top" bgcolor="#ffffff" style="border-top: 1px solid #ffffff;">
		<xsl:apply-templates select="calendar"></xsl:apply-templates>	
	 </td>
	</tr>	
  </xsl:template>

  <xsl:template match="calendar">
  <xsl:if test="@content != ''"> 
   
  <div>
  <xsl:attribute name="style">width:160px;position:absolute;border:1px #036 solid;float:left;background-color:ffffff;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;left:<xsl:value-of select="@left"/>px;overflow:hidden;</xsl:attribute>
  <table height="100%" cellspacing="0" cellpadding="0">
  <tr>
  <td width="10" bgColor="003366"></td>
  <td style="width:150px;padding:2px;text-align:left;vertical-align:top;">
  <xsl:attribute name="title"><xsl:value-of select="@starttime"/>-<xsl:value-of select="@endtime"/><xsl:text>  </xsl:text><xsl:value-of select="@content"/></xsl:attribute>
  <xsl:value-of select="@topic"/>
  </td></tr></table>
  </div>
  </xsl:if>
  </xsl:template>


</xsl:stylesheet>
