56
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
<%@ page contentTytml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>    
<title>PUSH时间设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/xmlextras.js"></script>
<link type="text/css" rel="stylesheet" href="css.css" />

		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
	//公共变量
	var progressBar;
	var currentMsgId=0 ;
	/*--------------------------------------------------------------
		功能：根据check框设置select框的状态
	--------------------------------------------------------------*/

	function isopen()
	{
		if($('isenabled').checked==true)
		{
			$('time1').disabled = false;
			$('time2').disabled = false;
			$('week1').disabled = false;
			$('week2').disabled = false;
			$('miniute1').disabled = false;
			$('miniute2').disabled=false;
		       // document.all.btnsave.disabled = false;
		}
		else
		{
			$('time1').disabled = true;
			$('time2').disabled = true;
			$('week1').disabled = true;
			$('week2').disabled = true;
			$('miniute1').disabled = true;
			$('miniute2').disabled = true;
		        //document.all.btnsave.disabled = true;
		}
	}
	/*--------------------------------------------------------------
		功能：载入界面
	--------------------------------------------------------------*/
	
	function LoadPushTime()
	{
		progressBar = new ProgressBar();
		var url = '../mailpushruletime.do';
		var pars = 'action=LoadPushTime';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadPushTime_CallBack}
		);
	}
	/*--------------------------------------------------------------
		功能：载入界面 - CallBack
	--------------------------------------------------------------*/
	
	function LoadPushTime_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;	
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true"){
				if (objXml.getElementsByTagName("pushtime").item(0).attributes[0].value == "true")
				{					
					document.getElementById('isenabled').checked = true;
				}
				else	
				{	
					document.getElementById('isenabled').checked = false;
				}	
							
				if(objXml.getElementsByTagName("pushtime").item(0).getAttribute("startday") == "-1" || objXml.getElementsByTagName("pushtime").item(0).getAttribute("endday") == "-1")
				{
					$('isfullweek').checked = true;
				}
				else
				{
					document.getElementById('week1').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("startday");
					document.getElementById('week2').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("endday");				
				}
				document.getElementById('time1').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("starttime").split(":")[0];
				document.getElementById('miniute1').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("starttime").split(":")[1];
				document.getElementById('time2').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("endtime").split(":")[0];
				document.getElementById('miniute2').value=objXml.getElementsByTagName("pushtime").item(0).getAttribute("endtime").split(":")[1];						
			}
		}
		catch(err)
		{
			document.getElementById('isenabled').checked = false;
			//alert(objXml.xml);
			//alert(err.message);
		}
		isopen();
		progressBar.Close();
	}
	/*--------------------------------------------------------------
		功能：保存设置
	--------------------------------------------------------------*/
	
	function SavePushTime()
	{
		var ischecked='false';
		if($('isenabled').checked)
		{
			ischecked='true';
		}
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在发送数据到服务器....");
		
		var startday = $('week1').value;
		var endday = $('week2').value;
		if($('isfullweek').checked && startday == endday)
		{
			startday = -1;
			endday = -1;
		}
		
		var url = '../mailpushruletime.do';
		var pars = 'action=SavePushTime&startday='+startday+'&endday='+endday
					+'&starttime='+$F('time1')+":"+$F('miniute1')+'&endtime='+$F('time2')+":"+$F('miniute2')+'&isenabled='+ischecked;
		//alert(pars);
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: SavePushTime_CallBack}
		);
		
	}
	/*--------------------------------------------------------------
		功能：保存设置 - CallBack
	--------------------------------------------------------------*/
	
	function SavePushTime_CallBack(originalRequest)
	{
		try
		{
			var objXml = originalRequest.responseXML;
			//alert(originalRequest.responseText);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");

			}
			else{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因："+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			
			}											
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因："+errorMessage);
		}
		//progressBar.Close();
	
	}	
	
	
</script>

</head>
  
<body onload="LoadPushTime();">

<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
  
<div class="center_nav">·当前所在位置：<a href="../user/main.jsp">首页</a> &gt;&gt; <a href="../mail/admin_mail.jsp">我的PushEmail</a> >> <a href="../mail/admin_pushrule.jsp">PUSH规则</a> >> PUSH时间设置<span id="spanCurrentPosition"></span></div> 
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
					<li><a id="current" href="../mail/user_push_pushtime.jsp">PUSH时间设置</a></li>
					<li><a href="../mail/user_push_whitename.jsp">信任列表</a></li>
					<li><a href="../mail/user_push_filter.jsp">邮件过滤</a></li>
			</div>
		</div>
	</div>
<div class="center_right">

<!-- 内容开始 -->
<table align="center" width="100%" height="300" >	
	<tr>
		<td align="left" valign=""><input type="checkbox" id="isenabled" onClick="javascript:isopen();" NAME="isenabled"></input><label for="isenabled">启用PUSH时间设置</label>	<fieldset>
			<table width="100%" border="0" align="center" cellspacing="0">
				<tr>
					<td colspan="4" height="28">
						&nbsp;
						
					</td>
				</tr>
				
				<tr>
					<td align=right height=30><input type="checkbox" id="isfullweek"></input></td>
					<td  height=30>是否整周</td>
					<td align="left" colspan="3">
						<label for="isfullweek">当起始工作日和结束工作日相同时，表示一整周</label>
					</td>
				</tr>
				<tr>
					<td align=right height=30>按工作日</td>
					<td align="left">从
						<select id="week1" name="week1">
							<option value="1%>">星期日</option>
							<option value="2" selected>星期一</option>
							<option value="3">星期二</option>
							<option value="4">星期三</option>
							<option value="5">星期四</option>
							<option value="6">星期五</option>
							<option value="7">星期六</option>
						</select>
					</td>
					<td align="left">到
						<select id="week2" name="week2">
							<option value="1">星期日</option>
							<option value="2" selected>星期一</option>
							<option value="3">星期二</option>
							<option value="4">星期三</option>
							<option value="5">星期四</option>
							<option value="6">星期五</option>
							<option value="7">星期六</option>
							</select>
					</td>
				</tr>
				<tr>
					<td width="30%" align=right height=30>按工作时间</td>
					<td width="20%" align=left>从
					<select id="time1" name="time1">
							<script language="javascript">
								for(var i=0;i<24;i++)
								{
									document.write("<option value='"+i+"'>"+i+"</option>");
								}
							</script>
					</select>点
					<select id="miniute1" name="miniute1">
						<script language="javascript">
								for(var i=0;i<60;i++)
								{
									document.write("<option value='"+i+"'>"+i+"</option>");
								}
						</script>
					</select>分	
					</td>
					<td align=left>到
						<select id="time2" name="time2">
							<script language="javascript">
								for(var i=0;i<24;i++)
								{
									document.write("<option value='"+i+"'>"+i+"</option>");
								}
							</script>
						</select>点															
						<select id="miniute2" name="miniute2">
							<script language="javascript">
								for(var i=0;i<60;i++)
								{
									document.write("<option value=\""+i+"\">"+i+"</option>");
								}
							</script>
						</select>分
						</td>
				</tr>
				<tr>
					<td align="center" colspan="10" height="40"><input type=button ID="btnSave" value="保存设置" style="cursor:hand;" onclick="SavePushTime();"></input></td>
				</tr>
			</table></fieldset>
		</td>
	</tr>
</table>

	</div>
		
		

<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
</body>
</html>
