<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="com.dheaven.mip.service.impl.*"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@ page import ="java.util.*"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipUserPrivacy"%>
<%@page import="com.dheaven.mip.util.PermissionHelper"%>
<%@page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals("")||request.getSession().getAttribute("user").equals(MipSysuser.Admin_UID))
{
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>


<html>
<head>
<title><%= MipWebJSPUi.mipweb_user_admin_personal_user_1 %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/tabpane.js"></script>
<script language="javascript" src="../scripts/selall.js"></script>
<script type="text/javascript" src="../scripts/xtree.js"></script>
<script type="text/javascript" src="../scripts/xmlextend.js"></script>
<script type="text/javascript" src="../scripts/xmlextras.js"></script>
<script type="text/javascript" src="../scripts/xloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="../css/xtree.css" />


<script language="javascript" src="../skin/common.js"></script>
	  <link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
	  <link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />


<link type="text/css" rel="stylesheet" href="../css/xtree.css" />
<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
<script language="javascript" type="text/javascript">

	/********************************************************************************************************
		备注：通许录群组管理	 by yesun
	*********************************************************************************************************/ 
	
	
	//公共变量
	var currentGroupId = "";
	var xmlGroupInfo = "<root/>";
	var progressBar;
	//选项卡
	var tabGroup;
	//默认宽高	
	var clientWidth = 800;	
	var treeHeight = 450;
	var listHeigth = 440;
	//屏幕最大化
	parent.window.moveTo(0,0);
	parent.window.resizeTo(screen.availWidth,screen.availHeight);
	
	/*--------------------------------------------------------------
		功能：初始化
	---------------------------------------------------------------*/
	function Init()
	{ 
		//给textarea 增加字数限制
	   
		//首先载入Right 部门列表
		GetGroupList();
		GetGroupUserList("");
		IsUserHasContactExtPermission();

		//计算树的高度，用来自适应	
		treeHeight = (document.body.clientHeight - 120);
		listHeigth = document.body.clientHeight - 210;
		if(document.all){
			$('treeMenuControl').style.cssText="float:left;margin:0px;background-color:#eee;width:9px;height:"+treeHeight+"px;";
			$('treeMenu').style.cssText="background-color:#eee;float:left;width:20%;OVERFLOW:scroll;OVERFLOW-X:scroll;OVERFLOW-Y:scroll;HEIGHT:"+treeHeight+"px;border:1px #999 solid;";
			$('divList').style.cssText = "overflow:auto;overflow-x:hidden;height:"+listHeigth+"px;";
		}
		else
		{
			$('treeMenuControl').setAttribute("style","float:left;margin:0px;background-color:#eee;width:9px;height:"+treeHeight+"px;");
			$('treeMenu').setAttribute("style","background-color:#eee;float:left;width:20%;OVERFLOW:scroll;OVERFLOW-X:scroll;OVERFLOW-Y:scroll;HEIGHT:"+treeHeight+"px;border:1px #999 solid;");
			$('divList').setAttribute("style","overflow:auto;overflow-x:hidden;height:"+listHeigth+"px;");
		}
		
		//下面代码不支持FF
		tabGroup = new WebFXTabPane( document.getElementById( "tabCatalog" ), true );
	}	
	
	
	//屏幕改变大小时，触发
	function OnReSize()
	{
		parent.window.moveTo(0,0);
		parent.window.resizeTo(screen.availWidth,screen.availHeight);
		
		treeHeight = (document.body.clientHeight - 120);
		listHeigth = document.body.clientHeight - 210;
				
		if(document.all)
		{
				document.getElementById("divGroupModify").style.cssText = "overflow-y:auto;overflow-x:hidden;height:"+listHeigth+"px;";
				
				$('treeMenuControl').style.cssText="float:left;margin:0px;background-color:#eee;width:9px;height:"+treeHeight+"px;";
				if($('divList').style.cssText.indexOf("DISPLAY") == -1)
				{
					$('divList').style.cssText = "overflow:auto;overflow-x:hidden;height:"+listHeigth+"px;"		
				}		
				if($('treeMenu').style.cssText.indexOf("DISPLAY") == -1)
				{
					$('treeMenu').style.cssText="background-color:#eee;float:left;width:20%;OVERFLOW:scroll;OVERFLOW-X:scroll;OVERFLOW-Y:scroll;HEIGHT:"+treeHeight+"px;border:1px #999 solid;";
				}		
		}
		else
		{
				document.getElementById("divGroupModify").setAttribute("style","overflow-y:auto;overflow-x:hidden;height:"+listHeigth+"px;");
				
				$('treeMenuControl').setAttribute("style","float:left;margin:0px;background-color:#eee;width:9px;height:"+treeHeight+"px;");
				if($('divList').style.cssText.indexOf("DISPLAY") == -1)
				{
					$('divList').setAttribute("style","overflow:auto;overflow-x:hidden;height:"+listHeigth+"px;");		
				}		
				if($('treeMenu').style.cssText.indexOf("DISPLAY") == -1)
				{
					$('treeMenu').setAttribute("style","background-color:#eee;float:left;width:20%;OVERFLOW:scroll;OVERFLOW-X:scroll;OVERFLOW-Y:scroll;HEIGHT:"+treeHeight+"px;border:1px #999 solid;");
				}
		}		
	}
	
	/*--------------------------------------------------------------
		功能：群组列表
	---------------------------------------------------------------*/
	function GetGroupList()
	{	
		
	
		$('divList').style.display = "";		
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		$('divUser').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divGroupList').style.display = "";
		$('divUserList').style.display = "";
	
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
	   progressBar.isNeedProgressBar = true;
	   progressBar.Top = 10;
	   progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_2 %>");
	
		var url = '../personal.do';
		var pars = 'action=getGroupList';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetGroupList_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：群组列表 - CallBack
	---------------------------------------------------------------*/
	function GetGroupList_CallBack(originalRequest)
	{
	  var objXml = originalRequest.responseXML;
	  DisplayTransformedXML(1, objXml, "../xslt/admin_personal_group_list.xsl",document.getElementById("divGroupList"));
	  progressBar.Close();
	  
	  //树
	 	webFXTreeConfig.rootIcon		= "images/xp/folder.png";
		webFXTreeConfig.openRootIcon	= "images/xp/openfolder.png";
		webFXTreeConfig.folderIcon		= "images/xp/folder.png";
		webFXTreeConfig.openFolderIcon	= "images/xp/openfolder.png";
		webFXTreeConfig.fileIcon		= "images/xp/file.png";
		webFXTreeConfig.lMinusIcon		= "images/xp/Lminus.png";
		webFXTreeConfig.lPlusIcon		= "images/xp/Lplus.png";
		webFXTreeConfig.tMinusIcon		= "images/xp/Tminus.png";
		webFXTreeConfig.tPlusIcon		= "images/xp/Tplus.png";
		webFXTreeConfig.iIcon			= "images/xp/I.png";
		webFXTreeConfig.lIcon			= "images/xp/L.png";
		webFXTreeConfig.tIcon			= "images/xp/T.png";
	
		var tree = new WebFXTree("<%= MipWebJSPUi.mipweb_user_admin_personal_user_3 %>","javascript:GetGroupList();");
		var nodeList = objXml.selectNodes("/root/group");
		for(var i=0;i<nodeList.length;i++)
		{
			var a = new WebFXTreeItem(""+nodeList[i].getAttribute("groupname")+"","javascript:GetGroupUserList('"+nodeList[i].getAttribute("id")+"');");
			tree.add(a);	
		}		
		document.getElementById("tree").innerHTML = tree;		
		//全部展开
		tree.expandAll();				
		clientWidth = document.body.clientWidth;
		
		$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_4 %>";
	}
	
	
	/*--------------------------------------------------------------
		功能：群组用户列表
	---------------------------------------------------------------*/
	function GetGroupUserList(id)
	{	
		
		
		currentGroupId = id;
		$('divList').style.display = "";		
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		$('divUser').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divGroupList').style.display = "";
		$('divUserList').style.display = "";
	

	
		var url = '../personal.do';
		var pars = 'action=getPersonalUserList&groupid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetGroupUserList_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：群组用户列表 - CallBack
	---------------------------------------------------------------*/
	function GetGroupUserList_CallBack(originalRequest)
	{
		if(currentGroupId!=""){
			$('divGroupList').style.display = "none";
		}
	  var objXml = originalRequest.responseXML;
	  DisplayTransformedXML(1, objXml, "../xslt/admin_personal_user_list.xsl",document.getElementById("divUserList"));
 		$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_5 %>";
	}
	
	/*--------------------------------------------------------------
	 	功能：载入新建部门界面
	---------------------------------------------------------------*/
	function LoadGroupCreate()
	{
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
		$('divUser').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divCreate').style.display = "";
		$('divGroupCreate').style.display = "";
		$('divGroupModify').innerHTML = "";		
		
		DisplayTransformedXML(1, "<root/>", "../xslt/admin_personal_group_create.xsl",document.getElementById("divGroupCreate"));	
		$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_6 %>";
	}

	/*--------------------------------------------------------------
		功能：新建群组
	---------------------------------------------------------------*/
	function GroupCreate()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_8 %>");
		if($F('groupname') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "groupname";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_personal_user_7 %>");
			return;
		}
		if($F('groupname').indexOf('$')>-1||$F('groupname').indexOf('%')>-1||$F('groupname').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "groupname";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_9 %>");
				return false;
		}
		var description = $F('description');
		if(description.length > 20){
			if(confirm('<%= MipWebJSPUi.mipweb_user_admin_personal_user_10 %>')){
				description = description.substring(0,20);
			}else{
				progressBar.Close();
				return false;
			}
		}
		if($F('description').indexOf('$')>-1||$F('description').indexOf('%')>-1||$F('description').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "description";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_11 %>");
				return false;
		}
		
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_12 %>");
		var url = '../personal.do';
		var pars = 'action=createGroup&groupname=' + $F('groupname') + '&description=' + description;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GroupCreate_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：新建群组 - CallBack
	---------------------------------------------------------------*/
	function GroupCreate_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_13 %>");
			progressBar.Close();				
			$('divGroupCreate').innerHTML = "";
			//重新加载部门列表
			GetGroupList();
			//重新加载部门树
			GetTreeMenu();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_personal_user_14 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	
	/*--------------------------------------------------------------
		功能：群组详情
	--------------------------------------------------------------*/
	function GroupShow(id)
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_15 %>");		
		currentGroupId = id;	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
		$('divUser').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divGroupModify').style.display = "none";
		$('divGroupShow').style.display = "";
		
		var url = '../personal.do';
		var pars = 'action=GetModel&groupid='+currentGroupId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GroupShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：群组详情 - CallBack
	--------------------------------------------------------------*/
	function GroupShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/admin_group_show.xsl",document.getElementById("divGroupShow"));		
		progressBar.Close();
		$('spanCurrentPosition').innerHTML = " >> "+objXml.getElementsByTagName("item")[0].getAttribute('groupname')+"<%= MipWebJSPUi.mipweb_user_admin_personal_user_16 %>";
		if(document.all)
			tabGroup.setSelectedIndex(0);			
	}

	
	/*--------------------------------------------------------------
		功能：载入修改群组界面
	--------------------------------------------------------------*/
	function LoadGroupModify()
	{
		$('divGroupShow').style.display = "none";
		$('divGroupModify').style.display = "";
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_17 %>");
		var url = '../group.do';
		var pars = 'action=GetModel&groupid='+currentGroupId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadGroupModify_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：载入修改群组界面- CallBack
	--------------------------------------------------------------*/
	function LoadGroupModify_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/admin_group_modify.xsl",document.getElementById("divGroupModify"));		
		//设置修改界面滚动条高度，BT
		if(document.all)
			document.getElementById("divGroupModify").style.cssText = "overflow-y:auto;overflow-x:hidden;height:"+(listHeigth-70)+"px;";
		else
			document.getElementById("divGroupModify").setAttribute("style","overflow-y:auto;overflow-x:hidden;height:"+(listHeigth-70)+"px;");				
		$('divGroupCreate').innerHTML = "";		
	}

	/*--------------------------------------------------------------
		功能：修改部门
	--------------------------------------------------------------*/
	function GroupModify()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_18 %>");
		if($F('groupname') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "groupname";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_19 %>");
			return;
		}
		if($F('groupname').indexOf('$')>-1||$F('groupname').indexOf('%')>-1||$F('groupname').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "groupname";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_20 %>");
				return false;
		}	
		var description = $F('description');
		var description = $F('description');
		if(description.length > 20){
			if(confirm('<%= MipWebJSPUi.mipweb_user_admin_personal_user_21 %>')){
				description = description.substring(0,20);
			}else{
				progressBar.Close();
				return false;
			}
		}
		if($F('description').indexOf('$')>-1||$F('description').indexOf('%')>-1||$F('description').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "description";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_22 %>");
				return false;
		}
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_23 %>");
		var url = '../group.do';
		var pars = 'action=Update&groupname=' + $F('groupname') + '&description=' + description +'&groupid='+currentGroupId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GroupModify_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改部门 - CallBack
	--------------------------------------------------------------*/
	function GroupModify_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_24 %>");		
				progressBar.Close();
				GetGroupList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_25 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_26 %>"+errorMessage);
		}
	}

	
	/*--------------------------------------------------------------
		功能：删除群组信息
	--------------------------------------------------------------*/
	function GroupDelete()
	{
		if(confirm("<%= MipWebJSPUi.mipweb_user_admin_personal_user_27 %>"))
		{	
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_28 %>");
			var url = '../personal.do';
			var pars = 'action=Delete&groupid='+currentGroupId;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: GroupDelete_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除群组信息 - CallBack
	--------------------------------------------------------------*/
	function GroupDelete_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;			
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{		
				progressBar.Close();
				//重新加载列表
				GetGroupList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_29 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_30 %>"+errorMessage);
		}
	}
		
		
		/*--------------------------------------------------------------
		功能：用户详情
	--------------------------------------------------------------*/
	function UserShow(id)
	{	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divUser').style.display = "";	
		$('divUserShow').style.display = "";
	
		progressBar=new ProgressBar();	
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_31 %>");
		var url = '../masuser.do';
		var pars = 'action=UserShow&userid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：用户详情 - CallBack
	--------------------------------------------------------------*/
	function UserShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/admin_group_user_show.xsl",document.getElementById("divUserShow"));
		progressBar.Close();
	}
		
		
	/*-------------------------------------------------------------
	 功能：Open TreeMenu
	--------------------------------------------------------------*/
	function ControlTreeMenu()
	{		
		OpenTreeMenu();
	}
	
	function OpenTreeMenu()
	{
		//更改图片
		if(document.getElementById('imgTreeMenuControl').src.indexOf("left") > 0)
		{
			document.getElementById('imgTreeMenuControl').src = "../images/right_arrow.gif";
		}
		else
		{
			document.getElementById('imgTreeMenuControl').src = "../images/left_arrow.gif";
		}
		
		var style = "";
		style = document.all?document.getElementById('treeMenu').style.cssText:document.getElementById('treeMenu').getAttribute('style');
		
		if(style.toLowerCase().indexOf("width: 20%") > 0)
		{
			//alert("隐藏树")
			if(document.all){	
				document.getElementById('treeMenu').style.cssText = "display:none";
				document.getElementById('divContent').style.cssText = "width:98%;float:left;";
			}
			else
			{
				document.getElementById('treeMenu').setAttribute("style","display:none");
				document.getElementById('divContent').setAttribute("style","width:98%;float:left;");
			}
		}
		else
		{
			//alert("显示树")
			if(document.all){	
				document.getElementById('treeMenu').style.cssText = "width:20%;float:left;OVERFLOW:auto;HEIGHT:"+treeHeight+"px;border:1px #999 solid;";
				document.getElementById('divContent').style.cssText = "width:78%;float:left;";	
			}
			else
			{
				document.getElementById('treeMenu').setAttribute("style","width:20%;float:left;OVERFLOW:auto;HEIGHT:"+treeHeight+"px;border:1px #999 solid;");
				document.getElementById('divContent').setAttribute("style","width:78%;float:left;");
			}
		}
	}

	/*--------------------------------------------------------------
		功能：用户Search
	--------------------------------------------------------------*/
	function Search()
	{
		$('divList').style.display = "";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		$('divGroupList').style.display = "none";
		$('divUserList').style.display = "none";
		$('divUserCreate').style.display = "none";	
		$('divUser').style.display = "none";	

		progressBar = new ProgressBar();		
		//判断		
		if($F('keyword') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "keyword";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_32 %>");
			return;
		}
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_33 %>");
		var url = '../group.do';
		var pars = 'action=Search&keyword='+$F('keyword');
			var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: Search_CallBack}
		);
	}
	/*-------------------------------------------------------------
		功能：用户列表 - CallBack
	--------------------------------------------------------------*/
	function Search_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/admin_group_list.xsl",document.getElementById("divGroupList"));
		progressBar.Close();
		$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_86 %>";		
	}


	/*--------------------------------------------------------------
		功能：退出
	--------------------------------------------------------------*/
	function UnJoinUser(id)
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_34 %>");
		var url = '../group.do';
		var pars = 'action=UnJoinUser&groupid='+currentGroupId+'&userid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UnJoinUser_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：退出- CallBack
	--------------------------------------------------------------*/
	function UnJoinUser_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_35 %>");
	
				GetGroupUserList(currentGroupId);
				
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_personal_user_36 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_personal_user_37 %>"+errorMessage);
		}
		progressBar.Close();
	}
	
	function UnJoinMutiUser()
	{
		if (!sel()){
		return false;
		}
		if(confirm("<%= MipWebJSPUi.mipweb_user_admin_personal_user_38 %>"+m_idCount+"<%= MipWebJSPUi.mipweb_user_admin_personal_user_39 %>"))
		{
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_personal_user_40 %>");
			var url = '../personal.do';
		var pars = 'action=delUser&userid='+m_ids;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: UnJoinMutiUser_CallBack}
			);
		}
	}
	function UnJoinMutiUser_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_41 %>");
				progressBar.Close();
				GetGroupUserList(currentGroupId);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_42 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_43 %>"+errorMessage);
		}
	}
	
	
	function LoadJoinUser()
	{
		window.open('admin_personal_select_user.jsp?groupid='+currentGroupId,'','height=520,width=400,top=100,left=200,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	
	

	//判断 用户是否具有自定义通讯录的访问权限， 两种，一、单位通讯录管理运，二、进入自定义通讯录白名单的用户 ， 再次恨透滥用ajax行为！！！
	function IsUserHasContactExtPermission()
	{
			var url = '../masuser.do';
			var pars = 'action=IsUserHasContactExtPermission';
				var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: IsUserHasContactExtPermission_CallBack}
			);
	}

	function IsUserHasContactExtPermission_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseText);
			if(objXml.getElementsByTagName("root")[0].getAttribute("hasContactExtPermission") == "true" ||objXml.getElementsByTagName("root")[0].getAttribute("hasGroupPermission") == "true"  )
			{				
				//既然用户拥有权限，那么就开始设置快速跳转的下拉列表
				var sel = document.createElement("select");
				sel.id = "selFastRedirect";
				
				if(document.all)			
					sel.attachEvent("onchange",function(){location.href=$F('selFastRedirect')});
				else
					sel.setAttribute("onchange","javascript:location.href=this.value");
				var option;
				if(objXml.getElementsByTagName("root")[0].getAttribute("hasContactExtPermission") == "true")
				{
					option = document.createElement("option");
					option.text = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_44 %>";
					option.value = "admin_user.jsp";				
					document.all?sel.options.add(option):sel.appendChild(option);				
					document.getElementById("lblNav").style.display="";	
				}
				/* 暂时屏蔽自定义通讯录
				if(objXml.getElementsByTagName("root")[0].getAttribute("hasContactExtPermission") == "true")
				{
					option = document.createElement("option");
					option.text = "自定义通讯录";
					option.value = "admin_contact.jsp";
					document.all?sel.options.add(option):sel.appendChild(option);
					document.getElementById("lblNav").style.display="";	
				}*/
				if(objXml.getElementsByTagName("root")[0].getAttribute("hasGroupPermission") == "true")
				{
					option = document.createElement("option");
					option.text = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_45 %>";
					option.setAttribute("selected","selected");
					option.value = "admin_group.jsp";
					document.all?sel.options.add(option):sel.appendChild(option);
					document.getElementById("lblNav").style.display="";	
				}
				
				
				document.all?$('divFastRedirect').appendChild(sel):$('divFastRedirect').appendChild(sel);	
				var personaloption = document.createElement("OPTION");
				personaloption.text = "<%= MipWebJSPUi.mipweb_user_admin_personal_user_46 %>";
				personaloption.value = "admin_personal_user.jsp";
				document.all?sel.options.add(personaloption):sel.appendChild(personaloption);	
				sel.selectedIndex = 2;//设置默认选中		
			}
		}
		catch(err)
		{
			alert(err.message);
		}
	}
	function loadUserCreate(){
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		$('divGroupList').style.display = "none";
		$('divUserList').style.display = "none";
		$('divUser').style.display = "none";	
		$('divUserCreate').style.display = "";	
	}
	function returnTable(){
		if(currentGroupId!=""){
			$('divGroupList').style.display = "none";
			$('divUserList').style.display = "";
		}else{
			$('divGroupList').style.display = "";
			$('divUserList').style.display = "";
		}
		$('divList').style.display = "";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		
		$('divUser').style.display = "none";	
		$('divUserCreate').style.display = "none";
	}
	function UserCreate(){
		if($('truename').value==""){
			alert("<%= MipWebJSPUi.mipweb_user_admin_personal_user_47 %>");
		}
		var url = '../personal.do';
		var pars = 'action=userCreate&groupid='+currentGroupId+'&truename='+$('truename').value+"&mobile="+$('mobile').value+"&email="+$('email').value+"&companytel="+$('companytel').value+"&hometel="+$('hometel').value+"&city="+$('city').value+"&comment="+$('comment').value;
			var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserCreate_CALLBACK}
		);
	}
	function UserCreate_CALLBACK(originalRequest){
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_48 %>");
				progressBar.Close();
				if(currentGroupId!=""){
					GetGroupUserList(currentGroupId);
				}else{
					GetGroupUserList("");
					GetGroupList();
				}
				
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_49 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_personal_user_50 %>"+errorMessage);
		}
	}
	function showUser(id){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_personal_user_51 %>", "../user/personal_user.jsp?id="+id,550,640);
	}
	function importall(){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_personal_user_52 %>","../user/import_personal_user.jsp",550,640);
	}
	function exportall(){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_personal_user_53 %>","../user/export_personal_user.jsp",550,640);
	}
