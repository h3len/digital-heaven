<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=MipWebMoreUi.mip_user_admin_upgrade_1%></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />

		<script src="../dwr/interface/Logs.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
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

		<script type="text/javascript">
				  var error="<%=request.getAttribute("error")%>";
				  <%request.removeAttribute("error");%>
		          var progressBar;
		          var lightRGB = new Array(255,255,255);
		          window.onload=function(){
		          if(error!=null&&error!="null")
		          	DHalert(error);
		           initColor("#7da1da");}
					 function initColor(Color){
					 var opArray=new Array(.10,.25,.50,.85,1.0);
					 var baseColor = longHexToDec(Color.substring(1,7));
					 var nColor,nHex;
					 for(var i=0;i<5;i++) {
					   nColor=setColorHue(baseColor,opArray[i],lightRGB);
					   nHex = toHex(nColor[0])+toHex(nColor[1])+toHex(nColor[2]);
					   document.all.item("marq").firstChild.firstChild.children(i).bgColor="#"+nHex;
					 }
					 }
					 
					 function setColorHue(originColor,opacityPercent,maskRGB) {
					 returnColor=new Array();
					 for(w=0;w<originColor.length;w++) returnColor[w] = Math.round(originColor[w]*opacityPercent) + Math.round(maskRGB[w]*(1.0-opacityPercent));
					 return returnColor;
					 }
					 
					 function longHexToDec(longHex) {
					 r=toDec(longHex.substring(0,2));
					 g=toDec(longHex.substring(2,4));
					 b=toDec(longHex.substring(4,6));
					 return new Array(r,g,b);
					 }
					 
					 function toHex(dec) {
					 hex=dec.toString(16);
					 if(hex.length==1)hex="0"+hex;
					 if(hex==100)hex="FF";
					 return hex.toUpperCase();
					 }
					 
					 function toDec(hex) {
					 return parseInt(hex,16);
					 }
            	function upload(){  
					       	document.getElementById('ftype').value="zip";
    						var file=document.getElementById('file').value;				
    						var file_type=file.substring(file.lastIndexOf(".")+1)
   							if(file_type!="zip"){
	   							DHalert("<%=MipWebMoreUi.mip_user_admin_upgrade_3%>");		
	   							return;
   							}	 
  							Ext.MessageBox.show({
					           title: nowtitle,
					           msg: "<%=MipWebMoreUi.mip_user_admin_upgrade_4%>",
					           progressText: "",
					           width:260,
					           icon:'ext-mb-Loading_Blue', //custom class in msg-box.html
					           progress:false,
					           closable:false,
					           animEl: 'mb6'
						    })
   							document.getElementById("BtnOK").disabled=true;	
   						    form1.submit();  
 				}
    					
	    	function upgradeLogsResult(){
				GB_showCenter("<%=MipWebMoreUi.mip_user_admin_upgrade_5%>", "../upgrade/upgradelogsresult.jsp",450,550);
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
				<div id="close_menu" onClick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<div id="center_nav_box">
						<div id="center_nav">
							<%=MipWebMoreUi.mip_user_admin_upgrade_2%>
						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">

								<form id="form1" name="form1" method="post"
									action="../UpgradeUploadServlet.do"
									enctype="multipart/form-data">
									<table width="600px" border="0" align="center" cellpadding="0"
										cellspacing="5">
										<tr>
											<td width="3%">
												<img src="../skin/default/images/text_icon.gif" />
											</td>
											<td width="26%">
												<%=MipWebMoreUi.mip_user_admin_upgrade_6%>
											</td>
											<td width="71%">
											</td>
										</tr>
										<tr>
											<td width="3%">
												<img src="../skin/default/images/text_icon.gif" />
											</td>
											<td width="26%">
												<%=MipWebMoreUi.mip_user_admin_upgrade_7%>
											</td>
											<td width="71%">
												<span style="color: red"> <%=MipWebMoreUi.mip_user_admin_upgrade_8%></span>

											</td>
										</tr>
										<tr>
											<td width="3%">
												<img src="../skin/default/images/text_icon.gif" />
											</td>
											<td width="26%">
												<%=MipWebMoreUi.mip_user_admin_upgrade_9%>
											</td>
											<td width="71%">
												<input id="file" type="file" NAME="file"
													onpaste="return   false" onkeydown="return   false"
													style="width: 300px;" />
												<input id="ftype" name="ftype" type="hidden" />
											</td>
										</tr>
									</table>
								</form>
								<div style="text-align: center">
									<input type="button" onclick="javascript:upload();" id="BtnOK"
										value="<%=MipWebMoreUi.mip_user_admin_upgrade_9%>" />
									<input type="button" onclick="upgradeLogsResult();"
										value="<%=MipWebMoreUi.mip_user_admin_upgrade_10%>" />
								</div>
								<br />
								<br>
								<div class="clear" id="prossBar"
									style="display: none; background-color: #eeeeee; width: 260; height: 120; border-color: #84AE5A; border-style: solid; border-width: 1px;">
									<br />
									<br />
									<font color="red" size="3"><%=MipWebMoreUi.mip_user_admin_upgrade_4%></font>
									<br />
									<br />
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="1" rowspan="2">
												<br>
											</td>
											<td width="1" height="1">
												<br>
											</td>
											<td height="1" bgcolor="#cccccc">
												<br>
											</td>
											<td width="1">
												<br>
											</td>
											<td width="1" rowspan="2">
												<br>
											</td>
										</tr>
										<tr>
											<td width="1" height="1" bgcolor="#cccccc">
												<br>
											</td>
											<td height="1">
												<br>
											</td>
											<td width="1" bgcolor="#cccccc">
												<br>
											</td>
										</tr>
										<tr>
											<td width="1" bgcolor="#cccccc">
												<br>
											</td>
											<td width="1" height="1">
												<br>
											</td>
											<td width="180" height="0">
												<marquee direction="right" scrollamount="7">
													<table id="marq" cellpadding="0" cellspacing="1"
														style="FONT-SIZE: 1px; WIDTH: 50px; HEIGHT: 10px">
														<tr>
															<td>
																<br>
															</td>
															<td>
																<br>
															</td>
															<td>
																<br>
															</td>
															<td>
																<br>
															</td>
															<td>
																<br>
															</td>
														</tr>
													</table>
												</marquee>
												<br>
											</td>
											<td width="1" height="1">
												<br>
											</td>
											<td width="1" bgcolor="#cccccc">
												<br>
											</td>
										</tr>
										<tr>
											<td rowspan="2">
												<br>
											</td>
											<td height="1" bgcolor="#cccccc">
												<br>
											</td>
											<td height="1">
												<br>
											</td>
											<td bgcolor="#cccccc">
												<br>
											</td>
											<td rowspan="2">
												<br>
											</td>
										</tr>
										<tr>
											<td height="1">
												<br>
											</td>
											<td height="1" bgcolor="#cccccc">
												<br>
											</td>
											<td>
												<br>
												<br>
												<br>
											</td>
										</tr>
									</table>
								</div>

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