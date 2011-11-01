<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="mdp.xsl"/>
  <xsl:template match="/">
    <mdp>
        <xsl:choose>
            <xsl:when test ="//param[@key='page']/@value=''">
                <msc type="servermsg">
                    <msg show="true"  buttonstyle="OK" style="warning">请输入页码</msg>
                </msc>
            </xsl:when>
            <xsl:otherwise>
                <tc>           
                    <url>
                        <!--<xsl:choose>
                            <xsl:when test="contains(//param[@key='sky']/@value,'channalid')">-->
         <xsl:value-of select ="//param[@key='sky']/@value"/>=<xsl:value-of select ="//param[@key='channalid']/@value"/>&amp;Page=<xsl:value-of select="//param[@key='page']/@value"/>
                            <!--</xsl:when>
                            <xsl:otherwise>
                            
                            </xsl:otherwise>
                        </xsl:choose>-->
                    </url>
                    <method>GET</method>
                    <encoding>gb2312</encoding>
                    <params/>
                </tc>
            </xsl:otherwise>
        </xsl:choose>
    </mdp>
  </xsl:template>
  

 
</xsl:stylesheet>
