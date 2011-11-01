
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%= MipWebJSPUi.mipweb_user_admin_user1_2 %>">
<meta name="description" content="<%= MipWebJSPUi.mipweb_user_admin_user1_3 %>">
<meta name="copyright" content="<%= MipWebJSPUi.mipweb_user_admin_user1_4 %>">
<title><%= MipWebJSPUi.mipweb_user_admin_user1_1 %></title>
<!-- common.js 通用js调用 -->
<script language="javascript" src="scripts/ext-all.js"></script>
<!-- css.css 通用css调用 -->
<link href="theme/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function allexit(){
		Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_admin_user1_5 %>', '<%= MipWebJSPUi.mipweb_user_admin_user1_6 %>', function(btn){
					if(btn=='yes'){
							location.href='login.html';	
							return;					
							}
						}
						);
		}

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

</script>
</head>
<body onload="showmenu();"> 

<!-- Top 页面顶部 -->
<div id="top" >
	<div id="logo_box">
	<div id="logo"></div>
	<div id="top_menu">
	  <div class="float_right">
	  <ul>
	  <li><img src="theme/images/bug_home.gif" /><li>
	  <li><a href="default.html"><%= MipWebJSPUi.mipweb_user_admin_user1_7 %></a><li>
	  <li><img src="theme/images/bug_down.gif" /><li>
	  <li><a href="default.html"><%= MipWebJSPUi.mipweb_user_admin_user1_8 %></a><li>
	  <li><img src="theme/images/bug_pass.gif" /><li>
	  <li><a href="default.html"><%= MipWebJSPUi.mipweb_user_admin_user1_9 %></a><li>
	  <li><img src="theme/images/bug_exit.gif" /><li>
	  <li><a onclick="javascript:allexit();" class="hand"><%= MipWebJSPUi.mipweb_user_admin_user1_10 %></a><li>
	  </ul>
	</div>
	</div>
	
</div>

<!-- Nav_menu 横向导航菜单 -->
<DIV id=menu>
<UL>
  <LI><A id=menu_home href="default.html" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_11 %></A> </LI>
  <LI><A href="#" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_12 %></A> </LI>
  <LI><A href="#" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_13 %></A> </LI>
  <LI><A href="#" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_14 %></A> </LI>
  <LI><A href="#" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_15 %></A> </LI>
  <LI><A href="#" hidefocus="true"><%= MipWebJSPUi.mipweb_user_admin_user1_16 %></A> </LI>
  <LI id=search></LI>
  </UL>
</DIV>

<!-- Main 页面中部 -->
<div id="center">

	<div id="center_left" class="center_left">
	<!--Strat center_left_tree-->
	<div id="center_left_tree">
	<div id="center_left_tree_top"></div>
	<div id="center_left_tree_bg">
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu1_.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu1_.jpg'" onmouseout="this.src='theme/images/center_left_menu1_.jpg'" /></a></div>
	
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu0.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu0_.jpg'" onmouseout="this.src='theme/images/center_left_menu0.jpg'" /></a></div>
	
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu2.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu2_.jpg'" onmouseout="this.src='theme/images/center_left_menu2.jpg'" /></a></div>
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu3.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu3_.jpg'" onmouseout="this.src='theme/images/center_left_menu3.jpg'" /></a></div>
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu4.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu4_.jpg'" onmouseout="this.src='theme/images/center_left_menu4.jpg'" /></a></div>
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu5.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu5_.jpg'" onmouseout="this.src='theme/images/center_left_menu5.jpg'" /></a></div>
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu6.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu6_.jpg'" onmouseout="this.src='theme/images/center_left_menu6.jpg'" /></a></div>
	<div class="center_left_tree_img"><a href="#" hidefocus="true"><img src="theme/images/center_left_menu7.jpg" border="0" onmouseover="this.src='theme/images/center_left_menu7_.jpg'" onmouseout="this.src='theme/images/center_left_menu7.jpg'" /></a></div>

	</div>
	<div id="center_left_tree_bom"></div>
	</div>
	</div>

	<div id="center_right">
