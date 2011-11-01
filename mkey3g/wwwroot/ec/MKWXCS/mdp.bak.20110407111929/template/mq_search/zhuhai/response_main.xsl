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
        <xsl:apply-templates select ="//div[@class='container']"/>
        <br/>
        <br/>
        <xsl:apply-templates select ="//date"/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>

  <!--格式化的东西-->
  <xsl:template match ="a[contains(@href,'action')]">
    <a href="?action=bs-transfer@mdp&amp;url={//url}{@href}&amp;nologin=true">
      <xsl:value-of select="."/>
    </a>
  </xsl:template >
  
  <xsl:template match="img">
    <xsl:if test="@width='236'">
      <img src="?action=viewimageremote@mdp&amp;url={$sfmz}{@src}&amp;nologin=true"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <xsl:template match="p">
    <br/>
    <!--<xsl:text>&#160;</xsl:text>-->
    <br/>
    <!--<xsl:text>&#160;&#160;</xsl:text>-->
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="date">
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>

  <!--表格内容的显示-->
  <xsl:template match="table[tr[1]/th[1][.='种类']]">
    <hr color="#aed3eb"/>
    <xsl:for-each select="child::*">
      <hr color="#aed3eb"/>
      <xsl:for-each select="child::*">
        <xsl:text>&#160;&#160;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#160;&#160;</xsl:text>
      </xsl:for-each>
    </xsl:for-each>
    <hr color="#aed3eb"/>
  </xsl:template>


</xsl:stylesheet>
