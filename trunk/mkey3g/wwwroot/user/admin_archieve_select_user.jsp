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
    <title><%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_1 %></title>    
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
    <link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" /> 
    <script type="text/javascript">
    
			var strId = "";
			var strName = "";	
			var currentCatalogId = "<%=request.getParameter("catalogid")%>";
			var type = "<%=request.getParameter("type")%>";

   /*--------------------------------------------------------------
	功能：加入用户
--------------------------------------------------------------*/
function JoinUser()
{
	//开始读取选中的用户和部门
	SelCatalogAndUser();
	//将选中的用户或者部门ID复制到父窗口的对应下拉列表中
	var obj ;
	if(type == "vto")
	{
		obj = opener.document.getElementById("lbvto");
	}
	else if(type == "cc")
	{
		obj = opener.document.getElementById("lbcc");
	}
	else if(type == "bcc")
	{
		obj = opener.document.getElementById("lbbcc");
	}
	
	if(strId.length > 0 )
	{
		var arrId = strId.split(',');
		var arrName = strName.split(',');
			
		for(var i = 0;i<arrId.length;i++)
		{
			//验证是否已经存在
			
			var isExsit = false;
			for(var j=0;j<obj.length;j++)
			{
				if(obj.options[j].value == arrId[i])
				{
					isExsit = true;
					break;
				}
			}
			if(isExsit == false)
			{
				var option = opener.document.createElement("option");
				option.text = arrName[i];
				option.value = arrId[i];
				document.all?obj.add(option):obj.appendChild(option);
			}				
		}	
	}	
	
	window.opener = null;
	self.close();
}

    
    </script>
      </head>
  
  <body text="silver" topmargin="0" leftmargin="0" bgcolor="#E1E7EC"
		marginwidth="0" marginheight="0" style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; MARGIN: 0pt; BORDER-LEFT: black 0px solid; BORDER-BOTTOM: black 0px solid">
		
		
		<!--用户相关-->
		<div class="tab-pane" id="tabUser" style="margin-top:6px;margin-bottom:6px;">
			<div class="tab-page" id="tabPage6">
				<h2 class="tab"><%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_2 %></h2>				
				
				<p class="ar" style="color:Gray"><%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_3 %></p>
								<table width="98%" cellpadding="0" cellspacing="1" style="margin:5px;">
								<tr bgColor="#f1f1f1"><td width="50%"><b><%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_4 %></b></td></tr>
								<tr>
								<td  valign="top">
								<div id="divUserTree" style="text-align:left;height:380px;width:260px; overflow:auto;overflow-y:yes;">
	<script src="../scripts/jsvm2/jsre.js" classpaht="webfx/xtree1.1.js"></script>
	<script  language="javascript">
	_import("com.eae.webfx.xtree.WebFXLoadTree");
	_import("com.eae.webfx.xtree.WebFXTree");
	_import("com.eae.webfx.xtree.WebFXTreeItem");	
	</script>
	<script type="text/javascript">
	var atree = new WebFXLoadTree("<%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_5 %>","../catalog.do?action=GetCatalogForTextNode&killmyself=true&bizUser=true&catalogid=<%=request.getSession().getAttribute("enterpriseid")%>");
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
								</tr></table>								
								<p class="ar" style="background-color:#f2f2f2; padding-top:10px;padding-bottom:10px;"> <input type="button" onclick="javascript:JoinUser()" value="<%= MipWebJSPUi.mipweb_user_admin_archieve_select_user_6 %>"/></p>
								</div>
								
								
		  </div>
			</div>		
	</div>		

</body>
</html>
