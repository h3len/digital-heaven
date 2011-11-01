<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_user_mod_group_1 %></title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
				<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
<script type="text/javascript">
//企业id
var bid = "<%=request.getParameter("bid") != null ? request.getParameter("bid") : ""%>";
		window.onload=function(){
		showBranchByid(bid);
		}
	function showBranchByid(bid){
	  	       //开始提交数据
  	 Progress("<%= MipWebJSPUi.mipweb_user_mod_group_2 %>","<%= MipWebJSPUi.mipweb_user_mod_group_3 %>");
    BranchAction.showGroup(bid,{
    
    			callback:function(data){
					CloseProgress();
					dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);    
				},
				errorHandler:function(errorString,exception){
					DHalert("<%= MipWebJSPUi.mipweb_user_mod_group_4 %>"+exception.message);
				}
			 	
			});	
	}
	
	//保存修改后企业信息
	function modbranch(){
				if($("enterpristname").value == ""){
				DHalert("<%= MipWebJSPUi.mipweb_user_mod_group_5 %>");
				return false;
			}
			if($("comment").value.length>50){
						DHalert("<%= MipWebJSPUi.mipweb_user_mod_group_6 %>");
						return false;
					}
			
			
	  	       //开始提交数据
  	 Progress("<%= MipWebJSPUi.mipweb_user_mod_group_7 %>","<%= MipWebJSPUi.mipweb_user_mod_group_8 %>");
    BranchAction.modgroup(bid,$("enterpristname").value,$("comment").value,'<%=session.getAttribute("enterpriseid")%>',
    
    
    			{
    
    			callback:function(data){
					if(data == "1"){
				 	   CloseProgress();
			 		   parent.parent.closePage();
			 	   	}else{
			 	   		DHalert(data);
						return false;
	 	   			}
				},
				errorHandler:function(errorString,exception){
					DHalert("<%= MipWebJSPUi.mipweb_user_mod_group_9 %>"+exception.message);
				}
			 	
				}
			);	
	}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"><%= MipWebJSPUi.mipweb_user_mod_group_10 %></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"><%= MipWebJSPUi.mipweb_user_mod_group_11 %></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_user_mod_group_12 %></span></td>
	 <td><input maxlength="20" type="text" id="enterpristname" value="" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/></td>
	 </tr>
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_user_mod_group_13 %></span></td>
	 <td><textarea id="comment" cols="50" rows="8" ></textarea></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_mod_group_14 %>" onclick="javascript:modbranch();"/> </td></tr>
	 </table>

  </body>
</html>
