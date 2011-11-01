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
<%@ page contentType="text/html; charset=UTF-8" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>    
<title>PUSH时间设置</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>

  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../scripts/xmlextras.js"></script>
	<link type="text/css" rel="stylesheet" href="css.css" />

	<!-- Dwr Js -->
	<script src="../dwr/interface/PushRule.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>

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
		
				PushRule.LoadPushTime(
				 	function(objXmldata){
								try
								{
										var objXml = objXmldata;	
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
										DHalert("网页过期,请重新登录");	
										window.location="../default_user.jsp" ;
									}
									isopen();
					}
				);
		
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
		
		Progress('正在发送数据到服务器....','保存设置');
		var startday = $('week1').value;
		var endday = $('week2').value;
		//注释掉 by mahm:
		/*
		if($('isfullweek').checked && startday == endday)
		{
			startday = -1;
			endday = -1;
		}
		*/
		//update by mahm:看了一下后台代码，原来工作日相同就当整周来处理，但是这样是不合理，如星期一 9：00到星期一 12：00,就不允许设置了吗
		var vtime1=$('time1').value+":"+$('miniute1').value;
		var vtime2=$('time2').value+":"+$('miniute2').value;
		if(startday == endday&&vtime1==vtime2)
		{
			startday = -1;
			endday = -1;
		}
		
		if(startday != endday&&vtime1==vtime2){
		DHalert("您设置的不是整周push,所以按工作时间的起始时间设置不能相同！");
		return;
		}
		
		
		PushRule.SavePushTime(startday,endday,vtime1,vtime2,ischecked,
				 	function(objXmldata){
							var objXml = objXmldata;
							//alert(originalRequest.responseText);
							if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
							{
								DHalert("PUSH时间设置成功！");
								return false;
							}
							else{
								DHalert("操作失败，请重试！\n失败原因："+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
								return false;
							}											
						
					
		});
		
	}
	
</script>
</head>
<body onload="LoadPushTime();">

<!-- 内容开始 -->
					<div align="center">
						<table align="center" width="80%">	
					<tr><td><br/><br/><br/></td></tr>
						<tr>
							<td align="center">
								<input type="checkbox" id="isenabled" onClick="javascript:isopen();" NAME="isenabled"></input><label for="isenabled">启用PUSH时间设置</label>
							</td>
						</tr>
						<tr><td><br/><br/></td></tr>
						<tr>
						<td align="center" style='BORDER-RIGHT:#8ca5b5 1px solid; BORDER-TOP:#8ca5b5 1px solid; BORDER-LEFT:#8ca5b5 1px solid; BORDER-BOTTOM:#8ca5b5 1px solid'>			
						<table width="100%" align="center" border="0"cellspacing="0">
							<tr>
								<td colspan="4" height="28">
									&nbsp;
								</td>
							</tr>
							<tr style="display:none">
								<td width="16" align="right"><img src="../skin/default/images/text_icon.gif" /></td>
								<td align="left" height=30 width="20%"><input type="checkbox" id="isfullweek"></input></td>
								<td align="left" height=30 >是否整周</td>
								<td align="left" colspan="3">
									<label for="isfullweek">当起始工作日和结束工作日相同时，表示一整周</label>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="left" height="28">
									<font color=#ff0000> 按工作日与按工作时间的起始时间设置相同时表示一整周!</font>
								</td>
							</tr>

							<tr>
								<td width="16" align="left"><img src="../skin/default/images/text_icon.gif" /></td>
								<td align="left" height=30 >
								按工作日</td>
								<td align="left">从
									<select id="week1" name="week1">
										<option value="1">星期日</option>
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
								<td colspan="4" align="left" height="28">
								<div class="center_nav_line">
								</div>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" align="left" height="28">
									<font color=#ff0000> 按工作时间的设置表示每个工作日内从某时到某时才会push!</font>
								</td>
							</tr>
							<tr>
								<td width="16" align="left"><img src="../skin/default/images/text_icon.gif" /></td>
								<td width="20%" align=left height=30 >按工作时间</td>
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
								<tr><td colspan="5"><br/><br/></td></tr>
							<tr>
								<td align="center" colspan="5" height="40"><input type=button class="button_4" ID="btnSave" value="保存设置" style="cursor:hand;" onclick="SavePushTime();"></input></td>
							</tr>
					</table>
</td></tr></table>
</div>
</body>
</html>
