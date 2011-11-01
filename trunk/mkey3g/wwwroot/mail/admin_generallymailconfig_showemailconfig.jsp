<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>常用邮箱详情</title>
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
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

		<script src="../dwr/interface/MipEnterpriseMailConfigWeb.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
		
<script type="text/javascript">
  var mailconfigid = "<%=request.getParameter("mailconfigid")%>" ;
  window.onload = function() {
  	MipEnterpriseMailConfigWeb.findMailconfigById(mailconfigid,
	{
		callback:function(oMap) {
			dwr.util.setValues(oMap);
			//alert($('mailconfigname').innerText) ;
			ChangeMailStyle($('emailstyle').value)
		},
		errorHandler:function(errorString, exception) {
			DHalert(errorString) ;
		}
	}) ;
  }
  function ChangeMailStyle(value)
    {
    	if(value=="POP3"){
    		$('emailstylenew').innerText="POP3" ;
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="DOMINO"){
    		$('emailstylenew').innerText="DOMINO" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="Exchange"){
    		$('emailstylenew').innerText="Exchange 2003" ;
	    	document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="none";
    	}else if(value=="IMAP") {
    		$('emailstylenew').innerText="IMAP4" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			document.getElementById('checkbox_div5').style.display="";
    	}else{
    		$('emailstylenew').innerText="Exchange 2007" ;
			document.getElementById('checkbox_div1').style.display="none";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="";
			document.getElementById('checkbox_div5').style.display="none";
    	}
    }
</script>
</head>
  
<body style="width:800px;">
<div>
  <div id="divUserMailconfig" style="margin-left:10px" >
  <input type="hidden" id="emailstyle" />
	<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">常用邮箱名：</td>
			<td id="mailconfigname"></td>
		</tr>
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">邮箱类型：</td>
			<td id="emailstylenew"></td>
		</tr>
		<tr>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%" height="24">邮件服务器地址：</td>
			<td id="mailserver"></td>
		</tr>
	</table>

	<table width="100%" bgcolor="" border="0" cellpadding="0"
		cellspacing="1">
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
							<td id="imapserver"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">IMAP端口：</td>
							<td id="imapport"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td id="smtpserverforimap"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td id="smtpportforimap"></td>
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
							<td id="pop3server"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">POP3端口：</td>
							<td id="pop3port"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP服务器地址：</td>
							<td id="smtpserver"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">SMTP端口：</td>
							<td id="smtpport"></td>
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
								<td id="owa"></td>
							</tr>
							<tr>
								<td width="16">
									<img
										src="../skin/default/images/text_icon.gif" />
								</td>
								<td width="25%">邮件域：</td>
								<td id="maildomain2003"></td>
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
							<td id="pushmailip3"></td>
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
							<td id="exchangeServer"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">邮件域：</td>
							<td id="maildomain2007"></td>
						</tr>
						<!-- <tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">服务器主机地址：</td>
							<td id="exchangeHost"></td>
						</tr>
						<tr>
							<td width="16">
								<img
									src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="25%">Exchange端口：</td>
							<td id="exchangePort"></td>
						</tr>-->
					</table>
				</div>
				<!--checkbox_div4-->
			</td>
		</tr>
	</table>
  </div>
</div>

  </body>
</html>
