<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.Constants"%>
<html>
	<head>
	
		<title>WAP参数配置</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="/dwr/interface/WapConfig.js" type="text/javascript"></script>
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
		/*
			*****************    MAS信息配置－ 通讯能力配置 － WAP  ******************
			by yesun 2007-8-2
		*/
  		 //公共变量
  	
 	var needproid='<%=Constants.EMA_NEED_ISAG_PROID+""%>';
  
   var enablewap = false;
   var canextends = true;
    var isag_canextends = true;
   	var tabPane;
   	var now_type="0";
   	var id="";
   	var ab=[[getctcc,'电信网关配置']];
		   //初始化
		window.onload = function()
		{
			
			DHTabPanel(ab,900,0,"tabs");
			
		    if(needproid=='false'){
		    	document.getElementById('emaneedproid').style.display="none";
		    }
		 } 
		 function Trim(value){
		 	return value.replace(/(^\s*)|(\s*$)/g,"");
		 }
		 
		 function getctcc(){
		 	now_type="1";
		 	$('ctcc_wapgateway').style.display="";
		 	$('gate_isag').style.display="none";
		 	$('gate_ppg').style.display="none";
		 	GetCtccConfig();
		 }
		
		 /*--------------------------------------------------------------
	       功能：取得列表
	   --------------------------------------------------------------*/
	
	 function GetCtccConfig(){
			Progress("正在读取数据....");
			WapConfig.getWapConfig(now_type,
			{
				callback:function(iwapBaseConfig){
					dwr.util.setValues(iwapBaseConfig);
					if(iwapBaseConfig!=null&&iwapBaseConfig["isag_canextends"]!=null){
						showfa();
						$("isag_canextends").checked=iwapBaseConfig["isag_canextends"];
					}else if(iwapBaseConfig!=null&&iwapBaseConfig["ppg_canextends"]!=null){
						$("ppg_canextends").checked=iwapBaseConfig["ppg_canextends"];
					}
					changegate();
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					DHalert("操作失败！失败原因"+exception.message);		
				}
			});
		}
	   
	/*--------------------------------------------------------------
		功能：更新配置
	--------------------------------------------------------------*/
	function updateWapConfig()
	{
			if(id==0){
					if($('gateurl').value == "")
					{
						 DHalert("网关URL不能为空！");
						return;
					}
					var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
					if(!reg.test($('gateurl').value)){
						DHalert("网关URL格式不正确！");
						return;
					}
					
						if($('gatepot').value == "")
					{
						 DHalert("网关端口不能为空！");
						return;
					}
					var reg2=/^\d+$/;
					if(!reg2.test($('gatepot').value)){
						DHalert("网关端口格式不正确！");
						return;
					}
						if($('gateno').value == "")
					{
						 DHalert("短信接入码不能为空！");
						return;
					}
					if(!reg2.test($('gateno').value)){
						DHalert("短信接入码格式不正确！");
						return;
					}
						if($('loginName').value == "")
					{
						DHalert("登录账号不能为空！");
						return;
					}
						if($('loginPasswd').value == "")
					{
						DHalert("登录密码不能为空！");
						return;
					}
						if($('gatserviceid').value == "")
					{
						DHalert(" 业务代码不能为空！");
						return;
					}
	
					var reg3 = /^(\+)?(\d)+$/
					var chargetermid = $('chargetermid').value;
					if(Trim(chargetermid)==""){
						DHalert("付费号码不能为空！");
						return;
					}
					if(!reg3.test(chargetermid)){
						DHalert("付费号码应为数字！");
						return;
					}
						if($('gatretry').value == "")
					{
						DHalert("失败重试次数不能为空！");
						return;
					}
					if(!reg2.test($('gatretry').value)){
						DHalert("重试次数必须为有效数字！");
						return;
					}
					Progress("正在更新数据....");
					WapConfig.saveWapConfig(id,"","ppg",$('gateurl').value,$('gatepot').value,$('gateno').value,$('loginName').value,$('loginPasswd').value,$('gatserviceid').value,$('gatretry').value,$("ctcc_wapenable").checked,canextends,$('mserviceid').value,$('getSPID').value,chargetermid,0,
						{
							callback:function(objXml) {
							if(objXml==1){
								CloseProgress();
									DHalert("短信设置操作成功！");	
								}else{
									CloseProgress();
									DHalert("操作失败！失败原因"+objXml);		
								}
							},
							errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert("操作失败！失败原因"+exception.message);		
							}
					});
			}else if(id==1){
					if($('isag_address').value==''){
						DHalert("短信地址不能为空！");	
						return;
					}
					if($('isagpwd').value==''){
						DHalert("接入密码不能为空！");	
						return;
					}
					if($('base_num').value==''){
						DHalert("接入号码不能为空！");	
						return;
					}
					if(needproid=='true'&&$('pro_id').value==''){
						DHalert("产品id不能为空！");	
						return;
					}
					var fatype="1";
					if($('fa_send').checked){
						fatype=0;
					}
					if($('fa_rece').checked){
						fatype=1;
					}
					if($('fa_no').checked){
						fatype=2;
					}
					var reg4 = /^(\+)?(\d)+$/
					if($('fa_self').checked){
						fatype=3;
						if($('fa_input').value==''){
							DHalert("FA号码不能为空！");	
							return;
						}
						if(!reg4.test($('fa_input').value)){
							DHalert("FA号码应为数字！");	
							return;
						}
					}
					if($('isag_gatretry').value == "")
					{
						DHalert("失败重试次数不能为空！");
						return;
					}
					if(!reg4.test($('isag_gatretry').value)){
						DHalert("重试次数必须为有效数字！");
						return;
					}
					if(document.getElementById('isag_canextends').checked == true)
					{
						isag_canextends = true;
					}else{
						isag_canextends = false;
					}
					Progress("正在更新数据....");
					WapConfig.saveISAGConfig(id,$('isag_address').value,$('isag_spid').value,$('isagpwd').value,$('base_num').value,$('pro_id').value,fatype,$('fa_input').value,$('order_num').value,$('unorder_num').value,$('isag_gatretry').value,isag_canextends,$("ctcc_wapenable").checked,
						{
							callback:function(objXml) {
							if(objXml==1){
									CloseProgress();
									DHalert("wap设置操作成功！");	
								}else{
									CloseProgress();
									DHalert("操作失败！失败原因"+objXml);		
								}
							},
							errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert("操作失败！失败原因"+exception.message);		
							}
					});
			}
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
	function showfa(){
		if($('fa_self').checked){
			$('fa_tr').style.display="";
		}else{
			$('fa_tr').style.display="none";
		}
	}
	
	function changegate(){
		if(now_type=="0"){
		}else if(now_type=="2"){
		}else if(now_type=="1"){
			if($("ctcc_isag").selected){
				id=1;
				$('gate_ppg').style.display="none";
				$('gate_isag').style.display="";
			}else{
				id=0;
				$('gate_ppg').style.display="";
				$('gate_isag').style.display="none";
			}
		}
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
						<%--
						<tr>
							<td width="1%">
								<img src="../theme/images/alert_left.gif" width="5" height="29" />
							</td>
							<td width="2%">
								<img src="../theme/images/alert_bug.gif" />
							</td>
							<td width="90%">
								wap参数配置 
							</td>
							<td width="2%">
								<a href="#"><img src="../theme/images/alert_right.gif"
										width="24" height="29" border="0" /> </a>
							</td>
						</tr>
						--%>
					</table>
					<div id="center_nav_box">
						<div id="center_nav">您现在所在位置 >>  配置管理 >> WAP参数配置</div>
					</div>	
					<br/>
					<span style="padding:6px 0px 0px 12px;"><b>移动、联通WAP使用短信网关,相关参数请在<a class="blue_12" style="text-decoration: underline" href="./admin_cmability_sms.jsp">短信参数配置</a>中进行设置</b></span>
					<div id="tabs" style="border:1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								
								<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="5">
									<tr>
										<td colspan="5" valign="top">
								<!--  ###############################   电信    ################################ -->
											
											<table width="55%" border="0" align="center" cellpadding="0" align="center"
												cellpadding="0"  cellspacing="4" id = "ctcc_wapgateway" style="display:none">
												<tr>
													<td width="36%">
														<input type="checkbox" id="ctcc_wapenable" checked="checked"/>
														<label for="ctcc_wapenable">
															开通WAP能力
														</label>
													</td>
													<td ></td>
												</tr>
												<tr >
													<td class="text_icon2" >
														WAP网关类型：
													</td>
													<td class="height25" >
														<select id="ctcc_wapgatetype" style="width: 120px;"
															onmouseover="fEvent('mouseover',this)"
															onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
															onmouseout="fEvent('mouseout',this)" onchange="changegate()">
															<option id="ctcc_isag" value="isag">
																ISAG网关
															</option>
														</select>
													</td>
												</tr>
											</table>
											<table width="55%" height="200" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_ppg">
													<tr>
														<td class="text_icon2" width="36%">
															行业网关地址：														</td>
														<td >
															<input type="text" id="gateurl" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>													</td>
													</tr>
													<tr>
														<td class="text_icon2">
															行业网关端口：														</td>
														<td>
															<input type="text" id="gatepot" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="5"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															wap接入码：														</td>
														<td>
															<input type="text" id="gateno" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"/>		<input type="checkbox" id="canextends" />
															<label for="canextends">
																可扩展									
															</label>
															</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录帐号：														</td>
														<td>
															<input type="text" id="loginName" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录密码：														</td>
														<td>
															<input type="password" id="loginPasswd" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															业务代码：														</td>
														<td>
															<input type="text" id="gatserviceid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															付费号码：														</td>
														<td>
															<input type="text" id="chargetermid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="21" />														</td>
													</tr>
												<tr>
														<td class="text_icon2">
															SPID：														</td>
														<td>
															<input type="text" id="getSPID" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
												
													<tr>
														<td class="text_icon2">
															Mserviceid：														</td>
														<td>
															<input type="text" id="mserviceid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
												
													<tr>
														<td class="text_icon2">
															失败重试次数：														</td>
														<td>
															<input type="text" id="gatretry" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="1" />														</td>
													</tr>
												</table>
											
												<table width="55%" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_isag">
													<tr>
														<td class="text_icon2"  width="36%">wap地址：</td>
														<td  width="64%">
															<input type="text" id="isag_address" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="60"/>
														</td>
													</tr>
													<tr>
														<td class="text_icon2" width="150">SPID：</td>
														<td>
															<input type="text" id="isag_spid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															接入密码：														</td>
														<td>
															<input type="password" id="isagpwd" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>
																
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															接入号码：														</td>
														<td>
															<input type="text" id="base_num" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"/>	<input type="checkbox" id="isag_canextends" />
															<label for="isag_canextends">
																可扩展									
															</label>
														</td>
													</tr>
													
													<tr id="emaneedproid">
														<td class="text_icon2">
															产品id：														</td>
														<td>
															<input type="text" id="pro_id" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>
																
														</td>
													</tr>
													
													<tr>
														<td class="text_icon2">
															FA：														</td>
														<td>
															<input type="radio" id="fa_send" name="fa" onclick ="showfa()"/>发送号码
															<input type="radio" id="fa_rece" name="fa" checked onclick ="showfa()"/>被叫号码
															<input type="radio" id="fa_no" name="fa" onclick ="showfa()"/>无
															<input type="radio" id="fa_self" name="fa" onclick ="showfa()"/>自定义
															
														</td>
													</tr>
													<tr id="fa_tr" style="display:none">
														<td class="text_icon2">
															FA号码：														</td>
														<td>
															<input type="text" id="fa_input" /> 
														</td>
													</tr>
													<tr style="display:none">
														<td class="text_icon2">
															订购命令字：														</td>
														<td>
															<input type="text" id="order_num" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" />
																
														</td>
													</tr>
													<tr style="display:none">
														<td class="text_icon2">
															取消订购命令字：														</td>
														<td>
															<input type="text" id="unorder_num" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" />
																
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															失败重试次数：														</td>
														<td>
															<input type="text" id="isag_gatretry" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="1" />														</td>
													</tr>
												</table>

											<div class="center_nav_line"></div>	
											<div class="div_center padding_5">
															  <input name="image" type="image"
																	onClick="javascript:updateWapConfig();return false;"
																	value="保存设置"
																	src="../skin/default/images/button_save.gif"
																	width="60px" height="22px" />
														</div>	
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