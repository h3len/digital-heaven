<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils"/>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>管理员企业管理</title>
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
var enterpriseid = "<%=request.getParameter("enterpriseid") != null ? request
							.getParameter("enterpriseid")
							: request.getSession().getAttribute("enterpriseid")%>"; 
  	window.onload = function(){
  		showpluginapp();
  	}
  	function showpluginapp(){
  	Progress("数据正在载入...","提示");
    EnterpriseAction.showPluginApp(
			 	function(objXml){
			 		//alert(objXml.xml);
					DisplayTransformedXML(1, objXml, "../xslt/admin_config_app.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);	
  	}
  	function createpluginapp(){
  		GB_showCenter("", "../sysconfig/createpluginapp.jsp?enterpriseid="+enterpriseid,450,878);
  	}
  	function modpluginapp(id,name,appid){
  		GB_showCenter("", "../sysconfig/modpluginapp.jsp?id="+id+"&name="+name+"&enterpriseid="+enterpriseid+"&appid="+appid,450,878);
  	}
  	function delpluginapp(id){
  	Ext.Msg.confirm(nowtitle, '您确定要删除功能模块的业务系统?', function(btn){
					if(btn=='yes'){
  		EnterpriseAction.delPluginApp(id,{
  			callback:function(odata){
  				if(odata){
  					DHalert("删除功能模块的业务系统成功！");
  					showpluginapp();
  				}
  			},
  			errorHandler:function(errorString, exception) {
				CloseProgress();
				DHalert("操作失败！失败原因"+exception.message);		
			}
  		});
  		}
		});
  	}
		function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if
		(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
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
	<div id="center_nav">您现在所在位置 >> 配置管理 >> 插件绑定业务系统</div>
</div>	
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
			<table width="100%" height="30" border="0" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
									<td width="90%" class="gray_14_bold">
										<span>插件绑定业务系统</span>
									</td>								
									<td width="2%">
										<div id="showcreateimage">
											<img src="../theme/images/new.gif" />
										</div>
									</td>
									<td width="8%" align="left">
										<div id="creatediv">
											<span class="margin_right_5" /> <span class="hand"
												onclick="javascript:createpluginapp();">创 建</span>
										</div>
									</td>
								</tr>
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
