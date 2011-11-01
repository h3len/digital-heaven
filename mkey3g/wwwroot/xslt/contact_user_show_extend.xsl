<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">真实姓名：</td><td><xsl:value-of select="/root/user/@truename" /></td></tr>
<tr><td align="right">所属部门：</td><td><xsl:value-of select="/root/user/@catalogname" /></td></tr>
<tr><td align="right">职务：</td><td><xsl:value-of select="/root/user/@title" /></td></tr>
<tr><td align="right">手机号码：</td><td><xsl:value-of select="/root/user/@mobile" /></td></tr>
<tr><td align="right">电子邮件：</td><td><xsl:value-of select="/root/user/@email" /></td></tr>
<tr><td align="right">联系电话：</td><td><xsl:value-of select="/root/user/@companytel" /></td></tr>
<tr><td align="right">住宅电话：</td><td><xsl:value-of select="/root/user/@hometel" /></td></tr>
<tr><td align="right">联系地址：</td><td><xsl:value-of select="/root/user/@city" /></td></tr>
<tr><td align="right">备 注：</td><td><xsl:value-of select="/root/user/@comment" /></td></tr>
<tr><td align="right">创建日期：</td><td><xsl:value-of select="/root/user/@createtime" /></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/user/@catalogid" />");GetUserList("<xsl:value-of select="/root/user/@catalogid" />");</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
