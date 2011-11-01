<%@ page contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
		
		<title>MDP日志管理</title>
		
		<script src="/dwr/interface/MdpLog.js" type="text/javascript"></script>
		<script src="/dwr/engine.js" type="text/javascript"></script>
		<script src="/dwr/util.js" type="text/javascript"></script>
		
		<script type="text/javascript" src="/skin/AJS.js"></script>
		<script type="text/javascript" src="/skin/AJS_fx.js"></script>
		<script type="text/javascript" src="/skin/gb_scripts.js"></script>
		<link href="/skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="/skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="/skin/calendar/lang/calendar-zh.js"></script>
		<link href="/skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="/skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="/skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />

		<script language="javascript" type="text/javascript">
		//公共变量
		var progressBar;
		var tabPane;	   
		var IsSearch = false;

		var pageid = "<%=request.getParameter("pageid") != null ? request.getParameter("pageid") : "1"%>";
		var pagesize ='<%=session.getAttribute("pageSize") != null ? session.getAttribute("pageSize"): "10"%>';
		var appid = "";

		   //初始化
		window.onload = function()
		{
			loadAppid();
		    Search(pageid);
		}
		
		 //页面跳转
		function ChangePage(id)
		{
			pageid = id;
			Search(pageid);			
		}
		
		function changeAppid(id){
			appid = id;
		}
		
		
		function loadAppid()
		{
			MdpLog.loadAppid("",
			{
				callback:function(objXml) {
					document.getElementById("selAppid").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_logs_enterprise.xsl",document.getElementById("selAppid"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		function exportToXls(allCount,sucCount,sucScale,outputType)
		{
			var opreatUser = $('user').value;
			var requestUrl = $('responseUrl').value;
			var responseStatus = $('statuCode').value;
			var startTime = $('starttime').value;
			var endTime = $('endtime').value;
			
			var param = "appid=" + appid 
				+ "&opreatUser=" + opreatUser
				 + "&requestUrl=" + requestUrl
				  + "&responseStatus=" + responseStatus
				   + "&startTime=" + startTime
				    + "&endTime=" + endTime
				     + "&allCount=" + allCount
				      + "&sucCount=" + sucCount
				       + "&sucScale=" + sucScale
				        + "&outputType=" + outputType;
			window.open('/mdp/webaction.do?action=exportMdpLogsStatisticsToXls&' + param);
		}
	   
	   
	   function Search(page)
	   {
			var type = "load";
			var responseUrl = "";
			var user = "";
			var statuCode = -10;
			var startTime = "";
			var endTime = "";
			var issuc = -1;
			if(appid == '' && $('selIssuc').value == '' && $('user').value == "" && $('responseUrl').value == "" && $('statuCode').value == "" &&( $('starttime').value == "" && $('endtime').value == ""))
			 	type = "load";
			else
				type = "search";
			if(type == "search")
			{
				responseUrl = $('responseUrl').value;
				responseUrl = responseUrl.replace("&","__26__").replace("=","__3d__");
				statuCode = $('statuCode').value;
				user = $('user').value;
				issuc = $('selIssuc').value;
				if(issuc == '')
				{
					issuc = -1;
				}
				if(statuCode == '')
				{
					statuCode = -10;
				}
				if($('starttime').value != "" && $('endtime').value != "")
				{
					var sArr = $('starttime').value.split(" ");
					var eArr = $('endtime').value.split(" ");
					var sDateArr = sArr[0].split("-");//开始日期
					var sTimeArr = sArr[1].split(":");//开始时间
		   		
		   		 	var eDateArr = eArr[0].split("-");//结束日期
		   		 	var eTimeArr = eArr[1].split(":");//结束时间
		    		
			    	 var dStart = new Date(Date.UTC(sDateArr[0],sDateArr[1]-1,sDateArr[2],sTimeArr[0],sTimeArr[1],sTimeArr[2]));
		 	    	 var dEnd = new Date(Date.UTC(eDateArr[0],eDateArr[1]-1,eDateArr[2],eTimeArr[0],eTimeArr[1],eTimeArr[2]));
		 	    	 var dateCount = Math.floor((dEnd - dStart)/1000/3600/24);
		 	    	 if(dateCount < 0)
		    		 {
				   	 	 DHalert("结束时间不能早于开始时间");
				    	 return;
		    	 	 }
		    	 	 else if(dateCount > 30){
		    	 		DHalert("查询日期不能大于30天");
				    	 return;
		    	 	 }
		    	 	 else
		    	 	 {
		    	 	 	startTime = $('starttime').value;
						endTime = $('endtime').value;
		    	 	 }
				}
				else if($('starttime').value != "" && $('endtime').value == "")
				{
					DHalert("结束时间不能为空");
					return;
				}
				else if($('starttime').value == "" && $('endtime').value != "")
				{
					DHalert("起始时间不能为空");
					return;
				}
			}
			MdpLog.getLogs("",type,page,pagesize, responseUrl, user, startTime, endTime,appid,statuCode,issuc,0,"",
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_logs_list.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
	   }
	   
	   /*--------------------------------------------------------------
	       功能：取得信息列表 - CallBack
	   --------------------------------------------------------------*/
	 function Search_CallBack(originalRequest)
	   {
      var objXml = originalRequest.responseXML;
      document.getElementById("divContent").innerHTML = "";
		DisplayTransformedXML(1, objXml, "/xslt/mdp_logs_list.xsl",document.getElementById("divContent"));
      	progressBar.Close();
     	 var time = '<%=request.getSession()
									.getAttribute("logsCacheTime") != null ? request
							.getSession().getAttribute("logsCacheTime")
							: "30"%>';
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
	
	//copy信息到剪贴板
	function copyToClipboard(txt) {   
    	if(window.clipboardData) {   
            window.clipboardData.clearData();   
            window.clipboardData.setData("Text", txt);   
    	} else if(navigator.userAgent.indexOf("Opera") != -1) {   
         	window.location = txt;   
   	    } else if (window.netscape) {   
         	try {   
              netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
            } catch (e) {   
              alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true'");   
            }   
         var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);   
         if (!clip)   
              return;   
         var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);   
         if (!trans)   
              return;   
         trans.addDataFlavor('text/unicode');   
         var str = new Object();   
         var len = new Object();   
         var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);   
         var copytext = txt;   
         str.data = copytext;   
         trans.setTransferData("text/unicode",str,copytext.length*2);   
         var clipid = Components.interfaces.nsIClipboard;   
         if (!clip)   
              return false;   
         clip.setData(trans,null,clipid.kGlobalClipboard);   
         //alert("复制成功！")   
   	 	}   
	}
	</script>

	</head>

	<body bgcolor="#f8f8f8" class="body_center">
	
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
									您现在所在位置 >> 系统维护 >> 接入日志
								</div>
							</div>
							<div id="mainbox">
								<div  class="center_list" style="display:table;">
									<table width="100%"  class="margin_left_5">
											<tr>
												<td align='left'>
													<div id='selAppid'></div>
												</td>
												<td align='left'>
													请求状态：
													<select id='selIssuc' name='selIssuc' style="width:100px;">
														<option value='' selected='true'>所有</option>
														<option value='0'>失败</option>
														<option value='1'>成功</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="49%">
													操作用户： <input class="input_text" tabindex="1" type="text" name="user" id="user" />
												</td>
												<td width="49%">
													请求地址： <input class="input_text" tabindex="2" type="text" name="responseUrl" id="responseUrl" />
												</td>
											</tr>
											<tr>
												<!--<td >
													应用名称： <input class="input_text" tabindex="3" type="text" name="appid" id="appid" />
												</td>-->
												<td>
													响应状态： <input class="input_text" tabindex="4" type="text" name="statuCode" id="statuCode" />
												</td>
											</tr>
											<tr>
												<td width="49%">
													起始时间：
													<input name="starttime" class="input_text" id="starttime" type="text" />
													<img alt='从日历选择'
														src='/skin/calendar/themes/icons/calendar2.gif' border='0'
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
												<td width="49%">
													结束时间：
													<input name="endtime" class="input_text" id="endtime" type="text" />
													<img alt='从日历选择'
														src='/skin/calendar/themes/icons/calendar2.gif' border='0'
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
													&#160;&#160;
													
												</td>
												
											</tr>
											
											<tr style=" height:23px ">
												<td colspan="2" width="100%" align="center">
													<input type="image"
														onclick="javascript:Search(1);return false;" id="search"
														value=" 查  询 "
														src="/skin/default/images/button_search.gif" />
												</td>
											</tr>
										</table>
									<div class="clear"></div>
									<div id="divContent"></div>
								</div>	
							</div>
					</div>
			</div>
		</div>

		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="/user/bottom.jsp" flush="true" />
		<!--Bottom Include-->

	</body>
</html>
