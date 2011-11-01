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
			var pageid = 1 ;
			function showRole(){
			  Progress('正在获取角色详情....','权限管理');
			  RoleAction.GetRoleJoinUserList(roleid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						}
					});
			}
			window.onload=function(){
				getrolelist(pageid);
				if(username=="emaadmin"){
		$('rolejoin').disabled=true;
		}
			}
			function modrole(){
				window.location.href="../role/modrole.jsp?roleid="+roleid;
			}
			function usermanager(){
				window.location.href="../role/rolejoinuser.jsp?roleid="+roleid;
			}
			function rolesetting(){
				window.location.href="../role/rolesetting.jsp?roleid="+roleid;
			}
			function joinUser(){
				window.location.href="../role/importuser.jsp?roleid="+roleid;
			}
			function getrolelist(pageid){
				Progress('正在获取角色用户列表.......','角色管理'); 
				RoleAction.GetRoleJoinUserList(roleid,pageid,{
						callback:function(objXml) {
							CloseProgress();
							if(username!=""&&username=="emaadmin"){
							DisplayTransformedXML(1, objXml, "../xslt/admin_role_join_admin_list_emaadmin.xsl",document.getElementById("divlist"));
							}else{
							DisplayTransformedXML(1, objXml, "../xslt/admin_role_join_admin_list.xsl",document.getElementById("divlist"));
							}
							
							
							
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取角色列表失败，失败原因："+errorString);
						}
				}			
				);
			}
			function UnJoinUser(userid){
				Ext.Msg.confirm('综合办公提醒您', '确定退出该用户吗？', function(btn){
									if(btn=='yes'){
										Progress('正在退出用户.......','角色管理'); 
										RoleAction.UnJoinUser(roleid,userid,{
												callback:function(otext) {
													CloseProgress();
													if(otext=='1'){
														 DHalert("退出用户成功!");
														 getrolelist(pageid);
													}
												},
												errorHandler:function(errorString, exception) {
													CloseProgress();
												    DHalert("获取角色列表失败，失败原因："+errorString);
												}
										}			
										);
									}
									return;
				});
			}
			
	//批量退出角色
	function UnJoinGroupUser(){
		var cks = document.getElementsByName('mark');
		
		var values = new Array();
		for(i = 0;i<cks.length;i++)
		{
			if(cks[i].checked)
			{
				values.push(cks[i].value);
			}
		}
		if(values.length < 1)
		{
			DHalert('请勾选要退出的用户!');
			return;
		}
		Ext.Msg.confirm('综合办公提醒您', '您确定要退出选择用户？',function(btn)
		{
			if(btn=='yes'){
				Progress('正在处理退出请求,请稍候...','处理中');
				RoleAction.UnJoinGroupUser(roleid,values,{
					callback:function(otext) {
						CloseProgress();
						if(otext=='1'){
							 DHalert("退出用户成功!");
							 getrolelist(pageid);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("获取角色列表失败，失败原因："+errorString);
					}
				}) ;
			}
		});
	}
	
	//全选的方法
	
	function checkall()
	{
		var cks = document.getElementsByName('mark');
		for(i = 0;i<cks.length;i++)
		{
			cks[i].checked = true;
		}
	}
	
	//反选的方法
	function inverse()
	{
		var cks = document.getElementsByName('mark');
		for(i = 0;i<cks.length;i++)
		{
			if(cks[i].checked)
			{
				cks[i].checked = false;
			}else
			{
				cks[i].checked = true;
			}
		}
	}		
	
	
			function gohome(){
			window.location.href="roleshow.jsp?roleid="+roleid;
			}
			
	function ChangePage(pid){
		getrolelist(pid) ;
	}	
		</script>
	</head>
	
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">用户列表</span>
		</div>
		<div>
			<input id="rolejoin" type="button" class="button_4" value="加入用户" onclick="joinUser()"/>
			<input id="roledele" type="button" class="button_4" value="退出角色" onclick="UnJoinGroupUser()"/>
		</div>
		<div id ="divlist"></div>
		<div class="div_center"><input type="button" class="button_2" value="返回" onclick="gohome()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
