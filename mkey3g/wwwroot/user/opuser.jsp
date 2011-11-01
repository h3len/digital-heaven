<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%= MipWebJSPUi.mipweb_user_opuser_1 %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
	
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript">
 		 /*****************************************
 		 功能说明：统计日志
 		 *******************************************/
 		window.onload=function(){
 		
 		var tabs = new Ext.TabPanel({		        
				        activeTab: 0,
				        frame:true,
				        defaults:{autoHeight: true},
				        renderTo: 'tabcard',
				        items:[
				         	{
				            title: '<%= MipWebJSPUi.mipweb_user_opuser_2 %>',
				            listeners: {activate: impuser},
				             html:'<div id="biz1"></div>',
				            id:'tabGOTONE'		            
				            },
				            {
				            title: '<%= MipWebJSPUi.mipweb_user_opuser_3 %>',
				            listeners: {activate: expuser},
				            html:'<div id="biz2"></div>',
				            id:'tabMZONE'
				            }
				        ]
				  	 	 });
				  	 	 
			loadBranch();
 		}
 		function showmenu(){
			document.getElementById("center_left").style.display='block';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
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
	
	function loadBranch(){
		Progress('<%= MipWebJSPUi.mipweb_user_opuser_4 %>','<%= MipWebJSPUi.mipweb_user_opuser_5 %>');
		User2.getAllGroupList({
				callback:function(olist) {
						CloseProgress();
						for(i=0;i<olist.length;i++){
							var ss=olist[i].split(":::");
							var op=document.createElement("option");
							op.value=ss[0];
							op.text=ss[1];
							document.all?$("groups").add(op):$("groups").appendChild(op);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_opuser_6 %>"+errorString);
					}
		});
	}
//导入用户
function impuser(){
$('impview').style.display="";
$('expview').style.display="none";
}
//导出用户
function expuser(){
$('expview').style.display="";
$('impview').style.display="none";
}

   //根据类型导出用户
	function exportdoc(){
       		if(document.getElementById("expexcel").checked==true){
       			window.location.href="../masuser.do?action=exportExcel&type=excel&groupid="+$("groups").value+"&subgroup="+$("subgroup").checked;
       		}else if(document.getElementById("exptxt").checked==true){
       			window.location.href="../masuser.do?action=exportExcel&type=csv&groupid="+$("groups").value+"&subgroup="+$("subgroup").checked;
       			}
       	}
     //上传导入文件
	  function upload(){
	  		Progress("<%= MipWebJSPUi.mipweb_user_opuser_7 %>","<%= MipWebJSPUi.mipweb_user_opuser_8 %>");
	       	if(document.getElementById("impexcel").checked==true){
		       		document.getElementById('ftype').value="excel";
	       		}
	       		if(document.getElementById("imptxt").checked==true){
		       		document.getElementById('ftype').value="txt";
	       		}
				var file=document.getElementById('file').value;
				if($('file').value == ''){
					DHalert("<%= MipWebJSPUi.mipweb_user_opuser_9 %>");
					return ;
				}
				var file_type=file.substring(file.lastIndexOf(".")+1);
				if(document.getElementById("impexcel").checked==true){
					document.getElementById("prompt1").style.display="block" ;
					document.getElementById("prompt2").style.display="none" ;
					if(file_type.toLowerCase()!="xls"&&file_type.toLowerCase()!="xlsx"){
						CloseProgress();
						DHalert('<%= MipWebJSPUi.mipweb_user_opuser_10 %>');
						return;
					}	
				}
				if(document.getElementById("imptxt").checked==true){
					document.getElementById("prompt1").style.display="none" ;
					document.getElementById("prompt2").style.display="" ;
					if(file_type!="txt"){
						CloseProgress();
						DHalert('<%= MipWebJSPUi.mipweb_user_opuser_11 %>');
						return;
					}	
				}
			form1.submit();
	}
    					
    	  	function forexample(type){
    		if(type=="excel"){
       			window.location.href="../masuser.do?action=forexample&type=excel";
       		}else if(type=="csv"){
       			window.location.href="../masuser.do?action=forexample&type=csv";
       		}
    	}
    	
	
	function changeprompt1(){
		if(document.getElementById("impexcel").checked==true){
			document.getElementById("prompt1").style.display="block" ;
			document.getElementById("prompt2").style.display="none" ;
		}
	}
	
	function changeprompt2(){
		if(document.getElementById("imptxt").checked==true){
			document.getElementById("prompt1").style.display="none" ;
			document.getElementById("prompt2").style.display="block" ;
		}
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
					<table width="100%" height="29" border="0" cellpadding="0"
						cellspacing="0" background="../../theme/images/alert_bg.gif">
						<%--
						<tr>
							<td width="1%">
								<img src="../theme/images/alert_left.gif" width="5" height="29" />
							</td>
							<td width="2%">
								<img src="../theme/images/alert_bug.gif" />
							</td>
							<td width="90%">
								<a href="#">日志统计</a>
							</td>
							<td width="2%">
								<a href="#"><img src="../theme/images/alert_right.gif"
										width="24" height="29" border="0" />
								</a>
							</td>
						</tr>
						--%>
					</table>
<div id="center_nav_box">
	<div id="center_nav"><%= MipWebJSPUi.mipweb_user_opuser_12 %></div>
</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<div id="tabcard"></div>

								<table id="expview" style="display: none" width="100%"
									border="0" align="center" cellpadding="0" cellspacing="5">
									<tr>
										<td width="3%">
											<img src="../skin/default/images/text_icon.gif" />
										</td>
										<td width="26%">
											<%= MipWebJSPUi.mipweb_user_opuser_13 %>
										</td>
										<td width="71%">
											<input type="radio" id="expexcel" name="exptype" checked="true" />
											<%= MipWebJSPUi.mipweb_user_opuser_14 %>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="exptxt" name="exptype" />
											<%= MipWebJSPUi.mipweb_user_opuser_15 %>
										</td>
									</tr>
									<tr class="height25">
										<td width="3%">
											<img src="../skin/default/images/text_icon.gif" />
										</td>
										<td width="26%">
											<%= MipWebJSPUi.mipweb_user_opuser_16 %>
										</td>
										<td width="71%">
											<select id="groups">
											</select>
											<input type="checkbox" id="subgroup" checked="checked"><%= MipWebJSPUi.mipweb_user_opuser_17 %>
										</td>
									</tr>
									<tr>
										<td colspan="2" align="center">
											
										</td>
										<td colspan="71%" align="left">
											<input type="button" class="button_5" value="<%= MipWebJSPUi.mipweb_user_opuser_18 %>" onclick="exportdoc()" size="10" />
										</td>
									</tr>
								</table>
								<%-- 导入用户--%>
								<br><br><div id="impview" style="display: none">
									<form id="form1" method="post" action="../userimport.do"
										enctype="multipart/form-data">
										<table width="100%" border="0" align="center" cellpadding="0"
											cellspacing="5">
											<tr>
												<td colspan="3" style="">
													<font color=#ff0000>
														<%= MipWebJSPUi.mipweb_user_opuser_19 %></font>
												<br><br></td>
											</tr>
											<tr>
												<td width="3%">
													<img src="../skin/default/images/text_icon.gif" />
												<br><br></td>
												<td width="26%">
													<%= MipWebJSPUi.mipweb_user_opuser_20 %>
												<br><br></td>
												<td width="71%">
													<input type="radio" id="impexcel" name="filetype"
														checked="true" onclick="changeprompt1()" />
													<%= MipWebJSPUi.mipweb_user_opuser_21 %>
													<a id="example" href="#" onclick="forexample('excel')"
														class="blue_12"><%= MipWebJSPUi.mipweb_user_opuser_22 %></a> 
													<input type="radio" id="imptxt" name="filetype" onclick="changeprompt2()"  />
													<%= MipWebJSPUi.mipweb_user_opuser_23 %>
													<a id="example" href="#" onclick="forexample('csv')"
														class="blue_12"><%= MipWebJSPUi.mipweb_user_opuser_24 %></a>
												<br><br></td>
											</tr>
											<tr>
												<td width="3%">
													<img src="../skin/default/images/text_icon.gif" />
												<br><br></td>
												<td width="26%">
													<%= MipWebJSPUi.mipweb_user_opuser_25 %>
												<br><br></td>
												<td width="71%">
													<input id="file" type="file" NAME="file"
														onpaste="return   false"   onkeydown="return   false" style="width: 300px;">
													<input id="ftype" name="ftype" type="hidden">
												<br><br></td>
											</tr>
											<tr>
													<td colspan="3" >
														<div id = "prompt1">
														<font color=#ff0000> <%= MipWebJSPUi.mipweb_user_opuser_26 %></font>
														</div>
														<div id = "prompt2" style="display:none ">
														<font color=#ff0000> <%= MipWebJSPUi.mipweb_user_opuser_27 %></font>
														</div>
													</td>
											</tr>
											<tr>
												<td colspan="3" align="center"><input type="button" class="button_5" onclick="javascript:upload();"
														id="BtnOK" value="<%= MipWebJSPUi.mipweb_user_opuser_28 %>"/>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="button" class="button_4" value="<%= MipWebJSPUi.mipweb_user_opuser_29 %>"  style="display:none" onclick="parent.parent.GB_CURRENT.hide()"/>
													
												<br><br></td>
											</tr>
										</table>
									</form>
								</div>




							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>