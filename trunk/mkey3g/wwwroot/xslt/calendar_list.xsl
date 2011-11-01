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
	<td width="1%" align="center" bgcolor="#b9daea" style="border-top: 1px solid #ffffff;"></td>
	<td width="6%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#86BFDA">
	
	<div style="height:100%;background-color:#E6F1F7;cursor:pointer;z-index:100;" onMouseOver="javascript:this.style.backgroundColor='#f2f8fb'" onMouseOut="javascript:this.style.backgroundColor='#E6F1F7'">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:12px;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	
	</td>
	<td width="82%" valign="top" bgcolor="#ffffff" style="background:url(../images/week_bg.gif);border:1px #e4e4e4 solid;cursor:pointer;">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">background:url(../images/week_bg.gif);border-top: 1px #e4e4e4 solid;</xsl:attribute>
	</xsl:if>
		<xsl:apply-templates select="calendar"></xsl:apply-templates>	
	 </td>
	</tr>	
  </xsl:template>
  
  
  <xsl:template match="hour" mode="disabled">
	<tr>
	<td width="1%" align="center" bgcolor="#b9daea" style="border-top: 1px solid #ffffff;"></td>
	<td width="6%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#86BFDA">
	
	<div style="height:100%;background-color:#E6F1F7;cursor:pointer;z-index:100;" onMouseOver="javascript:this.style.backgroundColor='#f2f8fb'" onMouseOut="javascript:this.style.backgroundColor='#E6F1F7'">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:12px;color:#999;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	
	</td>
	<td width="82%" valign="top" bgcolor="#ffffff" style="background:url(../images/week_bg.gif);border-top: 1px #e4e4e4 solid;cursor:pointer;">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">background:url(../images/week_bg.gif);border-top: 1px #e4e4e4 solid;</xsl:attribute>
	</xsl:if>
		<xsl:apply-templates select="calendar"></xsl:apply-templates>	
	 </td>
	</tr>
  </xsl:template>

  <xsl:template match="calendar">
  <xsl:if test="@topic != ''">    
  <div>
  <xsl:attribute name="style">clear:both;cursor:pointer;width:460px;position:absolute;border:1px #449BC6 solid;float:left;background-color:ffffff;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;left:<xsl:value-of select="@left"/>px;overflow:hidden;</xsl:attribute>
  <xsl:if test="@isadmin = 'true'"><xsl:attribute name="style">cursor:pointer;width:160px;position:absolute;border:1px #449BC6 solid;float:left;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;left:<xsl:value-of select="@left"/>px;overflow:hidden;background-color:#FFF4BC;</xsl:attribute></xsl:if>
  <xsl:if test="@ispublic = 'true'">  
  <xsl:attribute name="onclick">javascript:LoadCalendarModifyInfo("<xsl:value-of select="@id"/>","<xsl:value-of select="@starttime"/>");</xsl:attribute>
  </xsl:if>
  <table height="100%" cellspacing="0" cellpadding="0">
  <tr>
  <td width="10" bgColor="449BC6"></td>
  <td style="width:150px;padding:2px;text-align:left;vertical-align:top;">  
  
  <xsl:if test="@ispublic = 'true'">  
  <xsl:attribute name="title"><xsl:value-of select="@starttime"/>-<xsl:value-of select="@endtime"/><xsl:text>  </xsl:text><xsl:value-of select="@content"/></xsl:attribute>
  <xsl:value-of select="@topic"/>	
  </xsl:if>  
  <xsl:if test="@ispublic = 'false'">  
  此日程已被保密
  </xsl:if> 
  </td></tr></table>
  </div>
  </xsl:if>
  </xsl:template>


</xsl:stylesheet>
