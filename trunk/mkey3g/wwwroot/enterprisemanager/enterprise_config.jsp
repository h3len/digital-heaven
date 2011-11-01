<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<jsp:directive.page import="com.dheaven.mip.util.DhServerNameUtils"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>系统设置</title>
    
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
		var linktype = "";
		var ssltype = "";
		var enterprise = '<%=request.getSession().getAttribute("enterpriseid")%>';
		var iscloud = '<%=DhServerNameUtils.isCloud%>';
		window.onload = function(){
			if((enterprise==""||enterprise==null)&&iscloud=="true"){
				document.getElementById("mode").style.display="none";
			}
			showlinkmode();
		}
		  function updatelinkmode(){
		  	if(document.getElementById("linkmode2").checked){
		  		linktype="https";
		  	}else{
		  		linktype="http";
		  	}
		  	if(document.getElementById("sslmode2").checked){
		 		ssltype="double";
		 	}else{
		 		ssltype="single";
		 	}
		  	EnterpriseAction.updateLinkMode(linktype,ssltype,{
		  		callback:function(){
		  			DHalert("服务器配置修改成功");
		  		},errorHandler:function(errotString,exception){
		  			DHalert("服务器配置修改失败，失败原因："+errorString);
		  		}
		  	});
		  }
		  function linkmodechange(){
		  	if(document.getElementById("linkmode1").checked){
		  		linktype="http";
		  		document.getElementById("sslhide").style.display="none";
		  	}
		  	if(document.getElementById("linkmode2").checked){
		  		linktype="https";
		  		document.getElementById("sslhide").style.display="";
		  	}
		  }
		  function showlinkmode(){
		  	EnterpriseAction.showLinkMode(
		  	{
				callback:function(data){
					if(data==null){
						document.getElementById("linkmode1").checked;
						document.getElementById("sslmode1").checked;
					}else{
						dwr.util.setValues(data);
						if(data.linkmode=="https"){
							document.getElementById("sslhide").style.display="";
						}
					}},errorHandler:function(errorString,exception){
						DHalert(errorString);
					}
		  	});
		  }
		  function sslmodechange(){
		 	if(document.getElementById("sslmode1").checked){
		  		ssltype="single";
		  	}
		  	if(document.getElementById("sslmode2").checked){
		  		ssltype="double";
		  	}
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
	<div id="center_nav">您现在所在位置 >> 系统设置 </div>
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
							服务器连接方式设置：
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
											<input type="radio" onclick="linkmodechange()" name="linkmode" id="linkmode1"  value="http" checked>HTTP</input>
											
										</td>							
									<td width = "79%">
											<input type="radio" onclick="linkmodechange()" name="linkmode" id="linkmode2" value="https">HTTPS</input>
									</td>
								</tr>
								</table>
												</fieldset>
											</td>
										</tr>
						<table id ="sslhide" width="60%" border="0" align="center" style="display:none">
						<tr>
							<td width="35%">
							SSL检验方式设置：
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
											<input type="radio" onclick="sslmodechange()" name="sslmode" id="sslmode1"  value="single" checked>单向</input>
											
										</td>							
									<td width = "79%">
											<input type="radio" onclick="sslmodechange()" name="sslmode" id="sslmode2" value="double" >双向</input>
									</td>
								</tr>
								</table>
							</fieldset>
							</td>
						</tr>
						</table>
						<table width="60%" align="center">
						<tr>
							<td colspan="5">
								<fieldset>
								<div class="center_nav_line"></div>
													<div class="div_center padding_5">
														<input name="submit" type="button" id="updatelinkmode"
															onClick="updatelinkmode()" value="提交" class="button_2"/>
													</div>

												</fieldset>
											</td>
										</tr>
									</table>
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