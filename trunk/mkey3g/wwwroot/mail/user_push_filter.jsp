<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@ page import ="com.dheaven.mip.plugin.mail.core.*"%>
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
<title>邮件过滤</title>


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
//	var Filter = document.getElementById("Filter");

/*
	function mdel() {
	if (ischeck() == true)
	{
		f1.mode.value = "mdel";
		f1.submit();
	}
	}


	function ischeck() {
		var i = 0;
		var theObj;
	
		for(; i<0; i++)
		{
			theObj = eval("f1.check" + i);
	
			if (theObj != null)
				if (theObj.checked == true)
					return true;
		}
	
		return false;
	}
		*/
	function jsTrim(s) {return s.replace(/(^\s+)|(\s+$)/g, "");}
	function addnew() {
	
	if($F("s_msg")=="" && $F("s_content")!=4 && $F("s_mode")!=3)
	{
	  alert("请输入内容");
	  $("s_msg").focus();
	  return false;
	}
	
	
	if($F("s_content") == 3 && $F("s_msg").indexOf("e")>-1)
	{
	    alert("请不要按科学计数法输入数据");
	    $("s_msg").focus();
	    return false;
	}
	 if($F("s_content") == 3 && checkobjmunber($("s_msg"),0)==false)
	{
	  alert("请输入大于0的数字");
	  $("s_msg").focus();
	  return false;
	}
	
	
		var isok = false;
	        if($F("s_content")==1 && $F("s_mode")==3)
	        {
	          Filterform.submit();
	          return;
	        }
	
	        if($F("s_content")==4)
	        {
	          Filterform.submit();
	          return;
	        }
	
		if ($F("s_msg") == "" && $F("s_content") != 3 && ($F("s_mode") 
	
	== 1 || $F("s_mode") == 2))
			isok = true;
	
		if ($F("s_msg") != "" && $F("s_content") != 4)
			isok = true;
		if (isok == true)
		{
			if ($F("s_content") != 4)
			{
				Filterform.submit();
			}
			else
			{
				if ($F("s_msg") >= 0)
					Filterform.submit();
			}
		}
	}
	
	function add_s_mode(a_value, a_text)
	{
		var oOption = document.createElement("OPTION");
		oOption.text = a_text;
		oOption.value = a_value;
		document.all?$("s_mode").add(oOption):$("s_mode").appendChild(oOption);
	}
	
	function checkobjmunber(objtxt,izero){
	
		var chname;
		if (typeof(objtxt.chname)=="undefined"){
			chname = "内容";
		}
		else{
			chname = jsTrim(objtxt.chname)
			if (chname==""){chname = "内容";}
		}
	
		objtxt.value=jsTrim(objtxt.value);
		if (isNaN(parseFloat(objtxt.value))){
			//alert(chname + "不是有效数字！");
			objtxt.focus();return false;
		}
		objtxt.value=parseFloat(objtxt.value)
		if (izero>0){
			if(!(parseFloat(objtxt.value)>0)){
				//alert(chname + "需大于零！");
				objtxt.focus();return false;
			}
		}
		else if (izero>=0){
			if(!(parseFloat(objtxt.value)>=0)){
				//alert(chname + "需大于等于零！");
				objtxt.focus();return false;
			}
		}
		return true;
	}
	
	function select_content_onchange()
	{
		var i = 0;
		$('size').innerText="";
		for (i; i < $("s_mode").length; i++)
		{
			$("s_mode").remove(i);
			i--;
		}
	
		if ($F("s_content") == "1")
		{
	          $("s_msg").style.display = "";
			add_s_mode("1", "包含");
			add_s_mode("2", "不包含");
	                add_s_mode("3", "为空");
		}
	        else if ($F("s_content") == "2")
		{
	                $("s_msg").style.display = "";
			add_s_mode("1", "包含");
			add_s_mode("2", "不包含");
		}
		else if ($F("s_content") == "3")
		{
	          $("s_msg").style.display = "";
			add_s_mode("3", "大于");
			add_s_mode("4", "小于");
			$('size').innerText="KB";
			
		}
		else if ($F("s_content") == "4")
		{
	         
	          $("s_msg").style.display = "none";
	          add_s_mode("5", "重要");
			add_s_mode("6", "普通");
			add_s_mode("7", "不重要");
	
	}
	}
	
	function s_mode_change()
	{
		if($F("s_content")=="3")//这是邮件大小
		{
			 $("s_msg").style.display="";
			 return;
		}
		if($F("s_mode")=="3" || $F("s_mode")=="5" || $F("s_mode")=="6" || $F("s_mode")=="7")
		{
		$F("s_msg")="";
		$("s_msg").style.display="none";
		}
		else
		{
		$("s_msg").style.display="";
		}

	}
	
	function del(delid)
	{
		if(confirm("确认要删除该规则吗？"))
		{
			location.href="admin_push_filter.aspx?delid="+delid;
		}
	}
/*--------------------------------------------------------------
	功能：保存规则
--------------------------------------------------------------*/
	
	function Save(){

		
		if($F("s_msg")=="" && $F("s_content")!="4" && $F("s_mode")!="3")
		{
		  alert("请输入内容");
		  $("s_msg").focus();
		  return false;
		}
	
		if($F("s_content") == "3" && $F("s_msg").indexOf("e")>-1)
		{
		    alert("请不要按科学计数法输入数据");
		    $("s_msg").focus();
		    return false;
		}
		
		 if($F("s_content") == "3" && $F("s_msg")<=0)
		{
		  alert("请输入大于0的数字");
		  $("s_msg").focus();
		  return false;
		}


		//开始保存数据
		progressBar = new ProgressBar();		
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.SetStatus("正在保存数据....");
		var url = '../mailpushrulefilter.do';
		var pars ='action=Save&content='+$F('s_content')+'&mode='+$F('s_mode')+'&deal='+$F('s_deal')
				+'&msg='+$F('s_msg');
				
	
				
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: Save_CallBack}
		);
	
	}
