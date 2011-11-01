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
  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="input">
        <xsl:apply-templates mode="p"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="p"/>
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <a href="?action=bs-transfer@mdp&amp;url=http://210.73.44.165/search/accumulationFund/accumulationFundSearch.jsp&amp;nologin=true">返回查询页面</a>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  

  
  
  
<!--格式化的东西-->
  <xsl:template match="img" mode="p">
    <br/>
        <img src="?action=viewimageremote@mdp&amp;url=http://210.73.44.165{@src}&amp;nologin=true"/>
  </xsl:template>
  
  <!--文字-->
  <xsl:template match="text()" mode="p">
    <xsl:choose>
      <xsl:when test="contains(.,'：') or contains(.,'@') or contains(.,'申请注册') or contains(.,':') or position()=8">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="a" mode="p">
    <xsl:if test="contains(.,'http')">
      <a href="">
        <xsl:value-of select="."/>
      </a>
    </xsl:if>

  </xsl:template>

  <xsl:template match="input" mode="p">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>

  <!--好爽的提交按钮-->
  <xsl:template match="go" mode="p">
    <input type="submit" name="submit" caption="提交"/>
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
  
</xsl:stylesheet>
