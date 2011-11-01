<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
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

	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
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
//企业id
var eid = "<%=request.getParameter("eid") != null ? request.getParameter("eid") : ""%>";
		window.onload=function(){
		showEnterpriseByid(eid);
		}
	function showEnterpriseByid(eid){
			
	
	  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
    EnterpriseAction.showEnterpriseByid(eid,
			 	function(data){
			 		CloseProgress();
			 		if(data["hasMultiCheck"])
			 			$("multiCheck").style.display="";
			 		else
			 			$("multiCheck").style.display="none";
					dwr.util.setValues(data);
				}
			);	
	}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold">企业管理</span></div>
	<div class="up_subtitle" ><span class="blue_12_bold">企业详情</span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td align="right"><span class="blue_12">企业名称：</span></td>
	 <td id="enterpristname"></td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">企业简称：</span></td>
	 <td id="shortname"></td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">企业代码：</span></td>
	 <td id="logincode"></td>
	 </tr>
	 <tr>
	 <td align="right"><span class="blue_12">文件柜公共区磁盘空间：</span></td>
	 <td><input type="text" class="input_text" id="branchdisksize" disabled="disabled"  maxlength="7"/>
	 MB *
	 <br/></td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">文件柜个人区磁盘空间：</span></td>
	 <td><input type="text" class="input_text" id="persondisksize" disabled="disabled"  maxlength="7"/>
	 MB *
	 <br/></td>
	 </tr>
	 <tr>
	  <tr>
		<td align="right">
			<span class="blue_12">服务器ip：</span>
		</td>
		<td id="serverip"></td>
	</tr>
	<tr id="multiCheck" style="">
		<td align="right">
			<span class="blue_12">三重校验配置：</span>
		</td>
		<td>
			<input type="checkbox" id="chkIsForceCheck" disabled="disabled" />强制校验<br/>
			<input type="checkbox" id="chkIsAuToBanding" disabled="disabled" />自动校验<br/>
			<input type="checkbox" id="chkEnableImeiCheck" disabled="disabled" />绑定手机信息<br/>
			<input type="checkbox" id="chkEnableImsiCheck" disabled="disabled" />绑定SIM卡信息
		</td>
	</tr>
	 <tr>
	 <td align="right"><span class="blue_12">创建时间：</span></td>
	 <td id="createtime"></td>
	 </tr>
	 <tr>
	 <td align="right"><span class="blue_12">备注：</span></td>
	 <td id="comment"></td>
	 </tr>
	 
	 </table>

  </body>
</html>
