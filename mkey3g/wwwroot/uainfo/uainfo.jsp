<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out.print("<script>top.location.href='../default.jsp?url="
				+ request.getServletPath() + "?"
				+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");
		if (!uid
				.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)) {
			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
					.getBean("permissionServiceImpl");
			if (ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmail") == null) {
				out
						.print("<script>top.location.href='../default_admin.jsp?url="
								+ request.getServletPath()
								+ "?"
								+ request.getQueryString()
								+ "'</script>");
				return;
			} else {
				java.util.List list = ps
						.findUserPrivacyByUserIDAndCategoryID(uid,
								"mipmail");
				if (list == null || list.size() == 0) {
					out
							.print("<script>top.location.href='../default_admin.jsp?url="
									+ request.getServletPath()
									+ "?"
									+ request.getQueryString()
									+ "'</script>");
					return;
				}
			}
		}
	}
%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils" />

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>UA信息管理</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/MipDeviceUaAction.js"
			type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
   //EMOA，NMOA类型
   var mntype = "<%=DhServerNameUtils.Server_Name%>";

   //分页
 var pageid = "<%=request.getParameter("pageid") != null ? request
					.getParameter("pageid") : "1"%>";
   window.onload=function(){
    	//首先得到所有UA信息
    	getalluainfo(pageid);
   }

  //首先得到所有UA信息
  function getalluainfo(pageid){
  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
  	 dwr.util.setEscapeHtml(false);
    MipDeviceUaAction.getAllDeviceUaInfo(pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../uainfo/xslt/uainfo.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);
  	}
  	function regetalluainfo(pageid){
  	//开始提交数据
  		dwr.util.setEscapeHtml(false);
    	MipDeviceUaAction.getAllDeviceUaInfo(pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../uainfo/xslt/uainfo.xsl",document.getElementById("divlist"));
				}
			);

  	}

 		 //页面跳转
	function ChangePage(id)
	{
		pageid = id;
		getalluainfo(pageid);
	}


	//修改页面
	function moduainfo(uaid,id){
			GB_showCenter("", "../uainfo/mod_uainfo.jsp?uaid="+uaid+"&id="+id,500,600);
	}


	//删除页面
	function deleteuainfo(uaid,id){
			Ext.Msg.confirm(nowtitle, '确定删除吗？', function(btn){
				if(btn=='yes'){
					MipDeviceUaAction.delUAInfoByid(uaid,id,{
						callback:function(data){
							if(data=="1")
								Ext.Msg.alert(nowtitle,"删除UA信息成功!",function(){getalluainfo(pageid);});
							else
								getalluainfo(pageid);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						}
					});
				}
	    	});
	}

	//查看UA详情页面
	function showuainfo(id){
		GB_showCenter("", "../uainfo/show_uainfo.jsp?uaid="+id,450,600);
	}

	//导入UA信息
	function importuainfo(){
			GB_showCenter("", "../uainfo/improt_ua.jsp",400,678);
	}

	//关闭子页面
	function closePage(){
		regetalluainfo(pageid);
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
		
		//查询
		function searchuainfo()
		{
			Progress("数据正在载入...","提示");
  	 		dwr.util.setEscapeHtml(false);
    		MipDeviceUaAction.searchUaInfo($('type_name').value,$('os_detail').value,pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../uainfo/xslt/uainfo.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);
		}
</script>
	</head>
	<body>
		<!--Bottom Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
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
						<div id="center_nav">
							您现在所在位置 >> 系统管理 >> UA信息管理
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<table width="100%" height="30" border="0" align="center"
									cellpadding="0" cellspacing="0">
									<tr>
										<td width="90%" class="gray_14_bold">
											<span>UA信息管理</span>
										</td>
										<td width="2%">
											<div id="showcreateimage">
												<img src="../theme/images/new.gif" />
											</div>
										</td>
										<td width="8%" align="left">
											<div id="creatediv">
												<input type="button" value="导 入" class="button_2" onclick="javascript:importuainfo();" />
												<br/>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="3" align="right">
											型号：<input type="text" id="type_name">
											操作系统：<input type="text" id="os_detail">
											<input type="button" value="查询" class="button_2" onclick="javascript:searchuainfo()" />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
				</div>
			</div>
		</div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
