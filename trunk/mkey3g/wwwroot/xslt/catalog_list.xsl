<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <tr class="header">
        <td width="35%" style="padding-left:4px;">名 称</td>
        <td width="15%">手机号码</td>
        <xsl:if test="//root/catlist/@write = 'true'">
        <td width="10%">排序</td>
        </xsl:if>
        <td width="10%">类型</td>
        <td width="10%" align="center">详 情</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/catlist/cat"></xsl:apply-templates>
      <!--应用模板结束-->
</table>

</td></tr></table>

  </xsl:template>
  <xsl:template match="cat">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;" colspan="2">
      <img src="../images/icon_create_usergroup.gif"/><xsl:text>	</xsl:text><a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:GetCatalogList("<xsl:value-of select="@id"/>");GetUserList("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@catalogname" /></a>
      </td>
      <xsl:if test="//root/catlist/@write = 'true'">
      <td><a style="cursor:pointer;"><xsl:attribute name="onclick">JavaScript:CatalogSortUp("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_up.gif"/></a> <a style="cursor:hand;"><xsl:attribute name="onclick">JavaScript:CatalogSortDown("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_down.gif"/></a></td>
      </xsl:if>
      <td>
  
      <xsl:choose>
      <xsl:when test="//catlist/@isChildCompany='false' and //catlist/@parentid = 'null'">
 	     	集团
      </xsl:when>
      <xsl:when test="//catlist/@isChildCompany='true'">
 	     	部门
      </xsl:when>
      <xsl:otherwise>
          	部门
      </xsl:otherwise>
      </xsl:choose>
 
      </td>
      <td align="center"><input type="button"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">
       <xsl:choose>
       <xsl:when test="//root/catlist/@write = 'true'">
       JavaScript:CatalogShow("<xsl:value-of select="@id"/>");
       </xsl:when>
       <xsl:otherwise>
       JavaScript:CatalogShowExtend("<xsl:value-of select="@id"/>");
       </xsl:otherwise>
       </xsl:choose>
       </xsl:attribute><xsl:attribute name="value">详 情</xsl:attribute></input></td>
       </tr>
  </xsl:template>
</xsl:stylesheet>
