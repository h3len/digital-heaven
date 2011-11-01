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
      <td width="35%" style="padding-left:4px;">
      <input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute></input>
      <img src="../images/icon_single_user.gif"/><xsl:text>	</xsl:text><a><xsl:attribute name="style">cursor:hand;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:UserShow("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@truename" /></a>
      </td>
      <td width="15%" class="number_border">
        <xsl:value-of select="@mobile" />
      </td>
      <td width="10%" class="number_border">
           <a style="cursor:hand;"><xsl:attribute name="onclick">JavaScript:UserSortUp("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_up.gif"/></a> <a style="cursor:hand;"><xsl:attribute name="onclick">JavaScript:UserSortDown("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_down.gif"/></a>
      </td>
      <td width="10%" class="number_border">
            用户
      </td>
      <td width="10%" align="center"></td>
      <td width="10%" align="center"><input type="button" value="详 情"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:UserShow("<xsl:value-of select="@id"/>");</xsl:attribute></input></td>
      </tr>
  </xsl:template>
</xsl:stylesheet>
