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
	<!--行政公告-->
        <span width="100%" height="21px" bgcolor="#ffefd4">本地新闻</span>
            <xsl:apply-templates select ="//td[@class='sort_title14']/div/ul/li[a]" mode="ListLi"/>
        </body>
    </msc>
  </xsl:template>

  <!--读取标题列表-->
  <xsl:template match="a" mode="ListLi">
    <a href="{@href}"><xsl:value-of select ="."/></a>
  </xsl:template>

  <!--去掉标题中font内容 -->
  <xsl:template match="font" mode="ListLi"><br/></xsl:template>
</xsl:stylesheet>