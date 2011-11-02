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
                    江门社保查询
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
			查询项目：<xsl:value-of select="//table[@width='90%']/tbody/tr/td/div/font/."/><br/><br/><br/>
			<xsl:apply-templates select="//table[@width='90%']/tbody/tr/td[@align='left']/table/tr/td" mode="zblist"/>
        </body>
    </msc>
  </xsl:template>
  
  <xsl:template match="td" mode="zblist">
    <xsl:value-of select="."/><br/>
  </xsl:template>
</xsl:stylesheet>