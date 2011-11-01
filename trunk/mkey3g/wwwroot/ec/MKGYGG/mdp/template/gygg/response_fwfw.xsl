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
            <!--公司简介-->
            <xsl:when test="//url[contains(text(),'gsjj.asp')]">
              <img src="gaoya_index.png"/><br/>&#160;<br/>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
              <hr/>
              <strong>公司简介</strong>
              <br/>&#160;<br/>
            </xsl:when>
            <!--其他-->
            <xsl:otherwise>
              <img src="gaoya_index.png"/><br/>&#160;<br/>
              <!--头部-->
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">常规服务</a>|
              <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service1.asp&amp;nologin=true">高端服务</a>
              <hr/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="//table[@width='95%']"/>
        </font>
      </body>
    </msc>
  </xsl:template>



  <!--p标签-->
  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="text()='　'"/>
      <xsl:otherwise>
        <br/>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--img标签-->
  <xsl:template match="img">
    <img src="?action=viewimageremote@mdp&amp;url=http://www.chinagaoya.com/{@src}&amp;nologin=true"/>
  </xsl:template>

  <!--b标签-->
  <xsl:template match="b">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

</xsl:stylesheet>
