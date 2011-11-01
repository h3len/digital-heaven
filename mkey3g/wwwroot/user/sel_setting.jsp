<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_sel_setting_1 %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
 <script type="text/javascript" src="../scripts/common.js"></script>

	<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<!--GrayBox-->
	<script type="text/javascript" src="../skin/AJS.js"></script>
	<script type="text/javascript" src="../skin/AJS_fx.js"></script>
	<script type="text/javascript" src="../skin/gb_scripts.js"></script>
	<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
	<script src="../dwr/interface/User2.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript">
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
	function self_setting(){
		//可以保存为空吧，不可以么？
		 Progress('<%= MipWebJSPUi.mipweb_user_sel_setting_2 %>','<%= MipWebJSPUi.mipweb_user_sel_setting_3 %>');
		 
		 if($('c1').value != ""){
		 if($('c1').value.replace(/\s/g,"")==""){
		 		DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_4 %>");
				return false;
		 }
		 }
		 if($('c2').value != ""){
		  if($('c2').value.replace(/\s/g,"")==""){
		 		DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_5 %>");
				return false;
		 }
		 }
		 if($('c3').value != ""){
		  if($('c3').value.replace(/\s/g,"")==""){
		 		DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_6 %>");
				return false;
		 }
		 }
		 if($('c4').value != ""){
		  if($('c4').value.replace(/\s/g,"")==""){
		 		DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_7 %>");
				return false;
		 }
		 }
		 if($('c5').value != ""){
		  if($('c5').value.replace(/\s/g,"")==""){
		 		DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_8 %>");
				return false;
		 }
		 }
		 
		 var cf=new CheckForm();
		 for(var i=1;i<=5;i++){
		 	for(var j=i+1;j<=5;j++){
		 	if(cf.Trim($('c'+i).value) != "" && cf.Trim($('c'+j).value) !=""){
			 	if(cf.Trim($('c'+i).value) == cf.Trim($('c'+j).value)){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_9 %>");
					return false;
			 	}
			 }
		 	}
		 }
		 if(checkSetting($('c1').value)){
		 	DHalert($('c1').value+"<%= MipWebJSPUi.mipweb_user_sel_setting_10 %>");
		 	return false ;
		 }
		  if(checkSetting($('c2').value)){
		 	DHalert($('c2').value+"<%= MipWebJSPUi.mipweb_user_sel_setting_11 %>");
		 	return false ;
		 }
		  if(checkSetting($('c3').value)){
		 	DHalert($('c3').value+"<%= MipWebJSPUi.mipweb_user_sel_setting_12 %>");
		 	return false ;
		 }
		  if(checkSetting($('c4').value)){
		 	DHalert($('c4').value+"<%= MipWebJSPUi.mipweb_user_sel_setting_13 %>");
		 	return false ;
		 }
		 if(checkSetting($('c5').value)){
		 	DHalert($('c5').value+"<%= MipWebJSPUi.mipweb_user_sel_setting_14 %>");
		 	return false ;
		 }
		User2.setSelf($('c1').value,$('c2').value,$('c3').value,$('c4').value,$('c5').value,{
			callback:function(objXml) {
				if(objXml=="1"){
					CloseProgress();
					DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_15 %>");
				}else{
					CloseProgress();
					DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_16 %>"+objXml);
				}
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_17 %>"+errorString);
			}
		});
	
	}
	function self_getting(){
		Progress('<%= MipWebJSPUi.mipweb_user_sel_setting_18 %>','<%= MipWebJSPUi.mipweb_user_sel_setting_19 %>');
		User2.getSelf({
			callback:function(omap) {
				dwr.util.setEscapeHtml(false);
				CloseProgress();
				dwr.util.setValues(omap);
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%= MipWebJSPUi.mipweb_user_sel_setting_20 %>"+errorString);
			}
		});
	
	}
	window.onload=function(){
		self_getting();
	}
	function checkSetting(stt){
		if(stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_21 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_22 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_23 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_24 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_25 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_26 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_27 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_28 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_29 %>'||stt=='<%= MipWebJSPUi.mipweb_user_sel_setting_30 %>'){
			return true;
		}
		return false;
	}
</script>
</head>
<body>
<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true"/>

<!-- begin center -->
<div id="center">

	<div id="center_left" class="center_left">

	</div>

	<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<!-- 中部主要内容开始 -->

<div id="center_nav_box">
            <div id="center_nav"><%= MipWebJSPUi.mipweb_user_sel_setting_31 %></div>
        </div>

		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_sel_setting_32 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="16%">
					<%= MipWebJSPUi.mipweb_user_sel_setting_33 %>			</td>
				<td width="81%">
				<input type="text" maxlength="10"  id="c1" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="16%">
					<%= MipWebJSPUi.mipweb_user_sel_setting_34 %>			</td>
				<td width="81%">
				<input type="text" maxlength="10" id="c2" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="16%">
					<%= MipWebJSPUi.mipweb_user_sel_setting_35 %>				</td>
				<td width="81%">
				<input type="text" maxlength="10" id="c3" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="16%">
					<%= MipWebJSPUi.mipweb_user_sel_setting_36 %>			</td>
				<td width="81%">
				<input type="text" maxlength="10" id="c4" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>				</td>
			</tr>
			
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="16%">
					<%= MipWebJSPUi.mipweb_user_sel_setting_37 %>				</td>
				<td width="81%">
			  <input type="text" maxlength="10" id="c5" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td class="padding_5"><input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_sel_setting_38 %>" onclick ="self_setting()" /></td>
		  </tr>
		</table>
</div>
	</div>
</div>

<div class="clear"></div>
<!--Bottom Include-->
<jsp:include page="bottom.jsp" flush="true"/>
<!--Bottom Include-->
</body>
</html>
