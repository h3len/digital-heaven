<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root/sms">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
<tr><td align="right" width="30%">InforX主机地址：</td><td><input type="text" id="infoxserveraddr" maxLength="100"><xsl:attribute name="value"><xsl:value-of select="infoxserveraddr" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">InforX主机端口：</td><td><input type="text" id="infoxserverport" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="infoxserverport" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">短信号码：</td><td><input type="text" id="smsbasenumber" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="smsbasenumber" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">SPID：</td><td><input type="text" id="spid" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="spid" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">SP密 码：</td><td><input type="password" id="sppasswd" maxLength="20" ><xsl:attribute name="value"><xsl:value-of select="sppasswd" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">服务号码：</td><td><input type="text" id="serviceid" maxLength="100" ><xsl:attribute name="value"><xsl:value-of select="serviceid" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">失败重试次数：</td><td><input type="text" id="faillimit" maxLength="10" ><xsl:attribute name="value"><xsl:value-of select="faillimit" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td colspan="2">（*注：修改配置后需要重新启动服务才能生效）</td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>