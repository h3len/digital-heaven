<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="wapConstants.xsl"/>
  
  <xsl:variable name="wap11" select="'wap1.1'"></xsl:variable>
  <xsl:variable name="wap20" select="'wap2.0'"></xsl:variable>
  
  <!-- 输出最下边的菜单栏...最好弄成动态的..因为有些页面不需要有些按钮. -->
  <xsl:template name="getMenuButtons">
    <xsl:param name="outputType"></xsl:param>
    <xsl:param name="mode"></xsl:param>
    <xsl:choose>
      <xsl:when test="$outputType = $wap11">
        <!-- WAP1.1 WML -->
        <br />
        <xsl:choose>
          <xsl:when test="$mode = 'default' or $mode = 'home'">
            <a href="{$wapAction}?action=gohome@wap">主页</a>-<a href="{$wapAction}?appid={$appid}">注销</a>-<a href="{$wapAction}">应用</a>-&lt;普版&gt;-<a href="{$wapAction}?action=changever@wap&amp;wap=wap20">炫版</a><br />
          </xsl:when>
          <xsl:when test="$mode = 'login'">
            <a href="{$wapAction}">应用</a>-&lt;普版&gt;-<a href="{$wapAction}?action=gologin@wap&amp;wap=wap20">炫版</a><br />
          </xsl:when>
          <xsl:when test="$mode = 'applist'">
            &lt;普版&gt;-<a href="{$wapAction}?wap=wap20">炫版</a>
            <br />
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$outputType = $wap20">
        <!-- WAP2.0 XHTML -->
        <div class="bottomMenu">
        
          <xsl:choose>
            <xsl:when test="$mode = 'default' or $mode = 'home'">
            <a href="{$wapAction}?action=back@wap&amp;target=_self">返回</a>-<a href="{$wapAction}?action=dhs_msgcenter@wap">消息中心</a>-<a href="{$wapAction}?action=gohome@wap">主页</a>-<a href="{$wapAction}?appid={$appid}">注销</a>-<a href="{$wapAction}">应用</a>-<a href="{$wapAction}?action=changever@wap&amp;wap=wap11">普版</a>-&lt;炫版&gt;
              <br />
            </xsl:when>
            <xsl:when test="$mode = 'login'">
              <a href="{$wapAction}">应用</a>-<a href="{$wapAction}?action=gologin@wap&amp;wap=wap11">普版</a>-&lt;炫版&gt;
              <br />
            </xsl:when>
            <xsl:when test="$mode = 'applist'">
              <a href="{$wapAction}?wap=wap11">普版</a>-&lt;炫版&gt;
              <br />
            </xsl:when>
          </xsl:choose>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
