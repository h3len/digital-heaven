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
				return;
			}
		}
	}
}
%>
<%@ page contentTypml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>    
<title>信任列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>

		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
	//公共变量
	var progressBar;
	var currentMsgId=0 ;

	
	/*--------------------------------------------------------------
		功能：保存信任列表设置 - CallBack
	--------------------------------------------------------------*/
	function Save()
	{	
		var f1 = document.WhiteName;
		var tempstr = "";
		var i = 0;
		for (i; i < $('listall').length; i++)
		{
			tempstr = tempstr + f1.listall[i].value + ",";
		}
		
		if( tempstr.length > 0 && tempstr.indexOf(",") > -1 )
			tempstr = tempstr.substring(0,tempstr.length-1);
			
	
		//开始保存数据
		progressBar = new ProgressBar();		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在保存数据....");
		var url = '../mailpushrulewhitename.do';
		var pars ='action=Save&email='+tempstr;
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: Save_CallBack}
		);
		
	}
	
	/*--------------------------------------------------------------
		功能：保存信任列表设置 - CallBack
	--------------------------------------------------------------*/
	function Save_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！<br/>失败原因："+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！<br/>失败原因："+errorMessage);
		}
		
	}
	
	
	

	/*--------------------------------------------------------------
		功能：删除
	--------------------------------------------------------------*/
	function delout()
	{
		var f1 = document.WhiteName;
		var i = 0;
		for (i; i < $('listall').length; i++)
		{
			if (f1.listall[i].selected == true)
			{
				f1.listall.remove(i);
				f1.listall.selectedIndex = i-1;
				i--;
			}
		}
	}
	/*--------------------------------------------------------------
		功能：添加
	--------------------------------------------------------------*/	
	function add()
	{
		var f1 = document.WhiteName;
		//alert($('addmsg').value);
		if ($('addmsg').value.indexOf("\t") != -1)
		{
			f1.addmsg.focus();
			alert("输入错误!");
			return ;
		}
		if ($('addmsg').value.indexOf("@") <= 0)
		{
			f1.addmsg.focus();
			alert("请输入正确的EMAIL格式!");
			return ;
		}
		
		if ($('addmsg').value.indexOf("*") >-1)
		{
			if($('addmsg').value.indexOf("*")!=0 || f1.addmsg.value.indexOf("@")!=1)
			{
					f1.addmsg.focus();
					alert("请输入正确的EMAIL格式!");
					return ;
			}
		}
	
		if ($('addmsg').value.length > 0)
		{
			if (haveit() == false)
			{
				var oOption = document.createElement("OPTION");
				oOption.text = $('addmsg').value;
				oOption.value = $('addmsg').value;
				document.all?$('listall').add(oOption):$('listall').appendChild(oOption);
				return ;
			}
			else
				return ;
		}
	
		alert("输入错误!");
	}
	
	/*--------------------------------------------------------------
		功能：回车
	--------------------------------------------------------------*/
	function goent() {
		if (event.keyCode == 13)
		{
			event.keyCode = 9;
			//alert($('addmsg').value);
			add();
		}
	}
	
	/*--------------------------------------------------------------
		功能：判断重复		
	--------------------------------------------------------------*/
	function haveit()
	{
	var f1 = document.WhiteName;
		var tempstr = f1.addmsg.value;
	
		var i = 0;
		for (i; i < f1.listall.length; i++)
		{
			if (f1.listall[i].value == tempstr)
				return true;
		}
	
		return false;
	}
	/*--------------------------------------------------------------
		功能:载入信任列表	
	--------------------------------------------------------------*/
	function LoadList(){
		progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("正在保存数据....");
		var url = '../mailpushrulewhitename.do';
		var pars = 'action=LoadList';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadList_CallBack}
		);
    }
	/*--------------------------------------------------------------
		功能：载入信任列表 - CallBack
	--------------------------------------------------------------*/
	
	function LoadList_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			var nodeList = objXml.selectNodes("/root/emaillist/email");
			for(var i=0;i<nodeList.length;i++)
			{
				var oOption = document.createElement("OPTION");
				oOption.text = nodeList[i].attributes[0].value;
				oOption.value = nodeList[i].attributes[0].value;
				document.all?$('listall').add(oOption):$('listall').appendChild(oOption);
			}												
		}
		catch(err)
		{
			alert(errorMessage);
		}
		progressBar.Close();
	}	
</script>	

</head>
  
<body bgcolor="#ffffff" style="padding:0px;margin:0px;" onload="LoadList();">


 <!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
  
<div class="center_nav">·当前所在位置：<a href="../user/main.jsp">首页</a> &gt;&gt; <a href="../mail/admin_mail.jsp">我的PushEmail</a>  >> <a href="../mail/admin_pushrule.jsp">PUSH规则</a> >> 信任列表<span id="spanCurrentPosition"></span></div> 
<div class="center_nav_line"></div>
<div class="center">
  <div class="center_menu_top">
		<!-- center_menu_top -->
			<div id="center_menu_top">
				<ul>
					<li><a href="../mail/admin_mail.jsp"><span>绑定邮箱</span></a></li>
					<li id="current"><a href="../mail/admin_pushrule.jsp"><span>PUSH规则</span></a></li>
				
					<li></li>
				</ul>
	</div>
  </div>
 
	 <div class="center_left">
		<div class="center_menu_left">
		<!-- center_menu_left -->
			<div id="center_menu_left">
				<ul>
					<li><a href="../mail/user_push_pushtime.jsp">PUSH时间设置</a></li>
					<li><a id="current" href="../mail/user_push_whitename.jsp">信任列表</a></li>
					<li><a href="../mail/user_push_filter.jsp">邮件过滤</a></li>
			</div>
		</div>
	</div>
	
	
<div class="center_right">



<table align="center" width="100%" height="300" >
<form id="WhiteName" name="WhiteName" >
<tr valign="bottom">
		<td>
		<b>键入电子邮件地址:</b></td>
		<td width="20%"></td>
		<td width="30%">&nbsp;<b>信任列表:</b></td>
	</tr>
	<tr >
		<td style="PADDING-LEFT:20px">
			&nbsp;<input maxlength="120" size="30" name="addmsg" id="addmsg" class='textbox' onKeyDown="goent()"><br>
			支持通配符方式<br>
			*: 匹配任意长度的字符串.<br>
			?: 匹配一个字符.
		</td>
		<td align="center">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<input style="WIDTH: 80px" onClick="add();" type="button" style="cursor:hand;" value="添加 >>">
					</td>
				</tr>
				<tr>
					<td><br>
						<input style="WIDTH: 80px" onClick="delout()" type="button" style="cursor:hand;" value="<< 删除">
					</td>
				</tr>
			</table>
		</td>
		<td>
			<select name="listall" size="4" id="listall" TextMode="MultiLine" style="width:200px;"/>
			<input type="hidden" id="allmsgs" name="allmsgs"></input>
		</td>
	</tr>
	<tr>
		<td height="40" colspan="3"><br>
			<div class="center_nav_line"></div>
		</td>
	</tr>
	<tr>
		<td height="40" colspan="3">
			<div class="div_center"><input type="button" ID="btnOK" value="保 存" style="cursor:hand;" onclick="javascript:Save();"></asp:Button></input>
		</td>
	</tr>
</form>
</table>

<p class="gray al">*利用"信任列表"来确保过滤器不会阻挡对您来说重要的邮件。来自该列表中人员或邮箱的邮件不受过滤规则约束，仅受Push时间的约束。</p>
  

	</div>
</div>

<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
</body>
</html>
