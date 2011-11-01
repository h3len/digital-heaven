<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="90%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">发信人：</td><td><xsl:value-of select="/root/msg/@msgfrom" /></td></tr>
<tr><td align="right">收信人：</td><td><xsl:value-of select="/root/msg/@msgto" /></td></tr>
<tr><td align="right">消息内容：</td><td><xsl:value-of select="/root/msg" disable-output-escaping="yes" /> </td></tr>
<tr><td align="right">日期：</td><td><xsl:value-of select="/root/msg/@date" /></td></tr>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" colspan="2"><input type="button" style="cursor:hand;" id="btnOK" name="btnOK" value=" 返回即时信息列表 "><xsl:attribute name="onclick">javascript:GetMsgList();</xsl:attribute></input></td></tr> 
</table>
  </xsl:template>
</xsl:stylesheet>
