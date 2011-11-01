<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html>
	<head>
		<title><%= MipWebJSPUi.mipweb_user_admin_role_1 %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<script language="javascript" src="../skin/common.js"></script>
	    <link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
   //公共变量
   var progressBar;
   var currentId = "";
	   //选项卡
	var tabPane;
	   
	   //初始化
	   window.onload = function()
	   {
	       GetRoleList();
	       tabPane = new WebFXTabPane( document.getElementById( "tabRole" ), true );
	   }    
	   
	   /*--------------------------------------------------------------
	       功能：取得角色列表
	   --------------------------------------------------------------*/
	   function GetRoleList()
	   {
	       
	       $('divList').style.display = "";
					$('divCreate').style.display = "none";
					$('divInfo').style.display = "none";
		
	       //开始提交数据
	       progressBar = new ProgressBar();
	       progressBar.isNeedProgressBar = true;
	       progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_2 %>");
	       var url = "../role.do";
	       var pars = "action=GetRoleList";
	       //alert(pars);
	       var myAjax = new Ajax.Request(
	       url,
	       {method: 'post', parameters: pars, onComplete: GetRoleList_CallBack}
	       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得角色列表 - CallBack
	   --------------------------------------------------------------*/
	   function GetRoleList_CallBack(originalRequest)
	   {
	       var objXml = originalRequest.responseXML;
	       //alert(originalRequest.responseText);
	       DisplayTransformedXML(1, objXml, "../xslt/admin_role_list.xsl",document.getElementById("divRoleList"));
	       progressBar.Close();        
		$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_role_3 %>";
	   } 
	   
	   
	   
	   /*--------------------------------------------------------------
	       功能：按用户名或者功能搜索角色
	   --------------------------------------------------------------*/
   function Search()
	   {	       
	        //开始提交数据
			 progressBar = new ProgressBar();	   				 	
			 if($F('keyword').replace(/\s+/g, "") == ""){
			 progressBar.isNeedConfirmButton = true;
		     progressBar.focusItem = "keyword";
		     progressBar.SetStatus("<img src='../images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_4 %>");
		     return false;
			 }
			$('divList').style.display = "";
			$('divCreate').style.display = "none";
			$('divInfo').style.display = "none";							  			  			 
			   progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_5 %>");
			   var url = "../role.do";
			   var pars = "action=SearchRole&type=1&keyword="+$F('keyword');
			   var myAjax = new Ajax.Request(
			   url,
			   {method: 'post', parameters: pars, onComplete: GetRoleList_CallBack}
			   );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：按用户名或者功能搜索角色 - CallBack
	   --------------------------------------------------------------*/
	 function Search_CallBack(originalRequest)
	   {
	       var objXml = originalRequest.responseXML;
	       //alert(originalRequest.responseText);
	       DisplayTransformedXML(1, objXml, "../xslt/admin_role_list.xsl",document.getElementById("divRoleList"));
	       progressBar.Close();        
						$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_role_6 %>";
	   } 
	   
	   /*--------------------------------------------------------------
	 	功能：载入新建角色界面
	---------------------------------------------------------------*/
	function LoadRoleCreate()
	{
		
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
	
		$('divRoleCreate').style.display = "";
				
		//开始提交数据
	       progressBar = new ProgressBar();
	       progressBar.isNeedProgressBar = true;
	       progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_7 %>");
	       var url = "../role.do";
	       var pars = "action=LoadRoleCreate";
	       //alert(pars);
	       var myAjax = new Ajax.Request(
	       url,
	       {method: 'post', parameters: pars, onComplete: LoadRoleCreate_CallBack}
	       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：载入新建角色界面 - CallBack
	   --------------------------------------------------------------*/
	 function LoadRoleCreate_CallBack(originalRequest)
	   {
			   var objXml = originalRequest.responseXML;
					DisplayTransformedXML(1, objXml, "../xslt/admin_role_create.xsl",document.getElementById("divRoleCreate"));
			   progressBar.Close();
					$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_role_8 %>";
	   }
	
	   /*--------------------------------------------------------------
		功能：新建角色
	---------------------------------------------------------------*/
	function RoleCreate()
	{
	    progressBar = new ProgressBar();
		progressBar.SetStatus("正在校验数据....");
	 //add by mahm 校验为空或空格的情况
		if($F('rolename').replace(/\s+/g, "") == "")
	       {
	           progressBar.isNeedConfirmButton = true;
	           progressBar.focusItem = "rolename";
	           progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_9 %>");
	           return;
	       }
     	if($F('rolename').indexOf('$')>-1||$F('rolename').indexOf('%')>-1||$F('rolename').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "rolename";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_10 %>");
				return false;
		} 
		var comment = $F('comment');
		if(comment.length > 40){
			if(confirm('<%= MipWebJSPUi.mipweb_user_admin_role_11 %>')){
				comment = comment.substring(0,40);
			}else{
				progressBar.Close();
				return false;
			}
		}
		if($F('comment').indexOf('$')>-1||$F('comment').indexOf('%')>-1||$F('comment').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "comment";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_12 %>");
				return false;
		}
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_13 %>");
		var url = '../role.do';
		var pars = 'action=RoleCreate&rolename=' + $F('rolename') + '&comment=' + comment;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: RoleCreate_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：新建角色 - CallBack
	---------------------------------------------------------------*/
	function RoleCreate_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//Debug(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_14 %>");
				progressBar.Close();
				
				$('divRoleCreate').innerHTML = "";
				//重新加载角色列表
				GetRoleList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_15 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_15 %>"+err.message);
		}
	}
	
	
		
	/*--------------------------------------------------------------
	 	功能：载入修改角色界面
	---------------------------------------------------------------*/
	function LoadRoleModify()
	{
		$('divRoleShow').style.display = "none";
		$('divRoleModifyInfo').style.display = "";
		$('divRoleCreate').innerHTML = "";
		progressBar = new ProgressBar();
	       progressBar.isNeedProgressBar = true;
	       progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_16 %>");
	       var url = "../role.do";
	       var pars = "action=LoadRoleModify&roleid="+currentId;
	       var myAjax = new Ajax.Request(
	       url,
	       {method: 'post', parameters: pars, onComplete: LoadRoleModify_CallBack}
	       );
	   }
	   
	   /*--------------------------------------------------------------
	 	功能：载入修改角色界面 - CallBack
	---------------------------------------------------------------*/
	function LoadRoleModify_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
		DisplayTransformedXML(1, objXml, "../xslt/admin_role_modify.xsl",document.getElementById("divRoleModifyInfo"));
		progressBar.Close();
	}
	
	/*--------------------------------------------------------------
		功能：修改角色
	--------------------------------------------------------------*/
	function RoleModify()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_17 %>");
		
		if($F('rolename') == "")
	       {
	           progressBar.isNeedConfirmButton = true;
	           progressBar.focusItem = "rolename";
	           progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_18 %>");
	           return;
	       }
       if($F('rolename').indexOf('$')>-1||$F('rolename').indexOf('%')>-1||$F('rolename').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "rolename";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_19 %>");
				return false;
		} 
	    var comment = $F('comment');
		if(comment.length > 40){
			if(confirm('<%= MipWebJSPUi.mipweb_user_admin_role_20 %>')){
				comment = comment.substring(0,40);
			}else{
				progressBar.Close();
				return false;
			}
		}
		if($F('comment').indexOf('$')>-1||$F('comment').indexOf('%')>-1||$F('comment').indexOf('&')>-1){
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "comment";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_21 %>");
				return false;
		}   
	       
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_22 %>");
		var url = '../role.do';
		var pars = 'action=RoleModify&rolename=' + $F('rolename') + '&comment=' +comment+'&roleid='+currentId;
		
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: RoleModify_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改角色 - CallBack
	--------------------------------------------------------------*/
	function RoleModify_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
		    //alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_23 %>");			
				progressBar.Close();
				RoleShow(currentId);	
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_24 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_25 %>"+err.message);
		}
	}
	
	/*--------------------------------------------------------------
		功能：角色详情
	--------------------------------------------------------------*/
	function RoleShow(id)
	{
		currentId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divRole').style.display = "";
	
		$('divRoleShow').style.display = "";
		$('divRoleModifyInfo').innerHTML = "";
		$('divRoleModifyInfo').style.display = "none";
	
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_26 %>");
		var url = '../role.do';
		var pars = 'action=RoleShow&roleid='+currentId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: RoleShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：角色详情 - CallBack
	--------------------------------------------------------------*/
	function RoleShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/admin_role_show.xsl",document.getElementById("divRoleShow"));
		
		//加载UserList,PermissionList
		GetRoleJoinUserList();
		GetRoleJoinPermissionList();
		$('spanCurrentPosition').innerHTML = objXml.getElementsByTagName("role").item(0).getAttribute("rolename");
		
	//设置tab为第一个
	tabPane.setSelectedIndex(0);
	}
	


/*--------------------------------------------------------------
	功能：删除角色信息
--------------------------------------------------------------*/
function RoleDelete()
{
	if(confirm("<%= MipWebJSPUi.mipweb_user_admin_role_27 %>"))
	{	
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_28 %>");
		var url = '../role.do';
		//alert(currentId);
		var pars = 'action=RoleDelete&roleid='+currentId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: RoleDelete_CallBack}
		);
	}
}
/*--------------------------------------------------------------
	功能：删除角色信息 - CallBack
--------------------------------------------------------------*/
function RoleDelete_CallBack(originalRequest)
{
	try
	{
		var objXml = originalRequest.responseXML;
		//Debug(originalRequest.responseTEXT);
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_29 %>");
			progressBar.Close();
			//重新加载角色列表
			GetRoleList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_30 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_31 %>"+err.message);
	}
}	

	//delete 
	function RoleDeleteMany()
	{
		if (!sel()){
		return false;
		}
		if(confirm("<%= MipWebJSPUi.mipweb_user_admin_role_32 %>"+m_idCount+"<%= MipWebJSPUi.mipweb_user_admin_role_33 %>"))
		{
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_34 %>");
			var url = '../role.do';
			var pars = 'action=RoleDelete&roleid='+m_ids;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: RoleDeleteManyy_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除用户信息 - CallBack
	--------------------------------------------------------------*/
	function RoleDeleteManyy_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_35 %>");
				progressBar.Close();
				GetRoleList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_role_36 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_37 %>"+errorMessage);
		}
	}


   /*--------------------------------------------------------------
       功能：属于该角色的用户列表
   --------------------------------------------------------------*/
 function GetRoleJoinUserList()
   {
   
   $('panelRoleJoinUserList').style.display = "";
		$('panelJoinUser').style.display = "none";
		
       var url = "../masuser.do";
       var pars = "action=GetRoleJoinUserList&roleid="+currentId;
       var myAjax = new Ajax.Request(
       url,
       {method: 'post', parameters: pars, onComplete: GetRoleJoinUserList_CallBack}
       );
   }
   
   /*--------------------------------------------------------------
       功能：属于该角色的用户列表 - CallBack
   --------------------------------------------------------------*/
   function GetRoleJoinUserList_CallBack(originalRequest)
   {
       var objXml = originalRequest.responseXML;
       //alert(originalRequest.responseText);
       DisplayTransformedXML(1, objXml, "../xslt/admin_role_join_admin_list.xsl",document.getElementById("divRoleJoinUserList"));
   }
   
   /*--------------------------------------------------------------
       功能：不属于角色的用户列表
   --------------------------------------------------------------*/
   function GetRoleUnJoinUserList()
   {
       var url = "../role.do";
       var pars = "action=GetRoleUnJoinUserList&roleid="+currentId;
       //alert(pars);
       var myAjax = new Ajax.Request(
       url,
       {method: 'post', parameters: pars, onComplete: GetRoleUnJoinUserList_CallBack}
       );
   }
   
   /*--------------------------------------------------------------
       功能：不属于该角色的用户列表 - CallBack
   --------------------------------------------------------------*/
   function GetRoleUnJoinUserList_CallBack(originalRequest)
   {
       var objXml = originalRequest.responseXML;
       //alert(originalRequest.responseTEXT);
       DisplayTransformedXML(1, objXml, "../xslt/admin_role_unjoin_admin_list.xsl",document.getElementById("divRoleUnJoinUserList"));
   }
   
   /*--------------------------------------------------------------
	功能：加入用户
--------------------------------------------------------------*/
function JoinUser(id)
{
	var strId = SelCatalogAndUser();

 progressBar = new ProgressBar();
 
 if($F('catalogTree') == "")
	       {
	           progressBar.isNeedConfirmButton = true;
	           progressBar.focusItem = "catalogTree";
	           progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_38 %>");
	           return;
	       }
	       
	progressBar.isNeedConfirmButton = false;
	progressBar.isNeedProgressBar = true;
	progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_39 %>");
	var url = '../role.do';
	var pars = 'action=JoinUser&roleid='+currentId+'&catalogid='+$F('catalogTree')+'&strId='+strId;
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
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_40 %>");
			progressBar.Close();
			//重新加载列表
			GetRoleJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_41 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_42 %>"+err.message);
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
	progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_43 %>");
	var url = '../role.do';
	var pars = 'action=UnJoinUser&roleid='+currentId+'&userid='+id;
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
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_role_44 %>");
			progressBar.Close();
			//重新加载列表
			GetRoleJoinUserList();
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_role_45 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebJSPUi.mipweb_user_admin_role_45 %>"+err.message);
	}
}


