<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils" />
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>平台设置</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js"
			type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		var linktype = "";
		var ssltype = "";
		var isRemindBindPhoneValue = "";
		var loginport = '<%=session.getAttribute("loginport")%>';
		var iscloud = '<%=DhServerNameUtils.isCloud%>';
		window.onload = function(){
			if(loginport!="2"||iscloud!="true"){
				
				document.getElementById("mode").style.display="";
				document.getElementById("modebutton").style.display="";
				showlinkmode();
			}
			
			if(loginport=="2"||iscloud!="true"){
				document.getElementById("pcode").style.display="";
				showprofessioncode();
				showIsRemindBindPhone();
			}
			
		}
		  function saveprofessioncode(){
		  		var cf = new CheckForm();
		  		if(cf.Trim($("professioncode").value)==""){
		  			DHalert("请输入系统业务码！");
		  			return false;
		  		}
		  		if(cf.Trim($("professioncode").value).length<2){
		  			DHalert("系统业务码为两位！");
		  			return false;
		  		}
		  		EnterpriseAction.createprofessioncode($("professioncode").value,{
		  			callback:function(data) {
		  					if(data=="1"){
		  						SDHalert("添加业务成功！",130);
		  					}else if(data=="0"){
		  						showprofessioncode();
		  						DHalert("存在可用业务系统,不能修改集团业务码！");
		  					}
						},
						errorHandler:function(errorString, exception) {
						    DHalert("添加业务代码失败，失败原因："+errorString);
						}
		  		});
		  }
		  function showprofessioncode(){
		 	 EnterpriseAction.showprofessioncode({
						callback:function(data) {
							dwr.util.setValues(data);
							if($("updateenable").value=="1"){
								$("professioncode").disabled = true;
								$("saveprofessioncode").disabled = true;
							}else{
								$("professioncode").disabled = false;
								$("saveprofessioncode").disabled = false;
							}
						},
						errorHandler:function(errorString, exception) {
						    DHalert("获取业务代码失败，失败原因："+errorString);
						}
					});
		  }
		  function savetelphonebinding(){
		  	var telphonebinding = 0;//1:代表启用手机号绑定0：代表不启用
		  	if($("telphonebinding").checked){
		  		telphonebinding = 1;
		  	}
		  	
		  }
		  function gettelphonebinding(){
		  	
		  }
		  
		  
		  function saveserverip(){
		  		var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
		  		if($("serverip").value==""){
		        	DHalert("服务器地址不能为空！");
			        return;
		        }
		        if(!reg.test($("serverip").value)){
		        	DHalert("服务器地址格式不正确！");
			        return;
		        }
		        EnterpriseAction.saveserverip($("serverip").value,{
		  			callback:function(data) {
		  					if(data=="1"){
		  						 DHalert("修改服务器地址成功！");
		  					}else{
		  						SDHalert(data,130);
		  					}
						},
						errorHandler:function(errorString, exception) {
						    DHalert("修改服务器地址失败，失败原因："+errorString);
						}
		  		});
		        
		  }
		  
		  function savepushtime(){
		  		var cf = new CheckForm();
		  		if(!cf.IsNumber($("pushtime").value)){
		  			DHalert("推送过期时间必须为数字！");
		  			return false;
		  		}
		  		EnterpriseAction.savePushExpirationTime($("pushtime").value,{
		  			callback:function() {
		  					DHalert("修改推送过期时间成功！");
						},
						errorHandler:function(errorString, exception) {
						    DHalert("修改推送过期时间失败，失败原因："+errorString);
						}
		  		});
		  }
		 function updatelinkmode(){
		  	if(document.getElementById("linkmode2").checked){
		  		linktype="https";
		  	}else{
		  		linktype="http";
		  	}
		  	if(document.getElementById("sslmode2").checked){
		 		ssltype="double";
		 	}else{
		 		ssltype="single";
		 	}
		  	EnterpriseAction.updateLinkMode(linktype,ssltype,{
		  		callback:function(){
		  			DHalert("服务器配置修改成功");
		  		},errorHandler:function(errotString,exception){
		  			DHalert("服务器配置修改失败，失败原因："+errorString);
		  		}
		  	});
		  }
		  function linkmodechange(){
		  	if(document.getElementById("linkmode1").checked){
		  		linktype="http";
		  		document.getElementById("sslhide").style.display="none";
		  	}
		  	if(document.getElementById("linkmode2").checked){
		  		linktype="https";
		  		document.getElementById("sslhide").style.display="";
		  	}
		  }
		  function showlinkmode(){
		  	EnterpriseAction.showLinkMode(
		  	{
				callback:function(data){
					if(data==null){
						document.getElementById("linkmode1").checked;
						document.getElementById("sslmode1").checked;
					}else{
						dwr.util.setValues(data);
						if(data.linkmode=="https"){
							document.getElementById("sslhide").style.display="";
						}
					}},errorHandler:function(errorString,exception){
						DHalert(errorString);
					}
		  	});
		  }
		  function sslmodechange(){
		 	if(document.getElementById("sslmode1").checked){
		  		ssltype="single";
		  	}
		  	if(document.getElementById("sslmode2").checked){
		  		ssltype="double";
		  	}
		 }
		 
		  function showIsRemindBindPhone(){
		  	EnterpriseAction.showIsRemindBindPhone(
		  	{
				callback:function(data){
					if(data==null){
						document.getElementById("isRemindBindPhone1").checked;
					}else{
						dwr.util.setValues(data);
					}},
					errorHandler:function(errorString,exception){
						DHalert(errorString);
					}
		  	});
		  	document.getElementById("isRemindBindPhoneT").style.display="";
		  	document.getElementById("isRemindbutton").style.display="";
		  }
		 
		 function isRemindBindPhoneChange(){
		  	if(document.getElementById("isRemindBindPhone1").checked){
		  		isRemindBindPhoneValue="1";
		  	}
		  	if(document.getElementById("isRemindBindPhone2").checked){
		  		isRemindBindPhoneValue="0";
		  	}
		  }
		  
		function updateIsBindPhone(){
			if(document.getElementById("isRemindBindPhone1").checked){
		  		isRemindBindPhoneValue="1";
		  	}else{
		  		isRemindBindPhoneValue="0";
		  	}
		  	EnterpriseAction.updateIsRemindBindPhone(isRemindBindPhoneValue,{
		  		callback:function(objStr){
		  			if(objStr == "1"){
		  				SDHalert("设置成功!",130);
		  			}else{
		  				SDHalert("设置失败!",130);
		  			}
		  			
		  		},
		  		errorHandler:function(errotString,exception){
		  			DHalert("设置是否提醒用户未绑定手机号失败，失败原因："+errorString);
		  		}
		  	});
		}
