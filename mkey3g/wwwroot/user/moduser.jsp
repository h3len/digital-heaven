<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.web.MobileType"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipMobileType"%>

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
			 var regtel = /^(\+)?(86)?(\d){1,4}(\-)?(\d){6,15}$/
			var userid = '<%=request.getParameter("userid")%>';
			var nowgroupid = '<%=request.getParameter("nowgroupid")%>' ;
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
						    DHalert("<%= MipWebJSPUi.mipweb_user_moduser_1 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				
				getMobileType();
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
				otd2.innerHTML = "<input type=\"text\" maxlength=\"30\" id=\""+cid+"\"/>";
				oTr.appendChild(otd);
				oTr.appendChild(otd1);
				oTr.appendChild(otd2);
				obj.appendChild(oTr);
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


			function addUser(){
				
				 
				var reg = /^(\+)?(86)?(\d){6,20}$/
				var mailreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				var cf=new CheckForm();
				var comment = $('comment').value;
				var shortNum = $('short_num').value ;
				var birthday = $('birthday2').value ;
				var sexes = document.getElementsByName("sex") ;
				var sex ;
				var nationality = $('nationality').value ;
				var Origo = $('Origo').value ;
				var birthplace = $('birthplace').value ;
				var position = $('position').value ;
				var political_status = $('political_status').value ;
				var education = $('education').value ;
				var school = $('school').value ;
				var QQ = $('qq').value ;
				var MSN = $('msn').value ;
				var photo = $('filepath').value ;
				 
			    if(cf.Trim($('truename').value)==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_moduser_2 %>");
				 	 return false;
				 }
				if($('truename').value.indexOf("$")>-1||$('truename').value.indexOf("!")>-1||$('truename').value.indexOf("@")>-1||
				 	$('truename').value.indexOf("#")>-1||$('truename').value.indexOf("%")>-1||$('truename').value.indexOf("&")>-1||
				 	$('truename').value.indexOf("^")>-1||$('truename').value.indexOf("*")>-1||$('truename').value.indexOf("(")>-1||
				 	$('truename').value.indexOf(")")>-1){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_moduser_3 %>");
				 	 return false;
				 }
				 if($('mobile').value==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_moduser_4 %>");
				 	 return false;
				 }
				 if(!reg.test($('mobile').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_moduser_5 %>");
				 	 return false;
				 }
				 	//判断手机号码
					
		    	var isValidate = cf.IsTel($('mobile').value);
				if(!isValidate){
					DHalert("<%= MipWebJSPUi.mipweb_user_moduser_6 %>");
					return ;
				}
				 var regsn=/^(\d){1,20}$/;
				 if(shortNum!=""){
				 	if(!regsn.test(shortNum)){
				 	 	DHalert("<%= MipWebJSPUi.mipweb_user_moduser_7 %>");
				 	 	return false;
				 	}
				 }
				  var regExt = /^\d{7,20}$/;
				 if(cf.Trim($('companytel').value)!=""&&!regExt.test(cf.Trim($('companytel').value))){
				 		DHalert("公司电话应为7-20位数字");
						return ;
				 }
				 
		/*		 if($('companytel').value!=""&&!regtel.test($('companytel').value)){			
						DHalert("<%= MipWebJSPUi.mipweb_user_moduser_8 %>");
						return ;
				}
		*/		
				if(cf.Trim($('hometel').value)!=""&&!regExt.test(cf.Trim($('hometel').value))){
				 		DHalert("家庭电话应为7-20位数字");
						return ;
				 }
		/*		 if($('hometel').value!=""&&!regtel.test($('hometel').value)){			
						DHalert("<%= MipWebJSPUi.mipweb_user_moduser_9 %>");
						return ;
				}
		*/		
				//判断邮箱格式
				 if($('email').value.trim()!=''){
				 if(!mailreg.test($('email').value)){
					DHalert("<%= MipWebJSPUi.mipweb_user_moduser_10 %>");
					return ;
				}
				}
				 //判断证件格式
				 var idtype = $('idtype').value;
				 if($('idno').value != '')
				 {
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_moduser_11 %>")
				 	{
				 		var reg = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
				 		//if(!cf.IsIdno($('idno').value))
				 		//{
				 			//DHalert("输入的身份证号码不正确!");
				 			//return;
				 		//}
				 		if(!reg.test($('idno').value)){
				 			DHalert("<%= MipWebJSPUi.mipweb_user_moduser_12 %>");
				 			return ;
				 		}
				 	}
				 	//不清楚军官证是什么格式,暂且就当都是数字吧.
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_moduser_13 %>")
				 	{
				 		if(!cf.IsNumber($('idno').value))
				 		{
				 			DHalert("<%= MipWebJSPUi.mipweb_user_moduser_14 %>");
				 			return;
				 		}
				 	}
				 	//工号的问题嘛...
				 	//if(idtype = "工号")
				 	//{
				 		//if(!cf.IsNumber($('idno').value))
				 		//{
				 			//DHalert("输入的工号格式不正确!");
				 			//return;
				 		//}
				 	//}	
				 }
				  
				if(birthday!=""){
					if(!IsValidDate(birthday)){
						DHalert("<%= MipWebJSPUi.mipweb_user_moduser_15 %>");
						return ;
					}
				}
				/*
				if(birthday!=""){
					var nowdate = new Date() ;
					var births = birthday.split('-') ;
					if(births[0]<=nowdate.getFullYear()){
						if(births[1]<=(nowdate.getMonth()+1)){
							if(births[2]>nowdate.getDate()){
								return false ;
							}
						}else{
							return false ;
						}
					}else{
						return false ;
					}
				}
				*/
				 var QQreg = /^[1-9]\d{0,19}$$/;
				 
				 if(QQ!=""){
				 	if(!QQreg.test(QQ)){		
						DHalert("<%= MipWebJSPUi.mipweb_user_moduser_19 %>") ;
				 		return ;
				 	}
				 }
				if(MSN!=""){
				 	if(!mailreg.test(MSN)){
						DHalert("<%= MipWebJSPUi.mipweb_user_moduser_20 %>");
						return ;
					}
				 }
				
				  //if(($('companytel').value!=''&&!reg.test($('companytel').value))||($('hometel').value!=''&&!reg.test($('hometel').value))){
				 	// DHalert("电话号码格式错误！");
				 	 //return false;
				 //}
			//	 alert($('email').value);
				 //if($('email').value!=''&&!mailreg.test($('email').value)){
				 	// DHalert("邮箱格式不正确！");
				 	 //return false;
				 //}
				 //if($('truename').value==''){
				 	// DHalert("真实姓名不能为空！");
				 	 //return false;
				 //}
				
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
				 
				 for(i = 0 ; i<sexes.length ; i++){
					if(sexes[i].checked == true){
						sex = sexes[i].value ;
					}
				}
				 var comment = $('comment').value;
				 if(comment.length>40){
				 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_moduser_21 %>', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,40);	
							 Progress('<%= MipWebJSPUi.mipweb_user_moduser_22 %>','<%= MipWebJSPUi.mipweb_user_moduser_23 %>');
							 User2.modUser(userid,'',$('mobile').value,$('truename').value,$('companytel').value,$('hometel').value,
							 $('city').value,$('idtype').value,$('idno').value,"CLIENT",comment,$('email').value,$('mobiletype').value,c1,c2,c3,c4,c5,"","","",
							 shortNum,birthday,sex,nationality,Origo,birthplace,position,political_status,education,school,QQ,MSN,photo,new Array(),new Array(),
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											// parent.parent.DHalert("修改联系人信息成功");
											 parent.parent.ChangePage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_moduser_24 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_moduser_25 %>"+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 	 Progress('<%= MipWebJSPUi.mipweb_user_moduser_26 %>','<%= MipWebJSPUi.mipweb_user_moduser_27 %>);
							  User2.modUser(userid,'',$('mobile').value,$('truename').value,$('companytel').value,$('hometel').value,
							 $('city').value,$('idtype').value,$('idno').value,"CLIENT",comment,$('email').value,$('mobiletype').value,c1,c2,c3,c4,c5,"","","",
							 shortNum,birthday,sex,nationality,Origo,birthplace,position,political_status,education,school,QQ,MSN,photo,new Array(),new Array(),
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											//parent.parent.DHalert("修改联系人信息成功");
											 parent.parent.ChangePage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_moduser_28 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_moduser_29 %>"+errorString);
									}
								});	
				 }
			}
			function getMobileType(){
				dwr.util.setEscapeHtml(false);
				MobileAction.getMoblicTypeList({
					callback:function(objxml) {
										var nodes = objxml.selectNodes("//item");
										for(var i=0;i<nodes.length;i++){
												var oOption = document.createElement("OPTION");
												oOption.text = nodes[i].getAttribute("mobiletype");
												oOption.value = nodes[i].getAttribute("id");			
												document.all?$('mobiletype').add(oOption):$('mobiletype').appendChild(oOption);
										}
										getuserextend();
									},
									errorHandler:function(errorString, exception) {
										
									    DHalert("<%= MipWebJSPUi.mipweb_user_moduser_30 %>"+errorString);
									}
				});
			}
			function showUser(){
			  Progress('<%= MipWebJSPUi.mipweb_user_moduser_31 %>','<%= MipWebJSPUi.mipweb_user_moduser_32 %>');
			  User2.showUser(userid,
					{
						callback:function(oMap) {
							if(oMap.photoName!=null&&oMap.photoName!=''){
								document.getElementById("preview").src="../userPhotoDownload.do?action=downLoadUserPhoto&filename="+oMap.photoName ;
								$('filepath').value = oMap.photoName ;
							}else{
								document.getElementById("preview").src="../theme/images/none.gif" ;
								$('filepath').value = "" ;
							}
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_moduser_33 %>"+errorString);
							parent.parent.ChangePage(parent.parent.pageid);
						}
					});
			}
			
//上传照片
function uploadimg(){
		parent.parent.newwindow1 =window.open("add_img.jsp","<%= MipWebJSPUi.mipweb_user_moduser_71 %>","height=150,width=500,top=100,left=200,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
		</script>
	</head>
	<body style="width:100%;"  onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		<div class="up_title" >
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_moduser_34 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_moduser_35 %></span>
		</div>
		<table style="width:65%;" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tbody id="user_table">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_36 %>
				</td>
				<td width="71%">
					<input type="text" id="truename" maxlength="10" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
							onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>*
				</td>
				<td rowspan="12" style="text-align:center">
						<img id="preview" 
						style="text-align: center; height: 170px; width: 150px; border: 1px solid #ccc; font-size: 16px; word-break: break-all;"></img><br />
						<input type="button" value="<%= MipWebJSPUi.mipweb_user_moduser_37 %>" onclick="uploadimg()"/>
						<input type="hidden" id="filepath" />
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
					<%= MipWebJSPUi.mipweb_user_moduser_38 %>
				</td>
				<td width="71%" >
					<input type="text" id="mobile" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>*
				</td>
			</tr>
			<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_39 %>
					</td>
					<td width="80%">
						<input type="text" id="short_num" class="input_text" maxlength="30"
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
					<%= MipWebJSPUi.mipweb_user_moduser_40 %>
				</td>
				<td width="71%">
					<select id="mobiletype" >
						<option value='<%=MipMobileType.MOBILE_TYPE_OTHER%>'><%= MipWebJSPUi.mipweb_user_moduser_41 %></option>
					</select>*
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_42 %>
				</td>
				<td width="71%" >
					<input type="text" id="companytel" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_43 %>
				</td>
				<td width="71%" >
					<input type="text" id="hometel" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="20"/>
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_44 %>
				</td>
				<td width="71%">
					<input type="text" id="city" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="50"/>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_45 %>
				</td>
				<td width="71%">
					<input type="text" id="email" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)" maxlength="50"/>
				</td>
			</tr>
			 <tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_46 %>
				</td>
				<td width="71%" >
					<select id="idtype">
						<option value="<%= MipWebJSPUi.mipweb_user_moduser_47 %>" ><%= MipWebJSPUi.mipweb_user_moduser_50 %></option>
						<option value="<%= MipWebJSPUi.mipweb_user_moduser_48 %>" ><%= MipWebJSPUi.mipweb_user_moduser_51 %></option>
						<option value="<%= MipWebJSPUi.mipweb_user_moduser_49 %>" ><%= MipWebJSPUi.mipweb_user_moduser_52 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_53 %>
				</td>
				<td width="71%" >
					<input type="text" maxlength="18" id="idno" class="input_text" onmouseover="fEvent('mouseover',this)"onfocus="fEvent('focus',this)"
onblur="fEvent('blur',this)"onmouseout="fEvent('mouseout',this)"/>
				</td>
			</tr>
			<tr style="display:none ;">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_54 %>
				</td>
				<td width="71%" id="birthday1">
				</td>
			</tr>
			<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_55 %>
					</td>
					<td width="80%">
						<input type="text" id="birthday2" />
						<img alt='<%= MipWebJSPUi.mipweb_user_moduser_56 %>'
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
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_57 %>
					</td>
					<td width="80%">
						<input type="radio" id="male" name="sex" value="1" /><%= MipWebJSPUi.mipweb_user_moduser_58 %> 
						<input type="radio" id="female" name="sex" value="0" /><%= MipWebJSPUi.mipweb_user_moduser_59 %>
					</td>
				</tr>
				<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_moduser_60 %>
				</td>
				<td width="71%" id="sexes">
				</td>
			</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_61 %>
					</td>
					<td width="80%">
						<input type="text" id="nationality" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_62 %>
					</td>
					<td width="80%">
						<input type="text" id="Origo" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_63 %>
					</td>
					<td width="80%">
						<input type="text" id="birthplace" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_64 %>
					</td>
					<td width="80%">
						<input type="text" id="position" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_65 %>
					</td>
					<td width="80%">
						<input type="text" id="political_status" class="input_text" maxlength="30"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_66 %>
					</td>
					<td width="80%">
						<input type="text" id="education" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_moduser_67 %>
					</td>
					<td width="80%">
						<input type="text" id="school" class="input_text" maxlength="50"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						Q Q
					</td>
					<td width="80%">
						<input type="text" id="qq" class="input_text" maxlength="20"
							onmouseover="fEvent('mouseover',this)"
							onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
							onmouseout="fEvent('mouseout',this)" />
					</td>
				</tr>
				<tr>
					<td width="3%">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						MSN
					</td>
					<td width="80%">
						<input type="text" id="msn" class="input_text" maxlength="30"
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
					<%= MipWebJSPUi.mipweb_user_moduser_68 %>
				</td>
				<td width="71%" >
					<textarea id="comment"></textarea>
				</td>
			</tr>
			</tbody>
		</table>
		<div class="div_center"> <input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_moduser_69 %>" onclick ="addUser()" /><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_moduser_70 %>" onclick ="parent.parent.GB_CURRENT.hide()" /></div>

	</body>
</html>
