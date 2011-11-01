<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.service.impl.MipClientAppServiceImpl"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.dheaven.framework.dao.DaoException"%>
<%@page import="java.io.IOException"%>
<%
if(request.getParameter("action") != null && request.getParameter("action").equals("logout") && request.getSession().getAttribute("user") != null)
{
	//clear session	
	request.getSession().setAttribute("user", null);
	request.getSession().setAttribute("ssoid", null);
	request.getSession().setAttribute("username", null);
	request.getSession().setAttribute("truename", null);
	request.getSession().setAttribute("enterpriseid", null);
	//log
}
		String appid = null;
		String url = request.getRequestURL().toString();
		String domain = request.getServerName();
		int port = request.getServerPort();
		System.out.println("PORT:"+port);
		if(StringUtils.isNotEmpty(domain)){
			//需要调用基础件的接口 得到appid 根据domain去找到对应的appid 
			MipClientAppServiceImpl mipClientAppServiceImpl = (MipClientAppServiceImpl)ServerConfig.beanFacotry.getBean("mipClientAppServiceImpl");
			try {
				if(mipClientAppServiceImpl.findMipClientAppByNickname(domain) != null){
					appid = mipClientAppServiceImpl.findMipClientAppByNickname(domain).getAppid();
					System.out.println("STEP3:" + appid);			
				}
				else{
					System.out.println("STEP4:");
				}
			} catch (DaoException e) {
				e.printStackTrace();
			}
			if(StringUtils.isNotEmpty(appid)){
				try {
					if(StringUtils.isNotEmpty(Integer.toString(port)) && port != 0)
						url="http://"+domain+":"+port+"/wap/m.do?appid="+appid;
					else
						url="http://"+domain+"/wap/m.do?appid="+appid;
					System.out.println("STEP5:Redirect Url:" + url);
					response.sendRedirect(url);
					response.flushBuffer();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
 %>
 <%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%= MipWebMoreUi.mip_default_user_32 %>"/>
<meta name="description" content="<%= MipWebMoreUi.mip_default_user_33 %>"/>
<meta name="copyright" content="<%= MipWebMoreUi.mip_default_user_34 %>"/>
<title><%= MipWebMoreUi.mip_default_user_35 %>-<%=ServerConfig.ALL_PAGE_TITLE %></title>
<!-- common.js 通用js调用 -->
<script language="javascript" src="scripts/common.js"></script>
<!-- css.css 通用css调用 -->
<link href="theme/css.css" rel="stylesheet" type="text/css" />
<!-- Dwr Js -->
<script src="dwr/interface/User2.js" type="text/javascript"></script>
<script src="dwr/engine.js" type="text/javascript"></script>
<script src="dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		var logincount =1;
		var type="<%=session.getAttribute("type")!=null?1:0%>";
		<%
			if(session.getAttribute("type")!=null){
				session.removeAttribute("type");
			}
			%>
		function logininit(){
				User2.getLoginType(1,
					function(data){
					dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);
					});
		}


	function delinfo(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebMoreUi.mip_default_user_36 %>', function(btn){
					if(btn=='yes'){
								$('enterprisecode').value=""	;
								$('username').value=""	;
								$("password").value="";
								$("rnd").value="";
							return;					
							}
						}
						);
		}
	/*------------------------------------
		功能：系统登录
		@author yesun
		2006-11-1+
	------------------------------------*/
	//功能：用户登录
	function UserLogin()
	{

	 Progress('<%= MipWebMoreUi.mip_default_user_37 %>','<%= MipWebMoreUi.mip_default_user_38 %>');

	  if(document.getElementById("username").value == "")
		  {
	  		CloseProgress();
		  	SDHalert("<%= MipWebMoreUi.mip_default_user_39 %>",140);
		  	document.getElementById("username").focus()
		    return;
		  }
	  if(document.getElementById("password").value == "")
		  {
	  		CloseProgress();
		    SDHalert("<%= MipWebMoreUi.mip_default_user_40 %>",140);
		    document.getElementById("password").focus()
		    return;
		  }
	  if(logincount>1&&document.getElementById("rnd").value == "")
		  {
		  	CloseProgress();
		     SDHalert("<%= MipWebMoreUi.mip_default_user_41 %>",140);
		     document.getElementById("rnd").focus()
		    return;
		  }
	
		var logintype = 0;
		if(document.getElementById("checkboxid").checked == true){
		logintype = 1;
		}
		 var eccode="";
	  if('<%=DhServerNameUtils.Server_Name%>'=='<%=DhServerNameUtils.SERVER_NMOA%>'||"<%=com.dheaven.mip.config.ServerConfig.EnableMutiEnterprise%>" == "true"){
		   if(document.getElementById("enterprisecode").value == "")
			  {	  	
			  	CloseProgress();
			   	DHalert("<%= MipWebMoreUi.mip_default_user_42 %>");	
			  	document.getElementById("enterprisecode").focus()
			  	return;
			  }
			eccode = $('enterprisecode').value;
		}
	  //$('btnOK').disabled = true;
		
	  Progress('<%= MipWebMoreUi.mip_default_user_43 %>','<%= MipWebMoreUi.mip_default_user_44 %>');
	  User2.login(eccode,$('username').value,$('password').value,$('rnd').value,1,logintype,logincount,
			{
				callback:function(objXml) {
					if(objXml=="1"){
							CloseProgress();
				  			Progress('<%= MipWebMoreUi.mip_default_user_45 %>','<%= MipWebMoreUi.mip_default_user_46 %>');
						    window.location.href="<%=Constants.adminHomeUrl%>";
				  		}else{
				  			CloseProgress();
							 DHalert("<%= MipWebMoreUi.mip_default_user_47 %>"+objXml);
							 logincount++;
							 $('showrnd').style.display='';
							 changeRND();		  			
				  		}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				  DHalert("<%= MipWebMoreUi.mip_default_user_48 %>"+errorString);
				  logincount++;
				  $('showrnd').style.display='';
				  changeRND();
				}
			});
	}
	//功能：用户登录 - CallBack
	
	// 功能：取得Radio的value
	function GetRadioValueChoose(el)
	{
	  var sValue = "";
	  //取得第一个元素的name,搜索这个元素组
	  var tmpels = document.getElementsByName(el);
	  for(var i=0;i<tmpels.length;i++)
	 	 {
	    if(tmpels[i].checked)
			    {
			      sValue = tmpels[i].value;
			      break;
			    }
	 	 }
	  return sValue;
	}
	
	//功能：初始化数据，如读取cookie的值
	function init()
	{
		/*
		 //判断是否为多集团系统
		if("<%=com.dheaven.mip.config.ServerConfig.EnableMutiEnterprise%>" == "true")
		{
			// 需要取出集团列表
			document.getElementById("trCatalogList").style.display = "";
		}  
		else
		{
				document.getElementById("trCatalogList").style.display = "none";
		}
		*/
	}
	function changeRND()
	{
		document.getElementById("imgRnd").src = "rnd.do?type=user_rnd&"+Math.random();
	}
	function formreset(){
		document.getElementById('username').value="";
		document.getElementById('password').value="";
		document.getElementById('rnd').value="";
		changeRND()

	}
	
		//当输入回车时，可以直接提交
		function subIt(eventTag){
		  	var event = eventTag||window.event;    
	   		var currentKey = event.charCode||event.which;  
			if(currentKey==13){ 
	  			userLogin();
	         }
		}
		
	function changeRND()
	{
		document.getElementById("imgRnd").src = "rnd.do?type=user_rnd&"+Math.random();
	}
	window.onload = function(){
		if(<%=ServerConfig.EnableMutiEnterprise%>){
			$('eccode').style.display="";
		}else{
			$('eccode').style.display="none";
		}
		if(type==1){
			DHalert("<%= MipWebMoreUi.mip_default_user_49 %>");
		}
		logininit();
	}
	function funchecked(){
		if(document.getElementById("checkboxid").checked == true){
				document.getElementById("checkboxid").checked = false;
		}else{
				document.getElementById("checkboxid").checked = true;
		}
	}
