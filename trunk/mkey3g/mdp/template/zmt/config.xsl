<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!--
  @describe     || 全局配置文件，主要是对全局的变量进行控制。
-->

  <!--============================公有Begin===========================================-->
  <!--常用命令-->
  <xsl:variable name="bstransfer" select="'?action=bs-transfer@mdp&amp;url='"/>
  <xsl:variable name="localurl" select="'?action=bs-transfer@mdp&amp;localurl='"/>
  <xsl:variable name="viewfileremote" select="'?action=viewfileremote@mdp&amp;url='"/>
  <xsl:variable name="viewimageremote" select="'?action=viewimageremote@mdp&amp;url='"/>

  <!--全局基础ip地址-->
  <xsl:variable name="ip_url">www.dgzmt.gov.cn</xsl:variable>
  <xsl:variable name="cp_url">http://www.dgzmt.gov.cn</xsl:variable>

  <!--背景颜色-->
  <xsl:variable name="bgcolor">#deeef8</xsl:variable>

  <!--背景图片-->
  <xsl:variable name="background">background.png</xsl:variable>

  <!--showHead-->
  <xsl:variable name="showHead">false</xsl:variable>

  <!--showFoot-->
  <xsl:variable name="showFoot">true</xsl:variable>

  <!--判断是否为Wap方式登录的变量-->
  <xsl:variable name="is_wap">
    <xsl:if test="0">true</xsl:if>
  </xsl:variable>

  <!--客户端类型-->
  <xsl:variable name="clientType">
    <xsl:choose>
      <xsl:when test="1">iphone</xsl:when>
      <xsl:otherwise>others</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--判断是否登录超时的变量,OverTime-->
  <xsl:variable name="is_OT">
    <xsl:if test="contains(//input[@name='ReasonText']/@value,'重新登录')">true</xsl:if>
  </xsl:variable>

  <xsl:template name="title">
    <span width="100%" height="68px" align="center" bgcolor="#c3e8fc">
      <img src="DHDGCP_logo.png"/>
    </span>
    <span width="100%" height="4px"/>
  </xsl:template>

  <!--登录超时时，跳转到登录界面-->
  <xsl:template name="go_login">
    <msc type="servermsg" priority="high">
      <msg buttonstyle="OK" show="true">
        <xsl:value-of select="//input[@name='ReasonText']/@value"/>
      </msg>
      <script><![CDATA[application.gologin();]]></script>
    </msc>
  </xsl:template>

  <!--头部-->
  <xsl:template name="top_nav">
    <span width="100%" dock="top">
      <span width="100%" align="center">
        <img src="top.png"/>
      </span>
    </span>
  </xsl:template>

  <!--listitem通用模板-->
  <xsl:template name="list_item">
    <xsl:param name="icon" select="'list_item.png'"/>
    <xsl:param name="target" select="'_blank'"/>
    <xsl:param name="checked" select="''"/>
    <xsl:param name="value" select="''"/>
    <xsl:param name="href"/>
    <xsl:param name="caption"/>
    <!--<xsl:param name="caption_title" select="'标题'"/>-->
    <xsl:param name="sndcaption"/>
    <xsl:param name="sndcaption_title" select="'流程'"/>
    <xsl:param name="digest"/>
    <!--<xsl:param name="digest_title" select="'当前环节'"/>-->
    <xsl:param name="is_bold" select="''"/>

    <listitem href="{$href}" target="{$target}" icon="{$icon}" checked="{$checked}" value="{$value}">
      <xsl:if test="not($is_bold)">
        <caption>
          <!--<font color=""><xsl:value-of select="$caption_title"/>：</font>-->
          <font color="#00528e">
            <xsl:value-of select="$caption"/>
          </font>
        </caption>

        <xsl:if test="$sndcaption!=''">
          <sndcaption>
            <font color="">
              <xsl:value-of select="$sndcaption_title"/>：
            </font>
            <font color="">
              <xsl:value-of select="$sndcaption"/>
            </font>
          </sndcaption>
        </xsl:if>

        <xsl:if test="$digest!=''">
          <digest>
            <!--<font color=""><xsl:value-of select="$digest_title"/>：</font>-->
            <font color="">
              <xsl:value-of select="$digest"/>
            </font>
          </digest>
        </xsl:if>
      </xsl:if>

      <!--加粗显示-->
      <xsl:if test="$is_bold">
        <caption>
          <strong>
            <!--<font color=""><xsl:value-of select="$caption_title"/>：</font>-->
            <font color="#00528e">
              <xsl:value-of select="$caption"/>
            </font>
          </strong>
        </caption>

        <xsl:if test="$sndcaption!=''">
          <sndcaption>
            <strong>
              <font color="">
                <xsl:value-of select="$sndcaption_title"/>：
              </font>
              <font color="">
                <xsl:value-of select="$sndcaption"/>
              </font>
            </strong>
          </sndcaption>
        </xsl:if>

        <xsl:if test="$digest!=''">
          <digest>
            <strong>
              <!--<font color=""><xsl:value-of select="$digest_title"/>：</font>-->
              <font color="">
                <xsl:value-of select="$digest"/>
              </font>
            </strong>
          </digest>
        </xsl:if>
      </xsl:if>
    </listitem>
  </xsl:template>

  <!--非listbox列表-->
  <xsl:template name="list_ljh">
    <xsl:param name="href"/>
    <xsl:param name="icon" select="'list.png'"/>
    <!--<xsl:param name="caption_title" select="'标题'"/>-->
    <xsl:param name="caption" select="''"/>
    <xsl:param name="sndcaption_title" select="'流程名称'"/>
    <xsl:param name="sndcaption" select="''"/>
    <xsl:param name="digest_title" select="'接收时间'"/>
    <xsl:param name="digest" select="''"/>

    <span target="_blank" href="?action=bs-transfer@mdp&amp;url={$href}">
      <span width="100%" align="center" height="5"/>
      <img src="{$icon}"/>

      <!--<font color=""><xsl:value-of select="$caption_title"/>：</font>-->
      <font color="#00528e">
        <a target="_blank" href="?action=bs-transfer@mdp&amp;url={$href}">
          <xsl:value-of select="$caption"/>
        </a>
      </font>
      <br/>
      <xsl:if test="$sndcaption != ''">
        <font color="">
          <xsl:value-of select="$sndcaption_title"/>：
        </font>
        <font color="">
          <xsl:value-of select="$sndcaption"/>
        </font>
        <br/>
      </xsl:if>
      <xsl:if test="$digest != ''">
        <font color="">
          <xsl:value-of select="$digest_title"/>：
        </font>
        <font color="">
          <xsl:value-of select="$digest"/>
        </font>
      </xsl:if>
      <span width="100%" align="center" height="5"/>
    </span>
    <hr color="#eeeeee"/>
  </xsl:template>

  <!--============================公有End===========================================-->

</xsl:stylesheet>
