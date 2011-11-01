<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_user_create_group_1 %></title>
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
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
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
//得到父部门id
 var parentid = "<%=request.getParameter("parentid")!=null?request.getParameter("parentid"):request.getSession().getAttribute("enterpriseid")%>";
  
	function createenterprise(){
			if($("enterpristname").value == ""){
				DHalert("<%= MipWebJSPUi.mipweb_user_create_group_2 %>");
				return false;
			}
			if($("comment").value.length>50){
				DHalert("<%= MipWebJSPUi.mipweb_user_create_group_3 %>");
				return false;
			}
			
			if(parentid=='-1'){
				DHalert("<%= MipWebJSPUi.mipweb_user_create_group_4 %>");
				return false;
			}
			
	  	      //开始提交数据
    BranchAction.createGroup($("enterpristname").value,$("comment").value,parentid,{
			 	callback:function(data){
					//DHalert(data);
		 			parent.parent.closePage();
				},
				errorHandler:function(errorString, exception) {
                    DHalert("<%= MipWebJSPUi.mipweb_user_create_group_5 %>"+errorString);
					}
				}
			);	
	}
	
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"><%= MipWebJSPUi.mipweb_user_create_group_6 %></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"><%= MipWebJSPUi.mipweb_user_create_group_7 %></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_user_create_group_8 %></span></td>
	 <td><input maxlength="20" type="text" id="enterpristname" value="" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/><br/></td>
	 </tr>
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_user_create_group_9 %></span></td>
	 <td><textarea id="comment" cols="50" rows="8" ></textarea></td>
	 </tr>
	 <tr><td></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_create_group_10 %>" onclick="javascript:createenterprise();"/> </td></tr>
	 </table>

  </body>
</html>
