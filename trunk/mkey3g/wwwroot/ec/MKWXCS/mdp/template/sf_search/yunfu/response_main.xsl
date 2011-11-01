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
            <img src="top.gif"/>
          </span>
        </span>
        <xsl:value-of select ="//card/@title"/>
        <xsl:apply-templates/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>
  <!--屏蔽的东西-->
  <xsl:template match="title"/>

  <!--格式化的东西-->
  <xsl:template match="img">
    <br/>
    <img src="?action=viewimageremote@mdp&amp;url={$sfmz}{@src}&amp;nologin=true"/>
    <xsl:if test="@class='logo'">
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="a">
    <xsl:choose>
      <xsl:when test ="contains(.,'返回') or contains(.,'系统首页')"/>
      <xsl:when test="contains(@href,'#top')">
        <a href="?action=bs-transfer@mdp&amp;url={//url}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="?action=bs-transfer@mdp&amp;url={$sfmz}{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="br">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <xsl:template match="p">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <xsl:text>&#160;&#160;</xsl:text>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>

  <xsl:template match ="anchor">
    <input type="submit" caption="查询" target="_blank"/>
  </xsl:template>

  <!-- b标签模板 -->
  <xsl:template match="b">
    <font bold="true">
      <xsl:apply-templates/>
    </font>
  </xsl:template>

  <xsl:template match ="statuCode"/>
  
  <xsl:template match="date">
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>


  <!--过滤掉文字中多余的空白-->
  <xsl:template match="text()[contains(.,' ')]">
    <xsl:value-of select="translate(.,' ','')"/>
  </xsl:template>
</xsl:stylesheet>
