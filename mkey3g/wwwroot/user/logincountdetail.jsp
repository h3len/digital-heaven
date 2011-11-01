<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE%></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->

		<script src="../dwr/interface/LoginCountAction.js"
			type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">
			var pageid = "<%=request.getParameter("pageid") != null ? request
					.getParameter("pageid") : "1"%>"-0;
			var type = '<%=request.getParameter("type")%>';
			var entid='<%=request.getParameter("entid")%>';

			function getlogindetail(){
				LoginCountAction.getlogindetail(type,entid,pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../user/xslt/logindetail.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);
			}
			window.onload=function(){
				getlogindetail()
			}
			 //页面跳转
			function ChangePage(id)
			{
				pageid = id;
				getlogindetail(pageid);
			}

		</script>
	</head>
	<body style="width: 100%;"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue">活跃用户详情</span>
		</div>
		<div class="up_subtitle">
			<span>详情列表</span>
		</div>
		<div id="divlist"></div>


	</body>
</html>
