<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    	var GB_ROOT_DIR = "../skin/";
</script>
	
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 	<script type="text/javascript" src="../scripts/common.js"></script>
		<script src="../dwr/interface/MipAdminUser.js" type="text/javascript"></script>
		
		<script type="text/javascript">
		
		/**添加**/
		function addAdminUser(){
		
		  	 if($('manager').value == ""){
		    
		      	 DHalert("管理员不能为空");
			     return;
		     }
   		  	 if($('username').value == ""){
		    
		      	 DHalert("用户名不能为空");
			     return;
		     }
		     if($('manager').value=="mipadmin"||$('manager').value=="admin"){
		     
   		      	 DHalert("管理员名称不能为mipadmin或admin");
			     return;
		     }
   		     if($('username').value=="mipadmin"||$('username').value=="admin"){
		     
   		      	 DHalert("名称不能为mipadmin或admin");
			     return;
		     }
			
			MipAdminUser.addMipAdminUser($('manager').value,$('password').value,$('username').value,{
			
               callback:function(obj) {
               parent.parent.closePage("新建用户成功。");
			   },
			   errorHandler:function(errorString, exception) {
				 alert(exception.message);
			   }
			
			
			});

		}
		






		</script>
	</head>
	<body scroll="no" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">角色信息</span>
		</div>
		<div class="up_subtitle">
			<span>角色基本信息：</span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="19%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td colspan="2" style="color:red">
					管理员初始密码为123456，请登录后修改
				</td>
			</tr>
			<tr>
				<td width="19%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="12%">
					管理员：</td>
			  <td width="69%">
					<input id="manager" class="input_text" onMouseOver="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
			  *</td>
			</tr>
			<tr style="display:none;">
				<td width="19%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="12%">密码：</td>
				<td width="69%" ><input  value="123456" name="Input" class="input_text" id="password" onFocus="fEvent('focus',this)"
onblur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
		      *</td>
			</tr>
			<tr>
				<td width="19%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="12%">用户名：</td>
			  <td width="69%" ><input name="Input2" class="input_text" id="username" onFocus="fEvent('focus',this)"
onblur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
		      *</td>
			</tr>
			
		</table>
		<div class="div_center"><input type="button" class="button_2" value="添加" onClick="addAdminUser()"/> &nbsp;&nbsp;&nbsp;&nbsp;
	
	</body>
</html>
