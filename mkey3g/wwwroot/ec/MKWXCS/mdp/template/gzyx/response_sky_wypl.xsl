<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="../mdp.xsl"></xsl:import>
  <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>

  <xsl:template match="/html">
        <msc type="form" islogin="true">
            <head>
                <title></title>
                <script type="text/javascript">
                    <![CDATA[	
                    function aaa(){
                    alert('开发中.......');
				}
			]]>
                </script>
            </head>
            <body background="index_bg.png">
           aaaaaaaaaaaaaa
            </body>
        </msc>

    </xsl:template>

    <xsl:template match="img">
        <span width="100%">
            <span align="left">
        <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true"></img>
        </span>
            <span align="right">
            <xsl:value-of select="./../../../div/div/div[@class='point']/."/>
            </span>
        </span>
        <br/>
    </xsl:template>
    <xsl:template match="a">
        <xsl:choose>
            <xsl:when test="img">
                <xsl:apply-templates select="img"/>
            </xsl:when>
            <xsl:otherwise>
                <a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true">
                    <xsl:value-of select="."/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="div">
        <xsl:choose>
            <xsl:when test="@class='t_r'">
                <xsl:apply-templates/>

                <hr color="{$hrcolor}" size="2"/>
            </xsl:when>
            <xsl:when test="@class='point'">
                <!--<span width="100%" align="right">
                    <xsl:value-of select="."/>
                </span>-->
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="h3">
        <xsl:choose>
            <xsl:when test="@class='px14 clearfix'">
                <span width="100%">
                    <span>
                        <strong>在线购票</strong>
                    </span>
                    <span align="right">
                    <xsl:apply-templates select="a"/>
                    </span>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <strong>
                    <xsl:apply-templates/>
                </strong>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="p">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="ul">
        <xsl:choose>
        <!--正在放映影片-->
            <xsl:when test="@class='sh_showing __r_c_'">
                <xsl:apply-templates select="li" mode="li"/>
            </xsl:when>
            <!--票房-->
            <xsl:when test="@class='sh_booking pb15'">
                <xsl:apply-templates select="li" mode="pb"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="li" mode="li">
        <span>
            <span width="100%">
                <span align="left">
                <xsl:apply-templates select="div[@class='w245']/a"/></span>
                <span align="right">
                <xsl:value-of select="div[@class='w52 c_orange bold']"/>
            </span>
            </span>   
            <span>
                <xsl:apply-templates select="div[@class='fr']/a"/>
                <xsl:value-of select="span"/>
            </span>
        </span>
        <hr size="2"/>
    </xsl:template>
    <xsl:template match="li" mode="pb">
                <xsl:apply-templates select="div" mode="pb"/>
                <br/> 
    </xsl:template>
    <xsl:template match="div" mode="pb">
        <xsl:apply-templates/>&#160;
    </xsl:template>
    <xsl:template match="span">
        <xsl:choose>
            <xsl:when test="@id='presellidsSpan'"></xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>