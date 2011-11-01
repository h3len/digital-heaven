<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>top.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
else
{//权限
 	String uid = (String)request.getSession().getAttribute("user"); 	
 	if(!uid.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){
		PermissionServiceImpl ps = (PermissionServiceImpl)ServerConfig.beanFacotry.getBean("permissionServiceImpl");	
		if (ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail")==null)
		{
			out.print("<script>top.location.href='../default_admin.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
			return;
		}
		else
		{	
			java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,"mipmail");
			if(list == null || list.size() == 0)
			{
				out.print("<script>top.location.href='../default_admin.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
				return;
			}
		}
	}
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>修改UA信息</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<!-- Dwr Js -->
		<script src="../dwr/interface/MipDeviceUaAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
<script type="text/javascript">

var uaid = "<%=request.getParameter("uaid") != null ? request.getParameter("uaid") : ""%>";
var id = "<%=request.getParameter("id") != null ? request.getParameter("id") : ""%>";
window.onload=function(){
		showUAInfo(uaid,id);
		}
	function showUAInfo(uaid,id){
	  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
    MipDeviceUaAction.showUAInfo(uaid,id,{
					callback:function(oMap) {
						CloseProgress();
						DWRUtil.setValues(oMap);
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("操作失败，失败原因："+errorString);
					}
			});	
	}
	
	//保存修改后企业信息
	function modUAInfo(){
		cf = new CheckForm();
			if(cf.Trim($("gwuashort").value) == ""){
				DHalert("请输入短UA-GW！");
				return false;
			}

			if(cf.Trim($("gwualong").value) == ""){
				DHalert("请输入长UA-GW！");
				return false;
			}
			if(cf.Trim($("os_detail").value) == ""){
				DHalert("请输入操作系统！");
				return false;
			}
			if(cf.Trim($("screensize").value) == ""){
				DHalert("请输入分辨率！");
				return false;
			}
			
	  	       //开始提交数据
  	 		Progress("数据正在载入...","提示");
   			MipDeviceUaAction.modUAInfos(uaid,id,cf.Trim($("gwuashort").value),cf.Trim($("gwualong").value),cf.Trim($("os_detail").value),cf.Trim($("offname").value),cf.Trim($("screensize").value),
			 	cf.Trim($("type_name").value),cf.Trim($("weight").value),$("innermomery").value,cf.Trim($("extmemory").value),cf.Trim($("carner").value),cf.Trim($("network").value),
			 	cf.Trim($("blueteeth").value),cf.Trim($("player").value),cf.Trim($("htmlversion").value),cf.Trim($("wapversion").value),{
	 			callback:function(data){
			 	   if(data == "1"){
			 	   		CloseProgress();
			 	   		parent.parent.closePage(parent.parent.pageid);
			 	   	}else{
			 	   		DHalert(data);
						return false;
			 	   	}
				},
				 errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						    }
				});	
	}
	function cheLen(){
		var gwalong=${'gwualong'}.value;
		if(gwalong.length>200){
			DHalert("长GW-UA字符长度不能超过200字符！");
		}
	}
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold">UA信息管理</span></div>
	<div class="up_subtitle" ><span class="blue_12_bold">UA修改</span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td align="right"><span class="blue_12">短GW-UA：</span></td>
	 <td><input type="text" id="gwuashort" value="" class="input_text" maxlength="100"/>
	 *
	 </td>
	 </tr>
	 <tr>
	 <td align="right"><span class="blue_12">长GW-UA：</span></td>
	 <td><textarea id="gwualong" cols="40" rows="4" onblur="cheLen();"></textarea>*
	 </td>
	 </tr>
	  <tr>
	 <td align="right"><span class="blue_12">操作系统：</span></td>
	 <td><input type="text" id="os_detail" value="" class="input_text" maxlength="50"/>
	 </td>
	 </tr>
	 <tr>
	 <td align="right"><span class="blue_12">官网名称：</span></td>
	 <td><input type="text" id="offname" value="" class="input_text" maxlength="50"/>
	 </td>
	 </tr>
	 <tr >
	 <td align="right"><span class="blue_12">分辨率：</span></td>
	 <td><input type="text" class="input_text" id="screensize"  maxlength="20"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">型号：</span></td>
	 <td><input type="text" class="input_text" id="type_name"  maxlength="50"/>
	 <br/></td>
	 </tr>
	 <tr >
	 <td align="right"><span class="blue_12">质量：</span></td>
	 <td><input type="text" class="input_text" id="weight"  maxlength="50"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">机身内存：</span></td>
	 <td><input type="text" class="input_text" id="innermomery"  maxlength="50"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">扩展内存：</span></td>
	 <td><input type="text" class="input_text" id="extmemory"  maxlength="50"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">摄像头：</span></td>
	 <td><input type="text" class="input_text" id="carner"  maxlength="50"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">网络：</span></td>
	 <td><input type="text" class="input_text" id="network"  maxlength="50"/>
	 <br/></td>
	 </tr>
	  <tr >
	 <td align="right"><span class="blue_12">蓝牙：</span></td>
	 <td><input type="text" class="input_text" id="blueteeth"  maxlength="50"/>
	 <br/></td>
	 </tr>
	 	  <tr >
	 <td align="right"><span class="blue_12">系统播放器：</span></td>
	 <td><input type="text" class="input_text" id="player"  maxlength="50"/>
	 <br/></td>
	 </tr>
	 	  <tr >
	 <td align="right"><span class="blue_12">HTML版本：</span></td>
	 <td><input type="text" class="input_text" id="htmlversion"  maxlength="20"/>
	 <br/></td>
	 </tr>
	 	  <tr >
	 <td align="right"><span class="blue_12">WAP版本：</span></td>
	 <td><input type="text" class="input_text" id="wapversion"  maxlength="20"/>
	 <br/></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="提交" onclick="javascript:modUAInfo();"/> </td></tr>
	 </table>

  </body>
<script type="text/javascript">
inputEvent();
</script>
</html>
