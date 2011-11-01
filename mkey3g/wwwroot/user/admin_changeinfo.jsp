<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>parent.location.href='../default.jsp'</script>");
  return;
}
%>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%= MipWebJSPUi.mipweb_user_admin_changeinfo_1 %></title>

<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
   <link type="text/css" rel="stylesheet" href="../css/user.css" />
   <script type="text/javascript" src="../scripts/transferxml.js"></script>
   <script type="text/javascript" src="../scripts/checkform.js"></script>
	 <script type="text/javascript"><!--
    var progressBar;
    var mobiletype = "";

	/*--------------------------------------------------------------
		功能：载入修改用户界面
	--------------------------------------------------------------*/
	function LoadUserModifyInfo()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;		
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_changeinfo_2 %>");		
		User2.UserOneSelfShow(function(data){		
				dwr.util.setValues(data);
				progressBar.Close();
				GetMobileTypeListXml();
			}
		);	
	}
	
	//读取手机型号列表并且绑定到select
	function GetMobileTypeListXml()
	{	
		User2.GetMobileTypeList({
			callback:function(objXml) {
				var nodelist = objXml.getElementsByTagName('mobiletype');
				var objOption = document.createElement("OPTION");
				for(var i = 0;i<nodelist.length;i++)
				{
					var objOption = document.createElement("OPTION");
					objOption.text = nodelist.item(i).attributes[1].value;
		 			objOption.value = nodelist.item(i).attributes[0].value;
		 			document.all?$('mobiletype').add(objOption):$('mobiletype').appendChild(objOption);		 			
				}				
				//手机类型
				for(var i =0;i<$('mobiletype').length;i++)
				{
					if($('mobiletype').options[i].text == mobiletype)
					{
						$('mobiletype').selectedIndex = i;
					}
				}
			}
			}
		);	
	}
	
	
	
	/*--------------------------------------------------------------
		功能：修改用户
	--------------------------------------------------------------*/
	function UserModifyInfo()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_changeinfo_3 %>");
		if($F('username') == "")
		{		
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_changeinfo_4 %>");
			return;
		}
		if($F('truename') == "")
		{
			
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "truename";
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_changeinfo_5 %>");
		return;
		}		
		if($F('mobile') == "")
		{
			
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mobile";
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_changeinfo_6 %>");
			return;
		}
		if($F('comment').length>=50){
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "idno";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_changeinfo_7 %>");
			return false;
		}
		if($F('idno')!=""){
			if(!reg.test($F('idno'))){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "idno";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_changeinfo_8 %>");
				return;
			}
		}
      progressBar.isNeedConfirmButton = false;
      progressBar.isNeedProgressBar = true;
     progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_changeinfo_9 %>");

		User2.UserModifyInfo($F('truename'),$F('mobile'),$F('idtype'),$F('idno'),$F('companytel'),$F('city'),$F('comment'),$F('hometel'),$F('mobiletype'),$F('ssoid'),$F('email'),
			{
					callback:function(objXml) {
            progressBar.isNeedConfirmButton = true;
            progressBar.isNeedProgressBar = false;
            progressBar.SetStatus("<img src='../images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_changeinfo_10 %>");
            
         },
   	errorHandler:function(errorString, exception) {
  			progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_changeinfo_11 %>"+exception.message);
          }
         
			});
      }
		
		
		
		
	
	/*--------------------------------------------------------------
		功能：重置 - InfoReset
	--------------------------------------------------------------*/
	function InfoReset()
	{
	
		document.getElementById("idno").value="";
		//证件号码重置
		
		document.getElementById("companytel").value="";
		//公司电话重置
		
		document.getElementById("hometel").value="";
		//家庭电话重置
		
		document.getElementById("city").value="";
		//联系地址重置
		
			document.getElementById("email").value="";
		//电子邮件重置
		
		document.getElementById("comment").value="";
		//备注重置
	}


   --></script>
  </head>
  
<body bgcolor="#ffffff" style="padding:0px;margin:0px;" onload="javascript:LoadUserModifyInfo();">
<!--用户相关-->

	<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!--Top Include-->
		<div class="center_nav">
			<%= MipWebJSPUi.mipweb_user_admin_changeinfo_12 %>
			<a href="main.jsp"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_13 %></a> &gt;&gt;
			<a href="admin_changeinfo.jsp"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_14 %></a>
		</div>
<div class="attention"><img alt="" src="../images/ico_info.gif"/><%= MipWebJSPUi.mipweb_user_admin_changeinfo_15 %></div>





<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1" background="../images/center_bg.jpg">
<tr><td align="right"></td><td></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_16 %></td><td><span id="usertype"></span></td></tr>
<tr><td align="right" width="40%"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_17 %></td><td><input type="text" id="username" maxlength="20"></input><span id="username"></span><input type="hidden" id="username"></input><input type="hidden" id="ssoid"/></td></tr>

<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_18 %></td><td><input type="text" id="truename" maxlength="20"></input><span class="star"> *</span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_19 %></td><td><select id="mobiletype" maxlength="20"></select><span class="star"> *</span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_20 %></td><td><input type="text" id="mobile" maxlength="20"></input><span class="star"> *</span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_21 %></td><td>
<select id="idtype">
<option value="<%= MipWebJSPUi.mipweb_user_admin_changeinfo_22 %>"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_22 %></option>
<option value="<%= MipWebJSPUi.mipweb_user_admin_changeinfo_23 %>"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_23 %></option>
<option value="<%= MipWebJSPUi.mipweb_user_admin_changeinfo_24 %>"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_24 %></option>
</select>
</td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_25 %></td><td><input type="text" id="idno" maxlength="20"></input><span class="star"> </span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_26 %></td><td><input type="text" id="companytel" maxlength="20"></input><span class="star"> </span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_27 %></td><td><input type="text" id="hometel" maxlength="20"></input><span class="star"> </span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_28 %></td><td><input type="text" id="city" maxlength="20"></input><span class="star"> </span></td></tr>
<tr><td align="right">Email：</td><td><input type="text" id="email" maxlength="40"></input><span class="star"> </span></td></tr>
<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_changeinfo_29 %></td><td><textarea id="comment" style="height:60px;"></textarea><span class="star"> </span></td></tr>
<tr><td align="center" colspan="2"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserModifyInfo();" style="cursor:pointer;" value="<%= MipWebJSPUi.mipweb_user_admin_changeinfo_30 %>"/> <input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_changeinfo_31 %>"  onclick="InfoReset();"/></td><td></td></tr>
<tr><td align="right"></td><td></td></tr>
</table>






<!--Bottom Include-->
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->

  </body>
</html>
