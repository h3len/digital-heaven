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
                    樟木头测试
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        <span width="100%" height="21px"><a href="{$cp_url}/publicfiles//business/htmlfiles/dgzmt/s22367/index.htm">通知公告</a></span>
        <span width="100%" height="21px"><a href="{$cp_url}/publicfiles//business/htmlfiles/dgzmt/s22377/index.htm">樟城新闻</a></span>
        <span width="100%" height="21px"><a href="{$cp_url}/publicfiles//business/htmlfiles/dgzmt/s22443/index.htm">食在樟城</a></span>
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>