</script>
</head>
<body style="overflow:hidden;" onresize="javascript:OnReSize();" onload="javascript:Init();" class="body_center">

<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true"/>

<div id="mainbox" style="width:100%;">
<div class="center_nav">
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0><TBODY><TR>
				<TD>&nbsp;·&nbsp;<%= MipWebJSPUi.mipweb_user_admin_personal_user_54 %><a href="main.jsp" class="href_12px_gray"><%= MipWebJSPUi.mipweb_user_admin_personal_user_55 %></a>&nbsp;>>&nbsp; <a href="admin_personal_user.jsp" class="href_12px_gray"><%= MipWebJSPUi.mipweb_user_admin_personal_user_56 %></a> <span id="spanCurrentPosition"></span></TD><td width="30%">
				<label id="lblNav" style="display:none;"><table width="300"><tr><td align=right><span><%= MipWebJSPUi.mipweb_user_admin_personal_user_57 %></span></td><td><div id="divFastRedirect"></div></td></tr></table></label>
				</td></TR></TBODY></TABLE>
</div>
			
<div id="treeMenu" style="background-color:#eee;float:left;width:20%;OVERFLOW:scroll;OVERFLOW-X:scroll;OVERFLOW-Y:scroll;HEIGHT:440px;border:1px #999 solid;">
<table width="100%" height="100%" cellpadding="0">
<tr>
<td bgColor="#f8f8f8" valign="top">
<div id="tree" style=""></div>
</td>
</tr></table>
</div>


