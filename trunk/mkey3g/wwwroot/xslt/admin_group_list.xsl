<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <tr class="header">
        <td width="35%" style="padding-left:4px;">群组名称</td>        
        <td width="10%">类型</td>
        <td width="10%" align="center">详 情</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/list/item"></xsl:apply-templates>
      <!--应用模板结束-->
</table>

</td></tr></table>

  </xsl:template>
  <xsl:template match="item">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;">
      <img src="../images/icon_create_usergroup.gif"/><xsl:text>	</xsl:text><a><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">JavaScript:GetGroupUserList("<xsl:value-of select="@id"/>");</xsl:attribute><xsl:value-of select="@groupname" /></a>
      </td>
      <td>群组</td>
      <td align="center"><input type="button"><xsl:attribute name="style">cursor:hand;</xsl:attribute><xsl:attribute name="onclick">JavaScript:GroupShow("<xsl:value-of select="@id"/>");
       </xsl:attribute><xsl:attribute name="value">详 情</xsl:attribute></input></td>
       </tr>
  </xsl:template>
</xsl:stylesheet>
