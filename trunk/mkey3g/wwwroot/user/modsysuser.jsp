<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipMobileType"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
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
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">
			var userid = '<%=request.getParameter("userid")%>';
			var servertype='<%=DhServerNameUtils.Server_Name%>';
			var isSearch = <%=request.getParameter("isSearch")%> ;
			var checksernum = true;
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
							showUser()
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_1 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				getMobileType();
				getservicectrl();
				if(servertype=='<%=DhServerNameUtils.SERVER_EMA%>'){
					$('userctrlshow').style.display='';
				}else{
					$('userctrlshow').style.display='none';
				}
				if(<%=ServerConfig.hasTcCorePlugin&&!DhServerNameUtils.isMKEY%>){
					$('tr_num').style.display='';
				}else{
					$('tr_num').style.display='none';
				}
				getappname();
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
				otd2.innerHTML = "<input type=\"text\" id=\""+cid+"\"/>";
				oTr.appendChild(otd);
				oTr.appendChild(otd1);
				oTr.appendChild(otd2);
				obj.appendChild(oTr);
			}
			/************************************************************
				修改用户信息 
				version 1.0 武亮
				version 1.1 崔红保 2009-01-13 修改提示信息，合并重复代码
			***********************************************************/
			function modUser(){
				var cf = new CheckForm();
				var temp=cf.Trim($('username').value);
     			if(temp==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_2 %>");
				 	return false;
				 }
				 if(temp.indexOf("$")>-1||temp.indexOf("!")>-1||temp.indexOf("#")>-1||temp.indexOf("%")>-1||
					temp.indexOf("&")>-1||temp.indexOf("^")>-1||temp.indexOf("*")>-1||temp.indexOf("(")>-1||temp.indexOf(")")>-1){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_3 %>");
				 	 return false;
				 }
				 if(temp.length>50){
				    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_4 %>");
				 	return false;
				 }
				 temp=cf.Trim($('truename').value);
				  if(temp==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_5 %>");
				 	 return false;
				 }
				 if(temp.length>50){
				    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_6 %>");
				 	return false;
				 }
				var reg = /^(\+)?(\d)+$/
				var mailreg =  /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				 temp=cf.Trim($('mobile').value);	
				 if(temp==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_7 %>");
				 	 return false;
				 }else{
						if(!cf.IsTel($('mobile').value)){
						 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_8 %>");
				 	 	 return false;
						 }
				 	}
				 if($("quota").value!=""&&!cf.IsNumber($('quota').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_9 %>");
				 	 return false;
				 }
				 if($("quota").value=='<%= MipWebJSPUi.mipweb_user_modsysuser_10 %>'){
				 	$("quota").value=''
				 }
				  if(!checksernum){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_11 %>");
				 	 return false;
				 }
				 var regtel = /^(\+)?(86)?(\d){0,4}(\-)?(\d){6,16}$/;
				 if($('companytel').value!=""){
				 	if(!regtel.test($('companytel').value)){
						DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_12 %>");
						return ;
					}
				 }
				if($('hometel').value!=""){
					if(!regtel.test($('hometel').value)){
						DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_13 %>");
						return ;
					}
				}
				  temp=cf.Trim($('city').value);	
				 if(temp.length>50){
				    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_14 %>");
				 	return false;
				 }
				  //if(($('companytel').value!=''&&!reg.test($('companytel').value))||($('hometel').value!=''&&!reg.test($('hometel').value))){
				 	// DHalert("电话号码格式错误！");
				 	 //return false;
				 //}
				 
				 
				 if($('email').value!=''&&!mailreg.test($('email').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_15 %>");
				 	 return false;
				 }
				
				  //判断证件格式
				 var idtype = $('idtype').value;
				 if($('idno').value != '')
				 {
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_modsysuser_16 %>")
				 	{	
				 		var reg = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
				 		if(!reg.test($('idno').value)){
				 			DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_17 %>");
				 			return ;
				 		}
				 	}
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_modsysuser_18 %>")
				 	{
				 		if(!cf.IsNumber($('idno').value))
				 		{
				 			DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_19 %>");
				 			return;
				 		}
				 	}
				 }
				 var c1="";
				 var c2="";
				 var c3="";
				 var c4="";
				 var c5="";
				 if($('c1')!=undefined){
				 	c1 = $('c1').value;
				 }
				 if($('c2')!=undefined){
				 	c2 = $('c2').value;
				 }
				 if($('c3')!=undefined){
				 	c3 = $('c3').value;
				 }
				 if($('c4')!=undefined){
				 	c4 = $('c4').value;
				 }
				 if($('c5')!=undefined){
				 	c5 = $('c5').value;
				 }
				 var comment = $('comment').value;
				
				 if(servertype=='EMOA'&&!$('oa').checked&&!$('mail').checked&&!$('base').checked&&!$('together').checked&&!$('integation').checked&&!$('other').checked){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_20 %>");
				 	 return false;
				 }
				 var servicetype ="";
				 if($('oa').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mail').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('base').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('together').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integation').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('other').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
				if($('servicenum').value==''&&<%=ServerConfig.hasTcCorePlugin&&!DhServerNameUtils.isMKEY%>){
					Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_modsysuser_21 %>', function(btn){
					if(btn=='yes'){
								if(comment.length>40){
								 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_modsysuser_22 %>', function(btn){
										if(btn=='yes'){
											comment = comment.substr(0,40);	
											 Progress('<%= MipWebJSPUi.mipweb_user_modsysuser_23 %>','<%= MipWebJSPUi.mipweb_user_modsysuser_24 %>');
											_modsysuser(comment,c1,c2,c3,c4,c5,servicetype)
										}else{
											return false;	
										}
									});
								 }else{
								 	Progress('<%= MipWebJSPUi.mipweb_user_modsysuser_25 %>','<%= MipWebJSPUi.mipweb_user_modsysuser_26 %>');
											 _modsysuser(comment,c1,c2,c3,c4,c5,servicetype)
								 }	
							}
						}
						);
				}else{
					if(comment.length>40){
								 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_modsysuser_27 %>', function(btn){
										if(btn=='yes'){
											comment = comment.substr(0,40);	
											 Progress('<%= MipWebJSPUi.mipweb_user_modsysuser_28 %>','<%= MipWebJSPUi.mipweb_user_modsysuser_29 %>');
											 _modsysuser(comment,c1,c2,c3,c4,c5,servicetype)
										}else{
											return false;	
										}
									});
								 }else{
								 	Progress('<%= MipWebJSPUi.mipweb_user_modsysuser_30 %>','<%= MipWebJSPUi.mipweb_user_modsysuser_31 %>');
											 _modsysuser(comment,c1,c2,c3,c4,c5,servicetype)	
								 }	
				}
				
				
				  
				
			}
			function getMobileType(){
				MobileAction.getMoblicTypeList({
					callback:function(objxml) {
										var nodes = objxml.selectNodes("//item");
										for(var i=0;i<nodes.length;i++){
												var oOption = document.createElement("OPTION");
												oOption.text = nodes[i].getAttribute("mobiletype");
												oOption.value = nodes[i].getAttribute("id");			
												document.all?$('mobiletype').add(oOption):$('mobiletype').appendChild(oOption);
										}
										//getuserextend();
										showUser();
									},
									errorHandler:function(errorString, exception) {
										
									    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_32 %>"+errorString);
									}
				});
			}
			function showUser(){
			  Progress('<%= MipWebJSPUi.mipweb_user_modsysuser_33 %>','<%= MipWebJSPUi.mipweb_user_modsysuser_34 %>');
			  User2.showUser(userid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setEscapeHtml(false);
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_35 %>"+errorString);
						}
					});
			}
			function getservicectrl(){
				User2.getServiceCtrl(userid,
					{
						callback:function(oMap) {
						dwr.util.setEscapeHtml(false);
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_36 %>"+errorString);
						}
					});
			}
			function checknum(){
				if($('servicenum').value==''){
					checksernum=true;
					return;
				}
				var regnum = /^\d$/;
				if(!regnum.test($('servicenum').value)){
					$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_37 %>";
				}
				$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_38 %>";
				User2.checknum(userid,$('servicenum').value,{
						callback:function(otext) {
											CloseProgress();
											if(otext=="1"){
												$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_39 %>";
												checksernum=true;
											}else{
												$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_40 %>";
												checksernum=false;
											}
										},
										errorHandler:function(errorString, exception) {
											CloseProgress();
										    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_41 %>"+errorString);
										}
					})
			}
			function getCanUseServiceNum(){
				$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_42 %>";
				User2.getCanUseServiceNum({
						callback:function(data) {
							dwr.util.setValues(data);
							
							if($('servicenum').value==''){
								$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_43 %>";
							}else{
								$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_modsysuser_44 %>";
							}
							
							checksernum=true;
						},
						errorHandler:function(errorString, exception) {
							
						    //DHalert("添加用户失败，失败原因："+errorString);
						}
					});
			}
			function _modsysuser(comment,c1,c2,c3,c4,c5,servicetype){
				var old =new Array();
				var list=document.getElementsByName("oldappids")
				for(i=0;i<list.length;i++){
					old[i]=list[i].value;
				}
				var apps=DWRUtil.getValue("apps");
				if(apps==null||apps=="")
					apps=new Array();
				 User2.modUser(userid,$('username').value,$('mobile').value,$('truename').value,$('companytel').value,$('hometel').value,
											 $('city').value,$('idtype').value,$('idno').value,$('usertype').value,comment,$('email').value,
											 $('mobiletype').value,c1,c2,c3,c4,c5,servicetype,$("quota").value,$('servicenum').value,
											 "","","","","","","","","","","","","",apps,old,
												{
													callback:function(otext) {
														CloseProgress();
														if(otext=="1"){

															 if(isSearch==null||isSearch==""){
															 	parent.parent.ChangePage(parent.parent.pageid);
															 }else{
															 	if(!isSearch){
															 		parent.parent.ChangePage(parent.parent.pageid);
															 	}else{
															 		parent.parent.ChangeSearchPage(parent.parent.pageid);
															 	}
															 }

															 parent.parent.GB_CURRENT.hide()
														}else{
															DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_45 %>"+otext);
														}
													},
													errorHandler:function(errorString, exception) {
														CloseProgress();
													    DHalert("<%= MipWebJSPUi.mipweb_user_modsysuser_46 %>"+errorString);
													}
												});	
			}
			
		function getappname(){
	   	 	MipClientAppAction.getAllAppByUidEnterpriseid(userid,"<%=session.getAttribute("enterpriseid")%>",{
					callback:function(objXml) {
						DisplayTransformedXML(1, objXml, "../user/xslt/app_list.xsl",document.getElementById("applist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("获取数据失败，失败原因："+errorString);
					}
			});
 		}
		</script>
	</head>
	<body style="width: 100%;"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_modsysuser_47 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_modsysuser_48 %></span>
		</div>
		<table style="width: 100%;" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tbody id="user_table">
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_49 %>
					</td>
					<td width="71%">
						<input type="text" id="username" maxlength="50" class="input_text"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_50 %>
					</td>
					<td width="71%">
						<input type="text" id="truename" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
						*
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
						<%= MipWebJSPUi.mipweb_user_modsysuser_51 %>
					</td>
					<td width="71%">
						<input type="text" id="mobile" class="input_text"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" maxlength="20" />
						*
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_52 %>
					</td>
					<td class="padding_bottom_3" width="71%">
					<select id="mobiletype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
							<option value='<%=MipMobileType.MOBILE_TYPE_OTHER%>'>
								<%= MipWebJSPUi.mipweb_user_modsysuser_53 %>
							</option>
						</select>
						*
					</td>
				</tr>
				<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_modsysuser_54 %>
				</td>
				<td width="71%" id="quota1">
				</td>
				</tr>
				<tr style="display:none">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_55 %>
					</td>
					<td width="80%">
						<input type="text" id="quota" class="input_text" maxlength="5"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" size="9"/><font color="red"><small>提示:月配额超过30000条，系统默认为不限</small></font>
					</td>
				</tr>
				<tr id="tr_num">
					<td >
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td >
						<%= MipWebJSPUi.mipweb_user_modsysuser_56 %>
					</td>
					<td>
						<input type="text" id="servicenum" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onblur="checknum()"
							onmouseout="fEvent('mouseout',this)" size="9" />

						<span id="isok" style="color:red"></span><input type="button" value="<%= MipWebJSPUi.mipweb_user_modsysuser_57 %>" class="button_4" onclick="getCanUseServiceNum()"/>

					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_58 %>
					</td>
					<td width="71%">
						<input type="text" id="companytel" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_59 %>
					</td>
					<td width="71%">
						<input type="text" id="hometel" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)" 
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_60 %>
					</td>
					<td width="71%">
						<input type="text" id="city" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_61 %>
					</td>
					<td width="71%">
						<input type="text" id="email" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_62 %>
					</td>
					<td width="71%" class="padding_bottom_3">
					<select id="idtype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
							<option value="<%= MipWebJSPUi.mipweb_user_modsysuser_63 %>">
								<%= MipWebJSPUi.mipweb_user_modsysuser_64 %>
							</option>
							<option value="<%= MipWebJSPUi.mipweb_user_modsysuser_65 %>">
								<%= MipWebJSPUi.mipweb_user_modsysuser_66 %>
							</option>
							<option value="<%= MipWebJSPUi.mipweb_user_modsysuser_67 %>">
								<%= MipWebJSPUi.mipweb_user_modsysuser_68 %>
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_69 %>
					</td>
					<td width="71%">
						<input type="text" id="idno" class="input_text" maxlength="30"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_70 %>
					</td>
					<td width="71%" class="padding_bottom_3">
					<select id="usertype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
							<option value="WEB">
								WEB
							</option>
							<option value="WAP">
								WAP
							</option>
							<option value="CLIENT">
								CLIENT
							</option>
						</select>
					</td>
				</tr>
				<tr id="userctrlshow">
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_71 %>
					</td>
					<%if(DhServerNameUtils.isEMOA){ %>
					<%if(Constants.APP_AUTHEN_VALUE.equals("3")){%>
							<td  width="80%" class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("1")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%}else if(Constants.APP_AUTHEN_VALUE.equals("2")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("13")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} else if(Constants.APP_AUTHEN_VALUE.equals("12")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("23")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("123")){%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else{%>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
						<%}else{ %>
							<td  width="80%"  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="26%">
						<%= MipWebJSPUi.mipweb_user_modsysuser_78 %>
					</td>
					<td width="71%">
						<textarea id="comment" class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:50px"></textarea>
					</td>
				</tr>
				<tr>
					<td >
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td >
						<%= MipWebJSPUi.mipweb_user_addsysuser_122 %>
					</td>
					<td width="80%" class="padding_bottom_3" id="applist">
					</td>
				</tr>
			</tbody>
		</table>
		<div class="div_center">
			<input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_modsysuser_79 %>" onclick="modUser()" />
			<input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_modsysuser_80 %>"
				onclick="parent.parent.GB_CURRENT.hide()" />
		</div>

	</body>
</html>
