<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || !request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

<html>
	<head>
		<title><%= MipWebMoreUi.mip_user_admin_mobiletype_1 %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="../css/user.css" />
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

	
		<script type="text/javascript">
   //公共变量
   var progressBar;
   var currentId = "";
  	var mobiletypeinfoxml;
	   //选项卡
		var tabPane;
	   
	   //初始化
	 window.onload = function()
	   {
	   GetMobileTypeList();
	   tabPane = new WebFXTabPane( document.getElementById( "tabMobileType" ), true );
	   }    

	   /*--------------------------------------------------------------
	       功能：取得列表
	   --------------------------------------------------------------*/
	   function GetMobileTypeList()
	   {
	       
     $('divList').style.display = "";
			$('divCreate').style.display = "none";
			$('divInfo').style.display = "none";

      //开始提交数据
      progressBar = new ProgressBar();
      progressBar.isNeedProgressBar = true;
      progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_2 %>");
      var url = "../mobiletype.do";
      var pars = 'action=GetMobileTypeList';
      var myAjax = new Ajax.Request(
      url,
      {method: 'post', parameters: pars, onComplete: GetMobileTypeList_CallBack}
	       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得信息列表 - CallBack
	   --------------------------------------------------------------*/
	   function GetMobileTypeList_CallBack(originalRequest)
	   {
      var objXml = originalRequest.responseXML;
      document.getElementById("divMobileTypeList").innerHTML = "";
      DisplayTransformedXML(1, objXml, "../xslt/admin_mobiletype_list.xsl",document.getElementById("divMobileTypeList"));
      progressBar.Close();        
				//$('spanCurrentPosition').innerHTML = "手机类型列表";
	   } 
	   
	   /*--------------------------------------------------------------
	 	功能：载入新建信息界面
	---------------------------------------------------------------*/
	function LoadMobileTypeCreate()
	{
		
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
	
		$('divMobileTypeCreate').style.display = "";
				
		//开始提交数据
   progressBar = new ProgressBar();
   progressBar.isNeedProgressBar = true;
   progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_3 %>");
		$('divMobileTypeCreate').innerHTML = "";
		DisplayTransformedXML(1, "<root/>", "../xslt/admin_mobiletype_create.xsl",document.getElementById("divMobileTypeCreate"));
		//$('spanCurrentPosition').innerHTML = "创建手机类型信息";
		progressBar.Close();

	   }

	
	   /*--------------------------------------------------------------
		功能：新建信息
	---------------------------------------------------------------*/
	function MobileTypeCreate()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_4 %>");
		var checkform = new CheckForm();
		if(checkform.Trim($F('mobiletype')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "mobiletypenum";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_5 %>");
     return;
	     }
		if(checkform.Trim($F('height')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "startposition";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_6 %>");
     return;
	     }
		if(checkform.Trim($F('width')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "endposition";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_mobiletype_7 %>");
     return;
	     }
		if(checkform.Trim($F('ua')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "startmobiletypetime";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_8 %>");
     return;
	     }
	       
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_9 %>");
		var url = '../mobiletype.do';
		var pars = 'action=MobileTypeCreate&mobiletype=' + $F('mobiletype') + '&height=' + $F('height')
								+ '&width=' + $F('width')+ '&ua=' + $F('ua');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: MobileTypeCreate_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：新建信息 - CallBack
	---------------------------------------------------------------*/
	function MobileTypeCreate_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseText);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_10 %>");
				progressBar.Close();
				
				$('divMobileTypeCreate').innerHTML = "";
				//重新加载信息列表
				GetMobileTypeList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_11 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_12 %>"+err.message);
		}
	}
			
	/*--------------------------------------------------------------
	 	功能：载入修改信息界面
	---------------------------------------------------------------*/
	function LoadMobileTypeModify()
	{
		$('divMobileTypeShow').style.display = "none";
		$('divMobileTypeModifyInfo').style.display = "";
		$('divMobileTypeCreate').innerHTML = "";
		$("divMobileTypeModifyInfo").innerHTML="";
		DisplayTransformedXML(1, mobiletypeinfoxml, "../xslt/admin_mobiletype_modify.xsl",document.getElementById("divMobileTypeModifyInfo"));
   }

	/*--------------------------------------------------------------
		功能：修改信息
	--------------------------------------------------------------*/
	function MobileTypeModify()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_13 %>");
		
		var checkform = new CheckForm();
		if(checkform.Trim($F('mobiletype')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "mobiletypenum";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_14 %>");
     return;
	     }
		if(checkform.Trim($F('height')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "startposition";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_mobiletype_15 %>");
     return;
	     }
		if(checkform.Trim($F('width')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "endposition";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_16 %>");
     return;
	     }
		if(checkform.Trim($F('ua')) == "")
	    {
     progressBar.isNeedConfirmButton = true;
     progressBar.focusItem = "startmobiletypetime";
     progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_17 %>");
     return;
	     }
	       
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_18 %>");
		var url = '../mobiletype.do';
		var pars = 'action=MobileTypeModify&mobiletype=' + $F('mobiletype') + '&height=' + $F('height')
								+ '&width=' + $F('width')+ '&ua=' + $F('ua')+"&mobiletypeid="+currentId;
		
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: MobileTypeModify_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改信息 - CallBack
	--------------------------------------------------------------*/
	function MobileTypeModify_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
		    //alert(originalRequest.responseText);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_mobiletype_19 %>");				
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_mobiletype_20 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_21 %>"+err.message);
		}
	}
	
	/*--------------------------------------------------------------
		功能：信息详情
	--------------------------------------------------------------*/
	function MobileTypeShow(id)
	{
		currentId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divMobileType').style.display = "";
	
		$('divMobileTypeShow').style.display = "";
		$('divMobileTypeModifyInfo').innerHTML = "";
		$('divMobileTypeModifyInfo').style.display = "none";
	
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_22 %>");
		var url = '../mobiletype.do';
		var pars = 'action=MobileTypeShow&mobiletypeid='+currentId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: MobileTypeShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：信息详情 - CallBack
	--------------------------------------------------------------*/
	function MobileTypeShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
		mobiletypeinfoxml = objXml;
		document.getElementById("divMobileTypeShow").innerHTML="";
		DisplayTransformedXML(1, objXml, "../xslt/admin_mobiletype_show.xsl",document.getElementById("divMobileTypeShow"));
		//$('spanCurrentPosition').innerHTML = "<b>"+objXml.getElementsByTagName("item").item(0).getAttribute("mobiletypenum")+"</b> 信息";
		
	//设置tab为第一个
	tabPane.setSelectedIndex(0);
}


/*--------------------------------------------------------------
	功能：删除信息信息
--------------------------------------------------------------*/
function MobileTypeDelete()
{
	if(confirm("<%= MipWebMoreUi.mip_user_admin_mobiletype_23 %>"))
	{	
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_mobiletype_24 %>");
		var url = '../mobiletype.do';
		var pars = 'action=MobileTypeDelete&mobiletypeid='+currentId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: MobileTypeDelete_CallBack}
		);
	}
}
/*--------------------------------------------------------------
	功能：删除信息信息 - CallBack
--------------------------------------------------------------*/
function MobileTypeDelete_CallBack(originalRequest)
{
	try
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_25 %>");
			progressBar.Close();
			GetMobileTypeList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_26 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_mobiletype_27 %>"+err.message);
	}
}	

	</script>

	</head>
	<body>
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
								<li ><font size="+1"><%= MipWebMoreUi.mip_user_admin_mobiletype_28 %></font></li>
								<%if(request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))//dheaven帐号专用
		 						{%>
								<li ><a href="../user/admin_config.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_mobiletype_29 %></a></li>
								<li ><a href="../user/admin_mobiletype.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_mobiletype_30 %></a></li>
								  <%} %>
								<li ><a href="../user/admin_enterpriseconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_mobiletype_31 %></a></li>
								<li ><a href="../mail/admin_enterprisemailconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_mobiletype_32 %></a></li>
							
								
								
              

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
					<div class="nav">&nbsp;<%= MipWebMoreUi.mip_user_admin_mobiletype_33 %><a href="../user/main.jsp"><%= MipWebMoreUi.mip_user_admin_mobiletype_34 %></a><%= MipWebMoreUi.mip_user_admin_mobiletype_35 %><span id="spanCurrentPosition"></span></div>

					
			<!--列表-->
					<div id="divList">
						<div style="padding:5px;text-align:right;background-color:#fff;">
								<input type="button" onClick="javascript:LoadMobileTypeCreate();" value="<%= MipWebMoreUi.mip_user_admin_mobiletype_36 %>" />
						</div>
						<div id="divMobileTypeList"></div>
						<div style="padding:5px;text-align:right;background-color:#fff;">
							<input type="button"	onclick="javascript:LoadMobileTypeCreate();" value="<%= MipWebMoreUi.mip_user_admin_mobiletype_37 %>" />
						</div>
					</div>
	
					<!--创建-->
					<div id="divCreate" style="float:left">
					<div id="divMobileTypeCreate"></div>
					</div>
	
					<!--详情-->
					<div id="divInfo" style="display:none;">
						<div id="divMobileType" style="display:none;">
							<div id="tabMobileType" class="tab-pane" style="margin-top:6px;">
								<div class="tab-page" id="tabPage1">
									<h2 class="tab">
										<%= MipWebMoreUi.mip_user_admin_mobiletype_38 %>
									</h2>
									<div id="divMobileTypeShow"></div>
									<div id="divMobileTypeModifyInfo" style="display:none;"></div>
								</div>							
								<div class="tab-page" id="tabPage4">
									<h2 class="tab">
										<%= MipWebMoreUi.mip_user_admin_mobiletype_39 %>
									</h2>
									<div class="attention">
										<img alt="" src="../images/ico_info.gif" />
										<%= MipWebMoreUi.mip_user_admin_mobiletype_40 %>
									</div>
									<div style="text-align:right;padding:20px;">
										<input type="button" onClick="javascript:MobileTypeDelete();" value="<%= MipWebMoreUi.mip_user_admin_mobiletype_41 %>" />
									</div>
								</div>
							</div>
						</div>
						</div>
		</div>
	</div>
	</div>
	</body>
</html>
