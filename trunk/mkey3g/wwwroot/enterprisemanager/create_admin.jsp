<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out.print("<script>top.location.href='../default_admin.jsp?url=" + request.getServletPath() + "?"
				+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");
		if (!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)) {
			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
					.getBean("permissionServiceImpl");
			if (ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmail") == null) {
				out.print("<script>top.location.href='../default_admin.jsp?url=" + request.getServletPath()
						+ "?" + request.getQueryString() + "'</script>");
				return;
			} else {
				java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmail");
				if (list == null || list.size() == 0) {
					out.print("<script>top.location.href='../default_admin.jsp?url=" + request.getServletPath()
							+ "?" + request.getQueryString() + "'</script>");
					return;
				}
			}
		}
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>创建企业管理员页面</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		var enterprise_id="<%=request.getParameter("enterpriseid") == null ? "" : request.getParameter("enterpriseid")%>";
	   window.onload=function(){
    		//首先得到该企业下的所有用户
    		getEnterpriseNoAdmin();
    	}
    	
    function getEnterpriseNoAdmin(){
    	 Progress("正在载入数据...","提示");
	   	 EnterpriseAction.getEnterpriseNoAdmin({
					callback:function(oMap) {
						CloseProgress();
						var has=false;
						for(var x in oMap){
							has=true;
							break;
						};
						if(has){
							DWRUtil.addOptions("enterpriseid",oMap);
							var ops=$("enterpriseid").options;
							for(i=0;i<ops.length;i++){
								if(ops[i].value==enterprise_id)
									$("enterpriseid").selectedIndex=i;
							}
						}
						else{
							$("enterpriseid").disabled=true;
							$("submit_b").disabled=true;
							Ext.Msg.alert(nowtitle,"所有企业都已创建了企业管理员",function(){
																					parent.parent.GB_hide();
																				}
							);
							
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("操作失败，失败原因："+errorString);
					}
			});	
    }
    
	function createEnterpriseAdmin(){
			cf = new CheckForm();
			if(cf.Trim($("username").value) == ""){
				DHalert("请输入管理员名称！");
				return false;
			}
			if(cf.Trim($("username").value) == "admin"||cf.Trim($("username").value) == "mipadmin"||cf.Trim($("username").value) == "emoaadmin"){
				DHalert(cf.Trim($("username").value)+"为系统保留名称，请更换管理员名称！");
				return false;
			}
			if(cf.Trim($("password").value) == ""){
				DHalert("请输入登录密码！");
				return false;
			}
			if($('password').value.length < <%=com.dheaven.mip.util.Constants.PASSLENGTH%> ){
	        	DHalert("登录密码密码长度至少为<%=com.dheaven.mip.util.Constants.PASSLENGTH%>位！");
				return false;
	        }
			if(cf.Trim($("password_chk").value) == ""){
				DHalert("请输入重复登录密码！");
				return false;
			}
			if(cf.Trim($("password_chk").value) != cf.Trim($("password").value)){
				DHalert("两次输入的登录密码不一致！");
				return false;
			}
	
	  	       //开始提交数据
  	 Progress("正在提交数据...","提示");
    EnterpriseAction.createEnterpriseAdmin(dwr.util.getValue("enterpriseid"),cf.Trim($("username").value),cf.Trim($("password").value),{
				callback:function() {
					parent.parent.closePage();
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("操作失败，失败原因："+errorString);
				}
			});
	}
	
</script>
	</head>

	<body>
		<div class="up_title">
			<span class="blue_14_bold">企业管理员管理</span>
		</div>
		<div class="up_subtitle">
			<span class="blue_12_bold">创建企业管理员</span>
		</div>
		<table width="60%" " border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="40%">
					<span class="blue_12">企业名称：</span>
				</td>
				<td>
					<select id="enterpriseid" style="width: 123px" />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td>
					<span class="blue_12">管理员名称：</span>
				</td>
				<td>
					<input type="text" id="username" class="input_text" value=""
						maxlength="20" />
						*
					<br />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td>
					<span class="blue_12">登录密码：</span>
				</td>
				<td>
					<input type="password" id="password" class="input_text" value=""
						maxlength="20" />
						*
					<br />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td>
					<span class="blue_12">重复登录密码：</span>
				</td>
				<td>
					<input type="password" id="password_chk" class="input_text"
						value="" maxlength="20" />
						*
					<br />
				</td>
			</tr>
		</table>
		<div class="div_center padding_top_10 margin_top_10">
			<input class="button_2" id="submit_b" type="button" value="确认"
				onclick="javascript:createEnterpriseAdmin();" />
			&nbsp;&nbsp;&nbsp;
			<input class="button_2" type="button" value="关闭"
				onclick="parent.parent.GB_CURRENT.hide()" />
		</div>
	</body>
	<script type="text/javascript">
inputEvent();
</script>
</html>
