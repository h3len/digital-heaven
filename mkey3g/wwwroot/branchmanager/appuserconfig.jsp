<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{
	out.print("<script>parent.parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加业务系统用户</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/mobiledisk.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		   var enterpriseid = '<%=request.getParameter("enterpriseid")%>';
		   var appid ='<%=request.getParameter("appid")%>';
		   var apppageid = '<%=request.getParameter("pageid")!=null?request.getParameter("pageid"):1%>';
		   var userid="";
			var username="";
		   window.onload = function (){
		   		//if(!<%=Constants.canoperateapp %>){
		   		//	document.getElementById("importfromexcel").style.display="none" ;
		   		//	document.getElementById("delappuser").style.display="none" ;
		   		//	document.getElementById("addappuser").style.display="none" ;
		   		//}
		   		getAppUserList();
		   }
		   function getAppUserList(){
				Progress('正在获取应用用户列表.......','应用用户管理'); 
				EnterpriseAction.getAppUserList(appid,apppageid,{
						callback:function(objXml) {
							CloseProgress();
								DisplayTransformedXML(1, objXml, "../branchmanager/xslt/show_app_user.xsl",document.getElementById("divlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取获取应用用户列表失败，失败原因："+errorString);
						}
				}			
				);
			}
			function addappuser(){
				window.open('app_join_user.jsp?appid='+appid+'&enterpriseid='+enterpriseid+'&apppageid='+apppageid, '','height=550,width=878,top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
			}
			function outappuser(){
				var chks = document.getElementsByName('idmark');
						var userids="";
						//计数
						var num=0;
						for(var i = 0;i < chks.length ;i++)
						{
						  var ui="";
							if(chks[i].checked == true)
							{
							num=num+1;
								  ui=chks[i].value;
								  ui=ui.replace(/\'/g,"");
					              ui=ui.replace(/\'/g,"");   
								userids=userids+ui;
								if(i!=(chks.length-1)){  
								userids=userids+",";  
								}
							}
						}
						if(num!=0)
						{
						Ext.Msg.confirm(nowtitle, '您确定要退出该应用用户？', function(btn){
						 if(btn=='yes'){
									Progress('正在退出，请稍候.......','应用用户管理'); 
									EnterpriseAction.outappusers(userids,appid,{
											callback:function(otext) {
												CloseProgress();
												if(otext=='1'){
													DHalert("退出应用用户成功！");
													getAppUserList();
												}else{
													 DHalert("退出应用用户失败，失败原因："+otext);
												}
											},
											errorHandler:function(errorString, exception) {
												CloseProgress();
											    DHalert("退出应用用户失败，失败原因："+errorString);
											}
									});	
							}
						}
						);
						}else{
							DHalert("请选择要退出的应用用户!");
							return;
						}
			}
			 //全选
		    function checkall()
		    {
		    	var chks = document.getElementsByName('idmark');
		    	for(i = 0;i < chks.length ;i++)
		    	{
		    		chks[i].checked = true;
		    	}
		    }
	    
		    //反选
		    function inverse() 
		    {
		    	var chks = document.getElementsByName('idmark');
		    	for(i = 0;i < chks.length ;i++)
		    	{
		    		if(chks[i].checked == true)
		    		{
		    			chks[i].checked = false;
		    		}else
		    		{
		    			chks[i].checked = true;
		    		}
		    	}
		    } 
		    function fromexcel(){
		    	window.location.href = "importappuser.jsp?appid="+appid+"&apppageid="+apppageid+"&enterpriseid="+enterpriseid;
		    }
		    function adddappbinduser(id){
		    	window.location.href = "addappuser.jsp?apppageid="+apppageid+"&enterpriseid="+enterpriseid+"&id="+id+"&appid="+appid;
		    }
		    function unbinduser(id){
			    Ext.Msg.confirm(nowtitle, '您确定要解除该应用用户的绑定？', function(btn){
						if(btn=='yes'){
									EnterpriseAction.addUserByexistApp(id,null,null,enterpriseid,{
										callback:function(otext){
											if(otext=="1"){
												DHalert("解除绑定成功!");
												getAppUserList();
											}
										},
										errorHandler:function(errorString, exception) {
										    DHalert("解除绑定失败，失败原因："+errorString);
										}
									});
							}
						}
				);
			}
		  
		    
		    /***分页*******/
		    function ChangePage(pid){
				apppageid=pid;
				getAppUserList(enterpriseid,apppageid);
			}
		</script>
</head>
<body>
	<div class="up_title">
			<span class="href_14px_blue">业务系统用户列表</span>
		</div>
		<div style="text-align:left">
			<input type="button" id="addappuser" class="button_8" value="接入业务系统用户" onclick="addappuser()"/> 
			<input type="button" id="delappuser" class="button_8" value="退出业务系统用户" onclick="outappuser()"/>
			<input type="button" id="importfromexcel" class="button_5" value="从excel导入" onclick="fromexcel()"/>
		</div>
		<div id ="divlist"></div>
		<div class="div_center">
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/></div>
</body>
</html>