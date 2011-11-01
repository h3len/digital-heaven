<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MKey</title>
<link href="css/tools.css" type="text/css" rel="stylesheet" />
<style type="text/css">
.msg{color:red;}
.msg span{margin-right:30px;padding:3px;}
</style>
</head>
<body>

    <div class="msg">
    	<span class="bg_red witle">ie中存在,但是mdp中不存在</span>
		<span class="bg_orange witle">ie中不存在,但是mdp中存在</span>
		<span  class="bg_gray witle">ie和mdp中该段内容的值不同</span>
	</div><!-- 提示信息 end -->
<div id="page">
    <div id="main">
		<div id="header">
            <input class="button_2" name="" onclick="location.href='compare.jsp';" type="button" value="对 比" />
        </div>
        <%=session.getAttribute("ieContent") %>
        
        <%=session.getAttribute("mdpContent") %>
            
    </div>
    <!-- end main -->
</div>
<!-- page end-->
</body>
</html>