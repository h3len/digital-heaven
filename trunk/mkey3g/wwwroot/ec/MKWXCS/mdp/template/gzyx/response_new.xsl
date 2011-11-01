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
  <xsl:template match="div[@class='movie_side_nav']"/>
  <!--屏蔽‘看过？’-->
  <xsl:template match="div[@id='movieRatingDiv']"/>
  <!--屏蔽影院播放详情-->
  <xsl:template match="div[@class='sh_content']"/>
  <!--屏蔽影院详情导航-->
  <xsl:template match="div[@class='nav_date clearfix']"/>
  <!--屏蔽时光电影通劵-->
  <xsl:template match="div[@class='sh_other clearfix']"/>

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
        <a href="?action=bs-transfer@mdp&amp;url={@href}&amp;nologin=true" target="_blank">
          <xsl:value-of select="."/>
        </a>
        <xsl:apply-templates select="img"/>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <a href="?action=bs-transfer@mdp&amp;url={$href}&amp;nologin=true" target="_blank">
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--更多前换行-->
  <xsl:template match="a[contains(text(),'更多')]">
    &#160;&#160;<a href="{@href}" target="{@target}">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <!--屏蔽电子地图连接-->
  <!--<xsl:template match="a[contains(text(),'电子地图')]"/>-->
  <!--屏蔽详细连接-->
  <!--<xsl:template match="a[contains(text(),'详细')]"/>-->

  <!--========img标签===========-->
  <xsl:template match="img">
    <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true"/>
  </xsl:template>

  <!--=======p标签======-->
  <!--换行-->
  <xsl:template match="p[@class='mt6']">
    <br/>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  <!--换行-->
  <xsl:template match="p[@class='mt9 lh18']">
    <br/>&#160;<br/>
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>
  <!--换行-->
  <xsl:template match="p[contains(text(),'销售和客户电话')]">
    <br/>
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>

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

  <!--=====h3标签====-->


  <!--======ul标签=====-->

  <!--=====h1标签====-->
  <xsl:template match="h1[@class='movie_film_nav normal pl9 pr15']">
    <br/>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

</xsl:stylesheet>