<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
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
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var branchid = '<%=request.getParameter("branchid")%>';
			function showBranch(){
			  Progress('<%= MipWebJSPUi.mipweb_user_modbranch_1 %>','<%= MipWebJSPUi.mipweb_user_modbranch_2 %>');
			  BranchAction.showBranch(branchid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setEscapeHtml(false);
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_3 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				showBranch();
			}
			function modbranch(){
				 if($('branchname').value==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_4 %>");
				 	return false;
				 }
				 if($('shortname').value==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_5 %>");
				 	return false;
				 }
				 if($('comment').value==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_6 %>");
				 	return false;
				 }
				 var comment = $('comment').value;
				 if(comment.length>40){
				 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_modbranch_7 %>', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,40);	
							 Progress('<%= MipWebJSPUi.mipweb_user_modbranch_8 %>','<%= MipWebJSPUi.mipweb_user_modbranch_9 %>');
							 BranchAction.modBranch(branchid,$('branchname').value,$('shortname').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_10 %>");
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_11 %>"+errorString);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_12 %>"+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 	 Progress('<%= MipWebJSPUi.mipweb_user_modbranch_13 %>','<%= MipWebJSPUi.mipweb_user_modbranch_14 %>');
							 BranchAction.modBranch(branchid,$('branchname').value,$('shortname').value,comment,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_15 %>");
											 parent.parent.document.getElementById('tree').innerHTML="";
											 parent.parent.createTree();
											  parent.parent.loadBranch("");
											  parent.parent.GB_CURRENT.hide();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_16 %>"+errorString);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_modbranch_17 %>"+errorString);
									}
								});	
				 }
				
				
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_modbranch_18 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_modbranch_19 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modbranch_20 %>
				</td>
				<td width="71%">
					<input type="text" id= "branchname" />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modbranch_21 %>
				</td>
				<td width="71%">
					<input type="text" id= "shortname" />
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
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modbranch_22 %>
				</td>
				<td width="71%">
					<textarea id= "comment" style="word-break:break-all"></textarea>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modbranch_23 %>
				</td>
				<td width="71%" id="createtime">
				</td>
			</tr>
		</table>
		<div style="text-align:center"> <input type="button" value="<%= MipWebJSPUi.mipweb_user_modbranch_24 %>" onclick ="modbranch()" /><input type="button" value="<%= MipWebJSPUi.mipweb_user_modbranch_25 %>" onclick ="parent.parent.GB_CURRENT.hide()" /></div>
	</body>
</html>
