<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <!--
  
    @author wzc
        WAP xsl使用的常量文件.所有通用的常量都放在这里.
  
  -->

  <xsl:variable name="bstransfer">?action=bs-transfer@mdp&amp;url=</xsl:variable>
  <xsl:variable name="localurl">?action=bs-transfer@mdp&amp;localurl=</xsl:variable>
  <xsl:variable name="viewfileremote">?action=viewfileremote@mdp&amp;url=</xsl:variable>
  <xsl:variable name="viewimageremote">?action=viewimageremote@mdp&amp;url=</xsl:variable>
  <!--<xsl:variable name="getres">?action=res@wap&amp;res=</xsl:variable>-->
  <xsl:variable name="getimg">?action=getimg@wap&amp;img=</xsl:variable>
  <xsl:variable name="getskin">?action=getskin@wap&amp;skin=</xsl:variable>
  <xsl:variable name="getxml">?action=getxml@wap&amp;xml=</xsl:variable>
  
  <xsl:variable name="appid" select="/msc/@appid"></xsl:variable>
  <xsl:variable name="appfolder" select="/msc/@appfolder"></xsl:variable>
  
  <xsl:variable name="wapfolder" select="'/wap/images/'"></xsl:variable>
  <xsl:variable name="wapAction" select="'/wap/m.do'"></xsl:variable>
  
  <xsl:variable name="target" select="'target'"></xsl:variable>

  <xsl:variable name="QRY" select="'_MSC_CMD_=QRY'"></xsl:variable>


  <xsl:variable name="wap11Title" select="' - MKey 3G WAP 1.0'"></xsl:variable>
  <xsl:variable name="wap20Title" select="' - MKey 3G WAP 2.0'"></xsl:variable>
  
  
</xsl:stylesheet>
