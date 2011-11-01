<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" nologin="true" action="">
      <head>
        <title>
          <xsl:value-of select="//card/@title"/>
        </title>
      </head>
      <body>
        <strong>
          <xsl:value-of select="//card/@title"/>
        </strong>
        <br/>
        <xsl:apply-templates/>
        <input type="hidden" name="nologin" value="true"/>
      </body>
    </msc>
  </xsl:template>

  <!--主要内容-->
  <xsl:template match="p[1]">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <strong>
      <xsl:value-of select="."/>
    </strong>
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>
  <xsl:template match="p[2]">
    <xsl:apply-templates mode="p"/>
  </xsl:template>
  <xsl:template match="p[3]">
    <xsl:apply-templates mode="p"/>
  </xsl:template>






  <!--格式化的东西-->
  <xsl:template match="img" mode="p">
    <br/>
    <img src="?action=viewimageremote@mdp&amp;url=http://wap.dggjj.cn/wml/{@src}&amp;nologin=true"/>
  </xsl:template>

  <!--文字-->
  <xsl:template match="text()" mode="p">
    <xsl:choose>
      <xsl:when test="contains(.,'中国移动莞人邮箱') or contains(.,'操作') or contains(.,'：') or contains(.,':') or contains(.,'、')">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="a" mode="p">
    <xsl:choose>
      <xsl:when test="contains(.,'莞人邮箱')">
        <a href="">
          <xsl:value-of select="."/>(<xsl:value-of select="@href"/>)
        </a>
      </xsl:when>
      <xsl:when test="contains(.,'返回首页')">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <!--<a href="?action=bs-transfer@mdp&amp;url=http://wap.dggjj.cn/wml/{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>-->
      </xsl:when>
      <xsl:otherwise>
        <br/>
        <a href="?action=bs-transfer@mdp&amp;url=http://wap.dggjj.cn/wml/{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="input" mode="p">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <!--好爽的提交按钮-->
  <xsl:template match="go" mode="p">
    <input type="submit" name="submit" caption="查询"/>
  </xsl:template>

  <xsl:template match="br" mode="p">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match="date">
    <br/>
    <xsl:text>&#160;</xsl:text>
    <br/>
    <font size="xs">
      <xsl:text>当前时间:</xsl:text>
      <xsl:value-of select="."/>
    </font>
  </xsl:template>

  <xsl:template match="statuCode"></xsl:template>


  <xsl:template match="strong" mode="p">
    <strong>
      <xsl:value-of select="."/>
    </strong>
  </xsl:template>

</xsl:stylesheet>
