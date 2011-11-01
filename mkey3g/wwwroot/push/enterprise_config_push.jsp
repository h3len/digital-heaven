<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
<%@page import="com.dheaven.framework.plugin.config.MipCategory"%>

<html>
	<head>
	
		<title>系统推送规则配置</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="/dwr/interface/Push.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
	var isInit=false;
  	var maxsize=<%=ServerConfig.MipPlugiApsConfigMap.size()%>;
   	var tabPane;
   	var ab=new Array();
		   //初始化
	function closeAll(){
		for(i=0;i<maxsize;i++){
			$("plugin"+i).style.display="none";
		}
	}
		 
	<%
	int i=0;
	for(String id:ServerConfig.MipPlugiApsConfigMap.keySet()){
	%>
		function get<%=id%>(){
			closeAll();
		 	Get<%=id%>();
		 	$('plugin<%=i%>').style.display="";
		}
		
		var init<%=id%>=false;
		
		function Get<%=id%>(){
		 	Push.getPluginPushRule("<%=id%>",
			{
				callback:function(map) {
					if(!init<%=id%>){
						var rows=$("table<%=id%>").rows;
						if(map['client']==0){
							for(i=0;i<rows.length;i++){
								rows[i].cells[0].style.display="none";
							}
							$("truefalsetrue<%=id%>").style.display="none";
							$("truefalsefalse<%=id%>").style.display="none";
						}
						if(map['web']==0){
							for(i=0;i<rows.length;i++){
								rows[i].cells[1].style.display="none";
							}
							$("truefalsetrue<%=id%>").style.display="none";
							$("falsefalsetrue<%=id%>").style.display="none";
						}
						var list=document.getElementsByName("<%=id%>select");
						for(i=0;i<list.length;i++){
							var options=list[i].options;
							for(j=0;j<options.length;j++){
								if(map['ip-push']==0&&options[j].value=="ip-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['web-push']==0&&options[j].value=="web-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['sms-push']==0&&options[j].value=="sms-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['mms-push']==0&&options[j].value=="mms-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['wap-push']==0&&options[j].value=="wap-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['mail-push']==0&&options[j].value=="mail-push"){
									list[i].remove(options[j].index);
									j--;
								}else if(map['emn-push']==0&&options[j].value=="emn-push"){
									list[i].remove(options[j].index);
									j--;
								}
							}
						}
						init<%=id%>=true;
					}
					DWRUtil.setValue("<%=id%>truefalsetrue",map["truefalsetrue"]);
					DWRUtil.setValue("<%=id%>truefalsefalse",map["truefalsefalse"]);
					DWRUtil.setValue("<%=id%>falsefalsetrue",map["falsefalsetrue"]);
					DWRUtil.setValue("<%=id%>falsefalsefalse",map["falsefalsefalse"]);
				},
				errorHandler:function(errorString, exception) {
					DHalert(errorString);
				}
			});
		}
		
	<%
	i++;
	}
	%>
	
	function updateConfig(id){
		Progress('正在配置插件推送规则，请稍候....','配置推送规则');
		var result;
		result = {};


		if($("truefalsetrue"+id).style.display!="none"){
			result['true|false|true']=$(id+"truefalsetrue").value;
		}
		if($("truefalsefalse"+id).style.display!="none"){
			result['true|false|false']=$(id+"truefalsefalse").value;
		}
		if($("falsefalsetrue"+id).style.display!="none"){
			result['false|false|true']=$(id+"falsefalsetrue").value;
		}
		if($("falsefalsefalse"+id).style.display!="none"){
			result['false|false|false']=$(id+"falsefalsefalse").value;
		}
		
		Push.savePluginPushRule(id,result,
			{
				callback:function(map) {
					CloseProgress();
					DHalert("插件推送规则配置成功！");
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					DHalert(errorString);
				}
			});
		
	}
	
	function isForce(){
		Push.isForce(
			{
				callback:function(map) {
					$("force").checked=map;
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					DHalert(errorString);
				}
			});
	}
	
	function saveForce(force){
		Push.saveForce(force,
			{
				callback:function() {
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					DHalert(errorString);
				}
			});
	}
	
	window.onload = function()
	{
		<%
		i=0;
		for(MipCategory cat:ServerConfig.MipPlugiApsConfigMap.values()){
		%>
			ab[<%=i%>]=[get<%=cat.getId()%>,'<%=cat.getCategoryname()%>'];
		<%
			i++;
		}%>
		isForce();
		DHTabPanel(ab,900,0,"tabs");
	} 
	</script>
	</head>




	<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

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
					<!-- 中部主要内容开始 -->
					<table width="100%" height="29" border="0" cellpadding="0"
						cellspacing="0" background="../../theme/images/alert_bg.gif">
					</table>
					<div id="center_nav_box">
						<div id="center_nav">您现在所在位置 >>  配置管理 >> 系统推送规则配置</div>
					</div>	
					<div class="center_nav_line"></div>	
							<div >
								是否强制使用企业推送配置<input id="force" type="checkbox" onClick="javascript:saveForce(this.checked)" />
							</div>
					<div id="tabs" style="border:1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">

								<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="5">
									<tr>
										<td colspan="5" valign="top">
