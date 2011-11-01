<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>

<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%><html>
<head>
<title><%= MipWebMoreUi.mip_user_admin_contact_1 %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
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

	/********************************************************************
		备注：集团通讯录管理 by yesun
	*********************************************************************/ 
	
	
	//公共变量
	var userid = "";
	var currentUserId = "";
	var catalogid = "";
	var currentCatalogId = "";
	var parentid = "";
	var xmlUserInfo = "<root />";
	var xmlCatalogInfo = "<root />";
	var progressBar;
	var m_ids,m_idCount;
	
	//选项卡
	var tabPane;
	//默认宽高	
	var clientWidth = 800;	
	var treeHeight = 450;
	var listHeigth = 440;
	
	parent.window.moveTo(0,0);
	parent.window.resizeTo(screen.availWidth,screen.availHeight);
	
	
	/*--------------------------------------------------------------
		功能：初始化 载入根部门和用户
	---------------------------------------------------------------*/
	function Init()
	{    	
		//首先载入Right 部门列表
		GetCatalogList("");
		//首先载入Right 用户列表
		//GetUserList("");
		//然后载入Left，部门 树
		TreeMenu();
		
		IsUserHasContactExtPermission();
		
		//计算树的高度，用来自适应	
		treeHeight = (document.body.clientHeight - 20);
		listHeigth = document.body.clientHeight - 45;
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
		catalogTabPane = new WebFXTabPane( document.getElementById( "tabCatalog" ), true );
		userTabPane = new WebFXTabPane( document.getElementById( "tabUser" ), true );
	}
	
	
	/********************************************************************
		备注：以下为和部门有关的操作 by yesun
	*********************************************************************/ 
	
	function OnReSize()
	{		
		parent.window.moveTo(0,0);
		parent.window.resizeTo(screen.availWidth,screen.availHeight);
		
		treeHeight = (document.body.clientHeight - 20);
		listHeigth = document.body.clientHeight - 45;
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
	
	
	/*--------------------------------------------------------------
		功能：部门列表
	---------------------------------------------------------------*/
	function GetCatalogList(id)
	{
	
		if(id == "")
		{
			//禁止返回上级目录
			$('btnPre').disabled = true;
			$('btnPre1').disabled = true;
			
			$('btnNavCreateUser').style.display = "none";
			$('btnNavCreateUser1').style.display = "none";
						
			//如果支持多集团，则允许新建集团
			$('btnNavCreateCatalog').value = "<%= MipWebMoreUi.mip_user_admin_contact_2 %>";
			$('btnNavCreateCatalog1').value = "<%= MipWebMoreUi.mip_user_admin_contact_3 %>";
		}
		else
		{
			$('btnPre').disabled = false;
			$('btnPre1').disabled = false;
			
			$('btnNavCreateUser').style.display = "";
			$('btnNavCreateUser1').style.display = "";
			
			
			//除去 集团，就是部门/子单位了，
			$('btnNavCreateCatalog').style.display = "";
			$('btnNavCreateCatalog1').style.display = "";			
			$('btnNavCreateCatalog').value = "<%= MipWebMoreUi.mip_user_admin_contact_4 %>";
			$('btnNavCreateCatalog1').value = "<%= MipWebMoreUi.mip_user_admin_contact_5 %>";			
		}
				
		$('divCatalogList').style.display = "";
		$('divUserList').style.display = "";
		$('catalogLength').style.display = "";
		$('userLength').style.display = "";		
		
		catalogid = id;
		//alert("catalogid="+catalogid);
		xmlCatalogInfo = "<root><cat parentid=\""+catalogid+"\" /></root>";
		xmlUserInfo = "<root><user catalogid=\""+catalogid+"\" /></root>";
	
		$('divList').style.display = "";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
	
	
		progressBar = new ProgressBar();
	    progressBar.isNeedConfirmButton = false;
	    progressBar.isNeedProgressBar = true;
	    progressBar.Top = 10;
	    progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_6 %>");
	
		var url = '../contactcatalog.do';
		var pars = 'action=GetCatalogList&catalogid='+catalogid;
		
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetCatalogList_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：部门列表 - CallBack
	---------------------------------------------------------------*/
	function GetCatalogList_CallBack(originalRequest)
	{
	  var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
	  DisplayTransformedXML(1, objXml, "../xslt/contact_catalog_list.xsl",document.getElementById("divCatalogList"));
		//alert(document.getElementById("divCatalogList").innerHTML);
		//设置parentid
		try
		{//上帝 ^_*
			parentid = objXml.getElementsByTagName("catlist")[0].getAttribute("parentid");
			//alert("parentid="+parentid);
			$('spanCurrentPosition').innerHTML = objXml.getElementsByTagName("catlist")[0].getAttribute("parentcatalogname")!=""?" >> "+objXml.getElementsByTagName("catlist")[0].getAttribute("parentcatalogname"):"";
			$('catalogLength').innerHTML = "<%= MipWebMoreUi.mip_user_admin_contact_7 %>:<font color=Red>"+objXml.selectNodes("/root/catlist/cat").length+"</font>个 ";
			
			
			//权限验证
			if(objXml.getElementsByTagName("catlist")[0].getAttribute("write") == "true"){
				//显示管理按钮
				ShowManage(1);
			}
			else{
				//隐藏管理按钮
				ShowManage(0);
			}
		}
		catch(error)
		{
			//alert(error.message);
		}
	    progressBar.Close();
	}
	
	function ShowManage(isShow){
		if(isShow == 1){
			$('nav1').style.display = "";
			$('nav2').style.display = "";
		}
		else{
			$('nav1').style.display = "none";
			$('nav2').style.display = "none";
		}
	}
	
	/*--------------------------------------------------------------
	 	功能：载入新建部门界面
	---------------------------------------------------------------*/
	function LoadCatalogCreate()
	{
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
	
		$('divCatalogCreate').style.display = "";
		$('divUserCreate').style.display = "none";
		//加载新建部门 Xslt界面
		DisplayTransformedXML(1, xmlCatalogInfo, "../xslt/contact_catalog_create.xsl",document.getElementById("divCatalogCreate"));	
		$('spanCurrentPosition').innerHTML = "<%= MipWebMoreUi.mip_user_admin_contact_8 %>";
	}

	/*--------------------------------------------------------------
		功能：新建部门
	---------------------------------------------------------------*/
	function CatalogCreate()
	{		
		//验证页面控件
		var checkform = new CheckForm();
		if(!checkform.checkForm(document.getElementById('divCatalogCreate'))) return false;
		
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_9 %>");
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogCreate&catalogname=' + $F('catalogname') + '&comment=' +$F('comment')+'&catalogid='+catalogid;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogCreate_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：创建信息 - CallBack
	---------------------------------------------------------------*/
	function CatalogCreate_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_contact_10 %>");
				progressBar.Close();
				$('divCatalogCreate').innerHTML = "";
				
				//重新加载部门列表
				GetCatalogList(catalogid);
				//重新加载部门树
				TreeMenu();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_11 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_12 %>"+errorMessage);
		}
	}
	
	/*--------------------------------------------------------------
	 	功能：部门向上排序
	--------------------------------------------------------------*/
	function CatalogSortUp(id)
	{
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_13 %>");
		
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogSortUp&catalogid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogSort_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：部门向下排序
	---------------------------------------------------------------*/
	function CatalogSortDown(id)
	{
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_14 %>");
		
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogSortDown&catalogid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogSort_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：部门排序 - CallBack
	---------------------------------------------------------------*/
	function CatalogSort_CallBack(originalRequest)
	{
		progressBar.Close();
		//重新加载cataloglist
		//alert("重新加载cataloglist");
		GetCatalogList(catalogid);
	}

	
	/*--------------------------------------------------------------
		功能：部门详情
	--------------------------------------------------------------*/
	function CatalogShow(id)
	{
		currentCatalogId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divCatalog').style.display = "";
		$('divUser').style.display = "none";
		$('divUserExtend').style.display = "none";
		$('divCatalogExtend').style.display = "none";
	
		$('divCatalogShow').style.display = "";
		$('divCatalogModifyInfo').innerHTML = "";
		$('divCatalogModifyInfo').style.display = "none";
	
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_15 %>");
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogShow&catalogid='+currentCatalogId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：部门详情 - CallBack
	--------------------------------------------------------------*/
	function CatalogShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/contact_catalog_show.xsl",document.getElementById("divCatalogShow"));
		//alert(document.getElementById("divCatalogShow").innerHTML);
		//设置tab为第一个
		progressBar.Close();
		GetContactJoinUserList();
		catalogTabPane.setSelectedIndex(0);
	}
	
	
	
	
	/*--------------------------------------------------------------
		功能：部门详情
	--------------------------------------------------------------*/
	function CatalogShowExtend(id)
	{
		currentCatalogId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divCatalog').style.display = "none";
		$('divUser').style.display = "none";
		
		$('divCatalogExtend').style.display = "";
		$('divCatalogShowExtend').style.display = "";

		var url = '../contactcatalog.do';
		var pars = 'action=CatalogShow&catalogid='+currentCatalogId;

		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogShowExtend_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：部门详情 - CallBack
	--------------------------------------------------------------*/
	function CatalogShowExtend_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;		
		try
		{	
			catalogid = objXml.getElementsByTagName("cat")[0].getAttribute("parentid");
			DisplayTransformedXML(1, objXml, "../xslt/contact_catalog_show_extend.xsl",document.getElementById("divCatalogShowExtend"));
		}
		catch(err)
		{
		}
	}
	

	
	/*--------------------------------------------------------------
		功能：载入修改部门界面
	--------------------------------------------------------------*/
	function LoadCatalogModifyInfo()
	{
		$('divCatalogShow').style.display = "none";
		$('divCatalogModifyInfo').style.display = "";
		
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_16 %>");
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogShow&catalogid='+currentCatalogId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadCatalogModifyInfo_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：载入修改部门界面 - CallBack
	--------------------------------------------------------------*/
	function LoadCatalogModifyInfo_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/contact_catalog_modify.xsl",document.getElementById("divCatalogModifyInfo"));
		//alert(document.getElementById("divCatalogModifyInfo").innerHTML);
		progressBar.Close();
	}

	/*--------------------------------------------------------------
		功能：修改部门
	--------------------------------------------------------------*/
	function CatalogModifyInfo()
	{
	
		//验证页面控件
		var checkform = new CheckForm();
		if(!checkform.checkForm(document.getElementById('divCatalogModifyInfo'))) return false;
		
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_17 %>");
		var url = '../contactcatalog.do';
		var pars = 'action=CatalogModifyInfo&catalogname=' + $F('catalogname') + '&comment=' +$F('comment')+'&catalogid='+currentCatalogId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: CatalogModifyInfo_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改部门 - CallBack
	--------------------------------------------------------------*/
	function CatalogModifyInfo_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_18 %>");
				progressBar.Close();
				//重新加载部门树
				TreeMenu();	
				
				CatalogShow(currentCatalogId);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_19 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_20 %>"+errorMessage);
		}
	}

	
	/*--------------------------------------------------------------
		功能：删除部门信息
	--------------------------------------------------------------*/
	function CatalogDelete()
	{
		if(confirm("<%= MipWebMoreUi.mip_user_admin_contact_94 %>"))
		{	
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_21 %>");
			var url = '../contactcatalog.do';
			//alert(currentCatalogId);
			var pars = 'action=CatalogDelete&catalogid='+currentCatalogId;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: CatalogDelete_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除部门信息 - CallBack
	--------------------------------------------------------------*/
	function CatalogDelete_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_contact_22 %>");
				progressBar.Close();
				//重新加载部门列表
				GetCatalogList(catalogid);
				//重新加载部门树
				TreeMenu();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_23 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_24 %>"+errorMessage);
		}
	}






	
	/********************************************************************
		备注：以下为和用户有关的操作 by yesun
	*********************************************************************/
		



	
	/*--------------------------------------------------------------
		功能：用户列表
	--------------------------------------------------------------*/
	function GetUserList(catalogid)
	{
		$('divList').style.display = "";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";


		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_25 %>");
		
		var url = '../contactuser.do';
		var pars = 'action=GetUserList&catalogid='+catalogid;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetUserList_CallBack}
		);
	}
	/*-------------------------------------------------------------
		功能：用户列表 - CallBack
	--------------------------------------------------------------*/
	function GetUserList_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/contact_user_list.xsl",document.getElementById("divUserList"));
		progressBar.Close();
		
		$('userLength').innerHTML = "<%= MipWebMoreUi.mip_user_admin_contact_26 %>:<font color=Red>"+objXml.getElementsByTagName("userlist/user").length+"</font><%= MipWebMoreUi.mip_user_admin_contact_29 %> ";
	}

	/*-------------------------------------------------------------
		功能：载入新建用户界面
	--------------------------------------------------------------*/
	function LoadUserCreate()
	{
		//根目录不允许添加用户
		if( catalogid == 0 )
		{
			alert("<%= MipWebMoreUi.mip_user_admin_contact_27 %>");
			return;
		}
		
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
	
		$('divCatalogCreate').style.display = "none";
		$('divUserCreate').style.display = "";
		//加载新建部门 Xslt界面
		DisplayTransformedXML(1, xmlUserInfo, "../xslt/contact_user_create.xsl",document.getElementById("divUserCreate"));	
	
		$('spanCurrentPosition').innerHTML = " <%= MipWebMoreUi.mip_user_admin_contact_28 %>";
	}

	
	/*-------------------------------------------------------------
		功能：新建用户
	--------------------------------------------------------------*/
	function UserCreate()
	{	
	
		//验证页面控件
		progressBar = new ProgressBar();
		
		var checkform = new CheckForm();
		if($F('truename') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "truename";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_30 %>");
			return;
		}
		if(!checkform.IsTel($F('mobile')))
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mobile";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_31 %>");
			return;
		}	
		if($F('email') != "" && !checkform.IsEmail($F('email')))
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_32 %>");
			return;
		}
		
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_33 %>");
		var url = '../contactuser.do';
		var pars = 'action=UserCreate&truename=' + $F('truename') + '&title=' + $F('title') + '&email=' + $F('email') + '&mobile=' + $F('mobile')+ '&hometel=' + $F('hometel') + '&companytel=' + $F('companytel') + ' &city=' + $F('city') + '&comment=' + $F('comment')+'&catalogid='+catalogid;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserCreate_CallBack}
		);
	}
		
	/*-------------------------------------------------------------
		功能：创建用户 - CallBack
	--------------------------------------------------------------*/
	function UserCreate_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_contact_34 %>");
				progressBar.Close();
				$('divUserCreate').innerHTML = "";
				GetUserList(catalogid);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_35 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_36 %>"+errorMessage);
		}
	}


	/*-------------------------------------------------------------
		功能：用户向上排序
	--------------------------------------------------------------*/
	function UserSortUp(id)
	{
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_37 %>");
		
		var url = '../contactuser.do';
		var pars = 'action=UserSortUp&userid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserSort_CallBack}
		);
	}
	
	/*-------------------------------------------------------------
	 功能：用户向下排序
	--------------------------------------------------------------*/
	function UserSortDown(id)
	{
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_38 %>");
		
		var url = '../contactuser.do';
		var pars = 'action=UserSortDown&userid='+id;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserSort_CallBack}
		);
	}
	/*-------------------------------------------------------------
	 功能：用户排序 - CallBack
	--------------------------------------------------------------*/
	function UserSort_CallBack(originalRequest)
	{
		progressBar.Close();
		//重新加载userlist
		GetUserList(catalogid);
	}



	/*--------------------------------------------------------------
		功能：用户详情
	--------------------------------------------------------------*/
	function UserShow(id)
	{
		currentUserId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divCatalog').style.display = "none";
		$('divCatalogExtend').style.display = "none";
		$('divUser').style.display = "";
		$('divUserExtend').style.display = "none";
	
		$('divUserShow').style.display = "";
		$('divUserModifyInfo').innerHTML = "";
		$('divUserModifyInfo').style.display = "none";
	
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_39 %>");
		var url = '../contactuser.do';
		var pars = 'action=UserShow&userid='+currentUserId;
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
		//alert(originalRequest.responseTEXT);
		//$('divUserShow').style.display = "";
		DisplayTransformedXML(1, objXml, "../xslt/contact_user_show.xsl",document.getElementById("divUserShow"));
		//alert(document.getElementById("divUserShow").innerHTML);
		progressBar.Close();
		//设置tab为第一个
		userTabPane.setSelectedIndex(0);
	}
	
	/*--------------------------------------------------------------
		功能：用户详情
	--------------------------------------------------------------*/
	function UserShowExtend(id)
	{
		currentUserId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divCatalog').style.display = "none";
		$('divUser').style.display = "none";
	
		$('divUserExtend').style.display = "";
		$('divUserShowExtend').style.display = "";
	
		progressBar=new ProgressBar();	
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_40 %>");
		var url = '../contactuser.do';
		var pars = 'action=UserShow&userid='+currentUserId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserShowExtend_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：用户详情 - CallBack
	--------------------------------------------------------------*/
	function UserShowExtend_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/contact_user_show_extend.xsl",document.getElementById("divUserShowExtend"));
		progressBar.Close();
		//设置tab为第一个
		userTabPane.setSelectedIndex(0);		
	}
	

	/*--------------------------------------------------------------
		功能：载入修改用户界面
	--------------------------------------------------------------*/
	function LoadUserModifyInfo()
	{
		$('divUserShow').style.display = "none";
		$('divUserModifyInfo').style.display = "";
		
		progressBar=new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_41 %>");
		var url = '../contactuser.do';
		var pars = 'action=UserShow&userid='+currentUserId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadUserModifyInfo_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：载入修改用户界面 - CallBack
	--------------------------------------------------------------*/
	function LoadUserModifyInfo_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/contact_user_modify.xsl",document.getElementById("divUserModifyInfo"));
		//alert(document.getElementById("divUserModifyInfo").innerHTML);
		progressBar.Close();
	}

	/*--------------------------------------------------------------
		功能：修改用户
	--------------------------------------------------------------*/
	function UserModifyInfo()
	{
	
		//验证页面控件
		progressBar = new ProgressBar();
		
		var checkform = new CheckForm();
		if($F('truename') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "truename";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_42 %>");
			return;
		}
		if(!checkform.IsTel($F('mobile')))
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "mobile";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_43 %>");
			return;
		}	
		if($F('email') != "" && !checkform.IsEmail($F('email')))
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "email";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_44 %>");
			return;
		}
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_45 %>");
		var url = '../contactuser.do';
		var pars = 'action=UserModifyInfo&truename=' + $F('truename') + '&title=' + $F('title') + '&email=' + $F('email') + '&mobile=' + $F('mobile')+ '&hometel=' + $F('hometel') + '&companytel=' + $F('companytel') + ' &city=' + $F('city') + '&comment=' + $F('comment')+'&userid='+currentUserId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: UserModifyInfo_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改用户 - CallBack
	--------------------------------------------------------------*/
	function UserModifyInfo_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_46 %>");
				//refresh GetCatalogList
				//GetUserList(catalogid);
				//修改成功
				
				progressBar.Close();				
			  	//加载用户信息界面
			  	UserShow(currentUserId);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_47 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_contact_48 %>"+errorMessage);
		}
	}


	/*--------------------------------------------------------------
		功能：删除用户信息
	--------------------------------------------------------------*/
	function UserDelete()
	{
		if(confirm("<%= MipWebMoreUi.mip_user_admin_contact_93 %>"))
		{
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_49 %>");
			var url = '../contactuser.do';
			//alert(currentCatalogId);
			var pars = 'action=UserDelete&userid='+currentUserId;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: UserDelete_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除用户信息 - CallBack
	--------------------------------------------------------------*/
	function UserDelete_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_50 %>");
				GetUserList(catalogid);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_51 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_52 %>"+errorMessage);
		}
		progressBar.Close();
	}

	/*--------------------------------------------------------------
		功能：删除用户信息
	--------------------------------------------------------------*/
	function UserDeleteMany()
	{
		if (!sel()){
		return false;
		}
		if(confirm("<%= MipWebMoreUi.mip_user_admin_contact_53 %>"+m_idCount+"<%= MipWebMoreUi.mip_user_admin_contact_54 %>"))
		{
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_55 %>");
			var url = '../contactuser.do';
			var pars = 'action=UserDeleteMany&userid='+m_ids;
			//alert(pars);
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: UserDeleteMany_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除用户信息 - CallBack
	--------------------------------------------------------------*/
	function UserDeleteMany_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_56 %>");
				GetUserList(catalogid);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_contact_57 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_58 %>"+errorMessage);
		}
		progressBar.Close();
	}









	/********************************************************************
			备注：以下为和TreeMenu有关的操作 by yesun
	*********************************************************************/



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
		
		//alert(style);
		if(style.indexOf("width: 20%") > 0)
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
				document.getElementById('treeMenu').style.cssText = "width:20%;float:left;OVERFLOW:auto;HEIGHT:430px;border:1px #999 solid;";
				document.getElementById('divContent').style.cssText = "width:78%;float:left;";	
			}
			else
			{
				document.getElementById('treeMenu').setAttribute("style","width:20%;float:left;OVERFLOW:auto;HEIGHT:430px;border:1px #999 solid;");
				document.getElementById('divContent').setAttribute("style","width:78%;float:left;");
			}
		}
	}


	/*-------------------------------------------------------------
		功能：Tree Menu
	--------------------------------------------------------------*/
	function TreeMenu()
	{
		var url = '../contactcatalog.do';
		var pars = 'action=GetAllCatalogList';//&catalogid='+catalogid;
		var myAjax = new Ajax.Request(url,{method: 'post', parameters: pars, onComplete: TreeMenu_CallBack});
	}
	
	/*-------------------------------------------------------------
		功能：Tree Menu - CallBack
	--------------------------------------------------------------*/
	function TreeMenu_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
		/// XP Look
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
	
		var tree = new WebFXTree("<%= MipWebMoreUi.mip_user_admin_contact_59 %>","javascript:GetCatalogList('');");
		var nodeList = objXml.selectNodes("/root/catlist/cat");
		for(var i=0;i<nodeList.length;i++)
		{
			var a = new WebFXTreeItem(""+nodeList[i].attributes[1].value+"","javascript:GetCatalogList('"+nodeList[i].attributes[0].value+"');GetUserList('"+nodeList[i].attributes[0].value+"')");
			//get child catalog
			GetChildCatalog(a,nodeList[i]);		
			tree.add(a);
		}
		document.getElementById("tree").innerHTML = tree;	
		
		//全部展开
		//tree.expandAll();
		
		clientHeight = document.body.clientWidth;		
	}
	
	
	/*-------------------------------------------------------------
		功能：取得子部门 - 无级分类
	--------------------------------------------------------------*/
	function GetChildCatalog(a,objXml)
	{
		var nodeList = objXml.selectNodes("catlist/cat");
		for(var i=0;i<nodeList.length;i++)
		{
			var b = new WebFXTreeItem(""+nodeList[i].attributes[1].value+"","javascript:GetCatalogList('"+nodeList[i].attributes[0].value+"');GetUserList('"+nodeList[i].attributes[0].value+"')");
			GetChildCatalog(b,nodeList[i]);
			a.add(b);	
		}
		return b;
	}







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
       //alert(originalRequest.responseText);
       DisplayTransformedXML(1, objXml, "../xslt/admin_contact_join_user_list.xsl",document.getElementById("divContactJoinUserList"));
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
	progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_60 %>");
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
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_61 %>");
			progressBar.Close();
			//重新加载列表
			GetContactJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_62 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_63 %>"+err.message);
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
	progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_contact_64 %>");
	var url = '../contactcatalog.do';
	var pars = 'action=UnJoinUser&roleid='+currentCatalogId+'&userid='+id;
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
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_65 %>");
			progressBar.Close();
			//重新加载列表
			GetContactJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_66 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_contact_67 %>"+err.message);
	}
}





