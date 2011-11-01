<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.config.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE%></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../scripts/transferxml.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipUserStatisticsAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
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
			
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script language="JavaScript">
 		//接入应用统计分页ID
   		var pageid =1;
   		//新增接入应用数统计分页ID
   		var newAccessPageID=1;
   		var ab=[[accessApps,'接入应用总数'],[newAccessApps,'新增接入应用']];
        window.onload=function(){
        	DHTabPanel(ab,900,0,"tabs");
        }
        
        
        
            function accessApps(){
            
		 	now_type=0;
		 	$("new_registeredUsers_search").style.display="none";
		 	$("registeredUsers_search").style.display="";
		 	getAccessApps();
	 	}
	 	
		 function newAccessApps(){
		 
		 	$("starttime").value="";
		 	$("endtime").value="";
		 	$("registeredUsers_search").style.display="none";
		 	$("new_registeredUsers_search").style.display="block";
		 	now_type=1;
		 	getNewAccessApps();
		 } 
		 
		 
		 function getAccessApps(){
		
		 	Progress("正在读取数据....");
	
		 MipUserStatisticsAction.getAccessAppsPage(pageid,$("enterpristname").value,{
						callback:function(objXml) {
						
				                DisplayTransformedXML(1, objXml, "xslt/accessApp_list.xsl",document.getElementById("divList"));
								CloseProgress();
							},
						errorHandler:function(errorString, exception) {
								CloseProgress();
								
								DHalert("操作失败！失败原因:"+exception.message);		
							}
				});
		 }
		 
		 
		 
		 
		 
		function getNewAccessApps()
		{
	
				if($("starttime").value.trim() == "" && $("endtime").value.trim() != "")
			    {
			      DHalert("起始时间不能为空！");
			     return;
			     }
			     if($('endtime').value.trim() == "" && $("starttime").value.trim() != "")
			    {
			      DHalert("结束时间不能为空！");
			     	return;
			     }
				Progress("正在读取数据....");
				MipUserStatisticsAction.getNewAccessAppsPage(newAccessPageID,${"new_enterpristname"}.value,$("starttime").value,$("endtime").value,{
						callback:	function(objXml) {
						
							DisplayTransformedXML(1, objXml, "xslt/newuser_statistics_list.xsl",document.getElementById("divList"));
								CloseProgress();
							},
						errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert(exception.message);		
							}
				})
		}
		
		
	   //接入应用分页切换
	   function changePage(pid){
	   
	   pageid=pid;
	   getAccessApps();
	   
	   }
	   //新增接入应用分页切换
	   function changeNewRegisterPage(pid){
	   	newAccessPageID=pid;
        getNewAccessApps();
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
	
	function shows(id,starttime,endtime,num,name){
		GB_showCenter("新增应用列表", "../statistics/apps_list.jsp?id="+id+"&starttime="+starttime+"&endtime="+endtime+"&num="+num+"&name="+encodeURIComponent(name),450,640);	   
	}

</script>
	</head>

	<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!--Top Include-->
		<div id="center">
			<div id="center_left" class="center_left">
				<!--Strat center_left_tree-->
				<div id="center_left_tree">
					<div id="center_left_tree_top"></div>
					<div id="center_left_tree_bg">
					</div>
					<div id="center_left_tree_bom"></div>
				</div>
			</div>

			<div id="center_right">
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<!-- 中部主要内容开始 -->

					<div id="center_nav_box">
						<div id="center_nav">
							您现在所在位置 >> 系统维护>> 接入应用统计
						</div>
					</div>
							<div id="tabs" style="border: 1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<div class="center_list">
								<table class="margin_left_5" id="registeredUsers_search">
									<tr>
										<td >
											企业名称:
											<input type="text" id="enterpristname" maxlength="50"/>
										</td>

										<td colspan="2" align="center" height="25">

											<input type="image"
												onclick="javascript:changePage(1);" value="查询"
												src="../skin/default/images/button_search.gif" />
										</td>
									</tr>
								</table>
								<table class="margin_left_5" id="new_registeredUsers_search">
									<tr>
										<td >
											企业名称:
											<input type="text" id="new_enterpristname" maxlength="50"/>
										</td>
										<td>
											起始时间:
											<input name="starttime" id="starttime" type="text" />
											<img alt='起始时间'
												src='../skin/calendar/themes/icons/calendar2.gif' border='0'
												id='start' onMouseOver="this.style.cursor='pointer'"
												onmouseout="this.style.cursor='default'" />
											<script type="text/javascript">
													var cal1 = new Zapatec.Calendar.setup({
													
													inputField     :    "starttime",     // id of the input field
													singleClick    :     false,     // require two clicks to submit
													ifFormat       :    '%Y-%m-%d',     // format of the input field
													showsTime      :     true,     // show time as well as date
													button         :    "start"  // trigger button 
											
													});
											</script>
										</td>
										<td>
											结束时间:
											<input name="endtime" id="endtime" type="text" />
											<img alt='结束时间'
												src='../skin/calendar/themes/icons/calendar2.gif' border='0'
												id='end' onMouseOver="this.style.cursor='pointer'"
												onmouseout="this.style.cursor='default'" />

											<script type="text/javascript">
												var cal2 = new Zapatec.Calendar.setup({
												
												inputField     :    "endtime",     // id of the input field
												singleClick    :     false,     // require two clicks to submit
												ifFormat       :    '%Y-%m-%d',     // format of the input field
												showsTime      :     true,     // show time as well as date
												button         :    "end"  // trigger button 
												});
											</script>
										</td>
										<td align="center" height="25">

											<input type="image"
												onclick="javascript:changeNewRegisterPage(1);" value="查询"
												src="../skin/default/images/button_search.gif" />
										</td>
									</tr>
								</table>
								<div id="divList"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>