<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MKey</title>
<link href="css/tools.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
function Comparison()
{
	if(document.getElementById("ieLogs").value != "" && document.getElementById("mdpLogs").value != "")
	{
		document.form_Comparision.action += "?action=ParamComparison";
		document.form_Comparision.submit();
	}
	else
		alert("请输入ie和mdp的日志!");
}
</script>
</head>
<body>
<form name="form_Comparision" id="form_Comparision" method="POST" action="comparison.do">
<div id="page">
    <div id="main">
        <div id="header">
            <input class="button_2" name="comparison" onclick="Comparison()" type="button" value="对 比" />
        </div>
        <div class="left">
            <h1>请粘贴IE的流程数据到这里:</h1>
            <div>
                <textarea class="border" name="ieLogs" id="ieLogs" cols="" rows="" ondblclick="this.select();"></textarea>
            </div>
        </div>
        <!-- end left -->
        <div class="right">
            <h1>请粘贴MDP的流程数据到这里:</h1>
            <textarea class="border" name="mdpLogs" id="mdpLogs" cols="" rows="" ondblclick="this.select();"></textarea>
        </div>
        <!-- end right -->
    </div>
    <!-- end main -->
</div>
<!-- page end-->
</form>
</body>
</html>
