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
              <xsl:text>http://m.wxcsmz.com/wapquery/menu/sfinterfaceinfo.jsp</xsl:text>
            </url>
            <method>POST</method>
            <encoding>utf-8</encoding>
            <params>
              <xsl:apply-templates select ="//param"/>
            </params>
          </tc>
    </mdp>
  </xsl:template>

  <xsl:template match ="param">
    <!--<xsl:choose>
      <xsl:when test ="@key='nologin'"/>
      <xsl:otherwise>-->
        <param key="{@key}" value="{@value}"/>
      <!--</xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
</xsl:stylesheet>
