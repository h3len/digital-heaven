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
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
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
		<script language="JavaScript">
 		//公共变量
   		var pageid =1;
   		var now_type=0;
   		
   		var newRegisterPageID=1;
   		var ab=[[registeredUsers,'用户注册总数'],[newRegisteredUsers,'	新增注册用户数']];
   		
        window.onload=function(){
        	DHTabPanel(ab,900,0,"tabs");
        }
        
        function registeredUsers(){
		 	now_type=0;
		 	$("new_registeredUsers_search").style.display="none";
		 	$("registeredUsers_search").style.display="";
		 	getRegisteredUsers();
	 	}
	 	
		 function newRegisteredUsers(){
		
		 	$("starttime").value="";
		 	$("endtime").value="";
		 	$("registeredUsers_search").style.display="none";
		 	$("new_registeredUsers_search").style.display="";
		 	now_type=1;
		 	getNewRegisteredUsers();
		 } 
		 
		 
        function getList(){
        	if(now_type==0){
        		getRegisteredUsers();
        	}else{
        		getNewRegisteredUsers();
        	}
        }
        
        
		function getRegisteredUsers()
		{
				Progress("正在读取数据....");
				
        MipUserStatisticsAction.getRegisteredUsersPage(pageid,$("enterpristname").value.trim(),{
						callback:function(objXml) {
							DisplayTransformedXML(1, objXml, "xslt/user_statistics_list.xsl",document.getElementById("divList"));
								CloseProgress();
							},
						errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert("操作失败！失败原因:"+exception.message);		
							}
				});
		}
		
		function getNewRegisteredUsers()
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
				MipUserStatisticsAction.getNewRegisteredUsersPage(newRegisterPageID,${"new_enterpristname"}.value.trim(),$("starttime").value,$("endtime").value,{
						callback:function(objXml) {
						
							DisplayTransformedXML(1, objXml, "xslt/newuser_statistics_list.xsl",document.getElementById("divList"));
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
        getList();
	   }
	   
	   function changeNewRegisterPage(pid){
	 
	   newRegisterPageID=pid;
	   getList();
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
	
	var widthDiv;
	var lastname="";
		
	function fuzzyQuery(obj,showid){
		widthDiv = obj.offsetWidth;//文本框的宽度，层随此宽度
		var uname = obj.value;
		if(uname.trim()==""){
			$(showid).style.display="none";
			return;
		}
		if(uname.trim()==lastname&&$(showid).style.display!="none")
			return;
		lastname=uname.trim();
		var id=obj.id;
		EnterpriseAction.searchEnterpriseName(uname.trim(),function(args){
		  if(args.length!=0){
			   var content = "<table width=100% bgcolor='white'>";
			   for(i=0;i<args.length;i++){
				    content+="<tr width=\"100%\" onmouseover=\"this.style.background='#9DB3C5'\" onmouseout=\"this.style.background=''\">";
				    content+="<td onmousedown=\"sel(this,'"+id+"','"+showid+"')\" style='cursor:hand'>";//添加点击事件和手形样式
				    content+=args[i];//内容
				    content+="</td></tr>";
			   }
			   content += "</table>";
			   $(showid).style.display="block";//显示层
			   $(showid).style.width=widthDiv;//设定层的宽度和文本框同宽
			   $(showid).innerHTML=content;
		   }else{
		   	   $(showid).style.display="none";
		   }
		});
	}
		
	function sel(obj,id,showid){
	   $(id).value=obj.innerHTML;//把点击选中的内容赋值给文本框
	   $(showid).style.display="none";//层隐藏
	}
	
	function fuzzyHidden(showid){
		$(showid).style.display="none";//层隐藏
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
							您现在所在位置 >> 系统维护>> 用户数统计
						</div>
					</div>
					<div id="tabs" style="border: 1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<table class="margin_left_5" id="registeredUsers_search">
									<tr>
										<td >
											企业名称:
										</td>
										<td>
											<input type="text" id="enterpristname" maxlength="50" onkeyup="fuzzyQuery(this,'fuzzyshow1')" onblur="fuzzyHidden('fuzzyshow1')"/>
										</td>
										<td colspan="2" align="center" height="25">

											<input type="image"
												onclick="javascript:ChangePage(1);" value="查询"
												src="../skin/default/images/button_search.gif" />
										</td>
									</tr>
									<tr>
									<td />
									<td>
										<div style="border:1px #9DB3C5 solid;position:absolute;display:none" id="fuzzyshow1" ></div>
									</td>
									<td colspan="2" />
									</tr>
								</table>
								<table class="margin_left_5" id="new_registeredUsers_search">
									<tr>
										<td >企业名称:</td>
										<td >
											<input type="text" id="new_enterpristname" maxlength="50" onkeyup="fuzzyQuery(this,'fuzzyshow2')" onblur="fuzzyHidden('fuzzyshow2')"/>
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
												onclick="javascript:ChangePage(1);" value="查询"
												src="../skin/default/images/button_search.gif" />
										</td>
									</tr>
									<tr>
										<td/>
										<td>
											<div style="border:1px #9DB3C5 solid;position:absolute;display:none" id="fuzzyshow2" ></div>
										</td>
										<td colspan="3"/>
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