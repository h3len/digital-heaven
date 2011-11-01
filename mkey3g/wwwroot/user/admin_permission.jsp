
<%

	//验证权限
	if (request.getSession().getAttribute("admin") == null
			|| request.getSession().getAttribute("admin").equals("")) {
		out.print("<script>parent.location.href='../default.jsp?url="
		+ request.getServletPath() + "?"
		+ request.getQueryString() + "'</script>");
		return;
	}
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>

<html>
<head id="Head1" runat="server">
    <title><%= MipWebMoreUi.mip_user_admin_permission_1 %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="../css/user.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
	<script type="text/javascript">
    //公共变量
    var progressBar;
    var currentId = "";
    //选项卡
	var tabPane;
    
    //初始化
    window.onload = function()
    {
        GetPermissionList();
        tabPane = new WebFXTabPane( document.getElementById( "tabPermission" ), true );
    }    
    
    /*--------------------------------------------------------------
        功能：取得权限列表
    --------------------------------------------------------------*/
    function GetPermissionList()
    {
        
        $('divList').style.display = "";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "none";
		
        //开始提交数据
        progressBar = new ProgressBar();
        progressBar.isNeedProgressBar = true;
        progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_2 %>");
        var url = "../permission.do";
        var pars = "action=GetPermissionList";
        //alert(pars);
        var myAjax = new Ajax.Request(
        url,
        {method: 'post', parameters: pars, onComplete: GetPermissionList_CallBack}
        );
    }
    
    /*--------------------------------------------------------------
        功能：取得权限列表 - CallBack
    --------------------------------------------------------------*/
    function GetPermissionList_CallBack(originalRequest)
    {
        var objXml = originalRequest.responseXML;
        //alert(originalRequest.responseTEXT);
        DisplayTransformedXML(1, objXml, "../xslt/admin_permission_list.xsl",document.getElementById("divPermissionList"));
        progressBar.Close();        
		$('spanCurrentPosition').innerHTML = "<%= MipWebMoreUi.mip_user_admin_permission_3 %>";
    } 
    
    /*--------------------------------------------------------------
	 	功能：载入新建权限界面
	---------------------------------------------------------------*/
	function LoadPermissionCreate()
	{
		$('divList').style.display = "none";
		$('divCreate').style.display = "";
		$('divInfo').style.display = "none";
		
		//开始提交数据
        progressBar = new ProgressBar();
        progressBar.isNeedProgressBar = true;
        progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_4 %>");
        var url = "../permission.do";
        var pars = "action=LoadPermissionCreate";
        //alert(pars);
        var myAjax = new Ajax.Request(
        url,
        {method: 'post', parameters: pars, onComplete: LoadPermissionCreate_CallBack}
        );
    }
    
    /*--------------------------------------------------------------
        功能：载入新建权限界面 - CallBack
    --------------------------------------------------------------*/
    function LoadPermissionCreate_CallBack(originalRequest)
    {
        var objXml = originalRequest.responseXML;
        //alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/admin_permission_create.xsl",document.getElementById("divPermissionCreate"));
        progressBar.Close();        
		$('spanCurrentPosition').innerHTML = "<%= MipWebMoreUi.mip_user_admin_permission_34 %>";
    }
	
    /*--------------------------------------------------------------
		功能：新建权限
	---------------------------------------------------------------*/
	function PermissionCreate()
	{
	    progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_5 %>");
		
		if($F('permissionname') == "")
        {
            progressBar.isNeedConfirmButton = true;
            progressBar.focusItem = "permissionname";
            progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_6 %>");
            return;
        }
        
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_7 %>");
		var url = '../permission.do';
		var pars = 'action=PermissionCreate&permissionname=' + $F('permissionname') + '&comment=' + $F('comment');
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: PermissionCreate_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：新建权限 - CallBack
	---------------------------------------------------------------*/
	function PermissionCreate_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//Debug(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_8 %>");
				progressBar.Close();
				
				$('divPermissionCreate').innerHTML = "";
				//重新加载权限列表
				GetPermissionList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_9 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_10 %>"+err.message);
		}
	}
		
	/*--------------------------------------------------------------
	 	功能：载入修改权限界面
	---------------------------------------------------------------*/
	function LoadPermissionModify()
	{
		$('divPermissionShow').style.display = "none";
		$('divPermissionModifyInfo').style.display = "";
		$('divPermissionCreate').innerHTML = "";
		progressBar = new ProgressBar();
        progressBar.isNeedProgressBar = true;
        progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_11 %>");
        var url = "../permission.do";
        var pars = "action=LoadPermissionModify&permissionid="+currentId;
        var myAjax = new Ajax.Request(
        url,
        {method: 'post', parameters: pars, onComplete: LoadPermissionModify_CallBack}
        );
    }
    
    /*--------------------------------------------------------------
	 	功能：载入修改权限界面 - CallBack
	---------------------------------------------------------------*/
    function LoadPermissionModify_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/admin_permission_modify.xsl",document.getElementById("divPermissionModifyInfo"));
		progressBar.Close();
	}

	/*--------------------------------------------------------------
		功能：修改权限
	--------------------------------------------------------------*/
	function PermissionModify()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_12 %>");
		
		if($F('permissionname') == "")
        {
            progressBar.isNeedConfirmButton = true;
            progressBar.focusItem = "permissionname";
            progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_13 %>");
            return;
        }
        
        
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_14 %>");
		var url = '../permission.do';
		var pars = 'action=PermissionModify&permissionname=' + $F('permissionname') + '&comment=' +$F('comment')+'&permissionid='+currentId;
		
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: PermissionModify_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改权限 - CallBack
	--------------------------------------------------------------*/
	function PermissionModify_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
		    //alert(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_15 %>");				
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_16 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_17 %>"+err.message);
		}
	}
	
	/*--------------------------------------------------------------
		功能：权限详情
	--------------------------------------------------------------*/
	function PermissionShow(id)
	{
		currentId = id;
	
		$('divList').style.display = "none";
		$('divCreate').style.display = "none";
		$('divInfo').style.display = "";
	
		$('divPermission').style.display = "";
	
		$('divPermissionShow').style.display = "";
		$('divPermissionModifyInfo').innerHTML = "";
		$('divPermissionModifyInfo').style.display = "none";
	
		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_18 %>");
		var url = '../permission.do';
		var pars = 'action=PermissionShow&permissionid='+currentId;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: PermissionShow_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：权限详情 - CallBack
	--------------------------------------------------------------*/
	function PermissionShow_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		//alert(originalRequest.responseTEXT);
		DisplayTransformedXML(1, objXml, "../xslt/admin_permission_show.xsl",document.getElementById("divPermissionShow"));
		//设置tab为第一个
		tabPane.setSelectedIndex(0);
		$('spanCurrentPosition').innerHTML = objXml.getElementsByTagName("permission").item(0).getAttribute("permissionname")+"<%= MipWebMoreUi.mip_user_admin_permission_19 %>";
	}

	
	/*--------------------------------------------------------------
		功能：删除权限信息
	--------------------------------------------------------------*/
	function PermissionDelete()
	{
		if(confirm("<%= MipWebMoreUi.mip_user_admin_permission_20 %>"))
		{	
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_permission_21 %>");
			var url = '../permission.do';
			//alert(currentId);
			var pars = 'action=PermissionDelete&permissionid='+currentId;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: PermissionDelete_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除权限信息 - CallBack
	--------------------------------------------------------------*/
	function PermissionDelete_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//Debug(originalRequest.responseTEXT);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = false;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_22 %>");
				progressBar.Close();
				//重新加载权限列表
				GetPermissionList();
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_23 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_permission_24 %>"+err.message);
		}
	}	
	</script>
