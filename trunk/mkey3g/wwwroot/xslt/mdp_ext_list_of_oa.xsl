<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="permission" select="/list/@permission"></xsl:variable>
<xsl:variable name="count" select="/list/@count"></xsl:variable>
  <xsl:template match="/list">
  	  <div id="header" > 
  	  <!-- 任何人都可以绑定
 	  		<xsl:if test="$permission=1 or $permission=2 "> 	
 	  		 -->
  			<table width="100%">
				<tr>
					<td align="left"></td>	
					<td align="right"><input type="button"  class="button"  value="绑定客户系统账号" onclick="loadCreateWin()"/></td>
				</tr>
			</table>
	  </div>	
  	  <table width="100%" align="center">  				
		<tr class="header">
			<td width="5%">序号</td>
			<td width="20%">MIP用户名</td>
			<td width="25%">集团名称</td>
			<td width="20%">绑定系统ID</td>
			<td width="20%">绑定系统账号</td>
			<td width="25%">操作</td>
		</tr>
		<xsl:choose>
  			<xsl:when test="$count=0">
  				<tr><td width="100%" colspan="4" align="center">没有数据</td></tr>
  			</xsl:when>
  			<xsl:otherwise>
  				<xsl:apply-templates select="item"/>	
  			</xsl:otherwise>
  		</xsl:choose>
			
	  </table>
	 
 </xsl:template>
 <xsl:template match="item">
 	<tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
 		<td><xsl:value-of select="position()"/></td>
 		<td><a href="javascript:view('{@id}')"><xsl:value-of select="@mipUserName"/></a></td>
 		<td><xsl:value-of select="@branchname"/></td>
 		<td><xsl:value-of select="@sysid"/></td>
 		<td><xsl:value-of select="@oauser"/></td>
 		<td><input type="button"  class="button"  value="修改" onclick="loadUpdateWin('{@id}')"/><input type="button"  class="button"  value="删除" onclick="del('{@id}')"/></td> 		
 	</tr>
 </xsl:template>
</xsl:stylesheet>
