<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || !request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebMoreUi.mip_user_admin_config_1 %></title>
<link type="text/css" rel="stylesheet" href="../css/user.css" />
	<script type="text/javascript" src="../scripts/prototype.js"></script>
	<script type="text/javascript" src="../scripts/checkform.js"></script>
	<script type="text/javascript" src="../scripts/cookies.js"></script>
	<script type="text/javascript" src="../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../scripts/tabpane.js"></script>		
	<script type="text/javascript" src="../scripts/xmlextend.js"></script>
	
	<script type="text/javascript">
	var progressBar;
	var objXmlSMSConfig = "<root/>";
	window.onload = function()
	{
	 //GetConfigMenu();
	 GetConfig();
	}    
    
  function isIP(s)
	{
	  var patrn=/(\d){1,3}.(\d){1,3}.(\d){1,3}.(\d){1,3}$/;
	  if (!patrn.exec(s)) return false
	  return true
	}
		 /*--------------------------------------------------------------
	       功能：取得配置页面菜单
	   --------------------------------------------------------------*/
	 function GetConfigMenu()
	   {
     var url = "../config.do";
     var pars = "action=GetConfigMenu";
     var myAjax = new Ajax.Request(
     url,
     {method: 'post', parameters: pars, onComplete: GetConfigMenu_CallBack}
       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得配置页面菜单 - CallBack
	   --------------------------------------------------------------*/
	 function GetConfigMenu_CallBack(originalRequest)
	   {
    	var objXml = originalRequest.responseXML;
     //alert(originalRequest.responseText);
	 		var nodelist = objXml.selectNodes("/root/list/item");
			for(var i = 0;i < nodelist.length;i++)
	 		{	 		
				var obj= document.getElementById("menutable");
				var tbody = document.createElement("tbody");
				var tr1 = document.createElement("tr");
				var td1 = document.createElement("td");
				td1.setAttribute("height", "4");
				tr1.appendChild(td1);
				tbody.appendChild(tr1);
				obj.appendChild(tbody);	
				var tr2 = document.createElement("tr");
				tr2.setAttribute("height", "24");
				tr2.setAttribute("background", "../images/admin_left_2.gif");
				//tr1.setAttribute("onMouseOver", "this.background='./menu3.gif'");
				var td2 = document.createElement("td");
				td2.innerHTML="<div style='padding-left:35px;'><a href=\""+nodelist[i].attributes[1].value+"\">"+nodelist[i].attributes[0].value+"</a></div>";
				tr2.appendChild(td2);
				tbody.appendChild(tr2);
				obj.appendChild(tbody);
	 		} 		
	   } 	   
  /*--------------------------------------------------------------
	 	功能：载入系统配置界面
	---------------------------------------------------------------*/
	function GetConfig()
	{
		$('divbody').style.display = "";
		//开始提交数据
   progressBar = new ProgressBar();
   progressBar.isNeedProgressBar = true;
   progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_config_2 %>");
   var url = "../config.do";
   var pars = "action=GetConfig";
   //alert(pars);
   var myAjax = new Ajax.Request(
   url,
   {method: 'post', parameters: pars, onComplete: GetConfig_CallBack}
       );
    }
    
    /*--------------------------------------------------------------
        功能：载入系统配置界面 - CallBack
    --------------------------------------------------------------*/
  function GetConfig_CallBack(originalRequest)
    {
   var objXml = originalRequest.responseXML;
   //alert(originalRequest.responseText);
		DisplayTransformedXML(1, objXml, "../xslt/admin_config.xsl",document.getElementById("divbody"));
		progressBar.Close();        
		//载入sms配置
		LoadSMSConfig();
    }	  
    
  	/*--------------------------------------------------------------
		功能：修改信息
	--------------------------------------------------------------*/
	function ConfigModify()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_config_3 %>");
		
		var checkform = new CheckForm();
		if(checkform.Trim($F('projectname')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.isNeedProgressBar = false;
     progressBar.focusItem = "projectname";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_4 %>");
     return;
	     }
		if(checkform.Trim($F('projectversion')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.isNeedProgressBar = false;
     progressBar.focusItem = "projectversion";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_5 %>");
     return;
	     }
		if(checkform.Trim($F('name')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "name";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_6 %>");
     return;
	     }
	     
		if(checkform.Trim($F('clientversion')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "clientversion";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_7 %>");
     return;
	     }
		if(checkform.Trim($F('installdir')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "installdir";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_8 %>");
     return;
	     }
       	     

		if(!checkform.IsNumber($F('cmpopport')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "cmpopport";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_9 %>");
     return;
	     }	       
		if($F('cmpopportssl')!="" && !checkform.IsNumber($F('cmpopportssl')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "cmpopportssl";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_10 %>");
     return;
	     }	       
		if(!checkform.IsNumber($F('cmsmtpport')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "cmsmtport";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_11 %>");
     return;
	     }	       
	     
		if($F('cmsmtpportssl') != "" && !checkform.IsNumber($F('cmsmtpportssl')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "cmsmtportssl";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_12 %>");
     return;
	     }	       

		if(!checkform.IsNumber($F('mipport')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "mipport";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_13 %>");
     return;
	     }	       
		if($F('mipportssl') != "" && !checkform.IsNumber($F('mipportssl')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "mipportssl";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_14 %>");
     return;
	     }	       
	     
	     
	     if($F('adminname') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "adminname";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_15 %>");
			return;
		}
	     
	     if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_16 %>");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_17 %>");
			return;
		}
		
		if($F('mailpassword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mailpassword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_18 %>");
			return;
		}
		/*
		if($F('pop3server') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "pop3server";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入服务器！");
			return;
		}
		if($F('pop3port') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "pop3port";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入端口！");
			return;
		}
		*/
		if($F('smtpserver') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpserver";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_19 %>");
			return;
		}
		if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_20 %>");
			return;
		}
		

		if(!isIP($F('socketip')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "socketip";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_21 %>");
     return;
	     }	       
	         
		if(!isIP($F('openofficeip')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "openofficeip";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_22 %>");
     return;
	     }	       
		if(!checkform.IsNumber($F('openofficeport')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "openofficeport";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_23 %>");
     return;
	     }	       
		if(!checkform.IsNumber($F('pagecharcount')))
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "pagecharcount";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_24 %>");
     return;
	     }	            
	       
	       
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_config_25 %>");
		
		var url = '../config.do';
		var pars = 'action=ConfigModify&adminname=' + $F('adminname') + '&email=' + $F('email') + '&username=' + $F('username') + '&mailpassword=' + $F('mailpassword') + '&smtpserver=' + $F('smtpserver') + '&smtpport=' + $F('smtpport')+ '&projectname=' + $F('projectname') + '&projectversion=' + $F('projectversion')
		+ '&name=' + $F('name')+'&clientversion=' + $F('clientversion')+ '&installdir=' + $F('installdir')
		+ '&openofficeip=' + $F('openofficeip')+ '&openofficeport=' + $F('openofficeport')+ '&socketip=' + $F('socketip')
		+ '&pagecharcount=' + $F('pagecharcount')
		+ '&cmpopport=' + $F('cmpopport')+ '&cmpopportssl=' + $F('cmpopportssl')+ '&mipport=' + $F('mipport')
		+ '&mipportssl=' + $F('mipportssl')+ '&cmsmtpport=' + $F('cmsmtpport')+ '&cmsmtpportssl=' + $F('cmsmtpportssl');
			
		if ($('radio1').checked)
		{
			pars += '&enablemultienterprise=true' ;
		}
		else
		{
			pars += '&enablemultienterprise=false' ;
		}
		
		if ($('radioCreateUser1').checked)
		{
			pars += '&enablecreateuser=true' ;
		}
		else
		{
			pars += '&enablecreateuser=false' ;
		}
		
		if ($('radioUseTruename1').checked)
		{
			pars += '&usetruename=true' ;
		}
		else
		{
			pars += '&usetruename=false' ;
		}
		
		if ($('radio_ssl1').checked)
		{
			pars += '&enablessl=true' ;
		}
		else
		{
			pars += '&enablessl=false' ;
		}
		
		//判断sms type
		if($F("selSmsType").toLowerCase() == "bmcc_qxt")
		{
		
			if($F('enterpriseid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "enterpriseid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_26 %>");
				return;
			}	
			if($F('username')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "username";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_27 %>");
				return;
			}	
			if($F('password')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "password";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_28 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_29 %>");
				return;
			}	
		
			if(checkform.Trim($F('faillimit')) == "" || !checkform.IsNumber($F('faillimit')))
	    {
		     progressBar.isNeedConfirmButton = true;
		     progressBar.isNeedProgressBar = false;
		     progressBar.focusItem = "faillimit";
		     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_30 %>");
		     return;
	     }
		
			pars += "&faillimit="+$F("faillimit")+"&enterpriseid="+$F("enterpriseid")+"&username="+$F("username")+"&password="+$F("password")+"&smsbasenumber="+$F("smsbasenumber")+"&type="+$F("selSmsType");
		}
		else if($F("selSmsType").toLowerCase() == "dhwg")
		{
		if($F('appname')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "appname";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_31 %>");
				return;
			}	
			if($F('password')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "password";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_32 %>");
				return;
			}	
			if($F('branchname')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "branchname";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_33 %>");
				return;
			}	
			if($F('dhwgurl')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "dhwgurl";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_34 %>");
				return;
			}	
			if($F('platformname')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "platformname";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_35 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_36 %>");
				return;
			}	
			
			if(checkform.Trim($F('faillimit')) == "" || !checkform.IsNumber($F('faillimit')))
	    {
		     progressBar.isNeedConfirmButton = true;
		     progressBar.isNeedProgressBar = false;
		     progressBar.focusItem = "faillimit";
		     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_37 %>");
		     return;
	     }
			pars += "&faillimit="+$F("faillimit")+"&appname="+$F("appname")+"&password="+$F("password")+"&branchname="+$F("branchname")+"&dhwgurl="+$F("dhwgurl")+"&platformname="+$F("platformname")+"&smsbasenumber="+$F("smsbasenumber")+"&type="+$F("selSmsType");
		}
		else if($F("selSmsType").toLowerCase() == "hwcmpp2")
		{
		if($F('infoxserveraddr')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserveraddr";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_38 %>");
				return;
			}	
			if($F('infoxserverport')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserverport";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_39 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_40 %>");
				return;
			}	
			if($F('spid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "spid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_41 %>");
				return;
			}	
			if($F('sppasswd')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "sppasswd";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_42 %>");
				return;
			}	
			if($F('serviceid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "serviceid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_43 %>");
				return;
			}	
			if(checkform.Trim($F('faillimit')) == "" || !checkform.IsNumber($F('faillimit')))
	    {
		     progressBar.isNeedConfirmButton = true;
		     progressBar.isNeedProgressBar = false;
		     progressBar.focusItem = "faillimit";
		     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_44 %>");
		     return;
	     }
			pars += "&faillimit="+$F("faillimit")+"&infoxserveraddr="+$F("infoxserveraddr")+"&infoxserverport="+$F("infoxserverport")+"&smsbasenumber="+$F("smsbasenumber")+"&spid="+$F("spid")+"&sppasswd="+$F("sppasswd")+"&serviceid="+$F("serviceid")+"&type="+$F("selSmsType");
		}
		else if($F("selSmsType").toLowerCase() == "hwcmpp3")
		{
		
		if($F('infoxserveraddr')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserveraddr";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_45 %>");
				return;
			}	
			if($F('infoxserverport')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserverport";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_46 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_47 %>");
				return;
			}	
			if($F('spid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "spid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_48 %>");
				return;
			}	
			if($F('sppasswd')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "sppasswd";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_49 %>");
				return;
			}	
			if($F('serviceid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "serviceid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_50 %>");
				return;
			}	
				if(checkform.Trim($F('faillimit')) == "" || !checkform.IsNumber($F('faillimit')))
	    {
		     progressBar.isNeedConfirmButton = true;
		     progressBar.isNeedProgressBar = false;
		     progressBar.focusItem = "faillimit";
		     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_51 %>");
		     return;
	     }
			pars += "&faillimit="+$F("faillimit")+"&infoxserveraddr="+$F("infoxserveraddr")+"&infoxserverport="+$F("infoxserverport")+"&smsbasenumber="+$F("smsbasenumber")+"&spid="+$F("spid")+"&sppasswd="+$F("sppasswd")+"&serviceid="+$F("serviceid")+"&type="+$F("selSmsType");
		}
//	alert(pars);
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: ConfigModify_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改信息 - CallBack
	--------------------------------------------------------------*/
	function ConfigModify_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
		 	//alert(originalRequest.responseText);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_52 %>");				
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_53 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_54 %>"+err.message);
		}
	}  
	
	
	
	
	
	
	/*-------------------------------------------------------
		功能：载入SMS配置
	--------------------------------------------------------*/
	function LoadSMSConfig()
	{		
		progressBar = new ProgressBar();
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_config_55 %>");
			
		var url = '../config.do';
		var pars = 'action=LoadSMSConfig';
		var myAjax = new Ajax.Request(
			                url,
			                {method: 'post', parameters: pars, onComplete: LoadSMSConfig_Callback}
			                );
	}
	/*-------------------------------------------------------
		功能:载入SMS配置-CallBack
	--------------------------------------------------------*/
	function LoadSMSConfig_Callback(originalRequest)
	{
	  objXmlSMSConfig = originalRequest.responseXML;
	  //alert(originalRequest.responseText);	  	
	  DisplayTransformedXML(1, objXmlSMSConfig, "../xslt/admin_sms_"+objXmlSMSConfig.getElementsByTagName("sms")[0].getAttribute("type").toLowerCase()+"_config.xsl",document.getElementById("divSMS"));
	 	progressBar.Close();
	 	try
	 	{
	  $('selSmsType').value = objXmlSMSConfig.getElementsByTagName("sms")[0].getAttribute("type").toLowerCase();
	  }catch(err){}
	  
	}
	
	
	/*-------------------------------------------------------
		功能：修改sms配置
	--------------------------------------------------------*/
	function SMSModify()
	{			
		progressBar = new ProgressBar();	
		var url = '../smsconfig.do';
		var pars = 'action=SMSModify';
		
		//判断sms type
		if($F("selSmsType").toLowerCase() == "bmcc_qxt")
		{
		
			if($F('enterpriseid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "enterpriseid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_56 %>");
				return;
			}	
			if($F('username')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "username";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_57 %>");
				return;
			}	
			if($F('password')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "password";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_58 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_59 %>");
				return;
			}	
		
			pars += "&enterpriseid="+$F("enterpriseid")+"&username="+$F("username")+"&password="+$F("password")+"&smsbasenumber="+$F("smsbasenumber")+"&type="+$F("selSmsType");
		}
		else if($F("selSmsType").toLowerCase() == "hwcmpp2")
		{
		if($F('infoxserveraddr')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserveraddr";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_60 %>");
				return;
			}	
			if($F('infoxserverport')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserverport";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_61 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_62 %>");
				return;
			}	
			if($F('spid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "spid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_63 %>");
				return;
			}	
			if($F('sppasswd')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "sppasswd";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_64 %>");
				return;
			}	
			if($F('serviceid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "serviceid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_65 %>");
				return;
			}	
			
			pars += "&infoxserveraddr="+$F("infoxserveraddr")+"&infoxserverport="+$F("infoxserverport")+"&smsbasenumber="+$F("smsbasenumber")+"&spid="+$F("spid")+"&sppasswd="+$F("sppasswd")+"&serviceid="+$F("serviceid")+"&type="+$F("selSmsType");
		}
		else if($F("selSmsType").toLowerCase() == "hwcmpp3")
		{
		
		if($F('infoxserveraddr')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserveraddr";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_66 %>");
				return;
			}	
			if($F('infoxserverport')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "infoxserverport";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_67 %>");
				return;
			}	
			if($F('smsbasenumber')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "smsbasenumber";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_config_68 %>");
				return;
			}	
			if($F('spid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "spid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_69 %>");
				return;
			}	
			if($F('sppasswd')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "sppasswd";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_70 %>");
				return;
			}	
			if($F('serviceid')=="")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.focusItem = "serviceid";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_71 %>");
				return;
			}	
			pars += "&infoxserveraddr="+$F("infoxserveraddr")+"&infoxserverport="+$F("infoxserverport")+"&smsbasenumber="+$F("smsbasenumber")+"&spid="+$F("spid")+"&sppasswd="+$F("sppasswd")+"&serviceid="+$F("serviceid")+"&type="+$F("selSmsType");
		}
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_config_72 %>");
		var myAjax = new Ajax.Request(
			                url,
			                {method: 'post', parameters: pars, onComplete: SMSModify_Callback}
			                );
	}
	/*-------------------------------------------------------
		功能:修改sms配置-CallBack
	--------------------------------------------------------*/
	function SMSModify_Callback(originalRequest)
	{
	  try
		{
	    var objXml = originalRequest.responseXML;
	    //alert(originalRequest.responseText);
			 if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			  {
       progressBar.isNeedConfirmButton = true;
       progressBar.isNeedProgressBar = false;
       progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_73 %>");

          		}
	     else
	      	    {
	        progressBar.isNeedConfirmButton = true;
	        progressBar.isNeedProgressBar = false;
	        progressBar.SetStatus("<img src='../images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_74 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
	      	    }
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='../images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_config_75 %>"+errorMessage);
		}
	}
	
	//更换sms type
	function ChangeSmsType()
	{
	  DisplayTransformedXML(1, objXmlSMSConfig, "../xslt/admin_sms_"+$F('selSmsType').toLowerCase()+"_config.xsl",document.getElementById("divSMS"));
	}
    
	</script>

	</head>
  
  <body style="padding:0px;margin:0px;"> 
  <div  style="width:1000px;">
		<div id="main" style="width:100%;padding:0px;">	
			<div id="leftMenu" style="width:176px; padding:0px;float:left;">

				<!-- Begin: left navigation -->
      <table width="176" border="0" cellspacing="0" cellpadding="0" class='LeftHandNavigation'>
        <tr> 
          <td class="leftnavtop"><img src="/images/spacer.gif" alt="" width="1" height="21" /></td>
        </tr>
        <tr> 
          <td class='container'>
								<ul>
								<li ><font size="+1"><%= MipWebMoreUi.mip_user_admin_config_76 %></font></li>
								<%if(request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))//dheaven帐号专用
		 						{%>
								<li ><a href="admin_config.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_config_77 %></a></li>
								<li ><a href="admin_mobiletype.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_config_78 %></a></li>
								  <%} %>
								<li ><a href="admin_enterpriseconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_config_79 %></a></li>
								<li ><a href="../mail/admin_enterprisemailconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_config_80 %></a></li>
							
								
								
              

			   <li class='last'></li>
            </ul></td>
        </tr>
        <tr> 
          <td class="leftnavbot"><img src="/images/spacer.gif" alt="" width="1" height="26" /></td>
        </tr>
      </table>
<!-- End: left navigation -->
		</div>
		
		
				<div id="mainbox" style="width:80%;height:auto;padding:3px;">
					<div class="nav">&nbsp;<%= MipWebMoreUi.mip_user_admin_config_81 %><a href="../user/main.jsp"><%= MipWebMoreUi.mip_user_admin_config_82 %></a><%= MipWebMoreUi.mip_user_admin_config_83 %> <span id="spanCurrentPosition"></span></div>
	

	<div id="divbody" style="width:100%;padding:6px;text-align:center;background-color:#fff;float:left"></div>
	</div>
	
	</div>
</div>
	</body>
</html>
