<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%= MipWebMoreUi.mip_user_admin_logs_1 %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />

		<script src="../dwr/interface/Logs.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
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

		<script language="JavaScript">
       //公共变量
   
	   //选项卡
	var tabPane;	   
	var IsSearch = false;
   var type = "<%=request.getParameter("type") != null ? request
					.getParameter("type") : "-1"%>";
   var pageid = "<%=request.getParameter("pageid") != null ? request
					.getParameter("pageid") : "1"%>"-0;
	   
	   //初始化
	window.onload = function()
	{
		
	  	  getSysLogList(pageid);
	    
	   
	 }    
	 
	
	 //页面跳转
	function ChangePage(id)
	{
		pageid = id;
		if(IsSearch == true)
		{
			Search();			
		}
		else
		{
			getSysLogList(pageid);
		}
	}
	
	/*  将所有的日志列出*/
	function getSysLogList()
	{
		Progress("<%= MipWebMoreUi.mip_user_admin_logs_2 %>");
			Logs.getSysLogList('<%=request.getSession().getAttribute("enterpriseid")%>',type,pageid,
			{
				callback:function(objXml) {
					DisplayTransformedXML(1, objXml, "../xslt/admin_logs_list.xsl",document.getElementById("divList"));
					CloseProgress();					
				/*
					if(type == "1")
		      {
		      $('spanCurrentPosition').innerHTML = " >> 操作日志";
		      }
		      else if(type == "2")
		      {
		       $('spanCurrentPosition').innerHTML = " >> 运行日志";
		      }
		      else if(type == "3")
		      {
		       $('spanCurrentPosition').innerHTML = " >> 用户日志";
		      }
		      else if(type == "4")
		      {
		       $('spanCurrentPosition').innerHTML = " >> 安全日志";
		      }
		      else
		      {
		          $('spanCurrentPosition').innerHTML = " >> 全部日志";
		      }
				*/
      
      $('selType').value = type;

				},
				errorHandler:function(errorString, exception) {
				 alert(exception.message);
				}
			});
		}


