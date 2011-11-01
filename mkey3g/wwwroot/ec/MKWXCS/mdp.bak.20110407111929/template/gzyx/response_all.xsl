<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="../mdp.xsl"></xsl:import>
  <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>

  <xsl:template match="/">
    <msc type="form">
      <head>
          <title></title>
      </head>
      <body>
        <xsl:apply-templates select="//body/div[@id='layout_main']"/>
      </body>
    </msc>
  </xsl:template>

  <!--========div标签==========-->
  <!--屏蔽二级导航-->
  <!--<xsl:template match="div[@class='movie_side_nav']"/>-->
  <!--屏蔽‘看过？’-->
  <!--<xsl:template match="div[@id='movieRatingDiv']"/>-->
  <!--屏蔽影院播放详情-->
  <!--<xsl:template match="div[@class='sh_content']"/>-->
  <!--屏蔽影院详情导航-->
  <!--<xsl:template match="div[@class='nav_date clearfix']"/>-->
  <!--屏蔽时光电影通劵-->
  <!--<xsl:template match="div[@class='sh_other clearfix']"/>-->
  <xsl:template match="div">
    <xsl:choose>
      <!--屏蔽二级导航-->
      <xsl:when test="@class='movie_side_nav'"/>
      <!--屏蔽‘看过？’-->
      <xsl:when test="@id='movieRatingDiv'"/>
      <!--屏蔽影院播放详情-->
      <xsl:when test="@class='sh_content'"/>
      <!--屏蔽影院详情导航-->
      <xsl:when test="@class='nav_date clearfix'"/>
      <!--屏蔽时光电影通劵-->
      <xsl:when test="@class='sh_other clearfix'"/>
      <xsl:when test="@class='fr w255'"/>
      <!--屏蔽分数-->
      <xsl:when test="@class='point'"/>
      <xsl:when test="@id='presellBlock'">
        <strong>新片上映</strong>
        <hr/>
      </xsl:when>
      <xsl:when test="@class='table'">
        <br/>
        <xsl:apply-templates/>
        <hr/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--广州新片-->
  <!--<xsl:template match="div[@id='presellBlock']">
    <strong>新片上映</strong>
    <hr/>
  </xsl:template>-->
  <!--添加下划线-->
  <!--<xsl:template match="div[@class='table']">
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>-->
  <!--=======a标签======-->
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
      <!--屏蔽屏蔽演员、导演连接 需要修改-->
      <xsl:when test="contains(@href,'www.mtime.com')">
        <xsl:value-of select="."/>&#160;&#160;
      </xsl:when>
      <!--屏蔽影片类型连接-->
      <xsl:when test="contains(@href,'search.mtime.com')">
        <xsl:value-of select="."/>
      </xsl:when>
      <!--更多-->
      <xsl:when test="contains(text(),'更多')">
        &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="{@target}">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="?action=bs-transfer@mdp&amp;url={$href}&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl" target="_blank">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--========img标签===========-->
  <xsl:template match="img">
    <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true"/>
  </xsl:template>

  <!--=======p标签======-->
  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="@class='mt6 pb6'">
        <br/>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="@class='mt6'">
        <br/>
        <xsl:apply-templates/>
        <br/>
      </xsl:when>
      <xsl:when test="@class='mt9 lh18'">
        <br/>&#160;<br/>
        <xsl:apply-templates/>
        <br/>&#160;<br/>
      </xsl:when>
      <xsl:when test="contains(text(),'销售和客户电话')">
        <br/>
        <xsl:apply-templates/>
        <br/>&#160;<br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--换行-->
  <!--<xsl:template match="p[@class='mt6']">
    <br/>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>-->
  <!--换行-->
  <!--<xsl:template match="p[@class='mt9 lh18']">
    <br/>&#160;<br/>
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>-->
  <!--换行-->
  <!--<xsl:template match="p[contains(text(),'销售和客户电话')]">
    <br/>
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>-->

  <!--=======span标签======-->
  <xsl:template match="span[@class='point ml12']">
    &#160;&#160;&#160;&#160;
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  <!--换行-->
  <xsl:template match="span[@class='ele_dot']">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>
  <!--屏蔽趋势图单位连接-->
  <xsl:template match="span[@class='fr c_green normal px12']">
    <br/>
  </xsl:template>

  <!--=====strong标签====-->
  <!--屏蔽左箭头-->
  <xsl:template match="strong[@class='lefton']"/>
  <!--屏蔽右箭头-->
  <xsl:template match="strong[@class='righton']">
    <br/>&#160;
    <br/>
  </xsl:template>


  <!--======ul标签=====-->
  <!--屏蔽近期等导航链接-->
  <xsl:template match="ul[@id='willReleaseMenu']"/>

  <!--=====h1标签====-->
  <xsl:template match="h1[@class='movie_film_nav normal pl9 pr15']">
    <br/>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

</xsl:stylesheet>