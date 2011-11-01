<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.config.ServerConfig"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<html>
  <head>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
    	<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
     	  <script type="text/javascript">
     	     var enterpriseid = '<%=request.getParameter("enterpriseid")%>';
		   var appid ='<%=request.getParameter("appid")%>';
		   var apppageid = '<%=request.getParameter("pageid")!=null?request.getParameter("pageid"):1%>';
       	function upload(){
    						document.getElementById('appid').value=appid;
  	  					document.getElementById('enterpriseid').value = enterpriseid;
 						var file=document.getElementById('file').value;
 						if(file==""){
 						parent.parent.DHalert("请先选择EXCEL文件");
 						return;
 						}

 						var file_type=file.substring(file.lastIndexOf(".")+1)
							if(file_type!="XLS"&&file_type!="xls"&&file_type!="xlsx"&&file_type!="XLSX"){
								parent.parent.DHalert("文件格式不正确,请选择EXCEL文件");
								return;
							}
 						form1.submit();
 						document.getElementById('BtnOK').disabled = true;
 					}

    			function gohome(){
    				window.location.href="appuserconfig.jsp?appid="+appid+"&apppageid="+apppageid;
    			}
       </script>
  </head>

  <body>

  <%
  //服务器ip地址
  String serverIP=ServerConfig.serverip;
  //服务器端口号
  String serverPort=ServerConfig.serverport;
   %>
  <form id="form1" method="post" action="../importappuser.do" enctype="multipart/form-data">
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_import_user_4 %></span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_5 %>
				</td>
				<td width="71%">
					<input type="radio" id="excel" name="filetype" checked="true"/><%= MipWebJSPUi.mipweb_user_import_user_6 %> <a id="example"  href="../template/importAPPUser.xls"	 class="blue_12"><%= MipWebJSPUi.mipweb_user_import_user_7 %></a>

				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_8 %>
				</td>
				<td width="71%">
					<input id="file" type="file" NAME="file" style="width:300px;">
					<input id="enterpriseid" name="enterpriseid" type="hidden" >
					<input id="appid" name="appid" type="hidden" >
				</td>
			</tr>
		</table>
		</form>
	<div style="text-align:center">
		<input type="button"  class="button_4"  id="BtnOK" value="确认上传" onclick="upload();">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" onclick="parent.parent.GB_CURRENT.hide();" class="button_4" value="取消上传">
		</div>
  </body>
</html>
