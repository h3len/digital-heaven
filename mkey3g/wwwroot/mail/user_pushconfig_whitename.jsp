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
	<script src="../dwr/interface/PushWhiteName.js" type="text/javascript"></script>
	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
	//公共变量	
	var currentMsgId=0 ;
			
			window.onload = function()
		{
			LoadList();
		 }
	
	
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
			Progress("正在保存数据...","提示");
				PushWhiteName.saveWhitename(tempstr,
			 	function(objXmldata){
					 	var objXml = objXmldata;
					if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
					{
						DHalert("操作成功！");
						CloseProgress();
						parent.parent.GB_CURRENT.hide();
					}
					else
					{
						DHalert("操作失败！");
						CloseProgress();
						return false;
					}
			 	});
	}

	/*--------------------------------------------------------------
		功能：删除
	--------------------------------------------------------------*/
	function delout(){
			for(var i=0; i < $('listall').length; i++){
				if($('listall')[i].selected==true){
						$('listall').remove(i);
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
			DHalert("输入错误！");
			return false;
		}
		/*if ($('addmsg').value.indexOf("@") <= 0)
		{
			f1.addmsg.focus();
			DHalert("请输入正确的EMAIL格式！");
			return false;
		}*/
		if($('addmsg').value.indexOf('@')<1||$('addmsg').value.indexOf('@')==($('addmsg').value.length)-1){
			f1.addmsg.focus();
			DHalert("请输入正确的EMAIL格式！");
			return false;
		}
		//if ($('addmsg').value.indexOf("*") >-1)
		//{
		//	if($('addmsg').value.indexOf("*")!=0 || f1.addmsg.value.indexOf("@")!=1)
		//	{
		//			f1.addmsg.focus();
		//			DHalert("请输入正确的EMAIL格式！");
		//			return false;
			//}
	//	}
	
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
		DHalert("输入错误！");
	}
	
	/*--------------------------------------------------------------
		功能：回车
	--------------------------------------------------------------*/
	function goent() {
		if (event.keyCode == 13)
		{
			event.keyCode = 9;
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
				Progress("正在载入数据...","提示");
				PushWhiteName.loadList(
			 	function(objXmldata){
			 		try{
			 			var objXml = objXmldata;
						var nodeList = objXml.selectNodes("/root/emaillist/email");
						for(var i=0;i<nodeList.length;i++)
						{
						if(nodeList[i].attributes[0].value != ""){
							var oOption = document.createElement("OPTION");
							oOption.text = nodeList[i].attributes[0].value;
							oOption.value = nodeList[i].attributes[0].value;
							document.all?$('listall').add(oOption):$('listall').appendChild(oOption);
							}
						}	
						CloseProgress();
					}catch(err){
						DHalert("网页过期,请重新登录");	
						window.location="../default_user.jsp" ;
					}
			 	});

    }
	
</script>	
</head>
<body>

<!-- 内容开始 -->
					<div align="center">

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
			&nbsp;<input maxlength="120" size="30" name="addmsg" id="addmsg" class="input_text input_120px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)" onKeyDown="goent()"/><br/>
			支持通配符方式<br/>
			*: 匹配任意长度的字符串.<br/>
			?: 匹配一个字符.
		</td>
		<td align="center">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<input  onClick="add();" type="button" class="button_3" style="cursor:hand;" value="添加 >>"/>
					</td>
				</tr>
				<tr>
					<td><br/>
						<input  onClick="delout()" type="button" class="button_3" style="cursor:hand;" value="<< 删除"/>
					</td>
				</tr>
			</table>
		</td>
		<td>
			<select name="listall" size="4" id="listall" TextMode="MultiLine" multiple="multiple" style="width:200px;"/>
			<input type="hidden" id="allmsgs" name="allmsgs"></input>
		</td>
	</tr>
	<tr>
		<td height="40" colspan="3"><br/>
			<div class="center_nav_line"></div>
		</td>
	</tr>
	<tr>
		<td height="40" colspan="3">
			<div class="div_center"><input type="button" ID="btnOK" value="保 存"  class="button_2"  onclick="javascript:Save();"/></div>
		</td>
	</tr>
</form>
</table>

<p class="gray al">*利用"信任列表"来确保过滤器不会阻挡对您来说重要的邮件。来自该列表中人员或邮箱的邮件不受过滤规则约束，仅受Push时间的约束。</p>
  


</div>
</body>
</html>
