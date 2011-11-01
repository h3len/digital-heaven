<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改企业业务系统</title>
		<script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 	</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		
		
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var appid = '<%=request.getParameter("appid")%>';
		window.onload=function(){
				getclientapp(enterpriseid,appid);
		}
		function modClientApp(){
			var cf = new CheckForm();
			if(cf.Trim($("appname").value)==""){
				DHalert("请输入业务系统名称！");
				return false;
			}
			if(cf.Trim($("appcode").value)==""){
				DHalert("请输入业务系统ID！");
				return false;
			}
			var appcodevalue = (cf.Trim($("appcode").value)).substring(2,6);
			var reg = /^[0-9A-Z]{4}$/;
			if(!reg.test(appcodevalue)||appcodevalue.indexOf('I')>-1||appcodevalue.indexOf('O')>-1){
				DHalert("请输入正确的业务系统ID！");
				return false;
			}
			if(cf.Trim($("encode").value)==""){
				DHalert("请输入企业代码！");
				return false;
			}
			MipClientAppAction.updateEnterpriseApp(enterpriseid,cf.Trim($("appcode").value),cf.Trim($("appname").value),appid,cf.Trim($("encode").value),{
				callback:function(oData){
					if(oData=="1"){
						DHalert("修改业务系统成功");
						gohome();
					}
				},
				errorHandler:function(errorString, exception) {
				    DHalert("修改业务系统失败，失败原因："+errorString);
				}
				
			});
		}
		function gohome(){
			window.location.href="showclientapp.jsp?enterpriseid="+enterpriseid;
		}
		
		function getclientapp(enterpriseid,appid){
			MipClientAppAction.findMipClientApp(enterpriseid,appid,{
				callback:function(oMap) {
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取业务系统失败，失败原因："+errorString);
						}
			});
		}
		function checkappcode1(){
			if($('appcode').value==''){
				checkappcode=true;
				return;
			}
			var cf = new CheckForm();
			var appcodevalue = cf.Trim($("appcode").value);
			var reg = /^[0-9A-Z]{6}$/;
			if(!reg.test(appcodevalue)||appcodevalue.indexOf('I')>-1||appcodevalue.indexOf('O')>-1){
				DHalert("请输入正确的业务系统ID！");
				return;
			}
			$('isok').innerHTML="正在校验...";
			MipClientAppAction.checkappcode(appid,appcodevalue,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											$('isok').innerHTML="可以使用";
											checkappcode=true;
										}else{
											$('isok').innerHTML="不可使用";
											checkappcode=false;
										}
									}
				});
		}
		function getCanUseAppID(){
			$('isok').innerHTML="正在获取.....";
			MipClientAppAction.getCanUseAppID({
					callback:function(data) {
						dwr.util.setValues(data);
						checkappcode=true;
						if($('appcode').value==''){
							$('isok').innerHTML="无可用号码";
						}else{
							$('isok').innerHTML="可以使用";
						}
					}
				});
		}
</script>
</head>
<body>
		<div class="up_subtitle">
			<span>业务系统信息：</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统名称
				</td>
				<td width="71%">
					<input type="text" id="appname" class="input_text" maxlength="20"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9"/>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统ID
				</td>
				<td width="71%">
					<input type="text" id="appcode" class="input_text" maxlength="6"
									onmouseover="fEvent('mouseover',this)"
									onblur="checkappcode1()"
									onmouseout="fEvent('mouseout',this)" size="9" disabled/>
					<span id="isok" style="color:red"></span><input type="button" value="随即获取" class="button_4" onclick="getCanUseAppID();" style="display:none"/>
				</td>
			</tr>
			<tr style = "display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					企业代码
				</td>
				<td width="71%">
					<input type="text" id="encode" class="input_text" maxlength="6"
									onmouseover="fEvent('mouseover',this)"
									onblur="checkappcode1()"
									onmouseout="fEvent('mouseout',this)" size="9" disabled/>
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统运行状态
				</td>
				<td id = "appstatus">
				</td>
			</tr>
		</table>
		<div style="text-align:center">
			<input type="button" onclick="javascript:modClientApp();"  id="BtnOK" value="确认"> 
			<input type="button"  onclick="parent.parent.GB_CURRENT.hide()" value="关闭"/>
			<input type="button"  onclick="gohome()" value="返回"/>
		</div>
</body>
</html>