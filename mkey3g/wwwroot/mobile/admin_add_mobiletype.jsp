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
    <title><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_1 %></title>
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
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css">
		<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled">
<script type="text/javascript">
	 var cf = new CheckForm()

//添加一条手机型 号
     function addMobiletype()
     {
     	var mobiletyep = cf.Trim($('mobiletyep').value);
     	var width = cf.Trim($('width').value);
     	var height = cf.Trim($('height').value);
     	var ua = cf.Trim($('ua').value);
      if(mobiletyep ==""){
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_2 %>");
				return false;
     		  }
     var reg =/^\d*$/;
     if(width==""){
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_3 %>");
				return false;
     }
     if(!reg.test(width)){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_4 %>");
				return false;
     }
     if(width==0){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_5 %>");
				return false;
     }
     if(height==""){ 
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_6 %>");
				return false;
     }
     if(!reg.test(height)){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_7 %>");
     	return false;
     }
     if(height==0){
     	DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_8 %>");
     	return false;
     }
    // if(!reg.test($('width').value)||$('width').value==0||!reg.test($('height').value)||$('height').value==0){
		//		DHalert("手机宽高必须为有效数字！");
			//	return false;
		     //}
     
     if(ua ==""){     	
				DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_9 %>");
				return false;
		     }
    
     var brief = $('brief').value;
			if(brief.length > 50){
			Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_10 %>', function(btn){
							if(btn=='yes'){
								brief = brief.substring(0,50);
								Progress('<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_11 %>','<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_12 %>'); 
							     MobileAction.createMobiletype(mobiletyep,width,height,ua,$('manufactory').value,$('languagecode').value,$('model').value,brief,$("opsystem").value,
										{
											callback:function(data){
												if(data=="1")
												{
													CloseProgress();
													parent.parent.closewindow(); 
												}
												else
												{
												DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_13 %>"+data);
												}              
											},
											errorHandler:function(errorString,exception){
												DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_14 %>"+exception.message);
											}
							            });
							}else{
								return false;
							}
				}
			);
		}else{
			Progress('<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_15 %>','<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_16 %>'); 
		     MobileAction.createMobiletype(mobiletyep,width,height,ua,$('manufactory').value,$('languagecode').value,$('model').value,brief,$("opsystem").value,
					{
						callback:function(data){
							if(data=="1")
							{
								CloseProgress();
								parent.parent.closewindow(); 
							}
							else
							{
							DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_17 %>"+data);
							}              
						},
						errorHandler:function(errorString,exception){
							DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_18 %>"+exception.message);
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
		<td>
  	<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_19 %></span></td><td><input type="text" id="mobiletyep"  maxlength="20"class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
 		<tr><td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_20 %></span></td><td><input type="text" id="width" maxlength="3" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
 		<tr><td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_21 %></span></td><td><input type="text" id="height" maxlength="3" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
 		<tr><td><span class="href_12px_blue_bold">UA：</span></td><td><input type="text" id="ua" maxlength="25" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*</td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_22 %></span></td><td><input type="text" id="manufactory" maxlength="30" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_23 %></span></td>
 		<td>
 		<select id="opsystem">
 		<option value="brew">brew</option>
 		<option value="wince">wince</option>
 		<option value="windows mobile">windows mobile</option>
 		<option value="Symbian S603">Symbian S603</option>
 		<option value="Symbian S605">Symbian S605</option>
 			<option value="Symbian S605">Iphone</option>
 				<option value="Symbian S605">Android</option>
 					<option value="Symbian S605">OMS</option>

 		</select>
 		</td></tr>
							   	<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_24 %></span></td><td><input type="text" id="languagecode" maxlength="5" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_25 %></span></td><td><input type="text" id="model" maxlength="20" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/></td></tr>
										<tr>
										<td>
 		<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_26 %></span></td><td><textarea type="textarea" id="brief"
										class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:50px"></textarea></td></tr>
										</table>
	<table wideh="80%" align="center">
	<tr><td>
  <input type="button" id="com" class="button_2" value="<%= MipWebJSPUi.mipweb_mobile_admin_add_mobiletype_27 %>"  onclick="javascript:addMobiletype()">
  </td></tr>
  </table>
  </body>
</html>