</head>
<body>

	<div class="nav">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0><TBODY><TR>
			<TD class=navigation>&nbsp;<IMG alt="" src="../images/icon.gif" align=baseline border=0>&nbsp;<font color=#052968><%= MipWebMoreUi.mip_user_admin_permission_25 %></font><a href="main.jsp"><font color=#052968><%= MipWebMoreUi.mip_user_admin_permission_26 %></font></a><font color=#052968>&nbsp;<IMG alt="" src="../images/next.gif" align=baseline border=0>&nbsp; </font><a href="admin_permission.jsp"><font color=#052968><%= MipWebMoreUi.mip_user_admin_permission_27 %></font></a></TD></TR></TBODY></TABLE><span id="spanCurrentPosition"></span>
	</div>

    <form id="form1" runat="server">
    <div id="main">
              
		<!--列表-->
        <div id="divList">
            <div style="padding:5px;text-align:right;background-color:#fff;"><input type="button" class="button" onclick="javascript:LoadPermissionCreate();" value="<%= MipWebMoreUi.mip_user_admin_permission_28 %>" /> </div>
            <div id="divPermissionList"></div>
            <div style="padding:5px;text-align:right;background-color:#fff;"><input type="button" class="button" onclick="javascript:LoadPermissionCreate();" value="<%= MipWebMoreUi.mip_user_admin_permission_28 %>" /> </div>
            <div><%= MipWebMoreUi.mip_user_admin_permission_29 %></div>
        </div>
        
		<!--创建-->        
        <div id="divCreate" style="display:none;">
            <div id="divPermissionCreate"></div>
        </div>
                
		<!--详情-->        
        <div id="divInfo" style="display:none;">
            <div id="divPermission" style="display:none;">
		        <div id="tabPermission" class="tab-pane" style="margin-top:6px;">
			        <div class="tab-page" id="tabPage1">
				        <h2 class="tab"><%= MipWebMoreUi.mip_user_admin_permission_30 %></h2>
				        <div id="divPermissionShow"></div> 
				        <div id="divPermissionModifyInfo" style="display:none;"></div>
			        </div>		        
			        <div class="tab-page" id="tabPage2">
				        <h2 class="tab"><%= MipWebMoreUi.mip_user_admin_permission_31 %></h2>
				        <div class="attention"><img alt="" src="../images/ico_info.gif"/> <%= MipWebMoreUi.mip_user_admin_permission_32 %></div>
				        <div style="text-align:right;padding:20px;"><input type="button" class="button" onclick="javascript:PermissionDelete();" value="<%= MipWebMoreUi.mip_user_admin_permission_33 %>" /></div>
			        </div>
		        </div>
	        </div>
        </div>
        
    </div>
    </form>
</body>
</html>

