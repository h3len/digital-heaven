<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.DhServerNameUtils"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>活跃用户统计管理</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>

		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/LoginCountAction.js" type="text/javascript"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
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
		<script>
		var ab=[[imageshow,'折线图展示'],[tableshow,'列表显示']];
		var pageid=1;
		window.onload=function(){
			DHTabPanel(ab,900,0,"tabs");
			getEnterPrise();
			setYear() ;
 		}
 		function imageshow(){
			$('lookup').style.display="";
			$('tableshow').style.display="none";
 		}
 		function tableshow(){
 			$('lookup').style.display="none";
			$('tableshow').style.display="";
			getlogincount();
 		}
 		function getlogincount(){
 			var entcode=$('entcode').value;
 			var entname=$('entname').value;
 			var starttime=$('starttime').value;
 			var endtime=$('endtime').value;
 			var appname =$('appname').value;
			LoginCountAction.getLoginCount(entcode,entname,appname,starttime,endtime,pageid,
			 	function(objXml){
					DisplayTransformedXML(1, objXml, "../user/xslt/logincount.xsl",document.getElementById("divlist"));
		 			CloseProgress();
				}
			);
 		}
 		function getEnterPrise(){
 			Progress("正在载入数据...","提示");
		   	 EnterpriseAction.getAllEnterprise({
						callback:function(oMap) {
							CloseProgress();
							DWRUtil.addOptions("enterpriseid",oMap);
							var ops=$("enterpriseid").options;
							//for(i=0;i<ops.length;i++){
								//$("enterpriseid").selectedIndex=i;
							//}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						}
				});
 		}

 		function setYear(){
 			var nowdate= new Date() ;
 			var current = nowdate.getYear();
 			for(var i = 0 ; i<3; i++){
 				var oOption = document.createElement("OPTION");
				oOption.text = current;
				oOption.value =current;
				document.all?$('year').add(oOption):$('year').appendChild(oOption);
				current=current-1 ;
 			}
 		}

 		function showUserImg(){
 			var userimg = document.getElementById("imgUser") ;
 			userimg.src = "../userstatistic.do?action=showEnterpriseUser&year="+$('year').value+"&enterpriseid="+$('enterpriseid').value+"&"+Math.random();
 		}
 		function showdetail(type,entid){
			GB_showCenter("", "../user/logincountdetail.jsp?type="+type+"&entid="+entid,550,878);
 		}
		function exportdoc(){
 		    var entcode=$('entcode').value;
 			var entname=$('entname').value;
 			var starttime=$('starttime').value;
 			var endtime=$('endtime').value;
 			var appname =$('appname').value;
       		window.location.href="../exportUserStatistics.do?action=exportUserStatisticsExcel&entcode="+entcode+"&entname="+entname+"&starttime="+starttime+"&endtime="+endtime+"&appname="+appname;
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
				<div id="center_nav">您现在所在位置 >> 系统维护 >> 活跃用户统计</div>
			</div>

			<div id="mainbox">
				<div class="center_list_box">
					<div class="center_list">
						<div id="tabs"></div>
						<div id="lookup" class="text">

							<table id="lookup" width="100%" width="100%" border="0"
								cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<select id="enterpriseid">
											<option selected="selected">--请选择企业--</option>
										</select>
									</td>
									<td>
										<select id="year">
											<option selected="selected">--请选择年份--</option>
										</select>
									</td>
									<td>
										<input type="button" class="button_2" value="查询" onclick="showUserImg()" />
									</td>
								</tr>
								<tr>
									<td width="54%" class="text_icon2" colspan="3" >
										<span class="href_14px_blue">活跃用户统计：<span
											id="diskUsed"></span></span>
									</td>
								</tr>
								<tr>
									<td width="80%" colspan="3" align="center">
									 <p style="color:red;font-size:10" >&nbsp;&nbsp;备注：横坐标表示日期，纵坐标表示活跃用户数；&nbsp;&nbsp;&nbsp;“活跃用户数统计图”主要统计该月的活跃用户数</p>
										<img src="../userstatistic.do?action=showEnterpriseUser" id="imgUser"
											alt="活跃用户统计"  />
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div id="tableshow">
						<table width="95%"  border="1" class="detailtable" align="center" cellpadding="2" cellspacing="0">
				        <tr>
						  <td width="10%" class="lmtd2">集团客户ID</td>
				          <td width="15%"><input type="text" name="entcode" style="width:97% "></td>
				          <td width="10%" class="lmtd2">集团客户名称</td>
				          <td width="15%"><input type="text" name="entname" style="width:97% "></td>

				          <td width="10%" class="lmtd2">应用名称</td>
				          <td colspan="2" width="15%"><input type="text" name="appname" style="width:97% "></td>
				        </tr>
				        <tr>
				          <td width="10%" class="lmtd2">开始时间</td>
				          <td width="15%">
				            <input name="starttime" id="starttime" type="text" />
											<img alt='开始时间'
												src='../skin/calendar/themes/icons/calendar2.gif' border='0'
												id='start' onMouseOver="this.style.cursor='pointer'"
												onmouseout="this.style.cursor='default'" />

											<script type="text/javascript">
												var cal1 = new Zapatec.Calendar.setup({

												inputField     :    "starttime",     // id of the input field
												singleClick    :     false,     // require two clicks to submit
												ifFormat       :    '%Y-%m-%d %H:%M:00',     // format of the input field
												showsTime      :     true,     // show time as well as date
												button         :    "start"  // trigger button
												});
											</script>
				          </td>
				          <td width="10%" class="lmtd2">结束时间</td>
				          <td width="15%">
							<input name="endtime" id="endtime" type="text" />
											<img alt='结束时间'
												src='../skin/calendar/themes/icons/calendar2.gif' border='0'
												id='end' onMouseOver="this.style.cursor='pointer'"
												onmouseout="this.style.cursor='default'" />

											<script type="text/javascript">
												var cal2 = new Zapatec.Calendar.setup({

												inputField     :    "endtime",     // id of the input field
												singleClick    :     false,     // require two clicks to submit
												ifFormat       :    '%Y-%m-%d %H:%M:00',     // format of the input field
												showsTime      :     true,     // show time as well as date
												button         :    "end"  // trigger button
												});
											</script>
				          </td>
					<td colspan="2"  align="right"><input type="button" class="button_2"  value="查询" onclick="getlogincount()"></td>
					      <td width="11%"  align="right"><input type="button" class="button_4"  value="导出excel" onclick="exportdoc()"></td>
				        </tr>
				      </table>
				      <div id="divlist"></div>
					</div>
				</div>
			</div>

		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
