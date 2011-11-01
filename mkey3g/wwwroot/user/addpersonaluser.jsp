<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*" %>
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
			var groupid = '<%=request.getParameter("groupid")%>';
			function getuserextend(){
			  //Progress('正在获取用户详情....','单位通讯录');
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
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_1 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				getuserextend();
				//getMobileType();
			}
			function addTr(cc,cid){
				cc=dwr.util.escapeHtml(cc);
				var obj = $('user_table');
				var oTr = document.createElement("tr");
				var otd = document.createElement("td");
				otd.width="33%";
				otd.align="right";
				otd.innerHTML = "<img src=\"../skin/default/images/text_icon.gif\" />";
				var otd1 = document.createElement("td");
				otd1.width="13%";
				otd1.innerHTML = cc;
				var otd2 = document.createElement("td");
				otd2.width="54%";
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
			     var reg = /^(\+)?(86)?(\d){6,20}$/;
			     var mailreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				 var cf=new CheckForm();
				 if(cf.Trim($('truename').value)==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_2 %>");
				 	 return false;
				 }
				 if($('truename').value.indexOf('&')>-1||$('truename').value.indexOf('%')>-1){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_3 %>");
				 	return false;
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
				 
				 var shortNum = $('short_num').value ;
				 var birthday = $('birthday').value ;
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
				 
				 if($('truename').value.indexOf("$")>-1){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_4 %>");
				 	 return false;
				 }
				 if($('mobile').value!=''){
					 $('mobile').value = $('mobile').value.replace(/\s/ig,''); 
					 if(!reg.test($('mobile').value)){
					 	DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_5 %>");
				 		 return false;
					 }
				 }
				 var regsn=/^(\d){1,20}$/;
				 if(shortNum!=""){
				 	if(!regsn.test(shortNum)){
				 	 	DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_6 %>");
				 	 	return false;
				 	}
				 }
				 
				 /*var regtel = /^(\+)?(86)?(\d){1,4}(\-)?(\d){6,20}$/;
				 if($('companytel').value!=""){
				 	if(!regtel.test($('companytel').value)){
						DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_7 %>");
						return ;
					}
				 }*/
				 var regExt = /^\d{7,20}$/; 
				 if(cf.Trim($('companytel').value)!=""&&!regExt.test(cf.Trim($('companytel').value))){
				 		DHalert("公司电话应为7-20位数字");
						return ;
				 }
				/*if($('hometel').value!=""){
					if(!regtel.test($('hometel').value)){
						DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_8 %>");
						return ;
					}
				}*/
				 if(cf.Trim($('hometel').value)!=""&&!regExt.test(cf.Trim($('hometel').value))){
				 		DHalert("家庭电话应为7-20位数字");
						return ;
				 }
				 //if(($('companytel').value!=''&&!reg.test($('companytel').value))||($('hometel').value!=''&&!reg.test($('hometel').value))){
				 	// DHalert("电话号码格式错误！");
				 	// return false;
				// }
				 if($('email').value!=''&&!mailreg.test($('email').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_9 %>");
				 	 return false;
				 }
				 if(MSN!=""){
				 	if(!mailreg.test(MSN)){
						DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_10 %>");
						return ;
					}
				 }
				 
				 if(birthday!=""){
					if(!IsValidDate(birthday)){
						DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_11 %>");
						return ;
					}
				}
				
				if(birthday!=""){
					var nowdate = new Date() ;
					var births = birthday.split('-') ;
					if(births[0]<=nowdate.getFullYear()){
						if(births[1]<=(nowdate.getMonth()+1)){
							if(births[2]>nowdate.getDate()){
								DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_12 %>");
								return false ;
							}
						}else{
							DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_13 %>");
							return false ;
						}
					}else{
						DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_14 %>");
						return false ;
					}
				}
				 
				 var QQreg = /^[1-9]\d{0,19}$$/;
				 
				 if(QQ!=""){
				 	if(!QQreg.test(QQ)){
				 		DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_15 %>") ;
				 		return ;
				 	}
				 }
				 for(i = 0 ; i<sexes.length ; i++){
					if(sexes[i].checked == true){
						sex = sexes[i].value ;
					}
				 }
				 var comment = $('comment').value;
				 if(comment.length>40){
				 	 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_addpersonaluser_16 %>', function(btn){
					if(btn=='yes'){
							comment = comment.substring(0,40);	
							 Progress('<%= MipWebJSPUi.mipweb_user_addpersonaluser_17 %>','<%= MipWebJSPUi.mipweb_user_addpersonaluser_18 %>');
							 User2.addPersonalUser(groupid,$('truename').value,$('mobile').value,$('companytel').value,$('hometel').value,
							 $('city').value,comment,$('email').value,c1,c2,c3,c4,c5,
							 shortNum,birthday,sex,nationality,Origo,birthplace,position,political_status,education,school,QQ,MSN,photo,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											// DHalert("添加联系人信息成功");
											 parent.parent.ChangePage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_19 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_20 %>"+errorString);
									}
								});	
							}else{
							return false;	
							}
						}
						);
				 }else{
				 	 Progress('<%= MipWebJSPUi.mipweb_user_addpersonaluser_21 %>','<%= MipWebJSPUi.mipweb_user_addpersonaluser_22 %>');
							  User2.addPersonalUser(groupid,$('truename').value,$('mobile').value,$('companytel').value,$('hometel').value,
							 $('city').value,comment,$('email').value,c1,c2,c3,c4,c5,
							 shortNum,birthday,sex,nationality,Origo,birthplace,position,political_status,education,school,QQ,MSN,photo,
								{
									callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											// DHalert("添加联系人信息成功");
											 parent.parent.ChangePage(parent.parent.pageid);
											 parent.parent.GB_CURRENT.hide()
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_23 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_24 %>"+errorString);
									}
								});	
				 }
			}
			function getMobileType(){
				Mas2.getMoblicTypeList({
					callback:function(objxml) {
										var nodes = objxml.selectNodes("//item");
										for(var i=0;i<nodes.length;i++){
												var oOption = document.createElement("OPTION");
												oOption.text = nodes[i].getAttribute("mobiletype");
												oOption.value = nodes[i].getAttribute("id");			
												document.all?$('mobiletype').add(oOption):$('mobiletype').appendChild(oOption);
										}
									},
									errorHandler:function(errorString, exception) {
										
									    DHalert("<%= MipWebJSPUi.mipweb_user_addpersonaluser_25 %>"+errorString);
									}
				});
			}
			
