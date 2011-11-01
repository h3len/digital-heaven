<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root">

  <table width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff" >
      <tr class="header">
        <th class="ac" width="40">序号</th>
        <th width="30%">角色名称</th>
        <th width="40%">备注</th>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/rolelist/role">
      </xsl:apply-templates>
      <!--应用模板结束-->
  </table>
  </xsl:template>
  
  <xsl:template match="role">
   <tr>
     <xsl:attribute name="id">tr_<xsl:value-of select="@id"/></xsl:attribute>
     <xsl:if test="position() mod 2 = 1">
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#f2f2f2'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.backgroundColor='#ffffff'</xsl:attribute>
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
    		 <xsl:attribute name="bgColor">#f8f8f8</xsl:attribute>
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#f2f2f2'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.backgroundColor='#f8f8f8'</xsl:attribute>
     </xsl:if>     
     <td style="word-break: break-all">
       <xsl:value-of select="position()"/>
     </td>
      <td style="padding-left:4px;word-break: break-all">
      <input type="checkbox" name="role"><xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute></input>
        <xsl:value-of select="@rolename" />
    </td>
    <td style="word-break: break-all">
      <xsl:value-of select="@comment"/>
    </td>    
   </tr>
 </xsl:template>
</xsl:stylesheet>
