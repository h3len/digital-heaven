<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
    String username;
    if(request.getParameter("username") == null) {
       username = "";
    } else {
			username=request.getParameter("username").toString();
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title id="htitle"></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link type="text/css" rel="stylesheet" href="css.css" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
    var progressBar
    var userid = "<%=request.getParameter("userid")%>";
    var xml;
          
    	Event.observe(window, 'load', function(){
				LoadUserMailconfig();
				getUserTrueName();
			});
  function ChangeMailStyle(value)
    {
    	$('emailstyle').value = value;
    
    }
    //根据所选外网邮箱导入
  function ChangeOutemailStyle()
    {
				if($F('outemailstyle')=="sina"){
				//document.getElementById('sinasel').selected==true;
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.sina.com.cn ";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sina.com.cn";   			
 	    	$('smtpport').value = "25";   			
		}
   else if($F('outemailstyle')=="163"){
  			document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.163.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.163.com";   			
 	    	$('smtpport').value = "25";   			
		}
    else if($F('outemailstyle')=="sohu"){
    		document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.sohu.com ";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sohu.com";   			
 	    	$('smtpport').value = "25";   			
		}
		else if($F('outemailstyle')=="self"){
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				$('emailstyle').value="POP3";
 	    	$('pop3server').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");
 	    	$('pop3port').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port");
 	    	$('smtpserver').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver"); 			
 	    	$('smtpport').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport");  			
		}else if($F('outemailstyle')=="enterprise"){
					if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="POP3"){
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
						}
					if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="Exchange"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
						}
					if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="DOMINO"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
						}
				$('pop3server').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3server");
 	    	$('pop3port').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3port");
 	    	$('smtpserver').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("smtpserver");  			
 	    	$('smtpport').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("smtpport");  
 	    	$('emailstyle').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle"); 	
 	    	$('owa').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("owa");		
  			$('maildoain2').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("maildoain2");		
				$('pushmailip3').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pushmailip3");		
  			$('pushmaildomain3').value = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pushmaildomain3");	
		}
    }
    
  function changeSelectboxValue(){
    $('outemailstyle').value = "self";  
    }
    
	/*--------------------------------------------------------------
		功能：用户Mailconfig
	--------------------------------------------------------------*/
	function LoadUserMailconfig()
	{		
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在载入用户信息数据....");
		var url = '../mailconfig.do';
		var pars = 'action=LoadUserMailconfig&userid='+userid;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadUserMailconfig_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：用户Mailconfig - CallBack
	--------------------------------------------------------------*/
	function LoadUserMailconfig_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		xml = objXml;
		//alert(originalRequest.responseText);
		try{	
			DisplayTransformedXML(1, objXml, "../xslt/user_mailconfig.xsl",document.getElementById("divUserMailconfig"));
			if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="POP3"){
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
						}
					if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="Exchange"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
						}
					if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="DOMINO"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
					}
	
		if(document.getElementById("mailname") != null&&document.getElementById("mailname")!="")
		{
			
			if(document.getElementById('mailname').value=="sina")
			{
			document.getElementById('sina').selected==true;
			}
				if(document.getElementById('mailname').value=="163")
			{

			document.getElementById('163').selected=true;
			}
				if(document.getElementById('mailname').value=="sohu")
			{

			document.getElementById('sohu').selected=true;
			}
				if(document.getElementById('mailname').value=="self")
			{

			document.getElementById('self').selected=true;
			}
			
			if(document.getElementById('mailname').value=="enterprise")
			{
			
			document.getElementById('enterprise').selected=true;
			}
			ChangeOutemailStyle();
		}
			
			
			
			//设置删除mailconfig按钮
			//alert(objXml.getElementsByTagName("mailconfig").item(0).attributes[4].value);

			if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("email") == "")
			{
		
			//设置默认选中的emailstyle
			ChangeMailStyle(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle"));
			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
		
		
		
				//表示该用户没有设置email绑定
				$("btnDeleteMailconfig").style.display = "none";
			}
			else
			{	
				$("btnDeleteMailconfig").style.display = "";
			}
			//如果是公司强制使用公司邮箱那么select载入时框是公司邮箱，否则是自定义邮箱			
		//	if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("enable") == "false")
		//{
		
		//			$('outemailstyle').value="self";					
		//	}	else{
			//		$('outemailstyle').value="enterprise";
		//	}

		}catch(err){
			//alert(err.message);
		}
		
		//alert(document.getElementById("divUserMailconfig").innerHTML);
		progressBar.Close();
	}
	/*-------------------------------------------------------------
		功能：修改mailconfig
	--------------------------------------------------------------*/
	function UserMailconfig()
	{
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		
		if($F('mailpassword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mailpassword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱密码！");
			return;
		}
		
		if($F('emailstyle')=="POP3")
		{
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
				if($F('smtpserver') == "")
				{
					progressBar.isNeedConfirmButton = true;
					progressBar.focusItem = "smtpserver";
					progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp服务器！");
					return;
				}
				if($F('smtpport') == "")
				{
					progressBar.isNeedConfirmButton = true;
					progressBar.focusItem = "smtpport";
					progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
					return;
				}
		}
		
		var isnoticeValue = "";
		/*
		var isnotice = document.getElementsByName("isnotice");
		for(var i=0 ;i<isnotice.length;i++)
		{
			if(isnotice[i].checked)
			{
				isnoticeValue = isnotice[i].value;
			}
		}
		if(isnoticeValue == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "isnotice";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有选择是否短信通知！");
			return;
		}
		*/

		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");
		var url = '../mailconfig.do';
		var pars = 'action=UserMailconfig&email=' + $F('email') ;
		pars+= '&username=' + $F('username') ;
		pars+= '&password=' + $F('mailpassword') ;
		pars+= '&emailstyle=' + $F('emailstyle');
		pars+= '&pop3server=' + $F('pop3server') ;
		pars+= '&pop3port=' + $F('pop3port');
	 pars+= '&smtpserver=' + $F('smtpserver');
	 pars+= '&smtpport=' + $F('smtpport');
	 pars+= '&isnotice=' + isnoticeValue ;
		pars+= '&userid='+userid ;
		pars+= '&owa='+$F('owa');
		pars+='&maildoain2='+$F('maildoain2');
		pars+='&pushmailip3='+$F('pushmailip3');
		pars+='&pushmaildomain3='+$F('pushmaildomain3');
		pars+='&mailname='+$F('outemailstyle');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserMailconfig_CallBack}
		);
	}
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function UserMailconfig_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	
	
	/*--------------------------------------------------------------
		功能：删除邮箱绑定
	--------------------------------------------------------------*/
	function DeleteMailconfig()
	{
		if(confirm("确定要删除该邮箱绑定吗?"))
		{
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("正在发送数据到服务器....");
			var url = '../mailconfig.do';
			var pars = 'action=DeleteMailconfig&userid='+userid;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: DeleteMailconfig_CallBack}
			);
		}
	}


	/*--------------------------------------------------------------
		功能：删除邮箱绑定 - CallBack
	--------------------------------------------------------------*/
	function DeleteMailconfig_CallBack(originalRequest)
	{
	
		try
		{
			var objXml = originalRequest.responseXML;
			
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.Close();
				//重新加载mailconfig
				LoadUserMailconfig();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因："+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因："+errorMessage);
		}
		progressBar.Close();
	}
	
