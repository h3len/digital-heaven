<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <msc type="form">
        <head>
            <title>
                <xsl:choose>
                    <xsl:when test="//title/.!=''">
                        <xsl:value-of select="//title/."/>
                    </xsl:when>
                    <xsl:otherwise>
                    东莞金盾测试
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        <!--行政公告-->
        <span width="100%" height="21px" bgcolor="#ffefd4">行政公告</span>
            <xsl:apply-templates select ="//form[@id='formItem']/table/tr[position()&lt;16]" mode="gsxw1"/>
        </body>
    </msc>
  </xsl:template>
  
   <xsl:template match="a" mode="gsxw">
        <a href="{$ip_url}/{@href}">
            <xsl:choose>
				<xsl:when test ="string-length(.)&gt;16">
				  <xsl:value-of select ="substring(.,1,14)"/>..
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select ="."/>
				</xsl:otherwise>
			  </xsl:choose>
        </a>
        <br/>
    </xsl:template>
    
    <xsl:template match="tr" mode="gsxw1">
		<xsl:apply-templates select="./td[2]/img" mode="gsxw2"/>
    	<xsl:apply-templates select="./td[2]/a" mode="gsxw"/>
  	</xsl:template>
  
  <xsl:template match="img" mode="gsxw2">
    <img src="{$ip_url}/{@src}" /> 
  </xsl:template>


</xsl:stylesheet>