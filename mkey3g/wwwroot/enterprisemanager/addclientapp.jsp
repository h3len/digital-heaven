<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加业务系统</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/mobiledisk.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var pageid = '<%=request.getParameter("pageid")%>';
		/*****************************************************************
			页面载入时，加载集团业务代码---by chb
		******************************************************************/
		window.onload = function (){
		 	MipClientAppAction.getEntBizCode(enterpriseid,{
					callback:function(data) {
						dwr.util.setValues(data);
						var comm = "<span style=\"color:red\"><b>备注</b><ul style=\"margin-left:30px\">";
						comm=comm+"<li>1.业务系统ID由2位集团业务码("+data.platbizcode+")和4位应用编码组成</li>";
						comm=comm+"<li>2.应用编码是4位字符（0-9、A-Z排除I、O）的组合，不允许出现小写字母</li>";
						comm=comm+"<li>3.业务系统名称和业务系统ID在同一企业下不允许重复</li>";
						comm=comm+"<li>4.客户端用户登录时，global.xml中配置的appi必须和对应业务系统ID一致</li>";
						comm=comm+"</ul></span>";
						
						document.getElementById("comment").innerHTML  = comm;
					},
					errorHandler:function(errorString, exception) {
				   		DHalert(errorString);
				}
			});
		 }
		
		function saveClientApp(){
			var cf = new CheckForm();
			if(cf.Trim($("appname").value)==""){
				DHalert("请输入业务系统名称！");
				return false;
			}
			
			if(cf.Trim($("appcode").value)==""){
				DHalert("请输入业务系统ID！");
				return false;
			}
			
			var appcodevalue = cf.Trim($("appcode").value);
			var reg = /^[0-9A-Z]{4}$/;
			if(!reg.test(appcodevalue)||appcodevalue.indexOf('I')>-1||appcodevalue.indexOf('O')>-1){
				DHalert("请输入正确的业务系统ID！");
				return false;
			}
			MipClientAppAction.saveEnterpriseApp(enterpriseid,cf.Trim($("appcode").value),cf.Trim($("appname").value),cf.Trim($("appstatus").value),{
				callback:function(oData){
					if(oData=="1"){
						parent.parent.DHalert("添加业务系统成功!");
						gohome() ;
					}
				},
				errorHandler:function(errorString, exception) {
				    DHalert("添加业务系统失败，失败原因："+errorString);
				}
			});
		}
		
		function gohome(){
			window.location.href="showclientapp.jsp?enterpriseid="+enterpriseid+"&pageid="+pageid;
		}
		
		function checkappcode1(){
			$('isok').innerHTML="";
			if($('appcode').value==''){
				checkappcode=true;
				return;
			}
			var cf = new CheckForm();
			var appcodevalue = cf.Trim($("appcode").value);
			var reg = /^[0-9A-Z]{4}$/;
			if(!reg.test(appcodevalue)||appcodevalue.indexOf('I')>-1||appcodevalue.indexOf('O')>-1){
				DHalert("请输入正确的业务系统ID！");
				return false;
			}
			$('isok').innerHTML="正在校验...";
			MipClientAppAction.checkappcode("",appcodevalue,{
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
					},
					errorHandler:function(errorString, exception) {
				    DHalert("获取随机数失败，失败原因："+errorString);
				}
				});
		}
</script>
</head>
<body>
<div class="up_title">
			<span class="href_14px_blue">企业业务系统 &gt;&gt; 添加企业业务系统</span>
		</div>
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
				
					<span id="platbizcode" style="width:4px;float:left"></span><input type="text" id="appcode" class="input_text" maxlength="4"
									onmouseover="fEvent('mouseover',this)"
									onblur="checkappcode1()"
									onmouseout="fEvent('mouseout',this)" size="9" style="width:103px"/>
					<span id="isok" style="color:red"></span><input type="button" value="随即获取" class="button_4" onclick="getCanUseAppID();"/>
				</td>
			</tr>
					
					
			<tr class="height25" style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统运行状态
				</td>
				<td width="71%">
					<select id = "appstatus">
						<option value="0">运行</option>
						<option value="2">暂停</option>
					</select>
				</td>
			</tr>
		</table>
		<div style="text-align:center">
			<input type="button" onclick="saveClientApp();" id="BtnOK" value="确认" class="button_2"/> 
			<input type="button" onclick="parent.parent.GB_CURRENT.hide()" value="关闭" class="button_2"/>
			<input type="button" onclick="gohome();"  value="返回" class="button_2"/>
		</div>
		<span id="comment" style="color:red">
</body>
</html>