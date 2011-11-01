<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:template match="/exts">
      <xsl:choose>
        <xsl:when test="@count &gt; 0">
          <xsl:choose>
            <xsl:when test="@outputType = 'MSC3'">
              <msc type="form" action="?action=delextusers@mdp">
                <head>
                  <title>扩展用户管理</title>
                </head>
                <body>
                  <span width="100%" dock="top" align="center" bgcolor="#CCCCCC">
                    <strong>
                      <font color="#FF0000" size="xl">用户扩展信息列表</font>
                    </strong>
                    <hr />
                  </span>
                  <listbox mode="checkbox" name="ids">
                    <xsl:apply-templates select="ext" mode="msc3" />
                  </listbox>
                </body>
                <foot>
                  <item caption="删除" type="submit" align="primary"></item>
                  <item caption="新建" type="button" href="?action=loadextusercreate@mdp"></item>
                </foot>
              </msc>
            </xsl:when>
            <xsl:otherwise>
              <!--
                //TODO 有内容并且为MSC2时!
              -->
              <msc type="list" line="2" title="扩展用户管理">
                <head>
                  <object type="toolbar">
                    <input caption="新建" type="button" href="?action=loadextusercreate@mdp" align="primary" target="_self"></input>
                  </object>
                </head>
                <body>
                  <xsl:apply-templates select="ext" mode="msc2" />
                </body>
              </msc>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="@outputType = 'MSC3'">
              <msc type="form" action="?action=delextusers@mdp">
                <head>
                  <title>扩展用户管理</title>
                </head>
                <body>
                  <span width="100%" dock="top" align="center" bgcolor="#CCCCCC">
                    <strong>
                      <font color="#FF0000" size="xl">暂时没有绑定扩展用户,点击<a href="?action=loadextusercreate@mdp">新建</a>!</font>
                    </strong>
                    <hr />
                  </span>
                </body>
                <foot>
                  <item caption="新建" type="button" href="?action=loadextusercreate@mdp" align="primary"></item>
                </foot>
              </msc>
            </xsl:when>
            <xsl:otherwise>
              <!--
                //TODO 没内容并且为MSC2时!
              -->
              <msc type="form" action="?action=delextusers@mdp" title="扩展用户管理" >
                <body>
                  <font align="center" bold="true" color="#FF0000">暂时没有绑定扩展用户!</font>
                </body>
                <foot>
                  <input caption="新建" type="button" href="?action=loadextusercreate@mdp" align="primary" target="_self"></input>
                </foot>
              </msc>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

  <xsl:template match="ext" mode="msc3">
    <listitem value="{@id}" href="?action=getextuser@mdp&amp;extId={@id}">
      <caption>
        系统标识：<xsl:value-of select="@sysid"/>
      </caption>
      <sndcaption>
        系统账号：<xsl:value-of select="@username"/>
      </sndcaption>
      <digest>
        系统账号：<xsl:value-of select="@username"/>
      </digest>
    </listitem>
  </xsl:template>
  
   <xsl:template match="ext" mode="msc2">
    <item caption="系统标识：{@sysid}" sndcaption="系统账号：{@username}" href="?action=getextuser@mdp&amp;extId={@id}" target="_self" />
  </xsl:template>
</xsl:stylesheet>
