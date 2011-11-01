<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../mdp.xsl"/>

	<xsl:template match="/">
		<mdp>
      <tc>
        <url>
          http://wap.dggjj.cn/wml/gjjVerify.do
        </url>
        <method>POST</method>
        <encoding>utf-8</encoding>
        <params>
            <xsl:apply-templates select="//param"/>
        </params>
      </tc>

		</mdp>
	</xsl:template>
    <xsl:template match="param">
      <param key="{@key}" value="{@value}"/>
    </xsl:template>

  
</xsl:stylesheet>
