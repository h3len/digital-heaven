<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>黑白名单</title>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/MipBlackWhiteAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
		var type='<%=request.getParameter("type")%>';
		var id='<%=request.getParameter("id")%>';
		var pageid = '<%=request.getParameter("pageid")%>';
function modifyUser(){
    var end;
	var cf = new CheckForm();
	if($("checktype").value==0){
		if($('mobile').value.Trim()==""){
			DHalert("请输入号码！");
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
		   MipBlackWhiteAction.modBlackWhite(id,end,$("checktype").value,
			{	
				callback:function(otext) {
						if(otext==1){
							parent.parent.ChangePage(pageid);
							parent.parent.GB_CURRENT.hide();
						}else{
							DHalert("操作失败，失败原因："+otext);
						}
				},
				errorHandler:function(errorString, exception) {
						DHalert(errorString);															
				}
			});
       }
       
       function init(){
          MipBlackWhiteAction.getBlackWhiteMobile(id,
		 {	
			callback:function(otext) {
					if(otext!=null){
						changeType(otext["checktype"]);
						if(otext["checktype"]==0)
							$("mobile").value=otext["mobile"];
						else if(otext["checktype"]==1)
							$("front").value=otext["mobile"];
						else if(otext["checktype"]==2){
							$("zone1").value=otext["mobile"].split(":")[0];
							$("zone2").value=otext["mobile"].split(":")[1];
						}
						else
							$("holomorphy").value=otext["mobile"];
					}else{
						DHalert("操作失败，失败原因："+otext);
					}
			},
			errorHandler:function(errorString, exception) {
					DHalert(errorString);															
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
		if(i==checktype){
			$("checktype").selectedIndex=i;
			$("checktype_"+i).style.display="";
		}
		else
			$("checktype_"+i).style.display="none";
	}
}
</script>
	</head>
	<body onload="init()">
		<div class="up_subtitle">
			<span>用户信息：</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr >
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
						<input type="text" value="" id="zone1" maxlength="20" class="input_text"/>─
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
						<input type="text" value="" id="holomorphy" style="width:200px" maxlength="50" class="input_text"/>
				</td>
			</tr>
		</table>
		<div style="text-align: center">
			<input type="button" onclick="javascript:modifyUser();" class="button_2"
				id="BtnOK" value="确认">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="button_2" value="取消"
				onclick="parent.parent.GB_CURRENT.hide()" />
		</div>
	</body>
<script type="text/javascript">
inputEvent();
</script>
</html>