<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebMoreUi.mip_period_user_2 %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
	
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/MipAppPeriodAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
	 <!-- 新的时间控件 -->
		<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="../skin/calendar/lang/calendar-zh.js"></script>
		<link href="../skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="../skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="../skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
		
		<script type="text/javascript">
			var appid = "<%=request.getParameter("appid") != null ? request.getParameter("appid"): ""%>"; 
			var appname = "<%=request.getParameter("appname") != null ? request.getParameter("appname"): ""%>"; 
			window.onload = function(){
				MipAppPeriodAction.getAppPeriodinfo(appid,appname,{
					callback:function(omap){
						dwr.util.setValues(omap);
 		 			}
					
				});
			}
			function modAppPeriod(){
				if($('period').value.Trim()=="" || $('period').value.Trim()==null)
			    {
			      DHalert("<%= MipWebMoreUi.mip_period_user_4 %>");
			      return;
			     }
				if($('period').value.Trim() != ""&&!IsValidDate($('period').value))
			    {
			      DHalert("<%= MipWebMoreUi.mip_period_user_5 %>");
			      return;
			     }
				MipAppPeriodAction.mergeMipAppPeriod(appid,$('period').value,{
					callback:function(ostring){
						if(ostring=="1"){
							DHalert("<%= MipWebMoreUi.mip_period_user_6 %>");
							parent.parent.progetclientapplist();
							parent.parent.GB_CURRENT.hide();
						}
 		 			},
 		 			errorHandler:function(errorString, exception) {
					 DHalert(exception.message);
					}					
				});
				
			}
			
		</script>
	</head>
	
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue"><%= MipWebMoreUi.mip_period_user_7 %></span>
		</div>
		<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24"><%= MipWebMoreUi.mip_period_user_8 %></td>
			<td>
				<input type="text" id="appname" maxlength="50" class="input_text"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" readonly="true"/>
			</td>
		</tr>
		<tr>
			<td width="30%">
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%"><%= MipWebMoreUi.mip_period_user_9 %></td>
			<td>
				<input name="period" type="text" id="period" />
				<img alt='<%= MipWebMoreUi.mip_period_user_10 %>'
					src='../skin/calendar/themes/icons/calendar2.gif' border='0'
					id='periodTime' onMouseOver="this.style.cursor='pointer'"
					onmouseout="this.style.cursor='default'" />
				<script type="text/javascript">
						var cal1 = new Zapatec.Calendar.setup({
						
						inputField     :    "period",     // id of the input field
						singleClick    :     false,     // require two clicks to submit
						ifFormat       :    '%Y-%m-%d',     // format of the input field
						showsTime      :     true,     // show time as well as date
						button         :    "periodTime"  // trigger button 
				
						});
				</script>
				<span class="star">*</span>
			</td>
		</tr>
	</table>
		<div id ="divlist"></div>
		<div class="div_center">
		<input type="button" value="<%= MipWebMoreUi.mip_period_user_11 %>"  class="button_2"  onclick="modAppPeriod();"/>
		<input type="button" value="<%= MipWebMoreUi.mip_period_user_12 %>"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/>
		</div>
	</body>
</html>
