<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" nologin="true">
      <head>
        <title>
          <xsl:value-of select="//title"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select ="//form"/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>

  <!--格式化的东西-->
  <xsl:template match="img[@alt='Logo']">
    <br/>
    <img src="?action=viewimageremote@mdp&amp;url={$sfmz}{@src}&amp;nologin=true"/>
    <xsl:if test="@class='logo'">
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <xsl:template match="tr">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>

  <xsl:template match ="strong">
    <strong>
      <font size="l" color="#000000">
        <xsl:value-of select ="."/>
        <br/>
        <br/>
      </font>
    </strong>
  </xsl:template>

  <xsl:template match ="div[contains(@style,'height:48px')]"/>
  <xsl:template match ="statuCode"/>
  <xsl:template match ="a"/>

  <xsl:template match="date">
    <br/>
    <br/>
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>
  
  <xsl:template match ="h3"/>
  
</xsl:stylesheet>
