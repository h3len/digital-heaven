<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
/*
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)&&!uid.equals(session.getAttribute("enterpriseid"))){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail")==null)
		{
			out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail");
			if(list == null || list.size() == 0)
			{
				out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				return;
			}
		}
	}
}
*/
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_user_changepass_1 %></title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/CheckOaLogin.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
				<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript">
		function checkconfig(){
			  CheckOaLogin.checkIsSSO(userid,
					{
						callback:function(oMap) {
							dwr.util.setValues(oMap);
							//这里校验下是不是让他可以修改密码
							if(userid!="00000000000000000000000000000000"&&$('issso').value=="1"&&$('userlogintype').value=='bs'&&$('bsaddusertype').value=='1'){//启用sso，单点登录方式bs，自动同步密码
								//那我们就把所有的东西都给禁止了
								
								parent.parent.DHalert("<%= MipWebJSPUi.mipweb_user_changepass_2 %>");
								parent.parent.GB_CURRENT.hide();
							}
						},
						errorHandler:function(errorString, exception) {
							
						}
					});
			
		}
		window.onload=function(){
			if(<%=request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals("")%>){
				parent.parent.GB_CURRENT.hide();
				parent.parent.location.href="../default_ecmanager.jsp";
			}
			checkconfig();
		}
		var userid = '<%=request.getParameter("userid")%>';

		var isSearch = <%=request.getParameter("isSearch")%>;

		function enableuser(){
			if($('pwd').value.length<<%=com.dheaven.mip.util.Constants.PASSLENGTH%> || $('pwd').value.length>20){
				DHalert("<%= MipWebJSPUi.mipweb_user_changepass_3 %><%=com.dheaven.mip.util.Constants.PASSLENGTH%><%= MipWebJSPUi.mipweb_user_changepass_4 %>");
				return false;
			}
			if($('pwd').value.replace(/\s/g,"")==""||$('pwd').value =="" ){
				DHalert("<%= MipWebJSPUi.mipweb_user_changepass_5 %>");
				return false;
			}

			if($('pwd').value!=$('repwd').value){
				DHalert("<%= MipWebJSPUi.mipweb_user_changepass_6 %>");
				return false;
			}
			 User2.adminChangePassword(userid,$('pwd').value,
			{
				callback:function(otext) {
					if(otext=='1'){
						DHalert("<%= MipWebJSPUi.mipweb_user_changepass_7 %>");
						if(isSearch==null||isSearch==""){
							parent.parent.ChangePage(parent.parent.pageid);
						}else{
							if(!isSearch){
					       		parent.parent.ChangePage(parent.parent.pageid);
							}else{
								parent.parent.ChangeSearchPage(parent.parent.pageid);
							}
						}

						parent.parent.GB_CURRENT.hide()
					}else{
						DHalert("<%= MipWebJSPUi.mipweb_user_changepass_8 %>"+otext);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_changepass_9 %>"+errorString);
				}
			});
		}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td align="right"><span class="blue_12" ><%= MipWebJSPUi.mipweb_user_changepass_12 %></span></td>
	 <td><input type="password" id="pwd" value="" maxlength="20"/></td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12" ><%= MipWebJSPUi.mipweb_user_changepass_13 %></span></td>
	 <td><input type="password" id="repwd" value="" maxlength="20"/></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_changepass_14 %>" onclick="javascript:enableuser();"/> </td></tr>
	 </table>
	<input type="hidden" id="userlogintype"/>
	<input type="hidden" id="bsaddusertype"/>
	<input type="hidden" id="issso"/>
  </body>
</html>
