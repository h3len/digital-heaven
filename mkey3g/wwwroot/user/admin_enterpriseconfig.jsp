<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebMoreUi.mip_user_admin_enterpriseconfig_1 %></title>
<link type="text/css" rel="stylesheet" href="../css/user.css" />
	<script type="text/javascript" src="../scripts/prototype.js"></script>
	<script type="text/javascript" src="../scripts/checkform.js"></script>
	<script type="text/javascript" src="../scripts/cookies.js"></script>
	<script type="text/javascript" src="../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../scripts/tabpane.js"></script>		
	<script type="text/javascript" src="../scripts/xmlextend.js"></script>
	
	<script type="text/javascript">
	var progressBar;	
	var currentCatalogId = "<%=request.getSession().getAttribute("enterpriseid")%>";
	
	window.onload = function()
	{
	 //GetConfigMenu();
		 if("<%=request.getSession().getAttribute("user")%>" == "<%=com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID%>")
		 {
		 GetEnterpriseList();	 
		 }
		 else
		 {
		 GetConfig(currentCatalogId);
		 }
	} 
	
	
	
	
	
	/*--------------------------------------------------------------
		功能：GetEnterpriseList
	---------------------------------------------------------------*/
	function GetEnterpriseList()
	{
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
   progressBar.isNeedProgressBar = true;
   progressBar.Top = 10;
   progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_2 %>");	
		var url = '../catalog.do';
		var pars = 'action=GetCatalogList';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetEnterpriseList_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：GetEnterpriseList - CallBack
	---------------------------------------------------------------*/
	function GetEnterpriseList_CallBack(originalRequest)
	{
	  var objXml = originalRequest.responseXML;
	  try
		{
		  DisplayTransformedXML(1, objXml, "../xslt/enterpriseconfig_list.xsl",document.getElementById("divbody"));
		}
		catch(err)
		{
		}
	  progressBar.Close();
	}
	
	
	
    
  function isIP(s)
	{
	  var patrn=/(\d){1,3}.(\d){1,3}.(\d){1,3}.(\d){1,3}$/;
	  if (!patrn.exec(s)) return false
	  return true
	}
		 /*--------------------------------------------------------------
	       功能：取得配置页面菜单
	   --------------------------------------------------------------*/
	 function GetConfigMenu()
	   {
     var url = "../config.do";
     var pars = "action=GetConfigMenu";
     var myAjax = new Ajax.Request(
     url,
     {method: 'post', parameters: pars, onComplete: GetConfigMenu_CallBack}
       );
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得配置页面菜单 - CallBack
	   --------------------------------------------------------------*/
	 function GetConfigMenu_CallBack(originalRequest)
	   {
    	var objXml = originalRequest.responseXML;
     //alert(originalRequest.responseText);
	 		var nodelist = objXml.selectNodes("/root/list/item");
			for(var i = 0;i < nodelist.length;i++)
	 		{	 		
				var obj= document.getElementById("menutable");
				var tbody = document.createElement("tbody");
				var tr1 = document.createElement("tr");
				var td1 = document.createElement("td");
				td1.setAttribute("height", "4");
				tr1.appendChild(td1);
				tbody.appendChild(tr1);
				obj.appendChild(tbody);	
				var tr2 = document.createElement("tr");
				tr2.setAttribute("height", "24");
				tr2.setAttribute("background", "../images/admin_left_2.gif");
				//tr1.setAttribute("onMouseOver", "this.background='./menu3.gif'");
				var td2 = document.createElement("td");
				td2.innerHTML="<div style='padding-left:35px;'><a href=\""+nodelist[i].attributes[1].value+"\">"+nodelist[i].attributes[0].value+"</a></div>";
				tr2.appendChild(td2);
				tbody.appendChild(tr2);
				obj.appendChild(tbody);
	 		} 		
	   } 	   
  /*--------------------------------------------------------------
	 	功能：载入系统配置界面
	---------------------------------------------------------------*/
	function GetConfig(id)
	{
		currentCatalogId = id;
		$('divbody').style.display = "";
		//开始提交数据
   progressBar = new ProgressBar();
  	progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_3 %>");
		var url = '../catalog.do';
		var pars = 'action=CatalogShow&catalogid='+currentCatalogId;		
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetConfig_CallBack}
		);
    }
    /*--------------------------------------------------------------
        功能：载入系统配置界面 - CallBack
    --------------------------------------------------------------*/
  function GetConfig_CallBack(originalRequest)
    {
   var objXml = originalRequest.responseXML;
		DisplayTransformedXML(1, objXml, "../xslt/enterpriseconfig_modify.xsl",document.getElementById("divbody"));
		$('ssotype').value = objXml.getElementsByTagName("cat")[0].getAttribute("ssotype");
		if(objXml.getElementsByTagName("cat")[0].getAttribute("enablesso") == "true"){
			$('enablesso').checked = true;
		}
		EnableSSO();
   progressBar.Close();        
    }	  
    
	function EnableSSO()
	{
		if($('enablesso').checked == true){
			$('ssourl').enabled = true;
			$('ssotype').enabled = true;	
		}
		else{
			$('ssourl').enabled = false;
			$('ssotype').enabled = false;
		}
	}
    
  	/*--------------------------------------------------------------
		功能：修改信息
	--------------------------------------------------------------*/
	function EnterpriseModifyInfo()
	{
		progressBar = new ProgressBar();
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_4 %>");
		if($F('catalogname') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "catalogname";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_5 %>");
			return;
		}
		
		if($F('shortname') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "shortname";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_6 %>");
			return;
		}
		
		if($F('enterprisecode') == "")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "enterprisecode";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_7 %>");
			return;
		}		
		
		if($('enablesso').checked == true)
		{
			if($F('ssotype') == "")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "ssotype";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_8 %>");
				return;
			}
			if($F('ssourl') == "")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "ssourl";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_9 %>");
				return;
			}			
		}
	
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_10 %>");
		var url = '../catalog.do';
		var enablesso = false;
		enablesso = $('enablesso').checked;
		var pars = 'action=CatalogModifyInfo&password='+$F('password')+'&enablesso='+enablesso+'&ssotype='+$F('ssotype')+'&ssourl='+$F('ssourl')+'&enterprisecode='+$F('enterprisecode')+'&catalogname=' + $F('catalogname') + '&shortname=' + $F('shortname') + '&ssoid=&comment=' +$F('comment')+'&extnumber=' +$F('extnumber')+'&catalogid='+currentCatalogId;
		if(typeof(document.getElementById('branchdisksize')) != null){
			pars += '&branchdisksize='+$F("branchdisksize")+'&persondisksize='+$F("persondisksize");
		}
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: EnterpriseModifyInfo_CallBack}
		);
	}
	
	/*--------------------------------------------------------------
		功能：修改信息 - CallBack
	--------------------------------------------------------------*/
	function EnterpriseModifyInfo_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_admin_enterpriseconfig_11 %>");		
		if("<%=request.getSession().getAttribute("user")%>" == "<%=com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID%>")
		 {
		 	progressBar.Close();
		 GetEnterpriseList();	 
		 }		 
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_12 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_13 %>"+errorMessage);
		}
	}  
    
	</script>

 </head>
  
  <body style="padding:0px;margin:0px;">
  <div  style="width:1000px;float:left">
		<div id="main" style="width:100%;padding:0px;float:left">
			<div id="menu" style="width:176px; padding:0px;float:left;">

							<!-- Begin: left navigation -->
      <table width="176" border="0" cellspacing="0" cellpadding="0" class='LeftHandNavigation'>
        <tr> 
          <td class="leftnavtop"><img src="/images/spacer.gif" alt="" width="1" height="21" /></td>
        </tr>
        <tr> 
          <td class='container'>
								<ul>
								<li ><font size="+1"><%= MipWebMoreUi.mip_user_admin_enterpriseconfig_14 %></font></li>
								<%if(request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID))//dheaven帐号专用
		 						{%>
								<li ><a href="admin_config.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_15 %></a></li>
								<li ><a href="admin_mobiletype.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_16 %></a></li>
								  <%} %>
								<li ><a href="admin_enterpriseconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_17 %></a></li>
								<li ><a href="../mail/admin_enterprisemailconfig.jsp" target="main">&nbsp;&nbsp;&nbsp;&nbsp;<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_18 %></a></li>
							
								
								
              

			   <li class='last'></li>
            </ul></td>
        </tr>
        <tr> 
          <td class="leftnavbot"><img src="/images/spacer.gif" alt="" width="1" height="26" /></td>
        </tr>
      </table>
<!-- End: left navigation -->

</div>

				<div id="mainbox" style="width:80%;height:auto;padding:3px;float:left">
					<div class="nav" style="width:800px">&nbsp;<%= MipWebMoreUi.mip_user_admin_enterpriseconfig_19 %><a href="../user/main.jsp"><%= MipWebMoreUi.mip_user_admin_enterpriseconfig_20 %></a> <%= MipWebMoreUi.mip_user_admin_enterpriseconfig_21 %> <span id="spanCurrentPosition"></span></div>

	<div id="divbody" style="width:100%;padding:6px;text-align:center;background-color:#fff;float:left"></div>
		</div>
		</div.
</div>
	</body>
</html>
