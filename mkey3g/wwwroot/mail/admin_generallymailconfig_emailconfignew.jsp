<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>常用邮箱配置</title>
  	<!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

		<script src="../dwr/interface/MipEnterpriseMailConfigWeb.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
		
<script type="text/javascript">
  var mailconfigid = "<%=request.getParameter("mailconfigid")%>" ;
  window.onload = function() {
	  if(mailconfigid==""){
	  	ChangeMailStyle("POP3") ;
	  }else{
	  	MipEnterpriseMailConfigWeb.findMailconfigById(mailconfigid,
		{
			callback:function(oMap) {
				dwr.util.setValues(oMap);
				ChangeMailStyle($('emailstyle').value) ;
			},
			errorHandler:function(errorString, exception) {
				DHalert(errorString) ;
			}
		}) ;
	  }
  }
  function ChangeMailStyle(value)
    {
    	if(value=="POP3"){
    		document.getElementById('emailstylenew').options[0].selected = "selected" ;
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="DOMINO"){
    		document.getElementById('emailstylenew').options[1].selected = "selected" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="Exchange"){
    		document.getElementById('emailstylenew').options[2].selected = "selected" ;
	    	document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="IMAP") {
    		document.getElementById('emailstylenew').options[4].selected = "selected" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="";
    	}else{
    		document.getElementById('emailstylenew').options[3].selected = "selected" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
    	}
    }
	
	/*-------------------------------------------------------------
		功能：添加常用邮箱配置
	--------------------------------------------------------------*/
	function checkSpecialChar(testchar){
		if(testchar.indexOf('~')>=0||testchar.indexOf('@')>=0||testchar.indexOf('#')>=0||testchar.indexOf('$')>=0||testchar.indexOf('%')>=0||testchar.indexOf('^')>=0||testchar.indexOf('&')>=0||testchar.indexOf('*')>=0||testchar.indexOf('(')>=0||testchar.indexOf(')')>=0){
			return true;
		}else{
			return false;
		}
		
	}
	
	function checkAddress(address) {
		var addr1 = /^[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?$/
		var addr2 = /^(((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d)(\.((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d)){3})$/
		if(!addr1.test(address) && !addr2.test(address)){
			return true;
		} else {
			return false;
		}
	}
	
	function GenerallyMailconfig(){
		var pop3server = '' ;
		var pop3port = '' ;
		var smtpserver = '' ;
		var smtpport = '' ;
		var maildomain = '' ;
		var mailserver = '' ;
		var reg = /^\d+$/ ;
		Progress('正在保存邮箱数据....','保存中');
		//验证页面控件
		if($('mailconfigname').value == "" ||$('mailconfigname').value.replace(/\s/g,"")==""){
			DHalert("没有输入常用邮箱名！");
			return false;
		}
		if($('mailserver').value == "" ||$('mailserver').value.replace(/\s/g,"")==""){
			DHalert("没有输入邮件服务器地址！");
			return false;
		}
		if (checkAddress($('mailserver').value)) {
			DHalert("邮件服务器地址不正确！");					
			return;
		}
		mailserver=$('mailserver').value;
		
		if($('emailstylenew').value=="POP3"){
			if($('pop3server').value == "" ||$('pop3server').value.replace(/\s/g,"")==""){
				DHalert("没有输入pop3服务器地址！");
				return false;
			}
			if(checkSpecialChar($('pop3server').value)){
				DHalert("pop3服务器不能含有特殊字符！");					
				return;
			}
			if (checkAddress($('pop3server').value)) {
				DHalert("pop3服务器地址不正确！");					
				return;
			}
			pop3server = $('pop3server').value ;
			
			if($('pop3port').value == "" ||$('pop3port').value.replace(/\s/g,"")==""){
				DHalert("没有输入pop3服务器端口！");
				return false;
			}
			if(!reg.test($('pop3port').value)){
			 	DHalert("pop3端口必须为有效数字！");
			 	return false;
			}
			pop3port = $('pop3port').value ;
			
			if($('smtpserver').value == "" ||$('smtpserver').value.replace(/\s/g,"")==""){
				DHalert("没有输入smtp服务器地址！");
				return false;
			}
			if(checkSpecialChar($('smtpserver').value)){
				DHalert("smtp服务器不能含有特殊字符！");					
				return;
			}
			if (checkAddress($('smtpserver').value)) {
				DHalert("smtp服务器地址不正确！");					
				return;
			}
			smtpserver = $('smtpserver').value ;
			
			if($('smtpport').value == "" ||$('smtpport').value.replace(/\s/g,"")==""){
				 DHalert("没有输入smtp服务器端口！");
				 return false;
			}
			if(!reg.test($('smtpport').value)){
			 	DHalert("SMTP端口必须为有效数字！");
			 	return false;
			}
			smtpport = $('smtpport').value ;
		}
		
		if($('emailstylenew').value=="IMAP"){
			if($('imapserver').value == "" ||$('imapserver').value.replace(/\s/g,"")==""){
				DHalert("没有输入imap服务器地址！");
				return false;
			}
			if(checkSpecialChar($('imapserver').value)){
				DHalert("imap服务器不能含有特殊字符！");					
				return;
			}
			if (checkAddress($('imapserver').value)) {
				DHalert("imap服务器地址不正确！");					
				return;
			}
			pop3server = $('imapserver').value ;

			if($('imapport').value == "" ||$('imapport').value.replace(/\s/g,"")==""){
				DHalert("没有输入imap服务器端口！");
				return false;
			}
			if(!reg.test($('imapport').value)){
			 	DHalert("imap端口必须为有效数字！");
			 	return false;
			}
			pop3port=$('imapport').value;

			if($('smtpserverforimap').value == "" ||$('smtpserverforimap').value.replace(/\s/g,"")==""){
				DHalert("没有输入smtp服务器地址！");
				return false;
			}
			if(checkSpecialChar($('smtpserverforimap').value)){
				DHalert("SMTP服务器不能含有特殊字符！");					
				return;
			}
			if (checkAddress($('smtpserverforimap').value)) {
				DHalert("SMTP服务器地址不正确！");					
				return;
			}
			smtpserver=$('smtpserverforimap').value;
			
			if($('smtpportforimap').value == "" ||$('smtpportforimap').value.replace(/\s/g,"")==""){
				 DHalert("没有输入smtp服务器端口！");
				 return false;
			}
			if(!reg.test($('smtpportforimap').value)){
				DHalert("SMTP端口必须为有效数字！");
			 	return false;
			}
			smtpport=$('smtpportforimap').value;
		}
		
		if($('emailstylenew').value=="DOMINO"){
			if($('pushmailip3').value == "" ||$('pushmailip3').value.replace(/\s/g,"")==""){
				DHalert("没有输入服务器地址！");
				return false;
			}
			if (checkAddress($('pushmailip3').value)) {
				DHalert("服务器地址不正确！");					
				return;
			}
			pop3server=$('pushmailip3').value;
		}
		
		if($('emailstylenew').value=="Exchange"){
			if($('owa').value == "" ||$('owa').value.replace(/\s/g,"")==""){
				DHalert("没有输入owa地址！");
				return false;
			}
			if(checkSpecialChar($('owa').value)){
				DHalert("owa地址不能含有特殊字符！");					
				return;
			}
			pop3server=$('owa').value;
			
			if($('maildomain2003').value == "" ||$('maildomain2003').value.replace(/\s/g,"")==""){
				DHalert("没有输入邮件域！");
				return false;
			}
			if (checkAddress($('maildomain2003').value)) {
				DHalert("邮件域不正确！");					
				return;
			}
			maildomain=$('maildomain2003').value;
		}
		
		if($('emailstylenew').value=="Exchange2007"){
			if($('exchangeServer').value == "" ||$('exchangeServer').value.replace(/\s/g,"")==""){
				DHalert("没有输入webservice服务器地址！");
				return false;
			}
			if(checkSpecialChar($('exchangeServer').value)){
				DHalert("webservice地址不能含有特殊字符！");					
				return;
			}
			pop3server = $('exchangeServer').value ;
			
			if($('maildomain2007').value == "" ||$('maildomain2007').value.replace(/\s/g,"")==""){
				DHalert("没有输入邮件域！");
				return false;
			}
			if (checkAddress($('maildomain2007').value)) {
				DHalert("邮件域不正确！");					
				return;
			}
			maildomain=$('maildomain2007').value;
		}
		if(mailconfigid==''){
			mailconfigid='11111111111111111111111111111111' ;
		}
		MipEnterpriseMailConfigWeb.updateMailConfig(
		$('mailconfigname').value,
		$('emailstylenew').value,
		mailserver,
		maildomain,
		pop3server,
		pop3port,
		smtpserver,
		smtpport,
		mailconfigid,
		0,
		6,
		"",
		{
			callback:function() {
				CloseProgress();
				parent.parent.DHalert("常用邮箱配置成功！");
				parent.parent.GB_CURRENT.hide();
				parent.parent.generallyPushmailConfig();
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
				DHalert("操作失败，请重试！\n失败原因："+exception.message);	
			}
		}
		);
	}

</script>
</head>
  
<body style="width:800px;">
<div>
  <div id="divUserMailconfig" style="margin-left:10px" >
  <input type="hidden" id="emailstyle" />
	<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">常用邮箱名：</td>
			<td>
				<input type="text" id="mailconfigname"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" />
				<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">邮箱类型：</td>
			<td>
				<select id="emailstylenew" class="input_180px"
					onclick="javascript:ChangeMailStyle(this.value);"
					onchange="javascript:ChangeMailStyle(this.value);"
					style="height:20px">
					<option value="POP3">POP3</option>
					<option value="DOMINO">DOMINO</option>
					<option value="Exchange">Exchange 2003</option>
					<option value="Exchange2007">Exchange 2007</option>
					<option value="IMAP">IMAP4</option>
				</select>

			</td>
		</tr>
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">邮箱地址后缀：</td>
			<td>
				<input type="text" id="mailserver"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" />
				<span class="star">*</span>
			</td>
		</tr>
	</table>

	<table width="100%" bgcolor="" border="0" cellpadding="0"
		cellspacing="1">
		<tr>
			<td>
				<!--checkbox_div5-->
				<div id="checkbox_div5" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">IMAP服务器地址：</td>
							<td>
								<input type="text" id="imapserver"
									class="input_text input_180px" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">IMAP端口：</td>
							<td>
								<input type="text" id="imapport"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="993"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td>
								<input type="text" id="smtpserverforimap"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td>
								<input type="text" id="smtpportforimap"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="25"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div1-->
				<div id="checkbox_div1" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">POP3服务器地址：</td>
							<td>
								<input type="text" id="pop3server"
									class="input_text input_180px" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">POP3端口：</td>
							<td>
								<input type="text" id="pop3port"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="110"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td>
								<input type="text" id="smtpserver"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td>
								<input type="text" id="smtpport"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="25"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div2-->
				<div id="checkbox_div2" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">OWA地址：</td>
								<td>
									<input type="text" id="owa"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)"/>
									<span class="star">*</span>
								</td>
							</tr>
							<tr>
								<td width="16">
									<img src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%" height="24">邮件域：</td>
								<td>
									<input type="text" id="maildomain2003"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" />
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
				<!--checkbox_div3-->
				<div id="checkbox_div3" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">服务器地址：</td>
							<td>
								<input type="text" id="pushmailip3"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div3-->
				
				<!--checkbox_div4-->
				<div id="checkbox_div4" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">webservice地址：</td>
							<td>
								<input type="text" id="exchangeServer"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%" height="24">邮件域：</td>
							<td>
								<input type="text" id="maildomain2007"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" />
								<span class="star">*</span>
							</td>
						</tr>
						<!-- <tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">服务器主机地址：</td>
							<td>
								<input type="text"
									id="exchangeHost" class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">Exchange端口：</td>
							<td>
								<input type="text"
									id="exchangePort" class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr> -->
					</table>
				</div>
				<!--checkbox_div4-->
			</td>
		</tr>
	</table>

	<table width="100%" bgcolor="" border="0" cellpadding="0"
		cellspacing="1">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td colspan='2' >
				<font color='red'>
					注意：邮箱地址后缀即为邮箱地址中'@'后面的部分。例如:abc@163.com,邮箱地址后缀为163.com
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:150px;">
				<input type="button" class="button_4"
					style="cursor:pointer;" id="btnOK" name="btnOK"
					onclick="javascript:GenerallyMailconfig();" value=" 确认提交 " />
			</td>
		</tr>
	</table>
  </div>
</div>

  </body>
</html>
