<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root">
<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg">
	<tr height="6"><td align="right"></td><td></td></tr>
	<tr>
	<td colspan="2">
	<fieldset>
	<legend>基本信息</legend>
	<table width="100%">
			<tr><td align="right" width="30%">产品名称：</td><td>
			<input type="text" size="25" id="projectname"><xsl:attribute name="value"> <xsl:value-of select="/root/item/@projectname"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			
			<tr><td align="right">产品版本：</td><td>
			<input type="text" id="projectversion" size="25"><xsl:attribute name="value"> <xsl:value-of select="/root/item/@projectversion"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			
			<tr><td align="right">公司名称：</td><td>
			<input type="text" id="name" size="25"><xsl:attribute name="value"> <xsl:value-of select="/root/item/@name"/></xsl:attribute></input><span class="star"> * </span>
			</td></tr>
			
			<tr><td align="right">客户端版本号：</td><td><input type="text" id="clientversion" size="25">
			<xsl:attribute name="value"><xsl:value-of select="/root/item/@clientversion"/></xsl:attribute></input>
			<span class="star"> *</span></td></tr>
			
			<tr><td align="right">是否支持多集团：</td><td>
			<input type="radio" name='radio' style="	height:12px;" id='radio1' value ='true' >
			<xsl:if test="/root/item/@enablemultienterprise='true'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>是
			<input type="radio" name='radio' style="	height:12px;" id='radio2' value ='false'>
			<xsl:if test="/root/item/@enablemultienterprise='false'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>否
			<span class="star"> *修改此项必须重起服务器</span></td></tr>
			
			<tr><td align="right">是否支持创建用户：</td><td>
			<input type="radio" name='radioCreateUser' style="	height:12px;" id='radioCreateUser1' value ='true' >
			<xsl:if test="/root/item/@enablecreateuser='true'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>是
			<input type="radio" name='radioCreateUser' style="	height:12px;" id='radioCreateUser2' value ='false'>
			<xsl:if test="/root/item/@enablecreateuser='false'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>否
			<span class="star"> *修改此项必须重起服务器</span></td></tr>
			
			<tr><td align="right">是否使用真实姓名：</td><td>
			<input type="radio" name='radioUseTruename' style="	height:12px;" id='radioUseTruename1' value ='true' >
			<xsl:if test="/root/item/@usetruename='true'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>是
			<input type="radio" name='radioUseTruename' style="	height:12px;" id='radioUseTruename2' value ='false'>
			<xsl:if test="/root/item/@usetruename='false'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>否
			<span class="star"> *修改此项必须重起服务器</span></td></tr>
			
			<tr><td align="right">安装路径：</td><td><input type="text" id="installdir" size="25">
			<xsl:attribute name="value"><xsl:value-of select="/root/item/@installdir"/></xsl:attribute></input>
			<span class="star"> *</span></td></tr>
	</table>
	</fieldset>
	</td>
	</tr>
	
	<fieldset>
	<legend>管理员Email配置</legend>
		<table width="100%">			
		<tr><td align="right" width="30%">管理员名称：</td><td><input type="text" id="adminname" maxlength="50"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@adminname" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		<tr><td align="right" width="30%">邮箱地址：</td><td><input type="text" id="email" maxlength="50"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@email" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		<tr><td align="right">邮箱账号：</td><td><input type="text" id="username" maxlength="50"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@username" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		<tr><td align="right">邮箱密码：</td><td><input type="password" id="mailpassword" maxlength="50"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@mailpassword" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		<tr><td align="right">SMTP服务器：</td><td><input type="text" id="smtpserver"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@smtpserver" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		<tr><td align="right">SMTP端口：</td><td><input type="text" id="smtpport"><xsl:attribute name="value"><xsl:value-of select="/root/admin/@smtpport" /></xsl:attribute></input><span class="star"> *</span></td></tr>
		</table>
	</fieldset>

	<fieldset>
	<legend>SOCKET配置</legend>
		<table width="100%">
			<tr><td align="right" width="30%">cmpop端口：</td><td>
			<input type="text" size="25" id="cmpopport"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@cmpopport"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right" width="30%">cmpopssl端口：</td><td>
			<input type="text" size="25" id="cmpopportssl"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@cmpopportssl"/></xsl:attribute></input>
			</td></tr>
			<tr><td align="right" width="30%">cmsmtpport端口：</td><td>
			<input type="text" size="25" id="cmsmtpport"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@cmsmtpport"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right" width="30%">cmsmtpssl端口：</td><td>
			<input type="text" size="25" id="cmsmtpportssl"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@cmsmtpportssl"/></xsl:attribute></input>
			</td></tr>
			<tr><td align="right" width="30%">MIP服务器端口：</td><td>
			<input type="text" size="25" id="mipport"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@mipport"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right" width="30%">MIP服务器ssl端口：</td><td>
			<input type="text" size="25" id="mipportssl"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@mipportssl"/></xsl:attribute></input>
			</td></tr>
			<tr><td align="right" width="30%">SocketIp地址：</td><td>
			<input type="text" size="25" id="socketip"><xsl:attribute name="value"> <xsl:value-of select="/root/socket/@socketip"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right">是否支持SSL：</td><td>
			<input type="radio" name='radio_ssl' style="	height:12px;" id='radio_ssl1' value ='true' >
			<xsl:if test="/root/socket/@enablessl='true'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>是
			<input type="radio" name='radio_ssl' style="	height:12px;" id='radio_ssl2' value ='false'>
			<xsl:if test="/root/socket/@enablessl='false'">
				<xsl:attribute name="checked">true</xsl:attribute>
			</xsl:if>
			</input>否
			<span class="star"> *</span></td></tr>

		</table>
	</fieldset>

	<fieldset>
	<legend>文档解析配置</legend>
		<table width="100%">
			<tr><td align="right" width="30%">文档解析服务器Ip：</td><td>
			<input type="text" size="25" id="openofficeip"><xsl:attribute name="value"> <xsl:value-of select="/root/dp/@openofficeip"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right" width="30%">文档解析服务器端口：</td><td>
			<input type="text" size="25" id="openofficeport"><xsl:attribute name="value"> <xsl:value-of select="/root/dp/@openofficeport"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
			<tr><td align="right" width="30%">手机浏览每页字符数：</td><td>
			<input type="text" size="25" id="pagecharcount"><xsl:attribute name="value"> <xsl:value-of select="/root/dp/@pagecharcount"/></xsl:attribute></input><span class="star"> *</span>
			</td></tr>
		</table>
	</fieldset>

	<fieldset>
	<legend>SMS配置</legend>		
		<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr><td align="right" width="30%">更改SMS类型：</td><td>				
			<select id="selSmsType" onchange="javascript:ChangeSmsType();">		
			<option value="dhwg">数字天堂无线网关配置</option>	
			<option value="bmcc_qxt">北京企信通SMS配置</option>
			<option value="hwcmpp2">北京华为CMPP2配置</option>			
			<option value="hwcmpp3">北京华为CMPP3配置</option>			
			</select>
			</td></tr>
			<tr>
			<td colspan="2"><div id="divSMS"></div></td>
			</tr>
			</table>
			
	</fieldset>
	


<tr><td align="right" colspan="2">
	<input type="button" id="btnOK" name="btnOK" onclick="javascript:ConfigModify();" value=" 确认提交 "/>
</td></tr>

</table>
  </xsl:template>
</xsl:stylesheet>
