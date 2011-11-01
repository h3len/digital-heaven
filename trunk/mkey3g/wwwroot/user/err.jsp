
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%= MipWebJSPUi.mipweb_user_err_1 %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

<script type="text/javascript">
   //得到文件目录
     var currentPath = opener.document.getElementById('currentPath').value;
     
	function refresh(){
		 //刷新父窗体
        opener.getDirAndFile(currentPath,"private");
        opener.document.getElementById("pid0").innerText = ""
        opener.getXML(opener.document.getElementById("pid0"),'/',0);		  
	}
		
    </script>

  </head>
  
  <body text="silver" topmargin="0" leftmargin="0"
		marginwidth="0" marginheight="0" style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid"
		onload="javascript:refresh();">

  <br>
    <table width="520" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#E1E7EC">				
				<tr>
					<td width="85%" align="center" style="PADDING-TOP:20px"><b><%= MipWebJSPUi.mipweb_user_err_2 %></b>：</td>				
					</td>
				</tr>
				<tr>
					<td width="85%" align="center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_err_3 %>" onclick="javascript:window.opener == null;window.close();"></td>				
				</tr>				
		  </table>
  </body>
</html>
