<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" action="">
      <head>
      </head>
      <body>
          <xsl:call-template name="ss"/>
        <xsl:apply-templates select="//table/tr[3]"/>
        <xsl:apply-templates select="//td[@class='text1']"/>
      </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>