<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<!-- 中部主要内容开始 -->
<table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="theme/images/alert_bg.gif">
  <tr>
    <td width="1%"><img src="theme/images/alert_left.gif" width="5" height="29" /></td>
    <td width="2%"><img src="theme/images/alert_bug.gif"></td>
    <td width="90%"><a href="#"><%= MipWebJSPUi.mipweb_user_admin_user1_17 %></a></td>
    <td width="2%"><a href="#"><img src="theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
  </tr>
</table>

<table width="99%" height="27" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:11px;">
  <tr>
    <td background="theme/images/list_top_bg.jpg"><div class="list_top_left"><span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_admin_user1_18 %></span></div>
    <div class="list_top_right"><a href="#" class="white_12">More...</a></div></td>
  </tr>
</table>
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #CAD7DF;">
  <tr>
    <td width="24%">&nbsp;</td>
    <td width="76%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="5" class="title"><%= MipWebJSPUi.mipweb_user_admin_user1_19 %></td>
        </tr>
      <tr>
        <td colspan="5">
		<table width="100%">
		 	<tr>
			<td width="252">
				<div class="submenu">
				<a><%= MipWebJSPUi.mipweb_user_admin_user1_20 %></a>
				<a><%= MipWebJSPUi.mipweb_user_admin_user1_21 %></a>
				<a><%= MipWebJSPUi.mipweb_user_admin_user1_22 %></a>				</div>				</td>
				<td>	
				<form action="" method="post" name="f"><%= MipWebJSPUi.mipweb_user_admin_user1_23 %><input name="" type="text" value="" size="12" maxlength="12" />
				   <input name="" type="image" src="theme/images/search.gif" />
				</form>				</td>
				</tr>
				</table>				</td>
        </tr>
      <tr>
        <td colspan="5">
		<form action="" method="post" name="f2">
		  <table class="table01" width="98%" cellspacing="0" cellpadding="4">
            <tr class="bold">
              <td width="11%"><input name="Input" type="checkbox" value="" /></td>
              <td width="20%"><%= MipWebJSPUi.mipweb_user_admin_user1_24 %></td>
              <td width="23%"><%= MipWebJSPUi.mipweb_user_admin_user1_25 %></td>
              <td width="23%"><%= MipWebJSPUi.mipweb_user_admin_user1_26 %></td>
              <td width="23%"><%= MipWebJSPUi.mipweb_user_admin_user1_27 %></td>
            </tr>
            <tr>
              <td><input name="Input" type="checkbox" value="" /></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_28 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_29 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_30 %></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><input name="Input" type="checkbox" value="" /></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_31 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_32 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_33 %></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><input name="Input" type="checkbox" value="" /></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_34 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_32 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_33 %></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><input name="Input" type="checkbox" value="" /></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_34 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_32 %></td>
              <td><%= MipWebJSPUi.mipweb_user_admin_user1_33 %></td>
              <td>&nbsp;</td>
            </tr>
          </table>
		</form>		</td>
        </tr>
		<tr>
			<td>
				<form action="" method="post" class="pageform">
					<a class="blue_12" href=""><%= MipWebJSPUi.mipweb_user_admin_user1_35 %></a> <a class="blue_12" href=""><%= MipWebJSPUi.mipweb_user_admin_user1_36 %></a> <a class="blue_12" href=""><%= MipWebJSPUi.mipweb_user_admin_user1_37 %></a> <a class="blue_12" href=""><%= MipWebJSPUi.mipweb_user_admin_user1_38 %></a><%= MipWebJSPUi.mipweb_user_admin_user1_39 %> 
					<select size="1">
					  <option>1</option>
					  <option>2</option>
					  <option>3</option>
					  <option>4</option>
					  <option>5</option>
					</select> 
					<%= MipWebJSPUi.mipweb_user_admin_user1_40 %> <input name="" type="text" size="5" maxlength="5" /> &nbsp;<input name="" type="image" src="theme/images/go.gif" />
				</form>			</td>
		</tr>
      
    </table></td>
  </tr>
</table>

</div>

	</div>
</div>

<!-- Bottom 页面底部 -->
<div class="clear"></div>
<div id="bottom">
	<img src="theme/images/bottom_ad1.jpg" />
	<span class="gray_12"><%= MipWebJSPUi.mipweb_user_admin_user1_41 %></span>
</div>

</body>
</html>