<div id="treeMenuControl" style="float:left;margin:0px;background-color:#eee;width:9px;height:450;">
<table border=0 height="100%" cellspacing="0" cellpadding="0">
	<tr>
	 <td valign="middle">
<img id="imgTreeMenuControl" style="cursor:pointer;" title="<%= MipWebJSPUi.mipweb_user_admin_personal_user_58 %>" src="../images/left_arrow.gif" border="0" onclick="javascript:ControlTreeMenu();"/>
</td></tr></table>
</div>



<div id="divContent" style="float:left;width:78%;">
<!-- 用户查询 -->
<div style="border:1px #999 solid;">

</div>

<form id=formlist name=formlist>
<div id="divList" style="overflow:auto;overflow-x:hidden;height:420px;">

<table style="background-color:#eee;width:100%;" cellpacing="0" cellpadding="0"><tr><td align=right width="90%"><div id="nav1" style="padding:5px;text-align:right;height:30px;"><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_59 %>" onClick="javascript:selall(1)"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_61 %>" onClick="javascript:selall(0)"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_63 %>" onClick="javascript:selall(2)"/><input type="button" id="btnDelMany" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_65 %>" onclick='javascript:UnJoinMutiUser()'/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_66 %>" onclick="loadUserCreate()"></input><input type="button" id="btnJoinUser" onclick="javascript:LoadJoinUser();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_67 %>"  /><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_68 %>" onclick="importall()"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_69 %>" onclick="exportall()"></div></td><td><input type="button" id="btnCreateGroup" onclick="javascript:LoadGroupCreate();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_70 %>" /><input type="button" id="btnOK" name="btnOK" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_71 %> " onclick="GetGroupList();GetGroupUserList('');"> </td></tr></table>

