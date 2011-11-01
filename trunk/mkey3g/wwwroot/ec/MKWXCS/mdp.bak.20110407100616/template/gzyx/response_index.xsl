<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="../mdp.xsl"></xsl:import>
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
                <!--所在城市-->
                <xsl:apply-templates select="//div[@class='nav_city __r_c_']"/>
                <hr color="{$hrcolor}" size="2"/>
                <!--搜索，暂时没做-->
                <!--<xsl:apply-templates select="//div[@id='showtimeSearchRegion']"/>-->
                <!--<strong>影讯搜索</strong><br/>
                <a href="?action=bs-transfer@mdp&amp;url=http://static1.mtime.cn/20101224100533/Utility/Data/TheaterListBoxData.m&amp;chooce=yy&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_yy.xsl">选择影院</a>&#160;|&#160;
                <a href="?action=bs-transfer@mdp&amp;url=">选择电影</a>&#160;|&#160;
                <a href="?action=bs-transfer@mdp&amp;url=">选择时间</a>
                <hr color="{$hrcolor}" size="2"/>-->
                <!--预购票-->
                <xsl:apply-templates select="//div[@class='sh_leftout']"/>
                <hr color="{$hrcolor}" size="2"/>
                <!--新片上映，有需要就加进来-->
                <!--<xsl:apply-templates select="//div[@class='sh_left']"/>
                <hr color="{$hrcolor}" size="2"/>-->
                <!--热门电影-->
                <xsl:apply-templates select="//div[@class='sh_right']"/>
                <hr color="{$hrcolor}" size="2"/>
                <!--即将上映电影-->
                <xsl:apply-templates select="//div[@class='showtime_box mt9 __r_c_']"/>
            </body>
        </msc>

    </xsl:template>

    <xsl:template match="img">
        <span width="100%">
            <span align="left">
        <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true"></img>
        
        </span>
        <!--影评分数，有需要加就加进来-->
            <!--<span align="right">-->
       
            <!--<xsl:value-of select="./../../../../div/div/div[@class='point']/span"/>-->
           
            <!--</span>-->
        </span>
        <br/>
    </xsl:template>
    <!--a标签-->
    <xsl:template match="a">
        <xsl:choose>
            <xsl:when test="img">
                <xsl:apply-templates select="img"/>
            </xsl:when>
            <!--选择城市-->
            <xsl:when test="@class='select'">
                <a href="?action=bs-transfer@mdp&amp;url=http://static1.mtime.cn/20101224100533/Utility/Data/TheaterListBoxData.m&amp;nologin=true">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <!--地址带#的tomcat报错，这里把#后面的去掉没影响-->
            <xsl:when test="contains(@href,'/#')">
                <a href="?action=bs-transfer@mdp&amp;url={substring-before(@href,'/#')}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <!--电子地图屏蔽-->
            <xsl:when test="contains(@href,'map.html')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--时间屏蔽-->
            <xsl:when test="@class='c_666'">
                <!--<a href="?action=bs-transfer@mdp&amp;url=">-->
                    <xsl:value-of select="."/>
                <!--</a>-->
            </xsl:when>
            <xsl:when test="contains(text(),'点')">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="."/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="div">
        <xsl:choose>
        <!--过滤影评-->
            <xsl:when test="@id='cinemaCommentRegion'"/>
            <xsl:when test="@class='t_r'">
                <xsl:apply-templates/>
                <hr color="{$hrcolor}" size="2"/>
            </xsl:when>
            <!--过滤电影打分-->
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
            <xsl:when test="@class='pt35 clearfix px14'"/>
            <xsl:otherwise>
                <strong>
                    <xsl:apply-templates/>
                </strong>
                <br/>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:template>
    <xsl:template match="h4">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="@class='tr mt12 __r_c_'"/>
            <xsl:otherwise>
            <xsl:apply-templates/>
        <br/>
            </xsl:otherwise>
        </xsl:choose>  
    </xsl:template>
    <xsl:template match="ul">
        <xsl:choose>
        <!--正在放映影片-->
            <xsl:when test="@class='sh_showing __r_c_'">
                <xsl:apply-templates select="li" mode="li"/>
            </xsl:when>
            <!--票房排行榜，有需要加进来-->
            <xsl:when test="@class='sh_booking pb15'">
                <!--<xsl:apply-templates select="li" mode="pb"/>-->
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