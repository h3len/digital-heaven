<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
</script>
	
		
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
		var flag=0;
			var userid = '<%=request.getParameter("userid")%>';
			function showUser(){
			  User2.showPersonalUser(userid,
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
						    DHalert("<%= MipWebJSPUi.mipweb_user_showpersonaluser_1 %>"+errorString);
						}
					});
			}
			
			window.onload=function(){
				//刚进来当然是要写扩展字段了
				if(flag==0){
				getPersonalUserExtend();
				}
				flag=1;
				
			}
			function getPersonalUserExtend(){
				 User2.getPersonalUserExtend(
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
						    DHalert("<%= MipWebJSPUi.mipweb_user_showpersonaluser_2 %>"+errorString);
						}
					});
			}
			function addTr(cc,cid){
				cc=dwr.util.escapeHtml(cc);
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
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_showpersonaluser_3 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_showpersonaluser_4 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tbody id="user_table">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_5 %>
				</td>
				<td width="51%" id="truename"></td>
				<td rowspan="12" style="text-align:">
					<img id="preview" style="text-align: center; height: 170px; width: 150px; border: 1px solid #ccc; font-size: 16px; word-break: break-all;"></img><br />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_7 %>
				</td>
				<td width="71%" id="mobile"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_8 %>
				</td>
				<td width="71%" id="short_num"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_9 %>
				</td>
				<td width="71%" id="companytel"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_10 %>
				</td>
				<td width="71%" id="hometel"></td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_11 %>
				</td>
				<td width="71%" id="city"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_6 %>
				</td>
				<td width="71%" id="email"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_12 %>
				</td>
				<td width="71%" id="birthday1">
				</td>
			</tr>
			<tr style="display:none ;">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_showpersonaluser_13 %>
					</td>
					<td width="80%">
						<input type="text" id="birthday2" />
						<img alt='<%= MipWebJSPUi.mipweb_user_showpersonaluser_14 %>'
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
			<tr>
				<td width="3%" >
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_15 %>
				</td>
				<td width="71%" id="sexes">
				</td>
			</tr>
			<tr style="display:none ;">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_showpersonaluser_16 %>
					</td>
					<td width="80%">
						<input type="radio" id="male" name="sex" value="1" /><%= MipWebJSPUi.mipweb_user_showpersonaluser_17 %> 
						<input type="radio" id="female" name="sex" value="0" /><%= MipWebJSPUi.mipweb_user_showpersonaluser_18 %>
					</td>
				</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_19 %>
				</td>
				<td width="71%" id="nationality">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_20 %>
				</td>
				<td width="71%" id="Origo">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_21 %>
				</td>
				<td width="71%" id="birthplace">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_22 %>
				</td>
				<td width="71%" id="position">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_23 %>
				</td>
				<td width="71%" id="political_status">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_24 %>
				</td>
				<td width="71%" id="education">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_25 %>
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
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_26 %>
				</td>
				<td width="71%" id="comment">
				<br /></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showpersonaluser_27 %>
				</td>
				<td width="71%" id="createtime">
				<br /></td>
			</tr>
			</tbody>
		</table>
	</body>
</html>
