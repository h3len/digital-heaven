<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<!-- css.css 通用css调用 -->
<link href="../theme/css.css" rel="stylesheet" type="text/css" />
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
	var GB_ROOT_DIR = "../skin/";
	//得到用户是否首次登陆标示
	var isFirstLogin = <%=session.getAttribute("isFirstLogin")%>;
	<% session.setAttribute("isFirstLogin",false);%>
	
	//得到用户类型
	var loginport = <%=session.getAttribute("loginport")%>;
	//得到企业id
 	var enterpriseid = "<%=request.getParameter("enterpriseid") != null ? request
							.getParameter("enterpriseid")
							: request.getSession().getAttribute("enterpriseid")%>";
	 //得到用户ID
 	 var userId = "<%=request.getParameter("user") != null ? request
					.getParameter("user") : request.getSession().getAttribute(
					"user")%>";
</script>
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

<!-- Top 页面顶部 -->
<div id="top" style="width: 100%; min-width: 1000px">
	<div id="logo_box">
		<div id="logo_login"></div>
		<div id="top_menu">
			<div class="float_right">
				<ul>
					<li>
						<img src="../theme/images/bug_home.gif" />
					<li>
						<%
						if ("0".equals(session.getAttribute("loginport").toString())) {
						%>
					
					<li>
						<a href="..<%=com.dheaven.mip.util.Constants.userHomeUrl%>"><%=MipWebJSPUi.mipweb_user_top_1%></a>
					<li>
					<%
					}else if("4".equals(session.getAttribute("loginport").toString())){
					%>
					<li>
						<a href="..<%=com.dheaven.mip.util.Constants.periodAdminUrl%>"><%=MipWebJSPUi.mipweb_user_top_1%></a>
					<li>
						<%
						} else {
						%>
					
					<li>
						<a href="..<%=Constants.adminHomeUrl%>"><%=MipWebJSPUi.mipweb_user_top_4%></a>
					<li>
						<%
						}
						%>

						<%
									if ("0".equals(session.getAttribute("loginport").toString())
									&& (ServerConfig.hasTcCorePlugin || ServerConfig.hasMdpPlugin)) {
						%>
						<%-- mkey 或 mee --%>
					<li>
						<img src="../theme/images/bug_down.gif" />
					<li>
					<li>
						<a href="#" onclick="javascript:getsetup();" class="hand"><%=MipWebJSPUi.mipweb_user_top_2%></a>
					<li>
					<li>
						<img src="/theme/images/list_fun1.gif" />
					</li>
					<li>
						<a onclick="javascript:bindmdpuser();" href="#"><%=MipWebJSPUi.mipweb_user_top_3%></a>
					<li>
						<%
						} else {
						%>
						<%-- 框架显示内容 --%>
						<%
						}
						%>
						
						<%
						if(!"4".equals(session.getAttribute("loginport").toString())){
						 %>
					
					<li>
						<img src="../theme/images/bug_pass.gif" />
					<li>
					<li>
						<a id="current" href="../user/admin_changepassword.jsp"><%=MipWebJSPUi.mipweb_user_top_5%>
						</a>
					<li>
					
					<%} %>

						<%
									if (Constants.ema_need_threebind != 0
									&& "0".equals(session.getAttribute("loginport").toString())) {
						%>
					
					<li>
						<img src="../theme/images/bug_pass.gif" />
					<li>
					<li>
						<a href="#" onclick="javascript:threebind();" class="hand"><%=MipWebJSPUi.mipweb_user_top_6%></a>
					<li>
						<%
						}
						%>
					
					<li>
						<img src="../theme/images/bug_exit.gif" />
					<li>
					<li>
						<a href="#" onclick="javascript:Logout();" class="hand"><%=MipWebJSPUi.mipweb_user_top_7%></a>
					<li>
				</ul>
			</div>
		</div>

	</div>

	<!-- Nav_menu 横向导航菜单 -->
	<DIV id="menu">

	</DIV>

	<script type="text/javascript">

	User2.LoadCategoryByUserId({
				callback:function(objXml) {
					DisplayTransformedXML(1, objXml, "../xslt/nav_left.xsl",document.getElementById("center_left"));
					initSlideDownMenu();
					
					User2.LoadTopCategoryByUserId({
						callback:function(objXml) {
							DisplayTransformedXML(1, objXml, "../xslt/nav.xsl",document.getElementById("menu"));
							if(isFirstLogin){
						    	if(loginport=="1"){
						    		//管理员登录时，弹出新窗口提醒当前有哪些用户未绑定手机号码，建议尽快绑定
						    		remindBindPhoneEnter(enterpriseid);
						    	}else if(loginport=="0"){
						    		//未绑定手机的普通用户通过WEB登录时，弹出页面要求绑定
							    	remindBindPhoneUser(userId);
						    	}	
						    }
						    document.getElementById('activeuser').innerHTML=objXml.documentElement.getAttribute("activeuser");
						},
						errorHandler:function(errorString, exception) {
						    DHalert("<%=MipWebJSPUi.mipweb_user_top_9%>"+errorString);
						}
					});
				},
				errorHandler:function(errorString, exception) {
				    DHalert("<%=MipWebJSPUi.mipweb_user_top_8%>"+errorString);
				}
	});
	
		function Logout()
{
	Ext.Msg.confirm(nowtitle, '<%=MipWebJSPUi.mipweb_user_top_10%>', function(btn){
					if(btn=='yes'){
							Progress('<%=MipWebJSPUi.mipweb_user_top_11%>','<%=MipWebJSPUi.mipweb_user_top_12%>');
							User2.logout({
								callback:function(objXml){
									if(objXml=="0"){
										 CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_13%>");
									     Progress('<%=MipWebJSPUi.mipweb_user_top_14%>','<%=MipWebJSPUi.mipweb_user_top_15%>');
									     window.location.href="..<%=Constants.userLoginUrl%>"
									}else if(objXml=="1"){
										 CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_16%>");
									     Progress('<%=MipWebJSPUi.mipweb_user_top_17%>','<%=MipWebJSPUi.mipweb_user_top_18%>');
									     window.location.href="..<%=Constants.adminLoginUrl%>"
									}else if(objXml=="2"){
										 CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_19%>");
									     Progress('<%=MipWebJSPUi.mipweb_user_top_20%>','<%=MipWebJSPUi.mipweb_user_top_21%>');
									     window.location.href="..<%=Constants.superAdminLoginUrl%>"
									}else if(objXml=="3"){
										 CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_22%>");
									     Progress('<%=MipWebJSPUi.mipweb_user_top_23%>','<%=MipWebJSPUi.mipweb_user_top_24%>');
									     window.location.reload();
									     //window.location.href="../default_manager.jsp"
									}else if(objXml=="4"){
										CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_19%>");
									     Progress('<%=MipWebJSPUi.mipweb_user_top_20%>','<%=MipWebJSPUi.mipweb_user_top_21%>');
									     window.location.href="..<%=Constants.periodAdminUrl%>"
									}else{
										CloseProgress();
										 DHalert("<%=MipWebJSPUi.mipweb_user_top_25%>"+objXml);
									}
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("<%=MipWebJSPUi.mipweb_user_top_26%>"+errorString);
								}
								
							
							});			
							}
						}
						);			
}	

