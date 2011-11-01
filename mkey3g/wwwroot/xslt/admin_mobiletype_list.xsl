<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="98%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
  <tr class="header">
    <td width="22%" align="center">手机类型</td>
    <td width="20%" align="center">屏幕宽度</td>
    <td width="20%" align="center">屏幕高度</td>
    <td width="25%" align="center">UA</td>
    <td align="center">详 情</td>
  </tr>
      <!--应用模板开始-->
  <xsl:apply-templates select="/root/mobiletypelist/mobiletype">
  </xsl:apply-templates>         
      <!--应用模板结束-->
</table>
</xsl:template>

 	 <xsl:template match="mobiletype">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#eee'">
       <td align="center" style="word-break: break-all"> 
        <xsl:value-of select="@mobiletype" />
      </td>        
      <td align="center" style="word-break: break-all"> 
        <xsl:value-of select="@height" />
      </td>        
      <td align="center" style="word-break: break-all"> 
        <xsl:value-of select="@width" />
      </td>        
      <td align="center" style="word-break: break-all"> 
        <xsl:value-of select="@ua" />
      </td>        
      <td align="center"><input type="button" value="详 情"><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">JavaScript:MobileTypeShow("<xsl:value-of select="@id"/>");</xsl:attribute></input></td>
      </tr>
  </xsl:template>
  
</xsl:stylesheet>
