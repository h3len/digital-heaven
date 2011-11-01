<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root/sms">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
<tr><td align="right" width="30%">应用名称：</td><td><input type="text" id="appname" maxLength="100"><xsl:attribute name="value"><xsl:value-of select="appname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">密 码：</td><td><input type="password" id="password" maxLength="20" ><xsl:attribute name="value"><xsl:value-of select="password" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">机构名称：</td><td><input type="text" id="branchname" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="branchname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">无线网关URL：</td><td><input type="text" id="dhwgurl" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="dhwgurl" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">平台名称：</td><td><input type="text" id="platformname" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="platformname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">短信号码：</td><td><input type="text" id="smsbasenumber" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="smsbasenumber" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">失败重试次数：</td><td><input type="text" id="faillimit" maxLength="10" ><xsl:attribute name="value"><xsl:value-of select="faillimit" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td colspan="2" class="ar">（*注：修改配置后需要重新启动服务才能生效）</td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>