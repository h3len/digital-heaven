<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <!--应用模板开始-->
      <tr class="header">
        <td width="35%" style="padding-left:4px;">用户名称</td>     
        <xsl:if test="/root/@hasGroupPermission = 'true'">
        <td width="20%" align="center">退出群组</td>
        </xsl:if>
      </tr>
      <xsl:apply-templates select="/root/list/item"></xsl:apply-templates>
      <!--应用模板结束-->
</table>


  </xsl:template>
  <xsl:template match="item">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td width="35%" style="padding-left:4px;">
      <img src="../images/icon_single_user.gif"/><xsl:text>	</xsl:text>
      <xsl:if test="/root/@hasGroupPermission = 'true'">
      <input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute></input>
      </xsl:if>
				<a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:UserShow("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@username" /></a>
      </td>
      <xsl:if test="/root/@hasGroupPermission = 'true'">
      <td width="10%" align="center">
      <input type="button" value="退出群组" style="cursor:pointer">
      <xsl:attribute name="onclick">
       JavaScript:UnJoinUser("<xsl:value-of select="@id"/>");
      </xsl:attribute>
      </input>
      </td>
      </xsl:if>
      </tr>
  </xsl:template>
</xsl:stylesheet>