/*--------------------------------------------------------------
       功能：权限列表
   --------------------------------------------------------------*/
   function GetRoleJoinPermissionList()
   {
       var url = "../role.do";
       var pars = "action=GetRoleJoinPermissionList&roleid="+currentId;
       //alert(pars);
       var myAjax = new Ajax.Request(
       url,
       {method: 'post', parameters: pars, onComplete: GetRoleJoinPermissionList_CallBack}
       );
   }
   
   /*--------------------------------------------------------------
       功能：权限列表 - CallBack
   --------------------------------------------------------------*/
   function GetRoleJoinPermissionList_CallBack(originalRequest)
   {
       var objXml = originalRequest.responseXML;
       //alert(originalRequest.responseText);
       DisplayTransformedXML(1, objXml, "../xslt/admin_role_permission_list.xsl",document.getElementById("divRoleJoinPermissionList"));

   } 
   
   
   
/*--------------------------------------------------------------
	功能：保存权限
--------------------------------------------------------------*/
function UpdateRolePermission()
{
  progressBar = new ProgressBar();	
	progressBar.isNeedProgressBar = true;
	progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_role_46 %>");
	var url = '../role.do';
	var permissions = "";
	//取得权限值
	var o = document.getElementById("divRoleJoinPermissionList").getElementsByTagName("input");
   for(var i=0;i<o.length;i++){
       if(o[i].type == "checkbox" && o[i].checked == true){
       	permissions += o[i].id + ";";
       		}
   } 
	var pars = 'action=UpdateRolePermission&roleid='+currentId+'&permissions='+permissions;
	var myAjax = new Ajax.Request(
	url,
	{method: 'post', parameters: pars, onComplete: UpdateRolePermission_CallBack}
	);
}

