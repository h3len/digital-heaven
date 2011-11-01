<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_sections_admin_mod_sections_1 %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />	
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts_main.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
	
		<!-- Dwr Js -->
		<script src="../dwr/interface/SectionsAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css">
		<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled">
<script type="text/javascript">
	var extend_length=<%=com.dheaven.mip.plugin.sections.vo.MipSections.EXTENDS_NUM_LENGTH%>;
	var id='<%=request.getParameter("id")%>';
	window.onload=function(){
		for(var i=1;i<=extend_length;i++){
			var oOption = document.createElement("OPTION");
			oOption.text = i;
			oOption.value =i;			
			document.all?$('sections_type').add(oOption):$('sections_type').appendChild(oOption);
		}
		getSections();
	}
	
	function getSections(){
		SectionsAction.getSection(id,{
					callback:function(oMap) {
						dwr.util.setValues(oMap);
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_2 %>"+errorString);
					}
				});
	}
//添加一条手机型 号
   function modSection(){
   				var reg = /^\d*$/;
   				if(!reg.test($('startnum').value)){
   					DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_3 %>");
   					return;
   				}
   				if(!reg.test($('endnum').value)){
   					DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_4 %>");
   					return;
   				}
   				if($('startnum').value.length!=$('sections_type').value||$('endnum').value.length!=$('sections_type').value){
   					DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_5 %>");
   					return;
   				}
   				if($('startnum').value>$('endnum').value){
   					DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_6 %>");
   					return;
   				}
   				Progress('<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_7 %>','<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_8 %>'); 
				SectionsAction.modSection(id,$('startnum').value,$('endnum').value,{
					callback:function(objxml) {
						if(objxml==1){
							CloseProgress();
							parent.parent.closewindow(); 
						}else{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_9 %>"+objxml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_10 %>"+errorString);
					}
				});
   }
</script>
  </head>
  <body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		 <!-- 内容开始 -->
		<table wideh="80%" align="center">
		<tr style="display:none">
		<td>
  	<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_sections_admin_mod_sections_11 %></span></td><td><select id="sections_type"></select>*</td></tr>
 		<tr><td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_sections_admin_mod_sections_12 %></span></td><td><input type="text" id="startnum" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
 		<tr><td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_sections_admin_mod_sections_13 %></span></td><td><input type="text" id="endnum" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
 		
										</table>
	<table wideh="80%" align="center">
	<tr><td>
  <input type="button" id="com" class="button_2" value="<%= MipWebJSPUi.mipweb_sections_admin_mod_sections_14 %>"  onclick="javascript:modSection()">
  </td></tr>
  </table>
  </body>
</html>
