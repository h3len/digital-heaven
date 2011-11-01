<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipself")==null)
		{
			out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipself");
			if(list == null || list.size() == 0)
			{
				out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				return;
			}
		}
	}
}
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><%= MipWebJSPUi.mipweb_user_admin_select_user_1 %></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="../css/user.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script type="text/javascript">
    
var currentCatalogId = "<%=request.getParameter("catalogid")%>";

   /*--------------------------------------------------------------
       功能：属于该角色的用户列表
   --------------------------------------------------------------*/
 function GetContactJoinUserList()
   {
   
   $('panelContactJoinUserList').style.display = "";
		$('panelJoinUser').style.display = "none";
		
       var url = "../contactuser.do";
       var pars = "action=GetContactJoinUserList&catalogid="+currentCatalogId;
       var myAjax = new Ajax.Request(
       url,
       {method: 'post', parameters: pars, onComplete: GetContactJoinUserList_CallBack}
       );
   }
   
   /*--------------------------------------------------------------
       功能：属于该角色的用户列表 - CallBack
   --------------------------------------------------------------*/
   function GetContactJoinUserList_CallBack(originalRequest)
   {
       var objXml = originalRequest.responseXML;
       DisplayTransformedXML(1, objXml, "../xslt/contact_whitename_list.xsl",document.getElementById("divContactJoinUserList"));
   }
   
   
function LoadJoinUser()
 {
	 	$('panelContactJoinUserList').style.display = "none";
		$('panelJoinUser').style.display = "";
 }
   
   
      
   /*--------------------------------------------------------------
	功能：加入用户
--------------------------------------------------------------*/
function JoinUser(id)
{
	var strId = SelCatalogAndUser();

 progressBar = new ProgressBar();
	progressBar.isNeedConfirmButton = false;
	progressBar.isNeedProgressBar = true;
	progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_select_user_2 %>");
	var url = '../contactcatalog.do';
	var pars = 'action=JoinUser&catalogid='+currentCatalogId+'&strId='+strId;
	
	var myAjax = new Ajax.Request(
	url,
	{method: 'post', parameters: pars, onComplete: JoinUser_CallBack}
	);
}

/*--------------------------------------------------------------
	功能：加入角色 - CallBack
--------------------------------------------------------------*/
function JoinUser_CallBack(originalRequest)
{
	try
	{
		var objXml = originalRequest.responseXML;
		//Debug(originalRequest.responseTEXT);
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_select_user_3 %>");
			progressBar.Close();
			//重新加载列表
			GetContactJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_select_user_4 %><br/><%= MipWebJSPUi.mipweb_user_admin_select_user_5 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_select_user_6 %><br/><%= MipWebJSPUi.mipweb_user_admin_select_user_7 %>"+err.message);
	}
}

/*--------------------------------------------------------------
	功能：退出角色
--------------------------------------------------------------*/
function UnJoinUser(id)
{
  progressBar = new ProgressBar();
	progressBar.isNeedConfirmButton = false;
	progressBar.isNeedProgressBar = true;
	progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_select_user_8 %>");
	var url = '../contactcatalog.do';
	var pars = 'action=UnJoinUser&catalogid='+currentCatalogId+'&userid='+id;
	var myAjax = new Ajax.Request(
	url,
	{method: 'post', parameters: pars, onComplete: UnJoinUser_CallBack}
	);
}

