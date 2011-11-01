<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="contains(//url,'?show=table')">
        <msc type="table">
          <table>
            <xsl:apply-templates select="//table[@class='text']/tbody/tr" mode="table"/>
          </table>
        </msc>
      </xsl:when>
      <xsl:otherwise>
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
              当前位置：<a href="http://www.cp.gov.cn/">首  页</a>&#160;&gt;&#160;政务公开&#160;&gt;&gt;
            </span>
            <hr/>
            <xsl:apply-templates select="//td[@class='wenzhang12']"/>
            <xsl:text>&#160;&#160;</xsl:text>
            <a href="http://www.cp.gov.cn/">返回首页</a>
          </body>

        </msc>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="a">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>

  <xsl:template match="td">
    <xsl:apply-templates/>
    <xsl:if test ="position() = 2">
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="table[@id='mytable']">
    <span width="100%" bgcolor="#cccccc">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--表格显示-->
  <xsl:template match="table[@class='text']">
    <xsl:choose>
      <xsl:when test ="tbody">
        <br/>&#160;<br/>
        <span width="100%" align="center">
          <input type="button" href="{//url}?show=table" caption="点击查看表格"/>
        </span>
        <br/>&#160;<br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tr" mode="table">
    <tr>
      <xsl:apply-templates select="td" mode="table"/>
    </tr>
  </xsl:template>

  <xsl:template match="td" mode="table">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>



</xsl:stylesheet>
