<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>

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
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
		var id = "<%=request.getParameter("id")!=null?request.getParameter("id"):""%>";
		var name = "<%=request.getParameter("name")!=null?request.getParameter("name"):""%>";
		var appid = "<%=request.getParameter("appid")!=null?request.getParameter("appid"):""%>";
		var enterpriseid ="<%=request.getParameter("enterpriseid")!=null?request.getParameter("enterpriseid"):""%>";
			window.onload = function(){
			createClientAppName();
			
			}
		      /**获取业务系统名称*****/
			function createClientAppName(){
			  EnterpriseAction.getAllClientByenterpriseid(
			  enterpriseid,{
			  callback:function(map){
			  dwr.util.addOptions("appid",map);
			  var size=$("appid").options.length;
			  for(var i=0;i<size;i++){
			  if($("appid").options[i].value==appid){
			  $("appid").options[i].selected=true;
			  }
			  }
			   },
			  errorHandler:function(errorString, exception) {
						CloseProgress();
						DHalert("操作失败！失败原因："+exception.message);		
					}
			  }
			  );
			}
			function modpluginapp(){
				var cf = new CheckForm();
				EnterpriseAction.updatePluginApp(cf.Trim($("appid").value),id,enterpriseid,{
					callback:function(data){
						if(data=="1"){
							DHalert("修改功能模块的业务系统成功！");
							parent.parent.GB_CURRENT.hide();
							parent.parent.showpluginapp();
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
						DHalert("操作失败！失败原因："+exception.message);		
					}
				});
			}
			function gohome(){
				window.location.href ="admin_config_app.jsp";
			}
		</script>
	</head>
	
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">修改插件绑定的业务系统</span>
		</div>
		<table width="100%" bgcolor="" border="0" cellpadding="0" cellspacing="1">
		<tr>
			<td width="30%" >
			</td>
			<td width="16">
				<img src="../skin/default/images/text_icon.gif" />
			</td>
			<td width="25%">业务系统名称：</td>
			<td>
				<select id="appid" >
				</select>
				<span class="star">*</span>
			</td>
		</tr>
	</table>
		<div id ="divlist"></div>
		<div class="div_center">
		<input type="button" value="提交"  class="button_2"  onclick="modpluginapp();"/>
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/>
		</div>
	</body>
</html>
