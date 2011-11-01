<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form">
      <head>
        <title>
        </title>
      </head>
      <body bgcolor="#CCCCCC">
        <font size="s">
          <xsl:choose>
            <!--详情-->
            <xsl:when test="//url[contains(text(),'onews.asp')]">
              <img src="gaoya_index.png"/>
              <br/>&#160;<br/>
              <!--返回首页-->
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
              <hr/>
              <!--正文-->
              <xsl:apply-templates select="//body/table/tr/td/table/tr/td/table[2]" mode="xiangqing"/>
            </xsl:when>
            <!--诚聘精英-->
            <xsl:when test="//url[contains(text(),'otype1.asp')]">
              <img src="gaoya_index.png"/>
              <br/>&#160;<br/>
              <!--返回首页-->
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
              <hr/>
              <!--正文-->
              <strong>诚聘精英</strong>
              <br/>
              <xsl:apply-templates select="//body/table/tr/td[2]/table[2]" mode="zhuye"/>
            </xsl:when>
            <!--最新动态-->
            <xsl:otherwise>
              <img src="gaoya_index.png"/>
              <br/>&#160;<br/>
              <!--首页-->
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
              <hr/>
              <!--正文-->
              <xsl:apply-templates select="//body/table/tr/td[2]/table[2]" mode="zhuye"/>
            </xsl:otherwise>
          </xsl:choose>
        </font>
      </body>
    </msc>
  </xsl:template>

  <!--主页tr排版-->
  <xsl:template match="tr" mode="zhuye">
    <xsl:choose>
      <xsl:when test="position()=1">
        <xsl:choose>
          <xsl:when test="td/a/strong">
            <strong>最新动态</strong>
            <br/>
          </xsl:when>
          <xsl:otherwise>
            <img src="an.png"/>
            <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/{td/a/@href}&amp;nologin=true">
              <xsl:value-of select="td/a"/>
            </a><xsl:value-of select="td/font"/>
            &#160;&#160;<br/><br/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="position()=2">
        <xsl:choose>
          <xsl:when test="td/a">
            <img src="an.png"/>
            <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/{td/a/@href}&amp;nologin=true">
              <xsl:value-of select="td/a"/>
            </a>
            <xsl:value-of select="td/font"/>
            <br/>
          </xsl:when>
          <xsl:otherwise>
            &#160;<br/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@valign='bottom'">
        <!--分页-->
      </xsl:when>
      <xsl:otherwise>
        <img src="an.png"/>
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/{td/a/@href}&amp;nologin=true">
          <xsl:value-of select="td/a"/>
        </a>
        <xsl:value-of select="td/font"/>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--详情的排版-->
  <xsl:template match="tr" mode="xiangqing">
    <xsl:choose>
      <xsl:when test="position()=1">
        <strong>
          <xsl:apply-templates/>
        </strong>
        <br/>&#160;<br/>
      </xsl:when>
      <xsl:when test="position()=2">
        <xsl:value-of select="td[2]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--p标签的排版-->
  <xsl:template match="p">
    <br/>&#160;
    <xsl:apply-templates/>
  </xsl:template>
  <!--屏蔽a标签-->
  <xsl:template match="a"/>

  <!--b标签的排版-->
  <xsl:template match="b">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

</xsl:stylesheet>
