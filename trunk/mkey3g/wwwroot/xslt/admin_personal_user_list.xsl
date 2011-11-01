<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <!--应用模板开始-->
      <tr class="header">
     
       <td width="35%">联系人</td> 
       <td width="10%" style="padding-left:4px;">手机号</td>
       <td width="10%" align="center" >详 情</td>
      </tr>
      <xsl:apply-templates select="/root/user"></xsl:apply-templates>
      <!--应用模板结束-->
</table>


  </xsl:template>
  <xsl:template match="user">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
    	
		<td> <input type="checkbox" id="checkbox" name="value" value="{@id}" /><xsl:value-of select="@truename"/></td>
		<td align="left"><xsl:value-of select="@mobile"/></td>
 		<td align="center"><input type="button" value="详情" onclick="showUser('{@id}')" /></td>
      </tr>
  </xsl:template>
</xsl:stylesheet>
