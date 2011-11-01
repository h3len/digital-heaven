<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<title>viewlocal</title>
		<style>
.shadow {
	margin-top: 50px;
	margin-bottom: 10px;
	margin-right: 10px;
	margin-left: 10px;
	background-color: #EFEFEF;
}

.shadow img {
	padding: 1px;
	border: 2px solid #CDCDCD;
	background-color: #FFFFFF;
	position: relative;
	top: -15px;
	left: -15px;
}
</style>

	</head>
	<%
		int pages = 1;
		try{
			pages =	Integer.parseInt(request.getParameter("pages"));
		}catch(Exception e){
		}
	%>
	<body bgcolor="#DBE2ED" style="margin: 0px;padding: 0px">
		<table background="menu_bg.jpg" width="100%" height="44"
			cellpadding="0" cellspacing="0" style="display:<%="true".equalsIgnoreCase(request.getParameter("showclose"))?"block":"none"%>">
			<tr>
				<td valign="middle">
					&nbsp;&nbsp;&nbsp;
					<a><img src="back.gif" style="border: 0px" onclick="window.location='dhmkey3g://123';window.close()"/>
					</a>
				</td>
			</tr>
		</table>
		<%
			for (int i = 0; i < pages; i++) {
		%>
		<div class="shadow">
			<img width="98%"
				src="../tmp/<%=request.getParameter("uid")%>/<%=request.getParameter("filename")%>/temp<%=pages == 1 ? "" : "-" + i%>.jpg" />
			<div align="center" style="font-size:30">
				<%=i+1 %>/<%=pages %>
			</div>
		</div>
		<%
			}
		%>
		<table background="menu_bg.jpg" width="100%" height="44"
			cellpadding="0" cellspacing="0" style="display:<%="true".equalsIgnoreCase(request.getParameter("showclose"))?"block":"none"%>">
			<tr>
				<td valign="middle">
					&nbsp;&nbsp;&nbsp;
					<a><img src="back.gif" style="border: 0px" onclick="window.location='dhmkey3g://123';window.close()"/>
					</a>
				</td>
			</tr>
		</table>
	</body>
</html>