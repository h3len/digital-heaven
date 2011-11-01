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
		<script src="../dwr/interface/Mas2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var groupid = '<%=request.getParameter("groupid")%>';
			function getuserextend(){
			  //Progress('正在获取用户详情....','单位通讯录');
			  User2.getPersonalUserExtend(
					{
						callback:function(obj) {
							if(obj.c1!=''){
								
								addTr(obj.c1,"c1");
							}
							if(obj.c2!=''){
								addTr(obj.c2,"c2");
							}
							if(obj.c3!=''){
								addTr(obj.c3,"c3");
							}
							if(obj.c4!=''){
								addTr(obj.c4,"c4");
							}
							if(obj.c5!=''){
								addTr(obj.c5,"c5");
							}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_1 %>"+errorString);
						}
					});
			}
			
			
			function addGroup(){
				 if($('groupname').value==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_2 %>");
				 	 return false;
				 }
				 var comment = $('comment').value;
				 if(comment.length>40){
				 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_addgroup_3 %>', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,40);	
							 Progress('<%= MipWebJSPUi.mipweb_user_addgroup_4 %>','<%= MipWebJSPUi.mipweb_user_addgroup_5 %>');
							 User2.addPersonalGroup($('groupname').value,$('comment').value,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_6 %>");
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_7 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_8 %>"+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 	 Progress('<%= MipWebJSPUi.mipweb_user_addgroup_9 %>','<%= MipWebJSPUi.mipweb_user_addgroup_10 %>');
							 User2.addPersonalGroup($('groupname').value,$('comment').value,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_11 %>");
											 parent.parent.ChangegroupPage(parent.parent.pageid);
											  parent.parent.GB_CURRENT.hide();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_12 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addgroup_13 %>"+errorString);
									}
								});	
				 }
			}
			
		</script>
	</head>
	<body style="width:100%;"  onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title" >
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_addgroup_14 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_addgroup_15 %></span>
		</div>
		<table style="width:100%;" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tbody id="user_table">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_addgroup_16 %>
				</td>
				<td width="71%" >
					<input type="text" id="groupname" maxlength="10" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>*
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_addgroup_17 %>
				</td>
				<td width="71%" >
					<input type="text" id="comment" maxlength="20" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/>
				</td>
			</tr>
			 
			</tbody>
		</table>
		<div class="div_center"> <input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_addgroup_18 %>" onclick ="addGroup()" /> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%= MipWebJSPUi.mipweb_user_addgroup_19 %>"  class="button_2"  onclick ="parent.parent.GB_CURRENT.hide()" /></div>

	</body>
</html>
