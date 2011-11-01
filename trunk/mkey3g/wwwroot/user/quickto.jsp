<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<%@page import="com.dheaven.mip.util.PermissionHelper"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipUserPrivacy"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils" %>



<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    <title>快捷键设置-<%=ServerConfig.ALL_PAGE_TITLE %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css">
	<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled">
	<!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />				
	<script language="javascript" type="text/javascript" src="../datepicker/WdatePicker.js"></script>		
	<script src="../dwr/interface/Mas2.js" type="text/javascript"></script>
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
<script type="text/javascript" src="../skin/calendar/lang/calendar-zh.js"></script>
<link href="../skin/calendar/css/zpcal.css" rel="stylesheet" type="text/css" />
<link href="../skin/calendar/website/css/template.css" rel="stylesheet" type="text/css" />
<link href="../skin/calendar/themes/winxp.css" rel="stylesheet" type="text/css" />
<!-- Dwr Js -->
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>	
	<script type="text/javascript">
var quickNum=5;
function checkall(){
	if($('selall').checked){
		for(var i=0;i<quickNum;i++){
			$('quick_'+i).checked=true;
		}
	}else{
		for(var i=0;i<quickNum;i++){
			$('quick_'+i).checked=false;
		}
	}
}
function checkone(){
	var allcheck=true;
	for(var i=0;i<quickNum;i++){
		if(!$('quick_'+i).checked){
			allcheck=false;
		}	
	}
	if(allcheck){
		$('selall').checked=true;
	}else{
		$('selall').checked=false;
	}
}
//关闭左侧菜单 by Gaojingliang

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
	function getQuickto(){
	 	Progress('正在取得现有快捷键设置....','快捷键设置');
		User2.getQuickToMap({
			callback:function(objXml) {
					dwr.util.setValues(objXml);
					checkone();
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("快捷键获取失败！失败原因："+errorString);
				}
		});
	}
	window.onload=function(){
		if(<%=DhServerNameUtils.isEMAS%>){
			quickNum=4;
		}
		getQuickto();
	}
	function setqucikto(){
		Progress('正在设置快捷键....','快捷键设置');
		var quickto="";
		for(var i=0;i<quickNum;i++){
			if($('quick_'+i).checked){
				quickto=quickto+","+i;
			}	
		}
		if(quickto.indexOf(",")==0){
		 	quickto = quickto.substring(1);
	    }
	    User2.setQuickTo(quickto,{
	    		callback:function(objXml) {
					CloseProgress();
					if(objXml==1){
						DHalert("快捷键设置成功！");
					}else{
						DHalert("快捷键设置失败！失败原因："+objXml);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("快捷键设置失败！失败原因："+errorString);
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
<!--Strat center_left_tree-->
<div id="center_left_tree">
</div>
</div>


<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
	
<!-- 中部主要内容开始 -->
<table style="display:none" width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/theme/images/alert_bg.gif">
  <tr>
    <td width="1%"><img src="/theme/images/alert_left.gif" width="5" height="29" /></td>
    <td width="2%"><img src="/theme/images/alert_bug.gif"></td>
    <td width="90%"><a href="../minioa/admin_default.jsp">您有<span class="red" id="oatodo">0</span>篇公文待处理</a></td>
    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="/theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
  </tr>
</table>
<!-- center_nav 路径导航 -->
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 系统设置 >> 首页设置 <span class="red"> 注：快捷键设置将于下次登录生效 </span></div>
</div>

<div class="border_blue margin_top_5">
<table width="100%" border="0" cellspacing="0"
				cellpadding="0">
				<tr>
					<td width="10%" class="list_title_bg">
						<div align="center">
							<input type="checkbox" id="selall"
								onclick="checkall()" title="全选/不选" />
						</div>
					</td>
					<td width="40%" class="list_title_bg"></td>
					
					<td width="30%" class="list_title_bg">模块名</td>
				</tr>
				<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 style="cursor:pointer;">
					<td width="10%">
						<div align="center">
							<input type="checkbox" id="quick_0"
								onclick="checkone()" />
						</div>
					</td>
					<td width="40%"></td>		
					<td width="30%">待办公文</td>
				</tr>
				<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 style="cursor:pointer;">
					<td width="10%">
						<div align="center">
							<input type="checkbox" id="quick_1"
								onclick="checkone()" />
						</div>
					</td>
					<td width="40%"></td>		
					<td width="30%">发送短信</td>
				</tr>
			<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 style="cursor:pointer;">
					<td width="10%">
						<div align="center">
							<input type="checkbox" id="quick_2"
								onclick="checkone()" />
						</div>
					</td>
					<td width="40%"></td>		
					<td width="30%">公告</td>
				</tr>
				<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 style="cursor:pointer;">
					<td width="10%">
						<div align="center">
							<input type="checkbox" id="quick_3"
								onclick="checkone()" />
						</div>
					</td>
					<td width="40%"></td>		
					<td width="30%">单位通讯录</td>
				</tr>
		 	<%if(!DhServerNameUtils.isEMAS){ %>
				<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 style="cursor:pointer;">
					<td width="10%">
						<div align="center">
							<input type="checkbox" id="quick_4"
								onclick="checkone()" />
						</div>
					</td>
					<td width="40%"></td>		
					<td width="30%">差旅服务</td>
				</tr>
				<%} %>
</table>
<div class="text_align_center padding_5"><input class="button_2" type="button" value="确 认" onclick="setqucikto()"/></div>
</div>

  </div>
</div>

		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>