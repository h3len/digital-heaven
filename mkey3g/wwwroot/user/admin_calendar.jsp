<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
  out.print("<script>parent.location.href='../default.jsp'</script>");
  return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html>
<head>
<title>
<%= MipWebJSPUi.mipweb_user_admin_calendar_1 %>
</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/tabpane.js"></script>
<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
<link type="text/css" rel="stylesheet" href="../css/user.css" />  
<link type="text/css" rel="stylesheet" href="../css/calendar.css" />    
<script type="text/javascript" src="../scripts/calendar.js"></script>
<script language="javascript" type="text/javascript">

	/********************************************************************
		备注：日程安排 by yesun 2006-6-5
	*********************************************************************/ 
	
	var listHeight = 440;
	var contentWidth = 500;
	
	var screenWidth = screen.width;
	var screenHeight = screen.height;
	
	parent.window.moveTo(0,0);
	parent.window.resizeTo(screen.availWidth,screen.availHeight);
	
	//公共变量
	var left = 75;
	var cellwidth = 87;
	
	//alert(screen.width);
	
	left = String((screenWidth * 85/100)*7/100 + 3);
	if(left.indexOf(".")>-1)
	{
		left = left.substring(0,left.indexOf("."));
	}
	
	cellwidth = String((screenWidth * 85/100)/8 + 4);
	if(cellwidth.indexOf(".")>-1)
	{
		cellwidth = cellwidth.substring(0,cellwidth.indexOf("."));
	}
	//alert("left="+left);
	//alert("cellwidth="+cellwidth);
	
	
	//公共变量	
	var progressBar;
	var currentDate = "";
	var hasTaskDay = "";	
	var dNow = new Date();
	var arrUserCalendarContent = new Array();
	currentDate = dNow.getFullYear()+"-"+(dNow.getMonth()+1)+"-"+dNow.getDate();
	var calEditForm = "ok";
	
	/*--------------------------------------------------------------
		功能：初始化
	---------------------------------------------------------------*/
	function Init()
	{
		//载入日程安排
		GetHasTaskDay();		
		GetUserCalendarContent();
		
		//listHeight = document.body.document.body.clientWidth - 114 - 30;
		//alert(document.body.clientHeight);
		//设置list的滚动条的高度
		
		//alert(document.body.clientHeight);
		//alert(listHeight);
		//alert(listHeight);
		if($('divList').style.cssText == "")
		{
			listHeight = (document.body.clientHeight - 34);
			SetCssStyle($('divList'),"float:right;height:"+listHeight+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		//定义content的自适应宽度
		contentWidth = document.body.clientWidth*85/100;
		SetCssStyle($('content'),"width:"+contentWidth+"px;float:right;");
	}
	
	//取得css
	function GetCssStyle(obj)
	{
		if(CheckBrowser() == "IE")
		{
			return obj.style.cssText;
		}
		else
		{
			return obj.getAttribute("style");
		}
	}
	
	//设置css，
	function SetCssStyle(obj,style)
	{
		if(CheckBrowser() == "IE")
		{
			obj.style.cssText = style;
		}
		else
		{
			obj.setAttribute("style",style);
		}
	}
	
	
	function OnReSize()
	{
		parent.window.moveTo(0,0);
		parent.window.resizeTo(screen.availWidth,screen.availHeight);
		
		var viewtype = "";
		var radios = document.getElementsByName("radio");					
		for(var j=0 ;j<radios.length;j++)
		{
			if(radios[j].checked)
			{
				viewtype = radios[j].value;
			}
		}
		switch(viewtype)
		{
			case "month":
				listHeight = (document.body.clientHeight - 34);
				break;			
			case "week":
				listHeight = (document.body.clientHeight - 34 - 30);
				break;				
			case "day":
				listHeight = (document.body.clientHeight - 34);
				break;
				
		}
		SetCssStyle($('divList'),"float:right;height:"+listHeight+"px;overflow:auto;overflow-x:hidden;width:100%;");
		
		//定义content的自适应宽度
		contentWidth = document.body.clientWidth*85/100;
		SetCssStyle($('content'),"width:"+contentWidth+"px;float:right;");
	}
	
	/*--------------------------------------------------------------
		功能：设置标题
	---------------------------------------------------------------*/
	function ChangeTopic(s)
	{
		$('divTopic').innerHTML = s;
	}
	
	/*--------------------------------------------------------------
		功能：取得已经设置日程安排的日期
	---------------------------------------------------------------*/
	function GetHasTaskDay()
	{
		var url = '../calendar.do';     
      	var pars = 'action=GetHasTaskDayByUserId';
      	var myAjax = new Ajax.Request(
                    url,
                    {method: 'post', parameters: pars, onComplete: GetHasTaskDay_CallBack}
                    );
	}
	
	/*--------------------------------------------------------------
		功能：取得已经设置日程安排的日期 - CallBack Return
	---------------------------------------------------------------*/
	function GetHasTaskDay_CallBack(originalRequest)
	{
	
		hasTaskDay = originalRequest.responseText;
		hasTaskDay = "";
		try{
			//加载小日历
			showCalendar('calendar', '', dNow.getMonth(), dNow.getFullYear(), dNow.getDate(),hasTaskDay);
			showCalendar('calendar2', '', dNow.getMonth()+1, dNow.getFullYear(), dNow.getDate(),hasTaskDay);
		}catch(err){
			//alert(errorMessage);
		}
	}
	
	
	
	
	/*--------------------------------------------------------------
		功能：选择日期后
	---------------------------------------------------------------*/
	function SelectDate(selDate)
	{
		
		//判断，如果当前view为WeekView的话，则，调用WeekView	
		if($('r2').checked == true)
		{
			GetCalendarByWeek(selDate);
			return;
		}
		
		SetCssStyle($('divList'),"float:right;height:"+(listHeight+10)+"px;overflow:auto;overflow-x:hidden;width:100%;");
		$('divWeek').style.display = "none";
		//设置ViewType
		$('r1').checked = true;
		//alert(selDate);
		currentDate = selDate;	
		var shtml = "";				
		//取得selDate的日程信息	
		GetCalendarByDate(selDate);
	}
			
	/*--------------------------------------------------------------
		功能：取出该天的日程列表
	---------------------------------------------------------------*/
	function GetCalendarByDate(seldate)
	{	
		currentDate = seldate;
		ChangeTopic(seldate+"<%= MipWebJSPUi.mipweb_user_admin_calendar_2 %>");
		if(window.top.document.getElementById("parentFrame").rows == "114,*,30")
		{
			SetCssStyle($('divList'),"float:right;height:"+listHeight+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		else
		{
			SetCssStyle($('divList'),"float:right;height:"+(listHeight)+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		
		
		$('divWeek').style.display = "none";
		progressBar = new ProgressBar();
	    progressBar.isNeedConfirmButton = false;
	    progressBar.isNeedProgressBar = true;
	    progressBar.Top = 10;
	    progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_calendar_3 %>");	
		var url = '../calendar.do';
		var pars = 'action=GetUserCalendarByDate&date='+seldate+'&left='+left;
		//alert(pars);
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetCalendarByDate_CallBack}
		);
		
	}
	
	/*--------------------------------------------------------------
		功能：取出该天的日程列表 - CallBack
	---------------------------------------------------------------*/
	function GetCalendarByDate_CallBack(originalRequest)
	{
	    var objXml = originalRequest.responseXML;		
	    document.getElementById("divList").innerHTML = "";
	    DisplayTransformedXML(1, "<root><hour hour=\"0\"></hour><hour hour=\"1\"></hour><hour hour=\"2\"></hour><hour hour=\"3\"></hour><hour hour=\"4\"></hour><hour hour=\"5\"></hour><hour hour=\"6\"></hour><hour hour=\"7\"></hour><hour hour=\"8\"></hour><hour hour=\"9\"></hour><hour hour=\"10\"></hour><hour hour=\"11\"></hour><hour hour=\"12\"></hour><hour hour=\"13\"></hour><hour hour=\"14\"></hour><hour hour=\"15\"></hour><hour hour=\"16\"></hour><hour hour=\"17\"></hour><hour hour=\"18\"></hour><hour hour=\"19\"></hour><hour hour=\"20\"></hour><hour hour=\"21\"></hour><hour hour=\"22\"></hour><hour hour=\"23\"></hour></root>", "../xslt/calendar_list.xsl",document.getElementById("divList"));
	    //var win = window.open("","");
	    //win.document.write(document.getElementById("divList").innerHTML);
		progressBar.Close();
		//设置日视图div的滚动条位置
		document.getElementById("divList").scrollTop = 60*7;
	}
	
	
	
	/*--------------------------------------------------------------
		功能：星期 日程列表
	---------------------------------------------------------------*/
	function GetCalendarByWeek(seldate)
	{	
		currentDate = seldate;
		//设置标题,需要把日期，转换出来
		var str = seldate;   
		var re = /^(\d{4})\S(\d{1,2})\S(\d{1,2})$/;   
		var dt;   
		if(re.test(str))   
		{   
			dt = new Date(RegExp.$1,RegExp.$2   -   1,RegExp.$3);   
		} 
		ChangeTopic(dt.getFullYear()+"<%= MipWebJSPUi.mipweb_user_admin_calendar_4 %>"+(dt.getMonth()+1)+"<%= MipWebJSPUi.mipweb_user_admin_calendar_5 %>");
		$('divWeek').innerHTML = '<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr bgcolor="#b9daea" style="height:30px;text-align:center;font-weight:bolder;"><td width="1%"></td><td width="9%"></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_6 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_7 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_8 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_9 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_10 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_11 %></td><td><%= MipWebJSPUi.mipweb_user_admin_calendar_12 %></td></tr></table>';
		SetCssStyle($('divWeek'),"width:100%;");
		if(window.top.document.getElementById("parentFrame").rows == "114,*,30")
		{
			SetCssStyle($('divList'),"float:right;height:"+(listHeight-30)+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		else
		{
			SetCssStyle($('divList'),"float:right;height:"+(listHeight-30)+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		
		progressBar = new ProgressBar();
	    progressBar.isNeedConfirmButton = false;
	    progressBar.isNeedProgressBar = true;
	    progressBar.Top = 10;
	    progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_calendar_13 %>");	
		var url = '../calendar.do';
		var pars = 'action=GetUserCalendarByWeek&date='+seldate+'&left='+left+'&cellwidth='+cellwidth;
		//alert(pars);
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetCalendarByWeek_CallBack}
		);
		
	}
	
	/*--------------------------------------------------------------
		功能：星期 日程列表 - CallBack
	---------------------------------------------------------------*/
	function GetCalendarByWeek_CallBack(originalRequest)
	{
	    var objXml = originalRequest.responseXML;		
	    document.getElementById("divList").innerHTML = "";
	    DisplayTransformedXML(1, "<root><hour hour=\"0\"></hour><hour hour=\"1\"></hour><hour hour=\"2\"></hour><hour hour=\"3\"></hour><hour hour=\"4\"></hour><hour hour=\"5\"></hour><hour hour=\"6\"></hour><hour hour=\"7\"></hour><hour hour=\"8\"></hour><hour hour=\"9\"></hour><hour hour=\"10\"></hour><hour hour=\"11\"></hour><hour hour=\"12\"></hour><hour hour=\"13\"></hour><hour hour=\"14\"></hour><hour hour=\"15\"></hour><hour hour=\"16\"></hour><hour hour=\"17\"></hour><hour hour=\"18\"></hour><hour hour=\"19\"></hour><hour hour=\"20\"></hour><hour hour=\"21\"></hour><hour hour=\"22\"></hour><hour hour=\"23\"></hour></root>", "../xslt/calendar_week.xsl",document.getElementById("divList"));
		progressBar.Close();
		//var win = window.open("","");
	    //win.document.write(document.getElementById("divList").innerHTML);
		//设置日视图div的滚动条位置
		document.getElementById("divList").scrollTop = 61*7;
	}
			
	
	/*--------------------------------------------------------------
		功能：载入创建日程安排的界面
	---------------------------------------------------------------*/
	function LoadCreateCalendar(time)
	{
	return;
		var hour = 10;
		if(time.indexOf(":") > -1)
		{
			hour = time.substring(0,time.indexOf(":"));
		}
		//判断
		if(CheckBrowser() == "IE")
		{
			var diagReturn = showModalDialog("calendar_add.jsp?date="+currentDate+"&hour="+hour,'','dialogWidth:600px;dialogHeight:420px;help:No;resizable:No;');
			if(diagReturn == "ok"){
				var viewtype = "";
				var radios = document.getElementsByName("radio");					
				for(var j=0 ;j<radios.length;j++)
				{
					if(radios[j].checked)
					{
						viewtype = radios[j].value;
					}
				}
				ChangeCalendarViewType(viewtype);
				//重新加载小日程
			GetHasTaskDay();
			}
		}
		else
		{
			//firefox
			//var win = window.open("admin_calendar_add.jsp?date="+currentDate+"&hour="+hour, "mcePopup", "top=" + y + ",left=" + x +",scrollbars=" + scrollbars + ",dialog=yes,modal=yes,width=" + width +",height=" + height + ",resizable=no" ); 
			var win = window.open("calendar_add.jsp?date="+currentDate+"&hour="+hour,"","top=50,left=200,width=600,height=420,scrollbars=false,dialog=yes,modal=yes,resizable=no");
	        win.focus(); 
		}
	}	
		
	
	/*--------------------------------------------------------------
		功能：载入修改日程安排的界面
	---------------------------------------------------------------*/
	function LoadCalendarModifyInfo(id,time)
	{
		var dNow = new Date();
		var hour = 10;
		var myDate = dNow.getFullYear()+"-"+dNow.getMonth()+"-"+dNow.getDate();
		if(currentDate != "")
			myDate = currentDate;
		//if(typeof(obj.time) != undefined)
		//{
			//hour = obj.time.substring(0,obj.time.indexOf(":"));
			hour = time.substring(0,time.indexOf(":"));
		//}
		//alert(hour);
		//open window
		if(CheckBrowser() == "IE")
		{
		var diagReturn = showModalDialog("calendar_add.jsp?calendarid="+id+"&date="+myDate+"&hour="+hour,"edit","dialogWidth:600px;dialogHeight:450px;help:No;resizable:No;");
		if(diagReturn == "ok"){
			var viewtype = "";
			var radios = document.getElementsByName("radio");					
			for(var j=0 ;j<radios.length;j++)
			{
				if(radios[j].checked)
				{
					viewtype = radios[j].value;
				}
			}
			ChangeCalendarViewType(viewtype);
			//重新加载小日程
			GetHasTaskDay();
		}
		}
		else
		{
			var win = window.open("calendar_add.jsp?calendarid="+id+"&date="+myDate+"&hour="+hour,"edit","top=50,left=200,width=600,height=450,scrollbars=false,dialog=yes,modal=yes,resizable=no");
	        win.focus();
		}
	}		
	
	/*--------------------------------------------------------------
		功能：切换视图
	--------------------------------------------------------------*/
	function ChangeCalendarViewType(viewtype)
	{
		//alert(viewtype);
		switch(viewtype)
		{
			case "month":
				Init();
				break;			
			case "week":
				GetCalendarByWeek(currentDate);
				break;				
			case "day":
				GetCalendarByDate(currentDate);
				break;
				
		}
	}
	
	
	/*--------------------------------------------------------------
		功能：取得日程内容By日期
	--------------------------------------------------------------*/
	function GetUserCalendarContent()
	{
		progressBar = new ProgressBar();
	    progressBar.isNeedConfirmButton = false;
	    progressBar.isNeedProgressBar = true;
	    progressBar.Top = 10;
	    progressBar.SetStatus("<%= MipWebJSPUi.mipweb_user_admin_calendar_14 %>");	
		var url = '../calendar.do';
		var pars = 'action=GetUserCalendarContent';
		//alert(pars);
		var myAjax = new Ajax.Request(
		url,
		{method: 'post', parameters: pars, onComplete: GetUserCalendarContent_CallBack}
		);
	}
	function GetUserCalendarContent_CallBack(originalRequest)
	{
		progressBar.Close();
		//返回的格式如： "2006-6-5,10:21,大家开会了;2006-6-9,14:31,户外运动"
		var content = originalRequest.responseText;
		try{
			//alert(content);
			arrUserCalendarContent = content.split(";");
			//alert(arrUserCalendarContent.length);
			//加载大日历MonthView
			showBigCalendar('divList', '', dNow.getMonth(), dNow.getFullYear(), dNow.getDate(),hasTaskDay);	
			//设置标题,需要把日期，转换出来
			//var str = currentDate;   
			//var re = /^(\d{4})\S(\d{1,2})\S(\d{1,2})$/;   
			//var dt;   
			//if(re.test(str))   
			//{   
			//	dt = new Date(RegExp.$1,RegExp.$2   -   1,RegExp.$3);   
			//} 
			//ChangeTopic(dt.getFullYear()+"年"+(dt.getMonth()+1)+"月 公共日程安排");
		
			if(window.top.document.getElementById("parentFrame").rows == "114,*,30")
			{
				SetCssStyle($('divList'),"float:right;height:"+listHeight+"px;overflow:auto;overflow-x:hidden;width:100%;");
			}
			else
			{
				SetCssStyle($('divList'),"float:right;height:"+(listHeight)+"px;overflow:auto;overflow-x:hidden;width:100%;");
			}
			
			$('divWeek').style.display = "none";
		}catch(err){
			//alert(errorMessage);
		}
	}
	
	
	/*--------------------------------------------------------------
		功能：通过日期取得该天的内容，用于显示在MonthView中
	--------------------------------------------------------------*/
	function GetUserCalendarContentByDate(date)
	{
		//循环，找出某日期下的日程
		var returnContent = "";
		//alert(date);
		var j = 1;
		for(var i = 0;i<arrUserCalendarContent.length;i++)
		{
			var arrTemp = new Array();
			arrTemp = arrUserCalendarContent[i].split(',');
			//alert(arrTemp[0]+" == "+date);
			if(arrTemp.length > 0 && arrTemp[0] == date)
			{
				//找到了
				if(j>3)break;
				returnContent += "<font style=\"color:#000;text-decoration:underline;\"><em>"+arrTemp[1]+"</em> "+arrTemp[2]+"</font><br/>";
				j++;
				//alert(returnContent);				
			}
		}
		return returnContent;
	}
	
	/*--------------------------------------------------------------
		功能：控制菜单
	--------------------------------------------------------------*/
	function ControlMenu()
	{
		//更改图片
		if($('imgTreeMenuControl').src.indexOf("up") > 0)
		{
			$('imgTreeMenuControl').src = "../images/down_arrow.gif";
		}
		else
		{
			$('imgTreeMenuControl').src = "../images/up_arrow.gif";
		}
		
		if(window.top.document.getElementById("parentFrame").rows == "114,*,30")
		{
			window.top.document.getElementById("parentFrame").rows = "0,*,30";
			SetCssStyle($('divList'),"float:right;height:"+(listHeight+114)+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}
		else
		{
			window.top.document.getElementById("parentFrame").rows = "114,*,30";
			SetCssStyle($('divList'),"float:right;height:"+listHeight+"px;overflow:auto;overflow-x:hidden;width:100%;");
		}		
		var viewtype = "";
		var radios = document.getElementsByName("radio");					
		for(var j=0 ;j<radios.length;j++)
		{
			if(radios[j].checked)
			{
				viewtype = radios[j].value;
			}
		}
		ChangeCalendarViewType(viewtype);
	}
	function ChangeFrameSize(){
		parent.location.href="default.jsp";
	}
	
	
</script>

</head>
<body bgcolor="#ffffff" onload="javascript:Init();" onresize="javascript:OnReSize();">
<!--<div id="box" style="width:100%;background-color:#eee;"><img id="imgTreeMenuControl" style="cursor:hand;" src="../images/up_arrow.gif" border="0" onclick="javascript:ControlMenu();"/></div>-->
<div class="nav">
<div style="width:40%;float:left;">

			<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0><TBODY><TR>
			<TD class=navigation>&nbsp;<IMG alt="" src="../images/icon.gif" align=baseline border=0>&nbsp;<font color=#052968><%= MipWebJSPUi.mipweb_user_admin_calendar_15 %></font><a href="main.jsp"><font color=#052968><%= MipWebJSPUi.mipweb_user_admin_calendar_16 %></font></a><font color=#052968>&nbsp;<IMG alt="" src="../images/next.gif" align=baseline border=0>&nbsp; </font><a href="admin_calendar.jsp"><font color=#052968><%= MipWebJSPUi.mipweb_user_admin_calendar_17 %></font></a></TD></TR></TBODY></TABLE>

</div>
<div style="width:60%;float:right;">
<div style="width:70%;float:left;text-align:left;" id="divTopic"></div>
<div style="width:30%;float:right;text-align:right;"><button class="button" onclick="javascript:LoadCreateCalendar('9:30');" style="height:20px;"><%= MipWebJSPUi.mipweb_user_admin_calendar_18 %></button></div>
</div></div>

<div id="maincenter">

<div id="divCal" style="width:15%;float:left;">

<div id="calendar"></div>
<div id="calendar2"></div>
<div id="divCalendarViewType" style="font-size:14px;font-weight:bolder;font-family:Tahoma;color:#036;padding:10px;text-align:left;padding-left:20px;">
<input class="input" type="radio" id="r1" value="day" name="radio" onclick="javascript:ChangeCalendarViewType(this.value);"><label for="r1"><%= MipWebJSPUi.mipweb_user_admin_calendar_19 %></label><br/>
<input class="input" type="radio" id="r2" value="week" name="radio" onclick="javascript:ChangeCalendarViewType(this.value);"><label for="r2"><%= MipWebJSPUi.mipweb_user_admin_calendar_20 %></label><br/>
<input class="input" type="radio" id="r3" value="month" name="radio" onclick="javascript:ChangeCalendarViewType(this.value);" checked><label for="r3"><%= MipWebJSPUi.mipweb_user_admin_calendar_21 %></label></div>

</div>

<div id="content" style="width:75%;float:left;">

<div style="width:100%;display:none;" id="divWeek"></div>
<div id="divList"></div>

</div>

</div>

</body>
</html>
