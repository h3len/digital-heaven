<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils"/>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>企业管理测试系统同步地址</title>
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
		window.onload = function(){
			showsynaddress();
		}
		function showsynaddress(){
			EnterpriseAction.showSynAddress(
				function(data){
					dwr.util.setValues(data);
				}
			);
		}
		 function savesynaddress(){
		 	var cf = new CheckForm();
		 	if(cf.Trim($("synaddress").value)==""){
		 		DHalert("请输入同步地址！");
			       return;
		 	}
		 	EnterpriseAction.saveSynAddress(cf.Trim($("synaddress").value),{
		 		callback:function(data) {
		 			if(data=="1"){
		 				DHalert("保存同步地址成功！");
		 			}
		 		},
				errorHandler:function(errorString, exception) {
				    DHalert("保存同步地址失败，失败原因："+errorString);
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
	<div id="center_nav">您现在所在位置 >> 测试系统同步地址配置 </div>
</div>	
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
				<input type="hidden" id="updateenable"/>
				<div>
					<table width="60%" border="0" align="center" cellpadding="0"
						cellspacing="5">
						<tr>
							<td width="35%">
							同步地址配置
							</td>
							<td width="65%"></td>
							</tr>
						<tr>
							<td colspan="5">
								<fieldset>
			<table width="80%" height="30" border="0" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="3" class="text_icon2">
											<span class="href_14px_blue">同步地址:</span>
											
										</td>							
									<td width = "79%">
										<input type="text" id="synaddress" class="input_text" maxlength="50"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" size="9" style="width:350px;height:18px"/>
									</td>
								</tr>
								</table>
								<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input type="button" class="button_2" value="保存" onclick="savesynaddress();"/> 
													</div>

												</fieldset>
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
