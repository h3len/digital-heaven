<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html>
  <head>
       <title><%= MipWebJSPUi.mipweb_user_import_personal_user_1 %></title>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
     	  <script type="text/javascript">
       	function importdoc(){
       		
       	}
       	function upload(){
					       	if(document.getElementById("excel").checked==true){
					       		document.getElementById('ftype').value="excel";
				       		}else if(document.getElementById("csv").checked==true){
				       			document.getElementById('ftype').value="csv";
				       		}
    						var file=document.getElementById('file').value;
    						
    						var file_type=file.substring(file.lastIndexOf(".")+1)
    						
    						if(document.getElementById("excel").checked){
    							if(file_type!="XLS"&&file_type!="xls"){
    								alert('<%= MipWebJSPUi.mipweb_user_import_personal_user_2 %>');
    								return;
    							}	
    						}
    						if(document.getElementById("csv").checked){
    							if(file_type!="CSV"&&file_type!="csv"){
    								alert('<%= MipWebJSPUi.mipweb_user_import_personal_user_3 %>');
    								return;
    							}	
    						}
    						form1.submit();
    					}
       </script>
  </head>
  
  <body>
  	<form id="form1" method="post" action="../userupload.do" enctype="multipart/form-data">
		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_import_personal_user_4 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_import_personal_user_5 %></span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">

			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_personal_user_6 %>
				</td>
				<td width="71%">
					<input type="radio" id="excel" name="filetype" checked="true"/><%= MipWebJSPUi.mipweb_user_import_personal_user_7 %><input type="radio" id="csv" name="filetype"/><%= MipWebJSPUi.mipweb_user_import_personal_user_8 %>
					
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_personal_user_9 %>
				</td>
				<td width="71%">
					<input id="file" type="file" NAME="file" style="width:300px;">
					<input id="ftype" name="ftype" type="hidden" >
				</td>
			</tr>
		</table>
		</form>
		<div style="text-align:center"><input type="button" onclick="javascript:upload();"  id="BtnOK" value="<%= MipWebJSPUi.mipweb_user_import_personal_user_10 %>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<button onclick="parent.parent.GB_CURRENT.hide()"><%= MipWebJSPUi.mipweb_user_import_personal_user_11 %></button></div>
  </body>
</html>
