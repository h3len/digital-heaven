<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加应用用户</title>
		<script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 	</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var apppageid = '<%=request.getParameter("apppageid")%>';
		var appid ='<%=request.getParameter("appid")%>';
		var userid="";
		var username="";
		function saveAppUser(){
			var cf = new CheckForm();
			if(cf.Trim($("sysusername").value)==""){
				DHalert("请填写系统用户名！");
				return false;
			}
			/*
			if(cf.Trim($("appusername").value)==""){
				DHalert("请填写应用用户名！");
				return false;
			}
			if(cf.Trim($("apppassword").value)!=cf.Trim($("repassword").value)){
				DHalert("2次输入密码不一致！");
				return false;
			}
			*/
			EnterpriseAction.addAppUser(userid,cf.Trim($("sysusername").value),"","",appid,enterpriseid,{
				callback:function(otext){
					if(otext=="1"){
						DHalert("创建应用用户成功!");
						gohome();
					}
				},
				errorHandler:function(errorString, exception) {
				    DHalert("创建应用用户失败，失败原因："+errorString);
				}
			});
		}
		function gohome(){
			window.location.href="appuserconfig.jsp?appid="+appid+"&apppageid="+apppageid+"&enterpriseid="+enterpriseid;
		}
		function getSysuser(){
			window.open('app_join_user.jsp', '','height=550,width=878,top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
		}
		function adduserSfromIC(strId){
			userid = strId.substring(strId.indexOf("$")+1);
			username = strId.substring(4,strId.indexOf("$"));
			$("sysusername").value=username;
		}
</script>
</head>
<body>
<div class="up_title">
			<span class="href_14px_blue">添加应用用户</span>
		</div>
		<table width="60%" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					系统用户名
				</td>
				<td width="71%">
					<input type="text" id="sysusername" class="input_text" maxlength="5"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9"/>
					<input type="button" value="添加用户" class="button_4" onclick="getSysuser();" maxlength=20/>
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					应用用户名
				</td>
				<td width="71%">
					<input type="text" id="appusername" class="input_text" maxlength="6"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9" maxlength=20 />
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					应用用户密码
				</td>
				<td width="71%">
					<input type="password" id="apppassword" class="input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9" />
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					确认密码
				</td>
				<td width="71%">
					<input type="password" id="repassword" class="input_text" 
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9" />
				</td>
			</tr>
		</table>
		<div style="text-align:center">
			<input type="button" onclick="saveAppUser();" id="BtnOK" value="确认" class="button_2"/> 
			<input type="button" onclick="parent.parent.GB_CURRENT.hide()" value="关闭" class="button_2"/> 
			<input type="button" onclick="gohome();"  value="返回" class="button_2"/>
		</div>
</body>
</html>