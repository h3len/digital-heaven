<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>MDP 配置文件管理</title>
	<script type="text/javascript" src="../../scripts/jquery/jquery-1.2.3.pack.js"></script>
	<script type="text/javascript" src="../../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextend.js"></script>
	<script type="text/javascript">
	var progressBar;
	
	function loadAuthorization()
	{
		$.ajax({
		 type: "POST",
		 url: "config.do",
		 data: "action=LoadAuthorization",
		 dataType: "xml",
		 success: function(data){
		 	alert(data.xml);
			DisplayTransformedXML(1, data, "xslt/authorization.xsl",document.getElementById("main"));
			} 
		});
	}
	</script>
	<style type="text/css">
	#nav{ background-color:#eee; align-text:right;}
	</style>
	</head>
	<body>
	<div id="mainbox">
		<div id="nav"><a href="javascript:loadAuthorization();">访问策略管理</a> <a href="javascript:loadSource();">数据源管理</a> <a href="javascript:loadHtmlTransfer();">HTML转义</a></div>
		<div id="main"></div>
	</div>
	</body>
</html>
