<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root">

	<table width="100%" class="text_align_center" border="0" cellspacing="0" cellpadding="0">
      <tr class="list_title_bg">
        <td align="left" width="10%">序号</td>
        <td align="left" width="40%">角色名称</td>
        <td align="left" width="40%">备注</td>
        <td   align="left" width="10%">操 作</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/rolelist/role">
      </xsl:apply-templates>
      <!--应用模板结束-->
  </table>
  </xsl:template>
  
  <xsl:template match="role">
   <tr class="text_align_center" onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
     <xsl:attribute name="id">tr_<xsl:value-of select="@id"/></xsl:attribute>
     <xsl:if test="position() mod 2 = 1">
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
     </xsl:if>     
     <td align="left">
       <xsl:value-of select="position()"/>
     </td>
      <td align="left">
        <a><xsl:attribute name="style">cursor:pointer;</xsl:attribute><xsl:attribute name="onclick">
          javascript:RoleShow("<xsl:value-of select="@id"/>");
        </xsl:attribute>
        <xsl:value-of select="@rolename" />
      </a>
    </td>
    <td align="left" style="word-break: break-all">
      <xsl:value-of select="@comment"/>
    </td>
    <td align="left" height="25">
      <input type="image" value="详 情" src="../skin/default/images/button_detail.gif" width="60" height="22" border="0">
        <xsl:attribute name="onclick">
          javascript:RoleShow("<xsl:value-of select="@id"/>");return false;
        </xsl:attribute>
      </input>
     </td>
   </tr>
	<tr>
		<td colspan="7" class="list_line"></td>
	</tr>
 </xsl:template>
</xsl:stylesheet>
