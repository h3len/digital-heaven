<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.MipSysuserServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.ServerConfig"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>客户系统账号密码绑定</title>
	<script type="text/javascript" src="../../scripts/prototype.js"></script>
	<script type="text/javascript" src="../../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../../scripts/tabpane.js"></script>
	<script language="javascript" src="../../scripts/selall.js"></script>
	<script type="text/javascript" src="../../scripts/xtree.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextend.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextras.js"></script>
	<script type="text/javascript" src="../../scripts/xloadtree.js"></script>
	<link type="text/css" rel="stylesheet" href="../../css/xtree.css" />
	
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../../css/luna/tab.css" />
	<link type="text/css" rel="stylesheet" href="../../css/user.css" />
	
	<script type="text/javascript">
		var catId = "<%=request.getParameter("cat")%>";
		var progressBar;
		function Init(){		 
			 
			 GetCatalogList(catId);
			 GetUserList(catId);
			 
		}
		
		/*--------------------------------------------------------------
		功能：部门列表  
		---------------------------------------------------------------*/
		function GetCatalogList(id)
		{	
			 
			 progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在载入数据....");
			 var url = '../../catalog.do';
			 var pars = 'action=GetCatalogList&catalogid='+id;
		    
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: TreeMenu_CallBack}
		     );
		}
		function TreeMenu_CallBack(originalRequest){
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_catalog_list.xsl",document.getElementById("main"));
			progressBar.Close();
		}
		/*--------------------------------------------------------------
			功能：用户列表
		--------------------------------------------------------------*/
		function GetUserList(catalogid)
		{
			
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.Top = 10;
			progressBar.SetStatus("正在载入数据....");
			
			var url = '../../user.do';
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
		
			try
			{
				var objXml = originalRequest.responseXML;				
				DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_user_list.xsl",document.getElementById("divUserList"));
				progressBar.Close();
				
			}
			catch(err)
			{
				//alert(errorMessage);
			}
		}
		function selectUser(id ,truename){
			if (window.opener && !window.opener.closed){
					window.opener.document.getElementById("newmipuserName").value = truename;
					window.opener.document.getElementById("newmipuser").value = id;
					//window.opener.checkUser();
					window.close(-1);
			}
  			
		}
	</script>
	<style type="text/css">
	
	</style>
	</head>
  
<body bgcolor="#f8f8f8"  onload="javascript:Init();">		
		<div id="main" >
		</div>
		<div id="divUserList" />
		<div id="nav"></div>
		<div id="content"></div>
	</body>
</html>
