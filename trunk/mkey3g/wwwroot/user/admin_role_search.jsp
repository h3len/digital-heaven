<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){	 	
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");
		java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"miprole");
		if(list == null || list.size() == 0)
		{
			out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
	}
}
%>
<html>
	<head>
		<title><%= MipWebJSPUi.mipweb_user_admin_role_search_1 %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
	  <link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
	  <link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
	   //初始化
	   window.onload = function()
	   {
	       loadSearchUI();
	   }    
	   
	   //载入查询条件，即功能列表
	 function loadSearchUI()
	   {
	       var url = "../role.do";
	       var pars = "action=GetRoleJoinPermissionList";
	       var myAjax = new Ajax.Request(url,
				       {
				       method: 'post', 
				       parameters: pars, 
				       onComplete: function(originalRequest)
							       {
							       var objXml = originalRequest.responseXML;
							       DisplayTransformedXML(1, objXml, "../xslt/admin_role_function_list.xsl",document.getElementById("divList"));
							       progressBar.Close();
							       }
				       });
	   }
	   
	 function searchByFunction()
	   {
	   	var permissions = "";
				//取得权限值
				var o = document.getElementById("divList").getElementsByTagName("input");
			   for(var i=0;i<o.length;i++){
			       if(o[i].type == "checkbox" && o[i].checked == true){
			       	permissions += o[i].id + ";";
			       		}
			   } 
			   
			   //调用父窗口的按功能查询方法			   
				parent.parent.searchRoleByFunction(permissions);   
	   }
	   
	   
	</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
	
	<!--列表-->
	<div id="divList">loading..</div>
	<p class="ar"><div class="div_center"><input type="image" class="button" onclick="javascript:searchByFunction();return false;" value="<%= MipWebJSPUi.mipweb_user_admin_role_search_2 %>"  src="../skin/default/images/button_search.gif" width="60" height="22" /></div></p>

	</body>
</html>
