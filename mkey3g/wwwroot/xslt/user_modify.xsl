<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1"><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">用户名：</td><td><input type="text" id="username" chname="用户名" notempty="true" maxlength="20" readonly="readonly" value="{/root/user/@username}"/></td></tr>
<tr><td align="right">真实姓名：</td><td><input type="text" id="truename" maxlength="20" value="{/root/user/@truename}" readonly="readonly"/><span class="star"> *</span></td></tr>
<tr id="trUserType" style="display:none;"><td align="right">用户类型：</td><td>
<select id="usertype">
<xsl:apply-templates select="usertypelist/usertype"/>
</select>
<span class="star"> *</span></td></tr>

<tr><td align="right">手机类型：</td><td>
<select id="mobiletype"></select>
<span class="star"> *</span></td></tr>


<tr><td align="right">手机号码：</td><td><input type="text" id="mobile" chname="手机号码" notempty="true" istel="true" size="15" readonly="readonly" value="{/root/user/@mobile}" /><span class="star"> *</span></td></tr>
<tr><td align="right">证件类型：</td><td>
<select id="idtype">
<option value="身份证">身份证</option>
<option value="驾照">驾照</option>
<option value="护照">护照</option>
</select></td></tr>
<tr><td align="right">证件号码：</td><td><input type="text" id="idno" maxlength="18"><xsl:attribute name="value"><xsl:value-of select="/root/user/@idno" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">电子邮件：</td><td><input type="text" id="email" maxlength="50"><xsl:attribute name="value"><xsl:value-of select="/root/user/@email" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">工作电话：</td><td><input type="text" id="companytel" chname="联系电话" istel="true" maxlength="15"><xsl:attribute name="value"><xsl:value-of select="/root/user/@companytel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">家庭电话：</td><td><input type="text" id="hometel" chname="住宅电话" istel="true" maxlength="15"><xsl:attribute name="value"><xsl:value-of select="/root/user/@hometel" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr><td align="right">联系地址：</td><td><input type="text" id="city" maxlength="18"><xsl:attribute name="value"><xsl:value-of select="/root/user/@city" /></xsl:attribute></input><span class="star"> </span></td></tr>
<tr style="display:none"><td align="right">SSOID：</td><td><input type="text" id="ssoid" readonly="readonly" value="{/root/user/@ssoid}" maxlength="50"/><span class="star"> </span></td></tr>
<tr><td align="right">备 注(限50字)：</td><td><textarea id="commentuser1"><xsl:value-of select="/root/user/@comment" /></textarea></td></tr>

<tr><td align="right" colspan="4" style="padding:10px;"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserModifyInfo();" value=" 确认提交 "/> <input type="button" onclick="javascript:UserShow(currentUserId);" value=" 返回浏览用户信息 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/user/@catalogid" />");GetUserList("<xsl:value-of select="/root/user/@catalogid" />");</xsl:attribute></input></td></tr>
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