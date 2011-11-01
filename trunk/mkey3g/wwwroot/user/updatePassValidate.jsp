<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipMobileType"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
		    var GB_ROOT_DIR = "../skin/";
		</script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">			
			function updatePassValidate(){
				var reg = /^(\+)?(\d)+$/
				if($('passLength').value == ''){
					DHalert("<%= MipWebMoreUi.mip_user_updatePassValidate_1 %>");
					return false;
				}
				if(!reg.test($('passLength').value)){
					DHalert("<%= MipWebMoreUi.mip_user_updatePassValidate_2 %>");
					return false;
				}
				if($('passLength').value.length == 2 && (!$('passLength').value.indexOf('0'))){
					DHalert("<%= MipWebMoreUi.mip_user_updatePassValidate_3 %>");
					return false;
				}
				if($('passLength').value >20||$('passLength').value==0){
					DHalert("<%= MipWebMoreUi.mip_user_updatePassValidate_4 %>");
					return false;
				}
				User2.updatePassValidate($('passLength').value,{
					callback:function(objMap){
						dwr.util.setValues(objMap);
					},
					errorHandler:function(errorString, exception) {
					    DHalert(""+errorString);
					    return;
					}
				});
				DHalert("<%= MipWebMoreUi.mip_user_updatePassValidate_5 %>");
			}
			
			window.onload=function(){
				User2.getPassValidate({
					callback:function(objMap){
						dwr.util.setValues(objMap);
					},
					errorHandler:function(errorString, exception) {
					    DHalert(""+errorString);
					}
				});
			}
		</script>
	</head>
	<body style="width: 100%;"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebMoreUi.mip_user_updatePassValidate_6 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebMoreUi.mip_user_updatePassValidate_7 %></span>
		</div>
		<table class="table_reg" width="40%" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<tbody id="user_table">
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="30%">
						<%= MipWebMoreUi.mip_user_updatePassValidate_8 %>
					</td>
					<td width="69%">
						<input type="text" id="passLength" maxlength="2" class="input_text"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
						<%= MipWebMoreUi.mip_user_updatePassValidate_9 %>
					</td>
				</tr>
				
			</tbody>
		</table>

		<div class="div_center padding_top_10 margin_top_10">
			<input class="button_2" type="button" value="<%= MipWebMoreUi.mip_user_updatePassValidate_10 %>" onclick="updatePassValidate()" />
			&nbsp;&nbsp;&nbsp;
			<input class="button_2" type="button" value="<%= MipWebMoreUi.mip_user_updatePassValidate_11 %>"
				onclick="parent.parent.GB_CURRENT.hide()" />
		</div>

	</body>
</html>
