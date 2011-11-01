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
		
		var adminid = 0;
		
		
		window.onload = function(){
			
			adminid = '<%=request.getParameter("adminid")%>';
			getAdminUserById();
	  	
	    }

	    
		/**更新**/
		function updataAdminUser(){
		
		  	 if($('manager').value == ""){
		    
		      	 DHalert("管理员不能为空");
			     return;
		     }
   		  	 if($('username').value == ""){
		    
		      	 DHalert("用户名不能为空");
			     return;
		     }
			
			MipAdminUser.updateMipAdminUser(adminid,$('manager').value,$('username').value,{
			
              	callback:function(obj) {
               	parent.parent.closePage("修改用户成功。");
			   	},
			  	 errorHandler:function(errorString, exception) {
					 alert(exception.message);
			  	 }
			
			
			
			});
			
			
		
		}
		/**根据id,查询实体**/
		function getAdminUserById(){
			
			Progress("<%=MipWebMoreUi.mip_user_admin_logs_2%>");
			
			MipAdminUser.getMipAdminUserById(adminid,{
	   		
	    				callback:function(admin) {
						CloseProgress();
						document.getElementById("manager").value = admin.manager;
						document.getElementById("username").value = admin.username;
						

				
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("操作失败，失败原因："+errorString);
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
            <td width="19%" align="right"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="12%"> 管理员：</td>
            <td width="69%"><input name="Input" class="input_text" id="manager"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
              *</td>
          </tr>

          <tr>
            <td width="19%" align="right"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="12%">用户名：</td>
            <td width="69%" ><input name="Input2" class="input_text" id="username" onFocus="fEvent('focus',this)"
onblur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
              *</td>
          </tr>
        </table>
		<div class="div_center"><input type="button" class="button_2" value="修改" onClick="updataAdminUser()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	</body>
</html>
