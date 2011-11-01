<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
  <table width="100%" cellpadding="2" cellspacing="0" id="tdPermission">
      <tr class="list_title_bg">
        <td width="30%" style="padding-left:4px;"><span class="margin_left_10">模块名称</span></td>
        <td width="70%">权限</td>
      </tr>
      <!--应用模板开始-->
      	<xsl:apply-templates select="category"></xsl:apply-templates>
      <!--应用模板结束-->
       <tr><td class="ar" colspan="2"><div class="center_nav_line"></div></td></tr>
      
</table>
	
  </xsl:template>
  
  <xsl:template match="category">
  <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';" height="24px">
  <xsl:if test="position() mod 2 = 1">
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
     </xsl:if> 
 	<td style="padding-left:4px;font-size:12px;border-bottom:1px #ccc solid;"><span class="margin_left_10"><xsl:value-of select="@categoryname"/></span></td>
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
