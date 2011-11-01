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
        	当前位置：<xsl:apply-templates select ="//div/a[@href='index.jsp' and contains(text(),'首页')]/../a" mode="dhlist"/>
  
        <span width="100%" height="21px" bgcolor="#ffefd4">内容</span>
        <xsl:apply-templates select="//table[@class='qy']/tr[1]/td[1]/*" mode="imglist"/>
        </body>
    </msc>
  </xsl:template>
  
  <xsl:template match="a" mode="dhlist">
    <a href="{$ip_url}/{@href}">
      <xsl:choose>
        <xsl:when test ="string-length(.)&gt;16">
          <xsl:value-of select ="substring(.,1,14)"/>..
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select ="."/>
        </xsl:otherwise>
      </xsl:choose>
    </a> >>
  </xsl:template>

	<xsl:template match="text()" mode="imglist">
    <xsl:value-of select="."/>
    <br/>
  </xsl:template>
  
	<xsl:template match="img" mode="imglist">
    <img src="{@src}" />
  </xsl:template>
  

</xsl:stylesheet>