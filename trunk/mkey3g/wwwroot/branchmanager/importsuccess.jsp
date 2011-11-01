<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>中国电信移动办公</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
	</head>
<script type="text/javascript">
	window.onload= function(){
		try{
			parent.parent.ChangePage(parent.parent.pageid);
		}catch(e){
		}
	}
</script>
	<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<!-- 中部主要内容开始 -->
			<div class="center_list_box" style="width: 900;">
				<table width="100%" class="tablelist text_align_center">
					<tr>
						<td>
							<div id="preview" style="text-align: left;">
								<%
									if (session.getAttribute("reqstr") != null) {
										out.println(session.getAttribute("reqstr"));
										//为了节约资源的说.
										session.removeAttribute("reqstr");
									} else {
										out.println("<script>history.back();</script>");
									}
								%>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<input name="button" class="button_4" type="button" id="BtnOK"
								onclick="window.history.back();" value="返回上级" />
						</td>
					</tr>
				</table>
			</div>
	</body>
</html>
