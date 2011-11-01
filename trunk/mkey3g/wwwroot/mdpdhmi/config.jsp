<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
	
		<title>DHMI配置信息管理</title>
		
		
		<script src="/dwr/interface/DHMIConfigAction.js" type="text/javascript"></script>
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
		

		<script type="text/javascript">
		
		var progressBar;
		
		var adminType = '<%= com.dheaven.mip.mkey.web.Services.getAdminType(session)%>';
		
		function loadPage()
		{
			if(adminType == <%=com.dheaven.mip.dataaccess.vo.MipSysuser.USR_LOGIN_TYPE_CTCCMANAGER%>)
			{
				//平台管理员
				getEnterpriseList();
			}
			else
			{
				//企业管理员
				getAppList();
			}
		}
		
		
		//get enterprise list
		function getEnterpriseList(){
		     Progress("Loading....");
		     DHMIConfigAction.getEnterpriseList(
			{
				callback:function(objXml) {
					document.getElementById("divSelect").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_dhmi_applist.xsl",document.getElementById("divSelect"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		
		//get app list
		function getAppList(){
		     Progress("Loading....");
		     DHMIConfigAction.getAppList(
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_dhmi_applist.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		//get app list
		function getAppListById(enterpriseid){
		     Progress("Loading....");
		     DHMIConfigAction.getAppListByEnterpriseId(enterpriseid,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_dhmi_applist.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		//加载更新窗口
		function getDhmiConfig(appid){
		     Progress("正在加载数据....");
		     DHMIConfigAction.getDhmiConfig(appid,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_dhmi_config.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		function SaveOrUpdate(appid){
			var mdpServerUrl = document.getElementById("mdpServerUrl").value;
			var appServerURL = document.getElementById("appServerURL").value;
			var isautoMsc3 = document.getElementById('enableMsc2to3').checked;
			var workflowServerURL = "";
			if(mdpServerUrl.length==0){
				mdpServerUrl = "";
			}
			if(appServerURL.length==0){
				appServerURL = "";
			}
			
			Progress("正在保存配置...");
			DHMIConfigAction.saveOrUpdate(appid,mdpServerUrl,appServerURL,workflowServerURL,isautoMsc3,
			{
				callback:function(data) {
					if(data == "1"){
						DHalert("配置成功");
						//getDhmiConfig(appid);
					}
					else{
						DHalert("配置失败,请重试!");
					}
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
	</script>
	</head>
	<body bgcolor="#f8f8f8" onload="javascript:loadPage();">
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
									您现在所在位置 >> 配置管理 >> DHMI配置
								</div>
							</div>
							<div id="mainbox">
									
								<div  class="center_list">
									<table width="100%"  class="margin_left_5">
										<tr style=" height:23px ">
											<td colspan="2" width="100%" align="center">
												<div id="divSelect"></div>
											</td>
										</tr>
									</table>
									<div class="clear"></div>
								
								
									<div id="divContent"></div>
								</div>	
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
