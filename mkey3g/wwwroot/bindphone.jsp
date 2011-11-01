<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title><%=MipWebMoreUi.mip_bindphone_1%></title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		var name = parent.parent.document.getElementById('username').value;
		var pwd = parent.parent.document.getElementById('password').value;
		function save(){
		var reg = /^(\+)?(\d)+$/
				 if($('phone').value==''){
				 	 DHalert("<%=MipWebMoreUi.mip_bindphone_2%>");
				 	 return false;
				 }
				 if($('phone').value.length > 20 || $('phone').value.length < 6){
				 	DHalert("<%=MipWebMoreUi.mip_bindphone_3%>");
				 	return false;
				 }
				 if(!reg.test($('phone').value)){
				 	 DHalert("<%=MipWebMoreUi.mip_bindphone_4%>");
				 	 return false;
				 }
			 User2.updateUserPhone(name,pwd,$('phone').value,
			{
				callback:function(otext) {
				if(otext=="1"){
				parent.parent.GB_CURRENT.hide();
				parent.parent.bsuserlogin();
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

	<body>
		<div>
			<font color=#ff0000> <%=MipWebMoreUi.mip_bindphone_5%></font>
		</div>
		<br>
		<table width="100%" " border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<span class="blue_12"><%=MipWebMoreUi.mip_bindphone_6%></span>
				</td>
				<td>
					<input type="text" id="phone" value="" maxlength="25" />
					<input type="button" class="button_2"
						value="<%=MipWebMoreUi.mip_bindphone_7%>"
						onclick="javascript:save();" />
				</td>
			</tr>
		</table>
		<br></br>
		<p><%=MipWebMoreUi.mip_bindphone_13%></p>
	</body>
</html>
