<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

  <table width="100%" cellpadding="0" cellspacing="0" bgcolor="#ffffff" >
      <tr class="header">
        <td class="ac" width="40">序号</td>
        <td width="20%">角色名称</td>
        <td width="20%">所管理的部门</td>
        <td width="40%">备注</td>
        <td class="ac">操 作</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/rolelist/role">
      </xsl:apply-templates>
      <!--应用模板结束-->
      <tr><td colspan="5" style="text-align:right"><span > <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/user/@catalogid" />");GetUserList("<xsl:value-of select="/root/user/@catalogid" />");</xsl:attribute></input></span></td></tr>
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
     <td class="ac b">
       <xsl:value-of select="position()"/>
     </td>
      <td style="padding-left:4px;">
        <xsl:value-of select="@rolename" />
    </td>
    <td>
      <xsl:value-of select="@branchname"/>
    </td>
    <td>
      <xsl:value-of select="@comment"/>
    </td>
    <td class="ac">
      <input type="button" class="button" value="退出角色">
        <xsl:attribute name="onclick">
          javascript:UserUnJoinRole("<xsl:value-of select="@id"/>");
        </xsl:attribute>
      </input>
     </td>
   </tr>
 </xsl:template>
</xsl:stylesheet>
