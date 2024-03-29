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
                                <xsl:value-of select="//td[@class='bt']/div"/>
                            </strong>
                        </span>
                        <hr/>
                        <!--阅读次数-->
                        <span width="100%" align="center">
                            <xsl:value-of select="//table/tr[2]/td[1]"/>：<xsl:value-of select="//table/tr[2]/td[2]"/>
                        </span>
                        <!--更新时间-->
                        <span width="100%" align="center">
                            <xsl:value-of select="//table/tr[2]/td[3]"/>：<xsl:value-of select="//table/tr[2]/td[4]"/>
                        </span>
                        <hr/>
                        <xsl:apply-templates select="//tr[3]/td"/>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="td">
        <span width="100%">
            <!--<xsl:value-of select="."/>-->
            <xsl:choose>
                <xsl:when test="contains(.,./img)">
                    <xsl:apply-templates select="div/a/img"/>
                  <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="img">
        <span width="100%" align="center">
            <img src="?action=viewimageremote@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/{@src}&amp;nologin=true"/>
            <br/>
            <br/>
            <br/>
        </span>
    </xsl:template>

  <xsl:template match ="br">
    <br/>
  </xsl:template>
</xsl:stylesheet>
