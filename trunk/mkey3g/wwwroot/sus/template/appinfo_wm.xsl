<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="msc">
	<msc type="form" id="homepage"  showHead="true" showFoot="true">
	<head></head>
	<body bgcolor="#FFFFFF" margin="0">
		 <xsl:apply-templates select="/msc/body/span"></xsl:apply-templates>
	</body>
	<foot>
       <item id="chaoshiButton" type="button" caption="返　回" align="primary"><xsl:attribute name="href"><xsl:value-of select="/msc/body/@backurl"/></xsl:attribute></item>
  	</foot>
</msc>
</xsl:template>
<xsl:template match = "span">
	<span height="19%" width="100%" background="img/detial_top_bg.png" >
			<span width="5%"></span>
			<span width="30%" align="left" valign="center" height="19%"><img src="{@icon}"/></span>
			<span width="65%" valign="center" height="19%">
				<span width="100%" height="5%"></span>
				<font size="xl"><xsl:value-of select="@appname"/></font>
			</span>
		</span>
		<span width="100%" height="19%" align="center" valign="center"><input type="image" src="img/button_jr.png" src_down="img/button_jr_.png" src_focus="img/button_jr_.png" href="{@downloadurl}"/></span>
		<span width="100%">
			<span width="20%"/>
			<span width="70%"/>
		<span width="100%" align="left" >
			<xsl:value-of select="@comment"/><br/>
		</span>
		<span width="90%">
        	<span align="left">
        	<xsl:for-each select="preimg">
        		<img src="{@appimage}"/>
        	</xsl:for-each>
        	</span>
        </span>
		</span>
</xsl:template>
</xsl:stylesheet>

