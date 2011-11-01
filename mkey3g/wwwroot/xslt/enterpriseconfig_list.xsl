<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" cellpadding="2" cellspacing="0" style="border:1px #ccc solid;" bgcolor="#ffffff">
      <tr class="header">
        <td width="60%" style="padding-left:4px;">名 称</td>
        <td width="30%" align="center">企业配置</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/catlist/cat"></xsl:apply-templates>
      <!--应用模板结束-->
</table>

  </xsl:template>
  <xsl:template match="cat">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;"><xsl:value-of select="@catalogname" /></td>
      <td align="center"><input type="button"><xsl:attribute name="onclick">JavaScript:GetConfig("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:attribute name="value">修改企业配置</xsl:attribute></input></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
