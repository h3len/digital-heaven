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
        <!--工商新闻-->
        <span width="100%" height="21px" bgcolor="#ffefd4">工商新闻</span>
            <xsl:apply-templates select="//a[@class='menu4' and contains(@href,'id=25000053')]" mode="gsxw"/>
        <!--政务信息-->
        <span width="100%" height="21px" bgcolor="#ffefd4">政务信息</span>
            <xsl:apply-templates select="//a[@class='menu' and contains(@href,'id=30000105')]" mode="gsxw"/>
        <!--媒体视角-->
        <span width="100%" height="21px" bgcolor="#ffefd4">媒体视角</span>
            <xsl:apply-templates select="//a[@class='menu' and contains(@href,'id=25000054')]" mode="gsxw"/>
        <!--消费警示-->
        <span width="100%" height="21px" bgcolor="#ffefd4">消费警示</span>
            <xsl:apply-templates select ="//form[@id='formItem']/table/tbody/tr[position()&lt;6]" mode="gsxw1"/>
        <!--行政公告-->
        <span width="100%" height="21px"><a href="http://www.dgaic.gov.cn/item.jsp?id=25000046&amp;name=行政公告&amp;type=1">政务公告</a></span>
        <!--企业基本登记信息查询-->
        <span width="100%" height="21px"><a href="http://wsnj.gdgs.gov.cn/aiccps/jsp/pub/searchBase.jsp?returnUP=true">企业基本登记信息查询</a></span>
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
  	
  	<xsl:template match="tr" mode="gsxw3">
		<xsl:apply-templates select="./td[2]/img" mode="gsxw2"/>
    	<xsl:apply-templates select="./td[2]/a" mode="gsxw"/>
  	</xsl:template>
  
  <xsl:template match="img" mode="gsxw2">
    <img src="{$ip_url}/{@src}" /> 
  </xsl:template>


</xsl:stylesheet>