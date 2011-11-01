<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

  <table width="100%" class="border" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
      <tr class="header">
        <th class="ac" width="40">序号</th>
        <th width="30%">角色名称</th>
        <th width="40%">备注</th>
        <th class="ac">操 作</th>
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
       <xsl:attribute name="class">AlternatingItemTemplate</xsl:attribute>
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#C8E8DE'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.cssText='AlternatingItemTemplate'</xsl:attribute>
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="class">ItemTemplate</xsl:attribute>
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#C8E8DE'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.cssText='ItemTemplate'</xsl:attribute>
     </xsl:if>     
     <td class="ac b">
       <xsl:value-of select="position()"/>
     </td>
      <td style="padding-left:4px;">
        <font><xsl:attribute name="style">cursor:pointer;text-decoration:underline;color:#039;font-weight:bolder;</xsl:attribute>
        <xsl:value-of select="@rolename" />
      </font>
    </td>
    <td>
      <xsl:value-of select="@comment"/>
    </td>
    <td class="ac">
      <input type="button" class="button" value="加入角色">
        <xsl:attribute name="onclick">
          javascript:JoinRole("<xsl:value-of select="@id"/>");
        </xsl:attribute>
      </input>
     </td>
   </tr>
 </xsl:template>
</xsl:stylesheet>
