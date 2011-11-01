<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail")==null)
		{
			out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail");
			if(list == null || list.size() == 0)
			{
				out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				return;
			}
		}
	}
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>邮箱配置管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
		
<script type="text/javascript">
    var progressBar
    var userid = "<%=request.getParameter("userid")!=null?request.getParameter("userid"):request.getSession().getAttribute("user")%>";
			var xml;
    
  function ChangeMailStyle(value)
    {
    	$('emailstyle').value = value;
    	$('spanServer').innerHTML = value;
    	$('spanPort').innerHTML = value;
    }
    //根据所选外网邮箱导入
  function ChangeOutemailStyle()
  {
		if($F('outemailstyle')=="sina"){
				document.getElementById('sinasel').selected==true;
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
		xml = objXml;//给公共变量赋值
		var checkform = new CheckForm();
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
	
		if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("email") != "")
		{
		
			
			var selects=document.getElementById('outemailstyle');
			for(var i=0;i<selects.length;i++){
				if(selects[i].value==document.getElementById('mailname').value){
					selects[i].selected=true
				}
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
			//设置提示的邮件地址,格式为username#enterprisecode@ServerConfig.serverip
			document.getElementById("mailserveraddress").innerHTML=objXml.getElementsByTagName("mailtoaddress").item(0).getAttribute("value");
			
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
		var alerttype='0';
		if($('sms').checked){
			alerttype='0';
		}
		if($('mms').checked){
			alerttype='1';
		}
		if($('wap').checked){
			alerttype='2';
		}
		if($('client').checked){
			alerttype='3';
		}
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mailconfig.do';
		var pars = 'action=UserMailconfig&email=' + $F('email') + '&username=' + $F('username') + '&password=' + $F('mailpassword') + '&emailstyle=' + $F('emailstyle')+ '&pop3server=' + $F('pop3server') + '&pop3port=' + $F('pop3port') + '&smtpserver=' + $F('smtpserver') + '&smtpport=' + $F('smtpport')+ '&mailname='+$F('outemailstyle')+ '&userid='+userid+'&alerttype='+alerttype;
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
		if(confirm("确定要取消绑定邮箱吗?您的手机将不能使用邮件。"))
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
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！<br/>失败原因："+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！<br/>失败原因："+errorMessage);
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
		var pars = 'action=downloadDiploma&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=user';

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
		var pars = 'action=secondDiploma&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=user';

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
		var pars = 'action=donwClient&email=' + $F('email') + '&username=' + $F('username')+'&password=' + $F('mailpassword')+'&pop3port=' + $F('pop3port') + '&smtpport=' + $F('smtpport')+ '&userid='+userid + '&phonenum=' +$F('phonenum')+'&type=user';

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
	
</script>
  </head>
  
<body onload="javascript:LoadUserMailconfig();">
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
  
<div class="center_nav">·当前所在位置：<a href="../user/main.jsp">首页</a> &gt;&gt; <a href="../mail/admin_mail.jsp">我的PushEmail</a> >> 绑定邮箱<span id="spanCurrentPosition"></span></div> 
<div class="center_nav_line"></div>
<div class="center">
  <div class="center_menu_top">
		<!-- center_menu_top -->
			<div id="center_menu_top">
				<ul>
					<li id="current"><a href="../mail/admin_mail.jsp"><span>绑定邮箱</span></a></li>
					<li><a href="../mail/admin_pushrule.jsp"><span>PUSH规则</span></a></li>
					<li></li>
				</ul>
	</div>
  </div>
  <div style="clear:both"></div>
<TABLE width="100%">
<tr>
<td whith="50%" border="1">
   <div id="divUserMailconfig"></div></td>
<td>
<div style="bgcolor:#40ACF5;border:1px solid #DAE98E;width:250px; height:200px;padding:10px;">
	<div align="center" style="font-size: 16px;font-family: 黑体;width:100%;">提示</div>
	<p>服务器支持邮件转发方式的Push,请把邮件从您公司的邮件服务器上，转发到</p>
	<b style="color: red;" id="mailserveraddress"></b>
	<p>移动办公服务器收到您邮箱转发的邮件后会立即进行Push，速度比普通轮巡大大提高！</p>
</div>
</td></tr></table>
</div>


<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
</html>
