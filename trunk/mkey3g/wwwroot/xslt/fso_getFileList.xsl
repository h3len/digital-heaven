<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table border="0" cellpadding="0" cellspacing="1" width="100%">
<TBODY>
	<xsl:apply-templates select="file[position() &lt; 6]">
        <xsl:sort select="datelastmodified" order="descending"/>
    </xsl:apply-templates>
</TBODY>
</table>
</xsl:template>
<xsl:template match="file">
<tr><td>
<xsl:apply-templates select="name"/>
</td></tr>
</xsl:template>
<xsl:template match="name">
	<img src="../images/doc.gif" align="absmiddle"/><xsl:text> </xsl:text>
	<xsl:element name="a">
		<xsl:attribute name="href"><xsl:value-of select="parent::file/url"/></xsl:attribute>
		<xsl:attribute name="target">_blank</xsl:attribute>
		<xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
		<xsl:attribute name="class">aforbg</xsl:attribute>
		<xsl:choose>
			<xsl:when test="string-length() > 8">
				<xsl:value-of select="substring(.,1,8)"/>...
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>
</xsl:template>
</xsl:stylesheet>