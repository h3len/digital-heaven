<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail")==null)
		{
			out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail");
			if(list == null || list.size() == 0)
			{
				out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			l1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>PUSH规则</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="css.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />

  </head>
  
  <body>
<!--Top Include-->
	<jsp:include page="../user/top.jsp" flush="true"/>
	<!--Top Include-->
  
 <div class="center_nav">·当前所在位置：<a href="../user/main.jsp">首页</a> &gt;&gt; <a href="../mail/admin_mail.jsp">我的PushEmail</a> >> <a href="../mail/admin_pushrule.jsp">PUSH规则</a><span id="spanCurrentPosition"></span></div> 
  <div class="center_nav_line"></div>
  
<div class="center">
  <div class="center_menu_top">
		<!-- center_menu_top -->
			<div id="center_menu_top">
				<ul>
					<li id="current"><a href="../mail/admin_mail.jsp"><span>绑定邮箱</span></a></li>
					<li id="current"><a href="../mail/admin_pushrule.jsp"><span>PUSH规则</span></a></li>
				
					<li></li>
				</ul>
	</div>
  </div>
  </div>
  <p>&nbsp</p>

<div align="center">
<table align="center" width="50%">
<tr>
		 <!-- 内容开始 -->
	
		<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
			<table height="22">
				<tr bgcolor="#dbeaf5">
					<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
						<font class="s" color="#104a7b"><b><a href="user_push_pushtime.jsp">PUSH时间设置</a></b></font>
					</td>
				</tr>
			</table>
			<div align="center"><br>
				设定邮件到达提醒的工作时间。</div>
		</td>
	</tr>
	<tr>
		<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
		</td>
	</tr>
	<tr>
		<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
			<table height="22">
				<tr bgcolor="#dbeaf5">
					<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
						<font class="s" color="#104a7b"><b><a href="user_push_whitename.jsp">信任列表</a></b></font>
					</td>
				</tr>
			</table>
			<div align="center"><br>
				来自该列表中人员或邮箱的邮件不受过滤规则约束，仅受Push时间的约束。</div>
			<!--<table height="22"><tr bgcolor="#DBEAF5"><td nowrap align="center" height="22" width="150" style="border-top:1px #8CA5B5 solid; border-left:1px #8CA5B5 solid; border-right:1px #8CA5B5 solid; border-bottom:1px #8CA5B5 solid;">
<font class="s" color="#104A7B"><b><a href="BlackName.do?action=list">邮件拒收</a></b></font>
</td></tr>
</table>
<div align="center"><br>指定您不想接收邮件的电子邮件地址</div>-->
		</td>
	</tr>
	<tr>
		<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
		</td>
	</tr>
	<tr>
		<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
			<table height="22">
				<tr bgcolor="#dbeaf5">
					<td width="150" height="22" align="center" nowrap bgcolor="#eeeeee" style="BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid">
						<font class="s" color="#104a7b"><b><a href="user_push_filter.jsp">邮件过滤</a></b></font>
					</td>
				</tr>
			</table>
			<div align="center"><br>
				对信件按照您预先设定的规则进行自动过滤，使您免受垃圾邮件的骚扰。</div>
		</td>
		<td>
		</td>
		<td height="70" align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>
		</td>
	</tr>
	<tr>
		<td height="24" align="center" style='BORDER-RIGHT:#ffffff 1px solid; BORDER-TOP:#ffffff 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-BOTTOM:#ffffff 1px solid'>
		</td>
	</tr>
</table>
		</div>
		
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
  
</html>
