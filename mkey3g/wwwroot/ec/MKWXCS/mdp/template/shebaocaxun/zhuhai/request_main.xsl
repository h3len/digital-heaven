<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../mdp.xsl"/>

	<xsl:template match="/">
		<mdp>
      <tc>
        <url>
          http://218.204.223.149:4044/mlabour/logon1.jsp?idcardno=<xsl:value-of select="//param[@key='idcardno']/@value"/>&amp;button=确定
        </url>
        <method>GET</method>
        <encoding>utf-8</encoding>
        <params>
            <!--<xsl:apply-templates select="//param"/>-->
        </params>
      </tc>

		</mdp>
	</xsl:template>
    <xsl:template match="param">
      <param key="{@key}" value="{@value}"/>
    </xsl:template>

  
</xsl:stylesheet>
