<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>版本信息详情</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
   window.onload=function(){
   	 getallinfo();
   }
  function getallinfo(){
  	 Progress("数据正在载入...","提示");
  	 dwr.util.setEscapeHtml(false);
    EnterpriseAction.getAllProductRelease(
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../xslt/admin_version_info.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);	
  
  	}
  	
</script>
</head>
<body>
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
<!-- Main 页面中部 -->
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left"></div>
<!-- 右侧例表内容 -->
<div id="center_right">
	<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<div id="center_nav_box">
	<div id="center_nav" style="font-size:14px;font-weight:bold"> 版本信息详情</div>
</div>	
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
			<table width="100%" height="30" border="0" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<td colspan="3">
										<div id="divlist"></div>
								</td>
								</tr>
							</table>
			</div>
</div>
</div>
</div></div></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
</html>
