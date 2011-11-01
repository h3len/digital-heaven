<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <msc type="form">
        <head>
            <title>
                <xsl:choose>
                    <xsl:when test="//title/.!=''">
                        <xsl:value-of select="//title/."/>
                    </xsl:when>
                    <xsl:otherwise>
                    江门新闻网
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
		<span width="100%" height="21px" bgcolor="#ffefd4">本地新闻</span>
        <span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=1179">本地热点</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=192">江门时政</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=193">三区四市</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=205">蓬江新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=206">江海新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=207">新会新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=208">台山新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=209">开平新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=210">鹤山新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=211">恩平新闻</a></span>
		
		<span width="100%" height="21px" bgcolor="#ffefd4">财经频道</span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=194">江门财经</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=437">五邑商情</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=482">投资理财</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=286">证券市场</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=284">银行动态</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=285">保险业界</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=342">家用电器</a></span>

		<span width="100%" height="21px" bgcolor="#ffefd4">社会频道</span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=334">都市新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=335">五邑民生</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=410">法制新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=721">社区新闻</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=331">爱心桥</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=882">阳光老人</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=884">网人网事</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=737">市民热线</a></span>

		<span width="100%" height="21px" bgcolor="#ffefd4">生活频道</span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=290">情感家园</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=297">健康在线</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=339">美容塑身</a></span>
		<span width="100%" height="21px"><a href="{$cp_url}/web/sort.aspx?sort_id=288">时尚流行</a></span>
		
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>