<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_personal_user_1 %></title>
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
		window.location.href='../user/personal_mod_user.jsp?id='+puerid;
	}
	function deleteuser(){
			if(!confirm("<%= MipWebJSPUi.mipweb_user_personal_user_2 %>"))
				return false;
			var url = '../personal.do';
			var pars = 'action=delUser&userid='+puerid;
			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: deleteuser_CallBack}
			);
	}
	function deleteuser_CallBack(originalRequest){
		try
		{
			var objXml = originalRequest.responseXML;
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				parent.parent.GetGroupUserList(parent.parent.currentGroupId);
				parent.parent.GB_CURRENT.hide();
			}
			else
			{
				alert("<%= MipWebJSPUi.mipweb_user_personal_user_3 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
			}
		}
		catch(err)
		{
			alert("<%= MipWebJSPUi.mipweb_user_personal_user_4 %>"+errorMessage);
		}
	}
</script>
</head>
<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

<div class="up_title"><span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_personal_user_5 %></span></div>
<div class="up_subtitle"><span><%= MipWebJSPUi.mipweb_user_personal_user_6 %></span></div>
  <table border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_7 %>
				</td>
				<td width="71%" id="truename">
					</td>
			</tr>
			
  		<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_8 %>
				</td>
				<td width="71%" id="mobile">
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_9 %>
				</td>
				<td width="71%" id="email">
				</td>
			</tr>

				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_10 %>
				</td>
				<td width="71%" id="companytel">
				</td>
			</tr>
			
  			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_11 %>
				</td>
				<td width="71%" id="hometel">
					</td>
			</tr>
						<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_12 %>
				</td>
				<td width="71%" id="city">
					</td>
			</tr>
				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_personal_user_13 %>
				</td>
				<td width="71%" id="comment">
				</td>
			</tr>
  
  </table>
  <div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_personal_user_14 %>" onclick="mod()"/> <input type="button" value="<%= MipWebJSPUi.mipweb_user_personal_user_15 %>" onclick="deleteuser()"/> <input type="button" value="<%= MipWebJSPUi.mipweb_user_personal_user_16 %>" onclick="parent.parent.GB_CURRENT.hide()" /></div>
</body>
</html>
