<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/root">
	<div style="width:100%;margin:auto;padding:auto;text-align:center;">
	<xsl:apply-templates select="//category"></xsl:apply-templates>
	</div>
  </xsl:template>
  
 <xsl:template match="category">
  <div style="width:24%;float:left;">
  <a>
  <xsl:attribute name="href">
  ../<xsl:value-of select="@url"/>
  </xsl:attribute>
  <img>
  <xsl:attribute name="src">
  ../<xsl:value-of select="@logohref"/>
  </xsl:attribute>
  </img>
    </a>
	<p style="padding:10px;">[<a>
	 <xsl:attribute name="href">
  ../<xsl:value-of select="@url"/>
  </xsl:attribute>
  <xsl:if test="@style != ''">
  <xsl:attribute name="style">
  <xsl:value-of select="@style"/>
  </xsl:attribute>
  </xsl:if>
	<xsl:value-of select="@categoryname"/></a>]</p>
  </div>
 </xsl:template>
</xsl:stylesheet>
