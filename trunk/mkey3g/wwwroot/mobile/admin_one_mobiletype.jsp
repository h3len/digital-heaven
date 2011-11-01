<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<% 
    String username;
    if(request.getParameter("username") == null) {
       username = "";
    } else {
			username=new String(request.getParameter("username").getBytes("8859_1"),"utf-8");
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_1 %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="css.css" />
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		 <link type="text/css" rel="stylesheet" href="css.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		 var id;
         var path=location.href;
         if(path.indexOf("?")>-1)
                 {
          id=path.substring(path.lastIndexOf("=")+1);
                 }
  var flag = 0;
	   	//初始化
  window.onload = function(){
		    if(flag==0){
		    	getOneMobiletype(id);
		    }
		    flag=1;
		}

		//列出一条手机型 号信息
		function getOneMobiletype(id)
		{
		    MobileAction.getOneMobileType(id,{
		    callback:function(data){
			    dwr.util.setValues(data);
			    
			    if($("brief").value = ""){
			    $("brief").innerHTML = "&nbsp;"
			    		}
			       },
				errorHandler:function(errorString, exception) {
					parent.parent.DHalert(errorString);
				}
			});
		}
</script>
  </head>
  <body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		 <!-- 内容开始 -->

<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="90%" align="center" height="270" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="95%" border="1" align="center" cellpadding="8" cellspacing="0" bgcolor="#FFFFFF" bordercolordark="#f1f1f1" bordercolorlight="#E7E7E7">
      <tr>
        <td width="40%" bgcolor="#F5F5F5"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_2 %></td>
        <td width="60%" id="mobiletyep" class="href_12px_oringe" style="word-break: break-all">&nbsp;</td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_3 %></td>
        <td id="width" class="href_12px_oringe" style="word-break: break-all">&nbsp;</td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_4 %></td>
        <td id="height" class="href_12px_oringe">&nbsp; </td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5">UA：</td>
        <td id="ua" class="href_12px_oringe">&nbsp; </td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5" style="word-break: break-all"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_5 %></td>
        <td  class="href_12px_oringe"><span id="manufactory"></span>&nbsp; </td>
      </tr>
       <tr>
        <td bgcolor="#F5F5F5" style="word-break: break-all"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_6 %></td>
        <td  class="href_12px_oringe" id="opsystem">
			
		</td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_7 %></td>
        <td  class="href_12px_oringe"><span id="languagecode"></span>&nbsp; </td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_8 %></td>
        <td  class="href_12px_oringe"><span id="model"></span>&nbsp; </td>
      </tr>
      <tr>
        <td bgcolor="#F5F5F5" style="word-break: break-all"><%= MipWebJSPUi.mipweb_mobile_admin_one_mobiletype_9 %></td>
        <td class="href_12px_oringe">
        <span id="brief"></span>&nbsp; </td>
      </tr>
    </table></td>
  </tr>
</table>

  </body>
</html>
