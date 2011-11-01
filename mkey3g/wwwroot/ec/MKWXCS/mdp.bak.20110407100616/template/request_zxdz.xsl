<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
    <xsl:template match="/">
        <mdp>
            <tc>
                <url>
                    http://www.gdsin.net/dizhenzhenqing/dzbigseis.asp
                </url>
                <method>POST</method>
                <encoding>gb18030</encoding>
                <params>
                    <!--<xsl:apply-templates select="//param"/>-->
                    <param key="nian" value="{//param[@key='nian']/@value}"/>
                </params>
            </tc>
        </mdp>
    </xsl:template>
</xsl:stylesheet>