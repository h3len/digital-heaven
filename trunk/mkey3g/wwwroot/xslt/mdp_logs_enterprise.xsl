<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/branches">
        <xsl:choose>
          <xsl:when test="/branches/@adminType = '2'">
            选择企业：<select name="selBranch" style="width:100px;" onchange="changeEnterpriseId(this.value);">
              <option value="">所有</option>
              <xsl:apply-templates select="/branches/branch" />
            </select>
          </xsl:when>
          <xsl:otherwise>
            选择应用：<select name='selAppid' style='width:100px;' onchange='changeAppid(this.value);'>
              <option value=''>所有</option>
              <xsl:apply-templates select="/branches/app" />
            </select>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:when>
      <xsl:when test="/apps">
        选择应用：<select name='selAppid' style='width:100px;' onchange='changeAppid(this.value);'>
        <option value=''>所有</option>
          <xsl:apply-templates select="/apps/app" />
        </select>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="branch">
    <option value="{@id}">
      <xsl:value-of select="@code"/>
    </option>
  </xsl:template>

  <xsl:template match="app">
    <option value="{@id}">
      <xsl:value-of select="@appName"/>
    </option>
  </xsl:template>
  
</xsl:stylesheet>
