<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" action="">
      <head>
        <title>机构（省局介绍，内部机构）</title>
      </head>
      <body>
        <!--<span width="100%" dock="top">
          <img src="jigou.jpg"/>
        </span>-->
          <xsl:call-template name="ss"/>
        <xsl:choose>
          <xsl:when test="//param[@key='name']/@value='sjjs'">
            <strong>省局介绍</strong>
            <br/>
            <xsl:apply-templates select="//td[@class='text1']"/>
          </xsl:when>

          <xsl:when test="//param[@key='name']/@value='nbjg'">
            <strong>内部机构</strong>
            <br/>
            <xsl:apply-templates select="//center//center/table/tr/td[2]"/>
          </xsl:when>

          <xsl:otherwise>
            <span width="100%" align="center">
              <xsl:text>※</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/jigou.asp&amp;name=sjjs&amp;nologin=true">省局介绍</a>
              <xsl:text>※</xsl:text>
              <br/>
              <br/>
              <br/>
              <br/>
              <br/>
              <xsl:text>※</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/jigou.asp&amp;name=nbjg&amp;nologin=true">内部机构</a>
              <xsl:text>※</xsl:text>
            </span>
          </xsl:otherwise>
        </xsl:choose>

      </body>
    </msc>
  </xsl:template>

  <xsl:template match="div/table/tr[2]">
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

  <xsl:template match="div/table/tr[3]/td/table/tr">
    <xsl:choose>
      <xsl:when test="td[2]/div/a[2]">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/{td[2]/div/a[2]/@href}&amp;nologin=true">
          <xsl:value-of select="td[2]/div/a[1]/text()"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="bumen.xml">
          <xsl:value-of select="td[2]/div/a/text()"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>

    <hr/>
  </xsl:template>

  <xsl:template match="div/table/tr[4]">
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

  <xsl:template match="div/table/tr[5]/td/table/tr">
    <xsl:choose>
      <xsl:when test="td[2]">
        &#160;<xsl:text>⊥</xsl:text>
        <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/{td[2]/div/a/@href}&amp;nologin=true">
          <xsl:value-of select="td[2]/div/a/text()"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span width="100%" bgcolor="#EFEFEF">
          <xsl:value-of select="td/text()"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>

    <hr/>
  </xsl:template>

</xsl:stylesheet>