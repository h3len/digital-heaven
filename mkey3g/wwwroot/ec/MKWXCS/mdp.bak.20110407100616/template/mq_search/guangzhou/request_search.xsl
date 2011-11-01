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
          <xsl:text>http://202.108.112.107:48089/?isproxy=t%26pgtype=xhtml/httpecd_cssservices.gzgas.com:8081/service/login.do</xsl:text>
        </url>
        <method>POST</method>
        <encoding>utf-8</encoding>
        <params>
          <xsl:apply-templates select ="//param"/>
        </params>
      </tc>
      <!--<tc>
        <url>
          <xsl:text>http://202.108.112.107:48089/?isproxy=t%26pgtype=xhtml/httpecd_cssservices.gzgas.com:8081/service/home.do?url=</xsl:text>
        </url>
        <method>GET</method>
        <encoding>utf-8</encoding>
        <param/>
      </tc>-->
    </mdp>
  </xsl:template>

  <xsl:template match ="param">
    <xsl:choose>
      <xsl:when test ="@key='forceLogin' or @key='nologin'"/>
      <xsl:otherwise>
        <param key="{@key}" value="{@value}"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
