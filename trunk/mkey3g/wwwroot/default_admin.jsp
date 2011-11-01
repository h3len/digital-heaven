<%@ page import="com.dheaven.mip.config.*"%>
<%
	if (request.getParameter("action") != null && request.getParameter("action").equals("logout")
			&& request.getSession().getAttribute("user") != null) {
		//clear session	
		request.getSession().setAttribute("user", null);
		request.getSession().setAttribute("ssoid", null);
		request.getSession().setAttribute("username", null);
		request.getSession().setAttribute("truename", null);
		request.getSession().setAttribute("enterpriseid", null);
		//log
	}
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords"
			content="<%=MipWebMoreUi.mip_default_admin_1%>">
		<meta name="description"
			content="<%=MipWebMoreUi.mip_default_admin_2%>">
		<title><%=MipWebMoreUi.mip_default_admin_3%>-<%=ServerConfig.ALL_PAGE_TITLE%></title>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="dwr/interface/AdminUserLogin.js" type="text/javascript"></script>
		<script src="dwr/interface/User2.js" type="text/javascript"></script>
		<script src="dwr/engine.js" type="text/javascript"></script>
		<script src="dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
		var logincount =1;
		function logininit(){
				User2.getLoginType(2,
					function(data){
					dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);
					});
		}


	function delinfo(){
		Ext.Msg.confirm(nowtitle, '<%=MipWebMoreUi.mip_default_admin_4%>', function(btn){
					if(btn=='yes'){
								$('enterprisecode').value=""	;
								$('username').value=""	;
								$("password").value="";
								$("rnd").value="";
							return;					
							}
						}
						);
		}
	/*------------------------------------
		功能：系统登录
		@author yesun
		2006-11-1+
	------------------------------------*/
	//功能：用户登录
	function UserLogin()
	{

	 Progress('<%=MipWebMoreUi.mip_default_admin_5%>','<%=MipWebMoreUi.mip_default_admin_6%>');

	  if(document.getElementById("username").value == "")
		  {
	  		CloseProgress();
		  	SDHalert("<%=MipWebMoreUi.mip_default_admin_7%>",140);
		  	document.getElementById("username").focus()
		    return;
		  }
	  if(document.getElementById("password").value == "")
		  {
	  		CloseProgress();
		    SDHalert("<%=MipWebMoreUi.mip_default_admin_8%>",140);
		    document.getElementById("password").focus()
		    return;
		  }
	  if(logincount>1&&document.getElementById("rnd").value == "")
		  {
		  	CloseProgress();
		     SDHalert("<%=MipWebMoreUi.mip_default_admin_9%>",140);
		     document.getElementById("rnd").focus()
		    return;
		  }
	
		var logintype = 0;
		if(document.getElementById("checkboxid").checked == true){
		logintype = 1;
		}
		 var eccode="";
	
		
	  Progress('<%=MipWebMoreUi.mip_default_admin_10%>','<%=MipWebMoreUi.mip_default_admin_11%>');
	
	  
	  AdminUserLogin.login(eccode,$('username').value,$('password').value,$('rnd').value,2,logintype,logincount,
			{
				callback:function(objXml) {
					var loginresult = objXml[0];
					var string = objXml[1];
					if(objXml[0]){
							CloseProgress();
				  			 Progress('<%=MipWebMoreUi.mip_default_admin_17%>','<%=MipWebMoreUi.mip_default_admin_18%>');
						     //window.location.href="/mail/admin_mail.jsp";
						     //转到企业邮箱配置页面
						     if(string == ''){
						     	window.location.href="<%=com.dheaven.mip.util.Constants.enterpirseconfig%>";
						     }else{
						     	window.location.href=string;
						     }
						     
				  		}else{
				  			CloseProgress();
							 DHalert("<%=MipWebMoreUi.mip_default_admin_19%>"+string);
							 logincount++;
							 $('showrnd').style.display='';
							 changeRND();	  			
				  		}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					  DHalert("<%=MipWebMoreUi.mip_default_admin_20%>"+errorString);
					  logincount++;
					 $('showrnd').style.display='';
					 changeRND();	
				}
			});
	}
	//功能：用户登录 - CallBack
	
	// 功能：取得Radio的value
	function GetRadioValueChoose(el)
	{
	  var sValue = "";
	  //取得第一个元素的name,搜索这个元素组
	  var tmpels = document.getElementsByName(el);
	  for(var i=0;i<tmpels.length;i++)
	 	 {
	    if(tmpels[i].checked)
			    {
			      sValue = tmpels[i].value;
			      break;
			    }
	 	 }
	  return sValue;
	}
	
	//功能：初始化数据，如读取cookie的值
	function init()
	{
		/*
		 //判断是否为多集团系统
		if("<%=com.dheaven.mip.config.ServerConfig.EnableMutiEnterprise%>" == "true")
		{
			// 需要取出集团列表
			document.getElementById("trCatalogList").style.display = "";
		}  
		else
		{
				document.getElementById("trCatalogList").style.display = "none";
		}
		*/
	}
	function changeRND()
	{
		document.getElementById("imgRnd").src = "rnd.do?type=user_rnd&"+Math.random();
	}
	function formreset(){
		document.getElementById('username').value="";
		document.getElementById('password').value="";
		document.getElementById('rnd').value="";
		changeRND()

	}
	
		//当输入回车时，可以直接提交
		function subIt(eventTag){
		  	var event = eventTag||window.event;    
	   		var currentKey = event.charCode||event.which;  
			if(currentKey==13){ 
	  			userLogin();
	         }
		}
		
	function changeRND()
	{
		document.getElementById("imgRnd").src = "rnd.do?type=user_rnd&"+Math.random();
	}
	window.onload = function(){
		
		logininit();
	}
	function funchecked(){
		if(document.getElementById("checkboxid").checked == true){
				document.getElementById("checkboxid").checked = false;
		}else{
				document.getElementById("checkboxid").checked = true;
		}
	}
