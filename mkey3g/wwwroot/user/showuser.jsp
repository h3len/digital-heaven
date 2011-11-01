<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
	
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
	 
		<!-- 新的时间控件 -->
		<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
		<script type="text/javascript"src="../skin/calendar/lang/calendar-zh.js"></script>
		<link href="../skin/calendar/css/zpcal.css" rel="stylesheet"type="text/css" />
		<link href="../skin/calendar/website/css/template.css"	rel="stylesheet" type="text/css" />
		<link href="../skin/calendar/themes/winxp.css" rel="stylesheet"	type="text/css" />
		
		<script type="text/javascript">
			var userid = '<%=request.getParameter("userid")%>';
			var nowgroupid = '<%=request.getParameter("nowgroupid")%>' ;
			function showUser(){
			  Progress('<%= MipWebJSPUi.mipweb_user_showuser_1 %>','<%= MipWebJSPUi.mipweb_user_showuser_2 %>');
			  User2.showUser(userid,
					{
						callback:function(oMap) {
							if(oMap.photoName!=null&&oMap.photoName!=''){
								document.getElementById("preview").src="../userPhotoDownload.do?action=downLoadUserPhoto&filename="+oMap.photoName ;
							}else{
								document.getElementById("preview").src="../theme/images/none.gif" ;
							}
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_showuser_3 %>"+errorString);
							parent.parent.ChangePage(parent.parent.pageid);
						}
					});
			}
			window.onload=function(){
				getuserextend();
				
			}
			function getuserextend(){
			  //Progress('正在获取用户详情....','单位通讯录');
			  User2.getUserExtend(
					{
						callback:function(obj) {
							if(obj.c1!=''&&obj.c1!=null&&obj.c1!='null'){
								
								addTr(obj.c1,"c1");
							}
							if(obj.c2!=''&&obj.c2!=null&&obj.c2!='null'){
								addTr(obj.c2,"c2");
							}
							if(obj.c3!=''&&obj.c3!=null&&obj.c3!='null'){
								addTr(obj.c3,"c3");
							}
							if(obj.c4!=''&&obj.c4!=null&&obj.c4!='null'){
								addTr(obj.c4,"c4");
							}
							if(obj.c5!=''&&obj.c5!=null&&obj.c5!='null'){
								addTr(obj.c5,"c5");
							}
							showUser();
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_showuser_4 %>"+errorString);
						}
					});
			}
			function addTr(cc,cid){
				var obj = $('user_table');
				var oTr = document.createElement("tr");
				var otd = document.createElement("td");
				otd.width="3%";
				otd.innerHTML = "<img src=\"../skin/default/images/text_icon.gif\" />";
				var otd1 = document.createElement("td");
				otd1.width="26%";
				otd1.innerHTML = cc;
				var otd2 = document.createElement("td");
				otd2.width="71%";
				otd2.innerHTML = "<div id=\""+cid+"\"/>";
				oTr.appendChild(otd);
				oTr.appendChild(otd1);
				oTr.appendChild(otd2);
				obj.appendChild(oTr);
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_showuser_5 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_showuser_6 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tbody id="user_table">
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_7 %>
				</td>
				<td width="71%" id="username">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_8 %>
				</td>
				<td width="71%" id="truename">
				</td>
				<td rowspan="12" style="text-align:center">
						<img id="preview" 
						style="text-align: center; height: 170px; width: 150px; border: 1px solid #ccc; font-size: 16px; word-break: break-all;"></img><br />
				</td>
			</tr>
		
			<!-- 
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					部门代码
				</td>
				<td width="71%" id="enterprisecode">
				</td>
			</tr>
			 -->
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_9 %>
				</td>
				<td width="71%" id="mobile">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_10 %>
				</td>
				<td width="71%" id="short_num">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_11 %>
				</td>
				<td width="71%" id="companytel">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_12 %>
				</td>
				<td width="71%" id="hometel">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_13 %>
				</td>
				<td width="71%" id="city">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_14 %>
				</td>
				<td width="71%" id="email">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_15 %>
				</td>
				<td width="71%" id="idtype">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_16 %>
				</td>
				<td width="71%" id="idno">
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_17 %>
				</td>
				<td width="71%" id="usertype">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_18 %>
				</td>
				<td width="71%" id="mobiletype">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_19 %>
				</td>
				<td width="71%" id="birthday1">
				</td>
			</tr>
			<tr style="display:none ;">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_showuser_20 %>
					</td>
					<td width="80%">
						<input type="text" id="birthday2" />
						<img alt='<%= MipWebJSPUi.mipweb_user_showuser_21 %>'
													src='../skin/calendar/themes/icons/calendar2.gif'
													border='0' id='start'
													onmouseover="this.style.cursor='pointer'"
													onmouseout="this.style.cursor='default'" />
												<script type="text/javascript">
							var cal1 = new Zapatec.Calendar.setup({
							inputField     :    "birthday2",     // id of the input field
							singleClick    :     false,     // require two clicks to submit
							ifFormat       :    '%Y-%m-%d',     // format of the input field
							showsTime      :     true,     // show time as well as date
							button         :    "start"  // trigger button 
							});
					</script>
					</td>
				</tr>
			<tr style="display:none">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_showuser_22 %>
					</td>
					<td width="80%">
						<input type="radio" id="male" name="sex" value="1" /><%= MipWebJSPUi.mipweb_user_showuser_23 %> 
						<input type="radio" id="female" name="sex" value="0" /><%= MipWebJSPUi.mipweb_user_showuser_24 %>
					</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_25 %>
				</td>
				<td width="71%" id="sexes">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_26 %>
				</td>
				<td width="71%" id="nationality">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_27 %>
				</td>
				<td width="71%" id="Origo">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_28 %>
				</td>
				<td width="71%" id="birthplace">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_29 %>
				</td>
				<td width="71%" id="position">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_30 %>
				</td>
				<td width="71%" id="political_status">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_31 %>
				</td>
				<td width="71%" id="education">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_32 %>
				</td>
				<td width="71%" id="school">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					Q Q
				</td>
				<td width="71%" id="qq">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					MSN
				</td>
				<td width="71%" id="msn">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_33 %>
				</td>
				<td width="71%" id="comment">
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				<br /></td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showuser_34 %>
				<br /></td>
				<td width="71%" id="createtime">
				<br /></td>
			</tr>
			</tbody>
		</table>
	</body>
</html>
