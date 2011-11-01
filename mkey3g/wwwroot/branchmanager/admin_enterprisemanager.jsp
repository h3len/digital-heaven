<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title><%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_1 %></title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/mobiledisk.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipAdminMailConfigAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
//企业id
//得到企业id
 var enterpriseid = "<%=request.getParameter("enterpriseid") != null ? request
							.getParameter("enterpriseid")
							: request.getSession().getAttribute("enterpriseid")%>"; 
	window.onload=function(){
		showtab();
	}
		
	function  showtab(){
		var ab = [[showmodent,'<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_3 %>'],[showadmin,'管理员信息配置']];
		DHTabPanel(ab,900,0,"tabcard");
	}
		
	function showmodent(){
		$('moddiv').style.display="";
		$("modadmin").style.display="none";
		//开始提交数据
	  	Progress("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_18 %>","<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_19 %>");
	  	dwr.util.setEscapeHtml(false);
	    EnterpriseAction.showEnterpriseByidmod(enterpriseid,
				 	function(data){
				 		CloseProgress();
						dwr.util.setValues(data);
					}
		);	
	}
	
	function showadmin(){
		$('moddiv').style.display="none";
		//开始提交数据
	  	$("modadmin").style.display='';
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
	
	//保存修改后企业信息
	function modenterprise(){
	    var cf = new CheckForm();
		var temp=rp(cf.Trim($('menterpristname').value));
	    if(temp==""){
			DHalert("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_7 %>");
			return false;
		}
	    temp=rp(cf.Trim($('mshortname').value));
		if(temp==""){
			DHalert("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_8 %>");
			return false;
		}
		temp=rp(cf.Trim($('mlogincode').value));
		if(temp==""){
			DHalert("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_9 %>");
			return false;
		}
	    if($("mcomment").value!=""&&$("mcomment").value.length>50){
	        DHalert("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_10 %>");
	        return;
        }
	 //开始提交数据
  	 Progress("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_15 %>","<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_16 %>");
  	 dwr.util.setEscapeHtml(false);
     EnterpriseAction.modEnterprise(enterpriseid,$("menterpristname").value,
     $("mshortname").value,$("mlogincode").value,$("mcomment").value,0,0,'127.0.0.1',
	 	false,false,false,false,
	 	function(data){
	 	   if(data == "1"){
	 	   			CloseProgress();
					SDHalert("<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_17 %>",130);
					return;
   			}else{
   				DHalert(data);
			return false;
   			}
	 	
		}
	);	
	
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
		var mobile=cf.Trim($('systemmobile').value);	
		if(mobile!=''){
			if(!cf.IsTel(mobile)){
				DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_16 %>");
				return false;
			}
		}
		Progress('正在保存数据....','保存中');
      	MipAdminMailConfigAction.setSystemEmailConfig(
	      	$('systemname').value,
			$('systememail').value,
			$('systempassword').value,
			systememailstyle,
			systemsmtpserver,
			systemsmtpport,
			systemmaildomain,
			mobile,
    		function(data){
    			CloseProgress();
				if(data == "1"){
					DHalert("管理员信息配置成功！");	
				}else{
					DHalert("管理员信息配置失败！失败原因："+data);
				}
			}
		);
	}
	
	 function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if
		(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
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
	}
	
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
</script>
	</head>

	<body>
		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!-- begin center -->
		<div id="center">
			<div id="center_left" class="center_left"></div>
			<div id="center_right">
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<div id="center_nav_box">
						<div id="center_nav">
							<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_20 %>
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
							
							<div id="tabcard"> </div>
							<% if(false&&ServerConfig.EnableMutiEnterprise){ %>
								<div id="moddiv">
									<table width="70%" " border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td>
												<br />
												<br />
											</td>
										</tr>
										<tr>
											<td width="15%" align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_30 %>
											</td>
											<td width="75%">
												<input type="text" id="menterpristname" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="50" disabled="disabled"/>
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr>
											<td align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_31 %>
											</td>
											<td>
												<input type="text" id="mshortname" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" disabled="disabled" />
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr id="enterprisecode">
											<td align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_32 %>
											</td>
											<td>
												<input type="text" id="mlogincode" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" disabled="disabled"/>
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr>
											<td align="right" valign="top">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_41 %>
											</td>
											<td>
												<textarea id="mcomment" cols="50" rows="8"
													class="input_h380px" onfocus="fEvent('focus',this)"
													onblur="fEvent('blur',this)"
													onmouseover="fEvent('mouseover',this)"
													onmouseout="fEvent('mouseout',this)" disabled="disabled"></textarea>
											</td>
										</tr>

										<tr >
											<td  align="center" colspan="2">
												<input name="button" type="button" class="button_2"
													onclick="javascript:modenterprise();" value="<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_42 %>" disabled="disabled" />
											</td>
										</tr>

										<tr>
											<td>
												<br />
											</td>
										</tr>
									</table>
								</div>
								<%}else{ %>
									<div id="moddiv">
									<table width="70%" " border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td>
												<br />
												<br />
											</td>
										</tr>
										<tr>
											<td width="15%" align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_30 %>
											</td>
											<td width="75%">
												<input type="text" id="menterpristname" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="50" />
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr>
											<td align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_31 %>
											</td>
											<td>
												<input type="text" id="mshortname" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20"  />
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr id="enterprisecode">
											<td align="right">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_32 %>
											</td>
											<td>
												<input type="text" id="mlogincode" value=""
													class="input_text" onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" />
												*
											</td>
										</tr>
										<tr>
											<td>
												<br />
											</td>
										</tr>
										<tr>
											<td align="right" valign="top">
												<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_41 %>
											</td>
											<td>
												<textarea id="mcomment" cols="50" rows="8"
													class="input_h380px" onfocus="fEvent('focus',this)"
													onblur="fEvent('blur',this)"
													onmouseover="fEvent('mouseover',this)"
													onmouseout="fEvent('mouseout',this)" ></textarea>
											</td>
										</tr>


										<tr>
											<td align="center">
												&nbsp;
											</td>
											<td>
												&nbsp;
											</td>
										</tr>
										<tr >
											<td  align="center" colspan="2">
												<input name="button" type="button" class="button_2"
													onclick="javascript:modenterprise();" value="<%= MipWebJSPUi.mipbranchmanager_admin_enterprisemanager_42 %>"  />
											</td>
										</tr>

										<tr>
											<td>
												<br />
											</td>
										</tr>
									</table>
								</div>
								<%} %>
								<!-- 管理员邮箱设置 -->
								<div id="modadmin" style="display:none">

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
											<td class="text_icon2" style="width: 31%" valign="top">
												<span>手机号码：</span>
											</td>
											<td style="width: 69%">
												<input type="text" id="systemmobile"
													class="input_120px input_text"
													onmouseover="fEvent('mouseover',this)"
													onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
													onmouseout="fEvent('mouseout',this)" maxlength="20" />
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
							</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
