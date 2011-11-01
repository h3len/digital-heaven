<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../mdp.xsl"/>
    <xsl:template match="/">
        <msc type="form" nologin="true" action="">
            <head>
                <title>
                    <xsl:value-of select="//card/@title"/>
                </title>
            </head>
            <body>
                <strong>
                    <xsl:value-of select="//card/@title"/>
                </strong>
                <br/>
                <xsl:apply-templates/>
                <input type="hidden" name="nologin" value="true"/>
            </body>
        </msc>
    </xsl:template>

    <!--主要内容-->
    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="input">
                <xsl:apply-templates mode="p"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="p"/>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template match="anchor" mode="p">
        <!--清空空格-->
        <xsl:variable name="caption">
            <xsl:call-template name="ReplaceAll">
                <xsl:with-param name="content" select="text()"/>
                <xsl:with-param name="str" select="' '"></xsl:with-param>
                <xsl:with-param name="replacement" select="''"/>
            </xsl:call-template>
        </xsl:variable>

        <input type="submit" value="{$caption}">
            <xsl:attribute name="name">
                <xsl:value-of select="./go/@href"/>&amp;<xsl:for-each select="./go/postfield">
                    <xsl:value-of select="@name"/>
                    <xsl:text>=</xsl:text>
                    <xsl:value-of select="@value"/>
                    <xsl:if test="not(position()=last())">
                        <xsl:text>&amp;</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
        </input>

    </xsl:template>



    <!--格式化的东西-->
    <xsl:template match="img" mode="p">
        <br/>
        <xsl:choose>
            <xsl:when test="contains(@src,'..')">
                <img src="?action=viewimageremote@mdp&amp;url=http://211.139.201.121/fspay/subapp/sjdb/{substring-after(@src,'/')}&amp;nologin=true"/>
            </xsl:when>
            <xsl:when test="contains(@src,'picid')">
                <img src="?action=viewimageremote@mdp&amp;url=http://211.139.201.121/fspay/subapp/sjdb/post/{@src}&amp;nologin=true"/>
            </xsl:when>
            <xsl:otherwise>
                <img src="?action=viewimageremote@mdp&amp;url=http://211.139.201.121{@src}&amp;nologin=true"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--文字-->
    <xsl:template match="text()" mode="p">
        <!--<xsl:choose>-->
        <!--20101222 新增显示订阅方式详情的字段-->
        <!--<xsl:when test="contains(.,'：') or contains(.,'。') or contains(.,'！') or contains(.,':') or position()=8 or contains(.,'==') or contains(.,'、')">-->
        <xsl:value-of select="."/>
        <!--</xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>-->
    </xsl:template>


    <xsl:template match="a" mode="p">
        <xsl:variable name="href">
            <xsl:call-template name="ReplaceAll">
                <xsl:with-param name="content" select="@href"/>
                <xsl:with-param name="str">&amp;</xsl:with-param>
                <xsl:with-param name="replacement" select="'%26'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(.,'返回门户首页')"></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!--href地址中第一个字节有'/'的地址-->
                    <xsl:when test="starts-with($href,'/')">
                        <a href="?action=bs-transfer@mdp&amp;url=http://211.139.201.121{$href}&amp;nologin=true">
                            <xsl:value-of select="."/>
                        </a>
                    </xsl:when>
                    <!--href地址中第一个字节不是'/'的地址-->
                    <xsl:otherwise>
                        <a href="?action=bs-transfer@mdp&amp;url=http://211.139.201.121/fspay/subapp/sjdb/post/{$href}&amp;nologin=true">
                            <xsl:value-of select="."/>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="./br">
            <br/>&#160;<br/>
        </xsl:if>
        &#160;&#160;

    </xsl:template>

    <!--<xsl:template match="input" mode="p">
    <input type="{@type}" name="{@name}" value="{@value}" caption="{@value}"/>
  </xsl:template>-->

    <!--好爽的提交按钮-->
    <!--<xsl:template match="go" mode="p">
    <input type="submit" name="submit" caption="提交"/>
  </xsl:template>-->

    <xsl:template match="br" mode="p">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
    </xsl:template>

    <xsl:template match="date">
        <br/>
        <xsl:text>&#160;</xsl:text>
        <br/>
        <font size="xs">
            <xsl:text>当前时间:</xsl:text>
            <xsl:value-of select="."/>
        </font>
    </xsl:template>

    <xsl:template match="statuCode"></xsl:template>

    <xsl:template match="input" mode="p">
        <input type="{@type}" name="{@name}" value="{@value}">
            <xsl:if test="@value=''">
                <xsl:variable name="name">
                    <xsl:value-of select="@name"/>
                </xsl:variable>
                <xsl:attribute name="value">
                    <xsl:value-of select="//param[@key=$name]/@value"/>
                </xsl:attribute>
            </xsl:if>
        </input>
    </xsl:template>

    <xsl:template match="select" mode="p">
        <select name="{@name}" title="{@title}">
            <xsl:for-each select="option">
                <option value="{@value}">
                    <xsl:value-of select="text()"/>
                </option>
            </xsl:for-each>
        </select>
    </xsl:template>

    <!--屏蔽param参数缓存-->
    <xsl:template match="param"></xsl:template>

</xsl:stylesheet>