//这个方法是给海鹏写的，主要是为了将参数传到后台^_^ by wl
	function sendsettingsms(){
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		if($F('pop3port') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "pop3port";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入端口！");
			return;
		}
			if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=sendsettingsms&email=' + $F('email') + '&username=' + $F('username') +'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: sendsettingsms_CallBack}
		);
	}
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function sendsettingsms_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	function sendbombsms(){
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		if($F('pop3port') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "pop3port";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入端口！");
			return;
		}
			if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=sendbombsms&email=' + $F('email') + '&username=' + $F('username') +'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')
		+'&owa='+$F('owa')
		+'&maildoain2='+$F('maildoain2')
		+'&pushmailip3='+$F('pushmailip3')
		+'&pushmaildomain3='+$F('pushmaildomain3')
		+'&mailname='+$F('outemailstyle');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: sendsettingsms_CallBack}
		);
	}
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function sendbombsms_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	//下载根证书
	function downloadDiploma()
	{
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		
		if($F('mailpassword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mailpassword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱密码！");
			return;
		}
		
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
		if($F('smtpserver') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpserver";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp服务器！");
			return;
		}
		if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		var isnoticeValue = "";
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=downloadDiploma&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=admin';

		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: downloadDiploma_CallBack}
		);
	}
	
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function downloadDiploma_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	//下载次级证书
	function secondDiploma()
	{
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		
		if($F('mailpassword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mailpassword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱密码！");
			return;
		}
		
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
		if($F('smtpserver') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpserver";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp服务器！");
			return;
		}
		if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		var isnoticeValue = "";
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=secondDiploma&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=admin';

		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: secondDiploma_CallBack}
		);
	}
	
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function secondDiploma_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	//下载客户端
	function donwClient()
	{
		//验证页面控件
		var checkform = new CheckForm();	
		progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据.....");
		
		if($F('email') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱地址！");
			return;
		}
		
		if($F('username') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "username";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱帐号！");
			return;
		}
		
		if($F('mailpassword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mailpassword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入邮箱密码！");
			return;
		}
		
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
		if($F('smtpserver') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpserver";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp服务器！");
			return;
		}
		if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		var isnoticeValue = "";
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=donwClient&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=admin';

		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: donwClient_CallBack}
		);
	}
	
		
	/*-------------------------------------------------------------
		功能：绑定邮箱 - CallBack
	--------------------------------------------------------------*/
	function donwClient_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
	}
	function getUserTrueName(){
		User2.getUserNameByUid(userid,{
			callback:function(omap) {
          		 dwr.util.setValues(omap);
            
		         },
		   	errorHandler:function(errorString, exception) {
		  			alert("操作失败，请重试！\n失败原因：！"+exception.message);
		          }
		});
	}
</script>

  </head>
  
  <body >
		 <!-- 内容开始 -->
		 <div class="attention"><img alt="" src="../images/ico_info.gif"/> 为<b id="usertruename"></b>设置绑定邮箱</div>
		 
		<div id="divUserMailconfig"></div>
  </body>
</html>
