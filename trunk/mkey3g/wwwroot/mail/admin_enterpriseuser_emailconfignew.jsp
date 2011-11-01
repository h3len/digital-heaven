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
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
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
    var pop3server1 ;
    var smtpserver1 ;
    var pop3port1 ;
    var smtpport1 ;
    var imapserver1 ;
    var smtpserverforimap1 ;
    var imapport1 ;
    var smtpportforimap1 ;
    var pushmaildomain1 ;
    var exchangeServer1;
	var pushmaildomain41;
	//var exchangeHost1;
	//var exchangePort1;
	var pushmailip31;
	var owa1;
	var maildomain21;
  function ChangeMailStyle(value)
    {
    	if(value=="POP3"){
    		document.getElementById('emailstylenew').options[0].selected = "selected" ;
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="DOMINO"){
    		document.getElementById('emailstylenew').options[1].selected = "selected" ;
  			document.getElementById('checkbox_div1').style.display="none";
  			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="Exchange"){
    		document.getElementById('emailstylenew').options[2].selected = "selected" ;
  		    document.getElementById('checkbox_div1').style.display="none";
  			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="IMAP") {
    		document.getElementById('emailstylenew').options[4].selected = "selected" ;
  			document.getElementById('checkbox_div1').style.display="none";
  			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="";
    	}else{
    		document.getElementById('emailstylenew').options[3].selected = "selected" ;
  			document.getElementById('checkbox_div1').style.display="none";
  			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
    	}
    }

    /*********************************************************
    *     根据所选外网邮箱设置
    *     比如针对163邮箱，则自动显示163的配置，如果是新浪邮箱，则显示新浪配置
    *     by chb 2008-11-08
    *********************************************************/
  function ChangeOutemailStyle()
  {
		$('username').value = '';
		$('mailpassword').value = '';
		$('email').value = '';
		$('pushmailip3').value = '';
		$('pushmaildomain3').value = '';
		$('owa').value = '';
		$('maildomain2').value = '';
		$('pop3port').value = '';
		$('pop3server').value = '';
		$('smtpserver').value = '';
		$('smtpport').value = '';
		$('exchangeServer').value = '';
		$('pushmaildomain4').value = '';
		//$('exchangeHost').value = '';
		//$('exchangePort').value = '';
		fill();
		if($('outemailstyle').value =="sina"){
			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
			$('emailstylenew').value="POP3";
			$('emailstylenew').disabled=true;
 	    	$('pop3server').value = "pop3.sina.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sina.com";   			
 	    	$('smtpport').value = "25";  
 	    	return;
 	    }else if($('outemailstyle').value =="163"){
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
			$('emailstylenew').value="POP3";
			$('emailstylenew').disabled=true;
 	    	$('pop3server').value = "pop3.163.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.163.com";   			
 	    	$('smtpport').value = "25"; 
 	    	return;
		}else if($('outemailstyle').value =="sohu"){
    		document.getElementById('checkbox_div1').style.display="";
    		document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
			$('emailstylenew').value="POP3";
			$('emailstylenew').disabled=true;
 	    	$('pop3server').value = "pop3.sohu.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sohu.com";   			
 	    	$('smtpport').value = "25";  
 	    	return;
		}else if($('outemailstyle').value =="self"){
			$('emailstylenew').disabled=false;
			//如果个人没有配置邮箱，则应该遵从公司配置的邮箱
			if($("email").value==""){
				if($("emailstylenew").value=="POP3"){
					$('pop3server').value = pop3server1;
		 	    	$('pop3port').value = pop3port1;
		 	    	$('smtpserver').value = smtpserver1;   			
		 	    	$('smtpport').value = smtpport1;  
					document.getElementById('checkbox_div1').style.display="";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($("emailstylenew").value=="DONIMO"){
					$('pushmailip3').value = pushmailip31 ;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($("emailstylenew").value=="Exchange"){
					$('owa').value = owa1;
					$('maildomain2').value = maildomain21;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($("emailstylenew").value=="IMAP"){
					$('imapserver').value = imapserver1;
		 	    	$('imapport').value = imapport1;
		 	    	$('smtpserverforimap').value = smtpserverforimap1;   			
		 	    	$('smtpportforimap').value = smtpportimap1;  
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="";
				}else {
					$('exchangeServer').value = exchangeServer1;
					$('pushmaildomain4').value = pushmaildomain41;
					//$('exchangeHost').value = exchangeHost1;
					//$('exchangePort').value = exchangePort1;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="";
					document.getElementById('checkbox_div5').style.display="none";
				}
			}else{
				ChangeMailStyle($("emailstyle").value);
		        if($("emailstyle").value=="POP3"){
		        	document.getElementById('emailstylenew').options[0].selected = "selected" ;
		        	$('pop3server').value = pop3server1 ;
		           	$('smtpserver').value = smtpserver1 ;
		            $('pop3port').value = pop3port1 ;
		            $('smtpport').value = smtpport1 ;
				}else if($("emailstyle").value=="DOMINO"){
					document.getElementById('emailstylenew').options[1].selected = "selected" ;
					$('pushmailip3').value = pushmailip31;
					$('pushmaildomain3').value =pushmaildomain1;
				}else if($("emailstyle").value=="Exchange"){
					document.getElementById('emailstylenew').options[2].selected = "selected" ;
					$('owa').value = owa1;
					$('maildomain2').value =maildomain21;
				}else if($("emailstyle").value=="Exchange2007") {
					document.getElementById('emailstylenew').options[3].selected = "selected" ;
					$('exchangeServer').value =exchangeServer1;
					$('pushmaildomain4').value =pushmaildomain41;
					//$('exchangeHost').value =exchangeHost1;
					//$('exchangePort').value =exchangePort1;
				}else if($("emailstyle").value=="IMAP"){
					document.getElementById('emailstylenew').options[4].selected = "selected" ;
					$('imapserver').value = imapserver1;
		 	    	$('imapport').value = imapport1;
		 	    	$('smtpserverforimap').value = smtpserverforimap1;   			
		 	    	$('smtpportforimap').value = smtpportforimap1;  
				}
				//ChangeMailStyle($('emailstylenew').value);
			}
		}else if($('outemailstyle').value =="enterprise"){
				ChangeMailStyle($("enemailstyle").value);
				if($("enemailstyle").value=="POP3"){
					$('emailstylenew').value="POP3";
					document.getElementById('emailstylenew').options[0].selected = "selected" ;
					$('emailstylenew').disabled=true;
					$('pop3server').value = $('enpop3server').value;
					$('pop3port').value = $('enpop3port').value;
		 	    	$('smtpserver').value = $('ensmtpserver').value;
		 	    	$('smtpport').value = $('ensmtpport').value;			 	    	
				}else if($("enemailstyle").value=="DOMINO"){
					$('emailstylenew').value="DOMINO";
					document.getElementById('emailstylenew').options[1].selected = "selected" ;
					$('emailstylenew').disabled=true;
					$('pushmailip3').value = $('endominoaddress').value.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
					$('pushmaildomain3').value =$('endominomaildomain').value;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($('enemailstyle').value=="Exchange2007"){
					$('emailstylenew').value="Exchange2007";
					document.getElementById('emailstylenew').options[3].selected = "selected" ;
					$('emailstylenew').disabled=true;
					$('exchangeServer').value =$('enpop3server').value;
					$('pushmaildomain4').value =$('endominomaildomain').value;
					//$('exchangeHost').value =$('ensmtpserver').value;
					//$('exchangePort').value =$('enpop3port').value;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($("enemailstyle").value=="Exchange"){
					$('emailstylenew').value="Exchange";
					document.getElementById('emailstylenew').options[2].selected = "selected" ;
					$('emailstylenew').disabled=true;
					$('owa').value = $('endominoaddress').value;
					$('maildomain2').value =$('endominomaildomain').value;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="none";
				}else if($("enemailstyle").value=="IMAP"){
					$('emailstylenew').value="IMAP";
					document.getElementById('emailstylenew').options[4].selected = "selected" ;
					$('emailstylenew').disabled=true;
					$('imapserver').value = $('enpop3server').value;
					$('imapport').value = $('enpop3port').value;
		 	    	$('smtpserverforimap').value = $('ensmtpserver').value;
		 	    	$('smtpportforimap').value = $('ensmtpport').value;
					document.getElementById('checkbox_div1').style.display="none";
					document.getElementById('checkbox_div2').style.display="none";
					document.getElementById('checkbox_div3').style.display="none";
					document.getElementById('checkbox_div4').style.display="none";
					document.getElementById('checkbox_div5').style.display="";
				} else {
					$('emailstylenew').disabled=false;
					ChangeMailStyle($("emailstylenew").value);
					return;
				}
		}
    }

	var mailtype = '';
	var username;
	var mailpassword;
	var email;
	
	function fill(){
		$('username').value = username;
		$('mailpassword').value = mailpassword;
		$('email').value = email;
	}
	/*--------------------------------------------------------------
		功能：用户Mailconfig
	--------------------------------------------------------------*/
	function LoadUserMailconfig()
	{		
				MailConfig.LoadEnterpriseUserMailconfigNEW(userid,
			 	function(data){
			 	dwr.util.setEscapeHtml(false);
			 	dwr.util.setValues(data);
			 		//xml = objXml;//给公共变量赋值
					//DisplayTransformedXML(1, objXml, "./xslt/enterprise_user_mailconfig.xsl",document.getElementById("divUserMailconfig"));
				ChangeMailStyle($('emailstylenew').value) ;
				if($('enable').value=="true"){
					$('emailstylenew').disabled=true;
					$('pop3server').disabled=true;
	           		$('pop3port').disabled=true;
					$('smtpserver').disabled=true;
					$('smtpport').disabled=true;
	           		$('exchangeServer').disabled=true;
	           		$('pushmaildomain4').disabled=true;
	           		$('pushmailip3').disabled=true;
	           		$('owa').disabled=true;
	           		$('maildomain2').disabled=true;
	           		$('imapserver').disabled=true;
	           		$('imapport').disabled=true;
	           		$('smtpserverforimap').disabled=true;
	           		$('smtpportforimap').disabled=true;
				}
				/*var emailstyle = $('enemailstyle').value;
	           if(emailstyle!=""&&emailstyle!="null"){
	            $('emailstyle').value=emailstyle;
	           }*/
	        
	           email = $('email').value;
	           username = $('username').value;
	           mailpassword = $('mailpassword').value;
	           pop3server1 = $('pop3server').value;
	           smtpserver1 = $('smtpserver').value;
	           pop3port1 = $('pop3port').value;
	           smtpport1 = $('smtpport').value;
	           exchangeServer1=$('exchangeServer').value;
	           pushmaildomain41=$('pushmaildomain4').value;
	           pushmailip31=$('pushmailip3').value;
	           owa1=$('owa').value;
	           maildomain21=$('maildomain2').value;
	           imapserver1=$('imapserver').value;
	           imapport1=$('imapport').value;
	           smtpserverforimap1=$('smtpserverforimap').value;
	           smtpportforimap1=$('smtpportforimap').value;
				if($('email').value != ""){	
					var selects=document.getElementById('outemailstyle');
					mailtype = $('mailtype').value;
					for(var i=0;i<selects.length;i++){
						if(selects[i].value==$('mailtype').value){
							selects[i].selected=true
						}
					}
				}
				
				var alerttype=$('alerttype').value;
				if(alerttype=='1'){
					$('mms').checked = true;
				}else if(alerttype=='2'){
					$('wap').checked = true;
				}else if(alerttype=='3'){
					$('client').checked = true;
				}else{
					$('sms').checked = true;
				}
				
			if($('errdesc').value != "" && $('errdesc').value != "null"){
				$('errdescnew').innerHTML= $('errdesc').value;
				$("errmessage").style.display = "";
			}
				
			//设置删除mailconfig按钮
			if($("email").value == ""){
				//设置默认选中的emailstyle
				//ChangeMailStyle($("emailstyle").value);
				//表示该用户没有设置email绑定
				$("btnDeleteMailconfig").style.display = "none";
			}else{	
				$("btnDeleteMailconfig").style.display = "";
			}
			//设置提示的邮件地址,格式为username#enterprisecode@ServerConfig.serverip
			//document.getElementById("mailserveraddress").innerHTML=objXml.getElementsByTagName("mailtoaddress").item(0).getAttribute("value");
		});	
	}
	
	
	/*-------------------------------------------------------------
		功能：判断是否在常用邮箱内
	--------------------------------------------------------------*/
	function checkmailstyle(){
		if($('email').value == "" ||$('email').value.replace(/\s/g,"")=="")
		{
			//DHalert("请输入邮箱地址！");
			return false;
		}
		if($('email').value.indexOf('@')<1||$('email').value.indexOf('@')==($('email').value.length)-1){
			//DHalert("邮箱地址格式不正确！");
			return false;
		}
		if($('enable').value!="true"){
			MailConfig.checkmailstyleNEW($('email').value,userid,
				function(data){	
					dwr.util.setValues(data);	
						if(data.isgenerally=='yes'){
							$('emailstyle_div').style.display = "";
						}else{
							$('emailstyle_div').style.display = "none";
						}
						/*if($('isgenerally').value=='no'){
							ChangeOutemailStyle() ;				
						}else{
							ChangeMailStyle($('emailstylenew').value) ;
						}*/
					}
				
			);
		}
	}
	
	function UserMailconfig(){
		var pop3server="";
		var pop3port="";
		var smtpserver="";
		var smtpport="";
		var maildomain="";
		var reg = /^\d+$/
		Progress('正在连接邮箱服务器，请稍候....','绑定邮箱');
		//验证页面控件
		
		if($('email').value == "" ||$('email').value.replace(/\s/g,"")=="")
		{
			DHalert("没有输入邮箱地址！");
			return false;
		}
		 var cf = new CheckForm();
		/*if(!cf.IsEmail($('email').value)&&DWRUtil.getValue("emailstylenew")=="POP3"){
			DHalert("邮箱地址格式不正确！");
			return false;
		}*/
		if($('email').value.indexOf('@')<1||$('email').value.indexOf('@')==($('email').value.length)-1){
			DHalert("邮箱地址格式不正确！");
			return false;
		}
		if($('mailpassword').value == "" ||$('mailpassword').value.replace(/\s/g,"")=="")
		{
			DHalert("没有输入邮箱密码！");
			return false;
		}
		if($('mailpassword').value.length>=15&&DWRUtil.getValue("emailstylenew")=="Exchange2007"){
			DHalert("Exchange 2007密码不能超过14位！");
			return false;
		}
		if($('emailstyle_div').style.display != "none"){
			if($('emailstylenew').value=="POP3"){
				if($('pop3server').value == "" ||$('pop3server').value.replace(/\s/g,"")==""){
					DHalert("没有输入pop3服务器地址！");
					return false;
				}
				pop3server=$('pop3server').value;
	
				if($('pop3port').value == "" ||$('pop3port').value.replace(/\s/g,"")==""){
					DHalert("没有输入pop3服务器端口！");
					return false;
				}
				if(!reg.test($('pop3port').value)){
					DHalert("请输入正确的pop3端口号！");		
					return false;
				}
				if($('pop3port').value.length>5){
					DHalert("pop3端口最多为5位！");		
					return;
				}
				pop3port=$('pop3port').value ;
	
				if($('smtpserver').value == "" ||$('smtpserver').value.replace(/\s/g,"")=="")
				{
					DHalert("没有输入smtp服务器地址！");
					return false;
				}
				smtpserver=$('smtpserver').value;
	
				if($('smtpport').value == "" ||$('smtpport').value.replace(/\s/g,"")=="")
				{
					 DHalert("没有输入smtp服务器端口！");
					 return false;
				}
				if(!reg.test($('smtpport').value)){
					DHalert("请输入正确的smtp端口号！");		
					return false;
				}
				if($('smtpport').value.length>5){
					DHalert("smtp端口最多为5位！");		
					return;
				}
				smtpport=$('smtpport').value;
			}
			
			if($('emailstylenew').value=="IMAP"){
				if($('imapserver').value == "" ||$('imapserver').value.replace(/\s/g,"")==""){
					DHalert("没有输入imap服务器地址！");
					return false;
				}
				pop3server=$('imapserver').value;
				
				if($('imapport').value == "" ||$('imapport').value.replace(/\s/g,"")==""){
					DHalert("没有输入imap服务器端口！");
					return false;
				}
				if(!reg.test($('imapport').value)){
					DHalert("请输入正确的imap端口号！");		
					return false;
				}
				if($('imapport').value.length>5){
					DHalert("imap端口最多为5位！");		
					return;
				}
				pop3port=$('imapport').value;
				
				if($('smtpserverforimap').value == "" ||$('smtpserverforimap').value.replace(/\s/g,"")==""){
					DHalert("没有输入smtp服务器地址！");
					return false;
				}
				smtpserver=$('smtpserverforimap').value;
				
				if($('smtpportforimap').value == "" ||$('smtpportforimap').value.replace(/\s/g,"")==""){
					 DHalert("没有输入smtp服务器端口！");
					 return false;
				}
				if(!reg.test($('smtpportforimap').value)){
					DHalert("请输入正确的smtp端口号！");		
					return false;
				}
				if($('smtpportforimap').value.length>5){
					DHalert("smtp端口最多为5位！");		
					return;
				}
				smtpport=$('smtpportforimap').value;
			}
			
			if($('emailstylenew').value=="DOMINO"){
				if($('pushmailip3').value == "" ||$('pushmailip3').value.replace(/\s/g,"")==""){
					DHalert("没有输入服务器地址！");
					return false;
				}
				pop3server=$('pushmailip3').value;
			}
			
			if($('emailstylenew').value=="Exchange"){
				if($('owa').value == "" ||$('owa').value.replace(/\s/g,"")==""){
					DHalert("没有输入owa地址！");
					return false;
				}
				pop3server=$('owa').value;
				
				if($('maildomain2').value == "" ||$('maildomain2').value.replace(/\s/g,"")==""){
					DHalert("没有输入邮件域！");
					return false;
				}
				maildomain=$('maildomain2').value;
			}
			
			if($('emailstylenew').value=="Exchange2007"){
				if($('exchangeServer').value == "" ||$('exchangeServer').value.replace(/\s/g,"")==""){
					DHalert("没有输入webservice服务器地址！");
					return false;
				}
				pop3server=$('exchangeServer').value;
	
				if($('pushmaildomain4').value == "" ||$('pushmaildomain4').value.replace(/\s/g,"")==""){
					 DHalert("没有输入邮件域！");
					 return false;
				}
				maildomain=$('pushmaildomain4').value;
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
		
		MailConfig.saveUserMailconfig($('email').value,$('email').value.substring(0,$('email').value.indexOf('@')),$('mailpassword').value,$('emailstylenew').value,pop3server,pop3port,smtpserver,smtpport,maildomain,"self",userid,alerttype,
			function(data){				 
				if(data == "1"){
					CloseProgress();
					parent.parent.DHalert("该用户邮箱配置成功！");
					//重新加载mailconfig
					LoadUserMailconfig();
					
					parent.parent.GB_CURRENT.hide();
				}else{
					CloseProgress();
					DHalert("操作失败，失败原因："+data);
					return false;
				}
			}
		);
	}
	function undisplayall(){
		$('email').value='';
		$('username').value='';
		$('mailpassword').value='';
		$('pop3server').value='';
		$('pop3port').value='';
		$('smtpserver').value='';
		$('smtpport').value='';
		$('pushmailip3').value='';
		$('pushmaildomain3').value='';
		$('owa').value='';
		$('maildomain2').value='';
		$('pushmaildomain4').value='';
		$('exchangeServer').value='';
		//$('exchangeHost').value='';
		//$('exchangePort').value='';
		 pop3server1='' ;
     smtpserver1 ='';
     pop3port1 ='';
     smtpport1 ='';
     imapserver1 ='';
     smtpserverforimap1 ='';
     imapport1 ='';
     smtpportforimap1 ='';
     pushmaildomain1 ='';
     exchangeServer1='';
	 pushmaildomain41='';
	 //exchangeHost1='';
	 //exchangePort1='';
	 pushmailip31='';
	 owa1='';
	 maildomain21='';
	 username='';
	 mailpassword='';
	 email='';
		if($("email").value == "")
			{
			$("btnDeleteMailconfig").style.display = "none";
			}
			else
			{	
			$("btnDeleteMailconfig").style.display = "";
			}
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
										undisplayall();
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

</script>
</head>
  
<body onload="javascript:LoadUserMailconfig();" style="width:800px;">
<div>
  <div id="divUserMailconfig" style="margin-left:10px" >
  
  <table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
			
				<tr id="errmessage" style="display:none;">
					<td colspan="3">
						<font color='red'>
							邮箱配置出错：
						</font><span id="errdescnew"/>
					</td>
				</tr>
	</table>
	<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr style="display:none">
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">快捷配置：</td>
			<td>
				<select id="outemailstyle"
					onchange="javascript:ChangeOutemailStyle()" class="input_180px"
					style="height:20px">

					<option id="self" value="self">
						自定义邮箱
					</option>
					<option id="enterprise" value="enterprise">
						本单位邮箱
					</option>
					<option id="sina" value="sina">新浪</option>
					<option id="163" value="163">网易</option>
					<option id="sohu" value="sohu">搜狐</option>
				</select>
			</td>
		</tr>
		

		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">邮箱地址：</td>
			<td>
				<input type="text" id="email" maxlength="50"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="checkmailstyle()"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
		<tr style="display:none;">
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">邮箱账号：</td>
			<td>
				<input type="text" id="username" maxlength="50"
					class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">邮箱密码：</td>
			<td>
				<input type="password" id="mailpassword"
					maxlength="50" class="input_text input_180px"
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)"/>
				<span class="star">*</span>
			</td>
		</tr>
	</table>

	<table width="100%" bgcolor="" border="0" cellpadding="0"
		cellspacing="1" id="emailstyle_div" style="display:none">
		<tr>
			<td><div>
			<table width="100%" bgcolor="" border="0"
				cellpadding="0" cellspacing="1">
			<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">邮箱类型：</td>
			<td>
			
				<select id="emailstylenew" class="input_180px"
					onclick="javascript:ChangeMailStyle(this.value);"
					onchange="javascript:ChangeMailStyle(this.value);"
					style="height:20px">
					<option value="POP3">POP3</option>
					<option value="DOMINO">DOMINO</option>
					<option value="Exchange">Exchange 2003</option>
					<option value="Exchange2007">Exchange 2007</option>
					<option value="IMAP">IMAP4</option>
				</select>

			</td>
			</tr>
			</table>
			</div></td>
		</tr>
		<tr>
			<td>
				<!--checkbox_div5-->
				<div id="checkbox_div5" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">IMAP服务器地址：</td>
							<td>
								<input type="text" id="imapserver"
									class="input_text input_180px" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">IMAP端口：</td>
							<td>
								<input type="text" id="imapport"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="993"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td>
								<input type="text" id="smtpserverforimap"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td>
								<input type="text" id="smtpportforimap"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="25"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div1-->
				<div id="checkbox_div1" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">POP3服务器地址：</td>
							<td>
								<input type="text" id="pop3server"
									class="input_text input_180px" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">POP3端口：</td>
							<td>
								<input type="text" id="pop3port"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="110"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td>
								<input type="text" id="smtpserver"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td>
								<input type="text" id="smtpport"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									value="25"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div2-->
				<div id="checkbox_div2" style="display:none;">
						<table width="100%" bgcolor="" border="0"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">OWA地址：</td>
								<td>
									<input type="text" id="owa"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
										onmouseout="fEvent('mouseout',this)"/>
									<span class="star">*</span>
								</td>
							</tr>

							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">邮件域：</td>
								<td>
									<input type="text" id="maildomain2"
										class="input_text input_180px"
										onmouseover="fEvent('mouseover',this)"
										onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" />
									<span class="star">*</span>
								</td>
							</tr>
						</table>
					</div>
				<!--checkbox_div3-->
				<div id="checkbox_div3" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">服务器地址：</td>
							<td>
								<input type="text" id="pushmailip3"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>

						<tr style="display:none">
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">邮件域：</td>
							<td>
								<input type="text"
									id="pushmaildomain3" class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div3-->
				
				<!--checkbox_div4-->
				<div id="checkbox_div4" style="display:none;">
					<table width="100%" bgcolor="" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">webservice地址：</td>
							<td>
								<input type="text" id="exchangeServer"
									class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">邮件域：</td>
							<td>
								<input type="text"
									id="pushmaildomain4" class="input_text input_180px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"/>
								<span class="star">*</span>
							</td>
						</tr>
					</table>
				</div>
				<!--checkbox_div4-->
			</td>
		</tr>
	</table>
	
	<table width="100%" bgcolor="" border="0"
		cellpadding="0" cellspacing="1">
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">手机号码：</td>
			<td  align="left" id="mobile"></td>
		</tr>
		<tr style="display: none;">
			<td width="16">
					<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">提醒类型：</td>
			<td >
				<input type="radio" id="sms" name="alerttypenew"/>
				短信
				<input type="radio" id="mms" name="alerttypenew"/>
				彩信
				<input type="radio" id="wap" name="alerttypenew"/>
				WAP
				<input type="radio" id="client" name="alerttypenew"/>
				CLIENT
			</td>
		</tr>
	</table>

	<table width="100%" bgcolor="" border="0" cellpadding="0"
		cellspacing="1">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td colspan='2' >
				<font color='red'>
					注意：标准的POP3端口为110、标准的SMTP端口为25，系统不支持要求安全连接(SSL)访问的邮件地址！Exchange 2007密码长度最大是14位！
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-left:150px;">
				<input type="button" class="button_6"
					style="cursor:pointer;" id="btnDeleteMailconfig"
					onclick="javascript:DeleteMailconfig();" value="取消邮箱绑定 " />
				<input type="button" class="button_4"
					style="cursor:pointer;" id="btnOK" name="btnOK"
					onclick="javascript:UserMailconfig();" value=" 确认提交 " />
			</td>
		</tr>
	</table>
  </div>
</div>

<input type="hidden" id="emailstyle"/>
<input type="hidden" id="alerttype"/>
<input type="hidden" id="mailtype"/>
<input type="hidden" id="errdesc"/>

<input type="hidden" id="enpop3port"/>
<input type="hidden" id="ensmtpport"/>
<input type="hidden" id="enpop3server"/>
<input type="hidden" id="ensmtpserver"/>
<input type="hidden" id="enemailstyle"/>
<input type="hidden" id="endominoaddress"/>
<input type="hidden" id="endominomaildomain"/>

<input type="hidden" id="isgenerally"/>
<input type="hidden" id="enable"/>
  </body>
</html>
