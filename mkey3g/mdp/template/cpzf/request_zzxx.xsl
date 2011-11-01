<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>

  <xsl:template match="/">
    <mdp>
      <xsl:choose>
        <xsl:when test ="//param[@key='keyid']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请选择关键字</msg>
          </msc>
        </xsl:when>
        <!--<xsl:when test ="//param[@key='keyword']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入搜索条件</msg>
          </msc>
        </xsl:when>-->
        <xsl:otherwise>
          <tc>
            <url>
              <xsl:value-of select="$cp_url"/>
              <xsl:text>/newver/07renxian/zzxx.asp</xsl:text>
            </url>
            <method>POST</method>
            <encoding>gb2312</encoding>
            <params>
              <xsl:apply-templates select="//param"/>
            </params>
          </tc>
        </xsl:otherwise>
      </xsl:choose>
    </mdp>
  </xsl:template>

  <xsl:template match="param">
    <param key="{@key}" value="{@value}"/>
  </xsl:template>


  

</xsl:stylesheet>
