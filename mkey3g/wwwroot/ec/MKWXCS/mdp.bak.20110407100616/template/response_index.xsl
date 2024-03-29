<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
    <xsl:template match="/">
        <msc type="form" action="">
            <head>
                <title>系统导航</title>
            </head>
            <body>
                <img src="dzj.png"/><br/>
                <!--============地震速报=============-->
               <img src="dzsb.png"/>&#160; &#160;&#160;
              <font size="s">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhenqing/dzbigseis.asp&amp;nologin=true">&gt;&gt;更多</a>
              </font>              
                <br/>
              <xsl:apply-templates select="//tr" mode="dzsb"/>
              <!--============省内地震=================-->
              <img src="arrow02.png"/>&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/seis/seisdkb.htm&amp;nologin=true">省内地震</a><br/>

               <!--============省局新闻===============-->
                <img src="jnxw.png"/>&#160; &#160;&#160;
              <font size="s">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/dzxinwenll.asp?xwid=1&amp;nologin=true">&gt;&gt;更多</a>
              </font>
                <br/>
              <xsl:apply-templates select="//font[contains(text(),'局内新闻')]/../../../../tr[position()&gt;1]" mode="new"/>
              
              <!--==============地方新闻===============-->
              <img src="dfxw.png"/>&#160; &#160;&#160;
              <font size="s">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/dzxinwenll.asp?xwid=3&amp;nologin=true">&gt;&gt;更多</a>
              </font>
              <br/>
              <xsl:apply-templates select="//font[contains(text(),'局内新闻')]/../../../../tr[position()&gt;1]" mode="newdf"/>
              
              <!--××××××××××××地震知识×××××××××××××××-->
              <img src="dzzs.png"/>
              &#160; &#160;&#160;
              <font size="s">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhishi/dizhenzsll.asp?strid=基本知识&amp;nologin=true">&gt;&gt;更多</a>
              </font>
              <br/>
              <xsl:apply-templates select ="//a[contains(@href,'dizhenzhishi/')]/../../../tr" mode="dzzs"/>
              
              <!--公示公告-->
              <!--<img src="gsgg.png"/>&#160; &#160;&#160;
              <font size="s">
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhengonggao/gonggao.asp&amp;nologin=true">&gt;&gt;更多</a>
              </font>
              <br/>
              <xsl:apply-templates select="//a[contains(@href,'dizhengonggao/')]" mode="gg" />-->
              
              <!--地震专题-->



              <!--&#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/dzxinwenll.asp?xwid=1&amp;nologin=true">省局新闻</a>&#160;-->
                <!--<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenxinwen/dzxinwenll.asp?xwid=3&amp;nologin=true">地方新闻</a><br/>-->

                <!--<img src="jgjs.png"/> <br/>
                &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/jigou.asp&amp;name=sjjs&amp;nologin=true">省局介绍</a>&#160;
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenjigou/jigou.asp&amp;name=nbjg&amp;nologin=true">内部机构</a><br/>

                <img src="dzkp.png"/> <br/>
                &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhishi/dizhenzsll.asp?strid=基本知识&amp;nologin=true">地震知识</a>&#160;
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhishi/dizhenzsll.asp?strid=地震问答&amp;nologin=true">地震问答</a><br/>

                <img src="zjzt.png"/> <br/>
                &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhuanjia/dzzhuanjia.asp&amp;nologin=true">地震专家</a>
                &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzt/dzzt.asp&amp;nologin=true">地震专题</a><br/>

                <img src="dzfg.png"/> <br/>
                &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenfagui/dzfaguill.asp?strlb=国家级法规&amp;nologin=true">国家级法规</a>&#160;
                <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenfagui/dzfaguill.asp?strlb=广东省法规&amp;nologin=true">广东省法规</a><br/>

                <img src="qt.png"/> <br/>
                &#160;&#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhengonggao/gonggao.asp&amp;nologin=true">公示公告</a>
                &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/ZwGk/index0.asp&amp;nologin=true">信息公开</a><br/>-->

            </body>
        </msc>
    </xsl:template>
  
  <!--地震速报-->
  <xsl:template match="tr" mode="dzsb">
    <xsl:choose>
      <xsl:when test ="td/a[contains(@href,'javascript:openseis')]">     
          <xsl:apply-templates mode="dzsb"/>
        <br/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match ="font[contains(@style,'red') or contains(@color,'red')]" mode="dzsb">
    <xsl:if test ="contains(@style,'red')">
      <img src="arrow02.png"/>&#160;
    </xsl:if>

    <xsl:if test ="contains(@color,'red')">
      <font color="#ff0000">
        &#160;<xsl:apply-templates/>&#160;
      </font>
    </xsl:if>
 
  </xsl:template>

  <xsl:template match ="a" mode="dzsb">
    <a href='?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/dizhenzhenqing/dzbigseisxx.asp?id={substring-before(substring-after(@href,"&apos;"),"&apos;")}'>
      <xsl:apply-templates mode="dzsb"/>
    </a>
  </xsl:template>

  <xsl:template match ="font[@color='red']">
    <font color="#ff0000">
      <xsl:apply-templates/>
    </font>
  </xsl:template>

  <xsl:template match ="br" mode="dzsb">
    &#160;
  </xsl:template>
  
   <!--局内新闻-->
  <xsl:template match="tr" mode="new">
    <xsl:if test ="position()&lt;5">
      <xsl:apply-templates mode="new"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match ="font[contains(@style,'red') or contains(@color,'red')]" mode="new">
    <xsl:if test ="contains(@style,'red')">
      <img src="arrow02.png"/>&#160;
    </xsl:if>

    <xsl:if test ="contains(@color,'red')">
      <font color="#ff0000">
        &#160;<xsl:apply-templates/>&#160;
      </font>
    </xsl:if>
  </xsl:template>


  <xsl:template match ="td" mode="new">
    <xsl:choose>
      <xsl:when test ="contains(text(),'·')">
        <img src="arrow02.png"/>&#160;
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--地方新闻-->
  <xsl:template match ="tr" mode="newdf">
    <xsl:if test ="position()&gt;16 and position()&lt;21">
      <xsl:apply-templates mode="new"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <!--<xsl:template match ="a" mode="new">
    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/{@href}&amp;nologin=true">
      <xsl:apply-templates/>
    </a>
  </xsl:template>-->

 <!--新闻详情的链接-->
  <xsl:template match ="a">
    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/{@href}&amp;nologin=true">
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <!--地震知识-->
  <xsl:template match ="tr" mode="dzzs">
    <xsl:if test ="position()&gt;1 and position()&lt;6">
      <xsl:apply-templates select="td/a" mode='dzzs'/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match ="a" mode="dzzs">
    <img src="arrow02.png"/>&#160;
    <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/{@href}&amp;nologin=true">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match ="a" mode="gg">
    <xsl:choose>
      <xsl:when test ="contains(text(),'更多')">
        
      </xsl:when>
      <xsl:otherwise>
        <img src="arrow02.png"/>&#160; <a href="?action=bs-transfer@mdp&amp;url=http://www.gdsin.net/{@href}&amp;nologin=true">
          <xsl:apply-templates/>
        </a>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>