<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../mdp.xsl"/>
    <xsl:template match="/">
      <xsl:choose>
        <xsl:when test ="contains(//body/.,'未采集到任何数据')">
          <msc type="servermsg">
            <msg show="false">未采集到任何数据!</msg>
          </msc >
        </xsl:when>
        <xsl:otherwise>
          <msc type="form" nologin="true" action="">
            <head>
              <title>
                <xsl:value-of select="//title"/>
              </title>
            </head>
            <body>
              <xsl:apply-templates/>
            </body>
          </msc>
        </xsl:otherwise>
      </xsl:choose>
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
    <xsl:choose>
      <xsl:when test ="contains(.,'首页') or contains(.,'服务页面')"/>
      <xsl:when test="contains(@href,'#top')">
        <a href="?action=bs-transfer@mdp&amp;url={//url}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
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
  <xsl:template match ="div[@class='right']"/>
  
  <xsl:template match="date">
    <font size="s">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>

  <!--过滤掉文字中多余的空白-->
  <xsl:template match="text()[contains(.,'|')]">
    <xsl:value-of select="translate(.,'|','')"/>
  </xsl:template>
</xsl:stylesheet>