/*--------------------------------------------------------------
	功能：退出角色 - CallBack
--------------------------------------------------------------*/
function UnJoinUser_CallBack(originalRequest)
{
	try
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_select_user_9 %>");
			progressBar.Close();
			//重新加载列表
			GetContactJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_select_user_10 %><br/><%= MipWebJSPUi.mipweb_user_admin_select_user_11 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_select_user_10 %><br/><%= MipWebJSPUi.mipweb_user_admin_select_user_11 %>"+err.message);
	}
}

    
    </script>
	</head>

	<body onload="javascript:GetContactJoinUserList();" text="silver"
		topmargin="0" leftmargin="0" bgcolor="#E1E7EC" marginwidth="0"
		marginheight="0"
		style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid">


		<!--用户相关-->
		<div class="tab-pane" id="tabUser"
			style="margin-top:6px;margin-bottom:6px;">
			<div class="tab-page" id="tabPage6">
				<h2 class="tab">
					<%= MipWebJSPUi.mipweb_user_admin_select_user_12 %>
				</h2>

				<p class="ar" style="color:Gray">
					<%= MipWebJSPUi.mipweb_user_admin_select_user_13 %>
				</p>
				<div id="panelContactJoinUserList">
					<div style="padding:5px;text-align:right;background-color:#fff;">
						<input type="button" class="button"
							onclick="javascript:LoadJoinUser();" value="<%= MipWebJSPUi.mipweb_user_admin_select_user_14 %>" />
					</div>
					<div id="divContactJoinUserList"></div>
				</div>
				<div id="panelJoinUser" style="display:none;">
					<table width="98%" cellpadding="0" cellspacing="1"
						style="margin:5px;">
						<tr bgColor="#f1f1f1">
							<td width="50%">
								<b><%= MipWebJSPUi.mipweb_user_admin_select_user_15 %></b>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<div id="divUserTree"
									style="text-align:left;height:380px;width:260px; overflow:auto;overflow-y:yes;">
									<script src="../scripts/jsvm2/jsre.js"
										classpaht="webfx/xtree1.1.js"></script>
									<script language="javascript">
	_import("com.eae.webfx.xtree.WebFXLoadTree");
	_import("com.eae.webfx.xtree.WebFXTree");
	_import("com.eae.webfx.xtree.WebFXTreeItem");	
	</script>
									<script type="text/javascript">
	var atree = new WebFXLoadTree("<%= MipWebJSPUi.mipweb_user_admin_select_user_16 %>","../catalog.do?action=GetCatalogForTextNode&catalogid=<%=request.getSession().getAttribute("enterpriseid")%>");
	//当选中某个节点的时候，必须选中子，modify by yesun	
	atree.onCheck = function (node, tree)
	{

		//把子部门选上	
		if(node.isChecked() == true)
		{
			SelChildNodes(node);
			SelParentNode(node);
		}
		else
		{
			UnSelChildNodes(node);
			UnSelParentNode(node);
		}
		//GetCalendarByDateAndUserId(node.value);	
	}
	atree.build();
	//全部展开
	atree.expandAll();

	//选择子
	function SelChildNodes(node)
	{
		var i = 0;
		for(i=0;i<node.childNodes.length;i++)
		{
			if(node.childNodes.length > 0)
				SelChildNodes(node.childNodes[i]);
				
			node.childNodes[i].check(true);
		}
	} 
	
	//取消选择子
	function UnSelChildNodes(node)
	{
		var i = 0;
		for(i=0;i<node.childNodes.length;i++)
		{
			if(node.childNodes.length > 0)
				UnSelChildNodes(node.childNodes[i]);
				
			node.childNodes[i].check(false);
		}
	} 
	
	//选择父,也需要递归
	function SelParentNode(node)
	{
		var pNode = node.parentNode;
		var ok = true;
		for(i=0;i<pNode.childNodes.length;i++)
		{	
			if(pNode.childNodes[i].isChecked() == false)
			{
				//只要有一个没有选中,则返回
				ok = false;
				break;			
			}	
		}
		if(ok == true)
		{
			pNode.check(true);
			SelParentNode(pNode);
		}
	}
	//取消选择父,这里有点特殊,取消选择的时候,需要递归取消所有父
	function UnSelParentNode(node)
	{
		var pNode = node.parentNode;
		pNode.check(false);
		UnSelParentNode(pNode);
	}
	/*--------------------------------------------------------------
		功能：取得选中的选择部门或者用户的ID，用逗号隔开 by yesun
	---------------------------------------------------------------*/
	function SelCatalogAndUser()
	{
		var aobj = atree.getSelectedChildNodes();
		var strId = "";
		var strName = "";		
		for (var i = 0; i < aobj.length; i++)
		{
			strId += aobj[i].value+",";
			strName += aobj[i].text+",";			
		}
		if(strId.length > 0)
		{
			strId = strId.substring(0,strId.length-1);
			strName = strName.substring(0,strName.length-1);		
		}
		return strId;
	}	
</script>

								</div>
							</td>
						</tr>
					</table>
					<p class="ar"
						style="background-color:#f2f2f2; padding-top:10px;padding-bottom:10px;">
						<input type="button" onclick="javascript:JoinUser()"
							value="<%= MipWebJSPUi.mipweb_user_admin_select_user_17 %>" />
						<input type="button"
							onclick="javascript:GetContactJoinUserList();" value="<%= MipWebJSPUi.mipweb_user_admin_select_user_18 %>" />
					</p>
				</div>


			</div>
		</div>
		</div>

	</body>
</html>
