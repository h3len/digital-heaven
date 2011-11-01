<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>管理员管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link href="../datepicker/default/datepicker.css" rel="stylesheet"
			type="text/css">
		<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet"
			type="text/css" disabled="disabled">
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="../datepicker/WdatePicker.js"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript">
		var GB_ROOT_DIR = "../skin/";
	</script>
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/archievelib.js"></script>
		<!-- 新的时间控件 -->
		<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="../skin/calendar/lang/calendar-zh.js"></script>
		<link href="../skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="../skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="../skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipAdminUser.js" type="text/javascript"></script>
		<script type="text/javascript">
		
		var pageid;
		
		window.onload = function(){
		
			pageid = 1;
			
	  	  getAllAdmin();
	    }
	    
    	/**分页调用**/
		function ChangePage(id){
	
			pageid = id;
			getAllAdmin();
	
		}
	    
	    function getAllAdmin(){
	    		    
	    	MipAdminUser.getAllMipAdminUser(pageid,"",{
		    		callback:function(objXml) {
					DisplayTransformedXML(1, objXml, "xslt/show_permission_list.xsl",document.getElementById("divList"));
					CloseProgress();
	    	
	    			},
	    		
					errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
	    	
	    	});
	    
	    }
	    
	    
	   /**删除一个管理员的操作**/
	   function delAdminUser(adminid){
	   
	   		MipAdminUser.deleteMipAdminUser(adminid,{
	   		
               callback:function(obj) {
               DHalert("删除用户成功！");
               getAllAdmin();
			   },
			   errorHandler:function(errorString, exception) {
				alert(exception.message);
			   }
	   		
	   		
	   		});

	   
	   }
	   
	   /**更新**/
   		function updataAdminUser(adminid){
   			
			GB_showCenter("", "../permission/updateAdminUser.jsp?adminid="+adminid,300,450);
 		}
 		
	   	/**添加**/
   		function addAdminUser(){
   			
			GB_showCenter("", "../permission/addAdminUser.jsp",300,450);
 		}
 		
 		/****/
		function closePage(str){
		  
		   GB_CURRENT.hide();
		   pageid=1;
		   getAllAdmin();
		}
		
		/****/
		function CZ(eid){
			
			Ext.Msg.confirm("系统信息" ,"确定为<span style='color:red' >"+$('inputrealname'+eid).value +"</span>重置密码？", function(btn){
				if(btn=='yes'){
							
	
							MipAdminUser.resetPassword(eid,{
	   		
						               callback:function(obj) {
						               DHalert("密码已重置为初始密码！！");
						               
									   },
									   errorHandler:function(errorString, exception) {
										alert(exception.message);
									   }
								   
								}
							);
				 	}
				});
				
			}
			
		


	  
		</script>


	</head>
<body>
<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true" />
<!--Top Include-->
<div id="center">

<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left">
 
			
</div>


<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main" class="border_blue">
	

<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 系统管理 >> 管理员管理 </div>
</div>
	<div>
	<div  style="float:right">
		<input type="button" class="button_4" value="新增管理员"  onclick="addAdminUser()" />
	</div>		
</div>
<div id="divlist"></div>

  </div>
</div>
</div>

		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
