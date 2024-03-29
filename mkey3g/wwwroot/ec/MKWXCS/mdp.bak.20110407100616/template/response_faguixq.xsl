<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
    <xsl:template match="/">
        <xsl:choose>
            <!--网络连接失败-->
            <xsl:when test="//statuCode='-1'">
                <msc type="servermsg">
                    <msg buttonstyle="OK" show="true">网络连接失败</msg>
                </msc>
            </xsl:when>

            <xsl:otherwise>
                <msc type="form" action="">
                    <head>
                        <title>系统导航</title>
                    </head>
                    <body>
                        <xsl:call-template name="ss"/>
                        <input type="hidden" name="nologin" value="true"/>
                        <br/>
                        <span width="100%">
                            <span width="100%" align="center">地震法规</span>
                            <hr color="#000000"/>
                            <span width="100%">
                                <xsl:value-of select="//body/table/tr[3]"/>
                            </span>
                            <span width="100%">
                                <xsl:value-of select="//body/table/tr[4]"/>
                            </span>
                            <span width="100%">
                                <xsl:value-of select="//body/table/tr[5]"/>
                            </span>
                            <span width="100%">
                                <xsl:value-of select="//body/table/tr[6]"/>
                            </span>
                            <span width="100%">
                                <xsl:value-of select="//body/table/tr[7]"/>
                            </span>
                            <hr color="#000000"/>
                        </span>
                        <!--内容-->
                        <xsl:value-of select="//body/table/tr[9]"/>
                        
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>