<div id="divGroupList"></div>
<div id="divUserList"></div>
<table style="background-color:#eee;width:100%;" cellpacing="0" cellpadding="0"><tr><td align=right width="90%"><div id="nav1" style="padding:5px;text-align:right;height:30px;"><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_60 %>" onClick="javascript:selall(1)"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_62 %>" onClick="javascript:selall(0)"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_64 %>" onClick="javascript:selall(2)"/><input type="button" id="btnDelMany" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_65 %>" onclick='javascript:UnJoinMutiUser()'/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_66 %>" onclick="loadUserCreate()"></input><input type="button" id="btnJoinUser" onclick="javascript:LoadJoinUser();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_67 %>"  /><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_68 %>" onclick="importall()"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_69 %>" onclick="exportall()"></div></td><td><input type="button" id="btnCreateGroup" onclick="javascript:LoadGroupCreate();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_70 %>" /><input type="button" id="btnOK" name="btnOK" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_71 %> " onclick="GetGroupList();GetGroupUserList('');"> </td></tr></table>


</div>
</form>
<div id="divUserCreate">
	<table width="100%" align="center" bgcolor="" border="0" cellpadding="0" cellspacing="1">
	<tr><td align="right" width="30%"><%= MipWebJSPUi.mipweb_user_admin_personal_user_72 %></td><td><input type="text" id="truename" size="20"/><span class="star"> *</span></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_73 %></td><td><input type="text" id="mobile"/></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_74 %></td><td><input type="text" id="email"/></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_75 %></td><td><input type="text" id="companytel"/><span class="star"> </span></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_76 %></td><td><input type="text" id="hometel"/><span class="star"> </span></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_77 %></td><td><input type="text" id="city"/><span class="star"> </span></td></tr>
	<tr><td align="right"><%= MipWebJSPUi.mipweb_user_admin_personal_user_78 %></td><td><textarea id="comment"></textarea><span class="star"> </span></td></tr>
	<tr><td align="right" colspan="4"><input type="button" id="btnOK" name="btnOK" onclick="javascript:UserCreate();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_79 %>"/> <input type="button" id="btnOK" name="btnOK" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_80 %>" onclick="returnTable()"></td></tr>
	<tr><td align="right"></td><td></td></tr>
