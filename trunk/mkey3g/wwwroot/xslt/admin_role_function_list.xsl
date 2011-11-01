<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
  <table width="100%" cellpadding="2" cellspacing="0" id="tdPermission">
      <tr class="header">
        <td width="30%" class="list_title_bg"><span class="href_12px_blue_bold">模块名称</span></td>
        <td width="70%" class="list_title_bg"><span class="href_12px_blue_bold">权限</span></td>
      </tr>
      <!--应用模板开始-->
      	<xsl:apply-templates select="category"></xsl:apply-templates>
      <!--应用模板结束-->
</table>
	
  </xsl:template>
  
  <xsl:template match="category">
  <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
  <xsl:if test="position() mod 2 = 1">
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
     </xsl:if> 
 	<td style="padding-left:4px;font-size:12px;border-bottom:1px #ccc solid;"><xsl:value-of select="@categoryname"/></td>
 	<td style="font-size:12px;border-bottom:1px #ccc solid;"><xsl:apply-templates select="permission"></xsl:apply-templates></td>
  </tr>
 </xsl:template>
 
 
 <xsl:template match="permission">
	<xsl:element name="input">
	<xsl:attribute name="type">checkbox</xsl:attribute>
	<xsl:attribute name="id">
	<xsl:value-of select="@id"></xsl:value-of>
	</xsl:attribute>
	<xsl:attribute name="value">
	<xsl:value-of select="@privacy"></xsl:value-of>
	</xsl:attribute>
	<xsl:if test="@enabled='true'">
	<xsl:attribute name="checked">
	checked
	</xsl:attribute>
	</xsl:if>
	</xsl:element>
	<label style="width:100px;">
	<xsl:attribute name="for">
	<xsl:value-of select="@id"></xsl:value-of>
	</xsl:attribute>
	<xsl:value-of select="@permissionname"/>
	</label>	
 </xsl:template> 
</xsl:stylesheet>
