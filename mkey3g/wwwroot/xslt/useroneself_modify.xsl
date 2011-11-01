<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="root">

<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg">
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="40%">用户名：</td><td><xsl:value-of select="/root/user/@username" /><input type="hidden" id="username"><xsl:attribute name="value"><xsl:value-of select="/root/user/@username" /></xsl:attribute></input><input type="hidden" id="ssoid"><xsl:attribute name="value"><xsl:value-of select="/root/user/@ssoid" /></xsl:attribute></input></td></tr>
<tr><td align="right">真实姓名：</td><td><input type="text" id="truename"><xsl:attribute name="value"><xsl:value-of select="/root/user/@truename" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">手机类型：</td><td><select id="mobiletype"></select><span class="star"> *</span></td></tr>
<tr><td align="right">手机号码：</td><td><input type="text" id="mobile"><xsl:attribute name="value"><xsl:value-of select="/root/user/@mobile" /></xsl:attribute></input><span class="star"> *</span></td></tr>
<tr><td align="right">证件类型：</td><td>
<select id="idtype">
<option value="身份证">身份证</option>
<option value="驾照">驾照</option>
<option value="护照">护照</option>


</select>
</td></tr>
<tr><td align="right">证件号码：</td><td><input type="text" id="idno"><xsl:attribute name="value"><xsl:value-of select="/root/user/@idno" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">联系电话：</td><td><input type="text" id="companytel"><xsl:attribute name="value"><xsl:value-of select="/root/user/@companytel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">家庭电话：</td><td><input type="text" id="hometel"><xsl:attribute name="value"><xsl:value-of select="/root/user/@hometel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">联系地址：</td><td><input type="text" id="city"><xsl:attribute name="value"><xsl:value-of select="/root/user/@city" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">备 注：</td><td><textarea id="comment" style="height:60px;"><xsl:value-of select="/root/user/@comment" /></textarea><span class="star"> </span></td></tr>
<tr><td align="center" colspan="2"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserModifyInfo();" style="cursor:pointer;" value=" 确认提交 "/> <input type="button" value=" 重 置 "  onclick="InfoReset();"/></td><td></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>