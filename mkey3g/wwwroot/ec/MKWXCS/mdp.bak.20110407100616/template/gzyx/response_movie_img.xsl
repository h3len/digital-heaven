<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="../mdp.xsl"></xsl:import>
    <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>

    <xsl:template match="/">
        <msc type="form" action="">
            <head>
                <title></title>
            </head>
            <body>
                <xsl:apply-templates select="//body/div[@id='layout_main']"/>
            </body>
        </msc>
    </xsl:template>

    <!--========div标签==========-->
    <xsl:template match="div">
        <xsl:choose>
            <!--屏蔽二级导航-->
            <xsl:when test="@class='movie_side_nav'"/>
            <!--屏蔽‘看过？’-->
            <xsl:when test="@id='movieRatingDiv'"/>
            <!--屏蔽影评等-->
            <xsl:when test="@id='ratingChartRegion'"/>
            <xsl:when test="@class='fr movie_film_r2'"/>
            <!--屏蔽 推荐给朋友 | 推荐到群组 | 添加资料 | 添加图片 | 报错 -->
            <xsl:when test="@class='__r_c_ clearfix'"/>
            <xsl:when test="@id='info_col'"/>
            <!--屏蔽全国影院放映时间查询-->
            <xsl:when test="@id='movieShowtimeRegion'"/>
            <xsl:when test="@class='fr w255 o_h'"/>
            <!--屏蔽相关标签及影片专辑栏目-->
            <xsl:when test="@class='ele_inner pl6 pr6 pb6'"/>
            <!--屏蔽还有谁关注此影片-->
            <xsl:when test="@pan='M08_Movie_Overview_Member'"/>
            <!--屏蔽与此影片有关的游戏-->
            <xsl:when test="@pan='M08_Movie_Overview_Quiz'"/>
            <!--屏蔽右边栏-->
            <xsl:when test="@id='movie_main_r'"/>
            <!--屏蔽相关专题内容-->
            <xsl:when test="@class='fr w180 ml10 mr20'"/>
            <!--屏蔽相关资讯-->
            <xsl:when test="@class='w380 fl'"/>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!---->
    <xsl:template match="div[@class='pagenav tc mt20']">
        <xsl:apply-templates select="a" mode="fenye"/>
        <br/>
    </xsl:template>

    <!--定义变量-->
    <!--<xsl:variable name="page" select="substring-before(substring-after(//url,'comment-'),'.html')">
  </xsl:variable>-->

    <!--======img标签========-->
    <!--img标签-->
    <xsl:template match="img">
        <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true"/>
    </xsl:template>


    <!--=======a标签======-->
    <!---->
    <!--{$movie}/{substring-before(substring-after(//url,'com/'),'/')}/-->
    <xsl:template match="a" mode="fenye">
        <xsl:choose>
            <xsl:when test="not(@href)"/>
            <xsl:otherwise>
                |<a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="a" mode="daohang">
        |<a href="?action=bs-transfer@mdp&amp;url={$movie}{@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <xsl:template match="a" mode="a">
        <a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <xsl:template match="a" mode="a1">
        <a href="?action=bs-transfer@mdp&amp;url={$movie}{@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <!--a标签下的img-->
    <xsl:template match="a">
        <xsl:variable name ="href">
            <xsl:call-template name ="ReplaceAll">
                <xsl:with-param name ="content" select="@href"/>
                <xsl:with-param name="str">&amp;</xsl:with-param>
                <xsl:with-param name="replacement">%26</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not(@href)">
                &#160;&#160;<xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="img">
                <!--<a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true" target="_blank">
                    <xsl:value-of select="."/>
                </a>-->
                <xsl:apply-templates select="img"/>
                <br/>
            </xsl:when>
            <!--屏蔽博客连接-->
            <xsl:when test="contains(@href,'i.mtime.com')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽演员等连接-->
            <xsl:when test="contains(@href,'people.mtime.com')">
                <xsl:value-of select="."/>&#160;&#160;
            </xsl:when>
            <!--屏蔽影片类型连接-->
            <xsl:when test="contains(@href,'search.mtime.com')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽电子地图连接-->
            <xsl:when test="contains(text(),'电子地图')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽详细连接-->
            <xsl:when test="contains(text(),'详细')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽好友影评-->
            <xsl:when test="contains(text(),'好友影评')"/>
            <!--空a标签处理-->
            <xsl:when test="@href = ''">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--发行连接处理-->
            <!--<xsl:when test="contains(@href,'distributors')">
                <a href="?action=bs-transfer@mdp&amp;url={$movie}{@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>-->
            <!--制作连接处理-->
            <!--<xsl:when test="contains(@href,'distributors')">
                <a href="?action=bs-transfer@mdp&amp;url={$movie}{@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>-->
            <!--屏蔽全文连接-->
            <xsl:when test="contains(text(),'全文')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽评论标题连接-->
            <xsl:when test="@class='fl'">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽'所有影评'-->
            <xsl:when test="contains(text(),'所有影评')"/>
            <!--屏蔽呢称连接-->
            <xsl:when test="contains(@href,'i.mtime.com')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽地点连接-->
            <xsl:when test="contains(@href,'/city/')">
                <xsl:value-of select="."/>
            </xsl:when>
            <!--屏蔽电影名后面的城市连接-->
            <xsl:when test="@href='#'">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!--=======p标签======-->
    <xsl:template match="p">
        <xsl:choose>
            <!--热门影评 |最新影评|一句话影评 连接处理-->
            <xsl:when test="@class='mt-10'">
                <br/>
                <xsl:apply-templates select="font"/>
                <xsl:apply-templates select="a" mode="daohang"/>
                <br/>&#160;<br/>
            </xsl:when>
            <!--预告片视屏抢先看的内容换行-->
            <xsl:when test="@class='mt3 song' or @class='tc'">
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <xsl:when test="@class='c_a5'">
                <br/>
                <xsl:apply-templates/>
            </xsl:when>
            <!--更多连接处理-->
            <xsl:when test="@class='mt12 tr'">
                <xsl:apply-templates select="a" mode="a1"/>
                <xsl:apply-templates select="span"/>
            </xsl:when>
            <!--更多详情、更多剧情等连接-->
            <xsl:when test="@class='tr mt15'">
                <xsl:apply-templates select="a" mode="a"/>
                <xsl:apply-templates select="span"/>
            </xsl:when>
            <!--屏蔽导演、编剧、演员等定位连接-->
            <xsl:when test="@class='mt15'">
                <br/>&#160;<br/>
            </xsl:when>
            <!--<xsl:when test="contains(text(),'显示：')">
        <br/>
        <xsl:apply-templates/>
        <br/>&#160;<br/>
      </xsl:when>-->
            <!--屏蔽推荐和报错连接-->
            <xsl:when test="@class='tr mt9'"/>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--换行-->
    <!--<xsl:template match="p[@class='mt3 song']">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>-->
    <!--预告片的内容换行-->
    <!--<xsl:template match="p[@class='c_a5']">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>-->
    <!--预告片视屏抢先看的内容换行-->
    <!--<xsl:template match="p[@class='tc']">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>-->

    <!--=======span标签======-->
    <xsl:template match="span">
        <xsl:choose>
            <xsl:when test="@class='point ml12'">
                &#160;&#160;&#160;&#160;
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <!--更多-->
            <xsl:when test="@class='pt12 tr'">
                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
                <a href="{a/@href}">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:when test="@class='tr mt10'">
                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
                <a href="{a/@href}">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:when test="@class='normal px12 lh10'"/>
            <xsl:when test="@class='fr mt18 mr15'"/>
            <!--屏蔽回复数连接并换行-->
            <xsl:when test="@class='fr c_a5 px12 normal'">
                <xsl:value-of select="."/>
                <br/>
            </xsl:when>
            <!--屏蔽评论指数-->
            <xsl:when test="@class='fr c_a5'"/>
            <!--换行-->
            <xsl:when test="@class='fr mt9'">
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--<xsl:template match="span[@class='point ml12']">
        &#160;&#160;&#160;&#160;
        <xsl:apply-templates/>
        <br/>
    </xsl:template>-->
    <!--更多-->
    <!--<xsl:template match="p[@class='pt12 tr']">
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        <a href="{a/@href}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <xsl:template match="p[@class='tr mt10']">
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        <a href="{a/@href}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>-->
    <!--屏蔽影评条数-->
    <!--<xsl:template match="span[@class='normal px12 lh10']"/>-->
    <!--屏蔽相关专题连接-->
    <!--<xsl:template match="span[@class='fr mt18 mr15']"/>-->


    <!--=====h2标签====-->
    <!--电影介绍页面-->
    <xsl:template match="h2">
        <br/>
        &#160;
        <br/>
        <strong>
            <xsl:apply-templates/>
        </strong>
        <br/>
    </xsl:template>
    <!--预告片页面-->
    <!--<xsl:template match="h2[contains(text(),'视听抢先看')]">
        <br/>
        &#160;
        <br/>
        <strong>
            <xsl:apply-templates/>
        </strong>
        <br/>
    </xsl:template>-->

    <!--font标签-->
    <xsl:template match="font">
        <xsl:value-of select="."/>
    </xsl:template>

    <!--em标签-->
    <xsl:template match="em">
        <xsl:choose>
            <xsl:when test="@class='px12 c_a5'">
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <xsl:when test="@class='ele_inline_block ico_imglist_show ml6'">
                <xsl:apply-templates select="a" mode="daohang"/>
            </xsl:when>
            <xsl:when test="@class='ele_inline_block ico_txlist_show ml6'">
                <xsl:apply-templates select="a" mode="daohang"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--=====h3标签====-->
    <xsl:template match="h3">
        <xsl:choose>
            <xsl:when test="@class='clearfix pb3 px14'">
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <xsl:when test="@class='mt6 px14 lh20'">
                <br/>
                &#160;
                <br/>
                <strong>
                    <xsl:apply-templates/>
                </strong>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--<xsl:template match="h3[@class='clearfix pb3 px14']">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>-->
    <!--预告片，拍摄花絮，MV标题处理-->
    <!--<xsl:template match="h3[@class='mt6 px14 lh20']">
    <br/>
    &#160;
    <br/>
    <strong>
      <xsl:apply-templates/>
    </strong>
    <br/>
  </xsl:template>
  <xsl:template match="h3[@class='lh20 px14 mt30']">
    <br/>
    &#160;
    <br/>
    <strong>
      <xsl:apply-templates/>
    </strong>
    <br/>
  </xsl:template>-->

    <!--strong标签-->
    <xsl:template match="strong">
        <xsl:value-of select="."/>
    </xsl:template>


    <!--=====dl标签====-->
    <!--屏蔽总评分-->
    <xsl:template match="dl[@class='fl w320']"/>
    <!--屏蔽影评-->
    <xsl:template match="dl[@class='ele_tabs_a2 mt6 mb15 clearfix pb3']"/>

    <!--=====h1标签====-->
    <xsl:template match="h1[@class='movie_film_nav normal pl9 pr15']">
        <br/>
        <xsl:apply-templates/>
        <hr/>
    </xsl:template>

    <!--ul标签-->
    <xsl:template match="ul">
        <xsl:choose>
            <xsl:when test="@class='movie_list_half clearfix'">
                <br/>&#160;<br/>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--=======li 标签==============-->
    <xsl:template match="li">
        <xsl:choose>
            <xsl:when test="@class='fl wp49 ele_img_item pb12'">
                <br/>&#160;<br/>
                <xsl:apply-templates/>
                <hr/>
            </xsl:when>
            <xsl:otherwise>
                <br/>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--ol标签-->
    <xsl:template match="ol[@class='mt30 lh18 list_num']">
        <br/>
        <xsl:apply-templates select="li"/>
    </xsl:template>

</xsl:stylesheet>