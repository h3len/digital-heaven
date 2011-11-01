<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
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
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>电信管理员邮箱配置</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
   
   //得到企业id
   //分页
 //var pageid = "<%=request.getParameter("pageid") != null ? request.getParameter("pageid") : "1"%>";
   window.onload=function(){
    	//首先得到该企业下的所有用户
    	getuserbyenterpriseid();
    	}
  
  		//首先得到该企业下的所有用户
  function getuserbyenterpriseid(){
  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
    BranchAction.getRootBranchs(
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "xslt/admin_ctcc_branchmailconfig.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);	
  
  	}
  	
 	
	
	//转 到为企业用户配置邮箱页面
	function mailconfig(enterpriseid){
		//GB_showCenter("配置邮箱页面", "../mail/admin_enterpriseuser_emailconfig.jsp?userid="+userid,550,878);
	parent.location.href="admin_enterprise_mailconfig.jsp?enterpriseid="+enterpriseid;
	}
	
	function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if
		(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
	}
</script>
  </head>
  
<body>
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
<!-- Main 页面中部 -->
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left">
</div>
<!-- 右侧例表内容 -->
<div id="center_right">
	<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
	<div id="center_right_main">
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 移动邮件设置 >> 电信管理员邮箱配置</div>
</div>	
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
						<div id="divlist"></div>
			</div>
</div>
</div>
</div>
</div></div>
<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
</html>
