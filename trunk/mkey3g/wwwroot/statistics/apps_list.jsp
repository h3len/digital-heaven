<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
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
		<script src="../dwr/interface/MipUserStatisticsAction.js"
			type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">
		var id="<%=request.getParameter("id")%>";
		var starttime="<%=request.getParameter("starttime")%>";
		var endtime="<%=request.getParameter("endtime")%>";
		function showApps(){
			
		  MipUserStatisticsAction.showNewApps(id,starttime,endtime,
				{
					callback:function(oMap) {
					
						dwr.util.setValues(oMap);
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert(""+errorString);
					}
				});
		}
		window.onload=function(){
			showApps();
		}
		</script>
	</head>
	<body
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">

			<span class="href_14px_blue"><%=request.getParameter("starttime")%>&nbsp;&nbsp;&nbsp;<%=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8")%> </span>
		</div>

		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tbody id="user_table">
				<%
					for (int i = 0; i < Integer.parseInt(request.getParameter("num")); i++) {
				%>
				<tr>
					<td width="8%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td id="app<%=i%>" >
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</body>
</html>
