<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>邮箱配置管理</title>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/MailConfig.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
		
<script type="text/javascript">
    var userid = "<%=request.getParameter("userid")!=null?request.getParameter("userid"):request.getSession().getAttribute("user")%>";
    var xml;
    
  function ChangeMailStyle(value)
    {
    	if(value=="POP3"){
    				document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
    	}else if(value=="Exchange"){
    				document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
    	}else if(value=="DOMINO"){
    				document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
    	}
    }
    /*********************************************************
    *     根据所选外网邮箱设置
    *     比如针对163邮箱，则自动显示163的配置，如果是新浪邮箱，则显示新浪配置
    *     by chb 2008-11-08
    *********************************************************/
  function ChangeOutemailStyle()
  {
		if($('outemailstyle').value =="sina"){
			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			$('emailstyle').value="POP3";
			$('emailstyle').disabled=true;
 	    	$('pop3server').value = "pop3.sina.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sina.com";   			
 	    	$('smtpport').value = "25";   
 	    	if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="sina"){
 	    	 var email = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
 	    	 if(email!=""&&email!="null"){
 	    	 $('email').value = email;
 	    	 }
 	    	 var username = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
 	    	 if(username!=""&&username!="null"){
 	    	  $('username').value = username;
 	    	 }
 	    	var mailpassword = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
 	    	if(mailpassword!=""&&mailpassword!="null"){
 	    	 $('mailpassword').value = mailpassword;
 	    	}
 	    	}else{
 	    	 $('email').value = "";
 	    	 $('username').value = "";
 	    	 $('mailpassword').value = "";
 	    	}
 	    				
		}else if($('outemailstyle').value =="163"){
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			$('emailstyle').value="POP3";
			$('emailstyle').disabled=true;
 	    	$('pop3server').value = "pop3.163.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.163.com";   			
 	    	$('smtpport').value = "25";   
 	    	if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="163"){
		 	    	 var email = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
		 	    	 if(email!=""&&email!="null"){
		 	    	 $('email').value = email;
		 	    	 }
		 	    	 var username = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
		 	    	 if(username!=""&&username!="null"){
		 	    	  $('username').value = username;
		 	    	 }
		 	    	var mailpassword = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
		 	    	if(mailpassword!=""&&mailpassword!="null"){
		 	    	 $('mailpassword').value = mailpassword;
		 	    	}
 	    	}		
		}
   		else if($('outemailstyle').value =="sohu"){
    		document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			$('emailstyle').value="POP3";
			$('emailstyle').disabled=true;
 	    	$('pop3server').value = "pop3.sohu.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sohu.com";   			
 	    	$('smtpport').value = "25";   
 	    	if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="sohu"){
 	    	 		 var email = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
		 	    	 if(email!=""&&email!="null"){
		 	    	 $('email').value = email;
		 	    	 }
		 	    	 var username = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
		 	    	 if(username!=""&&username!="null"){
		 	    	  $('username').value = username;
		 	    	 }
		 	    	var mailpassword = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
		 	    	if(mailpassword!=""&&mailpassword!="null"){
		 	    	 $('mailpassword').value = mailpassword;
		 	    	}
 	    	}			
		}
		else if($('outemailstyle').value =="self"){
			$('emailstyle').disabled=false;
			//如果个人没有配置邮箱，则应该遵从公司配置的邮箱
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("email")==""){
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="POP3"){
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="Exchange"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="DOMINO"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
				}
			}else{
				//如果已经有配置邮箱了，当然应该走个人配置的邮箱了，让公司邮箱见鬼去吧
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="POP3"){
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="Exchange"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="DOMINO"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
				}
			}
			var pop3server = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");
			if(pop3server!=""&&pop3server!="null"){
  			$('pop3server').value = pop3server;	
  			$('pushmailip3').value = pop3server;	
  			}else{
  			$('pop3server').value = "";
  			$('pushmailip3').value="";
  			}
  			
  			var pop3port = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port");
			if(pop3port!=""&&pop3port!="null"){
  			$('pop3port').value = pop3port;		
  			}else{
  			$('pop3port').value = "";
  			}
			var smtpserver = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver");
			if(smtpserver!=""&&smtpserver!="null"){
  			$('smtpserver').value = smtpserver;		
  			}else{
  			$('smtpserver').value = "";
  			}
			var smtpport = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport");
			if(smtpport!=""&&smtpport!="null"){
  			$('smtpport').value = smtpport;		
  			}else{
  			$('smtpport').value = "";
  			}
  			var emailstyle = xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle");
  			if(emailstyle!=""&&emailstyle!="null"){
  			$('emailstyle').value = emailstyle;	
  			}else{
  			$('emailstyle').value = "";
  			}
			
			var owa = xml.getElementsByTagName("mailconfig").item(0).getAttribute("owa");
			if(owa!=""&&owa!="null"){
  			$('owa').value = owa;	
  			}else{
  			$('owa').value = "";
  			}
  			var maildoain2 = xml.getElementsByTagName("mailconfig").item(0).getAttribute("maildoain2");
			if(maildoain2!=""&&maildoain2!="null"){
  			$('maildoain2').value = maildoain2;		
  			}else{
  			$('maildoain2').value = "";
  			}
  			var pushmaildomain3 = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pushmaildomain3");
  			if(pushmaildomain3!=""&&pushmaildomain3!="null"){
  			$('pushmaildomain3').value = pushmaildomain3;		
  			}else{
  			$('pushmaildomain3').value = "";
  			}
  			
  			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="self"){
 	    	 		 var email = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
		 	    	 if(email!=""&&email!="null"){
		 	    	 $('email').value = email;
		 	    	 }
		 	    	 var username = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
		 	    	 if(username!=""&&username!="null"){
		 	    	  $('username').value = username;
		 	    	 }
		 	    	var mailpassword = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
		 	    	if(mailpassword!=""&&mailpassword!="null"){
		 	    	 $('mailpassword').value = mailpassword;
		 	    	}
 	    	}	
		}else if($('outemailstyle').value =="enterprise"){
			if(typeof(xml) != "undefined")
			{
				if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="POP3"){
					$('emailstyle').value="POP3";
					$('emailstyle').disabled=true;
					var pop3server = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3server");
					if(pop3server!=""&&pop3server!="null"){
						$('pop3server').value = pop3server;
					}
					var pop3port = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3port");
					if(pop3port!=""&&pop3port!="null"){
					$('pop3port').value = pop3port;
					}
		 	    	var smtpserver = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("smtpserver"); 
		 	    	if(smtpserver!=""&&smtpserver!="null"){
		 	    	$('smtpserver').value = smtpserver;
		 	    	}
		 	    	var smtpport = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("smtpport");
		 	    	if(smtpport!=""&&smtpport!="null"){
		 	    	$('smtpport').value = smtpport;	
		 	    	}
				}else if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="DOMINO"){
					$('emailstyle').value="DOMINO";
					$('emailstyle').disabled=true;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
					var pushmailip3 = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3server");
					if(pushmailip3!=""){
					$('pushmailip3').value = pushmailip3;
					}
					var pushmaildomain3=xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pushmaildomain3");
					if(pushmaildomain3!=""&&pushmaildomain3!="null"){
					$('pushmaildomain3').value =pushmaildomain3;
					}
				}
			}
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="enterprise"){
	 	    	 	 var email = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
		 	    	 if(email!=""&&email!="null"){
		 	    	 $('email').value = email;
		 	    	 }
		 	    	 var username = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
		 	    	 if(username!=""&&username!="null"){
		 	    	  $('username').value = username;
		 	    	 }
		 	    	var mailpassword = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
		 	    	if(mailpassword!=""&&mailpassword!="null"){
		 	    	 $('mailpassword').value = mailpassword;
		 	    	}
 	    	}
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
				MailConfig.LoadEnterpriseUserMailconfig(userid,
			 	function(objXml){
			 		xml = objXml;//给公共变量赋值
					DisplayTransformedXML(1, objXml, "./xslt/enterprise_user_mailconfig.xsl",document.getElementById("divUserMailconfig"));
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="POP3"){
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="Exchange"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
				}
				if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle")=="DOMINO"){
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
				}
				var emailstyle = xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle");
	           if(emailstyle!=""&&emailstyle!="null"){
	            $('emailstyle').value=emailstyle;
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
		});	
	}
	
	
	/*-------------------------------------------------------------
		功能：修改xujing
	--------------------------------------------------------------*/
	function UserMailconfig()
	{
		//验证页面控件
		var mailreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
		
		if($('email').value == "" ||$('email').value.replace(/\s/g,"")=="")
		{
				DHalert("没有输入邮箱地址！");
				return false;
		}
		 var cf = new CheckForm();
		if(!cf.IsEmail($('email').value)){
				DHalert("邮箱地址格式不正确！");
				return false;
		}
		 
		if($('username').value == "" ||$('username').value.replace(/\s/g,"")=="")
		{
				DHalert("没有输入邮箱帐号！");
				return false;
		}
		if($('mailpassword').value == "" ||$('mailpassword').value.replace(/\s/g,"")=="")
		{
				DHalert("没有输入邮箱密码！");
				return false;
		}
		
		var mailserver="";
		
		if($('emailstyle').value=="POP3")
		{
					if($('pop3server').value == "" ||$('pop3server').value.replace(/\s/g,"")=="")
				{
				DHalert("没有输入服务器！");
				return false;
				}else{
				mailserver=$('pop3server').value;
				}
				
				
				if($('pop3port').value == "" ||$('pop3port').value.replace(/\s/g,"")=="")
				{
					DHalert("没有输入端口！");
					return false;
				}
				if($('smtpserver').value == "" ||$('smtpserver').value.replace(/\s/g,"")=="")
				{
					DHalert("没有输入smtp服务器！");
					return false;
				}
				if($('smtpport').value == "" ||$('smtpport').value.replace(/\s/g,"")=="")
				{
					 DHalert("没有输入smtp端口！");
					 return false;
				}
		}
		
		var maildomain="";
		if($('emailstyle').value=="DOMINO")
		{
					if($('pushmailip3').value == "" ||$('pushmailip3').value.replace(/\s/g,"")=="")
				{
				DHalert("没有输入服务器地址！");
				return false;
				}else{
				mailserver=$('pushmailip3').value;
				}
				if($('pushmaildomain3').value != ""){
				mailserver=mailserver+";"+$('pushmaildomain3').value;
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

						MailConfig.saveUserMailconfig($('email').value,$('username').value,$('mailpassword').value,$('emailstyle').value,mailserver,$('pop3port').value,$('smtpserver').value,$('smtpport').value,$('outemailstyle').value,userid,alerttype,
								function(data){				 
									if(data == "1"){
										parent.parent.DHalert("该用户邮箱配置成功！");
										//重新加载mailconfig
										LoadUserMailconfig();
										
										parent.parent.GB_CURRENT.hide();
									}else{
										DHalert("操作失败，失败原因："+data);
										return false;
									}
								}
								);
	}
	
	/*--------------------------------------------------------------
		功能：删除邮箱绑定
	--------------------------------------------------------------*/
	function DeleteMailconfig()
	{
		Ext.Msg.confirm(nowtitle, '确定要取消该邮箱绑定吗？', function(btn){
							if(btn=='yes'){
								MailConfig.DelMailconfig(userid,
								function(data){				 
									if(data == "1"){
										//DHalert("操作成功！");
										//重新加载mailconfig
										LoadUserMailconfig();
									}else{
										DHalert("操作失败，失败原因："+data);
										return false;
									}
								}
								);
							return;
				    	}
				    	}
				  );
	
}

	//这个方法是给海鹏写的，主要是为了将参数传到后台^_^ by wl
	function sendsettingsms(){
	
		//验证页面控件
		Progress("数据正在载入...","提示");
		
		if($('email').value == "")
		{
			DHalert("没有输入邮箱地址！");
				return false;
		}
		
		if($('username').value == "")
		{
			
				DHalert("没有输入邮箱帐号！");
				return false;
		}
		if($('pop3port').value == "")
		{
			
				DHalert("没有输入端口！");
				return false;
		}
			if($('smtpport').value == "")
		{
			
				DHalert("没有输入smtp端口！");
				return false;
		}
		
		Progress("数据正在载入...","提示");

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
					//DHalert("操作成功！");			
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
					DHalert("操作失败！");
				return false;
			}
		}
		catch(err)
		{
			DHalert("操作失败！");
				return false;
		}
	}
	function sendbombsms(){
		//验证页面控件
	  	 Progress("数据正在载入...","提示");
		
		if($('email').value == "")
		{
			DHalert("没有输入邮箱地址！");
				return false;
		}
		
		if($('username').value == "")
		{
			DHalert("没有输入邮箱帐号！");
				return false;
		}
		if($('pop3port').value == "")
		{
				DHalert("没有输入端口！");
				return false;
		}
			if($('smtpport').value == "")
		{;
			DHalert("没有输入smtp端口！");
				return false;
		}
		
	  	 Progress("数据正在载入...","提示");

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
				//DHalert("操作成功！");
				return false;
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				DHalert("操作失败！");
				return false;
			}
		}
		catch(err)
		{
			DHalert("操作失败！");
				return false;
		}
	}
	//下载根证书
	function downloadDiploma()
	{
		//验证页面控件
	  	 Progress("数据正在载入...","提示");
		
		if($('email').value == "")
		{
				DHalert("没有输入邮箱地址！");
				return false;
		}
		
		if($('username').value == "")
		{
			DHalert("没有输入邮箱帐号！");
				return false;
		}
		
		if($('mailpassword').value == "")
		{
			DHalert("没有输入邮箱密码！");
				return false;
		}
		
		if($('pop3server').value == "")
		{
				DHalert("没有输入服务器！");
				return false;
			
		}
		if($('pop3port').value == "")
		{
				DHalert("没有输入端口！");
				return false;
		}
		if($('smtpserver').value == "")
		{

			DHalert("没有输入smtp服务器！");
				return false;
		}
		if($('smtpport').value == "")
		{
		
			DHalert("没有输入smtp端口！");
				return false;
			
		}
		var isnoticeValue = "";
	 Progress("数据正在载入...","提示");

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
				//DHalert("操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
				DHalert("操作失败！");
				return false;
			}
		}
		catch(err)
		{
				DHalert("操作失败！");
				return false;
		}
	}
	//下载次级证书
	function secondDiploma()
	{
		//验证页面控件
		var checkform = new CheckForm();	
	  	 Progress("数据正在载入...","提示");
		
		if($('email').value == "")
		{
				DHalert("没有输入邮箱地址！");
				return false;
		}
		if($('username').value == "")
		{
					DHalert("没有输入邮箱帐号！");
				return false;
		}
		if($('mailpassword').value == "")
		{
				DHalert("没有输入邮箱密码！");
				return false;
		}
		if($('pop3server').value == "")
		{			
				DHalert("没有输入服务器！");
				return false;
		}
		if($('pop3port').value == "")
		{
				DHalert("没有输入端口！");
				return false;
		}
		if($('smtpserver').value == "")
		{
				DHalert("没有输入smtp服务器！");
				return false;
		}
		if($('smtpport').value == "")
		{
			DHalert("没有输入smtp端口！");
			return false;
		}
		var isnoticeValue = "";
		  	 Progress("数据正在载入...","提示");

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
			
					//DHalert("操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
					DHalert("操作失败！");
				return false;
			}
		}
		catch(err)
		{
				DHalert("操作失败！");
				return false;
		}
	}
	//下载客户端
	function donwClient()
	{
		//验证页面控件
  	 Progress("正在校验数据...","提示");
		
		if($('email').value == "")
		{
			DHalert("没有输入邮箱地址！");
			return false;
		}
		if($('username').value == "")
		{			
			DHalert("没有输入邮箱帐号！");
			return false;
		}
		
		if($('mailpassword').value == "")
		{
			DHalert("没有输入邮箱密码！");
			return false;
		}
		if($('pop3server').value == "")
		{
				DHalert("没有输入服务器！");
				return false;
		}
		if($('pop3port').value == "")
		{				
				DHalert("没有输入端口！");
				return false;
		}
		if($('smtpserver').value == "")
		{
				DHalert("没有输入smtp服务器！");
				return false;
		}
		if($('smtpport').value == "")
		{
			
				DHalert("没有输入smtp端口！");
				return false;
		}
		var isnoticeValue = "";
  	 Progress("数据正在载入...","提示");

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
				//DHalert("操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").disabled = false;
			}
			else
			{
					DHalert("操作失败！");
					return false;
			}
		}
		catch(err)
		{
				DHalert("操作失败！");
									return false;
		}
	}
	
</script>
  </head>
  
<body onload="javascript:LoadUserMailconfig();" style="width:800px;overflow:hidden;">

  

<div class="center">
  <div class="center_menu_top">
		<!-- center_menu_top -->
			<div id="center_menu_top" style="display:none;">
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
<td width="100%" border="1">
   <div id="divUserMailconfig" style="margin-left:10px" ></div></td>
<td>
<div style="bgcolor:#40ACF5;border:1px solid #DAE98E;width:250px;display:none; height:200px;padding:10px;">
	<div align="center" style="font-size: 16px;font-family: 黑体;width:100%;">提示</div>
	<p>服务器支持邮件转发方式的Push,请把邮件从您公司的邮件服务器上，转发到</p>
	<b style="color: red;" id="mailserveraddress"></b>
	<p>移动办公服务器收到您邮箱转发的邮件后会立即进行Push，速度比普通轮巡大大提高！</p>
</div>
</td>
</tr></table>
</div>


  </body>
</html>