/*--------------------------------------------------------------
	功能：保存规则-CallBack
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
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+errorMessage);
		}
		progressBar.Close();
		LoadFilterList();
		
	}
/*--------------------------------------------------------------
	功能：载入邮件过滤列表
--------------------------------------------------------------*/
	
	function LoadFilterList(){
		progressBar = new ProgressBar();
		progressBar.isNeedConfirmButton = false;
		progressBar.isNeedProgressBar = true;
		progressBar.Top = 10;
		progressBar.SetStatus("正在载入数据....");
		
		var url = '../mailpushrulefilter.do';
		var pars = 'action=LoadFilterList';
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: LoadFilterList_CallBack}
		);
	}
/*--------------------------------------------------------------
	功能：载入邮件过滤列表－CallBack
--------------------------------------------------------------*/
	function LoadFilterList_CallBack(originalRequest)
	{
		var objXml = originalRequest.responseXML;
		try{
		
    document.getElementById("list").innerHTML = "";
			DisplayTransformedXML(1, objXml, "../xslt/mailfilter_list.xsl",document.getElementById("list"));
			progressBar.Close();
		}catch(err){
			alert(errorMessage);
		}
	}
/*--------------------------------------------------------------
	功能：删除
--------------------------------------------------------------*/
	function FilterDelete(id){
	

	
		if(confirm("确定删除该过滤规则吗?"))
		{	
			progressBar = new ProgressBar();
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("正在发送数据到服务器....");
			var url = '../mailpushrulefilter.do';
			var pars = 'action=FilterDelete&filterid='+id;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: FilterDelete_CallBack}
			);
		}
	}
	/*--------------------------------------------------------------
		功能：删除即时信息 - CallBack
	--------------------------------------------------------------*/
	function FilterDelete_CallBack(originalRequest)
	{

		try
		{
		
			var objXml = originalRequest.responseXML;
			
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作成功！");
				GetCatalogList(catalogid);
			}
			else
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.isNeedProgressBar = false;
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 操作失败，请重试！\n失败原因：！"+err.message);
		}
		progressBar.Close();
		LoadFilterList();
		
	}
</script>

</head>	

<body onload="LoadFilterList();">

 <!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
  
<div class="center_nav">·当前所在位置：<a href="../user/main.jsp">首页</a> &gt;&gt; <a href="../mail/admin_mail.jsp">我的PushEmail</a> >> <a href="../mail/admin_pushrule.jsp">PUSH规则</a> >> 邮件过滤<span id="spanCurrentPosition"></span></div> 
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
					<li><a href="../mail/user_push_whitename.jsp">信任列表</a></li>
					<li><a id="current" href="../mail/user_push_filter.jsp">邮件过滤</a></li>
			</div>
		</div>
	</div>


<div class="center_right">
<form name="Filterform" id="Filterform">
<table width="100%" align="center" cellspacing="0" bgcolor="#f8f8f8" style='BORDER:#8ca5b5 1px solid;margin-top:10px;'>

<input type="hidden" id="issave" name="issave" value="1"/>
	<tr>
		<td height="30" align="left" nowrap>
			<div style="Z-INDEX:9">&nbsp;<span class="href_12px_red_bold">第1步:</span>&nbsp;
				<select id="s_content" name="s_content" onChange="javascript:select_content_onchange()">
					<option value="1" selected>邮件主题</option>
					<option value="2">发件人</option>
					<option value="3">邮件大小</option>
					<option value="4">优先级</option>
				</select>
				<select name="s_mode" id="s_mode" class="drpdwn" onchange="javascript:s_mode_change()">
					<option value="1" selected>包含</option>
					<option value="2">不包含</option>
					<option value="3">为空</option>
				</select>
				<input type="text" id="s_msg" name="s_msg"></input><span id="size" style="COLOR:red"></span>
			</div>
		</td>
	</tr>
	<tr>
		<td nowrap>&nbsp;<span class="href_12px_red_bold">第2步:</span>&nbsp;
			<select id="s_deal" name="s_deal">
				<option value="4" selected>不推送</option>
				<option value="2" selected>不提醒</option>
				<option value="1">直接删除</option>
			</select>&nbsp;&nbsp;&nbsp;<button ID="btnOK"  onclick="javascript:Save();">创建新规则</button>
		</td>
	</tr>
</table>
<div id="list" style="height:330px;overflow:auto;"></div>
<br/>
<table width="99%" border="0" align="center" cellspacing="0" bgcolor="#EEEEEE" style='BORDER-TOP:#8ca5b5 1px solid'>
	<tr>
		<td colspan="2" height="10">
		</td>
	</tr>
	<tr>
		<td width="15%" valign="top">&nbsp;<font color="#ff3333">&nbsp;邮件大小</font></td>
		<td width="85%">您输入的邮件大小单位是"千字节(KB)".<br></td>
	</tr>
	<tr>
		<td colspan="2" height="10"></td>
	</tr>

</table>
</form>

</div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
</body>
</html>