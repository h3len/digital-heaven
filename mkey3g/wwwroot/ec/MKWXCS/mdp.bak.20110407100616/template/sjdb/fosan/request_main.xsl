<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="../../mdp.xsl"/>
    <xsl:variable name="key_param" select="//param[contains(@key,'jsp')]/@key"/>

    <xsl:template match="/">
        <!--20101222修改_进入订阅方式详情-->
        <mdp>
            <xsl:choose>
                <!--跳转地址有?号的时候-->
                <xsl:when test="contains($key_param,'?')">
                    <tc>
                        <url>
                            <!--提交地址的前部分-->
                            <xsl:choose>
                                <!--post的地址为完全路径时-->
                                <xsl:when test="contains($key_param,'fspay')">
                                    <xsl:choose>
                                        <!--地址中第一个字节有'/'的地址-->
                                        <xsl:when test="starts-with($key_param,'/')">
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
                                        <xsl:when test="starts-with($key_param,'/')">
                                            <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post</xsl:text>
                                        </xsl:when>
                                        <!--地址中第一个字节不是'/'的地址-->
                                        <xsl:otherwise>
                                            <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post/</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>

                            <!--地址后半部分-->
                            <xsl:choose>
                                <xsl:when test="contains($key_param,'/wap')">
                                    <xsl:value-of select="substring-before(//param[contains(@key,'jsp')]/@key,'/wap')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!--<xsl:value-of select="substring-before(//param[contains(@key,'jsp')]/@key,'&amp;')"/>-->
                                    <xsl:value-of select ="$key_param"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </url>
                        <method>POST</method>
                        <encoding>utf-8</encoding>
                        <params>
                            <param key="nologin" value="true"/>

                        </params>
                    </tc>
                </xsl:when>

                <!--跳转地址中没有?号的时候-->
                <xsl:otherwise>
                    <tc>
                        <url>
                            <!--提交地址的前部分-->
                            <xsl:choose>
                                <!--返回上一级或返回业务首页为post方式时-->
                                <!--<xsl:when test="contains(//param[contains(@key,'jsp')]/@value,'返回')">
                                    <xsl:choose>
                                        <xsl:when test="contains(//param[contains(@key,'jsp')]/@key,'userLogin.jsp') or contains(//param[contains(@key,'jsp')]/@key,'userLogin.jsp')">
                                            <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post/</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="starts-with(//param[contains(@key,'jsp')]/@key,'/')">
                                            <xsl:text>http://211.139.201.121</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>http://211.139.201.121/</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>

                                </xsl:when>-->

                                <!--post的地址为完全路径时-->
                                <xsl:when test="contains($key_param,'fspay')">
                                    <xsl:choose>
                                        <!--地址中第一个字节有'/'的地址-->
                                        <xsl:when test="starts-with($key_param,'/')">
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
                                        <xsl:when test="starts-with($key_param,'/')">
                                            <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post</xsl:text>
                                        </xsl:when>
                                        <!--地址中第一个字节不是'/'的地址-->
                                        <xsl:otherwise>
                                            <xsl:text>http://211.139.201.121/fspay/subapp/sjdb/post/</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>

                            <!--地址后半部分-->
                            <xsl:choose>
                                <xsl:when test="contains($key_param,'/wap')">
                                    <xsl:value-of select="substring-before($key_param,'/wap')"/>
                                </xsl:when>
                                <xsl:when test="contains($key_param,'&amp;')">
                                    <xsl:value-of select="substring-before($key_param,'&amp;')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select ="$key_param"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </url>
                        <method>POST</method>
                        <encoding>utf-8</encoding>
                        <params>
                            <param key="nologin" value="true"/>

                            <xsl:call-template name="param">
                                <xsl:with-param name="data" select="$key_param"/>
                            </xsl:call-template>
                        </params>
                    </tc>
                </xsl:otherwise>
            </xsl:choose>

        </mdp>
    </xsl:template>

    <!--通过递归的方法分解参数-->
    <xsl:template name="param">
        <xsl:param name="data"/>

        <xsl:variable name="temp">
            <xsl:choose>
                <xsl:when test="contains($data,'&amp;')">
                    <xsl:value-of select="substring-after($data,'&amp;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$data"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <!--当地址中带有&amp;字段时，格式化分离参数-->
            <xsl:when test="contains($temp,'&amp;')">
                <xsl:variable name="key">
                    <xsl:value-of select="substring-before($temp,'=')"/>
                </xsl:variable>
                <xsl:variable name="value">
                    <xsl:value-of select="substring-before(substring-after($temp,'='),'&amp;')"/>
                </xsl:variable>

                <param key="{$key}" value="{$value}">
                    <!--当分解出来的参数值包含$，则表明该值需要动态获取。当它的其他同名参数的值不为$格式的时候，取之更换-->
                    <xsl:choose>
                        <xsl:when test="contains($value,'$')">
                            <xsl:choose>
                                <xsl:when test="//param[@key=$key]/@value and not(contains(//param[@key=$key]/@value,'$'))">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="//param[@key=$key]/@value"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="value"/>
                                    
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                  
                </param>
                <!--再次递归-->
                <xsl:call-template name="param">
                    <xsl:with-param name="data" select="$temp"/>
                </xsl:call-template>

            </xsl:when>
            <!--当不带&amp;时，则表明已是最后一个参数。-->
            <xsl:otherwise>
                <param key="{substring-before($temp,'=')}" value="{substring-after($temp,'=')}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
