<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../mdp.xsl"/>
  <xsl:import href="../config.xsl"/>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="contains(//url,'?show=table')">
        <msc type="table">
          <table>
            <xsl:apply-templates select="//td[@id='contents']/../../tr[position() != last()]//tbody/tr" mode="table"/>
          </table>
        </msc>
      </xsl:when>
      <xsl:otherwise>
        <msc type="form" action="">
          <head>
            <title>
              <xsl:value-of select="//title"/>
            </title>
          </head>
          <body>
            <!--logo-->
            <xsl:call-template name="title"/>
            <span width="100%" height="48px" bgcolor="#fef1e1">
              <br/>
              <br/>
              当前位置：<a href="http://www.cp.gov.cn/">首  页</a>&#160;&gt;&#160;信息荟萃&#160;&gt;&#160;
              <xsl:if test ="//td[contains(text(),'当前位置')]">
                <xsl:value-of select="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞')"/>
              </xsl:if>
              &#160;&gt;&gt;
            </span>
            <hr/>
            <xsl:apply-templates select="//td[@id='contents']/../../tr[position() != last()]"/>
            <hr/>
            <xsl:text>&#160;&#160;</xsl:text>
            <!--判断当前位置，选择上一层链接的去向-->
            <xsl:choose>
              <xsl:when test="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞') = '热点报道'">
                <a href="http://www.cp.gov.cn/newver/03xinwen/03redian.asp">返回上一层</a>
              </xsl:when>
              <xsl:when test="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞') = '常平信息'">
                <a href="http://www.cp.gov.cn/newver/03xinwen/news.asp">返回上一层</a>
              </xsl:when>
              <xsl:when test="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞') = '政府公告'">
                <a href="http://www.cp.gov.cn/newver/03xinwen/05redian.asp?c_id=106">返回上一层</a>
              </xsl:when>
              <xsl:when test="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞') = '共青团讯'">
                <a href="http://www.cp.gov.cn/newver/02zhengfu/tx123.asp?c_id=2">返回上一层</a>
              </xsl:when>
              <xsl:when test="substring-after(//td[contains(text(),'当前位置')]/.,'政府信息＞') = '政府采购'">
                <a href="http://www.cp.gov.cn/newver/02zhengfu/zfcg.asp?c_id=18">返回上一层</a>
              </xsl:when>
              <xsl:otherwise>
                <a href="http://www.cp.gov.cn/">返回首页</a>
              </xsl:otherwise>
            </xsl:choose>

          </body>

        </msc>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tr" mode="table">
    <tr>
      <xsl:apply-templates select="td" mode="table"/>
    </tr>
  </xsl:template>

  <xsl:template match="td" mode="table">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates/>
    <br/>&#160;<br/>
  </xsl:template>

  <xsl:template match="td">
    <span width="100%" align="{@align}">
      <xsl:choose>
        <xsl:when test="@bgcolor!=''">
          <font size="s">
            <xsl:apply-templates/>
          </font>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="href_last">
    <xsl:param name="href_temp"/>
    <xsl:choose>
      <xsl:when test ="contains(substring-after($href_temp,'.'),'.')">
        <xsl:call-template name="href_last">
          <xsl:with-param name="href_temp" select="substring-after($href_temp,'.')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after($href_temp,'.')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="a">
    <!--获取链接后缀,判断如果是htm类型，则为链接，否则则为附件-->
    <xsl:variable name="href_last">
      <xsl:choose>
        <xsl:when test ="contains(substring-after(@href,'.'),'.')">
          <xsl:call-template name="href_last">
            <xsl:with-param name="href_temp" select="substring-after(@href,'.')" />
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after(@href,'.')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--开始判断-->
    <xsl:choose>
      <xsl:when test="contains(@href,'/download/')">
        <fileset enableadd="false" enabledel="false">
          <fileitem caption="{.}" filetype="{$href_last}" href="{@href}"/>
        </fileset>
      </xsl:when>
      <xsl:when test="contains($href_last,'htm') or contains($href_last,'com') or contains($href_last,'cn')">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:when test="contains(@href,'mailto')">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains(@href,'http://')">
            <fileset enableadd="false" enabledel="false">
              <fileitem caption="{.}" filetype="{$href_last}" href="{@href}"/>
            </fileset>
          </xsl:when>
          <xsl:otherwise>
            <fileset enableadd="false" enabledel="false">
              <fileitem caption="{.}" filetype="{$href_last}" href="{$ip_url}{@href}"/>
            </fileset>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--表格显示-->
  <xsl:template match="tbody">
    <br/>&#160;<br/>
    <span width="100%" align="center">
      <input type="button" href="{//url}?show=table" caption="点击查看表格"/>
    </span>
    <br/>&#160;<br/>
  </xsl:template>

  <xsl:template match="img">
    <xsl:choose>
      <xsl:when test ="contains(@src,'/sysimage/file/')"/>
      <xsl:otherwise>
        <span width="100%" align="center">
          <xsl:choose>
            <xsl:when test ="contains(@src,'http://')">
              <img src="{@src}"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="{$ip_url}{@src}"/>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>



</xsl:stylesheet>
