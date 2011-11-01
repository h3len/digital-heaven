<?xml version="1.0" encoding="utf-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
	<xsl:apply-templates select="dir">
        <xsl:sort select="." order="ascending"/>
    </xsl:apply-templates>
</xsl:template>
<xsl:template match="dir">
	<xsl:element name="div">
		<xsl:attribute name="id">pid<xsl:value-of select="@path"/></xsl:attribute>
		<xsl:attribute name="style">display:;padding-left:10px</xsl:attribute>
			<xsl:element name="nobr">
				<xsl:element name="span">
					<xsl:attribute name="class">container</xsl:attribute>
						<xsl:choose>
							<xsl:when test="@childcount &gt; 0">
								<xsl:element name="span">
									<xsl:attribute name="class">clsCollapse</xsl:attribute>
									<xsl:attribute name="status"></xsl:attribute>
									<xsl:attribute name="onclick">javascript:hideshow(this,"<xsl:value-of select="@path"/>","<xsl:value-of select="@possess"/>")</xsl:attribute>
									<img src="../images/icons/Tplus.png" border="0"/><img src="../images/icons/folder.png" border="0"/>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="span">
									<xsl:attribute name="class">clsLeaf</xsl:attribute>
									<img src="../images/icons/Tminus.png" border="0"/><img src="../images/icons/openfolder.png" border="0"/>
								</xsl:element>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:element>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				<xsl:element name="span">
					<xsl:attribute name="class">clsLabel</xsl:attribute>
					<xsl:attribute name="href"><xsl:value-of select="@path"/>&amp;<xsl:value-of select="@possess"/></xsl:attribute>
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:element>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>