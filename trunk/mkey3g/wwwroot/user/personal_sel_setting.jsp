<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_personal_sel_setting_1 %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<link rel="stylesheet" type="text/css" href="../theme/css.css" />
<script type="text/javascript" src="../scripts/common.js"></script>
<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function showmenu(){
		document.getElementById("center_left_tree").style.display='block';
		document.getElementById("center_left").className = "center_left";
		document.getElementById("center_right").style.width = "77%";
		}

	function closemenu(){
		if(document.getElementById('center_left_tree').style.display=='none'){
			document.getElementById("center_left_tree").style.display='block';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";
		}
		else if
		(document.getElementById('center_left_tree').style.display=='block'){
			document.getElementById("center_left_tree").style.display='none';
			document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
		}
	}
	function self_setting(){
		//可以保存为空吧，不可以么？
		 Progress('<%= MipWebJSPUi.mipweb_user_personal_sel_setting_2 %>','<%= MipWebJSPUi.mipweb_user_personal_sel_setting_3 %>');
		User2.setPsersonalSelf($('c1').value,$('c2').value,$('c3').value,$('c4').value,$('c5').value,{
			callback:function(objXml) {
				if(objXml=="1"){
					CloseProgress();
					DHalert("<%= MipWebJSPUi.mipweb_user_personal_sel_setting_4 %>");
				}else{
					CloseProgress();
					DHalert("<%= MipWebJSPUi.mipweb_user_personal_sel_setting_5 %>"+objXml);
				}
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%= MipWebJSPUi.mipweb_user_personal_sel_setting_6 %>"+errorString);
			}
		});
	
	}
	function self_getting(){
		Progress('<%= MipWebJSPUi.mipweb_user_personal_sel_setting_7 %>','<%= MipWebJSPUi.mipweb_user_personal_sel_setting_8 %>');
		User2.getPersonalSelf({
			callback:function(omap) {
				CloseProgress();
				dwr.util.setValues(omap);
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%= MipWebJSPUi.mipweb_user_personal_sel_setting_9 %>"+errorString);
			}
		});
	
	}
	var tabPane;
    var ab=[[showuserlist,'<%= MipWebJSPUi.mipweb_user_personal_sel_setting_10 %>'],[groupmanager,'<%= MipWebJSPUi.mipweb_user_personal_sel_setting_11 %>'],[self_getting,'<%= MipWebJSPUi.mipweb_user_personal_sel_setting_12 %>']];
	function showuserlist(){
		window.location.href="../user/personaluser.jsp";
	}
	function groupmanager(){
		window.location.href="../user/personalgroup.jsp";
	}
	window.onload=function(){
		self_getting();
		DHTabPanel(ab,900,2,"tabs");
	}
</script>
</head>
<body>
<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true"/>
<!-- begin center -->
<div id="center">
  <div id="center_left" class="center_left">
    <!--Strat center_left_tree-->
    <div id="center_left_tree">
      <div id="center_left_tree_top"></div>
      <div id="center_left_tree_bg"> </div>
      <div id="center_left_tree_bom"></div>
    </div>
  </div>
  <div id="center_right">
    <div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
    <div id="center_right_main">
      <!-- 中部主要内容开始 -->
      <table  style="display:none" width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../theme/images/alert_bg.gif">
        <tr>
          <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
          <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
          <td width="90%"><a href="../minioa/admin_default.jsp"><%= MipWebJSPUi.mipweb_user_personal_sel_setting_13 %><span class="red" id="oatodo">0</span><%= MipWebJSPUi.mipweb_user_personal_sel_setting_14 %></a></td>
          <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="../theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
        </tr>
      </table>
      <div id="tabs"></div>
      <div class="border_blue">
        <div class="up_subtitle"> <span><%= MipWebJSPUi.mipweb_user_personal_sel_setting_15 %></span> </div>
        <table width="45%" border="0" align="center" cellpadding="0"
			cellspacing="5">
          <tr>
            <td width="3%"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="26%"> <%= MipWebJSPUi.mipweb_user_personal_sel_setting_16 %> </td>
            <td width="71%"><input type="text" id="c1"/>
            </td>
          </tr>
          <tr>
            <td width="3%"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="26%"> <%= MipWebJSPUi.mipweb_user_personal_sel_setting_17 %> </td>
            <td width="71%"><input type="text" id="c2"/>
            </td>
          </tr>
          <tr>
            <td width="3%"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="26%"> <%= MipWebJSPUi.mipweb_user_personal_sel_setting_18 %> </td>
            <td width="71%"><input type="text" id="c3"/>
            </td>
          </tr>
          <tr>
            <td width="3%"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="26%"> <%= MipWebJSPUi.mipweb_user_personal_sel_setting_19 %> </td>
            <td width="71%"><input type="text" id="c4"/>
            </td>
          </tr>
          <tr>
            <td width="3%"><img src="../skin/default/images/text_icon.gif" /> </td>
            <td width="26%"> <%= MipWebJSPUi.mipweb_user_personal_sel_setting_20 %> </td>
            <td width="71%"><input type="text" id="c5"/>
            </td>
          </tr>
        </table>
        <div class="text_align_center padding_5">
          <input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_personal_sel_setting_21 %>" onclick ="self_setting()" />
        </div>
      </div>
    </div>
  </div>
</div>
<div class="clear"></div>
<!--Bottom Include-->
<jsp:include page="bottom.jsp" flush="true"/>
<!--Bottom Include-->
</body>
</html>
