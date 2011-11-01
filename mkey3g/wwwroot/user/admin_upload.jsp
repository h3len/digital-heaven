<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>window.opener.parent.location.href='../default.jsp';window.close();window.opener==null;</script>");
  return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%= MipWebJSPUi.mipweb_user_admin_upload_1 %></title>    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <link href="../css/user.css" rel="stylesheet" type="text/css">
<!-- common.js 通用js调用 -->
<script language="javascript" src="../scripts/common.js"></script>
<!-- css.css 通用css调用 -->
<link href="theme/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/transferxml.js"></script>
    <script language="javascript" src="../scripts/selall.js"></script>
    <script type="text/javascript" src="../scripts/tabpane.js"></script>
    <link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" /> 
  	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
  	<script type="text/javascript">
  		function upload()
  		{
  			var filename = document.getElementById('file').value;
  			
  			if(filename == '')
  			{
  				DHalert('<%= MipWebJSPUi.mipweb_user_admin_upload_2 %>');
  				return;
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
  				
  				DHalert('<%= MipWebJSPUi.mipweb_user_admin_upload_3 %>');
  				return;
  			}else
  			{
	  			document.getElementById('form1').submit();
	  		}
  		}
  	</script>
  </head>
  
  <body text="silver" topmargin="0" leftmargin="0" bgcolor="#E1E7EC"
		marginwidth="0" marginheight="0" style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid">
		
		
		<!--用户相关-->
		<div class="tab-pane" id="tabUser" style="margin-top:6px;margin-bottom:6px;">
			<div class="tab-page" id="tabPage6">
				<h2 class="tab"><%= MipWebJSPUi.mipweb_user_admin_upload_4 %></h2>				
				<div id="divLocal" style="padding-top:20px;padding-bottom:20px;">

			   <form id="form1" method="post" action="../importUser.do?catalogid=archieve" enctype="multipart/form-data">			
				<%= MipWebJSPUi.mipweb_user_admin_upload_5 %><input id="file" type="file" name="file" style="width:300px;" onpaste="return false" onkeydown="return false" />
					<p style="padding-top:10px;">
						<input type="button" class="button_4" ID="BtnOK" onclick="javascript:upload();" value="<%= MipWebJSPUi.mipweb_user_admin_upload_6 %>"/>&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="button" class="button_4" onclick="javascript:window.opener == null;window.close();" value="<%= MipWebJSPUi.mipweb_user_admin_upload_7 %>"/>
						</p>
				</form>		  
		  </div>
			</div>				
	</div>		

</body>
</html>