function getsetup(){
window.open("../setup.htm","","top=50,left=200,width=700,height=400,scrollbars=false,dialog=yes,modal=yes,resizable=yes");
}

function bindmdpuser(){
	window.open("../mdp/mdpadmin/index.jsp","","top=50,left=200,width=700,height=400,scrollbars=false,dialog=yes,modal=yes,resizable=yes");
}


function threebind(){
	var userid="<%=request.getSession().getAttribute("user")%>";
	if(userid!=""){
	GB_showCenter("<%=MipWebJSPUi.mipweb_user_top_28%>", "../user/threebind.jsp?uid="+userid,300,400);
	}
}

<%
boolean b=session.getAttribute(Constants.CONFIG_GUIDE)==null&&!Constants.hasConfigGuide;
if(b){
%>
	GB_showCenter("<%=MipWebJSPUi.mipweb_user_top_29%>", "../guide/admin_config_guide.jsp",400,600);
<%}
%>
 
 //管理员登录时，弹出新窗口提醒当前有哪些用户未绑定手机号码，建议尽快绑定
  function remindBindPhoneEnter(enterpriseid)
  {
  	Progress('<%=MipWebMoreUi.mip_bindphone_8%>','<%=MipWebMoreUi.mip_bindphone_9%>');
  	User2.isBindPhoneEnter(enterpriseid,
  		{
		callback:function(userNames){
	  		if(userNames.length>0){	  		
	  			CloseProgress();
				Ext.Msg.confirm(nowtitle, '<%=MipWebMoreUi.mip_bindphone_12%>', function(btn){
							if(btn=='yes'){
									window.location.href="../user/business_user.jsp?nophone=nophone";									
								}else{
									return;
								}
							}
						);
				
	  		}else{
	  			CloseProgress();
	  		}
	  	},
  	errorHandler:function(errorString, exception){
  		CloseProgress();
  		DHalert("<%=MipWebMoreUi.mip_bindphone_10%>"+errorString);
  	}	 
	});
	 	
  }
  
  //未绑定手机的普通用户通过WEB登录时，弹出页面要求绑定
  function remindBindPhoneUser(userId)
  {
  	Progress('<%=MipWebMoreUi.mip_bindphone_8%>','<%=MipWebMoreUi.mip_bindphone_9%>');
  	User2.isBindPhoneUser(userId,
  		{
		callback:function(retStr){
	  		if(retStr=="1"){ 	  		
	  			CloseProgress();
	  			GB_showCenter("<%=MipWebMoreUi.mip_default_user_21%>", "../bindphone.jsp?",200,500);
	  		}else{
	  			CloseProgress();
	  		}
	  	},
  	errorHandler:function(errorString, exception){
  		CloseProgress();
  		DHalert("<%=MipWebMoreUi.mip_bindphone_10%>"+errorString);
  	}	 
	});  	
  } 
</script>