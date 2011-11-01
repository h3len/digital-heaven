<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>
  
  <xsl:template match="/">
    <msc type="form" action="">
      <head>
        <title>
          <xsl:value-of select="//title"/>
        </title>
      </head>
      <body>
        <!--logo-->
        <xsl:call-template name="title"/>
        <span width="100%" height="48px" bgcolor="#fef1e1">
          <br/>
          当前位置：<a href="http://www.cp.gov.cn/">首  页</a>&#160;&gt;&#160;镇长信箱&#160;&gt;&gt;
        </span>
        <hr/>
        <xsl:apply-templates select="//body/table[5]/tbody/tr[2]/td[2]/table[2]/tbody/tr[3]/td/table"/>
      </body>

    </msc>
  </xsl:template>


  <xsl:template match="tr">
    <xsl:apply-templates/>
    <span width="100%" height="6px"/>
  </xsl:template>

  <xsl:template match="a">
    <xsl:text>&#160;</xsl:text>
    <xsl:choose>
      <xsl:when test ="contains(@href,'http://')">
        <a href="{@href}">
          <xsl:value-of select ="."/>
        </a>
      </xsl:when>
      <xsl:when test="contains(@href,'/')">
        <a href="{$cp_url}{@href}">
          <xsl:value-of select ="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$cp_url}/newver/07renxian/{@href}">
          <xsl:value-of select ="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- select标签模板 -->
  <xsl:template match="select">
    <select name="{@name}" caption="{@caption}">
      <xsl:apply-templates select="option"/>
    </select>
  </xsl:template>
  <!-- option标签模板 -->
  <xsl:template match="option">
    <option value="{@value}">
      <xsl:if test ="@selected and @selected='selected'">
        <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </option>
  </xsl:template>

  <xsl:template match="input[@type='Hidden']">
    <input type="hidden" name="{@name}" value="{@value}"/>
  </xsl:template>

  <xsl:template match="strong">
    <xsl:choose>
      <xsl:when test ="a">
        <xsl:apply-templates select="a"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
