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
          <img src="gaoya_index.png"/>
          <br/>&#160;<br/>
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
          <hr/>
          <strong>作品展示</strong>
          <!--内容-->
          <xsl:apply-templates select="//table[@class='xzy']/tr/td/table[2]"/>
          <hr/>
          <!--分页-->
          <xsl:apply-templates select="//table[@class='s']"/>
        </font>
      </body>
    </msc>
  </xsl:template>

  <!--a标签-->
  <xsl:template match="a">
    <xsl:variable name ="href">
      <xsl:call-template name ="ReplaceAll">
        <xsl:with-param name ="content" select="@href"/>
        <xsl:with-param name="str">&amp;</xsl:with-param>
        <xsl:with-param name="replacement">%26</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="img">
        <img src="?action=viewimageremote@mdp&amp;url=http://www.chinagaoya.com/photos/{img/@src}&amp;nologin=true"/>
      </xsl:when>
      <!--首页-->
      <xsl:when test="text()='首页'">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/{$href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <!--上一页-->
      <xsl:when test="text()='上一页'">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/{$href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <!--下一页-->
      <xsl:when test="text()='下一页'">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/{$href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <!--末页-->
      <xsl:when test="text()='末页'">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/{$href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/{@href}&amp;nologin=true">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--tr的排版-->
  <xsl:template match="tr/td">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