function OpenWinAndSelectUser(id)
{
	var win = window.open("admin_select_user.jsp?catalogid="+id,"","height=500,width=600");
	win.focus();
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
					option.text = "<%= MipWebMoreUi.mip_user_admin_contact_68 %>";
					option.value = "admin_user.jsp";				
					document.all?sel.add(option):sel.appendChild(option);				
				}
				/* 暂时屏蔽自定义通讯录
				if(objXml.getElementsByTagName("root")[0].getAttribute("hasContactExtPermission") == "true")
				{
					option = document.createElement("option");
					option.text = "自定义通讯录";
					option.setAttribute("selected","selected");
					option.value = "admin_contact.jsp";
					document.all?sel.add(option):sel.appendChild(option);
				}*/
				if(objXml.getElementsByTagName("root")[0].getAttribute("hasGroupPermission") == "true")
				{
					option = document.createElement("option");
					option.text = "<%= MipWebMoreUi.mip_user_admin_contact_69 %>";
					option.value = "admin_group.jsp";
					document.all?sel.add(option):sel.appendChild(option);
				}
				document.all?$('divFastRedirect').appendChild(sel):$('divFastRedirect').appendChild(sel);			
			}
		}
		catch(err)
		{
			alert(err.message);
		}
	}

</script>
</head>
<body bgcolor="#ffffff" style="padding:0px;margin:0px;" onresize="javascript:OnReSize();" onload="javascript:Init();">

