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
                        <strong>
                            <xsl:value-of select="//td[@width=219]/div"/>
                        </strong>
                        <xsl:apply-templates select="//table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--政务新闻-->
    <xsl:template match="tr">
        <xsl:choose>
            <xsl:when test="position()&gt;3">
                <xsl:apply-templates select="td/table/tr/td"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="td">
        <xsl:choose>
            <xsl:when test="@bgcolor='#CCCCCC'">
                <span width="100%" bgcolor="#cccccc">
                    <font color="#ff0000">
                        <xsl:value-of select="."/>
                    </font>
                </span>
            </xsl:when>
            <xsl:when test="./a">
                <a target="_blank" href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/{./a/@href}&amp;nologin=true">
                    <xsl:value-of select="./a"/>
                    <font color="#ff0000">
                        <xsl:value-of select="./font"/>
                    </font>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        <hr/>
    </xsl:template>
</xsl:stylesheet>