</script>
</head>
<body onkeydown="subIt(event)">

<!-- Top 页面顶部 -->
<div id="top">
	<div id="logo_box">
	<div id="logo_login"></div>
	<div id="top_title">
	  <div class="float_right"><img src="theme/images/top_title.gif" />
	</div>
	</div>
	
</div>

<!-- Nav_menu 横向导航菜单 -->
<DIV id=menu style="width:970px">
<UL>
  <LI id=menu_home></LI>
  <LI id=search></LI>
  </UL>
</DIV>

<!-- Main 页面中部 -->
<div id="center">

	<div id="login_top_bg2"></div>
		<div class="login_box_main">


<table width="100%" height="179" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="47%" valign="middle"><div align="center"><img src="theme/images/login_center_text.gif" width="276" height="39" /></div></td>
    <td width="53%"><table width="400" border="0" cellspacing="0" cellpadding="0">
      
      <tr id="eccode" style="display:none">
        <td> <%= MipWebMoreUi.mip_default_user_50 %> </td>
        <td colspan="2"><input type="text" tabindex="2" id="enterprisecode" name="enterprisecode"
							class="input_text" onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)"
												onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"/>
        </td>
      <td></td>
      </tr>
      <tr>
        <td> <%= MipWebMoreUi.mip_default_user_51 %> </td>
        <td colspan="2"><input type="text" tabindex="2" id="username" name="username"
							class="input_text" onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)"
												onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"/>        </td>
         <td rowspan="4" width="39%"><input type="image" src="theme/images/login_button.gif"
							name="submit" id="btnOK" value="<%= MipWebMoreUi.mip_default_user_52 %>"
							onclick="javascript:UserLogin()" tabindex="5" />        </td>      </tr>
      <tr>
        <td> <%= MipWebMoreUi.mip_default_user_53 %> </td>
        <td colspan="2"><input type="password" tabindex="3" id="password"
							name="password" class="input_text" 
							onmouseover="fEvent('mouseover',this)"
												onfocus="fEvent('focus',this)"
												onblur="fEvent('blur',this)"
												onmouseout="fEvent('mouseout',this)"/>  
      </td>
      <td></td>
      </tr>
      <tr style="display:none" id="showrnd">
        <td width="16%"> <%= MipWebMoreUi.mip_default_user_54 %> </td>
        <td width="15%"><input class="input_text_short" name="rnd" id="rnd"
							type="text" emptyok="false" tabindex="3" size="10"
							maxlength="10" onfocus="fEvent('focus',this)"
							onblur="fEvent('blur',this)"
							onmouseover="fEvent('mouseover',this)"
							onmouseout="fEvent('mouseout',this)" />        </td>
        <td width="20%"><a href="#"><img alt="<%= MipWebMoreUi.mip_default_user_55 %>" src="rnd.do?type=user_rnd" id="imgRnd" name="imgRnd" border="0" usemap="absmiddle" onclick="changeRND()"  onmouseover="this.style.cursor='hand'" onMouseOut="fEvent('mouseout',this)"/> </a> </td>
        <td></td>
        </tr>
      <tr>
        <td colspan="5"><input name="checkbox" id="checkboxid" type="checkbox" id="r1" title="<%= MipWebMoreUi.mip_default_user_56 %>" />
            <span onclick="funchecked();" class="hand"><%= MipWebMoreUi.mip_default_user_57 %></span>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:delinfo();"><%= MipWebMoreUi.mip_default_user_58 %></a> </td>
      </tr>
    </table></td>
  </tr>
</table>
		</div>
	<div id="login_bom_bg"></div>

	</div>

<!-- Bottom 页面底部 -->
<div id="bottom" class="gray_12"><div style="width:970px;margin:auto;text-align:center;"><%= MipWebMoreUi.mip_default_user_59 %><span class="margin_left_100"><span class="margin_left_100" /></span></div>

</body>
</html>