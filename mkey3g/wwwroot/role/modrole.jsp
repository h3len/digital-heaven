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
			function showRole(){
			  Progress('正在获取角色详情....','权限管理');
			  RoleAction.RoleShow(roleid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setEscapeHtml(false);
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						}
					});
			}
			window.onload=function(){
				showRole();	
				if(username=="emaadmin"){
				$('modrole').disabled=true;
		}
				
				
			}
			function modrole(){
				if($('rolename').value==''){
				 	 DHalert("角色不能为空！");
				 	 return false;
				 }
				 if($('rolename').value.length >21){
				 	 DHalert("角色名称长度不能超过20个字符");
				 	 return false;
				 }
				 
				 var comment = $('comment').value;
				 if(comment.length>40){
				 	 Ext.Msg.confirm('综合办公提醒您', '备注不能超过40字符，系统自动截取前40字符，是否确认？', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,40);	
							 Progress('正在修改角色信息....','角色管理');
							 RoleAction.RoleModify(roleid,$('rolename').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										
										if(otext=="1"){
										
											 DHalert("修改角色信息成功");
											 parent.parent.getrolelist();
											 window.location.href="../role/roleshow.jsp?roleid="+roleid;
										}else{
											DHalert("修改角色信息失败，失败原因："+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("修改角色信息失败，失败原因："+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 			 RoleAction.RoleModify(roleid,$('rolename').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										
										if(otext=="1"){
											 DHalert("修改角色信息成功");
											 parent.parent.getrolelist();
											 window.location.href="../role/roleshow.jsp?roleid="+roleid;
										}else{
											DHalert("修改角色信息失败，失败原因："+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("修改角色信息失败，失败原因："+errorString);
									}
								});		
				 }
			}
			function usermanager(){
				window.location.href="../role/rolejoinuser.jsp?roleid="+roleid;
			}
			function rolesetting(){
				window.location.href="../role/rolesetting.jsp?roleid="+roleid;
			}
			function roledel(){
				  Ext.Msg.confirm('综合办公提醒您', '确认删除该角色？', function(btn){
					if(btn=='yes'){
							 Progress('正在删除角色详情....','权限管理');
							 RoleAction.RoleDelete(roleid,
								{
									callback:function(otxt) {
										if(otxt=='1'){
											parent.parent.closepage();
										}else{
											DHalert("删除角色失败，失败原因："+otxt);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("删除角色失败，失败原因："+errorString);
									}
								});
							}else{
							return false;	
							}
						}
						);
				
			}
			
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">角色信息</span>
		</div>
		<div class="up_subtitle">
			<span>角色基本信息：</span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					角色名称
				</td>
				<td width="71%">
					<input id="rolename" type="text" class="input_text input_120px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"/>*
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					备注
				</td>
				<td width="71%" >
					<textarea id="comment" style="width:300px;height:100px;word-breat:break-all" class="input_h380px" onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"></textarea>
				</td>
			</tr>
			
		</table>
		<div class="div_center"><input type="button" id="modrole" class="button_2" value="确认" onclick="modrole()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input input type="button" class="button_2" value="返回" onclick="window.history.go(-1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="button_2" value="关闭" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
