<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>

  <xsl:template match="/">
    <mdp>
      <xsl:choose>
        <xsl:when test ="//param[@key='chkcode']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入验证码</msg>
          </msc>
        </xsl:when>
        <xsl:when test ="//param[@key='Q_Name']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入姓名</msg>
          </msc>
        </xsl:when>
        <xsl:when test ="//param[@key='Q_sType']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入信件的性质</msg>
          </msc>
        </xsl:when>
        <xsl:when test ="//param[@key='Q_title']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入标题</msg>
          </msc>
        </xsl:when>
        <xsl:when test ="//param[@key='Q_Content']/@value=''">
          <msc type="servermsg">
            <msg show="true"  buttonstyle="OK" style="warning">请输入内容</msg>
          </msc>
        </xsl:when>
        <xsl:otherwise>
          <tc>
            <url>
              <xsl:value-of select="$cp_url"/>
              <xsl:text>/newver/07renxian/Add_Question_ToDB.asp</xsl:text>
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
