<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<%@page import="com.dheaven.mip.util.PermissionHelper"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipUserPrivacy"%>

<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    <title> <%= MipWebJSPUi.mipweb_user_personalgroup_1 %>-<%=ServerConfig.ALL_PAGE_TITLE %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
		<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />				
	<script language="javascript" type="text/javascript" src="../datepicker/WdatePicker.js"></script>		
	<script src="../dwr/interface/Mas2.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>
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
	
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
	<script type="text/javascript">
	
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
	var tabPane;
    var ab=[[showuserlist,'<%= MipWebJSPUi.mipweb_user_personalgroup_2 %>'],[getpersonalgrouplist,'<%= MipWebJSPUi.mipweb_user_personalgroup_3 %>'],[selfsetting,'<%= MipWebJSPUi.mipweb_user_personalgroup_4 %>']];
	
	window.onload=function(){
		getpersonalgrouplist();
		DHTabPanel(ab,900,1,"tabs");
	}
	function selfsetting(){
		window.location.href="../user/personal_sel_setting.jsp"
	}
	function showuserlist(){
		window.location.href="../user/personaluser.jsp";
	}
	function ChangePage(pid){
		pageid = pid;
		getpersonalgrouplist();
	}
	function getpersonalgrouplist(){
		User2.getpersonalgrouplist(pageid,{
			callback:function(objXml) {
				DisplayTransformedXML(1, objXml, "../user/xslt/pergrouplist.xsl",document.getElementById("userlist"));
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%= MipWebJSPUi.mipweb_user_personalgroup_5 %>"+errorString);
			}
		});
	}
	function showgroup(groupid){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_personalgroup_6 %>", "../user/showgroup.jsp?groupid="+groupid,550,878);
	}
	function modgroup(groupid){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_personalgroup_7 %>", "../user/modgroup.jsp?groupid="+groupid,550,878);
	}
	function delgroup(gourpid){
 	
 		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_personalgroup_8 %>', function(btn){
					if(btn=='yes'){
							User2.delPersonalGroup(gourpid,
							{
								callback:function(otext){
									if(otext=='1'){
										DHalert("<%= MipWebJSPUi.mipweb_user_personalgroup_9 %>");
										ChangePage(pageid);
									}else{
										DHalert("<%= MipWebJSPUi.mipweb_user_personalgroup_10 %>"+otext);
									}
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("<%= MipWebJSPUi.mipweb_user_personalgroup_11 %>"+errorString);
								}
							});					
							}
						}
						);
 			
 
 }
  function add_group(){
 	GB_showCenter("<%= MipWebJSPUi.mipweb_user_personalgroup_12 %>", "../user/addgroup.jsp",550,878);	
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
<div id="center_right_main">
	
<!-- 中部主要内容开始 -->
<table  style="display:none" width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/theme/images/alert_bg.gif">
  <tr>
    <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
    <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
    <td width="90%"><a href="../minioa/admin_default.jsp"><%= MipWebJSPUi.mipweb_user_personalgroup_13 %><span class="red" id="oatodo">0</span><%= MipWebJSPUi.mipweb_user_personalgroup_14 %></a></td>
    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="/theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
  </tr>
</table>
<div id="tabs"></div>
<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav"><%= MipWebJSPUi.mipweb_user_personalgroup_15 %><a href="../user/personalgroup.jsp"> <%= MipWebJSPUi.mipweb_user_personalgroup_16 %> </a></div>
</div>

<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #CAD7DF;">
  <tr>
       <td width="99%" valign="top"><div style="margin:0px;padding:0px;clear:both"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="5" class="title"><%= MipWebJSPUi.mipweb_user_personalgroup_17 %></td>
        </tr>
      <tr>
        <td colspan="5">
<table width="100%">
		 	<tr>
			<td colspan="5">
				<div class="submenu">
				
				<a href="#" onclick="add_group()"><%= MipWebJSPUi.mipweb_user_personalgroup_18 %></a>
				
				</div>			
			</td>

        </tr>
      <tr>
        <td colspan="5">
        <div id="userlist"></div>
		</td>
        </tr>
      
    </table>
		</td>
  </tr>
</table>
  </div>
</div>

		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>