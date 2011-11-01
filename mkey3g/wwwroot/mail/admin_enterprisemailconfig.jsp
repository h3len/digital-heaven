<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>邮箱配置管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link type="text/css" rel="stylesheet" href="css.css" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="css.css" />
		<link type="text/css" rel="stylesheet" href="../css/user.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		
		
<script type="text/javascript">
    var progressBar;
    var currentCatalogId = "<%=request.getSession().getAttribute("enterpriseid")%>";
	
	window.onload = function()
	{
		 if("<%=request.getSession().getAttribute("user")%>" == "<%=com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID%>")
		 {
		 GetEnterpriseMailConfigList();	 
		 }
		 else
		 {
		 LoadUserMailconfig();
		 }
	} 

	
	/*--------------------------------------------------------------
		功能：GetEnterpriseMailConfigList
	---------------------------------------------------------------*/
	function GetEnterpriseMailConfigList()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
   progressBar.isNeedProgressBar = true;
   progressBar.Top = 10;
   progressBar.SetStatus("正在载入数据....");	
		var url = '../catalog.do';
		var pars = 'action=GetCatalogList';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetEnterpriseMailConfigList_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：GetEnterpriseMailConfigList_CallBack - CallBack
	---------------------------------------------------------------*/
	function GetEnterpriseMailConfigList_CallBack(originalRequest)
	{
	  var objXml = originalRequest.responseXML;
	  DisplayTransformedXML(1, objXml, "../xslt/enterprisemailconfig_list.xsl",document.getElementById("divUserMailconfig"));
		progressBar.Close();
	}
	
    
    function ChangeMailStyle(value)
    {
    	$('emailstyle').value = value;
    	$('spanServer').innerHTML = value;
    	$('spanPort').innerHTML = value;
    }
	/*--------------------------------------------------------------
		功能：用户Mailconfig
	--------------------------------------------------------------*/
	function LoadUserMailconfig()
	{		
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在载入数据....");
		var url = '../mipEnterpriseMailConfig.do';
		var pars = 'action=LoadUserMailconfig&userid='+currentCatalogId;	
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
		//alert(originalRequest.responseText);
		//try{	
			DisplayTransformedXML(1, objXml, "../xslt/user_enterprisemailconfig.xsl",document.getElementById("divUserMailconfig"));
			//设置默认选中的emailstyle
			ChangeMailStyle(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("emailstyle"));
	
			//设置删除mailconfig按钮
			//alert(objXml.getElementsByTagName("mailconfig").item(0).attributes[4].value);
			if(objXml.getElementsByTagName("mailconfig").item(0).getAttribute("id") == "")
			{
				//表示该用户没有设置email绑定
				$("btnDeleteMailconfig").style.display = "none";
			}
			else
			{	
				$("btnDeleteMailconfig").style.display = "";
			}
			
		 if("<%=request.getSession().getAttribute("user")%>" == "<%=com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID%>")
			{
				//超级管理员可以返回企业列表
				$("btnReturnEnterpriseList").style.display = "";
			}
			else
			{	
				$("btnReturnEnterpriseList").style.display = "none";
			}
			
		//}catch(err){
		//	alert(errorMessage);
		//}
		
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
		
		if($F('pop3server') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "pop3server";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入pop3服务器地址！");
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
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp服务器地址！");
			return;
		}
		if($F('smtpport') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "smtpport";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有输入smtp端口！");
			return;
		}
		
		var enable = "";
		var enablelist = document.getElementsByName("enable");
		for(var i=0 ;i<enablelist.length;i++)
		{
			if(enablelist[i].checked)
			{
				enable = enablelist[i].value;
			}
		}
		if(enable == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "enable";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'>没有选择是否强制用户使用企业邮箱配置！");
			return;
		}

		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");

		var url = '../mipEnterpriseMailConfig.do';
		var pars = 'action=UserMailconfig&enable='+enable+'&emailstyle=' + $F('emailstyle')+ '&pop3server=' + $F('pop3server') + '&pop3port=' + $F('pop3port') + '&smtpserver=' + $F('smtpserver') + '&smtpport=' + $F('smtpport')+ '&userid='+currentCatalogId;
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
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				//绑定成功,需要激活删除按钮
				$("btnDeleteMailconfig").style.display = "";
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
			var url = '../mipEnterpriseMailConfig.do';
			var pars = 'action=DeleteMailconfig&userid='+currentCatalogId;
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
				$("btnDeleteMailconfig").style.display = "none";
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
	

	
</script>
	
  </head>
  
  <body style="padding:0px;margin:0px;">
  <div  style="width:1000px;">
		<div id="main" style="width:100%;padding:0px;">
			<div id="menu" style="width:176px; padding:0px;float:left;">
			
							<!-- Begin: left navigation -->
      <table width="176" border="0" cellspacing="0" cellpadding="0" class='LeftHandNavigation'>
        <tr> 
          <td class="leftnavtop"><img src="/images/spacer.gif" alt="" width="1" height="21" /></td>
        </tr>
        <tr> 
          <td class='container'>
								<ul>
								<li ><font size="+1">企业邮箱配置</font></li>
								<%if(request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))//dheaven帐号专用
		 						{%>
								<li ><a href="../user/admin_config.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;系统配置</a></li>
								<li ><a href="../user/admin_mobiletype.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;手机类型管理</a></li>
								  <%} %>
								<li ><a href="../user/admin_enterpriseconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;企业配置</a></li>
								<li ><a href="../mail/admin_enterprisemailconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;企业邮箱配置</a></li>
							
								
								
              

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
					<div class="nav">&nbsp;当前位置：<a href="../user/main.jsp">管理首页</a>>>  企业邮箱配置 <span id="spanCurrentPosition"></span></div>


		 <!-- 内容开始 -->
		<div id="divUserMailconfig" style="width:100%;padding:6px;text-align:center;background-color:#fff;float:left"></div>
		</div>
		</div>
		</div>
  </body>
</html>
