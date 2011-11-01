<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="mdp.xsl"></xsl:import>
  <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>

  <xsl:template match="/html">
        <msc type="form" islogin="true">
            <head>
                <script type="text/javascript">
                    <![CDATA[	
                    function aaa(){
                    alert('开发中.......');
				}
			]]>
                </script>
            </head>
            <body background="index_bg.png">
                <span width="100%" dock="top" align="center">
                    <span width="100%">
                        <span width="50%" align="center">
                            <img src="menu01_.png" href="{$url}/workflow/request/RequestView.jsp?do=sy" ></img>
                        </span>
                        <span width="50%" align="center">
                            <img src="menu02.png" href="?action=bs-transfer@mdp&amp;url={$url}/docs/docs/DocMoreForHp.jsp" ></img>
                        </span>
                    </span>
                </span>
                <grid mode="3">
                    <!--<item icon="icon_gwgl01.png" caption="待办事宜({substring-after(//tr[@class='Title']/th/text(),':')})" href="{$url}/workflow/request/RequestView.jsp" target="_blank"></item>-->
                    <item icon="emailnew.png" caption="新建流程" href="{$url}/workflow/request/RequestType.jsp" target="_blank"/>
                    <item icon="icon_gwgl01.png" caption="待办事宜" href="{$url}/workflow/request/RequestView.jsp" target="_blank"></item>
                    <item icon="icon_gwgl02.png" caption="已办事宜" href="{$url}/workflow/request/RequestHandled.jsp" target="_blank"></item>
                    <item icon="icon_gwgl03.png" caption="办结事宜" href="{$url}/workflow/request/RequestComplete.jsp" target="_blank"></item>                   
                    <item icon="icon_swzl02.png" caption="流程代理" href="{$url}/workflow/request/wfAgentStatistic.jsp" target="_blank" />
                    <!--<item icon="icon_hygl02.png" caption="退回报告" href="script:aaa()" target="_blank"></item>-->
                    <item icon="icon03.png" caption="通讯录" href="script:aaa()" target="_blank"/>                    
                    <!--<xsl:apply-templates select="//a" mode="show"/>-->
                </grid>
            </body>
        </msc>

    </xsl:template>

    <xsl:template match="a" mode="show">
        <xsl:choose>
            <xsl:when test=".='报告审批(流程不明确)'">
                <item icon="icon_gwgl03.png" href="" target="_blank">
                    <xsl:attribute name="href">
                        <xsl:text>?action=bs-transfer@mdp&amp;url=</xsl:text>
                        <xsl:value-of select="$url"/>
                        <xsl:value-of select="@href"/>
                        <xsl:text>&amp;dheavenRequestTemplate=db/request_dblist.xsl</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="caption">
                        <xsl:if test="not(substring-after(../.,'/'))">
                            <xsl:text>未知流程</xsl:text>
                            <xsl:value-of select="../text()"/>
                        </xsl:if>
                        <xsl:if test="not(substring-after(../.,'/'))=false">
                            <xsl:text>未知流程(</xsl:text>
                            <xsl:value-of select="substring-after(../.,'/')"/>
                        </xsl:if>
                    </xsl:attribute>
                </item>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="contains(.,'_采编')">
                <item icon="icon_hygl01.png" href="" target="_blank">
                    <xsl:attribute name="href">
                        <xsl:text>?action=bs-transfer@mdp&amp;url=</xsl:text>
                        <xsl:value-of select="$url"/>
                        <xsl:value-of select="@href"/>
                        <xsl:text>&amp;dheavenRequestTemplate=db/request_dblist_cb.xsl</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="caption">
                        <xsl:if test="not(substring-after(../.,'/'))">
                            <xsl:text>采编</xsl:text>
                            <xsl:value-of select="../text()"/>
                        </xsl:if>
                        <xsl:if test="not(substring-after(../.,'/'))=false">
                            <xsl:text>采编(</xsl:text>
                            <xsl:value-of select="substring-after(../.,'/')"/>
                        </xsl:if>
                    </xsl:attribute>
                </item>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="contains(.,'_广告')">
                <item icon="icon_gwgl02.png" href="" target="_blank">
                    <xsl:attribute name="href">
                        <xsl:text>?action=bs-transfer@mdp&amp;url=</xsl:text>
                        <xsl:value-of select="$url"/>
                        <xsl:value-of select="@href"/>
                        <xsl:text>&amp;dheavenRequestTemplate=db/request_dblist_gg.xsl</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="caption">
                        <xsl:if test="not(substring-after(../.,'/'))">
                            <xsl:text>广告</xsl:text>
                            <xsl:value-of select="../text()"/>
                        </xsl:if>
                        <xsl:if test="not(substring-after(../.,'/'))=false">
                            <xsl:text>广告(</xsl:text>
                            <xsl:value-of select="substring-after(../.,'/')"/>
                        </xsl:if>
                        <!--<xsl:value-of select="../a[2]/text()"/>
                        <xsl:text>)</xsl:text>-->
                    </xsl:attribute>
                </item>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="contains(.,'_行政')">
                <item icon="icon_gwgl01.png" href="" target="_blank">
                    <xsl:attribute name="href">
                        <xsl:text>?action=bs-transfer@mdp&amp;url=</xsl:text>
                        <xsl:value-of select="$url"/>
                        <xsl:value-of select="@href"/>
                        <xsl:text>&amp;dheavenRequestTemplate=db/request_dblist_xz.xsl</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="caption">
                        <xsl:if test="not(substring-after(../.,'/'))">
                            <xsl:text>行政</xsl:text>
                            <xsl:value-of select="../text()"/>
                        </xsl:if>
                        <xsl:if test="not(substring-after(../.,'/'))=false">
                            <xsl:text>行政(</xsl:text>
                            <xsl:value-of select="substring-after(../.,'/')"/>
                        </xsl:if>
                    </xsl:attribute>
                </item>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="contains(.,'南都周刊')">
                <item icon="icon_qywh03.png" href="" target="_blank">
                    <xsl:attribute name="href">
                        <xsl:text>?action=bs-transfer@mdp&amp;url=</xsl:text>
                        <xsl:value-of select="$url"/>
                        <xsl:value-of select="@href"/>
                        <xsl:text>&amp;dheavenRequestTemplate=db/request_dblist_nd.xsl</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="caption">
                        <xsl:if test="not(substring-after(../.,'/'))">
                            <xsl:text>南都周刊</xsl:text>
                            <xsl:value-of select="../text()"/>
                            <xsl:text></xsl:text>
                        </xsl:if>
                        <xsl:if test="not(substring-after(../.,'/'))=false">
                            <xsl:text>南都周刊(</xsl:text>
                            <xsl:value-of select="substring-after(../.,'/')"/>
                        </xsl:if>
                        <!--<xsl:text>)</xsl:text>-->
                    </xsl:attribute>
                </item>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>