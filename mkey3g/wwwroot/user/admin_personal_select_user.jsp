
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {
		out
				.print("<script>window.opener.parent.location.href='../default.jsp';window.close();window.opener==null;</script>");
		return;
	}
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><%= MipWebMoreUi.mip_user_admin_personal_select_user_1 %></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="../css/user.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>


		<script type="text/javascript">
    
			var strId = "";
			var strName = "";
			var progressBar;
			var groupid = "<%=request.getParameter("groupid")%>";

   /*--------------------------------------------------------------
	功能：加入用户
--------------------------------------------------------------*/
function JoinUser()
{
	//开始读取选中的用户和部门
	SelCatalogAndUser();
	
	if(strId.length > 0 )
	{		
		 Progress('<%= MipWebMoreUi.mip_user_admin_personal_select_user_2 %>','<%= MipWebMoreUi.mip_user_admin_personal_select_user_3 %>');
		 User2.fromContact(strId,groupid,
		{
			callback:function(otext) {
				if(otext=='1'){
					parent.parent.ChangePage(parent.parent.pageid);
					parent.parent.GB_CURRENT.hide();
				}
			},
			errorHandler:functiDHalert(ception) {
				CloseProgress();
			    DHalert("<%= MipWebMoreUi.mip_user_admin_personal_select_user_4 %>"+errorString);
			}
		});		
	}		
}


    
    </script>
	</head>

	<body text="silver" topmargin="0" leftmargin="0" bgcolor="#E1E7EC"
		marginwidth="0" marginheight="0"
		style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid">


		<!--用户相关-->
		<div class="tab-pane" id="tabUser"
			style="margin-top: 6px; margin-bottom: 6px;">
			<div class="tab-page" id="tabPage6">
				<h2 class="tab">
					<%= MipWebMoreUi.mip_user_admin_personal_select_user_5 %>
				</h2>

				<table width="98%" cellpadding="0" cellspacing="1"
					style="margin: 5px;">
					<tr bgColor="#f1f1f1">
						<td width="50%">
							<b><%= MipWebMoreUi.mip_user_admin_personal_select_user_6 %></b>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div id="divUserTree"
								style="text-align: left; height: 380px; width: 390px; overflow: auto; overflow-y: yes;">
								<script src="../scripts/jsvm2/jsre.js"
									classpaht="webfx/xtree1.1.js"></script>
								<script language="javascript">
	_import("com.eae.webfx.xtree.WebFXLoadTree");
	_import("com.eae.webfx.xtree.WebFXTree");
	_import("com.eae.webfx.xtree.WebFXTreeItem");	
	</script>
								<script type="text/javascript">
	var atree = new WebFXLoadTree("<%= MipWebMoreUi.mip_user_admin_personal_select_user_7 %>","../catalog.do?action=GetCatalogForTextNode&killmyself=false&catalogid=<%=request.getSession().getAttribute("enterpriseid")%>&type=group&rnd="+Math.random());
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
		
		if(pNode==null||pNode==""){
			return;
		}
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
		//add by mahm:这样写页面就不会有JS错误
				try{
					pNode.check(true);
					}catch(e){
					
					}
			SelParentNode(pNode);
		}
	}
	//取消选择父,这里有点特殊,取消选择的时候,需要递归取消所有父
	function UnSelParentNode(node)
	{
		if(node.parentNode !=  null){
				var pNode = node.parentNode;
				try{
					pNode.check(false);
					}catch(e){
					
					}
				//pNode.check(false);
				UnSelParentNode(pNode);
		}
	}
	
	
	/*--------------------------------------------------------------
		功能：取得选中的选择部门或者用户的ID，用逗号隔开 by yesun
	---------------------------------------------------------------*/
	function SelCatalogAndUser()
	{
		var aobj = atree.getSelectedChildNodes();			
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
	}	
</script>
						</td>
					</tr>
				</table>
				<p class="ar" style="background-color: #f2f2f2; padding-top: 10px; padding-bottom: 10px;"></p>
				<table>
				<tr><td align="center"><input type="button" class="button_7"
						onclick="javascript:JoinUser()" value="<%= MipWebMoreUi.mip_user_admin_personal_select_user_8 %>" /></td></tr>
				</table>
				
			</div>


		</div>

	</body>
</html>
