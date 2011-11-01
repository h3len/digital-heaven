<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:template match="/exts">
      <xsl:choose>
        <xsl:when test="@outputType = 'MSC3'">
          <msc type="form" action="?action=updateextuser@mdp">
            <head>
              <title>用户扩展信息</title>
            </head>
            <body>
              <span width="100%" dock="top" align="center" bgcolor="#CCCCCC">
                <strong>
                  <font color="#FF0000" size="xl">用户扩展信息</font>
                </strong>
                <hr />
              </span>
              <br />
              <span width="100%" align="center">
                <span width="49%" align="right">系统标识：</span><span width="49%" align="left"><xsl:value-of select="/exts/oaSysid/text()"/></span></span>
              <span width="100%" align="center"> <span width="49%" align="right">系统账号：</span><span width="49%" align="left"><xsl:value-of select="/exts/oaUser/text()"/></span></span>
              <span width="100%" align="center"> <span width="49%" align="right">绑定手机：</span><span width="49%" align="left"><xsl:value-of select="/exts/mobile/text()"/></span></span>
              <span align="center" width="49%">
                <input type="button" href="?action=loadextusercreate@mdp&amp;extId={/exts/id/text()}" caption="修改信息" />
              </span>
              <span align="center" width="49%">
                <input type="button" href="?action=getextusers@mdp" caption="返回列表" />
              </span>
            </body>
          </msc>
        </xsl:when>
        <xsl:otherwise>
          <!--
            //TODO 有内容并且为MSC2时!
          -->
          <msc type="form" title="用户扩展信息" action="?action=updateextuser@mdp">
            <body>
              <font align="center" bold="true" color="#FF0000" size="large">用户扩展信息</font>
              <hr />
              <font color="#999999">系统标识：</font>
              <xsl:value-of select="/exts/oaSysid/text()"/>
              <br />
              <font color="#999999">系统账号：</font>
              <xsl:value-of select="/exts/oaUser/text()"/>
              <br />
              <font color="#999999">绑定手机：</font>
              <xsl:value-of select="/exts/mobile/text()"/>
              <br />
            </body>
            <foot>
              <input type="button" href="?action=loadextusercreate@mdp&amp;extId={/exts/id/text()}" target="_self" caption="修改信息" />
              <input type="button" href="?action=delextusers@mdp&amp;ids={/exts/id/text()}" target="_self" caption="删除绑定" />
              <input type="button" href="?action=getextusers@mdp" caption="返回列表" target="_self" />
            </foot>
          </msc>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>


  <xsl:template name="show">
    <xsl:param name="valueA"></xsl:param>
    <xsl:param name="valueB"></xsl:param>
    <xsl:choose>
      <xsl:when test="/exts/@isCreate = 'true'"><xsl:value-of select="$valueA"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$valueB"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