//上传照片
function uploadimg(){
		parent.parent.newwindow1 =window.open("add_img.jsp","<%= MipWebJSPUi.mipweb_user_addpersonaluser_26 %>","height=150,width=500,top=100,left=200,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

		
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_addpersonaluser_28 %></span>
		</div>
		<table width="80%" border="0"  >
			<tbody id="user_table">
			<tr>
				<td width="13%" align="right"  style="margin-left:80px ;">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_29 %>				</td>
			  <td width="44%" >
					<input type="text" id="truename" maxlength="10"/> 
				  &nbsp;<span class="red">*</span>			  </td>
				<td rowspan="12" style="text-align:center">
					<img id="preview" src ="../theme/images/none.gif"
					style="text-align: center; height: 170px; width: 150px; border: 1px solid #ccc; font-size: 16px; word-break: break-all;"></img><br />
					<input type="button" value="<%= MipWebJSPUi.mipweb_user_addpersonaluser_30 %>" onclick="uploadimg()"/>
					<input type="hidden" id="filepath" />
				</td>
			</tr>
			 <tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_31 %>				</td>
				<td width="54%" >
					<input type="text" id="mobile" maxlength="20"/>
			   </td>
			</tr>
			<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_32 %>
					</td>
					<td width="80%">
						<input type="text" id="short_num" maxlength="20" />
					</td>
				</tr>
			 <tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_33 %>				</td>
				<td width="54%" >
					<input type="text" id="companytel" maxlength="20"/>
			   </td>
			</tr>
			<tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_34 %>				</td>
				<td width="54%" >
					<input type="text" id="hometel" maxlength="20"/>
			  </td>
			</tr>
			 <tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_35 %>				</td>
				<td width="54%">
					<input type="text" id="city" maxlength="40"/>
			   </td>
			</tr>
			<tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_36 %>				</td>
				<td width="54%">
					<input type="text" id="email" maxlength="40"/>
			  </td>
			</tr>
			<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_37 %>
					</td>
					<td width="80%">
						<input type="text" id="birthday" />
						<img alt='<%= MipWebJSPUi.mipweb_user_addpersonaluser_38 %>'
													src='../skin/calendar/themes/icons/calendar2.gif'
													border='0' id='start'
													onmouseover="this.style.cursor='pointer'"
													onmouseout="this.style.cursor='default'" />
												<script type="text/javascript">
							var cal1 = new Zapatec.Calendar.setup({
							inputField     :    "birthday",     // id of the input field
							singleClick    :     false,     // require two clicks to submit
							ifFormat       :    '%Y-%m-%d',     // format of the input field
							showsTime      :     true,     // show time as well as date
							button         :    "start"  // trigger button 
							});
					</script>
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_39 %>
					</td>
					<td width="80%">
						<input type="radio" id="male" name="sex" value="1" checked="checked" /><%= MipWebJSPUi.mipweb_user_addpersonaluser_40 %> 
						<input type="radio" id="female" name="sex" value="0" /><%= MipWebJSPUi.mipweb_user_addpersonaluser_41 %>
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_42 %>
					</td>
					<td width="80%">
						<input type="text" id="nationality" maxlength="30" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_43 %>
					</td>
					<td width="80%">
						<input type="text" id="Origo" maxlength="30" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_44 %>
					</td>
					<td width="80%">
						<input type="text" id="birthplace" maxlength="30" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_45 %>
					</td>
					<td width="80%">
						<input type="text" id="position" maxlength="20" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_46 %>
					</td>
					<td width="80%">
						<input type="text" id="political_status" maxlength="30" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_47 %>
					</td>
					<td width="80%">
						<input type="text" id="education" maxlength="20" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						<%= MipWebJSPUi.mipweb_user_addpersonaluser_48 %>
					</td>
					<td width="80%">
						<input type="text" id="school" maxlength="30" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						Q Q
					</td>
					<td width="80%">
						<input type="text" id="qq" maxlength="20" />
					</td>
				</tr>
				<tr>
					<td width="3%" align="right">
						<img src="../skin/default/images/text_icon.gif" />
					</td>
					<td width="17%">
						MSN
					</td>
					<td width="80%">
						<input type="text" id="msn" maxlength="30" />
					</td>
				</tr>
			<tr>
				<td width="33%" align="right">
					<img src="../skin/default/images/text_icon.gif" />				</td>
				<td width="13%">
					<%= MipWebJSPUi.mipweb_user_addpersonaluser_49 %>				</td>
				<td width="54%" >
					<input type="text" id="comment"/>
			  </td>
			</tr>
			
			</tbody>
	</table>
		<div class="div_center"><input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_addpersonaluser_50 %>" onclick ="addUser()" />&nbsp;&nbsp;&nbsp;<input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_addpersonaluser_51 %>" onclick ="parent.parent.GB_CURRENT.hide()" /></div>

	</body>
</html>
