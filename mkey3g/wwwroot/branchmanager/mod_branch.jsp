<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_1 %></title>
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
//部门id
var bid = "<%=request.getParameter("bid") != null ? request.getParameter("bid") : ""%>";
//父部门id
var parentId = "<%=request.getParameter("parentid") != null ? request.getParameter("parentid") : ""%>";
 //得到企业id
var enterpriseid = "<%=request.getParameter("enterpriseid")!=null?request.getParameter("enterpriseid"):request.getSession().getAttribute("enterpriseid")%>";
 
		window.onload=function(){
		if(parentId==""||parentId==null||parentId==undefined){
          	parentId = enterpriseid ;
          }
		showBranchByid(bid);
		}
	function showBranchByid(bid){
	  	       //开始提交数据
  	 Progress("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_2 %>","<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_3 %>");
    BranchAction.showBranch(bid,
			 	function(data){
			 	CloseProgress();
			 		dwr.util.setEscapeHtml(false);
					dwr.util.setValues(data);
				}
			);	
	}
	
	
	//保存修改后部门信息
	function modbranch(){
			cf = new CheckForm();
			if($("branchname").value == "" ||$('branchname').value.replace(/\s/g,"")==""){
				DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_4 %>");
				return false;
			}
	
			if($("shortname").value == "" || $('shortname').value.replace(/\s/g,"")==""){
				DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_5 %>");
				return false;
			}
			if($('branchname').value.indexOf('<') > -1 || $('branchname').value.indexOf('>') > -1)
			{
				DHalert('<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_6 %>');
				return false;
			}
			if($('shortname').value.indexOf('<') > -1 || $('shortname').value.indexOf('>') > -1)
			{
				DHalert('<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_7 %>');
				return false;
			}				
		    if($("comment").value!=""&&$("comment").value.length>50){
	          DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_8 %>");
	          return;
	        }
        
	  	       //开始提交数据
  	 Progress("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_9 %>","<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_10 %>");
  	 dwr.util.setEscapeHtml(false);
    BranchAction.modBranch(bid,cf.Trim($("branchname").value),cf.Trim($("shortname").value),cf.Trim($("comment").value),enterpriseid,parentId,
			 	{
			 	   callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_11 %>");
											 parent.parent.closePage();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_12 %>"+otext);
										}
									},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_13 %>"+errorString);
					}
				}
			);	
	}
	
</script>
</head>
  
<body>
 	<div class="up_title"><span class="blue_14_bold"><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_14 %></span></div>
	<div class="up_subtitle" ><span class="blue_12_bold"><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_15 %></span></div>
	
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	 <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_16 %></span></td>
	 <td><input type="text" id="branchname" value="" maxlength="15"/>*</td>
	 </tr>
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_17 %></span></td>
	 <td><input type="text" id="shortname" value="" maxlength="10"/>*</td>
	 </tr>
	  <tr>
	 <td><span class="blue_12"><%= MipWebJSPUi.mipweb_branchmanager_mod_branch_18 %></span></td>
	 <td><textarea id="comment" cols="50" rows="8" ></textarea></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_branchmanager_mod_branch_19 %>" onclick="javascript:modbranch();"/> </td></tr>
	 </table>

  </body>
</html>
