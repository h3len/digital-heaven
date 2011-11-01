<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:template match="/exts">
      <xsl:choose>
        <xsl:when test="@outputType = 'MSC3'">
          <msc type="form" action="?action=updateextuser@mdp">
            <head>
              <title>
                <xsl:call-template name="show" >
                  <xsl:with-param name="valueA" select="'修改用户扩展'" />
                  <xsl:with-param name="valueB" select="'创建用户扩展'" />
                </xsl:call-template>
              </title>
            </head>
            <body>
              <span width="100%" dock="top" align="center" bgcolor="#CCCCCC">
                <strong>
                  <font color="#FF0000" size="xl">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="'修改用户扩展'" />
                      <xsl:with-param name="valueB" select="'创建用户扩展'" />
                    </xsl:call-template>
                  </font>
                </strong>
              </span>
              <span width="35%" align="right">系统标识<font color="#FF0000">*</font>：</span>
              <span width="64%" align="left">
                <input type="text" name="oaSysid" width="70%">
                  <xsl:attribute name="value">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="/exts/oaSysid/text()" />
                      <xsl:with-param name="valueB" select="''" />
                    </xsl:call-template>
                  </xsl:attribute>
                </input>
              </span>
              <br />
              
              <span width="35%" align="right">系统账号<font color="#FF0000">*</font>：</span>
              <span width="64%" align="left">
                <input type="text" name="oaUser" width="70%">
                  <xsl:attribute name="value">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="/exts/oaUser/text()" />
                      <xsl:with-param name="valueB" select="''" />
                    </xsl:call-template>
                  </xsl:attribute>
                </input>
              </span>
              <br />

              <span width="35%" align="right">系统密码<font color="#FF0000">*</font>：</span>
              <span width="64%" align="left">
                <input type="password" name="oaPass"  width="70%">
                  <xsl:attribute name="value">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="/exts/pass/text()" />
                      <xsl:with-param name="valueB" select="''" />
                    </xsl:call-template>
                  </xsl:attribute>
                </input>
              </span>
              <br />
              
              <span width="35%" align="right">绑定手机：</span>
              <span width="64%" align="left">
                <input type="text" name="mobile" width="70%">
                  <xsl:attribute name="value">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="/exts/mobile/text()" />
                      <xsl:with-param name="valueB" select="''" />
                    </xsl:call-template>
                  </xsl:attribute>
                </input>
              </span>
              <br />
              
              <xsl:if test="/exts/@isCreate = 'false'">
                <input type="hidden" name="extId" value="{/exts/id/text()}" />
              </xsl:if>

              <span align="center" width="49%">
                <input type="submit">
                  <xsl:attribute name="caption">
                    <xsl:call-template name="show" >
                      <xsl:with-param name="valueA" select="'确定修改'" />
                      <xsl:with-param name="valueB" select="'确定创建'" />
                    </xsl:call-template>
                  </xsl:attribute>
                </input>
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
          <msc type="form" action="?action=updateextuser@mdp" target="_self">
            <xsl:attribute name="title">
              <xsl:call-template name="show" >
                <xsl:with-param name="valueA" select="'修改用户扩展'" />
                <xsl:with-param name="valueB" select="'创建用户扩展'" />
              </xsl:call-template>
            </xsl:attribute>
            <body>
              <font color="#FF0000" size="large" align="center" bold="true">
                <xsl:call-template name="show" >
                  <xsl:with-param name="valueA" select="'修改用户扩展'" />
                  <xsl:with-param name="valueB" select="'创建用户扩展'" />
                </xsl:call-template>
              </font>
              <hr />系统标识*：
              <input type="text" name="oaSysid">
                <xsl:attribute name="value">
                  <xsl:call-template name="show" >
                    <xsl:with-param name="valueA" select="/exts/oaSysid/text()" />
                    <xsl:with-param name="valueB" select="''" />
                  </xsl:call-template>
                </xsl:attribute>
              </input>
              <br />系统账号*：
              <input type="text" name="oaUser">
                <xsl:attribute name="value">
                  <xsl:call-template name="show" >
                    <xsl:with-param name="valueA" select="/exts/oaUser/text()" />
                    <xsl:with-param name="valueB" select="''" />
                  </xsl:call-template>
                </xsl:attribute>
              </input>
              <br />系统密码*：
              <input type="password" name="oaPass">
                <xsl:attribute name="value">
                  <xsl:call-template name="show" >
                    <xsl:with-param name="valueA" select="/exts/pass/text()" />
                    <xsl:with-param name="valueB" select="''" />
                  </xsl:call-template>
                </xsl:attribute>
              </input>
              <br />绑定手机：
              <input type="text" name="mobile">
                <xsl:attribute name="value">
                  <xsl:call-template name="show">
                    <xsl:with-param name="valueA" select="/exts/mobile/text()" />
                    <xsl:with-param name="valueB" select="''" />
                  </xsl:call-template>
                </xsl:attribute>
              </input>
              <br />
              <xsl:if test="/exts/@isCreate = 'false'">
                <input type="hidden" name="extId" value="{/exts/id/text()}" />
              </xsl:if>
            </body>
            <foot>
              <input type="submit" align="primary">
                <xsl:attribute name="caption">
                  <xsl:call-template name="show" >
                    <xsl:with-param name="valueA" select="'确定修改'" />
                    <xsl:with-param name="valueB" select="'确定创建'" />
                  </xsl:call-template>
                </xsl:attribute>
              </input>
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
      <xsl:when test="/exts/@isCreate = 'false'"><xsl:value-of select="$valueA"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$valueB"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
