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
                        <!--<img src="zwgk.png"/><br/>-->
                        <span width="100%" align="center">
                            <br/>
                            <font size="l">
                                <strong>广东省地震局政府信息公开目录</strong>
                            </font>
                        </span>
                        <hr/>
                        <xsl:apply-templates select="//td[@width='622']/div/table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tr">
        <span width="100%">
            <xsl:choose>
                <xsl:when test="position() mod 2 ='0'">
                    <xsl:value-of select="."/>
                    <hr/>
                </xsl:when>
                <xsl:when test="position() mod 2 ='1' and position()&gt;1">
                    <xsl:apply-templates select="td/table/tr/td[2]"/>
                    <hr/>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="td">
        <span width="100%">
            <xsl:choose>
                <xsl:when test="p/span[2]/span/a/@onmouseout">
                    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/ZwGk/{p/span[2]/span/a/@href}&amp;nologin=true">
                        <xsl:value-of select="."/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/ZwGk/{p/span/span[2]/a/@href}&amp;nologin=true">
                        <xsl:value-of select="."/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
</xsl:stylesheet>
