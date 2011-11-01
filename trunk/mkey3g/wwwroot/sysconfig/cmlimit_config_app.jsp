<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>业务系统配置</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
		var enterpriseid = "<%=request.getParameter("enterpriseid") != null ? request.getParameter("enterpriseid"):request.getSession().getAttribute("enterpriseid")%>"; 
  		var pageid = 1;	
		window.onload=function(){
			getEList()
		}   	
	function getEList(){
		EnterpriseAction.getAllEnterpriseObj({
					callback:function(odata){
						for(var i=0;i<odata.length;i++){
							var e = odata[i];
							var oOption = document.createElement("OPTION");
							oOption.text =  odata[i].branchname;
							oOption.value = odata[i].id;			
							document.all?$('eid').add(oOption):$('eid').appendChild(oOption);
						}
						progetclientapplist();
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("暂停业务系统失败，失败原因："+errorString);
					}
				});
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
			document.getElementById("center_right").style.width = "99%";
		}
	}
	function getclientapplist(enterpriseid,pageid){
				Progress('正在获取企业业务系统列表.......','企业业务系统管理'); 
				MipClientAppAction.getClientAppListForLimit(enterpriseid,pageid,{
						callback:function(objXml) {
							CloseProgress();
								DisplayTransformedXML(1, objXml, "../branchmanager/xslt/show_signalclientapp_.xsl",document.getElementById("divlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取企业应用列表失败，失败原因："+errorString);
						}
				}			
				);
	}
	function progetclientapplist(){
		 getclientapplist($('eid').value,pageid)
	}
	//mdp需要的链接
	function uploadConfig(appcode){
		window.open('/mdp/upload.jsp?appid=' + appcode, '','height=300, width=500, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	function addclientapp(){
				GB_showCenter("", "../branchmanager/braddclientapp.jsp?enterpriseid="+enterpriseid+"&pageid="+pageid,400,600);
			}
			function modclientapp(id){
				GB_showCenter("", "../branchmanager/brmodclientapp.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid,400,600);
			}
			function delclientapp(id){
				Ext.Msg.confirm(nowtitle, '确定删除业务系统吗？', function(btn){
									if(btn=='yes'){
										Progress('正在删除业务系统.......','企业业务系统配置'); 
										MipClientAppAction.delEnterpriseApp(id,{
												callback:function(otext) {
													CloseProgress();
													if(otext=='1'){
														 DHalert("删除业务系统成功!");
														getclientapplist(enterpriseid,pageid);
													}
												},
												errorHandler:function(errorString, exception) {
													CloseProgress();
												    DHalert("删除业务系统失败，失败原因："+errorString);
												}
										}			
										);
									}
									return;
				});
			}
			
			function ChangePage(pid){
				pageid = pid;
				getclientapplist(enterpriseid,pageid);
			}
			//用户登录信息配置
			function loginConfig(id){
				GB_showCenter("", "../branchmanager/loginconfig.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid,300,600);
			}
			function addAppUser(id){
				GB_showCenter("", "../branchmanager/appuserconfig.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid,550,878);
			}
			
			//启动或暂停应用
			function changeimg(s,id){
			var src1=s.value;
			if(src1=="暂停"){
			 Progress("数据正在载入...","提示");
				EnterpriseAction.stopapp(id,1,{
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
			}else if(src1=="运行"){
				 Progress("数据正在载入...","提示");
				 EnterpriseAction.startapp(id,{
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
		
		function apponline(s,id){
				 Progress("数据正在载入...","提示");
				 EnterpriseAction.onlineEnable(id,1,{
					callback:function(odata){
						if(odata=="1"){
							CloseProgress();
							SDHalert("业务系统已成功下线！",130);
							getclientapplist(enterpriseid,pageid);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("业务系统下线失败，失败原因："+errorString);
					}
				});
		}
		function synchronization(id){
			GB_showCenter("", "../branchmanager/synchronization_app.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid,360,450);
		}
		function showserial(id){
			GB_showCenter("", "../branchmanager/showserial_num.jsp?enterpriseid="+enterpriseid+"&appid="+id+"&pageid="+pageid,360,450);
		}
		function config_limit(id){
			GB_showCenter("", "../sysconfig/config_limit.jsp?appid="+id,360,450);
		}
	  
</script>
</head>
<body>
<!--Bottom Include-->
<jsp:include   page="../user/top.jsp"   flush="true"/>
<!--Bottom Include-->
<!-- Main 页面中部 -->
<div id="center">
<!-- Left 页面左侧菜单 -->
<div id="center_left" class="center_left"></div>
<!-- 右侧例表内容 -->
<div id="center_right">
	<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
<div id="center_right_main">
<div id="center_nav_box">
	<div id="center_nav">您现在所在位置 >> 通讯能力限额设置 </div>
</div>	
<div id="mainbox">
		<div class="center_list_box">
				<div class="center_list">
				<div>
							<div id="appconfig"> 
						
						
									<div style="text-align:left" >
											<select id="eid" onchange="progetclientapplist();"></select>
									</div>
								
								 
									<div id ="divlist"></div>
							</div>
			</div>
</div>
</div>
</div></div></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
  </body>
</html>
