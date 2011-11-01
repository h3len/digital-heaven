<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">真实姓名：</td><td><input type="text" id="truename" size="20"><xsl:attribute name="value"><xsl:value-of select="/root/user/@truename" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">手机号码：</td><td><input type="text" id="mobile" istel="true"><xsl:attribute name="value"><xsl:value-of select="/root/user/@mobile" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">电子邮件：</td><td><input type="text" id="email"><xsl:attribute name="value"><xsl:value-of select="/root/user/@email" /></xsl:attribute></input></td></tr>
<tr><td align="right">职务：</td><td><input type="text" id="title"><xsl:attribute name="value"><xsl:value-of select="/root/user/@title" /></xsl:attribute></input></td></tr>
<tr><td align="right">联系电话：</td><td><input type="text" id="companytel"><xsl:attribute name="value"><xsl:value-of select="/root/user/@companytel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">住宅电话：</td><td><input type="text" id="hometel"><xsl:attribute name="value"><xsl:value-of select="/root/user/@hometel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">联系地址：</td><td><input type="text" id="city"><xsl:attribute name="value"><xsl:value-of select="/root/user/@city" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">备 注：</td><td><textarea id="comment"><xsl:value-of select="/root/user/@comment" /></textarea><span class="star"> </span></td></tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserModifyInfo();" value=" 确认提交 "/> <input type="button" onclick="javascript:UserShow(currentUserId);" value=" 返回浏览用户信息 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/user/@catalogid" />");GetUserList("<xsl:value-of select="/root/user/@catalogid" />");</xsl:attribute></input></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>