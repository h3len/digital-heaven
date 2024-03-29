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
                        <span align="center">
                            <strong>
                                <xsl:value-of select="//table[1]/tr/td[2]/div"/>
                            </strong>
                            <hr size="2"/>
                        </span>
                        选择年份: <select name="nian">
                            <xsl:apply-templates select="//option"/>
                        </select>
                        &#160;&#160;<input type="submit" caption="提交"/>
                        <xsl:apply-templates select="//table[1]/tr"/>
                        <hr/>
                        <font color="#aaaaaa" size="s">
                            <xsl:value-of select="//td[@class='jnfont5']/div"/>
                        </font>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="option">
        <option>
            <xsl:attribute name="value">
                <xsl:value-of select="./@value"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </option>
    </xsl:template>
    <!--列表-->
    <xsl:template match="tr">
        <xsl:choose>
            <xsl:when test="position()&gt;5 and position()&lt;last()-1">
                <span width="100%">
                    <hr/>
                    <xsl:apply-templates select="td"/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="td">
            <xsl:choose>
                <xsl:when test="position()=2">
                    <xsl:variable name="po" select="position()"/>
                    <font size="s">
                        <xsl:value-of select="//table/tr[4]/td[$po]"/>：<xsl:value-of select="translate(.,'    ','')"/>
                    </font>
                </xsl:when>
                <xsl:when test="position()=3">
                    <xsl:variable name="po" select="position()"/>
                    <font color="#aaaaaa" size="s">
                        <xsl:value-of select="//table/tr[4]/td[$po]"/>：
                        <xsl:value-of select="translate(.,'    ','')"/>
                    </font>
                </xsl:when>
            </xsl:choose>
    </xsl:template>
</xsl:stylesheet>