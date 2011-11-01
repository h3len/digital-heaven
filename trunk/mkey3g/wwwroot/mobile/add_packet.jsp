<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>alert('"+ MipWebJSPUi.mipweb_mobile_add_packet_8 +"');window.opener =null;window.close();</script>");
  return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%= MipWebJSPUi.mipweb_mobile_add_packet_1 %></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <link href="../css/user.css" rel="stylesheet" type="text/css">
	<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
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
    						var filename = document.getElementById('file').value;
  			
				  			if(filename == '')
				  			{
				  				DHalert('<%= MipWebJSPUi.mipweb_mobile_add_packet_2 %>');
				  				return ;
				  			}
				  			if(filename.indexOf(".")<0){
				  				DHalert('<%= MipWebJSPUi.mipweb_mobile_add_packet_3 %>');
				  				return ;
				  			}
							if(filename.indexOf("\\")>0){
								filename=filename.substring(filename.lastIndexOf('\\')+1);
							}
							if(filename.indexOf("/")>0){
								filename=filename.substring(filename.lastIndexOf('/')+1);
							}
							//filename=filename.substring(filename.lastIndexOf('/'));
							//alert(filename)
							if(filename.length>100)
				  			{
				  				
				  				DHalert('<%= MipWebJSPUi.mipweb_mobile_add_packet_4 %>');
				  			}else
				  			{
					  			document.getElementById('form1').submit();
					  		}
    					}
    </script>
  </head>
  
  <body><div style="margin:0px auto;margin-top:50px;">
			<div style="margin:0px auto;BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid;color:#E1E7EC">
				<form id="form1" method="post" action="../packetupload.do" enctype="multipart/form-data">

					<p style="color:#2F5C7C"><%= MipWebJSPUi.mipweb_mobile_add_packet_5 %><input id="file" type="file" NAME="file" style="width:300px;"  onpaste="return false" onkeydown="return false" onchange="javascript:this.readonly=true"></p>
						<input type="hidden" id="mms_message" name="mms_message" value=""/>
						<input type="hidden" id="page_no" name="page_no" value="1"/>
						<input type="hidden" id="type" name="type" value="img"/>
					<p><input type="button" onclick="javascript:upload();"  id="BtnOK" value="<%= MipWebJSPUi.mipweb_mobile_add_packet_6 %>">&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="button" onclick="javascript:window.opener == null;window.close();"  id="Btncal" value="<%= MipWebJSPUi.mipweb_mobile_add_packet_7 %>"></p>
		
			
				</form>
			</div>
				
				
	</div>

		
		  
</body>
</html>
