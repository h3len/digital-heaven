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
			var userid = '<%=request.getParameter("userid")%>';
			var pageid=1;
			function showUser(){
			  Progress('<%= MipWebJSPUi.mipweb_user_insertpersonaluser_1 %>','<%= MipWebJSPUi.mipweb_user_insertpersonaluser_2 %>');
			  User2.showPersonalUser(userid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_insertpersonaluser_3 %>"+errorString);
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
							DisplayTransformedXML(1, objXml, "../user/xslt/ingrouplist.xsl",document.getElementById("userlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_insertpersonaluser_4 %>"+errorString);
						}
					});
			}
			function ChangePage(pid){
				pageid = pid;
				getOtherGroup();
			}
			function inserttothis(gid){
				 User2.insertGroup(userid,gid,
					{
						callback:function(otext) {
							if(otext=='1'){
								DHalert("<%= MipWebJSPUi.mipweb_user_insertpersonaluser_5 %>");
								parent.parent.ChangePage(parent.parent.pageid);
								parent.parent.GB_CURRENT.hide();
							}else{
								DHalert(otext);
							}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
							DHalert(errorString);
						}
					});
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<div id="userlist"></div>
		<div class="div_center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_insertpersonaluser_6 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
		
	</body>
</html>
