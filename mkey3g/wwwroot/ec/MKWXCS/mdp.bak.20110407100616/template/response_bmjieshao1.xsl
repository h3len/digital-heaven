<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
    <xsl:template match="/">
        <xsl:choose>
            <!--网络连接失败-->
            <xsl:when test="//statuCode='-1'">
                <msc type="servermsg">
                    <msg buttonstyle="OK" show="true">网络连接失败</msg>
                </msc>
            </xsl:when>

            <xsl:otherwise>
                <msc type="form" action="">
                    <head>
                        <title>系统导航</title>
                    </head>
                    <body>
                        <xsl:call-template name="ss"/>
                      <br/>
                      <xsl:apply-templates select="//body"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

  <xsl:template match ="strong">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <xsl:template match ="a[contains(@href,'javascript:zoomDoc')]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match ="a">
    <font color="#0000ff">
      <xsl:apply-templates/>
    </font>
  </xsl:template>

  <xsl:template match ="p">
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>

  <xsl:template match ="b">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <xsl:template match ="div">
    <xsl:if test ="contains(text(),'_') or contains(text(),'-------')">
      <br/>
    </xsl:if>
    
    <xsl:if test ="not(contains(text(),'______') or contains(text(),'-------'))">
      <xsl:apply-templates/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match ="td[@class='bt']">
    <strong>
      <xsl:apply-templates/>
      <hr/>
    </strong>
  </xsl:template>
</xsl:stylesheet>