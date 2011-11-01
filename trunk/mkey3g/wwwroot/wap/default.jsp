<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
try {
		if(request.getParameter("appid")!=null)
			response.sendRedirect("m.do?appid="+request.getParameter("appid"));
		else
			response.sendRedirect("m.do");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/vnd.wap.wml");
		response.setHeader("Cache-Control", "no-cache, must-revalidate");
		
		%>
		<wml>
		<card title="页面跳转">
		<p>
		点击<a href="m.do?appid=<%=request.getParameter("appid") %>">链接</a>跳转页面
		</p>
		</card>
		</wml>
		<%		
	return;
} catch (java.io.IOException e) {
}
%>
