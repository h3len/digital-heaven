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
	<script>
	
	String.prototype.endWith = function(oString)
	{  
    	var reg=new RegExp(oString+"$");  
    	return reg.test(this);     
    }  


	function onUpload()
	{
		if(document.getElementById("mdpconfig").value == null || document.getElementById("mdpconfig").value == '')
		{
			DHalert("请先选择文件!");
			return;
		}
	
		if(document.getElementById("mdpconfig").value.endWith("mdp.zip"))
		{
			Ext.Msg.confirm(nowtitle, "确定给"+document.getElementById("appid").value+"应用上传配置文件?", function(btn){
				if(btn=='yes'){
					document.frmUpload.submit();				
				}
			});
		}
		else
		{
			DHalert("上传文件名称必须为mdp.zip");return;
		}
	}
	</script>
	</head>
	<body>
	<div id="mainbox">
	<form id="frmUpload" name="frmUpload" onsubmit="javascript:onUpload();return false;" enctype="multipart/form-data" method="POST" action="/mdp.do?action=Upload">
	<div width="100%" align="center">
	<br />
	选择配置文件：<input type="file" id="mdpconfig" name="mdpconfig" />
	<input type="hidden" id="appid" name="appid" value="<%=request.getParameter("appid")%>"/>
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
          <td align="left" width="69%"><font color=red>*</font>上传文件全称必须为mdp.zip</td>
        </tr>
        <tr>
          <td align="right" style="height:15px;" width="38%">3.</td>
          <td align="left" width="69%">上传压缩文件中根目录为mdp</td>
        </tr>
        <tr>
          <td align="right" style="height:15px;" width="38%">4.</td>
          <td align="left" width="69%">mdp目录下就是配置文件的各目录(如config,template等)</td>
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
