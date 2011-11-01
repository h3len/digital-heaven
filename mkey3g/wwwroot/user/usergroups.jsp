<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.web.MobileType"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipMobileType"%>
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
			
			window.onload=function(){
				getUserGroupsbyuid();
			}
			
			
				function getUserGroupsbyuid(){
					 User2.getUserGroupsbyuid(userid,
				{
					callback:function(objXml) {
						 DisplayTransformedXML(1, objXml, "../user/xslt/user_groups.xsl",document.getElementById("grouplist"));
					},
					errorHandler:function(errorString, exception) {
					    DHalert("<%= MipWebJSPUi.mipweb_user_usergroups_1 %>");
					}
				});
	}
			
			
			
			
			
			    function deluserfromgroup(groupid,userid){
    
    				Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_usergroups_2 %>', function(btn){
						if(btn=='yes'){
								 User2.delUser(userid,0,groupid,"1",
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 getUserGroupsbyuid();
											 parent.parent.searchuser();
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_usergroups_3 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_usergroups_4 %>"+errorString);
									}
								});			
							}
						}
						);
    }
			
			
		</script>
	</head>
	<body style="width: 100%;"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_usergroups_5 %></span>
		</div>
		<div id="grouplist"></div>
	</body>
</html>
