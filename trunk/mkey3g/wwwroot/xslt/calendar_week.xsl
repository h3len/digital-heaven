<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<div>
<table width="100%" cellpadding="0" cellspacing="1" border="0" style="background-color:#ccc">
<tr><xsl:apply-templates select="/root/hour[@hour=0]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=1]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=2]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=3]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=4]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=5]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=6]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=7]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=8]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=9]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=10]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=11]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=12]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=13]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=14]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=15]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=16]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=17]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=18]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=19]"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=20]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=21]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=22]" mode="disabled"></xsl:apply-templates></tr>
<tr><xsl:apply-templates select="/root/hour[@hour=23]" mode="disabled"></xsl:apply-templates></tr>
</table>
</div>


  </xsl:template>
  <xsl:template match="hour">
	
	<td width="1%" align="center" bgcolor="#b9daea" style="border-top: 1px solid #ffffff;word-break:break-all"></td>
	<td width="6%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#86BFDA">
	
	<div style="height:100%;background-color:#E6F1F7;cursor:pointer;" onMouseOver="javascript:this.style.backgroundColor='#f2f8fb'" onMouseOut="javascript:this.style.backgroundColor='#E6F1F7'">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:12px;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	</td>
	
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=0]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=0]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=0]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=0]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=0]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=0]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=0]/@date"></xsl:value-of>
		</span>	
		<xsl:apply-templates select="week[@week=0]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#ffffff" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=1]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=1]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>	
	<xsl:if test="week[@week=1]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=1]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=1]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=1]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=1]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=1]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#ffffff" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=2]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=2]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	
	<xsl:if test="week[@week=2]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=2]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=2]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=2]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=2]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=2]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#ffffff" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=3]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=3]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=3]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=3]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=3]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=3]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=3]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=3]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#ffffff" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=4]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=4]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=4]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=4]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=4]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=4]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=4]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=4]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#ffffff" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=5]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=5]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=5]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=5]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=5]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=5]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=5]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=5]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;word-break:break-all">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=6]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=6]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=6]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=6]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=6]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=6]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ff0000</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=6]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=6]/calendar"></xsl:apply-templates>	
	</td>
  </xsl:template>



<xsl:template match="hour" mode="disabled">
	
	<td width="1%" align="center" bgcolor="#b9daea" style="border-top: 1px solid #ffffff;"></td>
	<td width="6%" height="60" valign="top" align="center" style="border-top: 1px solid #ffffff;" bgcolor="#86BFDA">
	
	<div style="height:100%;background-color:#E6F1F7;cursor:pointer;" onMouseOver="javascript:this.style.backgroundColor='#f2f8fb'" onMouseOut="javascript:this.style.backgroundColor='#E6F1F7'">
	<xsl:attribute name="onclick">javascript:LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<span style="font-size:12px;color:#999;"><xsl:value-of select="@hour" /><xsl:text> </xsl:text><sup>00</sup></span>	</div>
	</td>
	
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=0]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=0]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=0]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=0]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=0]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=0]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=0]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=0]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=1]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=1]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>	
	<xsl:if test="week[@week=1]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=1]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=1]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=1]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=1]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=1]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=2]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=2]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=2]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=2]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=2]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=2]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=2]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=2]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=3]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=3]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=3]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=3]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=3]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=3]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=3]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=3]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=4]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=4]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=4]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=4]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=4]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=4]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=4]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=4]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=5]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=5]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=5]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=5]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=5]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=5]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=5]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=5]/calendar"></xsl:apply-templates>	
	</td>
	<td width="13%" valign="top" align="right" bgcolor="#f2f2f2" class="calcell" style="cursor:pointer;">
	<xsl:attribute name="onclick">currentDate = '<xsl:value-of select="week[@week=6]/@currentDate" />';LoadCreateCalendar('<xsl:value-of select="@hour" />:00');</xsl:attribute>
	<xsl:attribute name="time"><xsl:value-of select="@hour" />:00</xsl:attribute>
	<xsl:if test="week[@week=6]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
	<xsl:if test="week[@week=6]/@date != ''"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">javascript:$('r1').checked=true;$('r2').checked=false;SelectDate('<xsl:value-of select="week[@week=6]/@currentDate" />');</xsl:attribute></xsl:if>
	<xsl:if test="week[@week=6]/calendar/@content != ''">
	<xsl:attribute name="onclick"></xsl:attribute>
	<xsl:attribute name="style">border-top: 1px solid #ffffff;</xsl:attribute>
	</xsl:if>
		<span>
		<xsl:if test="week[@week=6]/@isCurrentDate = 'true'">
		<xsl:attribute name="style">color:#ffcccc</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="week[@week=6]/@date"></xsl:value-of>
		</span>
		<xsl:apply-templates select="week[@week=6]/calendar"></xsl:apply-templates>	
	</td>
  </xsl:template>
  
  
  <xsl:template match="calendar">
  <xsl:if test="@topic != ''">  
  <div>
  <xsl:if test="@starttime[starts-with(.,'07:')]">
  	<xsl:attribute name="style">width:80px;cursor:pointer;position:absolute;border:1px #449BC6 solid;float:left;background-color:ffffff;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;margin-left:-62px;overflow:hidden;</xsl:attribute>
  </xsl:if>
  <xsl:if test="@starttime[not(starts-with(.,'07:'))]">
  	<xsl:attribute name="style">width:80px;cursor:pointer;position:absolute;border:1px #449BC6 solid;float:left;background-color:ffffff;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;margin-left:-40px;overflow:hidden;</xsl:attribute>
  </xsl:if>
  <xsl:if test="@isadmin = 'true'"><xsl:attribute name="style">width:80px;cursor:pointer;position:absolute;border:1px #449BC6 solid;float:left;margin-left:4px;margin-top:<xsl:value-of select="@top"/>px;height:<xsl:value-of select="@height"/>px;left:<xsl:value-of select="@left"/>px;overflow:hidden;background-color:#FFF4BC;</xsl:attribute></xsl:if>
  <xsl:attribute name="onclick">javascript:LoadCalendarModifyInfo("<xsl:value-of select="@id"/>","<xsl:value-of select="@starttime"/>")</xsl:attribute>
  <table height="100%" cellspacing="0" border="0" cellpadding="0">
  <tr>
  <td width="10" bgColor="449BC6"></td>
  <td style="width:70px;padding:2px;text-align:left;vertical-align:top;word-break:break-all">
  <xsl:attribute name="title"><xsl:value-of select="@starttime"/>-<xsl:value-of select="@endtime"/><xsl:text>  </xsl:text><xsl:value-of select="@content"/></xsl:attribute>
  <xsl:value-of select="@topic"/>
  </td></tr></table>
  </div>
  </xsl:if>
  </xsl:template>


</xsl:stylesheet>
