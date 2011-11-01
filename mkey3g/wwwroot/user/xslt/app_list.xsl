<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:template match="item">
	<xsl:choose>
		<xsl:when test="@join= 'true'">
			<input type="checkbox" name="apps" value="{@id}" checked="true" />
		</xsl:when>
		<xsl:otherwise>
	 		<input type="checkbox" name="apps" value="{@id}" />
	 	</xsl:otherwise>
	</xsl:choose>
 	<xsl:value-of select="@name"/>(<xsl:value-of select="@appid"/>)<input type="hidden" name="oldappids" value="{@id}" /><br/>
</xsl:template>
</xsl:stylesheet>
