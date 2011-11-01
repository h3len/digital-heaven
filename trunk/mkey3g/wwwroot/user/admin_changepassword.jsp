<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
	|| request.getSession().getAttribute("user").equals("")) {
		out
		.print("<script>parent.location.href='../default.jsp'</script>");
		return;
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=MipWebMoreUi.mipweb_user_admin_changepassword_1%></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../scripts/cookies.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/AdminUserLogin.js" type="text/javascript"></script>
		<script src="../dwr/interface/CheckOaLogin.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
		
	var userid = "<%=session.getAttribute("user").toString()%>";
	window.onload=function(){
		if(userid=="00000000000000000000000000000000"){
		$('artnum').style.display="none";
		}
		checkconfig();
	}
	function checkconfig(){
			  CheckOaLogin.checkIsSSO(userid,
					{
						callback:function(oMap) {
							dwr.util.setValues(oMap);
							//这里校验下是不是让他可以修改密码
							if(userid!="00000000000000000000000000000000"&&$('issso').value=="1"&&$('userlogintype').value=='bs'&&$('bsaddusertype').value=='1'){//启用sso，单点登录方式bs，自动同步密码
								//那我们就把所有的东西都给禁止了
								$('oldpassword').disabled;
								$('newpassword').disabled;
								$('confirmnewpassword').disabled;
								$('btnOK').disabled;
								$('btnfalse').disabled;
								DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_2%>");
							}
						},
						errorHandler:function(errorString, exception) {
							
						}
					});
			
	}

function Trim() 
	{ 
   		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	}

    function changePassword()
    {
      Progress("<%=MipWebMoreUi.mipweb_user_admin_changepassword_3%>","<%=MipWebMoreUi.mipweb_user_admin_changepassword_4%>");
      if($('oldpassword').value == "")
      {
        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_5%>");
					return false;
      }
		var newpass = ($('newpassword').value).Trim() ;
		var confirmnewpass = ($('confirmnewpassword').value).Trim() ;
      if(newpass == "")
      {

        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_6%>");
					return false;
      }

      if(newpass.length < <%=com.dheaven.mip.util.Constants.PASSLENGTH%> || newpass.length>20)
      {
        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_7%><%=com.dheaven.mip.util.Constants.PASSLENGTH%><%=MipWebMoreUi.mipweb_user_admin_changepassword_8%>");
					return false;
      }

      if(confirmnewpass == "")
      {
        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_9%>");
					return false;
      }

      if(confirmnewpass != newpass)
      {
        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_10%>");
					return false;
      }

      if($('oldpassword').value == newpass)
      {
        DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_11%>");
					return false;
      }
      $('btnOK').disabled = true;
		   Progress("<%=MipWebMoreUi.mipweb_user_admin_changepassword_12%>","<%=MipWebMoreUi.mipweb_user_admin_changepassword_13%>");
      
			AdminUserLogin.ChangePassword(escape($('oldpassword').value),escape(newpass),
			{
								callback:function(oText) {
								if(oText=="1"){
	            DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_14%>");
								}else{
									DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_15%>"+oText);
								}
            var expdate = new Date();
      		expdate.setTime (expdate.getTime() + 1 * (24 * 60 * 60 * 1000)); //+1 day

	       				 //保存帐号密码
	        if(typeof(GetCookie("user_password")) == "string")
				{
			  			//如果用户已经保存密码到cookie，则需要更新cookie中的密码
			    SetCookie("user_password",$F('newpassword'), expdate, "/");
			    }
			},
   	errorHandler:function(errorString, exception) {
      DHalert("<%=MipWebMoreUi.mipweb_user_admin_changepassword_16%>"+exception.message);
          }
			});
				
			$('btnOK').disabled = false;
      }
     
    function checkPassword(pwd){
	  var objLow=document.getElementById("pwdLow");
	  var objMed=document.getElementById("pwdMed");
	  var objHi=document.getElementById("pwdHi");
	  if(pwd.length<4){
	    objLow.style.color="#000000";
	    objMed.style.color = "#ffffff";
	    objHi.style.color = "#ffffff";
	  }else{
	    var p1= (pwd.search(/[a-zA-Z]/)!=-1) ? 1 : 0;
	    var p2= (pwd.search(/[0-9]/)!=-1) ? 1 : 0;
	    var p3= (pwd.search(/[^A-Za-z0-9_]/)!=-1) ? 1 : 0;
	    var pa=p1+p2+p3;
	    
	    if(pa==1){
	      objLow.style.color="#000000";
	    objMed.style.color = "#ffffff";
	    objHi.style.color = "#ffffff";
	    }else if(pa==2){
	      objLow.style.color="#ffffff";
	    objMed.style.color = "#000000";
	    objHi.style.color = "#ffffff";
	    }else if(pa==3){
	      objLow.style.color="#ffffff";
	    objMed.style.color = "#ffffff";
	    objHi.style.color = "#000000";
	    }
	  }
	}
    function resetPassword()
    {
   $('newpassword').value="";
   $('oldpassword').value="";
   $('confirmnewpassword').value="";
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
    </script>
	</head>
	<body class="body_center">
	<!--Top Include-->
	<jsp:include page="../user/top.jsp" flush="true"/>
	<!--Top Include-->	
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left"></div>

<!-- 右侧例表内容 -->
<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<table id="artnum" height="29" border="0" cellpadding="0" cellspacing="0" background="/theme/images/alert_bg.gif">
  <tr>
    <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
    <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
    <td width="90%"><a href="../minioa/admin_default.jsp"><%=MipWebMoreUi.mipweb_user_admin_changepassword_17%><span class="red" id="oatodo">0</span><%=MipWebMoreUi.mipweb_user_admin_changepassword_18%></a></td>
    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="/theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
  </tr>
</table>
<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav"><%=MipWebMoreUi.mipweb_user_admin_changepassword_19%></div>
</div>
						<table width="90%" align="center" bgcolor="" border="0" cellpadding="5" cellspacing="1">
							<tr>
								<td align="right" width="43%">&nbsp;
									
								</td>
								<td width="50%">&nbsp;</td>
							</tr>
							<tr>
								<td align="right" >
									<span class="href_14px_blue"><%=MipWebMoreUi.mipweb_user_admin_changepassword_20%></span>								</td>
								<td>
									<input type="password" id="oldpassword" class="input_180px" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<span class="href_14px_blue"><%=MipWebMoreUi.mipweb_user_admin_changepassword_21%></span>
								</td>
								<td>
									<input type="password"
										onblur="javascript:checkPassword(this.value);"
										id="newpassword" class="input_180px" maxlength="20"/>
									<div id="pwdLow"
										style="width:60px;color:#fff;height:18px;background-color:#FF9933;float:left;text-align:center;border-top:3px solid #FABD7E;" style="display:none">
										<%=MipWebMoreUi.mipweb_user_admin_changepassword_22%>
									</div>
									<div id="pwdMed"
										style="width:60px;color:#fff;height:18px;background-color:#EFE143;float:left;text-align:center;border-top:3px solid #FCFFB0;" style="display:none">
										<%=MipWebMoreUi.mipweb_user_admin_changepassword_23%>
									</div>
									<div id="pwdHi"
										style="width:60px;color:#fff;height:18px;background-color:#89E556;float:left;text-align:center;border-top:3px solid #C6FFBA;" style="display:none">
										<%=MipWebMoreUi.mipweb_user_admin_changepassword_24%>
									</div>
								</td>
							</tr>
							<tr>
								<td align="right">
									<span class="href_14px_blue"><%=MipWebMoreUi.mipweb_user_admin_changepassword_25%></span>
								</td>
								<td>
									<input type="password" id="confirmnewpassword" class="input_180px" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<td colspan="3">
								</td>
							</tr>
							<tr>
								<td align="center" colspan="3" height="25">
									<input onClick="javascript:changePassword();return false;" type="image" id="btnOK" value="<%=MipWebMoreUi.mipweb_user_admin_changepassword_26%>" src="../skin/default/images/button_submit.gif">
									&nbsp;
									<input type="image" style="cursor:hand;" id="btnfalse" onClick="javascript:resetPassword();return false;" value="<%=MipWebMoreUi.mipweb_user_admin_changepassword_27%>" src="../skin/default/images/button_reset2.gif">
								</td>
							</tr>
							<tr>
								<td align="right">&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
							</tr>
						</table>
						<input type="hidden" id="userlogintype"/>
						<input type="hidden" id="bsaddusertype"/>
						<input type="hidden" id="issso"/>
		</div>
		</div>
		<!--Bottom Include-->
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
