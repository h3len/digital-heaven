<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg"><br/>
<tr><td align="right"></td><td></td></tr>
<tr>
<td colspan="2">
<fieldset>
<legend>集团基本信息</legend>
<table width="100%">
<tr><td align="right" width="30%">名称：</td><td><input type="text" id="catalogname" maxlength="20"/><span class="star"> *</span></td></tr>
<tr style="display:none"><td align="right">简称：</td><td><input type="text" id="shortname" maxlength="10"/><span class="star"> *</span></td></tr>
<tr><td align="right">企业简称：</td><td><input type="text" id="enterprisecode" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">corpId：</td><td><input type="text" id="ssoid" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">ProductID：</td><td><input type="text" id="productid" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">license：</td><td><input type="text" id="license" maxlength="20"/><span class="star"> </span></td></tr>
<tr><td align="right">企业密码：</td><td><input type="password" id="password" maxlength="20"/><span class="star"> *</span></td></tr>
<tr><td align="right">联系方式：</td><td><input type="text" id="mobile" maxlength="20"/><span class="star"> </span></td></tr>
<tr><td align="right">企业地址：</td><td><input type="text" id="address" maxlength="20"/><span class="star"> </span></td></tr>
<tr><td align="right">备 注(40字内)：</td><td><textarea id="commententerprise" maxlength="1000"></textarea><span class="star"> </span></td></tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td colspan="2">


</td>

</tr>

<tr>
<td colspan="2">


</td>
</tr>
<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:EnterpriseCreate();" value=" 确认提交 "/> <input type="button" id="btnOK" name="btnOK" value=" 返回部门列表 "><xsl:attribute name="onclick">javascript:GetCatalogList("<xsl:value-of select="/root/cat/@parentid" />");GetUserList("<xsl:value-of select="/root/cat/@parentid" />");</xsl:attribute></input> </td></tr>
<tr><td align="right"></td><td></td></tr>
</table>
  </xsl:template>
</xsl:stylesheet>
