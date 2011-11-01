<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="msc">
	<msc type='form' showHead='false' showFoot='false' >
	<body margin='0'>
	<span width="100%" dock="top" background="iphone/iphone_top_bg.png">
      <span width="29%">
        <input type="image" src="iphone/back03.png" src_down="iphone/back03_.png">
        	<xsl:attribute name="href">
        		<xsl:value-of select="body/@backurl"/>
        	</xsl:attribute>
        </input>
      </span>
        <span width="42%" align="center" valign="center">
        <img src="iphone/top_line.png"/><font color="#FFFFFF">业务详情</font>
      </span>
      <span width="29%" align="right">
      </span>
    </span>
    <xsl:apply-templates select="/msc/body/span"></xsl:apply-templates>
  </body>
  </msc>
   </xsl:template>
	<xsl:template match="span">
		<span width="100%" background="img/detial_top_bg.png" height="19%">
      <span width="30%" height="19%" valign="center" align="center">
        <img src="{@icon}"/>
      </span>
      <span width="70%" height="19%" align="left" valign="center">
        <font size="l"><xsl:value-of select="@appname"/></font>
      </span>    
    </span>
    <span width="100%" align="center" valign="center">
      <input type="image" src="img/button_jr.png" src_down="img/button_jr_.png" href="{@downloadurl}"/>
    </span>
    <span width="100%" height="2%"/>
    <span width="100%">
      <span width="5%"/>
      <span width="90%">
        <font size="s" color="#666666">
         <xsl:value-of select="@comment"/><br/>
        </font>
        <span width="90%">
        	<span align="left">
        	<xsl:for-each select="preimg">
        		<img src="{@appimage}"/>
        	</xsl:for-each>
        	</span>
        </span>
      </span>
    </span>
	</xsl:template>
</xsl:stylesheet>

