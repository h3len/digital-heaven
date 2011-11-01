<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
<script language="javascript" src="../skin/common.js"></script>
<link href="../skin/common.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts_main.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
<!--ExtJs-->
<link href="../skin/ext-all.css" type=text/css rel=stylesheet />
<script src="../skin/ext-base.js" type=text/javascript></script>
<script src="../skin/ext-all.js" type=text/javascript></script>
<!-- Dwr Js -->
<script src="/dwr/interface/Mas2.js" type="text/javascript"></script>
<script src="/dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>

<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>

<script type="text/javascript">
			var progressBar ;
			var returnBo;
			var returnMsg;
			var returnExc;
			var needmasconfig=false;
			var serverstate;
		function getdiv(){
			if(serverstate==0){//说明还没有进行初始化
				GB_showCenter("<%= MipWebJSPUi.mipweb_user_main_1 %>", "../user/index_masid.jsp",450,878);
			}else{
				GB_showCenter("<%= MipWebJSPUi.mipweb_user_main_2 %>", "../user/index_masid.jsp",450,878);
			}
		}
		function serverinit(){
				GB_showCenter("<%= MipWebJSPUi.mipweb_user_main_3 %>", "../init/init_enterprise.jsp",450,878);
			
		}
	//载入用户具有访问权限的模块，包括基础组件和插件
	function LoadCategoryByUserId()
	{
		progressBar= new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_main_4 %>");
		var url = '../masuser.do';
		var pars = 'action=LoadCategoryByUserId&userid=<%=request.getSession().getAttribute("user")%>';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadCategoryByUserId_CallBack}
		);
	}
	//载入模块CallBack
	function LoadCategoryByUserId_CallBack(originalRequest)
	{	
			
			var objXml = originalRequest.responseXML;
			//开始解析
			try{

			
					DisplayTransformedXML(1, objXml, "../xslt/index.xsl",document.getElementById("index_left"));		
		
			}
			catch(ex)
			{
				//alert(ex.message)
			}
			progressBar.Close();
		
			// needmasconfig = objXml.getElementsByTagName("needmasconfig")[0].firstChild.nodeValue;
			needmasconfig = false;
			if(needmasconfig=="true"){
				Ext.MessageBox.alert('<%= MipWebJSPUi.mipweb_user_main_5 %>', '<%= MipWebJSPUi.mipweb_user_main_6 %>',getdiv());
			}
			if(needmasconfig=="false"&&serverstate==0){
				Ext.MessageBox.alert('<%= MipWebJSPUi.mipweb_user_main_7 %>', '<%= MipWebJSPUi.mipweb_user_main_8 %>',serverinit());
			}
			
	}

		  //载入用户具有访问权限的模块，包括基础组件和插件forleft
			function LoadCategoryByUserIdforleft()
			{
				var url = '../masuser.do';
				var pars = 'action=LoadCategoryByUserId&userid=<%=request.getSession().getAttribute("user")%>';
				var myAjax = new Ajax.Request(
				url,
				{method: 'post', parameters: pars, onComplete: LoadCategoryByUserIdforleft_CallBack}
				);
			}
			//载入模块forleftCallBack
			function LoadCategoryByUserIdforleft_CallBack(originalRequest)
			{
					var objXml = originalRequest.responseXML;
					//开始解析
					try{
								}
					catch(ex)
					{
						alert(ex.message);
					}
			}
			
			
			//修改工作模式
	function ChangeWork()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_main_9 %>");
		var url = '../masuser.do';
		var pars = 'action=UserChangeWork';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: ChangeWork_CallBack}
		);
	}
	//修改工作模式 Conkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;"allBack
	function ChangeWork_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_main_10 %>");
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_main_11 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_main_12 %>"+errorMessage);
		}
		progressBar.Close();
	}
	
	//载入用户工作模式
	function LoadUserWork()
	{
		var url = '../masuser.do';
		var pars = 'action=LoadUserWork';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadUserWork_CallBack}
		);
	}
	//载入用户工作模式 CallBack
	function LoadUserWork_CallBack(originalRequest)
	{
		try{
			var a = originalRequest.responseText;
			if( a == "1" )
				$('mod').value = 1;
			else
				$('mod').value = 0;
		}catch(err){

		}
	}
		  window.onload=function(){
				LoadCategoryByUserId();
				LoadUserWork();
				getServerState();
				 <%
					//验证权限
					boolean hasAdminPermission = false;
					String uid = null;
					if(request.getSession().getAttribute("user")!=null && !request.getSession().getAttribute("user").equals(""))
					{//权限
					 	uid = (String)request.getSession().getAttribute("user"); 	
					 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
							PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
							if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mip-tc-core")!=null)
							{
								java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mip-tc-core");
								if(list != null && list.size() > 0)
								{
									hasAdminPermission = true;
								}
							}
						}
						else
						{
							hasAdminPermission = true;
						}
					}
					
					if(hasAdminPermission == true)
					{
					%>
						getNeedUpdate();
						<%}%>
			}
			function getServerState(){
				User2.getServerState({
					callback:function(otext){
						serverstate=otext;
					},
					errorHandler:function(errorString, exception) {
					}
				});
			}
			function getNeedUpdate(){
				Mas2.getNeedUpdate(
													{
													callback:function(objXml) {
														
														DisplayTransformedXML(1, objXml, "../xslt/fileUpdata.xsl",document.getElementById("uploadfile"));
													},
													errorHandler:function(errorString, exception) {
														alert(exception.message);
													}
												}		
													);
			}
	function reregi(){
		GB_CURRENT.hide();
		Ext.MessageBox.alert('<%= MipWebJSPUi.mipweb_user_main_13 %>', '<%= MipWebJSPUi.mipweb_user_main_14 %>',failmethod());
	}
 
</script>
</head>
<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

<!--Top Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Top Include-->

<div class="center_nav"><%= MipWebJSPUi.mipweb_user_main_15 %></div>
<div class="center_nav_line"></div>
<div class="center">
  <div class="index_left" id="index_left">
  </div>

	<div style="width:1px; background-color:#EBEBEB; height:490px; float:left; display:table;"></div>
  <div class="index_right">
		<div class="wellcome"><span class="href_12px_green_bold"><%= MipWebJSPUi.mipweb_user_main_16 %><%=session.getAttribute("truename")%></span></div>
		
				 <%
					//验证权限
					if(request.getSession().getAttribute("user")!=null && !request.getSession().getAttribute("user").equals(""))
					{//权限
					 	uid = (String)request.getSession().getAttribute("user"); 	
					 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
							PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
							if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mip-tc-core")!=null)
							{
								java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mip-tc-core");
								if(list != null && list.size() > 0)
								{
									hasAdminPermission = true;
								}
							}
						}
						else
						{
							hasAdminPermission = true;
						}
					}
					
					if(hasAdminPermission == true)
					{
					%>
							<div class="attrtion" id="uploadfile"></div>
		<div class="406ad"></div>
						<%}%>
		
		

	    </div>
</div>
	<div style="clear:both;"></div>


<!--Bottom Include-->
<jsp:include   page="../user/bottom.jsp"   flush="true"/>
<!--Bottom Include-->

</body>
</html>
