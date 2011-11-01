<%@ page contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../scripts/selall.js"></script>

		<script src="/dwr/interface/MdpLog.js" type="text/javascript"></script>
		<script src="/dwr/engine.js" type="text/javascript"></script>
		<script src="/dwr/util.js" type="text/javascript"></script>
		
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		
		<script type="text/javascript" src="/skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="/skin/calendar/lang/calendar-zh.js"></script>
		<link href="/skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="/skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="/skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />

		<script language="javascript" type="text/javascript">
		//公共变量
		var progressBar;
		var tabPane;
		var logid = '<%=request.getParameter("logid")%>';
		var adminType = <%=request.getParameter("tp")!= null && request.getParameter("tp").equals("1") ? 1: 0%>;

		   //初始化
		window.onload = function()
		{
		    Search(logid);
		}
	   
	   function Search(id)
	   {
			if(id != ''){
				Progress("Loading....");
				MdpLog.getLog(id,
				{
					callback:function(objXml) {
						document.getElementById("divContent").innerHTML = "";
						DisplayTransformedXML(1, objXml, "/xslt/mdp_logs_detail.xsl",document.getElementById("divContent"));
						CloseProgress();
					},
					errorHandler:function(errorString, exception) {
						alert(exception.message);
					}
				});
			}
			else{
				DHalert("日志不存在");
			}
        	
	   }
	</script>

	</head>

	<body bgcolor="#f8f8f8" class="body_center">
		<div id="center">
			<div  class="center_list">
				<div class="clear"></div>
				<div id="divContent"></div>
			</div>	
		</div>
		<div class="clear"></div>
	</body>
</html>
