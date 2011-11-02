<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <mdp>
            <tc>
            <url>http://weizhang.jmjgj.gov.cn/weizhang.asp</url>
            <method>POST</method>
            <encoding>gb2312</encoding>
            <params><xsl:apply-templates select="//param"/></params>
          </tc>
    </mdp>
	<body>
		查询结果
	</body>
  </xsl:template>
  <xsl:template match="param">
    <param key="{@key}" value="{@value}"/>
  </xsl:template>
</xsl:stylesheet>