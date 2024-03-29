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
                        <!--录入时间-->
                        <span width="100%" bgcolor="#E6F2FF">
                            <xsl:value-of select="translate(//body/table[1]/tr/td[2]/table/tr[3]/td[1],'    ','')"/>
                            <br/>
                            <xsl:value-of select="//body/table[1]/tr/td[2]/table/tr[3]/td[2]"/>
                        </span>
                        <hr/>
                        <!--文章内容-->
                        <span width="100%" align="center">
                            <font size="4">
                                <strong>
                                    <xsl:value-of select="//font[@size='4']"/>
                                </strong>
                            </font>
                        </span>
                        <br/>
                        <br/>
                        <span width="100%" align="center">
                            <font size="2">
                                <xsl:value-of select="//font[@size='2']"/>
                            </font>
                        </span>
                        <span width="100%" align="center">
                            <xsl:value-of select="//td[@class='text1']"/>
                        </span>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>