<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
<tr class="header">
        <td width="50%" style="padding-left:4px;">名 称</td>
        <td width="10%">类型</td>
        <td width="20%" align="center">操作</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/list/item">
      </xsl:apply-templates>
      <!--应用模板结束-->
</table>

  </xsl:template>
  <xsl:template match="item">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;">
      <xsl:value-of select="@name" /><xsl:text>	</xsl:text><xsl:value-of select="@mobile" />
      </td>
      <td width="10%">
      <xsl:choose>
      <xsl:when test="@otype = '1'">用户 </xsl:when>
      <xsl:when test="@otype = '0'">部门 </xsl:when>
      </xsl:choose>
      </td>
      <td align="center"><input type="button" value="退 出"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:UnJoinUser("<xsl:value-of select="@oid"/>");</xsl:attribute></input></td>
      </tr>
  </xsl:template>
</xsl:stylesheet>
