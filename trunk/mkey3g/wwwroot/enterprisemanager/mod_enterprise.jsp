<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>top.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail")==null)
		{
			out.print("<script>top.location.href='../default_admin.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail");
			if(list == null || list.size() == 0)
			{
				out.print("<script>top.location.href='../default_admin.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				return;
			}
		}
	}
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>发送设置短信</title>
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
//企业id
var eid = "<%=request.getParameter("eid") != null ? request.getParameter("eid") : ""%>";
		window.onload=function(){
			if(!<%=Constants.canoperateapp %>){
				document.getElementById("logincode").disabled="disabled" ;
			}
		showEnterpriseByid(eid);
		}
	function showEnterpriseByid(eid){
	  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
    EnterpriseAction.showEnterpriseByid(eid,{
					callback:function(oMap) {
						CloseProgress();
						if(oMap["hasMultiCheck"])
			 			$("multiCheck").style.display="";
			 			else
			 			$("multiCheck").style.display="none";
						DWRUtil.setValues(oMap);
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("操作失败，失败原因："+errorString);
					}
			});	
	}
	
	//保存修改后企业信息
	function modenterprise(){
		cf = new CheckForm();
		var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
			if(cf.Trim($("enterpristname").value) == ""){
				DHalert("请输入企业名称！");
				return false;
			}

			if(cf.Trim($("shortname").value) == ""){
				DHalert("请输入企业简称！");
				return false;
			}
			if(cf.Trim($("logincode").value) == ""){
				DHalert("请输入企业代码！");
				return false;
			}
			if(cf.Trim($("branchdisksize").value) == ""){
				DHalert("请输入公共区磁盘空间！");
				return false;
			}
			if(!cf.IsNumber($("branchdisksize").value)){
				DHalert("公共区磁盘空间必须为数字！");
				return false;
			}
			if(cf.Trim($("persondisksize").value) == ""){
				DHalert("请输入个人区磁盘空间！");
				return false;
			}
			if(!cf.IsNumber($("persondisksize").value)){
				DHalert("个人区磁盘空间必须为数字！");
				return false;
			}
				
	        if($("serverip").value==""){
	        	DHalert("服务器ip不能为空！");
		        return;
	        }
	        if(!reg.test($("serverip").value)){
	        	DHalert("服务器ip格式不正确！");
		        return;
	        }
	  	       //开始提交数据
  	 		Progress("数据正在载入...","提示");
   			EnterpriseAction.modEnterprise(eid,cf.Trim($("enterpristname").value),cf.Trim($("shortname").value),cf.Trim($("logincode").value),cf.Trim($("comment").value),
			 	cf.Trim($("branchdisksize").value),cf.Trim($("persondisksize").value),$("serverip").value,
	 			false,false,false,false,
	 			function(data){
			 	   if(data == "1"){
			 	   		CloseProgress();
			 	   		DHalert("修改成功");
		 				parent.parent.closePage();
			 	   	}else{
			 	   		DHalert(data);
						return false;
			 	   	}
				}
			);	
	}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold">企业管理</span></div>
	<div class="up_subtitle" ><span class="blue_12_bold">修改企业详情</span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td align="right"><span class="blue_12">企业名称：</span></td>
	 <td><input type="text" id="enterpristname" value="" class="input_text" maxlength="20"/>
	 *
	 </td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">企业简称：</span></td>
	 <td><input type="text" id="shortname" value="" class="input_text" maxlength="20"/>
	 *
	 </td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">企业代码：</span></td>
	 <td><input type="text" id="logincode" value="" class="input_text" maxlength="20"/>
	 *
	 </td>
	 </tr>
	 <tr style="display:none">
	 <td align="right"><span class="blue_12">文件柜公共区磁盘空间：</span></td>
	 <td><input type="text" class="input_text" id="branchdisksize"  maxlength="7"/>
	 MB *
	 <br/></td>
	 </tr>
	  <tr style="display:none">
	 <td align="right"><span class="blue_12">文件柜个人区磁盘空间：</span></td>
	 <td><input type="text" class="input_text" id="persondisksize"  maxlength="7"/>
	 MB *
	 <br/></td>
	 </tr>
	 <tr>
		<td align="right">
			<span class="blue_12">服务器地址：</span>
		</td>
		<td>
			<input type="text" id="serverip" value=""
				class="input_text" onmouseover="fEvent('mouseover',this)"
				onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
				onmouseout="fEvent('mouseout',this)" maxlength="20" disabled="disabled" />
			*
		</td>
	</tr>
	<tr id="multiCheck" style="display:none">
		<!--<td align="right">
			<span class="blue_12">三重校验配置：</span>
		</td>
		<td>
			<input type="checkbox" id="chkIsForceCheck" />强制校验<br/>
			<input type="checkbox" id="chkIsAuToBanding" />自动更新<br/>
			<input type="checkbox" id="chkEnableImeiCheck" />绑定手机信息<br/>
			<input type="checkbox" id="chkEnableImsiCheck" />绑定SIM卡信息
		</td>-->
	</tr>
	  <tr>
	 <td align="right"><span class="blue_12">备注：</span></td>
	 <td><textarea id="comment" cols="40" rows="8" ></textarea></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="提交" onclick="javascript:modenterprise();"/> </td></tr>
	 </table>

  </body>
<script type="text/javascript">
inputEvent();
</script>
</html>
