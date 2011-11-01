<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">

<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg">
<tr><td align="right" width="30%"></td><td></td></tr>
<xsl:choose>
<xsl:when test="@hasCreateBizUserPermission = 'true'">
<tr><td align="right">用户名：</td><td><input type="text" id="username" chname="用户名" notempty="true" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">密 码：</td><td><input type="password" maxlength="20" id="password" chname="密码" notempty="true"/><span class="star"> *</span><span style="color:red">密码至少8位</span><span class="star"></span></td></tr>
<tr><td align="right">确认密码：</td><td><input type="password" chname="确认密码" id="confirmpassword" notempty="true"/><span class="star"> *</span><span style="color:red">密码至少8位</span><span class="star"></span></td></tr>
</xsl:when>
<xsl:otherwise>
<tr><td align="right"></td><td><input type="hidden" id="username" chname="用户名" notempty="true" maxlength="20"/><input type="hidden" id="password" chname="密码" notempty="true"/><input type="hidden" chname="确认密码" id="confirmpassword" notempty="true"/></td></tr>
</xsl:otherwise>
</xsl:choose>
<tr><td align="right">真实姓名：</td><td><input type="text" id="truename" chname="真实姓名" notempty="true" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">用户类型：</td><td>
<select id="usertype">
<xsl:apply-templates select="usertypelist/usertype"/>
</select>
<span class="star"> *</span></td></tr>
<tr><td align="right">手机类型：</td><td>
<select id="mobiletype">
</select>
<span class="star"> *</span></td></tr>
<tr><td align="right">手机号码：</td><td><input type="text" id="mobile" chname="手机号码" notempty="true" istel="true" maxlength="15"/><span class="star"> *</span></td></tr>
<tr><td align="right">证件类型：</td><td>
<select id="idtype">
<option value="身份证">身份证</option>
<option value="驾照">驾照</option>
<option value="护照">护照</option>
</select></td></tr>
<tr><td align="right">证件号码：</td><td><input type="text" id="idno" maxlength="18"/><span class="star"> </span></td></tr>
<tr><td align="right">工作电话：</td><td><input type="text" id="companytel" chname="联系电话" istel="true" maxlength="15"/><span class="star"> </span></td></tr>
<tr><td align="right">住宅电话：</td><td><input type="text" id="hometel" chname="住宅电话" istel="true" maxlength="15"/><span class="star"> </span></td></tr>
<tr><td align="right">电子邮件：</td><td><input type="text" id="email" maxlength="50"/><span class="star"> </span></td></tr>
<tr><td align="right">联系地址：</td><td><input type="text" id="city" maxlength="20"/><span class="star"> </span></td></tr>
<tr style="display:none"><td align="right">SSOID：</td><td><input type="text" id="ssoid" maxlength="40"/><span class="star"> </span></td></tr>
<tr><td align="right">备 注(限50字)：</td><td><textarea id="commentuser"></textarea><span class="star"> </span></td></tr>

<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserCreate();" value=" 确认提交 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList(catalogid);GetUserList(catalogid);</xsl:attribute></input></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
  
  <xsl:template match="usertype">
  <option>
  <xsl:attribute name="value">
  <xsl:value-of select="@name"></xsl:value-of>
  </xsl:attribute>  
  <xsl:value-of select="@name"></xsl:value-of></option>
  </xsl:template>
</xsl:stylesheet>