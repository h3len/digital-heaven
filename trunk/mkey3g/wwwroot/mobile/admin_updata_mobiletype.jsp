<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<% 
    String username;
    if(request.getParameter("username") == null) {
       username = "";
    } else {
			username=new String(request.getParameter("username").getBytes("8859_1"),"utf-8");
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_1 %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link type="text/css" rel="stylesheet" href="css.css" />
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
	<!--GrayBox-->
	<script type="text/javascript" src="../skin/AJS.js"></script>
	<script type="text/javascript" src="../skin/AJS_fx.js"></script>
	<script type="text/javascript" src="../skin/gb_scripts_main.js"></script>
	<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

	<!-- Dwr Js -->
	<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>

	<script language="javascript" src="../scripts/selall.js"></script>
	<script type="text/javascript" src="../scripts/tabpane.js"></script>		
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
	<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css">
	<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled">
<script type="text/javascript">
  
		 var id;
         var path=location.href;
         if(path.indexOf("?")>-1)
                 {
          id=path.substring(path.lastIndexOf("=")+1);
                 }
  
	   	//初始化
	 var flag =0;
			window.onload=function(){
	 if(flag==0){
		 getOneMobiletype(id);
		 }
		 flag=1;
	}
		

		//列出一条手机型 号信息
		function getOneMobiletype(id)
		{
		    MobileAction.getOneMobileType(id,{
		    callback:function(data){
				   dwr.util.setEscapeHtml(false);
				   dwr.util.setValues(data);
		       },
		     errorHandler:function(errorString, exception) {
					parent.parent.DHalert(errorString);
				}
			});
		}



		//修改一条手机型 号
     function addMobiletype()
     {
         var cf=new CheckForm();
     	 if(cf.Trim($('mobiletyep').value)==""){
					DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_2 %>");
					return false;
			     }
	     var reg =/^\d*$/;
	     /*
	    if($('width').value==""){
					DHalert("屏幕宽度不能为空！");
					return false;
		     }
	     if($('height').value==""){
	     	DHalert("屏幕高度不能为空！");
					return false;
     	 }
	     if(!reg.test($('width').value)||!reg.test($('height').value)){
	     	DHalert("手机宽高必须为有效数字！");
					return false;
	     }
	     */
	     if(cf.Trim($('width').value)==""){
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_3 %>");
				return false;
     }
     if(!reg.test($('width').value)){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_4 %>");
				return false;
     }
     if($('width').value==0){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_5 %>");
				return false;
     }
     if(cf.Trim($('height').value)==""){
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_6 %>");
				return false;
     }
     if(!reg.test($('height').value)){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_7 %>");
     	return false;
     }
     if($('height').value==0){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_8 %>");
     	return false;
     }
     if(cf.Trim($('ua').value)==""){
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_9 %>");
				return false;
		    }
    
       	var brief = $('brief').value;
				if(brief.length > 50){
					Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_10 %>', function(btn){
									if(btn=='yes'){
										brief = brief.substring(0,50);
											Progress('<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_11 %>','<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_12 %>'); 
									    	 MobileAction.updataMobileTypeByid(id,$('mobiletyep').value,$('width').value,$('height').value,$('ua').value,$('manufactory').value,$('languagecode').value,$('model').value,brief,$("opsystem").value,
												{
													callback:function(data){
														CloseProgress();
														parent.parent.closewindow(); 
													},
													errorHandler:function(errorString,exception){
														DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_13 %>"+exception.message);
													}
									            });
										
									}else{
									 	return false;
									}
								}
					);				
				}else{
						Progress('<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_14 %>','<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_15 %>'); 
				    	 MobileAction.updataMobileTypeByid(id,$('mobiletyep').value,$('width').value,$('height').value,$('ua').value,$('manufactory').value,$('languagecode').value,$('model').value,brief,$("opsystem").value,
						{
							callback:function(data){
								CloseProgress();
								parent.parent.closewindow(); 
							},
							errorHandler:function(errorString,exception){
								DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_16 %>"+exception.message);
							}
			            });
				}
     
     }
</script>
  </head>
  <body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		 <!-- 内容开始 -->
		 
		 <table wideh="80%" align="center">
		 <tr>
  	<td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_17 %></span></td><td><input type="text" id="mobiletyep" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" tabindex="1" maxlength="20"></td></tr>
		<tr>
		<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_18 %></span></td><td><input type="text" id="width" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="3"></td></tr>
			<tr>
		<td>							
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_19 %></span></td><td><input type="text" id="height" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="3"></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold">UA：</span></td><td><input type="text" id="ua" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="25"></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_20 %></span></td><td><input type="text" id="manufactory" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_21 %></span></td><td>
 		<select id="opsystem">
 		<option value="brew">brew</option>
 		<option value="wince">wince</option>
 		<option value="windows mobile">windows mobile</option>
 		</select></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_22 %></span></td><td><input type="text" id="languagecode" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="5"></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_23 %></span></td><td><input type="text" id="model" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_24 %></span></td><td><textarea type="textarea" id="brief" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"
										 style="height:60px;"></textarea></td></tr>
										</table>
										<table wideh="80%" align="center">
			<tr><td>	
  <input type="button" id="com" class="button_2" value="<%= MipWebJSPUi.mipweb_mobile_admin_updata_mobiletype_25 %>"  onclick="javascript:addMobiletype()">
  </td></tr>
  </table>
  </body>
</html>