</script>
	</head>
	<body onkeydown="subIt(event)">

		<!-- Top 页面顶部 -->
		<div id="top">
			<div id="logo_box">
				<div id="logo_login"></div>
				<div id="top_title">
					<div class="float_right">
						<img src="theme/images/top_title.gif" />
					</div>
				</div>

			</div>

			<!-- Nav_menu 横向导航菜单 -->
			<DIV id=menu style="width: 970px">
				<UL>
					<LI id=menu_home></LI>
					<LI id=search></LI>
				</UL>
			</DIV>

			<!-- Main 页面中部 -->
			<div id="center">

				<div id="login_top_bg2"></div>
				<div class="login_box_main">


					<table width="100%" height="179" border="0" cellpadding="0"
						cellspacing="0">
						<tr>
							<td width="47%" valign="middle">
								<div align="center">
									<img src="theme/images/login_center_text.gif" width="276"
										height="39" />
								</div>
							</td>
							<td width="53%">
								<table width="400" border="0" cellspacing="0" cellpadding="0">


									<tr>
										<td>
											<%=MipWebMoreUi.mip_default_admin_21%>
										</td>
										<td colspan="2">
											<input type="text" tabindex="2" id="username" name="username"
												class="input_text" onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
										<td rowspan="4" width="39%">
											<input type="image" src="theme/images/login_button.gif"
												name="submit" id="btnOK"
												value="<%=MipWebMoreUi.mip_default_admin_22%>"
												onclick="javascript:UserLogin()" tabindex="5" />
										</td>
									</tr>
									<tr>
										<td>
											<%=MipWebMoreUi.mip_default_admin_23%>
										</td>
										<td colspan="2">
											<input type="password" tabindex="3" id="password"
												name="password" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
										<td></td>
									</tr>
									<tr style="display:none" id="showrnd">
										<td width="16%">
											<%=MipWebMoreUi.mip_default_admin_24%>
										</td>
										<td width="15%">
											<input class="input_text_short" name="rnd" id="rnd"
												type="text" emptyok="false" tabindex="3" size="10"
												maxlength="10" onfocus="fEvent('focus',this)"
												onblur="fEvent('blur',this)"
												onmouseover="fEvent('mouseover',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
										<td width="20%" >
											<a href="#"><img
													alt="<%=MipWebMoreUi.mip_default_admin_25%>"
													src="rnd.do?type=user_rnd" id="imgRnd" name="imgRnd"
													border="0" usemap="absmiddle" onclick="changeRND()"
													onmouseover="this.style.cursor='hand'"
													onMouseOut="fEvent('mouseout',this)" /> </a>
										</td>
										<td></td>
									</tr>
									<tr>
										<td colspan="5">
											<input name="checkbox" id="checkboxid" type="checkbox"
												id="r1" title="<%=MipWebMoreUi.mip_default_admin_26%>" />
											<span onclick="funchecked();" class="hand"><%=MipWebMoreUi.mip_default_admin_26%></span>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:delinfo();"><%=MipWebMoreUi.mip_default_admin_27%></a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<div id="login_bom_bg"></div>

			</div>

<!-- Bottom 页面底部 -->
<div id="bottom" class="gray_12"><div style="width:970px;margin:auto;text-align:center;"><%= MipWebMoreUi.mip_default_user_59 %></div>
	</body>
</html>