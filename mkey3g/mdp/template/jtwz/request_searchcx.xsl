<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <mdp>
            <tc>
            <url>http://weizhang.jmjgj.gov.cn/weizhang.asp</url>
            <method>post</method>
            <encoding>gb2312</encoding>
            <params><xsl:apply-templates select="//param"/></params>
          </tc>
    </mdp>
  </xsl:template>
  <xsl:template match="param">
    <param key="{@key}" value="{@value}"/>
  </xsl:template>
</xsl:stylesheet>