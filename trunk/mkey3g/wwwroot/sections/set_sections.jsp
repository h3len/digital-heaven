<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_sections_set_sections_1 %></title>
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
		<script src="../dwr/interface/Mas2.js" type="text/javascript"></script>
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
			function getSectionsLength(){
				Mas2.getSectionsLength(
				{
					callback:function(oMap) {
						dwr.util.setValues(oMap);
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_sections_set_sections_2 %>"+errorString);
					}
				}
				);
			}
			function setSectionsLength(){
				var reg=/^\d$/;
				if($('sections_length').value>6){
					DHalert("<%= MipWebJSPUi.mipweb_user_set_sections_1 %>");
					return false;
				}
				if(!reg.test($('sections_length').value)){
					DHalert("<%= MipWebJSPUi.mipweb_sections_set_sections_3 %>");
					return false;
				}
				Mas2.setSectionsLength($('sections_length').value,
				{
					callback:function(obj) {
						if(obj=="1"){
							parent.parent.GB_CURRENT.hide();
							parent.parent.DHalert("<%= MipWebJSPUi.mipweb_sections_set_sections_4 %>");
						}else{
							DHalert("<%= MipWebJSPUi.mipweb_sections_set_sections_5 %>"+obj);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_sections_set_sections_6 %>"+errorString);
					}
				}
				);
			}
			window.onload=function(){
				getSectionsLength();
			}
		</script>
</head>
  
<body>
 	<div><font color=#ff0000> </font></div>
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	
	 <br></br>
	 <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_sections_set_sections_7 %></span></td>
	 <td><input type="text" id="sections_length" value="" maxlength="25"/>
	 <input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_sections_set_sections_8 %>" onclick="javascript:setSectionsLength();"/>
	 </td>
	 </tr>
	 
	 <br></br>
	 
	 </table>
  </body>
</html>
