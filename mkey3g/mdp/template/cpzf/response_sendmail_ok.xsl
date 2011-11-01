<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test ="//div[@id='servermsg_ok']">
        <msc type="servermsg">
          <msg>
            <xsl:apply-templates select="//div[@id='servermsg_ok']/@value"/>
          </msg>
          <!--<script>
            application.getActiveWindow().location.href='http://www.cp.gov.cn/';
          </script>-->
        </msc>
      </xsl:when>
      <xsl:when test ="//font">
        <msc type="servermsg">
          <msg>
            <xsl:value-of select="//font"/>
          </msg>
          <!--<script>
            application.getActiveWindow().location.href='http://www.cp.gov.cn/newver/07renxian/sendmail2.asp';
          </script>-->
        </msc>
      </xsl:when>
      <xsl:otherwise>
        <msc type="servermsg">
          <msg>
            提交有误,请重新操作！
          </msg>
          <!--<script>
            application.getActiveWindow().location.href='http://www.cp.gov.cn/newver/07renxian/sendmail2.asp';
          </script>-->
        </msc>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
