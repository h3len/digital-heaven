<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
  		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
    <title>客户系统账号密码绑定</title>
	<script type="text/javascript" src="../../scripts/prototype.js"></script>
	<script type="text/javascript" src="../../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../../scripts/tabpane.js"></script>
	<script language="javascript" src="../../scripts/selall.js"></script>
	<script type="text/javascript" src="../../scripts/xtree.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextend.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextras.js"></script>
	<script type="text/javascript" src="../../scripts/xloadtree.js"></script>
	
	
	
	<script src="/dwr/interface/User2.js" type="text/javascript"></script>
	<script src="/dwr/engine.js" type="text/javascript"></script>
	<script src="/dwr/util.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="/skin/AJS.js"></script>
	<script type="text/javascript" src="/skin/AJS_fx.js"></script>
	<script type="text/javascript" src="/skin/gb_scripts.js"></script>
	<link href="/skin/gb_styles.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="/skin/calendar/calendar.js"></script>
	<script type="text/javascript"
		src="/skin/calendar/lang/calendar-zh.js"></script>
	<link href="/skin/calendar/css/zpcal.css" rel="stylesheet"
		type="text/css" />
	<link href="/skin/calendar/website/css/template.css"
		rel="stylesheet" type="text/css" />
	<link href="/skin/calendar/themes/winxp.css" rel="stylesheet"
		type="text/css" />
	
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
			 var url = '/catalog.do';
			 var pars = 'action=GetCatalogList&catalogid='+id;
		    
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: TreeMenu_CallBack}
		     );
		}
		function TreeMenu_CallBack(originalRequest){
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_catalog_list.xsl",document.getElementById("main"));
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
			
			
			 User2.GetUserList(catalogid,
			{
				callback:function(objXml) {
					document.getElementById("divUserList").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_user_list.xsl",document.getElementById("divUserList"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
			
			
			/*
			var url = '/user.do';
			var pars = 'action=GetUserList&catalogid='+catalogid;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: GetUserList_CallBack}
			);
			*/
		}
		/*-------------------------------------------------------------
			功能：用户列表 - CallBack
		--------------------------------------------------------------*/
		function GetUserList_CallBack(originalRequest)
		{		
		
			try
			{
				var objXml = originalRequest.responseXML;				
				DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_user_list.xsl",document.getElementById("divUserList"));
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
