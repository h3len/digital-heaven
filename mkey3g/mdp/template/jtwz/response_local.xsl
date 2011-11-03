<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <msc type="form">
        <head>
            <title>
                <xsl:choose>
                    <xsl:when test="//title/.!=''">
                        <xsl:value-of select="//title/."/>
                    </xsl:when>
                    <xsl:otherwise>
                    交通违章查询
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
			<xsl:value-of select="/html/body/p/."/><br/><br/><br/>
        </body>
    </msc>
  </xsl:template>
</xsl:stylesheet>