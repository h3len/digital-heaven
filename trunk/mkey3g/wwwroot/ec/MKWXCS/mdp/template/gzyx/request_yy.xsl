<?xml version="1.0" encoding="utf-8"?>
<!--
    补充材料上行
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>


  <xsl:template match="/">
    <mdp>
      <tc>
        <url>
            <xsl:value-of select="//param[@key='url']/@value"/>&amp;chooce=yy
		</url>
        <method>get</method>
        <encoding>utf-8</encoding>
        <params>
        </params>
      </tc>
    </mdp>
  </xsl:template>

 
</xsl:stylesheet>
