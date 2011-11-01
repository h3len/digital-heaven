<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>黑白名单：添加新用户</title>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/MipBlackWhiteAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!-- 新的时间控件 -->
		<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="../skin/calendar/lang/calendar-zh.js"></script>
		<link href="../skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="../skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="../skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
<script type="text/javascript">
var type='<%=request.getParameter("type")%>';
var enterpriseid = '<%=request.getParameter("eid")%>';
window.onload=function(){
	//if(type=='0'||"<%=DhServerNameUtils.SERVER_EMAS%>"=="<%=DhServerNameUtils.Server_Name%>"){
		$("calendarid").style.display="none";
		$("userctrlshow").style.display="none";
	//}else{
	//	$("calendarid").style.display="";
	//	$("userctrlshow").style.display="";
	//}
	if("<%=DhServerNameUtils.SERVER_EMA%>"=="<%=DhServerNameUtils.Server_Name%>"){
		if(type==1){
			$("checktype").disabled="disabled";
		}
	}
}
function addmobile(){
	var end;
	var cf = new CheckForm();
	if($("checktype").value==0){
		if($('mobile').value.Trim()==""){
			DHalert("匹配号码不能为空，请输入号码！");
			return false;
		}
		var num=remove86($('mobile').value.Trim());
		if(!cf.IsTel(num)){
			DHalert("号码格式不正确！");
			return false;
		}
		end=num;
	}else if($("checktype").value==1){
		if($('front').value.Trim()==""){
			DHalert("请输入开头号码！");
			return false;
		}
		var num=remove86($('front').value.Trim());
		var reg = /^(\d){3,19}$/;
		if(!reg.test(num)){
			DHalert("开头号码格式不正确！");
			return false;
		}
		end=num;
	}else if($("checktype").value==2){
		if($('zone1').value.Trim()==""){
			DHalert("请输入起始号码！");
			return false;
		}
		if($('zone2').value.Trim()==""){
			DHalert("请输入结束号码！");
			return false;
		}
		var num1=remove86($('zone1').value.Trim());
		var num2=remove86($('zone2').value.Trim());
		if(!cf.IsTel(num1)){
			DHalert("起始号码格式不正确！");
			return false;
		}
		if(!cf.IsTel(num2)){
			DHalert("结束号码格式不正确！");
			return false;
		}
		if(num1.length!=num2.length){
			DHalert("开始号码与结束号码位数必须相同！");
			return false;
		}
		if(num1>=num2){
			DHalert("开始号码必须小于结束号码！");
			return false;
		}
		end=num1+":"+num2;
	}else{
		if($('holomorphy').value.Trim()==""){
			DHalert("请输入匹配正则！");
			return false;
		}
		end=$('holomorphy').value.Trim();
	}
	if("<%=DhServerNameUtils.SERVER_EMA%>"=="<%=DhServerNameUtils.Server_Name%>"){
		if(type=='1'){
			if($('efftime').value.Trim()==""){
				DHalert("请选择生效时间！");
				return false;
			}
			if(!$('oa').checked&&!$('mail').checked&&!$('base').checked&&!$('together').checked&&!$('integation').checked&&!$('other').checked){
					DHalert('请选择业务类型！');
					return;
			}
		}
	}else{
		$('efftime').value="2009-00-00";
	}
	if("<%=DhServerNameUtils.SERVER_EMA%>"=="<%=DhServerNameUtils.Server_Name%>"){
		var servicetype ="";
				 if($('oa').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mail').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('base').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('together').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integation').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('other').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
	}else{
		var servicetype ="1";
	}
	 
	MipBlackWhiteAction.createBlackWhite(enterpriseid,end,type,$("checktype").value,$('efftime').value,servicetype,
				{	
					callback:function(otext) {
							if(otext==1){
								//alert("用户添加成功！");
								if(type==0)
									parent.parent.getblacknames();
								else
									parent.parent.getwhitenames();
								parent.parent.GB_hide();
							}else{
								DHalert("操作失败，失败原因："+otext);
							}
					},
			   	errorHandler:function(errorString, exception) {
			  			DHalert("操作失败，失败原因："+exception.message);		
			          }
					
				});
}
	
function remove86(num){
	if(num.indexOf("+")==0)
		num=num.substr(1);
	if(num.indexOf("86")==0)
		num=num.substr(2);
	return num;
}
	
function changeType(checktype){
	for(i=0;i<4;i++){
		if(i==checktype)
			$("checktype_"+i).style.display="";
		else
			$("checktype_"+i).style.display="none";
	}
	
}
</script>
</head>
<body>
		<div class="up_subtitle">
			<span> 添加设置：</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr class="height25">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					手机号匹配规则
				</td>
				<td width="71%">
						<select id="checktype" style="width:120px" onchange="changeType(this.value)">
							<option value="0">匹配号码</option>
							<option value="1">匹配开头</option>
							<option value="2">匹配区间</option>
							<option value="3">匹配正则</option>
						</select>
				</td>
			</tr>
			<tr id="checktype_0" >
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					匹配号码
				</td>
				<td width="71%">
						<input type="text" value="" id="mobile" maxlength="20" class="input_text"/>
				</td>
			</tr>
			<tr id="checktype_1" style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					匹配开头
				</td>
				<td width="71%">
						<input type="text" value="" id="front" maxlength="19" class="input_text"/>
				</td>
			</tr>
			<tr id="checktype_2" style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					匹配区间
				</td>
				<td width="71%">
						<input type="text" value="" id="zone1" maxlength="20" class="input_text"/>
						─
						<input type="text" value="" id="zone2" maxlength="20" class="input_text"/>
				</td>
			</tr>
			<tr id="checktype_3" style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					匹配正则
				</td>
				<td width="71%">
						<input type="text" value=""  style="width:200px" id="holomorphy"  maxlength="50" class="input_text"/>
				</td>
			</tr>
			<tr id="calendarid">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					生效日期
				</td>
				<td width="71%">
					<input type="text" name="date2" id="efftime" size="30" onpaste="return false" onkeydown="return false"/>
														<img alt='从日历选择'
															src='../skin/calendar/themes/icons/calendar2.gif'
															border='0' id='end'
															onmouseover="this.style.cursor='pointer'"
															onmouseout="this.style.cursor='default'" />

														<script type="text/javascript">
														var cal2 = new Zapatec.Calendar.setup({
														
														inputField     :    "efftime",     // id of the input field
														singleClick    :     false,     // require two clicks to submit
														ifFormat       :    '%Y-%m-%d',     // format of the input field
														showsTime      :     true,     // show time as well as date
														button         :    "end"  // trigger button 
												
														});
									
														</script>
				</td>
			</tr>
			<tr id="userctrlshow">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						业务类型
					</td>
					<td width="71%">
						<input type="checkbox" id="oa"></input>办公版<input type="checkbox" id="mail"></input>邮件版<input type="checkbox" id="base"></input>基础版<input type="checkbox" id="together"></input>协同通信<input type="checkbox" id="integation"></input>集成版<input type="checkbox" id="other"></input>其他
					</td>
				</tr>
		</table>
		<div style="text-align:center"><input type="button" onclick="addmobile();" class="button_2" id="BtnOK" value="确认">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="button"  class="button_2" value="取消" onclick="parent.parent.GB_CURRENT.hide()" /></div>
</body>
<script type="text/javascript">
inputEvent();
</script>
</html>