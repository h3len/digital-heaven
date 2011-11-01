<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.Constants"%>
<html>
	<head>
	
		<title>短信参数配置</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="/dwr/interface/SmsConfig.js" type="text/javascript"></script>
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
			*****************    MAS信息配置－ 通讯能力配置 － 短信  ******************
			by yesun 2007-8-2
		*/
  		 //公共变量
  	
 	var needproid='<%=Constants.EMA_NEED_ISAG_PROID+""%>';
  
   var enablesms = false;
   var canextends = true;
    var isag_canextends = true;
   	var tabPane;
   	var now_type="0";
   	var id="";
   	var ab=[[getcmcc,'移动网关配置']];
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
		 function getcmcc(){
		 	now_type="0";
		 	$('cmcc_smsgateway').style.display="";
		 	$('ctcc_smsgateway').style.display="none";
		 	$('gate_isag').style.display="none";
		 	$('gate_sgip').style.display="none";
		 	$('gate_cmpp2').style.display="none";
		 	$('gate_cmpp3').style.display="none";
		 	$('gate_smgp').style.display="none";
		 	GetCmccConfig();
		 }
		 
		 function getctcc(){
		 	now_type="1";
		 	$('ctcc_smsgateway').style.display="";
		 	$('cmcc_smsgateway').style.display="none";
		 	$('gate_isag').style.display="none";
		 	$('gate_sgip').style.display="none";
		 	$('gate_cmpp2').style.display="none";
		 	$('gate_cmpp3').style.display="none";
		 	$('gate_smgp').style.display="none";
		 	GetCtccConfig();
		 }
		
		 function getunicom(){
		 	now_type="2";
		 	$('ctcc_smsgateway').style.display="none";
		 	$('cmcc_smsgateway').style.display="none";
		 	$('gate_isag').style.display="none";
		 	$('gate_cmpp2').style.display="none";
		 	$('gate_cmpp3').style.display="none";
		 	$('gate_smgp').style.display="none";
		 	GetUnicomConfig();
		 	$('gate_sgip').style.display="";
		 }
		 /*--------------------------------------------------------------
	       功能：取得列表
	   --------------------------------------------------------------*/
	
     function GetCmccConfig(){
			Progress("正在读取数据....");
			SmsConfig.getSMSConfig(now_type,function(ismsBaseConfig){
			dwr.util.setValues(ismsBaseConfig);
			if(ismsBaseConfig!=null&&ismsBaseConfig["cmpp2_canextends"]!=null){
				$("cmpp2_canextends").checked=ismsBaseConfig["cmpp2_canextends"];
			}else if(ismsBaseConfig!=null&&ismsBaseConfig["cmpp3_canextends"]!=null){
				$("cmpp3_canextends").checked=ismsBaseConfig["cmpp3_canextends"];
			}
			changegate();
			CloseProgress();
 			});
	 }
	 function GetCtccConfig(){
			Progress("正在读取数据....");
			SmsConfig.getSMSConfig(now_type,function(ismsBaseConfig){
				dwr.util.setValues(ismsBaseConfig);
				if(ismsBaseConfig!=null&&ismsBaseConfig["isag_canextends"]!=null){
					showfa();
					$("isag_canextends").checked=ismsBaseConfig["isag_canextends"];
				}else if(ismsBaseConfig!=null&&ismsBaseConfig["smgp_canextends"]!=null){
					$("smgp_canextends").checked=ismsBaseConfig["smgp_canextends"];
				}
				changegate();
				CloseProgress();
			});
		}
   	 function GetUnicomConfig(){
		Progress("正在读取数据....");
		SmsConfig.getSMSConfig(now_type,function(ismsBaseConfig){
			dwr.util.setValues(ismsBaseConfig);
			if(ismsBaseConfig!=null)
				$("sgip_canextends").checked=ismsBaseConfig["sgip_canextends"];
			changegate();
			CloseProgress();
		});
	 }
	   
	/*--------------------------------------------------------------
		功能：更新配置
	--------------------------------------------------------------*/
	function updateSMSConfig()
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
					if(document.getElementById('smgp_canextends').checked == true)
					{
						canextends = true;
					}else{
						canextends = false;
					}
					
					Progress("正在更新数据....");
					SmsConfig.saveSMSConfig(id,"","smgp",$('gateurl').value,$('gatepot').value,$('gateno').value,$('loginName').value,$('loginPasswd').value,$('gatserviceid').value,$('gatretry').value,$("ctcc_smsenable").checked,canextends,$('mserviceid').value,$('getSPID').value,chargetermid,0,0,
						{
							callback:function(objXml) {
							if(objXml=="1"){
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
					SmsConfig.saveISAGConfig(id,$('isag_address').value,$('isag_spid').value,$('isagpwd').value,$('base_num').value,$('pro_id').value,fatype,$('fa_input').value,$('order_num').value,$('unorder_num').value,$('isag_gatretry').value,isag_canextends,$("ctcc_smsenable").checked,
						{
							callback:function(objXml) {
							if(objXml=="1"){
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
			}else if(id==2){
					if($('sgip_gateurl').value == "")
					{
						 DHalert("行业网关地址不能为空！");
						return;
					}
					var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
					if(!reg.test($('sgip_gateurl').value)){
						DHalert("行业网关地址格式不正确！");
						return;
					}
					
					if($('sgip_gatepot').value == "")
					{
						 DHalert("网关端口不能为空！");
						return;
					}
					var reg2=/^\d+$/;
					if(!reg2.test($('sgip_gatepot').value)){
						DHalert("网关端口格式不正确！");
						return;
					}
					if($('sgip_listenport').value == "")
					{
						 DHalert("监听端口不能为空！");
						return;
					}
					if(!reg2.test($('sgip_listenport').value)){
						DHalert("监听端口格式不正确！");
						return;
					}
						if($('sgip_gateno').value == "")
					{
						 DHalert("短信接入码不能为空！");
						return;
					}
					if(!reg2.test($('sgip_gateno').value)){
						DHalert("短信接入码格式不正确！");
						return;
					}
						if($('sgip_loginName').value == "")
					{
						DHalert("登录账号不能为空！");
						return;
					}
						if($('sgip_loginPasswd').value == "")
					{
						DHalert("登录密码不能为空！");
						return;
					}
						if($('sgip_gatserviceid').value == "")
					{
						DHalert(" 业务代码不能为空！");
						return;
					}
						if($('sgip_getCORPID').value == "")
					{
						DHalert(" 企业代码不能为空！");
						return;
					}
					var reg3 = /^(\+)?(\d)+$/
					var chargetermid = $('sgip_chargetermid').value;
					if(Trim(chargetermid)!=""&&!reg3.test(chargetermid)){
						DHalert("付费号码应为数字！");
						return;
					}
						if($('sgip_gatretry').value == "")
					{
						DHalert("失败重试次数不能为空！");
						return;
					}
					if(!reg2.test($('sgip_gatretry').value)){
						DHalert("重试次数必须为有效数字！");
						return;
					}
					var sgip_nodenum = $('sgip_nodenum').value;
					if(Trim(sgip_nodenum)!=""&&!reg3.test(sgip_nodenum)){
						DHalert("节点编号必须为数字！");
						return;
					}
					if($('sgip_canextends').checked){
						canextends = true;
					}else{
						canextends = false;
					}
					Progress("正在更新数据....");
					SmsConfig.saveSMSConfig(id,$('sgip_getCORPID').value,"sgip",$('sgip_gateurl').value,$('sgip_gatepot').value,$('sgip_gateno').value,$('sgip_loginName').value,$('sgip_loginPasswd').value,$('sgip_gatserviceid').value,$('sgip_gatretry').value,$("unicom_smsenable").checked,canextends,$('sgip_mserviceid').value,$('sgip_getSPID').value,chargetermid,sgip_nodenum,$('sgip_listenport').value,
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
			}else if(id==3){
				if($('cmpp2_gateurl').value == "")
				{
					DHalert("行业网关地址不能为空！");
					return;
				}
				var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
					if(!reg.test($('cmpp2_gateurl').value)){
						DHalert("行业网关地址格式不正确！");
						return;
					}
					if($('cmpp2_gatepot').value == "")
				{
					DHalert("行业网关端口不能为空！");
					return;
				}
					if($('cmpp2_gateno').value == "")
				{
					DHalert("短信号码不能为空！");
					return;
				}
					if($('cmpp2_gatSPID').value == "")
				{
					DHalert("登录帐号不能为空！");
					return;
				}
					if($('cmpp2_gatSPpass').value == "")
				{
					DHalert("登录密码不能为空！");
					return;
				}
					if($('cmpp2_gatserviceid').value == "")
				{
					DHalert("业务号码不能为空！");
					return;
				}
					if($('cmpp2_gatretry').value == "")
				{
					DHalert("失败重试次数不能为空！");
					return;
				}
				var reg2=/^\d+$/;
				if(!reg2.test($('cmpp2_gatretry').value)){
						DHalert("重试次数必须为有效数字！");
						return;
				}
				if($('cmpp2_canextends').checked){
					canextends = true;
				}else{
					canextends = false;
				}
				SmsConfig.saveSMSConfig(id,"","cmpp2",$('cmpp2_gateurl').value,$('cmpp2_gatepot').value,$('cmpp2_gateno').value,$('cmpp2_gatSPID').value,$('cmpp2_gatSPpass').value,$('cmpp2_gatserviceid').value,$('cmpp2_gatretry').value,$("cmcc_smsenable").checked,canextends,"","","",0,"",
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
		}else if(id==4){
				if($('cmpp3_gateurl').value == "")
				{
					DHalert("网关URL不能为空！");
					return;
				}
		
					if($('cmpp3_gatepot').value == "")
				{
					DHalert("网关端口不能为空！");
					return;
				}
					if($('cmpp3_gateno').value == "")
				{
					DHalert("短信号码不能为空！");
					return;
				}
					if($('cmpp3_gatSPID').value == "")
				{
					DHalert("SPID不能为空！");
					return;
				}
					if($('cmpp3_gatSPpass').value == "")
				{
					DHalert("SP密码不能为空！");
					return;
				}
					if($('cmpp3_gatserviceid').value == "")
				{
					DHalert("服务号码不能为空！");
					return;
				}
					if($('cmpp3_gatretry').value == "")
				{
					DHalert("失败重试次数不能为空！");
					return;
				}
				if($('cmpp3_canextends').checked){
					canextends = true;
				}else{
					canextends = false;
				}
				SmsConfig.saveSMSConfig(id,"","cmpp3",$('cmpp3_gateurl').value,$('cmpp3_gatepot').value,$('cmpp3_gateno').value,$('cmpp3_gatSPID').value,$('cmpp3_gatSPpass').value,$('cmpp3_gatserviceid').value,$('cmpp3_gatretry').value,$("cmcc_smsenable").checked,canextends,"","","",0,"",
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
			if($("cmcc_cmpp2").selected){
				id=3;
				$('gate_cmpp2').style.display="";
				$('gate_cmpp3').style.display="none";
			}else{
				id=4;
				$('gate_cmpp2').style.display="none";
				$('gate_cmpp3').style.display="";
			}
		}else if(now_type=="2"){
			id=2;
		}else if(now_type=="1"){
			if($("ctcc_smgp").selected){
				id=0;
				$('gate_smgp').style.display="";
				$('gate_isag').style.display="none";
			}else{
				id=1;
				$('gate_smgp').style.display="none";
				$('gate_isag').style.display="";
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
								短信参数配置 
							</td>
							<td width="2%">
								<a href="#"><img src="../theme/images/alert_right.gif"
										width="24" height="29" border="0" /> </a>
							</td>
						</tr>
						--%>
					</table>
					<div id="center_nav_box">
						<div id="center_nav">您现在所在位置 >>  配置管理 >> 短信参数配置</div>
					</div>	
					<div id="tabs" style="border:1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								
								<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="5">
									<tr>
										<td colspan="5" valign="top">
										
							<!--  ###############################   移动    ################################ -->				
											<table width="55%" border="0"  align="center" cellpadding="0"
													cellspacing="4" id = "cmcc_smsgateway" >
												<tr>
													<td width="36%">
														<input type="checkbox" id="cmcc_smsenable" checked="checked"/>
														<label for="cmcc_smsenable">
															开通SMS能力
														</label>
													</td>
													<td ></td>
												</tr>
												<tr >
													<td class="text_icon2" >
														短信网关类型：
													</td>
													<td class="height25" >
														<select id="cmcc_smsgatetype" style="width: 120px;"
															onmouseover="fEvent('mouseover',this)"
															onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
															onmouseout="fEvent('mouseout',this)" onchange="changegate()">
															<option id="cmcc_cmpp2" value="cmpp2">
																CMPP2网关
															</option>
															<option id="cmcc_cmpp3" value="cmpp3">
																CMPP3网关
															</option>
														</select>
													</td>
												</tr>
											</table>
												<table width="55%" height="200" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_cmpp2" >
													<tr>
														<td class="text_icon2" width="36%">
															行业网关地址：
														</td>
														<td >
															<input type="text" id="cmpp2_gateurl"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															行业网关端口：
														</td>
														<td>
															<input type="text" id="cmpp2_gatepot" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															短信号码：
														</td>
														<td>
															<input type="text" id="cmpp2_gateno" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
																<input type="checkbox" id="cmpp2_canextends" />
															<label for="cmpp2_canextends">
																可扩展									
															</label>
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录帐号：
														</td>
														<td>
															<input type="text" id="cmpp2_gatSPID" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录密码：
														</td>
														<td>
															<input type="password" id="cmpp2_gatSPpass"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<%--<tr>
														<td class="text_icon2">
															Msg_src：
														</td>
														<td align="left">
															<input type="text" id="msg_src" class="input_120px"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" />
															(可不填)
														</td>
													</tr>--%>
													<tr>
														<td class="text_icon2">
															业务号码：
														</td>
														<td>
															<input type="text" id="cmpp2_gatserviceid"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															失败重试次数：
														</td>
														<td >
															<input type="text" id="cmpp2_gatretry"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="1" />
														</td>
													</tr>
											</table>
											<table width="55%" height="200" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_cmpp3" style="display:none">
													<tr>
														<td class="text_icon2" width="36%">
															行业网关地址：
														</td>
														<td >
															<input type="text" id="cmpp3_gateurl"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															行业网关端口：
														</td>
														<td>
															<input type="text" id="cmpp3_gatepot" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															短信号码：
														</td>
														<td>
															<input type="text" id="cmpp3_gateno" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
																<input type="checkbox" id="cmpp3_canextends" />
															<label for="cmpp3_canextends">
																可扩展									
															</label>
														</td>
														
													</tr>
													<tr>
														<td class="text_icon2">
															登录帐号：
														</td>
														<td>
															<input type="text" id="cmpp3_gatSPID" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录密码：
														</td>
														<td>
															<input type="password" id="cmpp3_gatSPpass"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<%--<tr>
														<td class="text_icon2">
															Msg_src：
														</td>
														<td align="left">
															<input type="text" id="msg_src" class="input_120px"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" />
															(可不填)
														</td>
													</tr>--%>
													<tr>
														<td class="text_icon2">
															业务号码：
														</td>
														<td>
															<input type="text" id="cmpp3_gatserviceid"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30" />
														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															失败重试次数：
														</td>
														<td >
															<input type="text" id="cmpp3_gatretry"class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="1" />
														</td>
													</tr>
											</table>
							<!--  ###############################   联通    ################################ -->
												<table width="55%" height="200" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_sgip" style="display:none">
													<tr >
														<td width="36%">
															<input type="checkbox" id="unicom_smsenable" checked="checked"/>
															<label for="unicom_smsenable">
																开通SMS能力
															</label>
														</td>
														<td ></td>
													</tr>
													<tr>
														<td class="text_icon2" width="36%">
															行业网关地址：														</td>
														<td width="64%">
															<input type="text" id="sgip_gateurl" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>													</td>
													</tr>
													<tr>
														<td class="text_icon2">
															行业网关端口：														</td>
														<td>
															<input type="text" id="sgip_gatepot" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="5"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															短信监听端口：														</td>
														<td>
															<input type="text" id="sgip_listenport" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="5"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															短信接入码：														</td>
														<td>
															<input type="text" id="sgip_gateno" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"/>		<input type="checkbox" id="sgip_canextends" />
															<label for="sgip_canextends">
																可扩展									
															</label>
															</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录帐号：														</td>
														<td>
															<input type="text" id="sgip_loginName" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															登录密码：														</td>
														<td>
															<input type="password" id="sgip_loginPasswd" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															业务代码：														</td>
														<td>
															<input type="text" id="sgip_gatserviceid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															付费号码：														</td>
														<td>
															<input type="text" id="sgip_chargetermid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="21" />														</td>
													</tr>
												<tr>
														<td class="text_icon2">
															SPID：														</td>
														<td>
															<input type="text" id="sgip_getSPID" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
												<tr>
														<td class="text_icon2">
															企业代码：														</td>
														<td>
															<input type="text" id="sgip_getCORPID" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
												
													<tr style="display:none">
														<td class="text_icon2">
															Mserviceid：														</td>
														<td>
															<input type="text" id="sgip_mserviceid" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="30"/>														</td>
													</tr>
													<tr>
														<td class="text_icon2">
															节点编号：														</td>
														<td>
															<input type="text" id="sgip_nodenum" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="4"/>														</td>
													</tr>
												
													<tr>
														<td class="text_icon2">
															失败重试次数：														</td>
														<td>
															<input type="text" id="sgip_gatretry" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="1" />														</td>
													</tr>
												</table>
												<!--  ###############################   电信    ################################ -->
											
											<table width="55%" border="0" align="center" cellpadding="0" align="center"
												cellpadding="0"  cellspacing="4" id = "ctcc_smsgateway" style="display:none">
												<tr>
													<td width="36%">
														<input type="checkbox" id="ctcc_smsenable" checked="checked"/>
														<label for="ctcc_smsenable">
															开通SMS能力
														</label>
													</td>
													<td ></td>
												</tr>
												<tr >
													<td class="text_icon2" >
														短信网关类型：
													</td>
													<td class="height25" >
														<select id="ctcc_smsgatetype" style="width: 120px;"
															onmouseover="fEvent('mouseover',this)"
															onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
															onmouseout="fEvent('mouseout',this)" onchange="changegate()">
															<option id="ctcc_isag" value="isag">
																ISAG网关
															</option>
															<option id="ctcc_smgp" value="smgp">
																SMGP网关
															</option>
														</select>
													</td>
												</tr>
											</table>
											<table width="55%" height="200" border="0" align="center"
													cellpadding="0" cellspacing="4" id="gate_smgp" style="display:none">
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
															短信接入码：														</td>
														<td>
															<input type="text" id="gateno" class="input_text"
																onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" maxlength="20"/>		<input type="checkbox" id="smgp_canextends" />
															<label for="smgp_canextends">
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
													cellpadding="0" cellspacing="4" id="gate_isag" style="display:none">
													<tr>
														<td class="text_icon2"  width="36%">短信地址：</td>
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
																	onClick="javascript:updateSMSConfig();return false;"
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