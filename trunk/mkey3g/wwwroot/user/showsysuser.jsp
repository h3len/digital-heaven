<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.Constants"%>
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
		
		<script type="text/javascript">
		var servertype='<%=DhServerNameUtils.Server_Name%>';
			var userid = '<%=request.getParameter("userid")%>';
			function showUser(){
				if(servertype=='<%=DhServerNameUtils.SERVER_EMA%>'){
					$('userctrlshow').style.display='';
					$('emoa_chk').style.display='';
				}else{
					$('userctrlshow').style.display='none';
					$('emoa_chk').style.display='none';
				}
				
			  Progress('<%= MipWebJSPUi.mipweb_user_showsysuser_1 %>','<%= MipWebJSPUi.mipweb_user_showsysuser_2 %>');
			  User2.showUser(userid,
					{
						callback:function(oMap) {
							CloseProgress();
							if(oMap["quota"]==null)
								oMap["quota"]="<%= MipWebJSPUi.mipweb_user_showsysuser_3 %>";
							dwr.util.setValues(oMap);
								
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_showsysuser_4 %>"+errorString);
						}
					});
			}
			window.onload=function(){
			//	getuserextend();
				showUser();
				getservicectrl();
				if(<%=DhServerNameUtils.isMKEY%>){
					$('tr_num').style.display='none';
				}else{
					$('tr_num').style.display='';
				}
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
							
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_showsysuser_5 %>"+errorString);
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
			function getservicectrl(){
				User2.getServiceCtrl(userid,
					{
						callback:function(oMap) {
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_showsysuser_6 %>"+errorString);
						}
					});
			}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">


		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_showsysuser_7 %></span>
		</div>

		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_showsysuser_8 %></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tbody id="user_table">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_9 %>
				</td>
				<td width="71%" id="username">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_10 %>
				</td>
				<td width="71%" id="truename">
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
					<%= MipWebJSPUi.mipweb_user_showsysuser_11 %>
				</td>
				<td width="71%" id="mobile">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modsysuser_52 %>
				</td>
				<td width="71%" id="mobiletype">
				</td>
			</tr>
			 <tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_12 %>
				</td>
				<td width="71%" id="quota1">
				</td>
			</tr>
			<tr style="display:none ">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_showsysuser_13 %>
					</td>
					<td width="80%">
						<input type="text" id="quota" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" size="9"/>
					</td>
			 </tr>
			 <tr id="tr_num">
					<td >
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td >
						<%= MipWebJSPUi.mipweb_user_showsysuser_14 %>
					</td>
					<td id="servicenum">
					</td>
			 </tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_15 %>
				</td>
				<td width="71%" id="companytel">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_16 %>
				</td>
				<td width="71%" id="hometel">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_17 %>
				</td>
				<td width="71%" id="city">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_18 %>
				</td>
				<td width="71%" id="email">
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_19 %>
				</td>
				<td width="71%" id="idtype">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_20 %>
				</td>
				<td width="71%" id="idno">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_21 %>
				</td>
				<td width="71%" id="usertype">
				</td>
			</tr>
			<tr id="userctrlshow">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_22 %>
				</td>
				<%if(DhServerNameUtils.isEMOA){ %>
				<%if(Constants.APP_AUTHEN_VALUE.equals("3")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("1")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%}else if(Constants.APP_AUTHEN_VALUE.equals("2")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("13")){%>
							<td width="71%" id="usertype">
								<input type="checkbox" id="oa" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} else if(Constants.APP_AUTHEN_VALUE.equals("12")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("23")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("123")){%>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else{%>
							<td width="71%" id="usertype">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
						<%}else{ %>
							<td  width="71%" id="usertype">
								<input type="checkbox" id="oa" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other" disabled></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
			</tr>
			<tr  id="emoa_chk">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_29 %>
				</td>
				<td width="71%" id="mobiletype">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_30 %>
				</td>
				<td width="71%" id="comment" style="word-break:break-all">
				</td>
			</tr>
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_showsysuser_31 %>
				</td>
				<td width="71%" id="createtime">
				</td>
			</tr>
			</tbody>
		</table>
	</body>
</html>
