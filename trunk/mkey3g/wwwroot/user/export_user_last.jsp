<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
       <title><%= MipWebJSPUi.mipweb_user_export_user_last_1 %></title>
       <script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
       <script type="text/javascript">
       	var type='<%=request.getParameter("type")%>';
       	window.onload=function(){
       		if(type=='excel'){
       			document.getElementById('exportdoc').innerHTML="mycontact.xls";
       			document.getElementById('exportdoc').href="../masuser.do?action=exportExcel&type="+type
       		}else{
       			document.getElementById('exportdoc').innerHTML="mycontact.csv";
       			document.getElementById('exportdoc').href="../masuser.do?action=exportExcel&type="+type
       		}
       	}
       </script>
  </head>
  
  <body>
		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_export_user_last_2 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_export_user_last_3 %></span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_export_user_last_4 %>
				</td>
				<td width="71%">
					<a id="exportdoc" href="" style="cursor:pointer;text-decoration:underline;color:#039;font-weight:bolder;"></a>
				</td>
			</tr>
		</table>
		<div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_export_user_last_5 %>" onclick="parent.parent.GB_CURRENT.hide()" /></div>
  </body>
</html>
