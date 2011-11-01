<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/userlist/user">
      </xsl:apply-templates>
      <!--应用模板结束-->
</table>


  </xsl:template>
  <xsl:template match="user">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td width="60%" style="padding-left:4px;">    
      <img src="../../images/icon_single_user.gif"/><xsl:text>	</xsl:text> 
		<a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:selectUser('<xsl:value-of select="@id"/>','<xsl:value-of select="@truename"/>');</xsl:attribute><xsl:value-of select="@truename" /></a>     
      </td>      
      <td width="40%" class="number_border">
            用户
      </td>
      

      </tr>
  </xsl:template>
</xsl:stylesheet>
