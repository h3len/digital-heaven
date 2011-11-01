<%@ page import="com.dheaven.mip.config.*"%>

<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/BusinessLogs.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--ExtJs-->
		<LINK href="../skin/ext-all.css" type=text/css rel=stylesheet />
		<SCRIPT src="../skin/ext-base.js" type=text/javascript></SCRIPT>
		<SCRIPT src="../skin/ext-all.js" type=text/javascript></SCRIPT>
		<!-- prototype -->
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<script type="text/javascript">
/*
	这个方法就是生成业务
	by wl
*/
	var id;
		var path = location.href;


 	
  	if( path.indexOf("?") > -1)
	 {
    id = path.substring(path.lastIndexOf("=")+1);
		}
function showthislog(){
		BusinessLogs.getApsLogById(id,
		{
				callback:function(omap){
					if(omap!=null)
						dwr.util.setValues(omap);
				},
				errorHandler:function(errorString, exception) {

				}
			});
}
window.onload=function(){
	showthislog();
}
</script>
	</head>
	<body style="width:620px;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					企业名称
				</td>
				<td width="71%" id="enterprise">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					目标用户
				</td>
				<td width="71%" id="to">
				</td>
			</tr>

			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					创建时间
				</td>
				<td width="71%" id="vdatetime" style="word-break:break-all">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					送达时间
				</td>
				<td width="71%" id="completetime">
				</td>
			</tr>
		<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					状态
				</td>
				<td width="71%" id="status">
				</td>
			</tr>
			<tr >
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					类型
				</td>
				<td width="71%" id="type">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					内容
				</td>
				<td width="71%" id="content">
				</td>
			</tr>
		</table>
	</body>
</html>
