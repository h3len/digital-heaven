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
                        <!--<img src="zwgk.png"/><br/>-->
                        <span width="100%" align="center">
                            <strong>部门介绍</strong>
                        </span>
                        <xsl:apply-templates select="//tr[@id='cat01']/td[2]/table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tr">
        <span width="100%">
            <xsl:apply-templates select="td"/>
        </span>
    </xsl:template>
    <xsl:template match="td">
        <span width="100%">
            <hr/>
            <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/ZwGk/dep.asp?jid={substring-before(substring-after(//tr[@id='cat01']/td[2]/table/tr/td/p/a/@href,'javascript:getdep('),');')}&amp;nologin=true">
                <xsl:value-of select="."/>
            </a>
        </span>
    </xsl:template>
</xsl:stylesheet>