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
        <xsl:apply-templates/>
      </body>
    </msc>
  </xsl:template>

  <!--格式化的东西-->
  <xsl:template match="img">
    <br/>
    <img src="?action=viewimageremote@mdp&amp;url={$sfmz}{@src}&amp;nologin=true"/>
    <xsl:if test="@class='logo'">
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="a">
    <xsl:variable name="href">
      <xsl:call-template name="ReplaceAll">
        <xsl:with-param name="content" select="@href"/>
        <xsl:with-param name="str">&amp;</xsl:with-param>
        <xsl:with-param name="replacement" select="'%26'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test ="contains(.,'首页') or contains(.,'服务页面')"/>
      <xsl:when test="contains(@href,'selectflag')">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <a href="?action=bs-transfer@mdp&amp;url={$sfmz}{$href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <!-- b标签模板 -->
  <xsl:template match="b[@style]">
    <font bold="true">
      <xsl:apply-templates/>
    </font>
  </xsl:template>

  <xsl:template match ="div[contains(@style,'height:48px')]"/>
  <xsl:template match ="statuCode"/>
  <xsl:template match ="div[@class='right']"/>

  <xsl:template match="date">
    <br/>
    <br/>
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>
  
  <xsl:template match ="h3"/>

  <!--过滤掉文字中多余的空白-->
  <xsl:template match="text()[contains(.,' ')]">
    <xsl:value-of select="translate(.,' ','')"/>
  </xsl:template>
</xsl:stylesheet>
