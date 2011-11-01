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
        <body><span width="100%">
        	<xsl:apply-templates select="//div"/></span>
        </body>
    </msc>
  </xsl:template>
  
  <xsl:template match="div">
        <img src="icon.gif"/>
        <a href="{$cp_url}{@href}">
            <xsl:value-of select="@name"/>
        </a> 
        <font size="s">
            <xsl:value-of select="@date"/>
        </font>
        <br/>
    </xsl:template>


</xsl:stylesheet>