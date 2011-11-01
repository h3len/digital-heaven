<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <mdp>
            <tc>
            <url>http://wsnj.gdgs.gov.cn/aiccps/SearchServlet?service=getEntityInfoByPage&amp;corpName=<xsl:value-of select="//param[@key='corpName']/@value"/>&amp;registerNo=<xsl:value-of select="//param[@key='registerNo']/@value"/></url>
            <method>GET</method>
            <encoding>gb2312</encoding>
            <params></params>
          </tc>
    </mdp>
  </xsl:template>

</xsl:stylesheet>