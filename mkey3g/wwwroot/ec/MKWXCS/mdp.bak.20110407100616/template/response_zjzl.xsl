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
                        <!--头像-->
                        <span width="100%" align="center">
                            <img src="?action=viewimageremote@mdp&amp;url=http://www.gdsin.net{//img/@src}&amp;nologin=true"/>
                        </span>
                        <!--姓名-->
                        <span width="100%" align="center">
                            <xsl:value-of select="//div[@class='black']"/>
                        </span>
                        <hr/>
                        <!--阅读次数-->
                        <span width="100%" bgcolor="#FFDE78">
                            <span width="50%">
                                <xsl:value-of select="//span[@class='text11']"/>
                            </span>
                            <span width="50%">
                                <xsl:value-of select="//span[@class='title9pt1']/.."/>
                            </span>
                        </span>
                        <hr/>
                        <span width="100%">
                            <xsl:value-of select="//body/table[1]/tbody/tr[2]"/>
                        </span>
                        <span width="100%">
                            <br/>
                            专家文章：
                        </span>
                        <span width="100%" align="center">
                            <xsl:apply-templates select="//table[1]/tbody/tr[1]/td/div/table[2]/tr"/>
                        </span>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--专家文章列表-->
    <xsl:template match="tr">
        <span width="100%">
            <xsl:choose>
                <xsl:when test="position()&lt;last()">
                    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhuanjia/{td/a/@href}&amp;nologin=true">
                        <xsl:value-of select="."/>
                    </a>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>
</xsl:stylesheet>