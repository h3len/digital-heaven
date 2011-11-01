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
                    江门新闻网
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        <span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=1179">本地新闻</a></span>
        <span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=193">三区四市</a></span>
        <span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=334">都市新闻</a></span>
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>