</script>
	</head>
	<body>
		<!--Bottom Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
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
						<div id="center_nav">
							您现在所在位置 >> 配置管理 >> 系统设置
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<input type="hidden" id="updateenable" />
								<div>
									<table width="60%" border="0" align="center" cellpadding="0"
										style="display: none" id="pcode" cellspacing="5">
										<tr>
											<td width="35%">
												集团业务码设置
											</td>
											<td width="65%"></td>
										</tr>
										<tr>
											<td colspan="5">
												<fieldset>
													<table width="80%" height="30" border="0" align="center"
														cellpadding="0" cellspacing="0">
														<tr>
															<td colspan="3" class="text_icon2">
																<span class="href_14px_blue">集团业务码:</span>

															</td>
															<td width="79%">
																<input type="text" id="professioncode"
																	class="input_text" maxlength="2"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" size="9" />
															</td>
														</tr>
													</table>
													<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input name="submit" type="button" id="saveprofessioncode"
															onClick="saveprofessioncode()" value="提交"
															class="button_2" />
													</div>

												</fieldset>
											</td>
										</tr>
										<tr>

											<td width="35%">
												推送过期时间配置(单位:天)
											</td>
											<td width="65%"></td>
										</tr>
										<tr>
											<td colspan="5">
												<fieldset>
													<table width="80%" height="30" border="0" align="center"
														cellpadding="0" cellspacing="0">
														<tr>
															<td colspan="3" class="text_icon2">
																<span class="href_14px_blue">过期时间:</span>

															</td>
															<td width="79%">
																<input type="text" id="pushtime" class="input_text"
																	maxlength="3" onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" size="9" />
															</td>
														</tr>
													</table>
													<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input name="submit" type="button"
															onClick="savepushtime()" value="提交" class="button_2" />
													</div>

												</fieldset>
											</td>
										</tr>
										<tr>
											<td width="35%">
												服务器IP地址配置
											</td>
											<td width="65%"></td>
										</tr>
										<tr>
											<td colspan="5">
												<fieldset>
													<table width="82%" height="30" border="0" align="center"
														cellpadding="0" cellspacing="0">
														<tr>
															<td colspan="3" class="text_icon2" width="25%">
																<span class="href_14px_blue">服务器IP地址:</span>

															</td>
															<td width="79%">
																<input type="text" id="serverip" class="input_text"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" size="9" />
															</td>
														</tr>
													</table>
													<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input name="submit" type="button"
															onClick="saveserverip()" value="提交" class="button_2" />
													</div>

												</fieldset>
											</td>
										</tr>
										<table width="60%" align="center" id="mode"
											style="display: none">
											<tr>
												<td width="35%">
													服务器连接方式设置：
												</td>
												<td width="65%"></td>
											</tr>
											<tr>
												<td colspan="5">
													<fieldset>
														<table width="80%" height="30" border="0" align="center"
															cellpadding="0" cellspacing="0">
															<tr>
																<td colspan="3" class="text_icon2">
																	<input type="radio" onclick="linkmodechange()"
																		name="linkmode" id="linkmode1" value="http" checked>
																	HTTP
																	</input>

																</td>
																<td width="79%">
																	<input type="radio" onclick="linkmodechange()"
																		name="linkmode" id="linkmode2" value="https">
																	HTTPS
																	</input>
																</td>
															</tr>
														</table>
													</fieldset>
												</td>
											</tr>
											<table id="sslhide" width="60%" border="0" align="center"
												style="display: none">
												<tr>
													<td width="35%">
														SSL检验方式设置：
													</td>
													<td width="65%"></td>
												</tr>
												<tr>
													<td colspan="5">
														<fieldset>
															<table width="80%" height="30" border="0" align="center"
																cellpadding="0" cellspacing="0">
																<tr>
																	<td colspan="3" class="text_icon2">
																		<input type="radio" onclick="sslmodechange()"
																			name="sslmode" id="sslmode1" value="single" checked>
																		单向
																		</input>

																	</td>
																	<td width="79%">
																		<input type="radio" onclick="sslmodechange()"
																			name="sslmode" id="sslmode2" value="double">
																		双向
																		</input>
																	</td>
																</tr>
															</table>
														</fieldset>
													</td>
												</tr>
											</table>
											<table width="60%" align="center" id="modebutton"
												style="display: none">
												<tr>
													<td colspan="5">
														<fieldset>
															<div class="center_nav_line"></div>
															<div class="div_center padding_5">
																<input name="submit" type="button" id="updatelinkmode"
																	onClick="updatelinkmode()" value="提交" class="button_2" />
															</div>

														</fieldset>
													</td>
												</tr>
											</table>
										</table>
									</table>

									<table width="60%" align="center" id="isRemindBindPhoneT"
										style="display: none">
										<tr>
											<td width="35%">
												是否提醒用户未绑定手机号设置：
											</td>
											<td width="65%"></td>
										</tr>
										<tr>
											<td colspan="5">
												<fieldset>
													<table width="80%" height="30" border="0" align="center"
														cellpadding="0" cellspacing="0">
														<tr>
															<td colspan="3" class="text_icon2">
																<input type="radio" onclick="isRemindBindPhoneChange()"
																	name="isRemindBindPhone" id="isRemindBindPhone1" value="1" checked>
																提醒
																</input>

															</td>
															<td width="79%">
																<input type="radio" onclick="isRemindBindPhoneChange()"
																	name="isRemindBindPhone" id="isRemindBindPhone2" value="0">
																不提醒
																</input>
															</td>
														</tr>
													</table>
												</fieldset>
											</td>
										</tr>

										<table width="60%" align="center" id="isRemindbutton"
											style="display: none">
											<tr>
												<td colspan="5">
													<fieldset>
														<div class="center_nav_line"></div>
														<div class="div_center padding_5">
															<input name="submit" type="button" id="updateIsBindPhone"
																onClick="updateIsBindPhone()" value="提交" class="button_2" />
														</div>

													</fieldset>
												</td>
											</tr>
										</table>
									</table>

									<%
									if (DhServerNameUtils.isCloud) {
									%>
									<table width="60%" border="0" align="center" cellpadding="0"
										cellspacing="5" style="display: none">
										<tr>
											<td width="35%">
												登录类型配置
											</td>
											<td width="65%"></td>
										</tr>
										<tr>
											<td colspan="5">
												<fieldset>
													<table width="60%" border="0" align="center"
														cellpadding="0" cellspacing="5">
														<tr>
															<td colspan="3" class="text_icon2">
																<span class="href_14px_blue">用户登录方式:</span>

															</td>
															<td width="71%">
																<input type="checkbox" id="telphonebinding" />
																<label for="telphonebinding">
																	启用手机号绑定
																</label>
															</td>
														</tr>
													</table>
													<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input name="submit" type="button"
															onClick="savetelphonebinding()" value="提交"
															class="button_2" />
													</div>
												</fieldset>
											</td>
										</tr>
										<%
										}
										%>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--Bottom Include-->
			<jsp:include page="../user/bottom.jsp" flush="true" />
			<!--Bottom Include-->
	</body>
</html>
