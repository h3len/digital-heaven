<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/root">
  <div class="potaltitle"></div>
	<div class="clear"></div>
	
	<xsl:apply-templates select="//category"></xsl:apply-templates>

  </xsl:template>
  
 <xsl:template match="category">
<div class="index_potal_box">
      <div class="{@logohref} hand" onclick="javascript:location.href='{@url}'">
      </div>
	  <div class="index_title_bug"></div>
	  <div class="left">
	  <a  href="{@url}" title="" class="href_14px_black">
	<xsl:value-of select="@categoryname"/>
	  </a><br />
        <span class="href_12px_gray"><xsl:value-of select="@comment"/><br />
      </span><span class="href_12px_oringe"><span class="href_12px_green"></span></span></div>
   
   </div>
 </xsl:template>
</xsl:stylesheet>

 

