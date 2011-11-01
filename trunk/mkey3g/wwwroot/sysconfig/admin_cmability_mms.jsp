<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.Constants"%>
<html>
	<head>
	
		<title>彩信参数配置</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="/dwr/interface/MmsConfig.js" type="text/javascript"></script>
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
   var reg=/^\d+$/;
   var enablesms = false;
   var canextends = true;
    var isag_canextends = true;
   	var tabPane;
   	var now_type="0";
   	var ab=[[getcmcc,'移动网关配置']];
		   //初始化
		window.onload = function()
		{
			
			DHTabPanel(ab,900,0,"tabs");
			
		    if(needproid=='false'){
		    	document.getElementById('ctcc_emaneedproid').style.display="none";
		    }
		 } 
		 function Trim(value){
		 	return value.replace(/(^\s*)|(\s*$)/g,"");
		 }
		 function getcmcc(){
		 	now_type="0";
		 	changegate();
		 	$('cmcc').style.display="";
		 	$('ctcc_mmsgateway').style.display="none";
		 	$('unicom').style.display="none";
		 	GetCmccConfig();
		 }
		 //
		 function getctcc(){
		 	now_type="1";
		 	$('cmcc').style.display="none";
		 	$('ctcc_mmsgateway').style.display="";
		 	$('unicom').style.display="none";
		 	GetCtccConfig();
		 } 
		 
		 function getunicom(){
		 	now_type="2";
		 	changegate();
		 	$('cmcc').style.display="none";
		 	$('ctcc_mmsgateway').style.display="none";
		 	$('ctcc_gate_vas').style.display="none";
		 	$('unicom').style.display="";
		 	GetUnicomConfig();
		 } 
		 
		 /*--------------------------------------------------------------
	       功能：取得列表
	   --------------------------------------------------------------*/
	
     function GetCtccConfig(){
			Progress("正在读取数据....");
			MmsConfig.getMMSConfig(now_type,function(ismsBaseConfig){
				if(ismsBaseConfig!=null){
					dwr.util.setValues(ismsBaseConfig);
					showfa();
					$("ctcc_isag_canextends").checked=ismsBaseConfig["ctcc_isag_canextends"];
				}
				changegate();
				CloseProgress();
 			});
	 }
	 function GetCmccConfig(){
			Progress("正在读取数据....");
			MmsConfig.getMMSConfig(now_type,function(ismsBaseConfig){
				if(ismsBaseConfig!=null){
					dwr.util.setValues(ismsBaseConfig);
					$('cmcc_canextends').checked=ismsBaseConfig['cmcc_canextends'];
				}
				CloseProgress();
			});
		}
   	 function GetUnicomConfig(){
		Progress("正在读取数据....");
		MmsConfig.getMMSConfig(now_type,function(ismsBaseConfig){
			if(ismsBaseConfig!=null){
				dwr.util.setValues(ismsBaseConfig);
				$("unicom_canextends").checked=ismsBaseConfig["unicom_canextends"];
			}
			CloseProgress();
		});
	 }
	  
	   
	/*--------------------------------------------------------------
		功能：更新配置
	--------------------------------------------------------------*/
	function updateSMSConfig()
	{
		var operator = "cmcc_";
			if (now_type == "1")
				operator = "ctcc_";
			else if (now_type == "2")
				operator = "unicom_";
		if(now_type=="0"||now_type=="2"||(now_type=="1"&&$('ctcc_vas').selected)){
			if($(operator+'mmscUrl').value == "")
			{
				DHalert("网关URL不能为空！");
				return;
			}
			if($(operator+'mmscIp').value == "")
			{
				 DHalert("网关IP不能为空！");
				return;
			}
				var regIp = /^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)(:\d{1,5})?$/;
			if(!regIp.test($(operator+'mmscIp').value))
			{
				 DHalert("网关IP是无效的！");
				return;
			}
				if($(operator+'username').value == "")
			{
				$(operator+'username').value="admin";
			}
				if($(operator+'password').value == "")
			{
				$(operator+'username').value="password";
			}
				if($(operator+'vasid').value == "")
			{
				 DHalert("服务号码不能为空！");
				return;
			}
				if(!reg.test($(operator+'vasid').value))
			{
				 DHalert("服务号码只能输入有效数字！");
				return;
			}
				if($(operator+'vaspid').value == "")
			{
				DHalert("企业代码不能为空！");
				return;
			}
				if(!reg.test($(operator+'vaspid').value))
			{
				 DHalert("企业代码只能输入有效数字！");
				return;
			}
				if($(operator+'serviceCode').value == "")
			{
				DHalert("业务代码不能为空！");
				return;
			}
				if(!reg.test($(operator+'serviceCode').value))
			{
				DHalert("业务代码只能输入有效数字！");
				return;
			}
				if($(operator+'senderAddress').value == "")
			{
				DHalert("发送号码不能为空！");
				return;
			}
				if(!reg.test($(operator+'senderAddress').value))
			{
				DHalert("发送号码只能输入有效数字！");
				return;
			}	
			
			if($(operator+'listenport').value == "")
			{
				DHalert("彩信监听端口不能为空！");
				return;
			}
			var regLis = /^\d{1,5}$/;
			if(!regLis.test($(operator+'listenport').value)){
				DHalert("彩信监听端口为1到5位数字！");
				return;
			}
			var chargedParty = getRadioValue(operator+"chargedParty");
			if($(operator+'chargedPartyId').value == ""){
				DHalert("资费号码不能为空！");
				return;
			}
			if(!reg.test($(operator+'chargedPartyId').value)){
				DHalert("自费号码必须为有效数字！");
				return;
			}
			if($(operator+'timeout').value == "")
			{
				 DHalert("第一次失败超时时间不能为空！");
				return;
			}
				if(!reg.test($(operator+'timeout').value))
			{
				 DHalert("第一次失败超时时间只能输入数字！");
				return;
			}
			
				if($(operator+'reSendCount').value == "")
			{
				 DHalert("失败重试次数不能为空！");
				return;
			}
				if(!reg.test($(operator+'reSendCount').value))
			{
				 DHalert("失败重试次数只能输入有效数字！");
				return;
			}
			MmsConfig.saveMMSCConfig(now_type,$(operator+"mmscUrl").value,$(operator+"mmscIp").value,
			$(operator+'username').value,$(operator+'password').value,$(operator+'timeout').value,
			$(operator+'reSendCount').value,$(operator+'vasid').value,$(operator+'vaspid').value,
			$(operator+'serviceCode').value,$(operator+'senderAddress').value,
			$(operator+'mmsenable').checked,$(operator+'canextends').checked,$(operator+'listenport').value,chargedParty,$(operator+'chargedPartyId').value,
				{
					callback:function(objXml) {
						DHalert("彩信配置操作成功！");
					},
					errorHandler:function(errorString, exception) {
						DHalert("操作失败，请重试！\n失败原因"+exception.message);
					}
				});
		}else{
			if($(operator+'isag_address').value==''){
				DHalert("彩信地址不能为空！");	
				return;
			}
			if($(operator+'isag_password').value==''){
				DHalert("接入密码不能为空！");	
				return;
			}
			if($(operator+'isag_spid').value==''){
				DHalert("SPID不能为空！");	
				return;
			}
			if($(operator+'base_num').value==''){
				DHalert("接入号码不能为空！");	
				return;
			}
			if(needproid=='true'&&$(operator+'pro_id').value==''){
				DHalert("产品id不能为空！");	
				return;
			}
			var fatype="1";
			if($(operator+'fa_send').checked){
				fatype=0;
			}
			if($(operator+'fa_rece').checked){
				fatype=1;
			}
			if($(operator+'fa_no').checked){
				fatype=2;
			}
			var reg4 = /^(\+)?(\d)+$/
			if($(operator+'fa_self').checked){
				fatype=3;
				if($(operator+'fa_input').value==''){
					DHalert("FA号码不能为空！");	
					return;
				}
				if(!reg4.test($(operator+'fa_input').value)){
					DHalert("FA号码应为数字！");	
					return;
				}
			}
			Progress("正在更新数据....");
			MmsConfig.saveMMSIsagConfig($(operator+'isag_address').value,$(operator+'isag_spid').value,$(operator+'isag_password').value,$(operator+'base_num').value,$(operator+'pro_id').value,fatype,$(operator+'fa_input').value,$(operator+'order_num').value,$(operator+'unorder_num').value,$(operator+'isag_canextends').checked,$(operator+'mmsenable').checked,
				{
					callback:function() {
						CloseProgress();
						DHalert("彩信设置操作成功！");	
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
		if($('ctcc_fa_self').checked){
			$('ctcc_fa_tr').style.display="";
		}else{
			$('ctcc_fa_tr').style.display="none";
		}
	}
	function changegate(){
		if(now_type!="1"){
			$('ctcc_gate_vas').style.display="none";
			$('ctcc_gate_isag').style.display="none";
		}else if($('ctcc_vas').selected){
			$('ctcc_gate_vas').style.display="";
			$('ctcc_gate_isag').style.display="none";
		}else{
			$('ctcc_gate_vas').style.display="none";
			$('ctcc_gate_isag').style.display="";
		}
	}
	
	 /********************************************
	   	功能：得到被选中的radio的value
	   	by chb  2008-12-15
	   *********************************************/
	   function getRadioValue(radioName){
	   		var cp = document.getElementsByName(radioName);
			for(var i=0;i<cp.length;i++){
				if(cp[i].checked==true){
					return cp[i].value;
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
					</table>
					<div id="center_nav_box">
						<div id="center_nav">您现在所在位置 >>  配置管理 >> 彩信参数配置</div>
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
								<table width="55%" border="0" align="center" cellpadding="0"
									cellspacing="4"  id="cmcc">
									<tr >
										<td width="27%">
											<input type="checkbox" id="cmcc_mmsenable" checked="checked"/>
											<label for="cmcc_mmsenable">
												开通MMS能力
											</label>
										</td>
										<td ></td>
									</tr>
									<tr>
										<td class="text_icon2" >
											网关IP：
										</td>
										<td>
											<input type="text" id="cmcc_mmscIp" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											网关URL：
										</td>
										<td>
											<input type="text" id="cmcc_mmscUrl" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											服务号码：
										</td>
										<td>
											<input type="text" id="cmcc_vasid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											企业代码：
										</td>
										<td>
											<input type="text" id="cmcc_vaspid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											业务代码：
										</td>
										<td>
											<input type="text" id="cmcc_serviceCode" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											发送号码：
										</td>
										<td>
											<input type="text" id="cmcc_senderAddress" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
											<input type="checkbox" id="cmcc_canextends" checked />
											<label for="canextends">
												可扩展
											</label>
										</td>
									</tr>


									<tr>
										<td class="text_icon2">
											彩信监听端口：
										</td>
										<td>
											<input type="text" id="cmcc_listenport" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=5>
											<font color=#ff0000>提示：如果修改此端口需要重启服务器</font>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费方式：
										</td>
										<td >
											<input type="radio" id="cmcc_sender" name="cmcc_chargedParty" value="0" />
											发送方
											<input type="radio" id="cmcc_recipient" name="cmcc_chargedParty"
												value="1" />
											接收方
											<input type="radio" id="cmcc_thirdParty" name="cmcc_chargedParty"
												value="4" />
											第三方
											<input type="radio" id="cmcc_both" name="cmcc_chargedParty" value="2" />
											双方都收费
											<br/>
											<input type="radio" id="cmcc_neither" name="cmcc_chargedParty"
												value="3" />
											双方都不收费
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费号码：
										</td>
										<td>
											<input type="text" id="cmcc_chargedPartyId" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											第一次失败超时时间：
										</td>
										<td>
											<input type="text" id="cmcc_timeout" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											失败重试次数：
										</td>
										<td>
											<input type="text" id="cmcc_reSendCount" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
											<input type="hidden" id="cmcc_username" value="admin">
											<input type="hidden" id="cmcc_password" value="password" >
										</td>
									</tr>
									<tr>
										<td colspan="2">
										</td>
									</tr>
								</table>
								
								
								<!--  ###############################   电信    ################################ -->
								<table width="55%" border="0" align="center" cellpadding="0"
									cellspacing="4" id = "ctcc_mmsgateway" style="display:none">
									<tr>
										<td width="27%">
											<input type="checkbox" id="ctcc_mmsenable" checked="checked"/>
											<label for="ctcc_mmsenable">
												开通MMS能力
											</label>
										</td>
										<td ></td>
									</tr>
									<tr >
										<td class="text_icon2" >
											彩信网关类型：
										</td>
										<td class="height25" >
											<select id="ctcc_mmsgatetype" style="width: 120px;"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" onchange="changegate()">
												<option id="ctcc_vas" value="vas">
													VAS MM7网关
												</option>
												<option id="ctcc_isag" value="isag">
													ISAG网关
												</option>
											</select>
										</td>
									</tr>
								</table>
								<table width="55%" border="0" align="center" cellpadding="0"
									cellspacing="5" id="ctcc_gate_vas" style="display:none">
									<tr>
										<td class="text_icon2" width="27%">
											网关IP：
										</td>
										<td>
											<input type="text" id="ctcc_mmscIp" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											网关URL：
										</td>
										<td>
											<input type="text" id="ctcc_mmscUrl" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											服务号码：
										</td>
										<td>
											<input type="text" id="ctcc_vasid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											企业代码：
										</td>
										<td>
											<input type="text" id="ctcc_vaspid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											业务代码：
										</td>
										<td>
											<input type="text" id="ctcc_serviceCode" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											发送号码：
										</td>
										<td>
											<input type="text" id="ctcc_senderAddress" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
											<input type="checkbox" id="ctcc_canextends" checked />
											<label for="canextends">
												可扩展
											</label>
										</td>
									</tr>


									<tr>
										<td class="text_icon2">
											彩信监听端口：
										</td>
										<td>
											<input type="text" id="ctcc_listenport" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=5>
											<font color=#ff0000>提示：如果修改此端口需要重启服务器</font>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费方式：
										</td>
										<td >
											<input type="radio" id="ctcc_sender" name="ctcc_chargedParty" value="0" />
											发送方
											<input type="radio" id="ctcc_recipient" name="ctcc_chargedParty"
												value="1" />
											接收方
											<input type="radio" id="ctcc_thirdParty" name="ctcc_chargedParty"
												value="4" />
											第三方
											<input type="radio" id="ctcc_both" name="ctcc_chargedParty" value="2" />
											双方都收费
											<br/>
											<input type="radio" id="ctcc_neither" name="ctcc_chargedParty"
												value="3" />
											双方都不收费
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费号码：
										</td>
										<td>
											<input type="text" id="ctcc_chargedPartyId" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											第一次失败超时时间：
										</td>
										<td>
											<input type="text" id="ctcc_timeout" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											失败重试次数：
										</td>
										<td>
											<input type="text" id="ctcc_reSendCount" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
											<input type="hidden" id="ctcc_username" value="admin">
											<input type="hidden" id="ctcc_password" value="password" >
										</td>
									</tr>
									<tr>
										<td colspan="2">
										</td>
									</tr>
								</table>
								<table width="55%" border="0" align="center" cellpadding="0"
									cellspacing="5" id="ctcc_gate_isag" style="display: none">
									<tr>
										<td class="text_icon2" width="27%">
											彩信地址：
										</td>
										<td>
											<input type="text" id="ctcc_isag_address" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
									</tr>
									<tr>
										<td class="text_icon2" width="150">
											SPID：
										</td>
										<td>
											<input type="text" id="ctcc_isag_spid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											接入密码：
										</td>
										<td>
											<input type="password" id="ctcc_isag_password" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											接入号码：
										</td>
										<td>
											<input type="text" id="ctcc_base_num" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />
											<input type="checkbox" id="ctcc_isag_canextends" checked />
											<label for="ctcc_isag_canextends">
												可扩展
											</label>
										</td>
									</tr>
									<tr id="ctcc_emaneedproid">
										<td class="text_icon2">
											产品id：
										</td>
										<td>
											<input type="text" id="ctcc_pro_id" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />

										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											FA：														</td>
										<td>
											<input type="radio" id="ctcc_fa_send" name="ctcc_fa" onclick ="showfa()"/>发送号码
											<input type="radio" id="ctcc_fa_rece" name="ctcc_fa" checked onclick ="showfa()"/>被叫号码
											<input type="radio" id="ctcc_fa_no" name="ctcc_fa" onclick ="showfa()"/>无
											<input type="radio" id="ctcc_fa_self" name="ctcc_fa" onclick ="showfa()"/>自定义
											
										</td>
									</tr>
									<tr id="ctcc_fa_tr" style="display:none">
										<td class="text_icon2">
											FA号码：														</td>
										<td>
											<input type="text" id="ctcc_fa_input" /> 
										</td>
									</tr>
									<tr style="display:none">
										<td class="text_icon2">
											订购命令字：
										</td>
										<td>
											<input type="text" id="ctcc_order_num" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />

										</td>
									</tr>
									<tr style="display:none">
										<td class="text_icon2">
											取消订购命令字：
										</td>
										<td>
											<input type="text" id="ctcc_unorder_num" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" />

										</td>
									</tr>
								</table>
								
								<!--  ###############################   联通    ################################ -->
								<table width="55%" border="0" align="center" cellpadding="0"
									cellspacing="4"  id="unicom" style="display:none">
									<tr >
										<td width="27%">
											<input type="checkbox" id="unicom_mmsenable" checked="checked"/>
											<label for="unicom_mmsenable">
												开通MMS能力
											</label>
										</td>
										<td ></td>
									</tr>
									<tr>
										<td class="text_icon2" >
											网关IP：
										</td>
										<td>
											<input type="text" id="unicom_mmscIp" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											网关URL：
										</td>
										<td>
											<input type="text" id="unicom_mmscUrl" value="" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											服务号码：
										</td>
										<td>
											<input type="text" id="unicom_vasid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											企业代码：
										</td>
										<td>
											<input type="text" id="unicom_vaspid" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											业务代码：
										</td>
										<td>
											<input type="text" id="unicom_serviceCode" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											发送号码：
										</td>
										<td>
											<input type="text" id="unicom_senderAddress" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
											<input type="checkbox" id="unicom_canextends" checked />
											<label for="unicom_canextends">
												可扩展
											</label>
										</td>
									</tr>


									<tr>
										<td class="text_icon2">
											彩信监听端口：
										</td>
										<td>
											<input type="text" id="unicom_listenport" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=5>
											<font color=#ff0000>提示：如果修改此端口需要重启服务器</font>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费方式：
										</td>
										<td >
											<input type="radio" id="unicom_sender" name="unicom_chargedParty" value="0" />
											发送方
											<input type="radio" id="unicom_recipient" name="unicom_chargedParty"
												value="1" />
											接收方
											<input type="radio" id="unicom_thirdParty" name="unicom_chargedParty"
												value="4" />
											第三方
											<input type="radio" id="unicom_both" name="unicom_chargedParty" value="2" />
											双方都收费
											<br/>
											<input type="radio" id="unicom_neither" name="unicom_chargedParty"
												value="3" />
											双方都不收费
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											资费号码：
										</td>
										<td>
											<input type="text" id="unicom_chargedPartyId" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength=20></input>
										</td>
									</tr>

									<tr>
										<td class="text_icon2">
											第一次失败超时时间：
										</td>
										<td>
											<input type="text" id="unicom_timeout" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
										</td>
									</tr>
									<tr>
										<td class="text_icon2">
											失败重试次数：
										</td>
										<td>
											<input type="text" id="unicom_reSendCount" class="input_text"
												onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)" onBlur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)" maxlength="1"></input>
											<input type="hidden" id="unicom_username" value="admin">
											<input type="hidden" id="unicom_password" value="password" >
										</td>
									</tr>
									<tr>
										<td colspan="2">
										</td>
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