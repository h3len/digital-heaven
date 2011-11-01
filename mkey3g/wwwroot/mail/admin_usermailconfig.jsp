<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>邮箱配置管理</title>
  <script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 </script>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/MailConfig.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
<script type="text/javascript">
	<%
	boolean view = false;

	if(session.getAttribute("rolelist")!=null){
		List<String> list = (List<String>)session.getAttribute("rolelist");
		if(list.contains("mipmail")){
			view= true;
		}
	}
	%>
	
    var userid = "<%=request.getParameter("userid")!=null?request.getParameter("userid"):request.getSession().getAttribute("user")%>";
			var xml;
      //选项卡
		var tabPane;
	  ab=[[LoadUserMailconfig,'邮箱账号设置'],[pushruleconfig,'提醒规则设置']];
	window.onload=function(){
		
		if(<%=view%>){
			$('center_right').style.display="";
			DHTabPanel(ab,900,0,"tabs");
		}else{
			$('center_right').style.display="none";
			DHalert("您不具备此模块访问权限，请访问其他模块");
		}
	}

		//提醒规则设置
		function pushruleconfig(){
		document.getElementById("mailconfic").style.display="none";
		document.getElementById("pushconfig").style.display="";
		}


		//PUSH时间设置
		function pushtime(){
			GB_showCenter("", "../mail/user_pushconfig_pushtime.jsp",550,878);
		}

		//PUSH信任列表
		function pushwhitename(){
			GB_showCenter("", "../mail/user_pushconfig_whitename.jsp",550,878);
		}

		//邮件过滤
		function  pushfilter(){
			GB_showCenter("", "../mail/user_pushconfig_filter.jsp",550,878);
		}



	var email1 ;
	var emailstyle1 ;
	var username1 ;
	var password1 ;
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
	var pushmailip31;
	var owa1;
	var maildomain21;
  function ChangeMailStyle(value){
	   	if(value=="POP3"){
	   		document.getElementById('emailstyle').options[0].selected = "selected" ;
	 		document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
	   	}else if(value=="Exchange"){
	   		document.getElementById('emailstyle').options[2].selected = "selected" ;
	 		document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
	   	}else if(value=="DOMINO"){
	   		document.getElementById('emailstyle').options[1].selected = "selected" ;
	 		document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
	   	}else if(value=="Exchange2007"){
	   		document.getElementById('emailstyle').options[3].selected = "selected" ;
	 		document.getElementById('checkbox_div1').style.display="none";
	 		document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
	   	}else {
	   		document.getElementById('emailstyle').options[4].selected = "selected" ;
	 		document.getElementById('checkbox_div1').style.display="none";
	 		document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="";
	   	}
  }
    //根据所选外网邮箱导入
  function ChangeOutemailStyle(){
    $('email').value = email1;
   	$('username').value = username1;
   	$('mailpassword').value = password1;
   	$('pop3server').value = "";
   	$('pop3port').value = "";
   	$('smtpserver').value = "";   			
   	$('smtpport').value ="" ;
   	$('owa').value = '';
	$('maildomain2').value = '';
	$('pushmailip3').value = '';
	$('exchangeServer').value = '';
	$('pushmaildomain4').value = '';
	$('imapserver').value = '';
   	$('imapport').value = '';
   	$('smtpserverforimap').value = '';   			
   	$('smtpportforimap').value = '';
	if($('outemailstyle').value =="sina"){
		document.getElementById('checkbox_div1').style.display="";
		document.getElementById('checkbox_div2').style.display="none";
		document.getElementById('checkbox_div3').style.display="none";
		document.getElementById('checkbox_div4').style.display="none";
		document.getElementById('checkbox_div5').style.display="none";
		
		$('emailstyle').value="POP3";
		$('emailstyle').disabled=true;
    	$('pop3server').value = "pop3.sina.com";
    	$('pop3port').value = "110";
    	$('smtpserver').value = "smtp.sina.com";   			
    	$('smtpport').value = "25";   	
    	/*if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="sina"){
    	 $('email').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
    	 $('username').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
    	 $('mailpassword').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
    	}else{
    	 $('email').value = "";
    	 $('username').value = "";
    	 $('mailpassword').value = "";
    	}	*/	
	}else if($('outemailstyle').value =="163"){
 		document.getElementById('checkbox_div1').style.display="";
		document.getElementById('checkbox_div2').style.display="none";
		document.getElementById('checkbox_div3').style.display="none";
		document.getElementById('checkbox_div4').style.display="none";
		document.getElementById('checkbox_div5').style.display="none";
		$('emailstyle').value="POP3";
		$('emailstyle').disabled=true;
	    $('pop3server').value = "pop3.163.com";
	    $('pop3port').value = "110";
	    $('smtpserver').value = "smtp.163.com";   			
	    $('smtpport').value = "25";   	
 	    	/*if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="163"){
 	    	 $('email').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
 	    	 $('username').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
 	    	 $('mailpassword').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
 	    	}else{
 	    	 $('email').value = "";
 	    	 $('username').value = "";
 	    	 $('mailpassword').value = "";
 	    	}*/			
	}else if($('outemailstyle').value =="sohu"){
   		document.getElementById('checkbox_div1').style.display="";
		document.getElementById('checkbox_div2').style.display="none";
		document.getElementById('checkbox_div3').style.display="none";
		document.getElementById('checkbox_div4').style.display="none";
		document.getElementById('checkbox_div5').style.display="none";
		$('emailstyle').value="POP3";
		$('emailstyle').disabled=true;
	    $('pop3server').value = "pop3.sohu.com";
	    $('pop3port').value = "110";
	    $('smtpserver').value = "smtp.sohu.com";   			
	    $('smtpport').value = "25"; 
 	    	/*if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("mailtype")=="sohu"){
 	    	 $('email').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("email");
 	    	 $('username').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("username");
 	    	 $('mailpassword').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("password");
 	    	}else{
 	    	 $('email').value = "";
 	    	 $('username').value = "";
 	    	 $('mailpassword').value = "";
 	    	}	*/  			
	}else if($('outemailstyle').value =="self"){
		ChangeMailStyle(emailstyle1);
	    $('emailstyle').disabled=false;
		if(emailstyle1=="POP3"){
			document.getElementById('emailstyle').options[0].selected = "selected" ;
			$('pop3server').value = pop3server1;
 	    	$('pop3port').value = pop3port1;
 	    	$('smtpserver').value = smtpserver1;   			
 	    	$('smtpport').value = smtpport1;  
		}else if(emailstyle1=="Exchange"){
			document.getElementById('emailstyle').options[2].selected = "selected" ;
			$('owa').value = owa1;
			$('maildomain2').value = maildomain21;
		}else if(emailstyle1=="DOMINO"){
			document.getElementById('emailstyle').options[1].selected = "selected" ;
			$('pushmailip3').value = pushmailip31 ;
		}else if(emailstyle1=="Exchange2007"){
			document.getElementById('emailstyle').options[3].selected = "selected" ;
			$('exchangeServer').value = exchangeServer1;
			$('pushmaildomain4').value = pushmaildomain41;
		}else if(emailstyle1=="IMAP"){
			document.getElementById('emailstyle').options[4].selected = "selected" ;
			$('imapserver').value = imapserver1;
 	    	$('imapport').value = imapport1;
 	    	$('smtpserverforimap').value = smtpserverforimap1;   			
 	    	$('smtpportforimap').value = smtpportforimap1;  
		}else{
			document.getElementById('emailstyle').options[0].selected = "selected" ;
			ChangeMailStyle("POP3");
		}
	}else if($('outemailstyle').value =="enterprise"){
			//var pop3server  = xml.getElementsByTagName("enterprisemail").item(0).getAttribute("pop3server");
		if($("enemailstyle").value=="POP3"){
			$('emailstyle').value="POP3";
			document.getElementById('emailstyle').options[0].selected = "selected" ;
			$('emailstyle').disabled=true;
			$('pop3server').value = $('enpop3server').value;
			$('pop3port').value = $('enpop3port').value;
 	    	$('smtpserver').value = $('ensmtpserver').value;
 	    	$('smtpport').value = $('ensmtpport').value;	
 	    	document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";		 	    	
		}else if($("enemailstyle").value=="DOMINO"){
			$('emailstyle').value="DOMINO";
			document.getElementById('emailstyle').options[1].selected = "selected" ;
			$('emailstyle').disabled=true;
			$('pushmailip3').value = $('endominoaddress').value;
			$('pushmaildomain3').value =$('endominomaildomain').value;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
		}else if($("enemailstyle").value=="Exchange2007"){
			$('emailstyle').value="Exchange2007";
			document.getElementById('emailstyle').options[3].selected = "selected" ;
			$('emailstyle').disabled=true;
			$('exchangeServer').value =$('enpop3server').value;
			$('pushmaildomain4').value =$('endominomaildomain').value;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
		}else if($("enemailstyle").value=="Exchange"){
			$('emailstyle').value="Exchange";
			document.getElementById('emailstyle').options[2].selected = "selected" ;
			$('emailstyle').disabled=true;
			$('owa').value = $('endominoaddress').value;
			$('maildomain2').value =$('endominomaildomain').value;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
		}else if($("enemailstyle").value=="IMAP"){
			$('emailstyle').value="IMAP";
			document.getElementById('emailstyle').options[4].selected = "selected" ;
			$('emailstyle').disabled=true;
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
			$('emailstyle').disabled=false;
			ChangeMailStyle($('emailstyle').value);
			return;
		}
			
	}
  }
  function changeSelectboxValue(){
    $('outemailstyle').value = "self";  
  }
  
	/*--------------------------------------------------------------
		功能：用户Mailconfig  邮箱账号设置
	--------------------------------------------------------------*/
	function LoadUserMailconfig(){		
		document.getElementById("mailconfic").style.display="";
		document.getElementById("pushconfig").style.display="none";
		MailConfig.LoadEnterpriseUserMailconfig(userid,
		 	function(objXml){
		 		xml = objXml;//给公共变量赋值
				DisplayTransformedXML(1, objXml, "./xslt/enterprise_user_mailconfig.xsl",document.getElementById("divUserMailconfig"));
				//alert(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew"));
				if($('enable').value=="true"){
					$('emailstyle').disabled=true;
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
			   email1 = $('email').value
			   username1 = $('username').value;
			   password1 = $('mailpassword').value;
			   emailstyle1 = $('emailstylenew').value;
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
	           ChangeMailStyle(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")) ;
			
			if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("email") != ""){
				var selects=document.getElementById('outemailstyle');
				for(var i=0;i<selects.length;i++){
					if(selects[i].value==document.getElementById('mailname').value){
						selects[i].selected=true
					}
				}
				//ChangeOutemailStyle();
			}
			//设置删除mailconfig按钮
			if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("email") == ""){
				//设置默认选中的emailstyle
				/*ChangeMailStyle(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle"));
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";*/
				//表示该用户没有设置email绑定
				$("btnDeleteMailconfig").style.display = "none";
			}else{	
				$("btnDeleteMailconfig").style.display = "";
			}
			//设置提示的邮件地址,格式为username#enterprisecode@ServerConfig.serverip
			document.getElementById("mailserveraddress").innerHTML=objXml.getElementsByTagName("mailtoaddress").item(0).getAttribute("value");
           
		});	
	}
	
	
	/*-------------------------------------------------------------
		功能：修改mailconfig
	--------------------------------------------------------------*/
	//检测用户邮箱是否在常用邮箱内
	function checkmailstyle(){
		if($('email').value == "" ||$('email').value.replace(/\s/g,"")=="")
		{
			DHalert("请输入邮箱地址！");
			return false;
		}
		if($('email').value.indexOf('@')<1||$('email').value.indexOf('@')==($('email').value.length)-1){
			DHalert("邮箱地址格式不正确！");
			return false;
		}
		if($('enable').value!="true"){
			MailConfig.checkmailstyle($('email').value,userid,
				function(xml){	
					if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("isgenerally")=='no'){
						ChangeOutemailStyle() ;				
					}else{
					alert(xml.getElementsByTagName("mailconfig").item(0).getAttribute("isgenerally")) ;
						ChangeMailStyle(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")) ;
						if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="POP3"){
							$('pop3server').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server") ;
							$('pop3port').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port") ;
							$('smtpserver').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver") ;
							$('smtpport').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport") ;
						}else if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="DOMINO"){
							$('pushmailip3').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server") ;
						}else if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="Exchange"){
							$('owa').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server") ;
							$('maildomain2').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("maildomain") ;
						}else if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="Exchange2007"){
							$('exchangeServer').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server") ;
							$('pushmaildomain4').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("maildomain") ;
						}else{
							$('imapserver').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server") ;
							$('imapport').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port") ;
							$('smtpserverforimap').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver") ;
							$('smtpportforimap').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport") ;
						}
					}
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
		if($('email').value == "" ||$('email').value.replace(/\s/g,"")==""){
			DHalert("没有输入邮箱地址！");
			return false;
		}
		var cf = new CheckForm();
		if(!cf.IsEmail($('email').value)&&DWRUtil.getValue("emailstyle")=="POP3"){
			DHalert("邮箱地址格式不正确！");
			return false;
		}
		if($('email').value.indexOf('@')<1||$('email').value.indexOf('@')==($('email').value.length)-1){
			DHalert("邮箱地址格式不正确！");
			return false;
		}
		/*if($('username').value == "" ||$('username').value.replace(/\s/g,"")==""){
			DHalert("没有输入邮箱帐号！");
			return false;
		}*/
		if($('mailpassword').value == "" ||$('mailpassword').value.replace(/\s/g,"")==""){
			DHalert("没有输入邮箱密码！");
			return false;
		}
		if($('mailpassword').value.length>=15&&DWRUtil.getValue("emailstyle")=="Exchange2007"){
			DHalert("Exchange 2007密码不能超过14位！");
			return false;
		}
		
		if($('emailstyle').value=="POP3"){
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
				DHalert("pop3端口不是有效数字！");		
				return false;
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
				DHalert("smtp端口不是有效数字！");		
				return false;
			}
			smtpport=$('smtpport').value;
		}
		
		if($('emailstyle').value=="DOMINO"){
			if($('pushmailip3').value == "" ||$('pushmailip3').value.replace(/\s/g,"")==""){
				DHalert("没有输入服务器地址！");
				return false;
			}
			pop3server=$('pushmailip3').value;
			
			if($('pushmaildomain3').value != ""){
				maildomain=$('pushmaildomain3').value;
			}
		}
		
		if($('emailstyle').value=="Exchange"){
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
		
		if($('emailstyle').value=="Exchange2007"){
			if($('exchangeServer').value == "" ||$('exchangeServer').value.replace(/\s/g,"")==""){
				DHalert("没有输入webservice地址！");
				return false;
			}
			pop3server=$('exchangeServer').value;
				
			if($('pushmaildomain4').value == "" ||$('pushmaildomain4').value.replace(/\s/g,"")==""){
				 DHalert("没有输入邮件域！");
				 return false;
			}
			maildomain=$('pushmaildomain4').value;
		}
		
		if($('emailstyle').value=="IMAP"){
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
				DHalert("imap端口不是有效数字！");		
				return false;
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
				DHalert("smtp端口不是有效数字！");		
				return false;
			}
			smtpport=$('smtpportforimap').value;
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
		MailConfig.saveUserMailconfig($('email').value,$('email').value.substring(0,$('email').value.indexOf('@')),$('mailpassword').value,$('emailstyle').value,pop3server,pop3port,smtpserver,smtpport,maildomain,"self",userid,alerttype,
			function(data){				 
				if(data == "1"){
					CloseProgress();
					DHalert("成功设置绑定邮箱！");
					//重新加载mailconfig
					//CloseProgress();
					//LoadUserMailconfig();
				}else{
					CloseProgress();
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
<body>
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->

<!-- Main 页面中部 -->
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left"></div>
<!-- 右侧例表内容 -->
<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<!-- 中部主要内容开始 -->
<table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/theme/images/alert_bg.gif">
  <tr>
    <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
    <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
    <td width="90%"><a href="../minioa/admin_default.jsp">您有<span class="red" id="oatodo">0</span>篇公文待处理</a></td>
    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="/theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
  </tr>
</table>
<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置  &gt;&gt; 系统设置 &gt;&gt;邮箱设置</div>
</div>

<div id="tabs" style="border:1px solid white"></div>
<div id="mailconfic">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:11px;">
		<tr>
		<td whith="20%" border="1">
		   <div id="divUserMailconfig"></div></td>
		<td>
		<div style="bgcolor:#40ACF5;border:1px solid #DAE98E;width:250px;display:none; height:200px;padding:10px;">
			<div align="center" style="font-size: 16px;font-family: 黑体;width:100%;">提示</div>
			<p>服务器支持邮件转发方式的Push,请把邮件从您公司的邮件服务器上，转发到</p>
			<b style="color: red;" id="mailserveraddress"></b>
			<p>移动办公服务器收到您邮箱转发的邮件后会立即进行Push，速度比普通轮巡大大提高！</p>
		</div>
		</td></tr></table>
		</div>
		
		<div id="pushconfig" style="display:none">
		<table align="center" width="50%">
		<tr><td><br/><br/></td></tr>
		<tr>
				 <!-- 内容开始 -->
				<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
					<table height="22">
						<tr bgcolor="#dbeaf5">
							<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
								<font class="s" color="#104a7b"><b><a href="#" onclick="javascript:pushtime();">PUSH时间设置</a></b></font>
							</td>
						</tr>
					</table>
					<div align="center"><br/>
					设定邮件到达提醒的工作时间。</div>
				</td>
			</tr>
			<tr>
				<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
				</td>
			</tr>
			<tr>
				<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
					<table height="22">
						<tr bgcolor="#dbeaf5">
							<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
								<font class="s" color="#104a7b"><b><a href="#" onclick="javascript:pushwhitename();">信任列表</a></b></font>
							</td>
						</tr>
					</table>
					<div align="center"><br/>
						来自该列表中人员或邮箱的邮件不受过滤规则约束，仅受Push时间的约束。</div>
				</td>
			</tr>
			<tr>
				<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
				</td>
			</tr>
			<tr>
				<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
					<table height="22">
						<tr bgcolor="#dbeaf5">
							<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
								<font class="s" color="#104a7b"><b><a href="#" onclick="javascript:pushfilter();">邮件过滤</a></b></font>
							</td>
						</tr>
					</table>
					<div align="center"><br/>
						对信件按照您预先设定的规则进行自动过滤，使您免受垃圾邮件的骚扰。</div>
				</td>
				<td>
				</td>
				<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
				</td>
			</tr>
			<tr>
				<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
				</td>
			</tr>
		</table>
</div>
</div>
  </div>
  </div>

<!--Bottom Include-->
	<jsp:include page="../user/bottom.jsp" flush="true" />
<!--Bottom Include-->
  </body>
</html>
