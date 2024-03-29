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
                        <span width="100%" align="center">
                            <strong>
                                <xsl:value-of select="//body/table/tr[1]/td/table/tr/td[2]"/>
                            </strong>
                        </span>
                        <xsl:apply-templates select="//body/table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--法规文件列表-->
    <xsl:template match="tr">
        <span width="100%">
            <xsl:choose>
                <xsl:when test="position()&gt;2 and position()&lt;last()">
                    <hr/>
                    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenfagui/dzfaguixx.asp?id={substring-before(substring-after(td[2]/a/@href,'javascript:watchxx('),')')}&amp;nologin=true">
                        <xsl:value-of select="."/>
                    </a>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>
</xsl:stylesheet>