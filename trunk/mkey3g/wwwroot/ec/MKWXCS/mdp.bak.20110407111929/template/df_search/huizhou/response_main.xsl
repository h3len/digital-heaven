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
        <span width="100%" dock="top">
          <span width="100%">
            <img src="top.gif"/>
          </span>
        </span>
        <xsl:apply-templates select ="//div[@id='content']"/>
        <br/>
        <br/>
        <xsl:apply-templates select ="//date"/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>

  <!--格式化的东西-->
  <xsl:template match="img">
    <br/>
    <img src="?action=viewimageremote@mdp&amp;url={$sfmz}/images{substring-after(@src,'images')}&amp;nologin=true"/>
    <xsl:if test="@class='logo'">
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="a">
    <xsl:choose>
      <xsl:when test ="contains(.,'首页') or contains(.,'服务页面')"/>
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

  <xsl:template match="input">
    <xsl:choose>
      <xsl:when test ="@name='Submit'">
        <input type="submit" name="查询" value="查询" caption="查询"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&#160;</xsl:text>
        <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="br">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match="p">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <xsl:text>&#160;&#160;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match ="div[contains(@style,'height:48px')]"/>
  <xsl:template match ="statuCode"/>
  <xsl:template match ="div[@class='map']"/>

  <xsl:template match="date">
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>
  
  <xsl:template match ="h4">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <strong>
      <font size="l" color="#000000">
        <xsl:value-of select ="."/>
      </font>
    </strong>
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match ="div[contains(@syle,'color:#333')]">
    <strong>
      <font size="l" color="#000000">
         <xsl:value-of select ="."/>
      </font>
    </strong>
    <br/>
  </xsl:template>

  <xsl:template match="select">
    <xsl:text>&#160;</xsl:text>
    <select name="{@name}">
      <xsl:apply-templates select="option"/>
    </select>
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>
  <xsl:template match="option">
    <option value="{@value}">
      <xsl:value-of select="."/>
    </option>
  </xsl:template>

  <!--过滤掉文字中多余的空白-->
  <xsl:template match="text()[contains(.,'|')]">
    <xsl:value-of select="translate(.,'|','')"/>
  </xsl:template>


  
  
</xsl:stylesheet>
