<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default_ecmanager.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
	
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var roleid = '<%=request.getParameter("roleid")%>';
			var username ="<%=session.getAttribute("username")%>";
			window.onload=function(){
				getrolelist();
				if(username=="emaadmin"){
			$('rolesetting').disabled=true;
		}
			}
			function modrole(){
				window.location.href="../user/modrole.jsp?roleid="+roleid;
			}
			function usermanager(){
				window.location.href="../user/rolejoinuser.jsp?roleid="+roleid;
			}
			function rolesetting(){
				window.location.href="../user/rolesetting.jsp?roleid="+roleid;
			}
			function getrolelist(){
				Progress('正在获取权限列表.......','角色管理'); 
				RoleAction.GetRoleJoinPermissionList(roleid,{
						callback:function(objXml) {
							CloseProgress();
							 DisplayTransformedXML(1, objXml, "../xslt/admin_role_permission_list.xsl",document.getElementById("divlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取角色列表失败，失败原因："+errorString);
						}
				}			
				);
			}
			function joinUser(){
				//window.location.href="../user/joinuser.jsp?roleid="+roleid;
			}
			function saveperssion(){
				var permissions = "";
				//取得权限值
				var o = document.getElementById("divlist").getElementsByTagName("input");
				 
			   for(var i=0;i<o.length;i++){
			       if(o[i].type == "checkbox" && o[i].checked == true){
			       	permissions += o[i].id + ";";
		       		}
			   } 
				if(permissions=="") {
				 DHalert("角色权限不能为空！");
				 return;
				 }
			   
			   
			   Progress('正在保存角色权限....','角色管理');
			   RoleAction.UpdateRolePermission(roleid,permissions,{
			  		
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("保存角色权限成功");
											//window.location.href="../user/rolejoinuser.jsp?roleid="+roleid;
										}else{
											DHalert("保存角色权限败，失败原因："+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("保存角色权限失败，失败原因："+errorString);
									}
				})
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">权限列表</span>
		</div>
		<div class="div_right"></div>
		<div id ="divlist"></div>
		<div class="div_center"><input id="rolesetting" type="button" class="button_2" value="确认" onclick="saveperssion()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		 <input input type="button" class="button_2" value="返回" onclick="window.history.go(-1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
		 <input type="button" class="button_2" value="关闭" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
