<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	out.print("<script>parent.parent.GB_CURRENT.hide()</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipservermanage")==null)
		{
			out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			out.print("<script>parent.parent.GB_CURRENT.hide()</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipservermanage");
			if(list == null || list.size() == 0)
			{
				out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				out.print("<script>parent.parent.GB_CURRENT.hide()</script>");
				return;
			}
		}
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>黑白名单：添加新用户</title>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<script type="text/javascript">
    			var GB_ROOT_DIR = "../skin/";
		</script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/MipBlackWhiteAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
var type='<%=request.getParameter("type")%>';

window.onload=function(){
		DHTabPanel(ab,900,0,"tabs");
		if(type=='0'){
			$("checkboxid").style.display="none";
			$("promptspan").innerHTML="提示：导入文件从第一列开始依次为【匹配类型】【匹配内容】。";
		}else{
		<%if(DhServerNameUtils.isEMAS){%>
			$("checkboxid").style.display="none";
		<%}else{%>
		  $("checkboxid").style.display="";
		<%}%>
		 $("promptspan").innerHTML="提示：导入文件从第一列开始依次为【匹配类型】【匹配内容】，类型为“匹配号码”，内容为“手机号”。";
		}
	} 
var ab=[[toinlist,'导入名单'],[tooutlist,'导出名单']];
function toinlist(){
	$("inlist").style.display="";
	$("outlist").style.display="none";
}
function tooutlist(){
	$("inlist").style.display="none";
	$("outlist").style.display="";	
	if(type==0){
		$("radioid").style.display="none";
	}else{
		<%if(DhServerNameUtils.isEMAS){%>
			$("radioid").style.display="none";
		<%}else{%>
		 $("radioid").style.display="";
		<%}%>
		$("exportspan").innerHTML="提示：导出的内容为已生效的白名单。";
	}
}
	 	//根据类型导出名单
       	function exportdoc(){
       			var servicetype = "";
       		 if($('oard').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mailrd').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('baserd').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('togetherrd').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integationrd').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('otherrd').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
       		window.location.href="../exportblackwhite.do?action=exportExcel&type="+type+"&servicetype="+servicetype;
       	}
       	function exportexample(){
       		window.location.href="../exportblackwhite.do?action=exportExample&type="+type;
       	}
		//导入文件
	  function upload(){
	       		if(document.getElementById("impexcel").checked==true){
		       		document.getElementById('ftype').value="excel";
	       		}
	       		/*
	       		if(document.getElementById("imptxt").checked==true){
		       		document.getElementById('ftype').value="txt";
	       		}
	       		*/
				var file=document.getElementById('file').value;
				if($('file').value == ''){
					DHalert("导入文件不能为空！");
					return ;
				}
				var file_type=file.substring(file.lastIndexOf(".")+1);
				if(document.getElementById("impexcel").checked==true){
					if(file_type.toLowerCase()!="xls"&&file_type.toLowerCase()!="xlsx"){
						DHalert('文件格式不对，请确认');
						return;
					}	
				}
				/*
				if(document.getElementById("imptxt").checked==true){
					if(file_type!="txt"){
						DHalert('文件格式不对，请确认');
						return;
					}	
				}
				*/
				if(!$('oa').checked&&!$('mail').checked&&!$('base').checked&&!$('together').checked&&!$('integation').checked&&!$('other').checked){
					DHalert('请选择业务类型！');
						return;
				}
				var servicetype ="";
				 if($('oa').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mail').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('base').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('together').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integation').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('other').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
				 //alert(servicetype);
			$("form2").action+="?type="+type+"&servicetype="+servicetype;
			document.getElementById('form2').submit();
			document.getElementById('BtnOK').disabled = true;
	}
</script>
	</head>
	<body>
		<div id="tabs"></div>
		<table id="outlist" style="display: none" width="100%" border="0"
			align="center" cellpadding="0" cellspacing="5">
			<tr id="radioid">
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="26%">
							业务类型：
						</td>
						<td>
							<input type="checkbox" id="oard" name="servicetypenamerd" checked="checked" />
							办公版
							<input type="checkbox" id="mailrd" name="servicetypenamerd"/>
							邮件版
							<input type="checkbox" id="baserd" name="servicetypenamerd" />
							基础版
							<input type="checkbox" id="togetherrd" name="servicetypenamerd" />
							协同通信版
							<input type="checkbox" id="integationrd" name="servicetypenamerd" />
							集成版
							<input type="checkbox" id="otherrd" name="servicetypenamerd" />
							其他
						<td>
					</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					导出类型：
				</td>
				<td  >
					<input type="radio" id="expexcel" name="exptype" checked="checked" />
					EXCEL格式 &nbsp;&nbsp;&nbsp;&nbsp;
					<!-- 
					<input type="radio" id="exptxt" name="exptype" />
					txt格式
					 -->
				</td>
	
			</tr> 
			<tr>
						<td colspan="3">
							<div id="export">
									<span style="color:#ff0000" id="exportspan"></span>
							</div>
						</td>
					</tr>
			<tr>
				<td colspan="2" align="center"></td>
				<td colspan="71%" align="left">
					<input name="button" class="button_5" type="button"
						onclick="exportdoc()" value="导出名单" size="10" />
				</td>
			</tr>
		</table>

		<div id="inlist" style="display: none">
			<form id="form2" method="post" action="../blackwhiteimportupload.do"
				enctype="multipart/form-data">
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="5">
					<tr>
						<td colspan="26%" style="display: none">
							<font color="#ff0000"> 提示：导入文本文件之前需要对文件进行UTF-8编码</font>
						</td>
					</tr>
					<tr id="checkboxid">
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="26%">
							业务类型：
						</td>
						<td >
							<input type="checkbox" id="oa" name="servicetypename" checked="checked" />
							办公版
							<input type="checkbox" id="mail" name="servicetypename"/>
							邮件版
							<input type="checkbox" id="base" name="servicetypename"/>
							基础版
							<input type="checkbox" id="together" name="servicetypename"/>
							协同通信版
							<input type="checkbox" id="integation" name="servicetypename"/>
							集成版
							<input type="checkbox" id="other" name="servicetypename"/>
							其他
						<td>
					</tr>
					<tr>
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="26%">
							导入类型：
						</td>
						<td  >
							<input type="radio" id="impexcel" name="filetype" checked="true" />
							EXCEL格式
							<a id="example" href="#" onclick="exportexample()"
								class="blue_12">示例</a> &nbsp;&nbsp;&nbsp;&nbsp;
							<!-- 
							<input type="radio" id="imptxt" name="filetype" />
							txt格式
							<a id="example" href="#" onclick="forexample('csv')"
								class="blue_12">示例</a>
							 -->
						</td>
					</tr>
					<tr>
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="10%">
							上传文件
						</td>
						<td width="81%">
							<input id="file" onpaste="return   false"
								onkeydown="return   false" type="file" name="file"
								style="width: 300px;" />
							<input id="ftype" name="ftype" type="hidden" />
							<input id="uploadtype" name="uploadtype" type="hidden"
								value="personnel" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="prompt">
									<span style="color:#ff0000" id="promptspan"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							<input name="button" type="button" id="BtnOK"
								onclick="javascript:upload();" class="button_5" value="导入名单" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button style="display: none" class="button_4"
								onclick="parent.parent.GB_CURRENT.hide()">
								取消上传
							</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>