<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@ page import="com.dheaven.mip.util.Constants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户登陆统计</title>
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
		<script src="../dwr/interface/MipUserLoginAction.js" type="text/javascript"></script>
		<script>
		var pageid=1 ;
		window.onload=function(){
			if(<%=Constants.userstatistics %>){
				showInstanceuser() ;
			}else{
				DHalert("您不具备此模块的访问权限!") ;
				return ;
			}
 		}
 		
		function showInstanceuser(){
			Progress("正在载入数据...","提示");
			var starttime = $('starttime').value;
			var endtime = $('endtime').value ;
			if(starttime!=null&&starttime!=''){
				if(!IsValidDate(starttime)){
					DHalert("起始时间格式不正确！");
					return ;
				}
				if(endtime==null||endtime==''){
					DHalert("请您输入结束时间!") ;
					return ;
				}
			}
			if(endtime!=null&&endtime!=''){
				if(!IsValidDate(endtime)){
					DHalert("结束时间格式不正确！");
					return ;
				}
				if(starttime==null||starttime==''){
					DHalert("请您输入起始时间!") ;
					return ;
				}
			}
			MipUserLoginAction.showInstanceuser("",starttime,endtime,pageid,
				{
					callback:function(objXml) {
						CloseProgress();
						DisplayTransformedXML(1, objXml, "../user/xslt/mip_user_login_list.xsl",document.getElementById("user_statistics"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("获取数据失败,失败原因:"+errorString);
					}
				}
			);
		}
		function ChangePage(pid){
			pageid = pid;
			showInstanceuser();
		}
		
		//判断日期格式
	function IsValidDate(DateStr)    
	{    
	    var sDate=DateStr.replace(/(^\s+|\s+$)/g,''); //去两边空格;  
	    if(sDate=='') return true;    
	    //如果格式满足YYYY-(/)MM-(/)DD或YYYY-(/)M-(/)DD或YYYY-(/)M-(/)D或YYYY-(/)MM-(/)D就替换为''    
	    //数据库中，合法日期可以是:YYYY-MM/DD(2003-3/21),数据库会自动转换为YYYY-MM-DD格式    
	    var s = sDate.replace(/[\d]{4,4}[\-]{1}[\d]{1,2}[\-]{1}[\d]{1,2}/g,'');  
	    if (s=='') //说明格式满足YYYY-MM-DD或YYYY-M-DD或YYYY-M-D或YYYY-MM-D    
	    {    
	        var t=new Date(sDate.replace(/\-/g,'/'));    
	        var ar = sDate.split(/[-/:]/);    
	        if(ar[0] != t.getFullYear()||ar[1]!= t.getMonth()+1 ||ar[2]!=t.getDate())    
	        {    
	            //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
	            return false;    
	        }    
	    }    
	    else    
	    {    
	        //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
	        return false;    
	    }    
	    return true;    
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
				<div id="center_nav">您现在所在位置 >> 统计管理 >> 用户登录统计</div>
			</div>

			<div id="mainbox">
			<%if(Constants.userstatistics){%>
				<div class="center_list_box">
					<div class="center_list">
							<table id="lookup" width="100%" width="100%" border="0"
								cellspacing="0" cellpadding="0">
								<tr>
									 <td width="20%">起始时间：</td>
					                 <td width="30%">
										<input type="text" id="starttime" />
										<img alt='从日历选择'
																	src='../skin/calendar/themes/icons/calendar2.gif'
																	border='0' id='start'
																	onmouseover="this.style.cursor='pointer'"
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
					                 <td width="20%"><div align="center">结束时间：</div></td>
					                 <td width="30%">
										<input type="text" id="endtime" />
										<img alt='从日历选择'
																	src='../skin/calendar/themes/icons/calendar2.gif'
																	border='0' id='startt'
																	onmouseover="this.style.cursor='pointer'"
																	onmouseout="this.style.cursor='default'" />
																<script type="text/javascript">
											var cal1 = new Zapatec.Calendar.setup({
											inputField     :    "endtime",     // id of the input field
											singleClick    :     false,     // require two clicks to submit
											ifFormat       :    '%Y-%m-%d',     // format of the input field
											showsTime      :     true,     // show time as well as date
											button         :    "startt"  // trigger button 
											});
									</script>
									</td>
									 <td>
										<input type="button" class="button_2" value="查询" onclick="showInstanceuser()" />
									 </td>
								</tr>
								<tr>
									<td width="80%" colspan="5" >
										<div id="user_statistics"></div>
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
								
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
	
</html>
