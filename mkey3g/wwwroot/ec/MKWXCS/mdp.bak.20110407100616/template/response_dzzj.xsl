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
                            <strong>地震专家</strong>
                        </span>
                        <xsl:apply-templates select="//center/table/tr[2]/td[2]/div/table/tbody/tr/td/table/tr"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--专家信息-->
    <xsl:template match="tr">
        <xsl:choose>
            <xsl:when test="position()&gt;4 and position()&lt;11">
                <xsl:apply-templates select="td/table"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="table">
        <hr/>
        <span align="center">
            <span width="100%" align="center">
                <img src="?action=viewimageremote@mdp&amp;url=http://www.gdsin.net/dizhenzhuanjia/{tr[1]/td/a/img/@src}&amp;nologin=true"/>
            </span>
            <span width="100%" align="center">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhuanjia/dizhenzjxx.asp?id={substring-before(substring-after(tr[2]/td/a/@href,'javascript:zjxx('),')')}&amp;nologin=true">
                <xsl:value-of select="tr[2]/td"/>
                </a>
            </span>
        </span>
    </xsl:template>
</xsl:stylesheet>