<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html>
  <head>
       <title><%= MipWebJSPUi.mipweb_user_import_user_2 %></title>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
			<script type="text/javascript" src="../scripts/prototype.js"></script>
			<link href="../theme/css.css" rel="stylesheet" type="text/css" />
     	  <script type="text/javascript">
       	function importdoc(){
       		
       	}
       	function upload(){
					       	if(document.getElementById("excel").checked==true){
					       		document.getElementById('ftype').value="excel";
				       		}
    						var file=document.getElementById('file').value;
    						
    						var file_type=file.substring(file.lastIndexOf(".")+1)
    						
    						if(document.getElementById("excel").checked){
    							if(file_type!="XLS"&&file_type!="xls"){
    								alert('<%= MipWebJSPUi.mipweb_user_import_user_1 %>');
    								return;
    							}	
    						}
    						form1.submit();
    					}
    					
    	function forexample(){
    		$('example').href="../masuser.do?action=exportexample";
    	}
       </script>
  </head>
  
  <body>
  	<form id="form1" method="post" action="../userimport.do" enctype="multipart/form-data">
		<div class="up_title">
			<span class="blue_14_blod"><%= MipWebJSPUi.mipweb_user_import_user_3 %></span>
		</div>
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
					<input type="radio" id="excel" name="filetype" checked="true"/><%= MipWebJSPUi.mipweb_user_import_user_6 %> <a id="example"  href="#" onclick="forexample()" class="blue_12"><%= MipWebJSPUi.mipweb_user_import_user_7 %></a>
					
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
					<input id="ftype" name="ftype" type="hidden" >
				</td>
			</tr>
		</table>
		</form>
		<div style="text-align:center"><input type="button" onclick="javascript:upload();"  id="BtnOK" value="<%= MipWebJSPUi.mipweb_user_import_user_9 %>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<button onclick="parent.parent.GB_CURRENT.hide()"><%= MipWebJSPUi.mipweb_user_import_user_10 %></button></div>
  </body>
</html>
