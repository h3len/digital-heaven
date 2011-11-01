<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default_ecmanager.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
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
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var enterpriseid = '<%=request.getParameter("enterpriseid")%>';
			var pageid = '<%=request.getParameter("pageid")!=null?request.getParameter("pageid"):"1"%>';
			window.onload=function(){
				//if(!<%=Constants.canoperateapp %>){
		   		//	document.getElementById("addclient").style.display="none" ;
		   		//}
				getclientapplist(enterpriseid,pageid);
			}
			function addclientapp(){
				window.location.href="../enterprisemanager/addclientapp.jsp?enterpriseid="+enterpriseid+"&pageid="+pageid;
			}
			function modclientapp(id){
				window.location.href="../enterprisemanager/modclientapp.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid;
			}
			function delclientapp(id){
			Ext.Msg.confirm('平台提醒您', '您确定要退出该业务系统？', function(btn){
						 if(btn=='yes'){
						 Progress('正在删除企业业务系统.......','企业业务系统管理'); 
						MipClientAppAction.delEnterpriseApp(id,{
								callback:function(otext) {
									if(otext==1){
										DHalert("删除企业业务系统成功!");
										getclientapplist(enterpriseid,pageid);
									}
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("删除企业业务系统失败，失败原因："+errorString);
								}
						}			
						);
							}
						}
						);
			}
			function getclientapplist(enterpriseid,pageid){
				MipClientAppAction.getClientAppList(enterpriseid,pageid,{
						callback:function(objXml) {
							CloseProgress();
								DisplayTransformedXML(1, objXml, "../enterprisemanager/xslt/show_client_app.xsl",document.getElementById("divlist"));
						},
						errorHandler:function(errorString, exception) {
						    DHalert("获取企业业务系统列表失败，失败原因："+errorString);
						}
				}			
				);
			}
			function gohome(){
				window.location.href="admin_enterprisemanager.jsp?enterpriseid="+enterpriseid;
			}
			function ChangePage(pid){
				pageid = pid;
				getclientapplist(enterpriseid,pageid);
			}
			//启动或暂停应用
			function changeimg(s,id){
			var src1=s.value;
			if(src1=="关闭"){
			 Progress("数据正在载入...","提示");
				MipClientAppAction.stopapp(id,2,{
					callback:function(odata){
						if(odata=="1"){
							CloseProgress();
							SDHalert("业务系统已启用！",130);
							getclientapplist(enterpriseid,pageid);
						}else{
							CloseProgress();
							getclientapplist(enterpriseid,pageid);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("暂停业务系统失败，失败原因："+errorString);
					}
				});
			}else if(src1=="开通"){
				 Progress("数据正在载入...","提示");
				 MipClientAppAction.startapp(id,{
					callback:function(odata){
						if(odata=="1"){
							CloseProgress();
							SDHalert("业务系统已启用！",130);
							getclientapplist(enterpriseid,pageid);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("启用业务系统失败，失败原因："+errorString);
					}
				});
			}
		}
		</script>
	</head>
	
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">企业业务系统列表</span>
		</div>
		<div style="text-align:left">
			<input id="addclient" type="button" class="button_8" value="添加企业业务系统" onclick="addclientapp()"/> 
		</div>
		<div id ="divlist"></div>
		<div class="div_center">
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
