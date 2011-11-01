<%@ page contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
		
		<title>MDP适配文件管理</title>
		
		<script src="/dwr/interface/MdpConfig.js" type="text/javascript"></script>
		<script src="/dwr/engine.js" type="text/javascript"></script>
		<script src="/dwr/util.js" type="text/javascript"></script>
		
		<script type="text/javascript" src="/skin/AJS.js"></script>
		<script type="text/javascript" src="/skin/AJS_fx.js"></script>
		<script type="text/javascript" src="/skin/gb_scripts.js"></script>
		<link href="/skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
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
		   //初始化
		window.onload = function()
		{
		    getMdpConfig("");
		}
		
	   function getMdpConfig(path)
	   {
        	//Progress("正在载入适配文件....");
			MdpConfig.getMdpConfigList(path,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_config_list.xsl",document.getElementById("divContent"));
					//CloseProgress();
				},
				errorHandler:function(errorString, exception) {
				//CloseProgress();
					alert(exception.message);
				}
			});
	   }
	   
	   function downloadFile(path)
	   {
			location.href="../mdp.do?action=DownloadMdpConfig&path="+path;
	   }
	</script>

	</head>

	<body bgcolor="#f8f8f8" class="body_center">
	
		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!--Top Include-->
		
		<div id="center">
			<div id="center_left" class="center_left">
				<!--Strat center_left_tree-->
				<div id="center_left_tree">
					<div id="center_left_tree_top"></div>
					<div id="center_left_tree_bg">

					</div>
					<div id="center_left_tree_bom"></div>
				</div>
			</div>
				<div id="center_right">
					<div id="close_menu" onClick="javascript:closemenu()" class="hand"></div>
						<div id="center_right_main">
							<div id="center_nav_box">
								<div id="center_nav">
									您现在所在位置 >> 系统维护 >> MDP适配文件管理
								</div>
							</div>
							<div id="mainbox">
									<div id="divContent"></div>
							</div>
					</div>
			</div>
		</div>

		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="/user/bottom.jsp" flush="true" />
		<!--Bottom Include-->

	</body>
</html>
