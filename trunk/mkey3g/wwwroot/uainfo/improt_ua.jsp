<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out.print("<script>top.location.href='../default.jsp?url="
				+ request.getServletPath() + "?"
				+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");
		if (!uid
				.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)) {
			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
					.getBean("permissionServiceImpl");
			if (ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmail") == null) {
				out
						.print("<script>top.location.href='../default_admin.jsp?url="
								+ request.getServletPath()
								+ "?"
								+ request.getQueryString()
								+ "'</script>");
				return;
			} else {
				java.util.List list = ps
						.findUserPrivacyByUserIDAndCategoryID(uid,
								"mipmail");
				if (list == null || list.size() == 0) {
					out
							.print("<script>top.location.href='../default_admin.jsp?url="
									+ request.getServletPath()
									+ "?"
									+ request.getQueryString()
									+ "'</script>");
					return;
				}
			}
		}
	}
%>
<html>
  <head>
       <title>导入UA信息</title>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
			<script type="text/javascript" src="../scripts/prototype.js"></script>
			<link href="../theme/css.css" rel="stylesheet" type="text/css" />
     	  <script type="text/javascript">
     
		function upload(){
       	  		var file=document.getElementById("file").value;
        		var file_type=file.substring(file.lastIndexOf(".")+1)
				if(file==""){
					parent.parent.DHalert("请先选择CSV文件");
					return;
				}
				if(file_type!="CSV"&&file_type!="csv"&&file_type!="csv"&&file_type!="CSV"){
					alert("文件格式不正确,请选择CSV文件");
					return;
				}
				form1.submit();	
		}
		function forexample(){
    		$('example').href="../uaexa.do";
    	}
       </script>
  </head>
  
  <body>
		<form id="form1" method="post" action="/csvimport.do"
			enctype="multipart/form-data">
	
			<div class="up_subtitle">
				<span><%= MipWebJSPUi.mipweb_user_import_user_4 %></span>
			</div>
			<br/>
			<br/>
			<table width="600px" border="0" align="center" cellpadding="0"
				cellspacing="5">

				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_import_user_5 %>
					</td>
					<td width="71%">
						<input type="radio" id="excel" name="filetype" checked="true" />从CSV文件中导入
						<a id="example" href="#" onclick="forexample();" class="blue_12"><%= MipWebJSPUi.mipweb_user_import_user_7 %></a>

					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						说明
					</td>
					<td width="71%" style="font-size: 12px;color: red;">
						应CSV文件格式国际标准要求，上传文件中不能存在英文逗号(,)，否则上传将不能成功!
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_import_user_8 %>
					</td>
					<td width="71%">
						<input id="file" type="file" NAME="file" style="width: 300px;">
						<input id="ftype" name="ftype" type="hidden">
					</td>
				</tr>
			</table>
		</form>
		<div style="text-align:center"><input type="button" onclick="javascript:upload();"  id="BtnOK" value="<%= MipWebJSPUi.mipweb_user_import_user_9 %>">&nbsp;&nbsp;&nbsp;&nbsp; 
       </div>
  </body>
</html>