<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_user_enableuser_1 %></title>
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
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
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
		var userid = '<%=request.getParameter("userid")%>';
		var branchid = '<%=request.getParameter("branchid")%>';
		function enableuser(){
			if($('pwd').value.length<8){
				DHalert("<%= MipWebJSPUi.mipweb_user_enableuser_2 %>");
				return false;
			}
			if($('pwd').value!=$('repwd').value){
				DHalert("<%= MipWebJSPUi.mipweb_user_enableuser_3 %>");
				return false;
			}
			 User2.enableuser(userid,branchid,$('username').value,$('pwd').value,
			{
				callback:function(otext) {
					if(otext=='1'){
						DHalert("<%= MipWebJSPUi.mipweb_user_enableuser_4 %>");
					    parent.parent.ChangePage(parent.parent.pageid);
						parent.parent.GB_CURRENT.hide()
					}else{
						DHalert("<%= MipWebJSPUi.mipweb_user_enableuser_5 %>"+otext);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_enableuser_6 %>"+errorString);
				}
			});
		}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td align="right"><span class="blue_12"><%= MipWebJSPUi.mipweb_user_enableuser_9 %></span></td>
	 <td><input type="password" id="pwd" value="" /></td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12"><%= MipWebJSPUi.mipweb_user_enableuser_10 %></span></td>
	 <td><input type="password" id="repwd" value="" /></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_enableuser_11 %>" onclick="javascript:enableuser();"/> </td></tr>
	 </table>

  </body>
</html>
