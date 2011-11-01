<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业业务系统同步</title>
		<script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 	</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		
		
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var appid = '<%=request.getParameter("appid")%>';
		var pageid = '<%=request.getParameter("pageid")%>';
		window.onload=function(){
		showsynapp();
		}
		function showsynapp(){
			EnterpriseAction.showsyninfo(appid,
				function(oData){
					dwr.util.setValues(oData);
				}
			);
		}
</script>
</head>
<body>
<div class="up_title">
			<span class="href_14px_blue">业务系统同步信息</span>
		</div>
		<div class="up_subtitle">
			<span>同步信息：</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					同步序列号
				</td>
				<td width="71%" id="showserialnum">
				</td>
			</tr>
			<tr align="center">
				<td align="center" colspan="3">
					<input type="button" class="button_2" value="关闭" onclick="parent.parent.GB_CURRENT.hide()"/> 
				</td>
			</tr>
		</table>
		
</body>
</html>