<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true"/>

<form id="formlist" name="formlist">
<div id="mainbox" style="width:100%;">
<div class="nav" style="width:100%;">
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0><TBODY><TR>
				<TD>&nbsp;<IMG alt="" src="../images/icon.gif" align=baseline border=0>&nbsp;<%= MipWebMoreUi.mip_user_admin_contact_70 %><a href="main.jsp" class="href_12px_gray"><%= MipWebMoreUi.mip_user_admin_contact_71 %></a>&nbsp;>>&nbsp; <a href="admin_contact.jsp" class="href_12px_gray"><%= MipWebMoreUi.mip_user_admin_contact_72 %></a> <span id="spanCurrentPosition"></span></TD><td width="30%">
				<label id="lblNav" style="display:none;"><table width="300"><tr><td align=right><span><%= MipWebMoreUi.mip_user_admin_contact_73 %></span></td><td><div id="divFastRedirect"></div></td></tr></table></label>
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
<img id="imgTreeMenuControl" style="cursor:pointer;" title="<%= MipWebMoreUi.mip_user_admin_contact_74 %>" src="../images/left_arrow.gif" border="0" onclick="javascript:ControlTreeMenu();"/>
</td></tr></table>
</div>



<div id="divContent" style="float:left;width:78%;">

<div id="divList" style="overflow:auto;overflow-x:hidden;height:420px;">
<table style="background-color:#eee;width:100%;" cellpacing="0" cellpadding="0"><tr><td align=right width="90%"><div id="nav1" style="display:none;padding:5px;text-align:right;height:30px;"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_75 %>" onClick="javascript:selall(1)"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_76 %>" onClick="javascript:selall(0)"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_77 %>" onClick="javascript:selall(2)"><input type=button value="<%= MipWebMoreUi.mip_user_admin_contact_78 %>" onclick='javascript:UserDeleteMany()'><input type="button" id="btnNavCreateCatalog" onclick="javascript:LoadCatalogCreate();" value="<%= MipWebMoreUi.mip_user_admin_contact_79 %>" /> <input type="button" id="btnNavCreateUser" onclick="javascript:LoadUserCreate();" value="<%= MipWebMoreUi.mip_user_admin_contact_80 %>"  /></div></td><td style="padding-bottom:5px;"><input type="button" id="btnPre" onclick="javascript:GetCatalogList(parentid);GetUserList(parentid);" value="<%= MipWebMoreUi.mip_user_admin_contact_81 %>" /></td></tr></table>
<div style="width:100%;text-align:right;padding-right:10px;font-weight:bolder;" ><span id="catalogLength"></span><span id="userLength"></span></div>
<div id="divCatalogList"></div>
<div id="divUserList"></div>
<table style="background-color:#eee;width:100%;" cellpacing="0" cellpadding="0"><tr><td align=right width="90%"><div id="nav2" style="display:none;padding:5px;text-align:right;background-color:#eee;height:30px;"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_75 %>" onClick="javascript:selall(1)"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_76 %>" onClick="javascript:selall(0)"><input type="button" value="<%= MipWebMoreUi.mip_user_admin_contact_77 %>" onClick="javascript:selall(2)"><input type=button value="<%= MipWebMoreUi.mip_user_admin_contact_78 %>" onclick='javascript:UserDeleteMany()'><input type="button" id="btnNavCreateCatalog1" onclick="javascript:LoadCatalogCreate();" value="<%= MipWebMoreUi.mip_user_admin_contact_79 %>" /> <input type="button" id="btnNavCreateUser1" onclick="javascript:LoadUserCreate();" value="<%= MipWebMoreUi.mip_user_admin_contact_80 %>"  /></div></td><td style="padding-bottom:5px;"><input type="button" id="btnPre1" onclick="javascript:GetCatalogList(parentid);GetUserList(parentid);" value="<%= MipWebMoreUi.mip_user_admin_contact_81 %>" /></td></tr></table>
</div>


