<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:import href="../../mdp.xsl"/>

  <!--
        @author       || 熊彬
        @date         || 2010-12-15
        @description  || 广东无线城市
    -->
  
  <xsl:template match="/">
    <mdp>
          <tc>
            <url>
              <xsl:text>http://yfwap.uyunfu.com/Sfinfo.aspx?hh=</xsl:text>
              <xsl:value-of select ="//param[@key='hh']/@value"/>
            </url>
            <method>GET</method>
            <encoding>utf-8</encoding>
            <params>
            </params>
          </tc>
    </mdp>
  </xsl:template>

</xsl:stylesheet>
