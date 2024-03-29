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
                            <strong>公示公告</strong>
                        </span>
                        <xsl:apply-templates select="//body/table/tr[3]/td/table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tr">
        <xsl:choose>
            <xsl:when test="position()&gt;1 and position() mod 2 ='0'">
                <hr/>
                <xsl:apply-templates select="td"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="td">
        <xsl:choose>
            <xsl:when test="position()&gt;1 and position()&lt;3">
                <span width="100%">
                    <xsl:variable name="po" select="position()"/>
                    <xsl:value-of select="//body/table/tr[3]/td/table/tr[1]/td[$po]"/>：
                    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhengonggao/{../td[2]/span/a/@href}&amp;nologin=true">
                        <xsl:value-of select="."/>
                    </a>
                </span>
            </xsl:when>
            <xsl:when test="position()=3">
                    <xsl:variable name="po" select="position()"/>
                    <xsl:value-of select="//body/table/tr[3]/td/table/tr[1]/td[$po]"/>：<xsl:value-of select="."/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>