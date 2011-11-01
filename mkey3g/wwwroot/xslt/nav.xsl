<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/root">

 <ul>
			<!-- nav_menu -->
     <!--应用模板开始-->
  <xsl:apply-templates select="/root/top/topcategory"></xsl:apply-templates>
  <LI id="search"></LI>
  	</ul>
  
 </xsl:template>
      <!--应用模板结束-->

	
	<xsl:template match="topcategory">
			<xsl:choose>
				<xsl:when test="@categoryname!='差旅服务'">
					<li><a hidefocus="true" href="{@url}"><xsl:value-of select="@categoryname"/></a></li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a href="http://{@url}" target="_blank">
							<xsl:value-of select="@categoryname" />
						</a>
					</li>
				
				</xsl:otherwise>
			</xsl:choose>
	
			
			
	</xsl:template>



</xsl:stylesheet>
