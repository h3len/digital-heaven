<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title><%= MipWebMoreUi.mip_period_user_2 %></title>
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
  		var pageid = "<%=request.getParameter("pageid") != null ? request.getParameter("pageid") : "1"%>"-0;
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
					    DHalert("<%=MipWebMoreUi.mip_period_user_13%>"+errorString);
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
		Progress('<%=MipWebMoreUi.mip_period_user_14%>','<%=MipWebMoreUi.mip_period_user_15%>');
				MipClientAppAction.getClientAppListForPeriod(enterpriseid,pageid,{
						callback:function(objXml) {
							CloseProgress();
								DisplayTransformedXML(1, objXml, "../period/xslt/updatePeriod.xsl",document.getElementById("divlist"));
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%=MipWebMoreUi.mip_period_user_16%>"+errorString);
						}
				}			
				);
	}
	function progetclientapplist(){
		 enterpriseid = $('eid').value;
		 getclientapplist($('eid').value,pageid)
	}
	
			
			function ChangePage(id){
				pageid = id;
				getclientapplist(enterpriseid,pageid);
			}
		
		function updatePeriod(appid,appname){
			GB_showCenter("", "../period/doUpdatePeriod.jsp?appid="+appid+"&appname="+appname,360,450);
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
<div id="center_nav"> <%= MipWebMoreUi.mip_period_user_3 %> </div>
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
