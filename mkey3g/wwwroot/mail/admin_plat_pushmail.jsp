<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="com.dheaven.mip.service.impl.PermissionServiceImpl,com.dheaven.mip.plugin.mail.core.MailConstants"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@ page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<html>
	<head>
		<title>邮件参数配置</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

		<script src="../dwr/interface/MipEnterpriseMailConfigWeb.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipAdminMailConfigAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script type="text/javascript">
		/*
			*****************     ******************
			by yesun 2007-08-16 
			xj 2007-08-27 
			xj 2009-01-07修改 
		*/
		 //公共变量
	 
	  var type;
	  var pop3server="";
	  var pop3port="";
	  var smtpserver="";
	  var smtpport="";
	  var pushmailip="";
	  var pushmaildomain="";
	  var owaip="";
	  var pmtype="";
	  var tabPane;
	  var pageid=1;
	  var isSearch = 0 ;
      var ab= '' ;
      <%
      	String loginport = session.getAttribute("loginport").toString() ;
      	if(ServerConfig.EnableMutiEnterprise==false||loginport=="1"){ %>
      	//	ab = [[getPushmailConfig,'企业邮箱设置'],[generallyPushmailConfig,'常用邮箱设置'],[managerPushmailConfig,'管理员邮箱设置'],[getMailParam,'邮件策略配置']];
      		ab = [[getPushmailConfig,'企业邮箱设置'],[generallyPushmailConfig,'常用邮箱设置'],[getMailParam,'邮件策略配置']];
      <% }else {%>
      		ab = [[generallyPushmailConfig,'常用邮箱设置'],[getMailParam,'邮件策略配置']];
      <%}%>
		   //初始化
	 window.onload=function(){
	  	DHTabPanel(ab,900,0,"tabs");
	 }
	 //获取企业邮箱设置
	 function getPushmailConfig(){
	 	isSearch = 0 ;
	 	document.getElementById("showmanagermailconfig").style.display='none';
	 	document.getElementById("generallymailConfig").style.display='none';
	 	document.getElementById("mailparam").style.display='none';
		document.getElementById("mailconfig").style.display='';
	    Progress("数据正在载入...","提示");
	    MipEnterpriseMailConfigWeb.getMailConfig(function(data){
      				dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);
					//alert(data.pushmailtype) ;
					pmtype=$('pushmailtype').value;
					if($('pushmailtype').value==pmtype)
					{
					    selected="true";
					}
					selectopt();
					if($('btn').value=="true"){
						$('btnDeleteMailconfig').style.display="";
					}else{
						$('btnDeleteMailconfig').style.display="none";
					}
					//alert(data.enablecheck);
					if($('enablecheck').value=='true'){
						$('enable').checked = true ;
					}
					CloseProgress();
				}
				);
		}
	//获取常用邮箱列表
	function generallyPushmailConfig(){
		document.getElementById("showmanagermailconfig").style.display='none';
	 	document.getElementById("generallymailConfig").style.display='';
	 	document.getElementById("mailparam").style.display='none';
		document.getElementById("mailconfig").style.display='none';
		Progress("数据正在载入...","提示");
		MipEnterpriseMailConfigWeb.getGenerallyMailConfig(pageid,"","",
		{
			callback:function(objXml) {
				DisplayTransformedXML(1, objXml, "xslt/admin_generallyMailConfig_list.xsl",document.getElementById("generallymailConfig"));
				CloseProgress();
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert(errorString);
			}
		});
	}
	//获取邮箱策略配置
	function getMailParam(){
	 	document.getElementById("showmanagermailconfig").style.display='none';
		document.getElementById("mailconfig").style.display='none';
		document.getElementById("generallymailConfig").style.display='none';
		document.getElementById("mailparam").style.display='';
	    Progress("数据正在载入...","提示");
	    MipEnterpriseMailConfigWeb.getMailParam(function(data){
      				dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);
					if($('mailtype').value=="1"){
					$('mailclear').checked=true;
					$('mailqueue').checked=false;
					}else if($('mailtype').value=="2"){
					 $('mailqueue').checked=true;
					 $('mailclear').checked=false;
					} else if($('mailtype').value=="3"){
						$('mailqueue').checked=true;
					 $('mailclear').checked=true;
					}
					if($('hasMailPlugin').value=='false'){
						var mailparamDiv = document.getElementById('mailparam'); 
						var inputElent = new Array(); 
						inputElent = mailparamDiv.getElementsByTagName("input"); 
						for(var i=0; i<inputElent.length; i++){ 
							//inputElent[i].style.backgroundColor = "#DBDBDB"; 
							inputElent[i].disabled = "disabled"; 
						} 
						if(${'isReceive'}.value == 'true') {
							document.getElementById('setReceiveFlag').disabled = "";
						}
						/*$("serverMailSize").disabled = "disabled";
						$("serverMailSaveTime").disabled = "disabled";
						$("userMailSize").disabled = "disabled";
						$("clientSize").disabled = "disabled";
						$("mailtype").disabled = "disabled";
						$("mailqueuesize").disabled = "disabled";
						$("mailrotationtime").disabled = "disabled";*/
						//disabled 
					}
					CloseProgress();
				}
				);
		}
	/*--------------------------------------------------------------
		功能：更新配置
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
	
	function setReceiveFlag() {
		Progress("正在发送数据到服务器....","提示");
		MipEnterpriseMailConfigWeb.SetEnterpriseReceiveFlag("",
				document.getElementById('setReceiveFlag').checked,
				{
					callback:function() {
						CloseProgress();
						DHalert("企业轮询设置配置成功！");	
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
						DHalert("操作失败，请重试！\n失败原因："+exception.message);	
					}
				});
	}

	function updatePushmailConfig(){
		var pushmaildomain = '' ;
		var pop3server = '' ;
		var pop3port = '' ;
		var smtpserver = '' ;
		var smtpport = '' ;
		var enable = 0;
		var reg = /^\d+$/
		
		if($('mailserver').value == "" || $('mailserver').value.replace(/\s/g,"")==""){
			DHalert("没有填写邮件服务器地址！");					
			return;
		}
		if (checkAddress($('mailserver').value)) {
			DHalert("邮件服务器地址不正确！");					
			return;
		}
		if(document.getElementById('pushmailtype').value=="POP3"){
			type=1;
			if($('pop3server').value == "" || $('pop3server').value.replace(/\s/g,"")==""){
				DHalert("没有填写pop3服务器！");					
				return;
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
			
			if($('pop3port').value == ""|| $('pop3port').value.replace(/\s/g,"")==""){
				DHalert("没有填写pop3端口！");		
				return;
			}	
			if(!reg.test($('pop3port').value)){
				DHalert("pop3端口不是有效数字！");		
				return;
			}
			if($('pop3port').value.length>5){
				DHalert("pop3端口最多为5位！");		
				return;
			}
			pop3port = $('pop3port').value ;
			
			if($('smtpserver').value == "" || $('smtpserver').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp服务器！");	
				return;
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
			
			if($('smtpport').value == ""  || $('smtpport').value.replace(/\s/g,"")=="")
			{
				DHalert("没有填写smtp端口！");	
				return;
			}	
			if(!reg.test($('smtpport').value)){
				DHalert("smtp端口不是有效数字！");		
				return;
			}
			
			smtpport = $('smtpport').value ;
		}
		if(document.getElementById('pushmailtype').value=="IMAP"){
			type=5;
			if($('imapserver').value == "" || $('imapserver').value.replace(/\s/g,"")==""){
				DHalert("没有填写imap服务器！");					
				return;
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
			
			if($('imapport').value == ""|| $('imapport').value.replace(/\s/g,"")==""){
				DHalert("没有填写imap端口！");		
				return;
			}	
			if(!reg.test($('imapport').value)){
				DHalert("imap端口不是有效数字！");		
				return;
			}
			pop3port = $('imapport').value ;
			
			if($('smtpserverforimap').value == "" || $('smtpserverforimap').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp服务器！");	
				return;
			}	
			if(checkSpecialChar($('smtpserverforimap').value)){
				DHalert("smtp服务器不能含有特殊字符！");					
				return;
			}
			if (checkAddress($('smtpserverforimap').value)) {
				DHalert("smtp服务器地址不正确！");					
				return;
			}
			smtpserver = $('smtpserverforimap').value ;
			
			if($('smtpportforimap').value == ""  || $('smtpportforimap').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp端口！");	
				return;
			}	
			if(!reg.test($('smtpportforimap').value)){
				DHalert("smtp端口不是有效数字！");		
				return;
			}
			smtpport = $('smtpportforimap').value ;
		}
		if(document.getElementById('pushmailtype').value=="Exchange"){
			type=2;
			if($('owaip').value == "" || $('owaip').value.replace(/\s/g,"")==""){
				DHalert("没有填写OWA地址！");	
				return;
			}	
			if(checkSpecialChar($('owaip').value)){
				DHalert("OWA地址不能含有特殊字符！");					
				return;
			}
			pop3server = $('owaip').value ;
			
			if($('pushmaildomain2').value == "" || $('pushmaildomain2').value.replace(/\s/g,"")==""){
				DHalert("没有填写邮件域！");
				return;
			}	
			if(checkSpecialChar($('pushmaildomain2').value)){
				DHalert("邮件域不能含有特殊字符！");					
				return;
			}else {
				var tmp_mail = $('systememail').value;
				var tmp_domain = tmp_mail.substr(tmp_mail.indexOf('@')+1);
				if($('systemdomain2007').value != tmp_domain) {
					DHalert("邮箱@后面的和邮件域不匹配！请检查输入..");
					return;
				}
			}
			pushmaildomain = $('pushmaildomain2').value ;
		}
		if(document.getElementById('pushmailtype').value=="DOMINO"){
			type=3;
			var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
			if($('pushmailip3').value == "" || $('pushmailip3').value.replace(/\s/g,"")==""){
				DHalert("没有填写服务器地址！");
				return;
			}
			if (checkAddress($('pushmailip3').value)) {
				DHalert("邮件服务器地址不正确！");					
				return;
			}
			pop3server = $('pushmailip3').value
		}
		
		if(document.getElementById('pushmailtype').value=="Exchange2007"){
			type=4;
			if($('exchangeService').value == "" || $('exchangeService').value.replace(/\s/g,"")==""){
				DHalert("没有填写webservice地址！");
				return;
			}
			if(checkSpecialChar($('exchangeService').value)){
				DHalert("webservice地址不能含有特殊字符！");					
				return;
			}
			pop3server = $('exchangeService').value ;
			
			if($('pushmaildomain4').value == "" || $('pushmaildomain4').value.replace(/\s/g,"")==""){
				DHalert("没有填写邮件域！");
				return;
			}
			if(checkSpecialChar($('pushmaildomain4').value)){
				DHalert("邮件域不能含有特殊字符！");					
				return;
			}
			pushmaildomain = $('pushmaildomain4').value ;
		}
		if($('enable').checked==true){
			enable = 1 ;
		}
		Progress("正在发送数据到服务器....","提示");
		MipEnterpriseMailConfigWeb.updateMailConfig(
		"2222222",
		$('pushmailtype').value,
		$('mailserver').value,
		pushmaildomain,
		pop3server,
		pop3port,
		smtpserver,
		smtpport,
		$('branchid').value,
		enable,
		type,
		null,
		{
			callback:function() {
				CloseProgress();
				DHalert("企业邮箱配置成功！");	
				$('btnDeleteMailconfig').style.display="";
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
				DHalert("操作失败，请重试！\n失败原因："+exception.message);	
			}
		});
	}
	
	//取消企业邮箱设置
	function DeleteMailconfig(){
			Ext.Msg.confirm(nowtitle, '确定要取消该邮箱绑定吗？', function(btn){
				if(btn=='yes'){
					Progress("正在发送数据到服务器....","提示");
					MipEnterpriseMailConfigWeb.DeleteMailconfig(null,
					{
						callback:function() {
							CloseProgress();
							SDHalert("取消配置成功！",140);	
							undisplayall() ;
							$('btnDeleteMailconfig').style.display="none";
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
							DHalert("操作失败，请重试！\n失败原因："+exception.message);	
						}
					});
	    		}
		    });
	}
	function undisplayall(){
		$('mailserver').value = "";
		$('pop3server').value = "";
		$('pop3port').value = "";
		$('smtpserver').value = "";
		$('smtpport').value = "";
		$('pushmailip3').value = "";
		$('owaip').value = "";
		$('pushmaildomain2').value = "" ;
		$('exchangeService').value = "";
		$('pushmaildomain4').value = "";
		$('imapserver').value = "";
		$('imapport').value = "";
		$('smtpserverforimap').value = "";
		$('smtpportforimap').value = "";
	}
		//动态显示输入框
	function selectopt(){
		if(document.getElementById('pushmailtype').value=="POP3"){
			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
		}
		if(document.getElementById('pushmailtype').value=="Exchange"){
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
		}
		if(document.getElementById('pushmailtype').value=="DOMINO"){
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
		}
		if(document.getElementById('pushmailtype').value=="Exchange2007"){
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
		}
		if(document.getElementById('pushmailtype').value=="IMAP"){
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="";
		}
	} 

	function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}else if(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
	}
	
	/*
	以下为管理员邮箱设置
	*/
	
	//得到管理员邮箱配置
	function managerPushmailConfig(){
		document.getElementById("showmanagermailconfig").style.display='';
		document.getElementById("mailconfig").style.display='none';
		document.getElementById("mailparam").style.display='none';
		document.getElementById("generallymailConfig").style.display='none';
	    //取出管理员邮箱设置信息
	    Progress("数据正在载入...","提示");
	    dwr.util.setEscapeHtml(false);
      	MipAdminMailConfigAction.getSystemEmailConfig(function(data){
					dwr.util.setValues(data);
					show(1);
					show(2);
					show(3);
					$('systememailstyle').value = $('systememailstyletemp').value ;
					if($('systememailstyle').value==''){
						$('systememailstyle').value = "POP3" ;
					}
					changeSystemMail() ;
					if($('hasMailPlugin').value=='false') {
						//$('mailPlugin').style.display='none' ;
						hide(1);
						hide(2);
						hide(3);
					}
					CloseProgress();
				}
		);
	}
	
	function changeSystemMail(){
		if($('systememailstyle').value=="POP3"){
			$('systememailstyle').options[0].selected = "selected" ;
			document.getElementById('adminmail_div1').style.display="";
			document.getElementById('adminmail_div2').style.display="none";
			document.getElementById('adminmail_div3').style.display="none";
			document.getElementById('adminmail_div4').style.display="none";
			document.getElementById('adminmail_div5').style.display="none";
		}
		if($('systememailstyle').value=="Exchange"){
			$('systememailstyle').options[2].selected = "selected" ;
			document.getElementById('adminmail_div1').style.display="none";
			document.getElementById('adminmail_div2').style.display="";
			document.getElementById('adminmail_div3').style.display="none";
			document.getElementById('adminmail_div4').style.display="none";
			document.getElementById('adminmail_div5').style.display="none";
		}
		if($('systememailstyle').value=="DOMINO"){
			$('systememailstyle').options[1].selected = "selected" ;
			document.getElementById('adminmail_div1').style.display="none";
			document.getElementById('adminmail_div2').style.display="none";
			document.getElementById('adminmail_div3').style.display="";
			document.getElementById('adminmail_div4').style.display="none";
			document.getElementById('adminmail_div5').style.display="none";
		}
		if($('systememailstyle').value=="Exchange2007"){
			$('systememailstyle').options[3].selected = "selected" ;
			document.getElementById('adminmail_div1').style.display="none";
			document.getElementById('adminmail_div2').style.display="none";
			document.getElementById('adminmail_div3').style.display="none";
			document.getElementById('adminmail_div4').style.display="";
			document.getElementById('adminmail_div5').style.display="none";
		}
		if($('systememailstyle').value=="IMAP"){
			if ($('hasMailPlugin').value=='false') {
				$('systememailstyle').options[1].selected = "selected" ;
			} else {
				$('systememailstyle').options[4].selected = "selected" ;
			}
			document.getElementById('adminmail_div1').style.display="none";
			document.getElementById('adminmail_div2').style.display="none";
			document.getElementById('adminmail_div3').style.display="none";
			document.getElementById('adminmail_div4').style.display="none";
			document.getElementById('adminmail_div5').style.display="";
		}
		$('systememailstyletemp').value = $('systememailstyle').value;
	}
	
	function checkmailstyle(){
		if($('systememail').value == "" ||$('systememail').value.replace(/\s/g,"")=="")
		{
			//DHalert("请输入邮箱地址！");
			return false;
		}
		if($('systememail').value.indexOf('@')<1||$('systememail').value.indexOf('@')==($('systememail').value.length)-1){
			//DHalert("邮箱地址格式不正确！");
			return false;
		}
		//if($('enable').value!="true"){
			MipAdminMailConfigAction.checkmailstyleNEW($('systememail').value,
				function(data){	
					dwr.util.setValues(data);	
					if($('hasMailPlugin').value=='false'){
						$('systememailstyle').value = "POP3" ;
					}else{
						if($('systememailstyletemp').value=='')
						{
							$('systememailstyle').value = "POP3" ;
						}else
						{
							$('systememailstyle').value = $('systememailstyletemp').value ;
						}
					}
					changeSystemMail() ;				
				}
				
			);
		//}
	}
	
	//保存管理员邮箱配置
	function savemanagerPushmailConfig(){
		 var reg = /^\d+$/
		 var systemsmtpserver = '' ;
		 var systemsmtpport = '' ;
		 var systemmaildomain = '' ;
		 var systememailstyle = '' ;
   		 if($('systemname').value=='' || $('systemname').value.replace(/\s/g,"")=="" ){
		 	DHalert("管理员名称不能为空！");
		 	return false;
		 }
		 if($('systememail').value=='' ||$('systememail').value.replace(/\s/g,"")=="" ){
		 	DHalert("邮箱地址不能为空！");
		 	return false;
		 }
		 var cf = new CheckForm();
		 if(!cf.IsEmail($('systememail').value)){
				DHalert("邮箱地址格式不正确！");
				return false;
		 }
		/* if($('systememail').value=='' ||$('systememail').value.replace(/\s/g,"")=="" ){
		 	DHalert("邮箱账号不能为空！");
		 	return false;
		 }*/
		 if($('systempassword').value=='' ||$('systempassword').value.replace(/\s/g,"")=="" ){
		 	DHalert("邮箱密码不能为空！");
		 	return false;
		 }
		if($('systememailstyle').value=="POP3"){
			systememailstyle="POP3";
			if($('systemsmtpserver').value == "" || $('systemsmtpserver').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp服务器！");	
				return;
			}	
			if(checkSpecialChar($('systemsmtpserver').value)){
				DHalert("smtp服务器不能含有特殊字符！");					
				return;
			}
			systemsmtpserver = $('systemsmtpserver').value ;
			
			if($('systemsmtpport').value == ""  || $('systemsmtpport').value.replace(/\s/g,"")=="")
			{
				DHalert("没有填写smtp端口！");	
				return;
			}	
			if(!reg.test($('systemsmtpport').value)){
				DHalert("smtp端口不是有效数字！");		
				return;
			}
			systemsmtpport = $('systemsmtpport').value ;
		}
		if(document.getElementById('systememailstyle').value=="IMAP"){
			systememailstyle="IMAP";
			if($('systemimapserver').value == "" || $('systemimapserver').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp服务器！");	
				return;
			}	
			if(checkSpecialChar($('systemimapserver').value)){
				DHalert("smtp服务器不能含有特殊字符！");					
				return;
			}
			systemsmtpserver = $('systemimapserver').value ;
			
			if($('systemimapport').value == ""  || $('systemimapport').value.replace(/\s/g,"")==""){
				DHalert("没有填写smtp端口！");	
				return;
			}	
			if(!reg.test($('systemimapport').value)){
				DHalert("smtp端口不是有效数字！");		
				return;
			}
			systemsmtpport = $('systemimapport').value ;
		}
		if(document.getElementById('systememailstyle').value=="Exchange"){
			systememailstyle="Exchange";
			if($('systempowaip').value == "" || $('systempowaip').value.replace(/\s/g,"")==""){
				DHalert("没有填写OWA地址！");	
				return;
			}	
			if(checkSpecialChar($('systempowaip').value)){
				DHalert("OWA地址不能含有特殊字符！");					
				return;
			}
			systemsmtpserver = $('systempowaip').value ;
			
			if($('systemdomain2003').value == "" || $('systemdomain2003').value.replace(/\s/g,"")==""){
				DHalert("没有填写邮件域！");
				return;
			}	
			if(checkSpecialChar($('systemdomain2003').value)){
				DHalert("邮件域不能含有特殊字符！");					
				return;
			}
			systemmaildomain = $('systemdomain2003').value ;
		}
		if(document.getElementById('systememailstyle').value=="DOMINO"){
			systememailstyle="DOMINO";
			var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
			if($('systemdomino').value == "" || $('systemdomino').value.replace(/\s/g,"")==""){
				DHalert("没有填写服务器地址！");
				return;
			}	
			systemsmtpserver = $('systemdomino').value
		}
		
		if(document.getElementById('systememailstyle').value=="Exchange2007"){
			systememailstyle="Exchange2007";
			if($('systemexchangeService').value == "" || $('systemexchangeService').value.replace(/\s/g,"")==""){
				DHalert("没有填写webservice地址！");
				return;
			}
			if(checkSpecialChar($('systemexchangeService').value)){
				DHalert("webservice地址不能含有特殊字符！");					
				return;
			}
			systemsmtpserver = $('systemexchangeService').value ;
			
			if($('systemdomain2007').value == "" || $('systemdomain2007').value.replace(/\s/g,"")==""){
				DHalert("没有填写邮件域！");
				return;
			}
			if(checkSpecialChar($('systemdomain2007').value)){
				DHalert("邮件域不能含有特殊字符！");					
				return;
			}
			systemmaildomain = $('systemdomain2007').value ;
		}
		 Progress('正在保存邮箱数据....','保存中');
      	MipAdminMailConfigAction.setSystemEmailConfig(
	      	$('systemname').value,
			$('systememail').value,
			$('systempassword').value,
			systememailstyle,
			systemsmtpserver,
			systemsmtpport,
			systemmaildomain,
    		function(data){
    			CloseProgress();
				if(data == "1"){
					DHalert("管理员邮箱配置成功！");	
				}else{
					DHalert("管理员邮箱配置失败！失败原因："+data);
				}
			}
		);
	}
	
	
	//保存邮件参数配置
	function saveMailParam(){
		var reg = /^\d+$/;	
		//邮件服务器收取时间限制、邮件每次推送数量
   		 if($('mailrotationtime').value==''){
		 	DHalert("服务器邮件轮询间隔时间不能为空！");
		 	return false;
		 }
		 if(!reg.test($('mailrotationtime').value)||$('mailrotationtime').value<=0){
		 	DHalert("服务器邮件轮询间隔时间必须为正整数！");
		 	return false;
		 }
		 if($('mailrotationtime').value<1){
		 	DHalert("服务器邮件轮询间隔时间不能小于1！");
		 	return false;
		 }
		 
   		 if($('serverMailSize').value==''){
		 	DHalert("服务器邮件收取时限不能为空！");
		 	return false;
		 }
		 if(!reg.test($('serverMailSize').value)||$('serverMailSize').value<=0){
		 	DHalert("服务器邮件收取时限必须为正整数！");
		 	return false;
		 }
		 
		 if($('clientSize').value==''){
		 	DHalert("服务器每次推送邮件数不能为空！");
		 	return false;
		 }
		  if(!reg.test($('clientSize').value)||$('clientSize').value<=0){
		 	DHalert("服务器每次推送邮件数必须为正整数！");
		 	return false;
		 }
		 var mailtype = 0;//邮件策略类型【1：清理 2：队列】
		 if($('mailclear').checked&&!$('mailqueue').checked){
		   	mailtype=1;
		 }else if($('mailqueue').checked&&!$('mailclear').checked){
		 	mailtype=2;
		 }else if($('mailqueue').checked&&$('mailclear').checked){
		 	mailtype=3;
		 }else{
			 DHalert("必须选择一种邮件策略，请确认！");
		 	return false;
		 }
		 //邮件清理策略
		 if(mailtype==1||mailtype==3){
			 if($('serverMailSaveTime').value==''){
			 	DHalert("服务器邮件缓存时间不能为空！");
			 	return false;
			 }
			 if(!reg.test($('serverMailSaveTime').value)||$('serverMailSaveTime').value<=0){
			 	DHalert("服务器邮件缓存时间必须为整数！");
			 	return false;
			 }
			 if($('userMailSize').value==''){
			 	DHalert("服务器保存每个用户邮件数不能为空！");
			 	return false;
			 }
			  if(!reg.test($('userMailSize').value)||$('userMailSize').value<=0){
			 	DHalert("服务器保存每个用户邮件数必须为正整数！");
			 	return false;
			 }
		 }
		 //邮件队列长度
		 if(mailtype==2||mailtype==3){
			 if($('mailqueuesize').value==''){
			 	DHalert("邮件队列长度不允许为空！");
			 	return false;
			 }
			 if(!reg.test($('mailqueuesize').value)||$('mailqueuesize').value<=0){
			 	DHalert("邮件队列长度必须为正整数！");
			 	return false;
			 }
		 }
		 if(mailtype==3){
		  	if(parseInt($('mailqueuesize').value)>parseInt($('userMailSize').value)) {
		  		DHalert("邮件队列长度不能大于服务器保存每个用户邮件数！");
				return false;
			}
		 }
		var serverMailSize = 0;
		var serverMailSaveTime = 0;
		var userMailSize = 0;
		var clientSize = 0;
		var mailqueuesize = 0;
		var mailrotationtime = 6 ;
		//邮件轮训间隔时间
		if($('mailrotationtime').value!=""){
			mailrotationtime=$('mailrotationtime').value;
		} 
		if($('serverMailSize').value!=""){
			serverMailSize=$('serverMailSize').value;
		} 
		//邮件缓存时间
		if($('serverMailSaveTime').value!=""){
			serverMailSaveTime=$('serverMailSaveTime').value;
		}
		//服务器保存用户邮件数
		if($('userMailSize').value!=""){
			userMailSize=$('userMailSize').value;
		}
		//每次推送邮件数目
		if($('clientSize').value!=""){
			clientSize=$('clientSize').value;
		}
		//邮件队列长度
		if($('mailqueuesize').value!=""){
			mailqueuesize=$('mailqueuesize').value;
		}
		if(mailtype==1) {
			mailqueuesize = 0
		} else if(mailtype==2) {
			serverMailSaveTime = 0;
		 	userMailSize = 0;
		}
		//serverMailSize服务器邮件收取时限
		//serverMailSaveTime服务器邮件缓存时间
		//userMailSize,服务器保存每个用户邮件数
		//clientSize服务器每次推送邮件数
		//mailqueuesize邮件队列长度
		//mailtype
      	MipEnterpriseMailConfigWeb.saveMailParam(
      		mailrotationtime,
	      	serverMailSize,
			serverMailSaveTime,
			userMailSize,
			clientSize,
			mailqueuesize,
			mailtype,
	    	function(data){
				if(data == "1"){
					DHalert("管理员邮件策略配置成功！");	
				}else{
					DHalert("管理员邮件策略配置失败！");
				}
			}
		);
	}
	
	/*--------------------------------------------------------------
			功能：常用邮箱配置
	--------------------------------------------------------------*/
	//分页
	function ChangePage(pid){
		pageid = pid;
		if(isSearch == 0){
			generallyPushmailConfig();
		}else{
			searchmailconfig(pageid) ;
		}
	}
	//全选
	function checkAll(){
		var boxs = document.getElementsByName('mark');
		for(i = 0;i < boxs.length;i++){
			boxs[i].checked = true;
		}
	}
	//反选
	function inverse(){
		var boxs  = document.getElementsByName('mark');
		for(i = 0;i < boxs.length;i++){
			boxs[i].checked?boxs[i].checked = false:boxs[i].checked = true;
		}
	}
	//批量删除邮箱
	function delAllSelect(){
		var boxs = document.getElementsByName('mark');
		var values = new Array();
		for(i = 0;i < boxs.length;i++){
			boxs[i].checked?values.push(boxs[i].value): i;
		}
		if(values.length == 0){
			DHalert('请勾选要删除的邮箱!');
			return;
		}
		Ext.Msg.confirm(nowtitle, '您确认要删除选择的邮箱?', function(btn){
			if(btn == 'yes'){
				Progress("正在删除...","提示");
				MipEnterpriseMailConfigWeb.deleteMailconfigs(values,{
					callback:function(msg){
						if(msg == "1"){
							CloseProgress();
							SDHalert("删除成功!",140);
						}else if(msg == "0"){
							CloseProgress();
							DHalert("");
						}
						
						if(isSearch==0){
							generallyPushmailConfig() ;
						}else{
							searchmailconfig(pageid) ;
						}
					}
				});
			}
		});
	}
	//查看常用邮箱配置页面
	function showmailConfig(mailconfigid){
		GB_showCenter("常用邮箱配置详情", "../mail/admin_generallymailconfig_showemailconfig.jsp?mailconfigid="+mailconfigid,450,678);
	}
	//查看
	function showgenerallymailConfig(mailconfigid){	
		GB_showCenter("常用邮箱配置", "../mail/admin_generallymailconfig_emailconfignew.jsp?mailconfigid="+mailconfigid,450,678);
	}
	//搜索
	function searchmailconfig(pid){
		isSearch = 1 ;
		var cf = new CheckForm();
		var keyword = $('check_keyword').value ;
		var search_type = $('check_search_type').value ;
		pageid = pid ;
		Progress("数据正在载入...","提示");
		if(pid=='serch'){
	 		if(cf.Trim($('keyword').value)==""){
		 		SDHalert("请输入查询内容!",140);
				return;
	 		}else{
	 			pageid = 1;
	 		}
	 	}
	 	if($('keyword').value==''&&keyword!=''){
	 		$('keyword').value = keyword ;
		}
	 	MipEnterpriseMailConfigWeb.getGenerallyMailConfig(pageid,$('keyword').value,$('search_type').value,
		{
			callback:function(objXml) {
				DisplayTransformedXML(1, objXml, "xslt/admin_generallyMailConfig_list.xsl",document.getElementById("generallymailConfig"));
				CloseProgress();
				if($('check_search_type').value=="emailstyle"){
					$('search_type').options[1].selected = "selected" ;
				}else if($('check_search_type').value=="maildomain"){
					$('search_type').options[2].selected = "selected" ;
				}else {
					$('search_type').options[0].selected = "selected" ;
				}
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert(errorString);
			}
		});
	}
	//设置邮件队列策略是否可用
	function fun()
	{
		if($('mailqueue').checked == true)
		{
			$('mailqueuesize').disabled = false;
		}else
		{
			$('mailqueuesize').disabled = true;
		}
	}
	
	function hide(index)
	{
	   //得到要隐藏的那个option对象
	   var oldOption =document.getElementById("systememailstyle").children(index);
	   //把option中的文本内容放到old|Str中
	   var oldStr   = oldOption.innerText;
	//创建一个新的div元素其属性与原来的option一样
	   var newOption = document.createElement('<div' + oldOption.outerHTML.match(/(<\w*)([^>]*)(>)/)[2] +'>');
	//option中的文本内容赋给新的div
	   newOption.innerText   = oldStr;
	//交换div与option的位置
	   newOption.swapNode(oldOption);
	   //alert(xxx.innerHTML);
	}
	function show(index)
	{
	   var oldOption =document.getElementById("systememailstyle").children(index);
	   if(oldOption.tagName=='DIV')
	   {
	    var oldStr   = oldOption.innerText;
	    var newOption = document.createElement('<option' + oldOption.outerHTML.match(/(<\w*)([^>]*)(>)/)[2] +'>');
	    newOption.innerText   = oldStr;
	    newOption.swapNode(oldOption);
	   }
	   //alert(xxx.innerHTML);
	}
		
	</script>
	</head>
	<body class="body_center">
		<!--Bottom Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!--Bottom Include-->
		<!-- Main 页面中部 -->
		<div id="center">
			<!-- Left 页面左侧菜单 -->
			<div id="center_left" class="center_left"></div>
			<!-- 右侧例表内容 -->
			<div id="center_right">
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">

					<!-- center_nav 路径导航 -->
					<div id="center_nav_box">
						<div id="center_nav">
							您现在所在位置 &gt;&gt; 移动邮件设置 &gt;&gt;邮件参数配置
						</div>
					</div>
					<div id="tabs" style="height: 30px"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<div id="mailconfig">
									<table width="100%" border="0" align="center" cellpadding="0"
										cellspacing="5">
										<tr height="25"></tr>
										<tr class="height25">
											<input type="hidden" id="mailtype" /> 
											<td width="31%" class="text_icon2">
												<span>服务器类型：</span>
											</td>
											<td width="69%">
												<select
														id="pushmailtype" onchange="javascript:selectopt();"
														id="registerCronCount" class="input_250px input_text"
														onmouseover="fEvent('mouseover',this)"
														onfocus="fEvent('focus',this)"
														onblur="fEvent('blur',this)"
														onmouseout="fEvent('mouseout',this)"/>
														<option value="POP3" selected="selected">
															POP3
														</option>
														<option value="DOMINO" selected="selected">
															LOTUS DOMINO
														</option>
														<option value="Exchange" selected="selected">
															Exchange 2003
														</option>
														<option value="Exchange2007" selected="selected">
															Exchange 2007
														</option>
														<option value="IMAP" selected="selected">
															IMAP4
														</option>
													</select>
											</td>
										</tr>
										<tr >
											<td width="31%" class="text_icon2">
												<span>企业邮箱后缀：</span>
											</td>
											<td width="69%">
													@<input type="text" id="mailserver"
													class="input_120px input_text" maxlength="30"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)"
													onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" />
											</td>
										</tr>
									</table>
									<table width="100%">
										<tr>
											<td>
												<!--checkbox_div1-->
												<div id="checkbox_div1" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width:31%">
																<span>POP3服务器地址：</span>
															</td>
															<td style="width:69%">
																<input type="text" id="pop3server"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>POP3端口：</span>
															</td>
															<td>
																<input type="text" id="pop3port"
																	class="input_120px input_text" maxlength="5"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP服务器地址：</span>
															</td>
															<td>
																<input type="text" id="smtpserver"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP端口：</span>
															</td>
															<td>
																<input type="text" id="smtpport"
																	class="input_120px input_text"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)" maxlength="5"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--checkbox_div1-->

												<!--checkbox_div5-->
												<div id="checkbox_div5" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width: 31%" valign="top">
																<span>IMAP服务器地址：</span>
															</td>
															<td>
																<input type="text" id="imapserver"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>IMAP端口：</span>
															</td>
															<td>
																<input type="text" id="imapport"
																	class="input_120px input_text" maxlength="5"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP服务器地址：</span>
															</td>
															<td>
																<input type="text" id="smtpserverforimap"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP端口：</span>
															</td>
															<td>
																<input type="text" id="smtpportforimap"
																	class="input_120px input_text"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)" maxlength="5"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--checkbox_div5-->

												<!--checkbox_div2-->
												<div id="checkbox_div2">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width: 31%" valign="top">
																<span>OWA地址：</span>
															</td>
															<td>
																<input type="text"
																	id="owaip" class="input_120px input_text"
																	maxlength="30" onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>邮件域:</span>
															</td>
															<td>
																<span>
																	<input type="text" id="pushmaildomain2"
																		class="input_120px input_text" maxlength="30"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" /> </span>
															</td>
														</tr>
													</table>
												</div>
												<!--checkbox_div2-->

												<!--checkbox_div3-->
												<div id="checkbox_div3" style="display: none;">
													<table width="100%" border="0" align="left" cellpadding="0"
														cellspacing="5">

														<tr>
															<td class="text_icon2" style="width: 31%" valign="top">
																<span>服务器地址：</span>
															</td>
															<td>
																<input type="text"
																	id="pushmailip3" class="input_120px input_text"
																	maxlength="30" onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<input type="hidden" id="pushmailtype">
													</table>
												</div>
												<!--checkbox_div3-->
												<!--checkbox_div4-->
												<div id="checkbox_div4" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width: 31%" valign="top">
																<span>邮件域 ：</span>
															</td>
															<td>
																<input type="text" id="pushmaildomain4"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>webservice地址：</span>
															</td>
															<td>
																<input type="text" id="exchangeService"
																	class="input_120px input_text" maxlength="50"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--checkbox_div4-->
											</td>
										</tr>
										<tr>
											<td><input type="checkbox" id="enable" />强制启用企业邮箱</td>
										</tr>
										<tr>
											<td colspan="5">
												<div class="center_nav_line"></div>
											</td>
										</tr>

										<tr>
											<td colspan="5">
												<table width="100%"><tr>
												<td align="center" width="60%">
												<input type="hidden" id="btn" />
												<input type="hidden" id="enablecheck" />
												<input type="button" class="button_6"
													style="cursor:pointer;" id="btnDeleteMailconfig"
													onclick="javascript:DeleteMailconfig();" value="取消邮箱设置" />
												<input type="button"
													onclick="javascript:updatePushmailConfig();" value="确定"
													class="button_2" />
												</td>
												<td width="40%">
												</td>
												</tr>
												</table>
											</td>
										</tr>
									</table>
								</div>
								<!-- 常见邮箱设置 -->
								<div id="generallymailConfig">
								
								</div>
								
								
								<!-- 管理员邮箱设置 -->
								<div id="showmanagermailconfig">

									<table width="100%" border="0" align="center" cellpadding="0"
										cellspacing="5">
										<tr>
											<td class="text_icon2" style="width: 31%" valign="top">
												<span>管理员名称：</span>
											</td>
											<td style="width: 69%">
												<input type="text" id="systemname"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" />
												*
											</td>
										</tr>
										<tr>
											<td class="text_icon2">
												<span>邮箱地址：</span>
											</td>
											<td>
												<input type="text" id="systememail"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="checkmailstyle()"
													onmouseout="fEvent('mouseout',this)" maxlength="100" />
												*
											</td>
										</tr>
										<tr>
											<td class="text_icon2">
												<span>邮箱密码：</span>
											</td>
											<td>
												<input type="password" id="systempassword"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" />
												*
											</td>
										</tr>
										<tr id="mailPlugin" class="height25">
											<td class="text_icon2" style="width:31%">
												<span>服务器类型：</span>
											</td>
											<td style="width:69%">
												<input type="hidden" id="systememailstyletemp" />
												<input type="hidden" id="hasMailPlugin" />
												<!-- 设置企业用户是否轮询收取邮件 -->
												<input type="hidden" id="isReceive" />
												<select id="systememailstyle" onchange="javascript:changeSystemMail();"
													class="input_250px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)"
													onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)"/>
													<option value="POP3" selected="selected">
														POP3
													</option>
													<option value="DOMINO" selected="selected">
														DOMINO
													</option>
													<option value="Exchange" selected="selected">
														Exchange 2003
													</option>
													<option value="Exchange2007" selected="selected">
														Exchange 2007
													</option>
													<option value="IMAP" selected="selected">
														IMAP4
													</option>
												</select>
											</td>
											</tr>
									</table>
									<table width="100%">
										<tr>
											<td>
												<!--adminmail_div1-->
												<div id="adminmail_div1" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width:31%">
																<span>SMTP服务器地址：</span>
															</td>
															<td style="width:69%">
																<input type="text" id="systemsmtpserver"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP端口：</span>
															</td>
															<td>
																<input type="text" id="systemsmtpport"
																	class="input_120px input_text"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)" maxlength="5"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--adminmail_div1-->

												<!--adminmail_div5-->
												<div id="adminmail_div5" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" style="width:31%">
																<span>SMTP服务器地址：</span>
															</td>
															<td style="width:69%">
																<input type="text" id="systemimapserver"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>SMTP端口：</span>
															</td>
															<td>
																<input type="text" id="systemimapport"
																	class="input_120px input_text"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)" maxlength="5"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--adminmail_div5-->

												<!--adminmail_div2-->
												<div id="adminmail_div2" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" valign="top" style="width:31%">
																<span>OWA地址：</span>
															</td>
															<td style="width:69%">
																<span>
																	<input type="text"
																		id="systempowaip" class="input_120px input_text"
																		maxlength="30" onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" /> </span>
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>邮件域:</span>
															</td>
															<td>
																<span><input type="text" id="systemdomain2003"
																		class="input_120px input_text" maxlength="30"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" /> </span>
															</td>
														</tr>
													</table>
												</div>
												<!--adminmail_div2-->

												<!--adminmail_div3-->
												<div id="adminmail_div3" style="display: none;">
													<table width="100%" border="0" align="left" cellpadding="0"
														cellspacing="5">
														<tr>
															<td class="text_icon2" valign="top" style="width:31%">
																<span>服务器地址：</span>
															</td>
															<td style="width:69%">
																<span>
																	<input type="text"
																		id="systemdomino" class="input_120px input_text"
																		maxlength="30" onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" /> </span>
															</td>
														</tr>
													</table>
												</div>
												<!--adminmail_div3-->
												
												<!--adminmail_div4-->
												<div id="adminmail_div4" style="display: none;">
													<table width="100%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td class="text_icon2" valign="top" style="width:31%">
																<span>邮件域 ：</span>
															</td>
															<td style="width:69%">
																<input type="text" id="systemdomain2007"
																	class="input_120px input_text" maxlength="30"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
														<tr>
															<td class="text_icon2">
																<span>webservice地址：</span>
															</td>
															<td>
																<input type="text" id="systemexchangeService"
																	class="input_120px input_text" maxlength="50"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" />
															</td>
														</tr>
													</table>
												</div>
												<!--adminmail_div4-->
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<div class="center_nav_line"></div>
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<table width="100%"><tr>
													<td align="center" width="60%">
														<input type="button"
														onclick="javascript:savemanagerPushmailConfig();"
														value="确定" class="button_2" />
													</td>
													<td width="40%">
													</td>
												</tr>
												</table>
											</td>
										</tr>
									</table>
								</div>






								<!-- 邮件参数配置 -->
								<div id="mailparam" style="display: none">
									<table width="100%" border="0" align="center" cellpadding="0"
										cellspacing="5">
										<tr style="display:none">
											<td>
												<input id="setReceiveFlag" disabled="disabled" type="checkbox" onclick="script:setReceiveFlag();"/>企业用户轮询收取邮件<br>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="center_nav_line"></div>
											</td>
										</tr>										
										<tr>
											<td class="text_icon2" style="width: 31%" valign="top">
												<span>轮询间隔时间设置：</span>
											<br><br></td>
											<td style="width: 69%">
												<input type="text" id="mailrotationtime"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="3" />
												（分钟）*
											<br><br></td>
										</tr>
										<tr>
											<td class="text_icon2" style="width: 31%" valign="top">
												<span>服务器邮件收取时限：</span>
											<br><br></td>
											<td style="width: 69%">
												<input type="text" id="serverMailSize"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="3" />
												（天）*
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2" class="gray">
												
													指服务器自动收取邮件时刻向前推指定天数的邮件，服务器才从邮件服务器收取，超过则不收，时间精确到分！
											<br><br></td>
										</tr>


										<tr>
											<td class="text_icon2">
												<span>服务器每次推送邮件数：</span>
											<br><br></td>
											<td>
												<input type="text" id="clientSize"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="3" />
												（封）*
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2" class="gray">
											
													服务器每次向客户端推送的邮件数或客户端主动发起邮件收取操作服务器每次下发邮件数,客户端可多次点收取邮件将邮件收全！
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="center_nav_line"></div>
											</td>
										</tr>
										
										<tr>
											<td>
												<input id="mailclear" type="checkbox" />邮件缓存清理策略<br><br>
											</td>
										</tr>
										<tr>
											<td colspan="2" class="gray">
												
													服务器在运行过程中产生大量邮件数据，为保证服务器高效运行每日凌晨1时将清理邮件缓存，以下设置为邮件缓存清理的策略，当以下条件同时满足，则删除超过邮件缓存时间的邮件!
										
											<br><br></td>
										</tr>
										<tr>
										<td class="text_icon2">
											<span>服务器邮件缓存时间：</span>
										<br><br></td>
										<td>
											<input type="text" id="serverMailSaveTime"
												class="input_120px input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="3" />
											（天）*
										<br><br></td>
										</tr>
										<tr>
											<td colspan="2" class="">
												
													服务器只缓存从当日凌晨1时起倒推指定天数的邮件，超过则自动清理，时间精确到分！
											<br><br></td>
										</tr>
										<tr>
											<td class="text_icon2">
												<span>服务器保存每个用户邮件数：</span>
											<br><br></td>
											<td>
												<input type="text" id="userMailSize"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="3" />
												（封）*
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2" class="gray">
												服务器为每个用户保存的最大邮件数量！ 
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2" class="gray">
											
													例：服务器邮件缓存时间设置为30天，服务器保存每个用户邮件数设置为100封.<br />
													　1.当邮件代理服务器上的邮件超过30天，但是邮件封数未超过100封，邮件代理服务器不会清理邮件代理服务器上的数据.<br />
													　2.当邮件代理服务器上的邮件未超过30天，邮件封数超过了100封，邮件代理服务器也不会清理邮件代理服务器上的数据.<br />
													　3.当邮件代理服务器上的邮件超过30天并且邮件封数超过100封，则邮件代理服务器会自动清理30天之前收到邮件代理服务器上的数据(此时邮件封数可能超过100封).
													<!--  例：当服务器邮件缓存时间设置为10天，服务器保存每个用户邮件数设置为100封，则当某用户的邮件在服务器缓存时间未超过10天时保存邮件数可超过100封，如超过10天则最多可保存100封！-->
										
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="center_nav_line"></div>
											</td>
										</tr>
										<tr>
											<td>
												<input id="mailqueue" type="checkbox" onclick="javascript:fun();"/>邮件队列策略<br><br>
											</td>
										</tr>
										<tr>
											<td class="text_icon2">
												<span>邮件队列长度：</span>
											<br><br></td>
											<td>
												<input type="text" id="mailqueuesize"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="3" disabled/>
												（封）*
											<br><br></td>
										</tr>
										
										<tr>
											<td colspan="2" class="gray">
											<%if(DhServerNameUtils.isEMOA){ %>
													如果使用这个策略EMA在向邮件服务器收取邮件时会形成一个邮件队列，例如设置邮件队列长度为30封则EMA服务器上最多只保存用户30封客户端未收取的邮件，
													当用户通过手机收取10封(这个数是可变的)后，邮件队列会释放10封邮件的位置，但是如果邮件队列已满用户还尚未收取邮件，这时EMA服务器收到第31封邮件之后会将队列中比较老的一封邮件自动清理，新邮件优先进入队列，用户手机不会再收到被清理的邮件！
											<%}else if(DhServerNameUtils.isEMAS){ %>		
													如果使用这个策略EMAS在向邮件服务器收取邮件时会形成一个邮件队列，例如设置邮件队列长度为30封则EMAS服务器上最多只保存用户30封客户端未收取的邮件，
													当用户通过手机收取10封(这个数是可变的)后，邮件队列会释放10封邮件的位置，但是如果邮件队列已满用户还尚未收取邮件，这时EMAS服务器收到第31封邮件之后会将队列中比较老的一封邮件自动清理，新邮件优先进入队列，用户手机不会再收到被清理的邮件！
											<%} %>
											<br><br></td>
										</tr>
										<tr>
											<td colspan="2">
												
											<br><br></td>
										</tr>
										
										
										
										<tr>
											<td colspan="2" align="center"><input type="button" onclick="javascript:saveMailParam();"
													value="确定" class="button_2" />
											<br><br></td>
										</tr>
									</table>
								</div>




								<%
									String enterpriseid = "";
									enterpriseid = (String) session.getAttribute("enterpriseid");
								%>
								<input type="hidden" id="branchid" value="<%=enterpriseid%>">

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