/*--------------------------------------------------------------
	功能：保存权限 - CallBack
--------------------------------------------------------------*/
function UpdateRolePermission_CallBack(originalRequest)
{
	try
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseText);
		if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_47 %>");
			
		}
		else
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_48 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
		}
	}
	catch(err)
	{
		progressBar.isNeedConfirmButton = true;
		progressBar.isNeedProgressBar = false;
		progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_admin_role_48 %>"+err.message);
	}
}

	//加入用户到权限，必须选择一个且唯一的集团或部门，
	function LoadJoinUser()
	{
		
		$('panelRoleJoinUserList').style.display = "none";
		$('panelJoinUser').style.display = "";
		TreeMenu();	
	}


/*-------------------------------------------------------------
		功能：Tree Menu
	--------------------------------------------------------------*/
	function TreeMenu()
	{
		var url = '../catalog.do';
		var pars = 'action=GetAllCatalogList';
		var myAjax = new Ajax.Request(url,{method: 'post', parameters: pars, onComplete: TreeMenu_CallBack});
	}
	
	/*-------------------------------------------------------------
		功能：Tree Menu - CallBack
	--------------------------------------------------------------*/
	function TreeMenu_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//clear select
		for(var i = $('catalogTree').length;i>=0;i--)
		{
			$('catalogTree').remove(i);
		}
		
		var nodeList = objXml.selectNodes("/root/catlist/cat");
		for(var i=0;i<nodeList.length;i++)
		{
			var objOption = document.createElement("OPTION");
			objOption.text = nodeList[i].attributes[1].value;
			objOption.value = nodeList[i].attributes[0].value;		
			document.all?$('catalogTree').add(objOption):$('catalogTree').appendChild(objOption);
			//get child catalog
			GetChildCatalog(nodeList[i],0);
		}
	}
	
	
	
	/*-------------------------------------------------------------
		功能：取得子部门 - 无级分类
	--------------------------------------------------------------*/
	function GetChildCatalog(objXml,count)
	{
		//alert(objXml.xml);
		var nodeList = objXml.selectNodes("catlist/cat");
		//alert(nodeList.length);
		for(var i=0;i<nodeList.length;i++)
		{
			//get attribute
			//alert(nodeList[i].attributes[1].value);
			//生成select树 for 更换部门
			
			var space="";
			for(var j = 0;j<count;j++)
			{
				space += "　"
			}
			if(i == nodeList.length-1)
				space+="　┗";
			else
				space+="　┣"
				
			var objOption = document.createElement("OPTION");
			objOption.text = space+nodeList[i].attributes[1].value;
			objOption.value = nodeList[i].attributes[0].value;		
			document.all?$('catalogTree').add(objOption):$('catalogTree').appendChild(objOption);
			count++;
			GetChildCatalog(nodeList[i],count);
			count--;		
		}
	}

	function SelectCatalog(catalogid, catalogname)
	{
		$('spanResult').innerHTML = "<h1>"+catalogname+"</h1>";
	}
	
	
	//按功能查询
	function loadSearchRoleByFunction()
	{
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_role_49 %>", "../user/admin_role_search.jsp",450,640);
	}
	
	
	
	
	 /*--------------------------------------------------------------
	       功能：按功能搜索角色
	   --------------------------------------------------------------*/
   function searchRoleByFunction(permissions)
	   {
	       
			   $('divList').style.display = "";
					$('divCreate').style.display = "none";
					$('divInfo').style.display = "none";
		
			   var url = "../role.do";
			   var pars = "action=SearchRoleByFunction&permissions=" + permissions;
			   var myAjax = new Ajax.Request(url,
			   		{
				   method: 'post', 
				   parameters: pars, 
				   onComplete: function(originalRequest)
					   {
					   	var objXml = originalRequest.responseXML;
			       DisplayTransformedXML(1, objXml, "../xslt/admin_role_list.xsl",document.getElementById("divRoleList"));
								GB_CURRENT.hide();
								$('spanCurrentPosition').innerHTML = "<%= MipWebJSPUi.mipweb_user_admin_role_50 %>";
					   }
				  });
	   }
	
	</script>
