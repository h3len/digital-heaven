<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>
<html>
	<head>
		<title><%= MipWebJSPUi.mipweb_user_admin_update_logs_1 %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="../css/user.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		
	
		<script type="text/javascript">
   //公共变量
   var progressBar;
   var currentId = "";
   var pageid = "<%=request.getParameter("pageid")!=null?request.getParameter("pageid"):"1"%>";
	   
	   //初始化
	window.onload = function()
	{
	    getUpdateLogsList(pageid);
	 }    
	   
	   /*--------------------------------------------------------------
	       功能：取得信息列表
	   --------------------------------------------------------------*/
	   function getUpdateLogsList(pageid)
	   {
      			//开始提交数据
      progressBar = new ProgressBar();
      progressBar.isNeedProgressBar = true;
      progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_update_logs_2 %>");
      var url = "../mas.do";
      var pars = 'action=getUpdateLogsList&pageid='+pageid;
      var myAjax = new Ajax.Request(
      url,
      {method: 'post', parameters: pars, onComplete: getUpdateLogsList_CallBack}
	       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得信息列表 - CallBack
	   --------------------------------------------------------------*/
	 function getUpdateLogsList_CallBack(originalRequest)
	   {
      var objXml = originalRequest.responseXML;
      document.getElementById("divLogsList").innerHTML = "";
      DisplayTransformedXML(1, objXml, "../xslt/admin_update_logs_list.xsl",document.getElementById("divLogsList"));
     	progressBar.Close();
	   } 
	   
	</script>
	</head>
	<body>
	
				<div id="mainbox" style="width:80%;height:auto;padding:3px;">
					<div class="nav">&nbsp;<img alt="" src="../images/icon.gif" /> <%= MipWebJSPUi.mipweb_user_admin_update_logs_3 %><a href="../user/main.jsp"><%= MipWebJSPUi.mipweb_user_admin_update_logs_4 %></a> <img alt="" src="../images/next.gif" /> <%= MipWebJSPUi.mipweb_user_admin_update_logs_5 %> <span id="spanCurrentPosition"></span></div>
					
	<form id="formlist" name="formlist">

		 <div id="mainbox">
				<!--列表-->
				<div id="divList" style="width:1000;float:left;">
					<div id="divLogsList"></div>
				</div>				
		</div>
	</form>
	</body>
</html>
