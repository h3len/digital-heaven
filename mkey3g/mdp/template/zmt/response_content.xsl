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
                    东莞金盾测试
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        	当前位置：<xsl:apply-templates select ="//div[@class='list_banner_left']/span[2]/*" mode="dhlist"/><br/>
  				<xsl:value-of select="//div[@class='content_title']"/><br/>
  				<xsl:value-of select="//div[@class='content_subtitle']"/><br/>
  				<!--<xsl:value-of select="//div[@id='zoom']"/>-->
        <span width="100%" height="21px" bgcolor="#ffefd4">内容</span>
        <span width="100%">
        	<xsl:apply-templates select="//div[@id='zoom']/table" mode="imglist"/>
        </span>
        </body>
    </msc>
  </xsl:template>

	<xsl:template match="a" mode="dhlist">
    <a href="{$cp_url}/{@href}"><xsl:value-of select ="."/></a> >>
  </xsl:template>
	<xsl:template match="text()" mode="imglist">
    <xsl:value-of select="."/>
    <br/>
  </xsl:template>
  
	<xsl:template match="img" mode="imglist">
    <img src="{$cp_url}/{@src}" /><br/>
  </xsl:template>
  

</xsl:stylesheet>