</head>
	<body class="body_center" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
	
	<!--Top Include-->
	<jsp:include page="../user/top.jsp" flush="true"/>
	<!--Top Include-->


<!--Top Include-->
<div class="center_nav" ><%= MipWebJSPUi.mipweb_user_admin_role_51 %><a href="../user/main.jsp"><%= MipWebJSPUi.mipweb_user_admin_role_52 %></a> &gt;&gt; <a href="admin_role.jsp"><%= MipWebJSPUi.mipweb_user_admin_role_53 %></a> >>  <span id="spanCurrentPosition"></span></div>
<div class="center">
	<div class="clear"></div>
				<div id="mainbox">
				<div class="center_list_box">
					<div class="center_list">



				<!--列表-->
<table width="100%">
	<tr>
		<td width="6%"><span class="href_14px_gray"><%= MipWebJSPUi.mipweb_user_admin_role_54 %></span></td>
		<td width="16%"><img src="../skin/default/images/list_search.gif">
		<%= MipWebJSPUi.mipweb_user_admin_role_55 %><input type="text" id="keyword" class="input_120px" onkeydown="javascript:if(event.keyCode == 13 || event.which == 13){Search();}" onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)" /> 
		<td width="6%"><input type="image"  value="<%= MipWebJSPUi.mipweb_user_admin_role_57 %>" onclick="javascript:Search();return false;" src="../skin/default/images/button_search.gif"/></td> 
		<td width="10%"><span class="href_12px_blue_bold hand" onclick="javascript:loadSearchRoleByFunction();"><%= MipWebJSPUi.mipweb_user_admin_role_56 %></span></td>
		<td width="30%">				
			<div class="right">
			<input type="image" value="<%= MipWebJSPUi.mipweb_user_admin_role_58 %>" onClick="javascript:selall(1);return false;" src="../skin/default/images/button_chooseA.gif"/>
			<input type="image" value="<%= MipWebJSPUi.mipweb_user_admin_role_59 %>" onClick="javascript:selall(0);return false;" src="../skin/default/images/button_chooseN.gif"/>
			<input type="image" value="<%= MipWebJSPUi.mipweb_user_admin_role_60 %>" onClick="javascript:selall(2);return false;" src="../skin/default/images/button_chooseO.gif"/>
			<input type="image" id="btnDelMany" value="<%= MipWebJSPUi.mipweb_user_admin_role_61 %>" onclick='javascript:RoleDeleteMany();return false;' src="../skin/default/images/button_chooseD.gif"/>
			<input type="image" onclick="javascript:LoadRoleCreate();return false;" value="<%= MipWebJSPUi.mipweb_user_admin_role_62 %>" src="../skin/default/images/button_newrole.gif" width="60" height="22" border="0"/>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="7">
		<!--列表-->
			<div id="divList">
			
