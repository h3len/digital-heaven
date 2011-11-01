<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="../../mdp.xsl"/>

    <xsl:template match="/">
        <!--20101222修改_进入订阅方式详情-->
        <mdp>

            <tc>
                <url>
                    <xsl:choose>
                        <!--返回上一级或返回业务首页为post方式时-->
                        <xsl:when test="contains(//param[contains(@key,'jsp')]/@value,'返回')">
                            <xsl:text>http://211.139.201.121</xsl:text>
                        </xsl:when>

                        <!--post的地址为完全路径时-->
                        <xsl:when test="contains(//param/@key,'fspay')">
                            <xsl:choose>
                                <!--地址中第一个字节有'/'的地址-->
                                <xsl:when test="starts-with(//param[contains(@key,'jsp')]/@key,'/')">
                                    <xsl:text>http://211.139.201.121</xsl:text>
                                </xsl:when>
                                <!--地址中第一个字节不是'/'的地址-->
                                <xsl:otherwise>
                                    <xsl:text>http://211.139.201.121/</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>

                        <!--post的地址为相对路径时-->
                        <xsl:otherwise>
                            <xsl:choose>
                                <!--地址中第一个字节有'/'的地址-->
                                <xsl:when test="starts-with(//param[contains(@key,'jsp')]/@key,'/')">
                                    <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post</xsl:text>
                                </xsl:when>
                                <!--地址中第一个字节不是'/'的地址-->
                                <xsl:otherwise>
                                    <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post/</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>

                    </xsl:choose>


                    <!--<xsl:choose>
                                <xsl:when test="contains(//param[contains(@key,'jsp')]/@key,'/wap')">
                                    <xsl:value-of select="substring-before(//param[contains(@key,'jsp')]/@key,'/wap')"/>
                                </xsl:when>
                                <xsl:otherwise>-->
                    <xsl:value-of select="substring-before(//param[contains(@key,'jsp')]/@key,'&amp;')"/>
                    <!--</xsl:otherwise>
                            </xsl:choose>-->
                </url>
                <method>POST</method>
                <encoding>utf-8</encoding>
                <params>
                    <param key="nologin" value="true"/>
                    <xsl:call-template name="param">
                        <xsl:with-param name="data" select="//param[contains(@key,'jsp')]/@key"/>

                    </xsl:call-template>
                </params>
            </tc>

        </mdp>
    </xsl:template>

    <xsl:template name="param">
        <xsl:param name="data"/>

        <xsl:choose>
            <xsl:when test="contains($data,'&amp;')">

                <xsl:variable name="temp">
                    <xsl:value-of select="substring-after($data,'&amp;')" />
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="contains($temp,'&amp;')">
                        <param key="{substring-before(substring-after($data,'&amp;'),'=')}" value="{substring-before(substring-after($data,'='),'&amp;')}"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <param key="{substring-before(substring-after($data,'&amp;'),'=')}" value="{substring-after($data,'=')}"/>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:if test="contains($temp,'&amp;')">
                    <xsl:call-template name="param">
                        <xsl:with-param name="data" select="$temp"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
