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
                    江门新闻网--本地新闻
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        <span width="100%" height="21px" bgcolor="#ffefd4">内容</span>
        <span width="100%">
        	<xsl:apply-templates select="//td[@class='xml_text13']/p/font" mode="imglist"/>
        </span>
        </body>
    </msc>
  </xsl:template>

  <xsl:template match="text()" mode="imglist">
    <xsl:value-of select="."/>
    <br/>
  </xsl:template>
  
  <xsl:template match="img" mode="imglist">
    <img src="{@src}" /><br/>
  </xsl:template>
  

</xsl:stylesheet>