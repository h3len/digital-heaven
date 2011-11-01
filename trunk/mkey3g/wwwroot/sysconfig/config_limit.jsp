<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

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
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var appid = "<%=request.getParameter("appid") != null ? request.getParameter("appid"): ""%>"; 
			window.onload = function(){
				MipClientAppAction.getlimitinfo(appid,{
					callback:function(omap){
						dwr.util.setValues(omap);
 		 			}
					
				});
			}
			function modlimitconfig(){
				var reg = /^(-1)?|\d*$/;
				var smslimit = $('smslimit').value;
				var mmslimit = $('mmslimit').value;
				var smsbyday = $('smsbyday').value;
				var mmsbyday = $('mmsbyday').value;
				if(smslimit == '不限制'){
					smslimit = -1;
				}
				if(mmslimit == '不限制'){
					mmslimit = -1;
				}
				if(smsbyday == '不限制'){
					smsbyday = -1;
				}
				if(mmsbyday == '不限制'){
					mmsbyday = -1;
				}
				if(!reg.test(smslimit)){
					DHalert('短信配额必须为数字');
					return;
				}
				if(!reg.test(mmslimit)){
					DHalert('彩信信配额必须为数字');
					return;
				}
				if(!reg.test(smsbyday)){
					DHalert('短信频率必须为数字');
					return;
				}
				if(!reg.test(mmsbyday)){
					DHalert('彩信频率必须为数字');
					return;
				}
				MipClientAppAction.modlimitconfig(appid,smslimit,mmslimit,smsbyday,mmsbyday,{
					callback:function(ostring){
						if(ostring=="1"){
							DHalert('通讯能力配额配置成功！');
							parent.parent.progetclientapplist();
							return;
						}
 		 			}
					
				});
				
			}
			
		</script>
	</head>
	
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">业务系统限额</span>
		</div>
		<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">业务系统名称：</td>
			<td>
				<span id="appname"></span>
			</td>
		</tr>
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">短信月配额：</td>
			<td>
				<input type="text" id="smslimit" maxlength="20"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">短信频率：</td>
			<td>
				<input type="text" id="smsbyday" maxlength="20"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
			<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">彩信月配额：</td>
			<td>
				<input type="text" id="mmslimit" maxlength="20"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">彩信频率：</td>
			<td>
				<input type="text" id="mmsbyday" maxlength="20"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				
			</td>
			<td width="25%" style="color:red">注：</td>
			<td style="color:red">
				输入-1或不限制表示不限制
			</td>
		</tr>
	</table>
		<div id ="divlist"></div>
		<div class="div_center">
		<input type="button" value="提交"  class="button_2"  onclick="modlimitconfig();"/>
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/>
		</div>
	</body>
</html>
