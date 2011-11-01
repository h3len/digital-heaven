<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>邮箱绑定</title>
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
		<script src="../dwr/interface/MailConfig.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
   
   //得到企业id
 var enterpriseid = "<%=request.getParameter("enterpriseid") != null ? request
							.getParameter("enterpriseid")
							: request.getSession().getAttribute("enterpriseid")%>";
   //分页
 var pageid = "<%=request.getParameter("pageid") != null ? request
					.getParameter("pageid") : "1"%>";
 var showtype = 1;
 
   window.onload=function(){
    	//首先得到该企业下的所有用户
    	getuserbyenterpriseid(enterpriseid);
    }
    	
  
  
  		//首先得到该企业下的所有用户
  function getuserbyenterpriseid(enterpriseid){
  showtype = 1;
  	       //开始提交数据
  	 Progress("数据正在载入...","提示");
    MailConfig.getuserbyenterpriseid(enterpriseid,pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "xslt/admin_enterpriseuser_list.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);	
  
  	}
  	
 		 //页面跳转
		function ChangePage(id)
		{
			pageid = id;
			if(showtype == 1){
				getuserbyenterpriseid(enterpriseid);
			}else{
				serch(pageid);
			}
			
		}
	
	//转 到为企业用户配置邮箱页面
	function mailconfig(userid){
		GB_showCenter("邮箱配置", "../mail/admin_enterpriseuser_emailconfignew.jsp?userid="+userid,550,878);
	}
	
	function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
	}
	
	//按用户真实姓名快速定位（查询）
	function serch(pageid){
	 	var cf = new CheckForm();
	 	var truename = cf.Trim($('truename').value);
        var temp=cf.Trim($('searchtruename').value);
	 	if(pageid=='serch'){
	 		if(temp==''){
		 		SDHalert("请输入查询内容!",140);
				return;
	 		}else{
	 			pageid = 1;
	 		}
	 	}
   		if(truename!=''&&temp==''){
	 		$('searchtruename').value = truename ;
		}
		showtype = 2;
  	 	Progress("数据正在载入...","提示");
    	MailConfig.searchuserbytruename(enterpriseid,$('searchtruename').value,pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "xslt/admin_enterpriseuser_list.xsl",document.getElementById("divlist"));
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
			<div id="center_left" class="center_left">
			</div>
			<!-- 右侧例表内容 -->
			<div id="center_right">
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<div id="center_nav_box">
						<div id="center_nav">
							您现在所在位置 >> 移动邮件设置 >> 邮箱绑定
						</div>
					</div>
					<div class="center_list_box">
						<div class="center_list">
							<table width="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="3" class="gray bold">
										<span class="margin_left_10">用户邮箱绑定</span>
									</td>
									<td align="right">
										<img src="/theme/images/list_search.gif" width="18"
											height="18" />
										按用户真实姓名查询：
										<input type="text" id="searchtruename" />
										<input type="button" value="确定" class="button_2"
											onclick="javascript:serch('serch');" />
									</td>
								</tr>

								<tr>
									<td colspan="4">
										<div id="divlist"></div>
									</td>
								</tr>
							</table>
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
