<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_branchmanager_create_branch_1 %></title>
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
//得到父部门id
 var parentid = "<%=request.getParameter("parentid")!=null?request.getParameter("parentid"):request.getSession().getAttribute("enterpriseid")%>";
 //得到企业id
 var enterpriseid = "<%=request.getParameter("enterpriseid")!=null?request.getParameter("enterpriseid"):request.getSession().getAttribute("enterpriseid")%>";
  
  
	function createenterprise(){
			cf = new CheckForm();
			if($("enterpristname").value == "" ||$('enterpristname').value.replace(/\s/g,"")==""){
				DHalert("<%= MipWebJSPUi.mipweb_branchmanager_create_branch_2 %>");
				return false;
			}
	
			if($("shortname").value == "" || $('shortname').value.replace(/\s/g,"")==""){
				DHalert("<%= MipWebJSPUi.mipweb_branchmanager_create_branch_3 %>");
				return false;
			}
			if($('enterpristname').value.indexOf('<') > -1 || $('enterpristname').value.indexOf('>') > -1)
			{
				DHalert('<%= MipWebJSPUi.mipweb_branchmanager_create_branch_4 %>');
				return false;
			}
			if($('shortname').value.indexOf('<') > -1 || $('shortname').value.indexOf('>') > -1)
			{
				DHalert('<%= MipWebJSPUi.mipweb_branchmanager_create_branch_5 %>');
				return false;
			}
			//alert($("comment").value.length);
          if($("comment").value!=""&&$("comment").value.length>50){
          DHalert("<%= MipWebJSPUi.mipweb_branchmanager_create_branch_6 %>");
          return;
          }
          if(parentid==""||parentid==null||parentid==undefined){
          	parentid = enterpriseid ;
          }
	  	       //开始提交数据
    		BranchAction.createBranch(cf.Trim($("enterpristname").value),cf.Trim($("shortname").value),cf.Trim($("comment").value),parentid,enterpriseid,
			 	{
					callback:function(data){
				 	if(data == "1"){
				 		//DHalert("创建成功！");
			 			parent.parent.closePage();
				 	}else{
				 		DHalert(data);
				 	}
						
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_branchmanager_create_branch_7 %>"+errorString);
					}
				});	
	}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"><%= MipWebJSPUi.mipweb_branchmanager_create_branch_8 %></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"><%= MipWebJSPUi.mipweb_branchmanager_create_branch_9 %></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_create_branch_10 %></span></td>
	 <td><input maxlength="15" size="50" type="text" id="enterpristname" value="" class="input_text" />*<br/></td>
	 </tr>
	 
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_create_branch_11 %></span></td>
	 <td><input maxlength="10" size="50" type="text" id="shortname" value="" class="input_text" />*<br/></td>
	 </tr>
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_create_branch_12 %></span></td>
	 <td><textarea id="comment" cols="50" rows="8" ></textarea></td>
	 </tr>
	 <tr><td></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_branchmanager_create_branch_13 %>" onclick="javascript:createenterprise();"/> </td></tr>
	 </table>

  </body>
</html>
