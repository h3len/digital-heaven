<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@ page import="com.dheaven.mip.util.Constants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>使用情况统计表</title>
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
		<!-- dwr js -->
		<script src="../dwr/interface/MipUserStatisticsAction.js" type="text/javascript"></script>
		<script>
		//得到企业id
 		var enterpriseid = "<%=request.getParameter("enterpriseid")!=null?request.getParameter("enterpriseid"):request.getSession().getAttribute("enterpriseid")%>";
		var pageid=1 ;
		window.onload=function(){
			if(<%=Constants.userstatistics %>){
				getEnterPrisename();
				getappname() ;
				setYear();
				setMonth();
				
			}else{
				DHalert("您不具备此模块的访问权限!") ;
				return ;
			}
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
 		function setMonth(){
 		    var date=new Date();
 		    var month=date.getMonth()+1;// 0-11
 			for(var i = 1 ; i<13; i++){
 				var oOption = document.createElement("OPTION");
				oOption.text = i;
				oOption.value = i;		
				document.all?$('month').add(oOption):$('month').appendChild(oOption);
				if(i==month){
			      oOption.selected=true;
				}
 			}
 		}
 		function getEnterPrisename(){
 			Progress("正在载入数据...","提示");
		   	 EnterpriseAction.showEnterpriseByid(enterpriseid,{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取数据失败，失败原因："+errorString);
						}
				});
 		}
 		
 		function getappname(){
 			Progress("正在载入数据...","提示");
		   	 EnterpriseAction.getAllClientByenterpriseid(enterpriseid,{
						callback:function(oMap) {
							CloseProgress();
							DWRUtil.addOptions("appid",oMap);
							var ops=$("appid").options;
							getuserstatistics() ;
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取数据失败，失败原因："+errorString);
						}
				});
 		}
 		function getuserstatistics(){
 			Progress("正在载入数据...","提示");
 			var appid = $('appid').value;
 			var year = $('year').value;
 			var month = $('month').value;
 			if(appid==null||appid==""){
				CloseProgress();
				document.getElementById('statisticsImg').style.display="none";				
				DHalert("该企业还未接入应用,请确认");
				return ;
			}
 			MipUserStatisticsAction.getUserStatistics(enterpriseid,appid,year,month,
 					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
							document.getElementById("imgUser").src="../userstatistic.do?action=showEnterpriseUserByEnterpriseAndAppidAndstatisticstime&appid="+$('appid').value+"&year="+$('year').value+"&month="+$('month').value+"&rnd="+Math.random() ;
						 
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取数据失败，失败原因："+errorString);
						}
					}
 			);
 		}
 		
 		function showUserImg(){
 			getuserstatistics() ;
 			document.getElementById("imgUser").src="../userstatistic.do?action=showEnterpriseUserByEnterpriseAndAppidAndstatisticstime&appid="+$('appid').value+"&year="+$('year').value+"&month="+$('month').value+"&rnd="+Math.random() ;
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
				<div id="center_nav">您现在所在位置 >> 系统维护 >> 使用情况统计表</div>
			</div>

			<div id="mainbox">
			<%if(Constants.userstatistics){%>
				<div class="center_list_box">
					<div class="center_list">
						<div class="">
							<table  class="up_title" width="80%" border="0" cellspacing="0" cellpadding="0">
								<tr  class="up_title" style="margin-top: 10">
									<td class="gray_14_bold" id="enterpristname" width="20%" align="center" Style="font-size:18;font-weight: 18  "></td>
									<td class="gray_14_bold" id="" width="35%" align="" Style="font-size:18;font-weight: 18  ">
										<select id="appid">
										</select>系统对接
									</td>
									<td class="gray_14_bold" id="statisticstime" width="30%" align="" Style="font-size:18;font-weight: 18  ">
										<select id="year">
										</select> 年
										<select id="month">
										</select> 月使用情况
									</td>
									<td class="gray_14_bold"  Style="font-size:18;font-weight: 18  ">
										<input type="button" class="button_2" value="查询" onclick="showUserImg()" />
									</td>
								</tr>
							</table>
						</div>
						<br />
						<div>
							<table id="lookup" width="90%" border="0"
								cellspacing="0" cellpadding="0">
								<tr>
									<td width="5%"></td>
									<td width="15%" >本月注册用户数:</td>
					                 <td id="monthregisterusers" width="30%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
					                 <td width="15%" >本月活跃用户数:</td>
					                 <td id="monthlivelyusers" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
								</tr>
								<tr><td colspan="5"><br/></td></tr>
								<tr>
									<td width="5%"></td>
									<td width="15%">本月活跃率:</td>
					                 <td id="monthprobability" width="25%" Style="color: RED; font-weight: 550;font-size: 14"></td>
					                 <td width="15%">日均活跃用户数:</td>
					                 <td id="dayprobabilityusers" width="25%" Style="color: RED; font-weight: 550;font-size: 14"></td>
								</tr>
								<tr><td colspan="5"><br/></td></tr>
								<tr>
									<td width="5%"></td>
									<td width="15%">本月总计使用量:</td>
					                 <td id="monthuserslogintimes" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
					                 <td width="15%">日均使用量:</td>
					                 <td id="dayuserslogintimes" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
								</tr>
								<tr><td colspan="5"><br/></td></tr>
								<tr>
									<td width="5%"></td>
									<td width="15%">本月最高使用量日期:</td>
					                 <td id="dayofmonthusersmastlogin" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
					                 <td width="15%">本月最高日使用量:</td>
					                 <td id="dayofmonthusersmastlogintimes" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
								</tr>
								<tr><td colspan="5"><br/></td></tr>
						<tr>
									<td width="5%"></td>
									<td width="15%">本月用户登录次数:</td>
					                 <td id="monthuserlogincount" width="25%" Style="color: RED; font-weight: 550;font-size: 14 "></td>
								</tr>
								<tr><td colspan="5"><br/></td></tr>
								<tr>
								<tr id="statisticsImg">
									<td  class="up_title" width="80%" colspan="5" align="center" >
									      <p style="color:red;font-size:10" >&nbsp;&nbsp;备注：横坐标表示日期，纵坐标表示使用量；&nbsp;&nbsp;&nbsp;“日使用量统计图”主要统计该月的每天使用数量</p>
										<img src="" id="imgUser"
											alt="日使用量统计" width="800" />
									</td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
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
