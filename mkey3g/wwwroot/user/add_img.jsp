<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>alert('"+ MipWebJSPUi.mipweb_user_add_img_4 +"');window.opener =null;window.close();</script>");
  return;
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%= MipWebJSPUi.mipweb_user_add_img_1 %></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <link href="../css/user.css" rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
 <script type="text/javascript" src="../scripts/common.js"></script>
			<script type="text/javascript" src="../scripts/transferxml.js"></script>
			<script type="text/javascript" src="../scripts/tabpane.js"></script>
			<script language="javascript" src="../scripts/selall.js"></script>
			<script type="text/javascript" src="../scripts/xtree.js"></script>
			<script type="text/javascript" src="../scripts/xmlextend.js"></script>
			<script type="text/javascript" src="../scripts/xmlextras.js"></script>
			<script type="text/javascript" src="../scripts/xloadtree.js"></script>
			<script type="text/javascript" src="../scripts/checkform.js"></script>
			<script type="text/javascript" src="scripts/mobiledisk.js"></script>			
    <script type="text/javascript">
    			
    			
    				function upload(){
    						var file=document.getElementById('file').value;
    						if(file==null||file==''||file==' '){
    							DHalert('<%= MipWebJSPUi.mipweb_user_add_img_2 %>') ;
    							return ;
    						}
    						
    						var file_type=file.substring(file.lastIndexOf(".")+1)
    						
    						if(file_type!="jpg"&&file_type!="gif"&&file_type!="wbmp"&&file_type!="png"&&file_type!="bmp"&&file_type!="jpeg"&&file_type!="tiff"&&file_type!="tga"&&file_type!="eps"&&file_type!="psd"&&file_type!="swf"&&file_type!="svg"){
    							if(file_type!="JPG"&&file_type!="GIF"&&file_type!="WBMP"&&file_type!="PNG"&&file_type!="BMP"&&file_type!="JPEG"&&file_type!="TIFF"&&file_type!="TGA"&&file_type!="EPS"&&file_type!="PSD"&&file_type!="SWF"&&file_type!="SVG"){
    								DHalert('<%= MipWebJSPUi.mipweb_user_add_img_3 %>');
    								return;
    							}	
    						}
    						form1.submit();
    					}
    </script>
  </head>
  
  <body><div style="margin:0px auto;margin-top:50px;">
			<div style="margin:0px auto;BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid;color:#E1E7EC">
				<form id="form1" method="post" action="../userPhotoUpload.do" enctype="multipart/form-data">
					<table>
						<tr>
							<td>
					<%= MipWebJSPUi.mipweb_user_add_img_5 %><input id="file" onpaste="return false" onkeydown="return false" type="file" NAME="file" style="width:300px;">
						<input type="hidden" id="type" name="type" value="0"/>
							</td>
						</tr>
						<tr>
							<td style="text-align:center;">
							<input class="button_4" type="button" onclick="javascript:upload();"  id="BtnOK" value="<%= MipWebJSPUi.mipweb_user_add_img_6 %>">&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="<%= MipWebJSPUi.mipweb_user_add_img_7 %>" class="button_4" onclick="javascript:window.opener == null;window.close();" />
							</td>
						</tr>
					</table>
			
				</form>
			</div>
				
				
	</div>

		
		  
</body>
</html>
