
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    <title>角色管理-<%=ServerConfig.ALL_PAGE_TITLE %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css">
	<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled">
	<!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />				
	<script language="javascript" type="text/javascript" src="../datepicker/WdatePicker.js"></script>		
	<!--GrayBox-->
	<script type="text/javascript">
		var GB_ROOT_DIR = "../skin/";
	</script>
	<script type="text/javascript" src="../skin/AJS.js"></script>
	<script type="text/javascript" src="../skin/AJS_fx.js"></script>
	<script type="text/javascript" src="../skin/gb_scripts.js"></script>
	<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../scripts/archievelib.js"></script>
	<!-- 新的时间控件 -->
	<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
	<script type="text/javascript" src="../skin/calendar/lang/calendar-zh.js"></script>
	<link href="../skin/calendar/css/zpcal.css" rel="stylesheet" type="text/css" />
	<link href="../skin/calendar/website/css/template.css" rel="stylesheet" type="text/css" />
	<link href="../skin/calendar/themes/winxp.css" rel="stylesheet" type="text/css" />
	<!-- Dwr Js -->
	<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>	
	<script type="text/javascript">
	
	
	var username ="<%=session.getAttribute("username")%>";
//关闭左侧菜单 by Gaojingliang 
// 该死的高老板 mod by wl
	var pageid=1;
	function showmenu(){
		document.getElementById("center_left").style.display='block';
		document.getElementById("center_left").className = "center_left";
		document.getElementById("center_right").style.width = "77%";
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
	window.onload=function(){
		getrolelist();
		
		if(username=="emaadmin"){
		$('addrole').disabled=true;
		}
		
	}
	function getrolelist(){
		Progress('正在获取角色列表.......','登录中'); 
		RoleAction.GetRoleList({
				callback:function(objXml) {
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../xslt/admin_role_list.xsl",document.getElementById("divlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("获取角色列表失败，失败原因："+errorString);
				}
		}			
		);
	}
	function RoleShow(roleid){
		GB_showCenter("角色详情", "../role/roleshow.jsp?roleid="+roleid,550,878);
	}
	function add_role(){
		GB_showCenter("新建角色", "../role/addrole.jsp",550,878);
	}
	function closepage(){
		getrolelist();
		GB_CURRENT.hide();
	}
	
	</script>
</head>
 
<body>
<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true" />
<!--Top Include-->
<div id="center">

<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left">
 
			
</div>


<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main" class="border_blue">
	

<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 系统管理 >> 角色管理 </div>
</div>
<div>
	<div  style="float:right">
		<input type="button" class="button_4" value="新增角色"  onclick="add_role()" />
	</div>		
</div>
<div id="divlist"></div>

  </div>
</div>
</div>

		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>