<div id="divCreate" style="display:none;">
<div id="divCatalogCreate" style="display:none;"></div>
<div id="divUserCreate" style="display:none;"></div>
</div>

<div id="divInfo" style="display:none;">
	
	<div id="divCatalog" style="display:none;">
		<!--部门相关-->
		<div class="tab-pane" id="tabCatalog" style="margin:6px;">
			<div class="tab-page" id="tabPage1">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_82 %></h2>
				<div id="divCatalogShow"></div> 
				<div id="divCatalogModifyInfo" style="display:none;"></div>
			</div>
			<div class="tab-page" id="tabPage2">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_83 %></h2>
				<div class="attention"><img alt="" src="../images/ico_info.gif"/> <%= MipWebMoreUi.mip_user_admin_contact_84 %></div>
				<p align="right" style="padding:20px;"><button onclick="javascript:CatalogDelete();"><img src="../images/delete.gif" height="15" width="15"> <%= MipWebMoreUi.mip_user_admin_contact_85 %> </button></p>
			</div>
		</div>
	</div>
	
	<!-- 普通用户浏览 -->
	<div id="divCatalogExtend" style="display:none;">
	<!--部门相关-->
		<div class="tab-pane" id="tabCatalogExtend" style="margin:6px;">
			<div class="tab-page" id="tabPage3">			
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_86 %></h2>
				<div id="divCatalogShowExtend" style="overflow-y:auto;overflow-x:hidden;height:370px;"></div>
			</div>
		</div>		
	</div>
	
	<!-- 普通用户浏览 -->
	<div id="divUserExtend" style="display:none;">
	<!--部门相关-->
		<div class="tab-pane" id="tabUserExtend" style="margin:6px;">
			<div class="tab-page" id="tabPage3">			
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_88 %></h2>
				<div id="divUserShowExtend" style=""></div>
			</div>
		</div>		
	</div>
	
	<div id="divUser" style="display:none;">
		<!--用户相关-->
		<div class="tab-pane" id="tabUser" style="margin:6px;">
			<div class="tab-page" id="tabPage3">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_88 %></h2>
				<div id="divUserShow"><%= MipWebMoreUi.mip_user_admin_contact_89 %></div> 
				<div id="divUserModifyInfo" style="display:none;"></div> 				
			</div>				
			<div class="tab-page" id="tabPage5">
				<h2 class="tab"><%= MipWebMoreUi.mip_user_admin_contact_90 %></h2>
				<div class="attention"><img alt="" src="../images/ico_info.gif"/> <%= MipWebMoreUi.mip_user_admin_contact_91 %></div>
				<p align="right" style="padding:20px;"><input type="button" onclick="javascript:UserDelete();" value="<%= MipWebMoreUi.mip_user_admin_contact_92 %>" /></p>
			</div>
		</div>
	</div>
</div>

</div>
</div>
</form>
</body>
</html>
