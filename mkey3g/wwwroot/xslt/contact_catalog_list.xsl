<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

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
        <td width="10%" align="center">进入</td>
        <td width="20%" align="center">管理</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/catlist/cat"></xsl:apply-templates>
      <!--应用模板结束-->
</table>

</td></tr></table>

  </xsl:template>
  <xsl:template match="cat">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;">
      <img src="../images/icon_create_usergroup.gif"/><xsl:text>	</xsl:text><a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:GetCatalogList("<xsl:value-of select="@id"/>");GetUserList("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@catalogname" />
       <xsl:if test="@username != ''">
      [ 创建人：<xsl:value-of select="@username"></xsl:value-of>]
       </xsl:if>
      
      </a>
      </td>
      <td></td>
      <td><a style="cursor:pointer；"><xsl:attribute name="onclick">JavaScript:CatalogSortUp("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_up.gif"/></a> <a style="cursor:hand;"><xsl:attribute name="onclick">JavaScript:CatalogSortDown("<xsl:value-of select="@id"/>")</xsl:attribute><img src="../images/icon_arrow_down.gif"/></a></td>
      <td>
      <xsl:choose>
      <xsl:when test="//catlist/@isChildCompany='false' and //catlist/@parentid = ''">
 	     	通讯录
      </xsl:when>
      <xsl:when test="//catlist/@isChildCompany='true'">
 	     	通讯录
      </xsl:when>
      <xsl:otherwise>
          	组
      </xsl:otherwise>
      </xsl:choose>
      </td>
      <td align="center"><input type="button" value="进 入"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:GetCatalogList("<xsl:value-of select="@id"/>");GetUserList("<xsl:value-of select="@id"/>");</xsl:attribute></input></td>
      <td align="center">
      <xsl:if test="@IsShowWhiteButton = 'true'">
      <input type="button" value="设置白名单"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:OpenWinAndSelectUser("<xsl:value-of select="@id"/>");</xsl:attribute></input>
      </xsl:if>
      <xsl:choose>
      <xsl:when test="@IsAdmin = 'true'">
      <input type="button" value="详 情"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:CatalogShow("<xsl:value-of select="@id"/>");</xsl:attribute></input>
      </xsl:when>
      <xsl:when test="@IsAdmin = 'false'">
      <input type="button" value="详 情"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:CatalogShowExtend("<xsl:value-of select="@id"/>");</xsl:attribute></input>
      </xsl:when>
      </xsl:choose>
      </td>
      </tr>
  </xsl:template>
</xsl:stylesheet>
