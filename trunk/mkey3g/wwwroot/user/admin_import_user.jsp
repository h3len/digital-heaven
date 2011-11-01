<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>window.opener.parent.location.href='../default.jsp';window.close();window.opener==null;</script>");
  return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%= MipWebMoreUi.mip_user_admin_import_user_1 %></title>    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <link href="../css/user.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../scripts/prototype.js"></script>   
    <script type="text/javascript" src="../scripts/transferxml.js"></script>
    <script language="javascript" src="../scripts/selall.js"></script>
    <script type="text/javascript" src="../scripts/tabpane.js"></script>
    
    <script type="text/javascript" src="../scripts/common.js"></script>
    
    <link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" /> 
    
    <script type="text/javascript">
    /*--------------------------------------------------------------
		功能：用户列表
	--------------------------------------------------------------*/
	function LoadUserListBySSO()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_import_user_2 %>");
		
		var url = '../masuser.do';
		var pars = 'action=LoadUserListBySSO&catalogid='+$F('catalogid');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadUserListBySSO_CallBack}
		);
	}
	/*-------------------------------------------------------------
		功能：用户列表 - CallBack
	--------------------------------------------------------------*/
	function LoadUserListBySSO_CallBack(originalRequest)
	{		
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseText);
			DisplayTransformedXML(1, objXml, "../xslt/ssouser_list.xsl",document.getElementById("divUserList"));
			progressBar.Close();
			//$('userLength').innerHTML = "用户:<font color=Red>"+objXml.selectNodes("/root/userlist/user").length+"</font>个 ";
		}
		catch(err)
		{
			alert(err.message);
		}
	}
	
	
	
	 /*--------------------------------------------------------------
		功能：Import用户
	--------------------------------------------------------------*/
	function ImportUser()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_import_user_3 %>");
		
		var strIds = SelectCheckbox("selected");
		
   var url = '../masuser.do';
		var pars = 'action=ImportUser&catalogid='+$F('catalogid')+'&strIds='+strIds;

		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: ImportUser_CallBack}
		);
	}
	/*-------------------------------------------------------------
		功能：用户 - CallBack
	--------------------------------------------------------------*/
	function ImportUser_CallBack(originalRequest)
	{		
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseText);
			
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_import_user_4 %>：<br/>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
				//从新载入
				LoadUserListBySSO();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_import_user_5 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			alert(err.message);
		}
	}

//全选all，反选antiselected，不选none，等等选择操作
function SelectCheckbox(action)
{
	var obj = document.getElementById('divUserList');
	var chklist = obj.getElementsByTagName('input');
	if(action == "all")
	{
		//选择全部		
		for(var i=0;i<chklist.length;i++)
		{
			chklist[i].checked = true;
		}
	}
	else if(action == "none")
	{
		//全部取消		
		for(var i=0;i<chklist.length;i++)
		{
			chklist[i].checked = false;
		}
	}
	else if(action == "antiselected")
	{
		//反选		
		for(var i=0;i<chklist.length;i++)
		{
			if(chklist[i].checked == false)
				chklist[i].checked = true;
			else
				chklist[i].checked = false;
		}
	}
	else if(action == "new")
	{
		//新增的
		for(var i=0;i<chklist.length;i++)
		{
			if(chklist[i].id.indexOf("new") > -1)
			{			
				chklist[i].checked = true;
			}
			else
			{
				chklist[i].checked = false;
			}
		}
	}
	else if(action == "update")
	{
		//更新的	
		for(var i=0;i<chklist.length;i++)
		{
			if(chklist[i].id.indexOf("update") > -1)
			{			
				chklist[i].checked = true;
			}
			else
			{
				chklist[i].checked = false;
			}
		}
	}
	else if(action == "delete")
	{
		//删除的	
		for(var i=0;i<chklist.length;i++)
		{
			if(chklist[i].id.indexOf("delete") > -1)
			{			
				chklist[i].checked = true;
			}
			else
			{
				chklist[i].checked = false;
			}
		}
	}
	else if(action == "selected")
	{
		//已选中的, 返回 new_id,update_id,delete_id,格式
		var strId = "";
		for(var i=0;i<chklist.length;i++)
		{
			if(chklist[i].checked == true)
			{			
				strId += chklist[i].id +",";
			}
		}
		return strId;
	}		
}
	</script>
  </head>
  
  <body text="silver" topmargin="0" leftmargin="0" bgcolor="#ffffff"
		marginwidth="0" marginheight="0" style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; MARGIN: 0pt; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid">
		
		
		<!--用户相关-->
		<div class="tab-pane" id="tabUser" style="margin-top:6px;margin-bottom:6px;">
			<div class="tab-page" id="tabPage6">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_import_user_6 %></h2>				
				<div id="divLocal" style="padding-top:20px;padding-bottom:20px;">
			   <form id="form1" method="post" action="../importUser.do?catalogid=<%=request.getParameter("catalogid") %>" enctype="multipart/form-data">			
				<%= MipWebMoreUi.mip_user_admin_import_user_7 %>：<input id="file" type="file" name="file" width="400"/>		
						<input type="hidden" id="catalogid" value="<%=request.getParameter("catalogid") %>" />
					<p style="padding-top:10px;">
						<input type="submit" ID="BtnOK" value="确认上传"/>&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="button" onClick="javascript:window.opener == null;window.close();" value="<%= MipWebMoreUi.mip_user_admin_import_user_8 %>" />						
						</p>
				</form>		  
		  </div>
			</div>
			<div class="tab-page" id="tabPage4">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_import_user_9 %></h2>
				<div id="divSSO">
				<p style="text-align:right;"><input type="button" onClick="LoadUserListBySSO();" value="<%= MipWebMoreUi.mip_user_admin_import_user_10 %>"/></p>
				<span id="userLength"></span>
				<div id="divUserList"></div>
				</div>
			</div>			
	</div>		

</body>
</html>