<%
	i=0;
	for(String id:ServerConfig.MipPlugiApsConfigMap.keySet()){
%>
										<div id="plugin<%=i%>" style="display:none">
											<table id="table<%=id%>" width="60%" align="center" class="table01" width="98%" cellspacing="0" cellpadding="3" >
													<tr  class="header">
														<td class="list_title_bg"   width="30%"><div align="center" class="href_12px_blue_bold">客户端</div></td>
														<td class="list_title_bg"  width="30%"><div align="center" class="href_12px_blue_bold">web</div></td>
														<td  class="list_title_bg" width="40%"><div align="center" class="href_12px_blue_bold">提醒方式</div></td>
													</tr>
													<tr  style="height:23px;" id="truefalsetrue<%=id%>">
														<td   ><div align="center" style="color:green;">在线</div></td>
														<td  ><div align="center" style="color:green;">在线</div></td>
														<td  width="40%"><div align="center">
														<select id="<%=id%>truefalsetrue" name="<%=id%>select" style="width:130px">
															<option value="ip-push">使用ip push</option>
															<option value="web-push">使用web push</option>
															<option value="sms-push">使用明文短信</option>
															<option value="mms-push">使用彩信</option>
															<option value="wap-push">使用wap push</option>
															<option value="mail-push">使用邮件提醒</option>
															<option value="no-push">不提醒</option>
														</select>
														</div></td>
													</tr>
													<tr  style="height:23px;" id="truefalsefalse<%=id%>"> 
														<td   ><div align="center" style="color:green;">在线</div></td>
														<td  ><div align="center" style="color:red;">离线</div></td>
														<td  width="40%"><div align="center">
														<select id="<%=id%>truefalsefalse" name="<%=id%>select" style="width:130px">
															<option value="ip-push">使用ip push</option>
															<option value="sms-push">使用明文短信</option>
															<option value="mms-push">使用彩信</option>
															<option value="wap-push">使用wap push</option>
															<option value="mail-push">使用邮件提醒</option>
															<option value="no-push">不提醒</option>
														</select>
														</div></td>
													</tr>
													<tr  style="height:23px;" id="falsefalsetrue<%=id%>">
														<td   ><div align="center" style="color:red;">离线</div></td>
														<td  ><div align="center" style="color:green;">在线</div></td>
														<td  width="40%"><div align="center">
														<select id="<%=id%>falsefalsetrue" name="<%=id%>select" style="width:130px">
															<option value="web-push">使用web push</option>
															<option value="sms-push">使用明文短信</option>
															<option value="mms-push">使用彩信</option>
															<option value="wap-push">使用wap push</option>
															<option value="mail-push">使用邮件提醒</option>
															<option value="emn-push">激活客户端</option>
															<option value="no-push">不提醒</option>
														</select>
														</div></td>
													</tr>
													<tr  style="height:23px;" id="falsefalsefalse<%=id%>">
														<td   ><div align="center" style="color:red;">离线</div></td>
														<td ><div align="center" style="color:red;">离线</div></td>
														<td  width="40%"><div align="center">
														<select id="<%=id%>falsefalsefalse"  name="<%=id%>select" style="width:130px">
															<option value="sms-push">使用明文短信</option>
															<option value="mms-push">使用彩信</option>
															<option value="wap-push">使用wap push</option>
															<option value="mail-push">使用邮件提醒</option>
															<option value="emn-push">激活客户端</option>
															<option value="no-push">不提醒</option>
														</select>
														</div></td>
													</tr>
											</table>
											<div class="center_nav_line"></div>	
											<div class="div_center padding_5">
															  <input name="image" type="image"
																	onClick="javascript:updateConfig('<%=id %>')"
																	value="保存设置"
																	src="../skin/default/images/button_save.gif"
																	width="60px" height="22px" />
											</div>
											</div>
<%
	i++;
} 
%>
									  </td>
									</tr>
								</table>

								<div id="divList">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>