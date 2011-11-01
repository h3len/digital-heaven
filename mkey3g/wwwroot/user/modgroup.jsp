<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

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
			var groupid = '<%=request.getParameter("groupid")%>';
			function showBranch(){
			  Progress('<%= MipWebJSPUi.mipweb_user_modgroup_1 %>','<%= MipWebJSPUi.mipweb_user_modgroup_2 %>');
			  User2.getPersonalGroup(groupid,
					{
						callback:function(oMap) {
							CloseProgress();
							if(oMap["groupname"]==""){
								Ext.Msg.alert("<%= MipWebJSPUi.mipweb_user_modgroup_3 %>","<%= MipWebJSPUi.mipweb_user_modgroup_4 %>",function(){
														top.GB_hide();
								});
								return;
							}
							dwr.util.setEscapeHtml(false);
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_5 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				showBranch();
			}
			function modgroup(){
				 if($('groupname').value==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_6 %>");
				 	 return false;
				 }
				 var comment = $('comment').value;
				 if(comment.length>20){
				 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_modgroup_7 %>', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,20);	
							 Progress('<%= MipWebJSPUi.mipweb_user_modgroup_8 %>','<%= MipWebJSPUi.mipweb_user_modgroup_9 %>');
							 User2.modPersonalGroup(groupid,$('groupname').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_10 %>");
											 parent.parent.ChangegroupPage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_11 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_12 %>"+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 			Progress('<%= MipWebJSPUi.mipweb_user_modgroup_13 %>','<%= MipWebJSPUi.mipweb_user_modgroup_14 %>');
							 User2.modPersonalGroup(groupid,$('groupname').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_15 %>");
											 parent.parent.ChangegroupPage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_16 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_modgroup_17 %>"+errorString);
									}
								});	
				 }
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_modgroup_18 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_modgroup_19 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modgroup_20 %>
				</td>
				<td width="71%" >
				<input type="text" id="groupname" maxlength="10" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modgroup_21 %>
				</td>
				<td width="71%">
					<textarea  id="comment" style="width:300px;height:100px;word-break:break-all" class="input_h380px" onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"></textarea>
				</td>
			</tr>
		
			<!-- 
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					部门代码
				</td>
				<td width="71%" id="enterprisecode">
				</td>
			</tr>
			 -->
			
			
		</table>
		<div class="div_center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_modgroup_22 %>" onclick="modgroup()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_modgroup_23 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
