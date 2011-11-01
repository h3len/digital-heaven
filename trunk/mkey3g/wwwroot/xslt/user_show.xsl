<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="root">
<div id="panelUserShow">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" style='TABLE-LAYOUT: fixed'><br/>
<tr><td align="right"></td><td></td></tr>
<tr><td align="right" width="30%">用户名称：</td><td><xsl:value-of select="/root/user/@username" /></td></tr>
<tr><td align="right">用户状态：</td><td>
<xsl:choose>
<xsl:when test="/root/user/@enable = 'true'">
        <img src="../images/true.gif" height="14" width="14" align="absmiddle"/>已启用</xsl:when>
<xsl:when test="/root/user/@enable = 'false'">
        <img src="../images/false.gif" height="14" width="14" align="absmiddle"/>已冻结</xsl:when>
</xsl:choose>

<input type="button">
<xsl:attribute name="value">
<xsl:choose>
<xsl:when test="/root/user/@enable = 'true'">点击冻结</xsl:when>
<xsl:when test="/root/user/@enable = 'false'">点击启用</xsl:when>
</xsl:choose>
</xsl:attribute>
<xsl:attribute name="onclick">JavaScript:UserEnable("<xsl:value-of select="@id"/>");</xsl:attribute>
</input>
</td></tr>
<xsl:if test="/root/user/@hasEnableBizPermission = 'true'">
<tr><td align="right">业务访问权限：</td><td>
<xsl:choose>
<xsl:when test="/root/user/@ismipuser = 'true'">
        <img src="../images/true.gif" height="14" width="14" align="absmiddle"/>已开通</xsl:when>
<xsl:when test="/root/user/@ismipuser = 'false'">
        <img src="../images/false.gif" height="14" width="14" align="absmiddle"/>未开通</xsl:when>
</xsl:choose>

<input type="button">
<xsl:attribute name="value">
<xsl:choose>
<xsl:when test="/root/user/@ismipuser = 'true'">点击关闭业务访问权限</xsl:when>
<xsl:when test="/root/user/@ismipuser = 'false'">点击开通业务访问权限</xsl:when>
</xsl:choose>
</xsl:attribute>
<xsl:attribute name="onclick">JavaScript:UserEnableMIP("<xsl:value-of select="@id"/>");</xsl:attribute>
</input>

</td></tr>

<tr>
<td align="right">PUSHMAIL业务状态：

</td><td id="pushmailconfig"></td>
</tr>


</xsl:if>

<tr><td align="right">真实姓名：</td><td><xsl:value-of select="/root/user/@truename" /></td></tr>
<tr><td align="right">所属部门：</td><td><xsl:value-of select="/root/user/@catalogname" /></td></tr>
<tr><td align="right">手机类型：</td><td><xsl:value-of select="/root/user/@mobiletype" /></td></tr>
<tr><td align="right">手机号码：</td><td><xsl:value-of select="/root/user/@mobile" /></td></tr>
<tr><td align="right">证件类型：</td><td><xsl:value-of select="/root/user/@idtype" /></td></tr>
<tr><td align="right">证件号码：</td><td><xsl:value-of select="/root/user/@idno" /></td></tr>
<tr><td align="right">电子邮件：</td><td><xsl:value-of select="/root/user/@email" /></td></tr>
<tr><td align="right">工作电话：</td><td><xsl:value-of select="/root/user/@companytel" /></td></tr>
<tr><td align="right">家庭电话：</td><td><xsl:value-of select="/root/user/@hometel" /></td></tr>
<tr><td align="right">联系地址：</td><td><xsl:value-of select="/root/user/@city" /></td></tr>
<tr style="display:none"><td align="right">SSOID：</td><td><xsl:value-of select="/root/user/@ssoid" /></td></tr>
<tr><td align="right">备 注：</td><td style="word-break: break-all"><xsl:value-of select="/root/user/@comment" /></td></tr>
<tr><td align="right">用户类型：</td><td><xsl:value-of select="/root/user/@usertype" /></td></tr>
<tr><td align="right">创建日期：</td><td><xsl:value-of select="/root/user/@createtime" /></td></tr>
<tr><td align="right">登录次数：</td><td><xsl:value-of select="/root/user/@logincount" /></td></tr>
<tr><td align="right">最后登录时间：</td><td><xsl:value-of select="/root/user/@lastactivitytime" /></td></tr>
<tr><td align="right" colspan="4" style="padding:10px;"> </td></tr>
<tr><td align="right"></td><td></td></tr>

	<input type="hidden" id="userid" >
		<xsl:attribute name="value">
			<xsl:value-of select="/root/user/@id" />
		</xsl:attribute>
	</input>

</table>
</div>
<div style="text-align:right;">
<xsl:if test="/root/user/@hasCreateBizPermission = 'true'">
<input type="button" value=" 修改用户密码 " onclick="javascript:LoadUserChangePassword();" />
</xsl:if>
<input type="button" id="btnOK" name="btnOK" value=" 修改用户信息 "><xsl:attribute name="onclick">javascript:LoadUserModifyInfo("<xsl:value-of select="/root/user/@id" />");</xsl:attribute></input> 
<input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/user/@catalogid" />");GetUserList("<xsl:value-of select="/root/user/@catalogid" />");</xsl:attribute></input></div>
  </xsl:template>
</xsl:stylesheet>
