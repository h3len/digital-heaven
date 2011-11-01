<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:template match="/">
    <msc type="form" action="">
      <head>
        <title>ʡ�ڵ���</title>
      </head>
      <body>
          <xsl:call-template name="ss"/>
        <xsl:apply-templates select="//table"/>
      </body>
    </msc>
  </xsl:template>

  <xsl:template match="table/tr[1]">
    <span width="100%" align="center">
      <font size="2" color="#ff0000">�㶫ʡ����ֵ���챨</font><br/>(����ʱ�䣺2011-03-07 15:33:00)
    </span>
    <hr/>
  </xsl:template>

  <xsl:template match="table/tr[position()&gt;1]">
    <xsl:value-of select="td[1]"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="td[2]"/>
    <hr/>
  </xsl:template>
  
</xsl:stylesheet>