<form name="formlist" id="formlist">
				<div id="divRoleList"></div>
				</form>
			</div>
		<!--创建-->
			<div id="divCreate">
			<div id="divRoleCreate"></div>
		</div>

				<!--详情-->
				<div id="divInfo" style="display:none;">
					<div id="divRole" style="display:none;">
						<div id="tabRole" class="tab-pane">
							<div class="tab-page" id="tabPage1">
								<h2 class="tab">
									<%= MipWebJSPUi.mipweb_user_admin_role_63 %>
								</h2>
								<div id="divRoleShow"></div>
								<div id="divRoleModifyInfo" style="display:none;"></div>
							</div>
							<div class="tab-page" id="tabPage2">
								<h2 class="tab">
									<%= MipWebJSPUi.mipweb_user_admin_role_64 %>
								</h2>
								<div id="panelRoleJoinUserList">
								<div style="padding:5px;text-align:right;background-color:#fff;"><input type="button" class="button"	onclick="javascript:LoadJoinUser();" value="<%= MipWebJSPUi.mipweb_user_admin_role_65 %>" /></div>
								<div id="divRoleJoinUserList"></div>
								</div>
								<div id="panelJoinUser" style="display:none;">
								<table width="100%" cellpadding="0" cellspacing="1" style="margin:5px;">
								<tr><td width="50%"><b><%= MipWebJSPUi.mipweb_user_admin_role_66 %></b></td><td><b><%= MipWebJSPUi.mipweb_user_admin_role_67 %></b></td></tr>
								<tr>
								<td  valign="top">
								<div id="divUserTree" style="text-align:left;height:260px;width:260px; overflow:auto;overflow-y:yes;">
	<script src="../scripts/jsvm2/jsre.js" classpaht="webfx/xtree1.1.js"></script>
	<script  language="javascript">
	_import("com.eae.webfx.xtree.WebFXLoadTree");
	_import("com.eae.webfx.xtree.WebFXTree");
	_import("com.eae.webfx.xtree.WebFXTreeItem");	
	</script>
	<script type="text/javascript">
	var atree = new WebFXLoadTree("<%= MipWebJSPUi.mipweb_user_admin_role_68 %>","../catalog.do?action=GetCatalogForTextNode&catalogid=&bizUser=true&rnd="+Math.random());
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
								<td  valign="top">	
								<select id="catalogTree" size="15"></select>
								<span style="color:red">(<%= MipWebJSPUi.mipweb_user_admin_role_69 %>)</span>
								</td>
								</tr>
      <tr>
        <td colspan="3"><div class="center_nav_line"></div>
        </td>
      </tr>
								</table>								
								<p class="ar"> <div class="div_center"><input type="button" onclick="javascript:JoinUser()" value="<%= MipWebJSPUi.mipweb_user_admin_role_70 %>"/> <input type="button" onclick="javascript:GetRoleJoinUserList();" value="<%= MipWebJSPUi.mipweb_user_admin_role_71 %>"/></div>
								</div>
							</div>
							<div class="tab-page" id="tabPage3">
								<h2 class="tab">
									<%= MipWebJSPUi.mipweb_user_admin_role_72 %>
								</h2>
								<div id="divRoleJoinPermissionList"></div>
							</div>
							<div class="tab-page" id="tabPage4">
								<h2 class="tab">
									<%= MipWebJSPUi.mipweb_user_admin_role_73 %>
								</h2>
								<div class="href_14px_red" style="padding:80px;">
									<img alt="" src="../images/ico_info.gif" />
									<%= MipWebJSPUi.mipweb_user_admin_role_74 %>
								</div>
								<div class="center_nav_line"></div>
								<div class="div_center" style="padding:10px;">
									<input type="button" class="button"
										onclick="javascript:RoleDelete();" value="<%= MipWebJSPUi.mipweb_user_admin_role_75 %>" />
										<input type="button" class="button" id="btnReturn" value="<%= MipWebJSPUi.mipweb_user_admin_role_76 %> " onclick="javascript:GetRoleList();" />
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				
		</td>
	</tr>
</table>

			
					</div>
				</div>
			</div>
		</div>
					
		
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>