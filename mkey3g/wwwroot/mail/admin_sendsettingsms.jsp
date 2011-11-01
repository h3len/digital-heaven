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
    <title>发送设置短信</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
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
		
				<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
<script type="text/javascript">
    var userid = "<%=request.getParameter("userid")!=null?request.getParameter("userid"):request.getSession().getAttribute("user")%>";
			var xml;
    
  function ChangeMailStyle(value)
    {
    	$('emailstyle').value = value;
    	$('spanPort').innerHTML = value;
    }
    //根据所选外网邮箱导入
  function ChangeOutemailStyle()
    {
		if($('outemailstyle').value =="sina"){
			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.sina.com.cn ";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sina.com.cn";   			
 	    	$('smtpport').value = "25";   			
		}else if($('outemailstyle').value =="163"){
  			document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.163.com";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.163.com";   			
 	    	$('smtpport').value = "25";   			
		}else if($('outemailstyle').value =="sohu"){
    		document.getElementById('checkbox_div1').style.display="";
			document.getElementById('checkbox_div2').style.display="none";
			document.getElementById('checkbox_div3').style.display="none";
			document.getElementById('checkbox_div4').style.display="none";
			$('emailstyle').value="POP3";
 	    	$('pop3server').value = "pop3.sohu.com ";
 	    	$('pop3port').value = "110";
 	    	$('smtpserver').value = "smtp.sohu.com";   			
 	    	$('smtpport').value = "25";   			
		}else if($('outemailstyle').value =="self"){
			/*if($('emailstyle').value="POP3"){
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
			}
			if($('emailstyle').value=="Exchange"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
			}
			if($('emailstyle').value=="DOMINO"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="";
				document.getElementById('checkbox_div4').style.display="none";
			}
			if($('emailstyle').value=="Exchange2007"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="";
			} 	*/		
		}else if($('outemailstyle').value =="enterprise"){
			if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="POP3"){
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="Exchange"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="DOMINO"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("enterprisemail").item(0).getAttribute("emailstyle")=="Exchange2007"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="";
				document.getElementById('checkbox_div5').style.display="none";
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
				DisplayTransformedXML(1, objXml, "./xslt/enterprise_sendsettingsms.xsl",document.getElementById("divUserMailconfig"));
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="POP3"){
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="Exchange"){
				$('emailstyle').value = "Exchange2003"
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="DOMINO"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="Exchange2007"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="";
				document.getElementById('checkbox_div5').style.display="none";
			}
			if(xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew")=="IMAP"){
				document.getElementById('checkbox_div1').style.display="none";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
				document.getElementById('checkbox_div5').style.display="";
			}
			$('pop3server').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");
 	    	$('pop3port').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port");
 	    	$('smtpserver').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver");  			
 	    	$('smtpport').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport");  
 	    	$('emailstyle').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstylenew"); 	
 	    	$('owa').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");		
			$('pushmailip3').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");		
			$('exchangeServer').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");		
			$('pushmaildomain4').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("maildomain");		
			$('imapserver').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3server");		
			$('imapport').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("pop3port");		
			$('smtpserverforimap').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpserver");		
			$('smtpportforimap').value = xml.getElementsByTagName("mailconfig").item(0).getAttribute("smtpport");		
			//设置删除mailconfig按钮
			/*if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("email") == ""){
				//设置默认选中的emailstyle
				ChangeMailStyle(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle"));
				document.getElementById('checkbox_div1').style.display="";
				document.getElementById('checkbox_div2').style.display="none";
				document.getElementById('checkbox_div3').style.display="none";
				document.getElementById('checkbox_div4').style.display="none";
			}*/
	
			//设置提示的邮件地址,格式为username#enterprisecode@ServerConfig.serverip
			document.getElementById("mailserveraddress").innerHTML=objXml.getElementsByTagName("mailtoaddress").item(0).getAttribute("value");
		});	
	}
	
	
	/*-------------------------------------------------------------
		功能：修改mailconfig
	--------------------------------------------------------------*/
	function UserMailconfig()
	{
		//验证页面控件
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
		if($('emailstyle').value=="POP3")
		{
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

						MailConfig.saveUserMailconfig($('email').value,$('username').value,$('mailpassword').value,$('emailstyle').value,$('pop3server').value,$('smtpserver').value,$('smtpserver').value,$('smtpport').value,$('outemailstyle').value,userid,alerttype,
								function(data){				 
									if(data == "1"){
										DHalert("操作成功！");
										//重新加载mailconfig
										LoadUserMailconfig();
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
		Ext.Msg.confirm('删除', '确定要删除该邮箱绑定吗？', function(btn){
							if(btn=='yes'){
								MailConfig.DelMailconfig(userid,
								function(data){				 
									if(data == "1"){
										DHalert("操作成功！");
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


	function sendsettingsms(){
	
		//验证页面控件
		Progress("数据正在载入...","提示");
		
		if($('email').value == "")
		{
			DHalert("邮箱没有绑定！",140);
				return false;
		}
		
		if($('username').value == "")
		{
			
			DHalert("邮箱没有绑定！",140);
				return false;
		}
		/*if($('pop3port').value == "")
		{
			
				DHalert("邮箱没有绑定！");
				return false;
		}
			if($('smtpport').value == "")
		{
			
				DHalert("邮箱没有绑定！");
				return false;
		}*/
		
		Progress("数据正在载入...","提示");
		MailConfig.sendSettingSmsEnterprise(userid,
				function(data){				 
					if(data == "1"){
						DHalert("操作成功！",140);
						
						parent.parent.GB_CURRENT.hide();
					}else{
						DHalert("操作失败，失败原因："+data);
						return false;
					}
					CloseProgress();
				}
				);
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
<td whith="50%" border="1">
   <div id="divUserMailconfig"></div></td>
<td>
<div style="display:none;bgcolor:#40ACF5;border:1px solid #DAE98E;width:250px; height:200px;padding:10px;">
	<div align="center" style="font-size: 16px;font-family: 黑体;width:100%;">提示</div>
	<p>服务器支持邮件转发方式的Push,请把邮件从您公司的邮件服务器上，转发到</p>
	<b style="color: red;" id="mailserveraddress"></b>
	<p>移动办公服务器收到您邮箱转发的邮件后会立即进行Push，速度比普通轮巡大大提高！</p>
</div>
</td></tr></table>
</div>


  </body>
</html>
