<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils"/>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>
    <title>企业管理</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
   //EMOA，NMOA类型
   var mntype = "<%=DhServerNameUtils.Server_Name %>";

   //分页
 var pageid = "<%=request.getParameter("pageid") != null ? request.getParameter("pageid") : "1"%>";
   window.onload=function(){
    	//首先得到该企业下的所有用户
    	getallenterprise(pageid);
    	if(!<%=Constants.canoperateapp %>){
			document.getElementById("creatediv").style.display="none" ;
			document.getElementById("showcreateimage").style.display="none" ;
		}
    	}

 	 //判断 是否EMOA，还是NMOA
  function yntype(mntype){
		  if(mntype == "EMOA"){
		  document.getElementById("creatediv").style.display="none";
		  document.getElementById("showcreateimage").style.display="none";

		  	 }
		  if(mntype == "NMOA"){
		  document.getElementById("creatediv").style.display="";
		  document.getElementById("showcreateimage").style.display="";
		  	}
  	}
  	//
  function showenterprise(id){
  	GB_showCenter("企业详情", "../enterprisemanager/showclientapp.jsp?enterpriseid="+id,550,878);
  }

  		//首先得到所有企业
  function getallenterprise(pageid){
  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
  	 dwr.util.setEscapeHtml(false);
    EnterpriseAction.getRootBranchsPage(pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../enterprisemanager/xslt/admin_enterprisemanager.xsl",document.getElementById("divlist"));
		 			yntype(mntype);
		 			CloseProgress();
				}
			);

  	}
  	function regetallenterprise(pageid){
  	       //开始提交数据
  	 dwr.util.setEscapeHtml(false);
    EnterpriseAction.getRootBranchsPage(pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../enterprisemanager/xslt/admin_enterprisemanager.xsl",document.getElementById("divlist"));
		 			yntype(mntype);
		 			//CloseProgress();
				}
			);

  	}

 		 //页面跳转
		function ChangePage(id)
		{
			pageid = id;
			getallenterprise(pageid);
		}


	//修改页面
	function modenterprise(id){
			GB_showCenter("", "../enterprisemanager/mod_enterprise.jsp?eid="+id,460,460);
	}

		//删除页面
		function delenterprise(id){
						Ext.Msg.confirm(nowtitle, '确定删除吗？', function(btn){
							if(btn=='yes'){
								EnterpriseAction.delEnterpriseByid(id,{
									callback:function(data){
										if(data=="1")
											Ext.Msg.alert(nowtitle,"删除企业成功,请确认!",function(){getallenterprise(pageid);});
										else
											getallenterprise(pageid);
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("操作失败，失败原因："+errorString);
									}
								});
							}
				    	});
			}

	//查看页面
	function showenterprise(id){
		GB_showCenter("", "../enterprisemanager/showclientapp.jsp?enterpriseid="+id,450,878);
	}

	//新建企业
	function createenterprise(){
		GB_showCenter("", "../enterprisemanager/create_enterprise.jsp",460,460);
	}

	//关闭子页面
	function closePage(){
		regetallenterprise(pageid);
		GB_CURRENT.hide();
	}

		function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if
		(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
	}
	//
	function showapplimit(id){
		GB_showCenter("", "../enterprisemanager/create_app_limit.jsp?enterpriseid="+id+"&pageid="+pageid,500,600);
	}
	
	//
	//启用企业
		function enableEnterprise(id){
						Ext.Msg.confirm(nowtitle, '确定启用该企业吗？', function(btn){
							if(btn=='yes'){
								EnterpriseAction.enOrDisableEnterprise(id,"1",{
									callback:function(data){
										if(data=="1"){
											Ext.Msg.alert(nowtitle,"启用企业成功,请确认!",function(){getallenterprise(pageid);});
										}else{
											getallenterprise(pageid);
										}										
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("操作失败，失败原因："+errorString);
									}
								});
							}
				    	});
			}
			
		//停用企业
		function disableEnterprise(id){
						Ext.Msg.confirm(nowtitle, '确定停用该企业吗？', function(btn){
							if(btn=='yes'){
								EnterpriseAction.enOrDisableEnterprise(id,"0",{
									callback:function(data){
										if(data=="1"){
											Ext.Msg.alert(nowtitle,"停用企业成功,请确认!",function(){getallenterprise(pageid);});
										}else{
											getallenterprise(pageid);
										}										
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("操作失败，失败原因："+errorString);
									}
								});
							}
				    	});
			}
</script>
</head>
<body>
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
<!-- Main 页面中部 -->
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left"></div>
<!-- 右侧例表内容 -->
<div id="center_right">
	<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 系统管理 >> 企业管理</div>
</div>
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
			<table width="100%" height="30" border="0" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
									<td width="90%" class="gray_14_bold">
										<span>企业管理</span>
									</td>
									<td width="2%">
										<div id="showcreateimage">
											<img src="../theme/images/new.gif" />
										</div>
									</td>
									<td width="8%" align="left">
										<div id="creatediv">
											<span class="margin_right_5" /> <span class="hand"
												onclick="javascript:createenterprise();">创 建</span>
										</div>
									</td>
								</tr>
								<tr>
								<td colspan="3">
										<div id="divlist"></div>
								</td>
								</tr>
							</table>
			</div>
</div>
</div>
</div></div></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
</html>
