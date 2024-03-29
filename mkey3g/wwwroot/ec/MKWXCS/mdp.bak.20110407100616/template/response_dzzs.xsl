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
                        <span width="100%" align="center">
                            <strong>
                                <xsl:value-of select="//table/tr/td/div/table/tr/td[2]/div"/>
                            </strong>
                        </span>
                        <hr/>
                        <span width="100%" bgcolor="#f2f2f2">
                            <xsl:value-of select="//td[@class='text1']"/>
                        </span>
                        <hr/>
                        <xsl:apply-templates select="//table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tr">
        <xsl:choose>
            <xsl:when test="position()&gt;3">
                <xsl:apply-templates select="./td[2]/table/tr" mode="two"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tr" mode="two">
        <span width="100%">
            <xsl:apply-templates select="td"/>
        </span>
    </xsl:template>
    <xsl:template match="td">
        <span width="100%">
            <xsl:choose>
                <xsl:when test="./a">
                    <span width="100%">
                        <a target="_blank" href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhishi/{./a/@href}&amp;nologin=true">
                            <xsl:value-of select="."/>
                        </a>
                    </span>
                    <hr/>
                </xsl:when>
                <xsl:otherwise>
                    <span width="100%">
                        <xsl:value-of select="."/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
</xsl:stylesheet>