/*  搜索日志*/
  /*--------------------------------------------------------------
	       功能：取得信息列表
	   --------------------------------------------------------------*/
	   function Search()
	   {
	   if(!IsSearch){
	   	pageid=1;
	   }
	   if($('starttime').value.Trim() != ""&&!CheckDateTime($('starttime').value))
	    {
	      DHalert("起始时间格式错误！");
	      return;
	     }	 
	     if($('endtime').value.Trim() != ""&&!CheckDateTime($('endtime').value))
	    {
		     DHalert("结束时间格式错误！");
		     return;
	     }	 

		if($('starttime').value.Trim()!=""&&$('endtime').value.Trim() != ""){
		    var sArr = $('starttime').value.split(" ");
		    var eArr = $('endtime').value.split(" ");
	    	var sDateArr = sArr[0].split("-");//开始日期
	    	var sTimeArr = sArr[1].split(":");//开始时间
	    	var eDateArr = eArr[0].split("-");//结束日期
	    	var eTimeArr = eArr[1].split(":");//结束时间
		    var dStart = new Date(Date.UTC(sDateArr[0],sDateArr[1]-1,sDateArr[2],sTimeArr[0],sTimeArr[1],sTimeArr[2]));
	 	    var dEnd = new Date(Date.UTC(eDateArr[0],eDateArr[1]-1,eDateArr[2],eTimeArr[0],eTimeArr[1],eTimeArr[2]));
	 	    if(parseInt(dEnd.valueOf()) < parseInt(dStart.valueOf())){
			      DHalert(" 结束时间不能早于起始时间！");
			     return;
		     		
	 	    }
		}
	    //企业代码
	    var keyCode="";
	    if('<%=request.getSession().getAttribute("enterpriseid")%>'==""){
	    keyCode=$("keyCode").value;
	    }
	     Progress("<%= MipWebMoreUi.mip_user_admin_logs_3 %>","<%= MipWebMoreUi.mip_user_admin_logs_4 %>");
	     Logs.Search(type,pageid,$('starttime').value,$('endtime').value,$('key').value,'<%=request.getSession().getAttribute("enterpriseid")%>',keyCode,
			{
				callback:function(objXml) {				     
					DisplayTransformedXML(1, objXml, "../xslt/admin_logs_list.xsl",document.getElementById("divList"));
					 CloseProgress();
					
				},
				errorHandler:function(errorString, exception) {
				 DHalert(exception.message);
				}
			});
	     
	              
					IsSearch = true;
      
      /**
      if(type == "1")
		      {
		      $('spanCurrentPosition').innerHTML = "用户日志查询结果";
		      }
		      else if(type == "2")
		      {
		       $('spanCurrentPosition').innerHTML = "运行日志查询结果";
		      }
		      else if(type == "3")
		      {
		       $('spanCurrentPosition').innerHTML = "操作日志查询结果";
		      }
		      else if(type == "4")
		      {
		       $('spanCurrentPosition').innerHTML = "安全日志查询结果";
		      }
		      else
		      {
		          $('spanCurrentPosition').innerHTML = "日志查询结果";
		      }
      **/
      
      $('selType').value = type;
	   }
	   
	   
	   function show_role()
	   {
	    GB_showCenter("<%= MipWebMoreUi.mip_user_admin_logs_5 %>", "../mas/admin_log_uploadrules.jsp",450,640);
	   
	   }
	   
	   function aa()
	   {  
	   DHalert("<%= MipWebMoreUi.mip_user_admin_logs_6 %>");
	   CloseProgress();
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
	
	function changeType(t){
		type=t;
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
				<div id="close_menu" onClick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<div id="center_nav_box">
						<div id="center_nav">
							<%= MipWebMoreUi.mip_user_admin_logs_7 %>
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<table width="100%" class="margin_left_5">
								<% if(!DhServerNameUtils.isMKEY){%>
									<tr>
										<td width="50%">
											<img src='../skin/default/images/list_fun1.gif'
												align='absmiddle'>
											&nbsp;&nbsp;
											<a href="#" onClick="show_role()"><%= MipWebMoreUi.mip_user_admin_logs_8 %></a>
										</td>
										<td width="50%">
										</td>
									</tr>
								<%}%>
									<tr>
										<td width="50%">

											<%= MipWebMoreUi.mip_user_admin_logs_9 %>
											<input name="starttime" id="starttime" type="text" />
											<img alt='<%= MipWebMoreUi.mip_user_admin_logs_10 %>'
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
										<td>
											<%= MipWebMoreUi.mip_user_admin_logs_11 %>
											<input name="endtime" id="endtime" type="text" />
											<img alt='<%= MipWebMoreUi.mip_user_admin_logs_12 %>'
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
									</tr>
									<tr>
										<td width="50%">
											<%= MipWebMoreUi.mip_user_admin_logs_13 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="text" id="key" />
										</td>

										<td width="50%">
											<%= MipWebMoreUi.mip_user_admin_logs_14 %>
											<select id="selType"
												onchange="javascript:changeType(this.value)">
												<option value="-1">
													<%= MipWebMoreUi.mip_user_admin_logs_15 %>
												</option>
												<option value="1">
													<%= MipWebMoreUi.mip_user_admin_logs_16 %>
												</option>
												<option value="2">
													<%= MipWebMoreUi.mip_user_admin_logs_17 %>
												</option>
												<option value="3">
													<%= MipWebMoreUi.mip_user_admin_logs_18 %>
												</option>
												<option value="4">
													<%= MipWebMoreUi.mip_user_admin_logs_19 %>
												</option>
											</select>
										</td>
									</tr>
									<% if((Integer)request.getSession().getAttribute("loginport")==MipSysuser.USR_LOGIN_TYPE_CTCCMANAGER){ %>
									<tr>
									<td width="50%">
											<%= MipWebMoreUi.mip_user_admin_logs_21 %>
											<input type="text" id="keyCode" />
										</td>
										<td width="50%">
										
										</td>
									</tr>
									<%} %>
									<tr>
										<td colspan="2" align="center" height="25">

											<input type="image"
												onclick="javascript:Search();return false;" id="search"
												value="<%= MipWebMoreUi.mip_user_admin_logs_20 %>"
												src="../skin/default/images/button_search.gif" />
										</td>
									</tr>
								</table>



								<div id="divList">


								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>