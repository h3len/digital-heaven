<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_personal_mod_user_1 %></title>
<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
<script language="javascript" src="../skin/common.js"></script>
<link href="../skin/common.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
<!-- Dwr Js -->
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<!-- prototype -->
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/xmlextend.js"></script>
<script type="text/javascript">
var puerid = '<%=request.getParameter("id")%>'
window.onload=function(){
	getPuser(puerid);
}

function getPuser(id){
		User2.getPUserinfo(id,
						{
							callback:function(oMap) {
								dwr.util.setValues(oMap);								
							},
							errorHandler:function(errorString, exception) {
								//					alert("JavaClassName" + exception.javaClassName + ", message=" + exception.message);
								//alert(exception.message);
							}
						});
	}
	function mod(){
		User2.modPUserinfo(puerid,$('truename').value,$('mobile').value,$('email').value,$('companytel').value,$('hometel').value,$('city').value,$('comment').value,
						{
							callback:function(oText) {
								if(oText!=1){
									alert("<%= MipWebJSPUi.mipweb_user_personal_mod_user_2 %>"+otext)
								}else{
									alert("<%= MipWebJSPUi.mipweb_user_personal_mod_user_3 %>");
									parent.parent.GB_CURRENT.hide();
								}							
							},
							errorHandler:function(errorString, exception) {
								//					alert("JavaClassName" + exception.javaClassName + ", message=" + exception.message);
								//alert(exception.message);
							}
						});
	}
</script>
</head>
<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

<div class="up_title"><span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_personal_mod_user_4 %></span></div>
<div class="up_subtitle"><span><%= MipWebJSPUi.mipweb_user_personal_mod_user_5 %></span></div>
  <table border="0" align="center" cellpadding="0"
			cellspacing="5">
			
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_6 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="truename" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />*
					</td>
			</tr>
			
  		<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_7 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="mobile" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_8 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="email" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />
				</td>
			</tr>

				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_9 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="companytel" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />
				</td>
			</tr>
			
  			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_10 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="hometel" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />
					</td>
			</tr>
						<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_11 %>
				</td>
				<td width="71%">
				<input name="text24" type="text" id="city" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)" />
					</td>
			</tr>
				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_mod_user_12 %>
				</td>
				<td width="71%">
				<textarea name="textarea" id="comment" class="input_h380px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)"></textarea>
				</td>
			</tr>
  
  </table>
  <div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_personal_mod_user_13 %>" onclick="mod()" /> <input type="button" value="<%= MipWebJSPUi.mipweb_user_personal_mod_user_14 %>" onclick="parent.parent.GB_CURRENT.hide()" /></div>
</body>
</html>
