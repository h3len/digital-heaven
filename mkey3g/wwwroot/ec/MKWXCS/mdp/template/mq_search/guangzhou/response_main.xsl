<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" nologin="true" action="">
      <head>
        <title>
          <xsl:value-of select="//title"/>
        </title>
      </head>
      <body>
        <span width="100%" dock="top">
          <span width="100%">
            <img src="top_mq.gif"/>
          </span>
        </span>
        <xsl:apply-templates select ="//form"/>
        <xsl:apply-templates select ="//date"/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>

  <!--格式化的东西-->
  <xsl:template match="input">
    <br/>
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <xsl:template match ="p[@class='cssAppBigBold']"/>

  <xsl:template match="date">
    <br/>
    <br/>
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>
  
</xsl:stylesheet>
