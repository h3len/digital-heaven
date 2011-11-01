<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
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
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	</head>
<script type="text/javascript">
	window.onload= function(){
		try{
			parent.parent.ChangePage(parent.parent.pageid);
		}catch(e){
		}
	}
</script>
	<body>
		<div id="center" align="center">
					<!-- 中部主要内容开始 -->
						<div id="center_nav">
							<%= MipWebMoreUi.mip_user_importsuccess_1 %>
						</div>
						<hr>
						<br/>
					<div id="mainbox" align="center">
								<table width="100%" class="tablelist text_align_center" align="center">
									<tr>
										<td>
											<div id="preview"  align="left">
												<%
												
													if(session.getAttribute("reqstr") != null)
													{
														out.println(session.getAttribute("reqstr"));
														//为了节约资源的说.
														session.removeAttribute("reqstr");
													}else
													{
														out.println("<script>history.back();</script>");
													}
												
												%>
												</div>
										</td>

									</tr>
									<tr>
										<td>
											<input name="button" class="button_4" type="button" id="BtnOK"
												onclick="window.history.back();" value="<%= MipWebMoreUi.mip_user_importsuccess_2 %>" />
										</td>
									</tr>
								</table>

							</div>

		</div>
		<div class="clear"></div>
	</body>
</html>
