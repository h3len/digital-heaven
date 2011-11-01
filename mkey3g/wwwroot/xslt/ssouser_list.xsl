<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<div style="overflow:auto;overflow-x:hidden;height:400px;">
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff" >
<tr class="header">
        <td style="padding-left:20px;width:50px;">用户名称</td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/userlist/user">
      </xsl:apply-templates>
      <!--应用模板结束-->
</table>
</div>
<p style="text-align:right;"><input type="button" value="全选" onClick="javascript:SelectCheckbox('all')"/><input type="button" value="不选" onClick="javascript:SelectCheckbox('none')"/><input type="button" value="反选" onClick="javascript:SelectCheckbox('antiselected')"/> <input type="button" value="选中新增的" onClick="javascript:SelectCheckbox('new');"/> <input type="button" value="选中更新的" onClick="javascript:SelectCheckbox('update')"/> <input type="button" value="选中删除的" onClick="javascript:SelectCheckbox('delete')"/> <input type="button" onclick="ImportUser();" value="同步选中的用户"/></p>

  </xsl:template>
  <xsl:template match="user">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td width="35%" style="padding-left:4px;">
      <input type="checkbox">
      <xsl:attribute name="id">
      <xsl:choose>
      <xsl:when test="@status = '1'">new_<xsl:value-of select="@ssoid"/></xsl:when>
      <xsl:when test="@status = '-1'">delete_<xsl:value-of select="@ssoid"/></xsl:when>
      <xsl:when test="@status = '0'">update_<xsl:value-of select="@ssoid"/></xsl:when>
      </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute></input>
      <xsl:text>	</xsl:text>
      <xsl:choose>
      <xsl:when test="@status = '1'">
      <img src="../images/add.gif"/>
      </xsl:when>
         <xsl:when test="@status = '-1'">
     <img src="../images/del.png"/>
      </xsl:when>
         <xsl:when test="@status = '0'">
     <img src="../images/update.gif"/>
      </xsl:when>
      </xsl:choose>
      <xsl:value-of select="@username" />
      </td>
</tr>
  </xsl:template>
</xsl:stylesheet>
