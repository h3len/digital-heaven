<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=MipWebMoreUi.mip_user_admin_upgrade_1%></title>
		<script type="text/javascript">
  		  var GB_ROOT_DIR = "../skin/";
		</script>
		<script language="javascript" src="../scripts/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/Upgrade.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
		 var progressBar;
		 function upgrade(){
		   document.getElementById('BtnOk').disabled=true;
		   Upgrade.checkUpgradeFile(
		  {
		    callback:function(objText){
		        if(objText=="1"){
		            DHalert("<%=MipWebMoreUi.mip_user_admin_upgrade_11%>");
				}else{
					DHalert("<%=MipWebMoreUi.mip_user_admin_upgrade_12%>"+objText);
                    document.getElementById('BtnOk').disabled=false;
										}		
		    },
		     errorHandler:function(errorString, exception) {
				}
		  }
		  );
		 }
        </script>
	</head>

	<body class="body_center">

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

						</div>
					</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<table width="600px" border="0" align="center" cellpadding="0"
									cellspacing="5">
									<tr>
										<td width="3%">
											<img src="../skin/default/images/text_icon.gif" />
										</td>
										<td width="10%">
											<%=MipWebMoreUi.mip_user_admin_upgrade_7%>
										</td>
										<td width="71%">
											<span style="color: red"> <%=MipWebMoreUi.mip_user_admin_upgrade_13%>
											</span>

										</td>
									</tr>
								</table>
								<div style="text-align: center">
									<input type="button" onclick="javascript:upgrade();" id="BtnOK"
										value="<%=MipWebMoreUi.mip_user_admin_upgrade_14%>" />
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
