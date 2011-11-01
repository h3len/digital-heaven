<%@ page contentType="text/html; charset=UTF-8"%>
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
			var userid = '<%=request.getParameter("userid")%>';
			var pageid=1;
			var now_branchid = parent.parent.now_branchid;
			function showUser(){
			  Progress('<%= MipWebMoreUi.mip_user_trapersonaluser_1 %>','<%= MipWebMoreUi.mip_user_trapersonaluser_2 %>');
			  User2.showPersonalUser(userid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebMoreUi.mip_user_trapersonaluser_3 %>"+errorString);
						}
					});
			}
			
			window.onload=function(){
				getOtherGroup()
			}
			function getOtherGroup(){
				  User2.getOtherGroup(userid,pageid,
					{
						callback:function(objXml) {
							DisplayTransformedXML(1, objXml, "../user/xslt/pgrouplist.xsl",document.getElementById("userlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebMoreUi.mip_user_trapersonaluser_4 %>"+errorString);
						}
					});
			}
			function ChangePage(pid){
				pageid = pid;
				getOtherGroup();
			}
			function tratothis(gid){
				 User2.changeGroup(userid,gid,now_branchid,
					{
						callback:function(otext) {
							if(otext=='1'){
								DHalert("<%= MipWebMoreUi.mip_user_trapersonaluser_5 %>");
								parent.parent.ChangePage(parent.parent.pageid);
								parent.parent.GB_CURRENT.hide();
							}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebMoreUi.mip_user_trapersonaluser_6 %>"+errorString);
						}
					});
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<div id="userlist"></div>
		<div class="div_center"><input type="button" value="<%= MipWebMoreUi.mip_user_trapersonaluser_7 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
		
	</body>
</html>
