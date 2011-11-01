<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test ="contains(//url,'?show=lxwm')">
        <msc type="form">
          <head>
            <title>
              <xsl:value-of select="//title/text()"/>
            </title>
          </head>
          <body>
            <!--logo-->
            <xsl:call-template name="title"/>
            <span width="100%" height="48px" bgcolor="#fef1e1">
              <br/>
              当前位置：<a href="http://www.cp.gov.cn/">首  页</a>&#160;&gt;&#160;联系我们&#160;&gt;&gt;
            </span>
            <hr/>
            <xsl:apply-templates select="//td[contains(text()[3],'东莞市常平镇人民政府版权所有')]/text()[position()&lt;3]" mode="lxwm"/>
          </body>
        </msc>
      </xsl:when>
      <xsl:otherwise>
        <msc type="form">
          <head>
            <title>
              <xsl:value-of select="//title/text()"/>
            </title>
          </head>
          <body>
            <!--logo-->
            <xsl:call-template name="title"/>
            <span width="100%" height="1px" bgcolor="#cbb54c"/>
            <span width="100%" align="center" bgcolor="#FFEA76">
              <span width="100%" height="7px"/>
              <a href="?action=bs-transfer@mdp&amp;url=http://xxgk.dg.gov.cn/publicfiles/business/htmlfiles/0526/1.1/200908/159009.htm">常平简介</a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://xxgk.dg.gov.cn/publicfiles/business/htmlfiles/0526/1.2/200907/154345.htm">机构领导</a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://xxgk.dg.gov.cn/publicfiles/business/htmlfiles/0526/1.3/200908/159019.htm">内设机构</a>
              <span width="100%" height="7px"/>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/03xinwen/news.asp">常平信息</a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/02zhengfu/tx123.asp?c_id=2">共青团讯</a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/07renxian/zzxx.asp?chl_id=1">镇长信箱</a>
              <span width="100%" height="7px"/>
            </span>
            <span width="100%" height="4px"/>
            
 

            <span width="100%" height="1px" bgcolor="#f9d393"/>
            <!--政府公告-->
            <span width="100%" height="21px" bgcolor="#ffefd4">
              <img src="DHDGCP_zfgg.png" href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/03xinwen/05redian.asp?c_id=106"/>
            </span>
            <!--政府公告内容-->
            <span width="100%">
              <span width="100%" height="7px"/>
              <xsl:apply-templates select ="//body/meta[@name='GENERATOR'][1]/following-sibling::table[5]/tbody/tr[2]//td[@class='table_line']/../../tr[position()&lt;7]" mode="list"/>
            </span>
            <span width="100%" height="4px"/>
            <span width="100%" height="1px" bgcolor="#f9d393"/>
            <!--热点报道-->
            <span width="100%" height="21px" bgcolor="#ffefd4">
              <img src="DHDGCP_rdbd.png" href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/03xinwen/03redian.asp"/>
            </span>
            <!--热点报道内容-->
            <span width="100%">
              <span width="100%" height="7px"/>
              <xsl:apply-templates select ="//body/meta[@name='GENERATOR'][2]/following-sibling::table[5]/tbody/tr[2]//td[@class='table_line']/../../tr[position()&lt;7]" mode="list"/>
            </span>
            <span width="100%" height="4px"/>

            <span width="100%" height="1px" bgcolor="#f9d393"/>
            <!--政府采购-->
            <span width="100%" height="21px" bgcolor="#ffefd4">
              <img src="DHDGCP_zfcg.png" href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/newver/02zhengfu/zfcg.asp?c_id=18"/>
            </span>
            <!--政府采购内容-->
            <span width="100%">
              <span width="100%" height="7px"/>
              <xsl:apply-templates select ="//body/meta[@name='GENERATOR'][3]/following-sibling::table[5]/tbody/tr[2]//td[@class='table_line']/../../tr[position()&lt;7]" mode="list"/>
            </span>
            <!--<a href="?action=bs-transfer@mdp&amp;url=http://www.cp.gov.cn/?show=lxwm">联系我们</a>-->
          </body>
        </msc>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="text()" mode="lxwm">
    <xsl:value-of select="."/>
    <br/>
  </xsl:template>

  <xsl:template match="tr" mode="list">
    <img src="DHDGCP_icon_1.png"/>
    <xsl:apply-templates select="./td/a" mode="list"/>
    <!--<xsl:apply-templates select="./td[2]"/>-->
  </xsl:template>
  <!--显示前六条信息-->
  <xsl:template match="a" mode="list">
    <a href="{$cp_url}{@href}">
      <xsl:choose>
        <xsl:when test ="string-length(.)&gt;16">
          <xsl:value-of select ="substring(.,1,14)"/>..
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select ="."/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
    <span width="100%" height="7px"/>
  </xsl:template>

</xsl:stylesheet>
