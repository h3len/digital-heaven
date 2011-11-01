<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../mdp.xsl"/>

	<xsl:template match="/">
		<mdp>
      <tc>
        <url>
          http://210.73.44.165/search/accumulationFund/accumulationFundSearch_post.jsp?contentId=-1&amp;catId=0&amp;L1catName=&amp;L1catEncode=&amp;L2catName=&amp;cntName=
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
