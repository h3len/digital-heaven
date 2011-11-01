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
		<script type="text/javascript" src="../scripts/dh.js"></script>
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
 		//公共变量
   		var pageid =1;
   		
        window.onload=function(){
        	getNewRegisteredEnterprist();
        }
        
		function getNewRegisteredEnterprist()
		{
				if($("starttime").value.trim() == "" && $("endtime").value.trim() != "")
			    {
			      DHalert("起始时间不能为空！");
			      return;
			     }
			     if(!IsValidDate($("starttime").value)){
			     	DHalert("起始时间格式不正确！");
			        return;
			     }
			     if($('endtime').value.trim() == "" && $("starttime").value.trim() != "")
			    {
			      DHalert("结束时间不能为空！");
			     	return;
			     }
			     if(!IsValidDate($("endtime").value)){
			     	DHalert("结束时间格式不正确！");
			        return;
			     }
				Progress("正在读取数据....");
				MipUserStatisticsAction.getNewRegisteredEnterpristPage(pageid,$("starttime").value,$("endtime").value,{
						callback:	function(objXml) {
						
						 DisplayTransformedXML(1, objXml, "xslt/newenterprise_statistics_list.xsl",document.getElementById("divList"));
								CloseProgress();
							},
						errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert(exception.message);		
							}
				})
		}
	   
	   function ChangePage(pid){
	   	pageid=pid;
        getNewRegisteredEnterprist();
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
							您现在所在位置 >> 系统维护>> 注册企业统计
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<table class="margin_left_5" id="new_registeredUsers_search">
									<tr>
										<td >
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
												onclick="javascript:ChangePage(1);" value="查询"
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