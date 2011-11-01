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
        <img src="gaoya_index.png"/><br/>&#160;<br/>
        <font size="s">
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/gsjj.asp&amp;nologin=true">首页</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/service2.asp&amp;nologin=true">服务范围</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype.asp?owen1=最新动态&amp;nologin=true">最新动态</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/photos/type.asp?typeid=26&amp;nologin=true">作品栏</a>|
          <a href="?action=bs-transfer@mdp&amp;url=http://www.chinagaoya.com/otype1.asp?owen1=诚聘英才&amp;nologin=true">诚聘英才</a>
          <hr/>
          <strong>作品显示</strong>
          <br/>
          <xsl:apply-templates select="//table[@class='bk1']"/>
          <br/>
          <xsl:apply-templates select="//table[@class='bk' and @cellpadding='3']/tr/td[1]"/>
        </font>
      </body>
    </msc>
  </xsl:template>

  <xsl:template match="img">
    <img src="?action=viewimageremote@mdp&amp;url=http://www.chinagaoya.com/photos/{@src}&amp;nologin=true"/>
  </xsl:template>


</xsl:stylesheet>
