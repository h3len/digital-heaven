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
              <xsl:apply-templates/>
              <input type="hidden" name="nologin" value="true"/>
            </body>
        </msc>
    </xsl:template>

  <!--结构--><!--
  <xsl:template match="div[@class='heads']">
    <xsl:apply-templates select="/" mode="heads"/>
  </xsl:template>
  <xsl:template match="div[@class='center']">
    <xsl:apply-templates select="/" mode="center"/>
  </xsl:template>-->
  
  

  
  
  
<!--格式化的东西-->
  <xsl:template match="img">
    <br/>
    <xsl:choose>
      <xsl:when test="contains(@src,'..')">
        <img src="?action=viewimageremote@mdp&amp;url=http://218.204.223.149:4044/mlabour/{substring-after(@src,'/')}&amp;nologin=true"/>
      </xsl:when>
      <xsl:otherwise>
        <img src="?action=viewimageremote@mdp&amp;url=http://218.204.223.149:4044{@src}&amp;nologin=true"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@class='logo'">
      <br/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="a">
    <xsl:if test="contains(.,'业务介绍') or contains(.,'资费说明') or contains(.,'业务开通') or contains(.,'业务取消') or contains(.,'在线查询') or contains(.,'使用帮助')">
      <img src="arrow02.png"/>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="contains(.,'返回页顶') or contains(.,'返回主页')">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <a href="?action=bs-transfer@mdp&amp;url=http://218.204.223.149:4044/mlabour/logon.jsp&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:when test="contains(@href,'..')">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <a href="?action=bs-transfer@mdp&amp;url=http://218.204.223.149:4044/mlabour/{substring-after(@href,'/')}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:when test="not(contains(@href,'new'))">
        <a href="?action=bs-transfer@mdp&amp;url=http://218.204.223.149:4044/mlabour/new/{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="?action=bs-transfer@mdp&amp;url=http://218.204.223.149:4044/mlabour/{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="input">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <xsl:template match="form">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="br">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>

  <!--<xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="contains(.,'CopyRight') or contains(.,'广东有限公司')">
        <font size="xs">
          <xsl:apply-templates/>
        </font>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>-->
  
  <xsl:template match="p">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <xsl:text>&#160;&#160;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="h2">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="date">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <font size="xs">
      <xsl:text>当前时间:</xsl:text><xsl:value-of select="."/>
    </font>
  </xsl:template>

  <xsl:template match="statuCode"></xsl:template>
  <xsl:template match="em"></xsl:template>
  
  
    <!--屏蔽的东西-->
  <xsl:template match="title"/>
</xsl:stylesheet>
