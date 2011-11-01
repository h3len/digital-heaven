<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html>
  <head>
       <title><%= MipWebJSPUi.mipweb_user_export_user_1 %></title>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
     	  <script type="text/javascript">
       	function exportdoc(){
       		if(document.getElementById("excel").checked==true){
       			window.location.href="../user/export_user_last.jsp?type=excel";
       		}else if(document.getElementById("excel").checked==true){
       			window.location.href="../user/export_user_last.jsp?type=csv";
       		}
       	}
       </script>
  </head>
  
  <body>
		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_export_user_2 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_export_user_3 %></span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_export_user_4 %>
				</td>
				<td width="71%">
					<input type="radio" id="excel" checked="true"/><%= MipWebJSPUi.mipweb_user_export_user_5 %>
					
				</td>
			</tr>
		</table>
		<div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_export_user_6 %>" onclick="exportdoc()" /><input type="button" value="<%= MipWebJSPUi.mipweb_user_export_user_7 %>" onclick="parent.parent.GB_CURRENT.hide()" /></div>
  </body>
</html>