</table>
	

</div>
<div id="divCreate" style="display:none;">
<div id="divGroupCreate" style="overflow-y:auto;overflow-x:hidden;height:440px;display:none;"></div>
</div>

<div id="divInfo" style="display:none;">	
	<!--部门相关-->
	<div class="tab-pane" id="tabGroup" style="margin:6px;">
		<div class="tab-page" id="tabPage1">
			<h2 class="tab"><%= MipWebJSPUi.mipweb_user_admin_personal_user_81 %></h2>
			<div id="divGroupShow" style=""></div> 
			<div id="divGroupModify" style="display:none;overflow-y:auto;overflow-x:hidden;height:370px;"></div>
		</div>	

		<div class="tab-page" id="tabPage2">
			<h2 class="tab"><%= MipWebJSPUi.mipweb_user_admin_personal_user_82 %></h2>
			<div class="attention"><img alt="" src="../images/ico_info.gif"/> <%= MipWebJSPUi.mipweb_user_admin_personal_user_83 %></div>
			<p align="right" style="padding:20px;"><input type="button" onclick="javascript:GroupDelete();" value="<%= MipWebJSPUi.mipweb_user_admin_personal_user_84 %>" /></p>
		</div>

	</div>
</div>
<div id="divCreate_user" style="display:none;">
<div id="divGroupCreate" style="overflow-y:auto;overflow-x:hidden;height:440px;display:none;"></div>
</div>

<div id="divUser" style="display:none;">
		<!--用户相关-->
		<div class="tab-pane" id="tabUser" style="margin:6px;">
			<div class="tab-page" id="tabPageUser1">			
				<h2 class="tab"><%= MipWebJSPUi.mipweb_user_admin_personal_user_85 %></h2>
				<div id="divUserShow" style=""></div> 				
			</div>
	</div>
</body>
</html>
