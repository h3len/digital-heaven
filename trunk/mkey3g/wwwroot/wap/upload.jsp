<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>上传MDP配置文件</title>
	<style type="text/css">
	#nav{ background-color:#eee; align-text:right;}
	</style>
	<link href="/theme/css.css" rel="stylesheet" type="text/css" />
	<link href="/skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="/skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="/skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
			
		<script type="text/javascript" src="/scripts/common.js"></script>
	<%
		String appid = request.getParameter("appid");
		if(appid == null || appid.equals(""))
		{
			return;
		}
	%>
	<script>
	var appid = '<%= appid %>';
	
	String.prototype.endWith = function(oString)
	{  
    	var reg=new RegExp(oString+"$");  
    	return reg.test(this);     
    }  


	function onUpload()
	{
		if(document.getElementById("wapAppFile").value == null || document.getElementById("wapAppFile").value == '')
		{
			DHalert("请先选择应用文件!");
			return;
		}
		if(document.getElementById("wapAppFile").value.endWith(appid + ".zip"))
		{
			Ext.Msg.confirm(nowtitle, "确定给"+ appid +"业务系统上传WAP应用?", function(btn){
				if(btn=='yes'){
					document.frmUpload.submit();
				}
			});
		}
		else
		{
			DHalert("上传文件名称必须为"+appid+".zip");return;
		}
	}
	</script>
	</head>
	<body>
	<div id="mainbox">
	<form id="frmUpload" name="frmUpload" onsubmit="javascript:onUpload();return false;" enctype="multipart/form-data" method="POST" action="/wap/appManager.do?action=appUpload">
	<div width="100%" align="center">
	<br />
	选择配置文件：<input type="file" id="wapAppFile" name="wapAppFile" />
	<input type="hidden" id="appid" name="appid" value="<%= appid %>"/>
	<br />
	<input type="submit" class="button" value="上传">
	<br/>
	<font color="red">
	 <div align="center" width="100%" >
    	<table width="80%" cellpadding="2" cellspacing="2" bgcolor="#ffffff">
        <tr>
          <td align="right" style="height:15px;" width="38%">1.</td>
          <td align="left" width="69%"><font color=red>*</font>上传文件名必须为标准的zip格式文件</td>
        </tr>
        <tr>
          <td align="right" style="height:15px;" width="38%">2.</td>
          <td align="left" width="69%"><font color=red>*</font>上传文件全称必须为<%= appid %>.zip</td>
        </tr>
        <tr>
          <td align="right" style="height:15px;" width="38%">3.</td>
          <td align="left" width="69%">上传压缩文件中根目录为<%= appid %></td>
        </tr>
       </table>
     </div>
	</font>
	<%
	if(request.getParameter("rspMsg") != null){
	%>
	<br/>
	</div>
	<div width="100%" align="center">
	提示信息：<%=request.getParameter("rspMsg")%>
	</div>
	<%
	}
	%>
	</form>
	</div>
	</body>
</html>
