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
                        <span width="100%">
                            <strong>地震专题</strong>
                        </span>
                        <br/>
                        <xsl:apply-templates select="//body/div/center/table/tr[2]/td/div[1]/table/tr" mode="one"/>
                        <hr/>
                        <span width="100%">
                            <strong>历史地震专题</strong>
                        </span>
                        <br/>
                        <xsl:apply-templates select="//body/div/center/table/tr[2]/td/div[2]/table/tr" mode="two"/>
                        <hr/>
                        <span width="100%">
                            <strong>地震知识</strong>
                        </span>
                        <br/>
                        <xsl:apply-templates select="//body/div/center/table/tr[2]/td/div[3]/table/tr" mode="three"/>
                        <hr/>
                        <span width="100%">
                            <strong>地震问答</strong>
                        </span>
                        <br/>
                        <xsl:apply-templates select="//body/div/center/table/tr[2]/td/div[4]/table/tr" mode="three"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--地震专题的链接-->
    <xsl:template match="tr" mode="one">
        <xsl:choose>
            <xsl:when test="td/a">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzt/{td/a/@href}&amp;nologin=true">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
    </xsl:template>
    <!--历史地震专题的链接-->
    <xsl:template match="tr" mode="two">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhuanti/dizhenztll.asp?strid={td/a/font}&amp;nologin=true">
            <xsl:value-of select="."/>
        </a>
        <br/>
    </xsl:template>
    <!--地震知识的链接-->
    <xsl:template match="tr" mode="three">
        <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net{substring-after(td/a/@href,'..')}&amp;nologin=true">
            <xsl:value-of select="."/>
        </a>
        <br/>
    </xsl:template>
</xsl:stylesheet>