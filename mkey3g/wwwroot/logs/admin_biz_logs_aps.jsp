<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>业务日志</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../dwr/interface/BusinessLogs.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script language="JavaScript">
       //公共变量
		var searchoption="";
      var pageid = "<%=request.getParameter("pageid") != null ? request.getParameter("pageid") : "1"%>";
	   //初始化
	window.onload = function()
	{
	  	 ChangePage(pageid);
	 }    
	 function getApsLosList(){
	 			BusinessLogs.getApsLosList(pageid,
				{
					callback:function(objXml) {
						DisplayTransformedXML(1, objXml, "../logs/xslt/admin_logs_aps_list.xsl",document.getElementById("divList"));
					},
					errorHandler:function(errorString, exception) {

					}
				});
	 }
	
	 //页面跳转
	function ChangePage(id)
	{
		pageid = id;
		if(searchoption==""){
			getApsLosList();			
		}else{
			search(searchoption);			
		}
	} 
	   function show_role()
	   {
	    GB_showCenter("APS日志搜索条件", "../logs/admin_biz_logs_aps_searchrole.jsp",450,640);	   
	   }
	   
	   function changeview()
	   {
			switch ($('selType').value) {
				case "1":window.location.href="#"
					break;
				}
	   }
	   function showthislog(id){
	   		 GB_showCenter("APS日志详情", "../logs/admin_show_thislog.jsp?id="+id,450,640);	   
	   }
	   function search(s){
			   try{
					 searchoption=s;
						BusinessLogs.searchApsLogs(pageid,
						searchoption,
					{
					callback:function(objXml) {
						DisplayTransformedXML(1, objXml, "../logs/xslt/admin_logs_aps_list.xsl",document.getElementById("divList"));
						searchclose();
					},
					errorHandler:function(errorString, exception) {
						DHalert(" 查询失败!失败原因："+errorString);
					}
				});
			   }catch(e){
			   	alert(e.message)
			   }
		}
	   	function searchclose(){
	   				//Ext.MessageBox.alert('信息', '搜索完成',failmethod());
	   				if(GB_CURRENT)
	   					GB_CURRENT.hide();
	   			}
	   		function checkall(){
	   			if($('aps_selall').checked==true){
	   					SelCheckbox('aps',1)
	   				}else{
	   					SelCheckbox('aps',0)
	   				}
	   		}
			function deleteapslog(){
			
			SelAllValue('aps');
			if(m_ids==""){
				 DHalert(" 请至少选中一个删除！");
				return false;
			}
			
			Ext.Msg.confirm(nowtitle, '您确定要删除所选记录？', function(btn){
					if(btn=='yes'){		
							BusinessLogs.deleteapslog(m_ids,
							{
									callback:function(objText) {
										if(objText=="1"){
											 	 ChangePage(pageid);
										}else{
										 DHalert(" 删除失败!失败原因："+objText);
									    ChangePage(pageid);
										}						
									},
									errorHandler:function(errorString, exception) {
										DHalert(errorString);
									}
							});
						}
					}
);
						
				}

 		function isallsel(checkname){
				var obj = document.getElementsByName(checkname);
				var len = obj.length;
				var b=true;
				for (	var i=0;i<len;i++){
				if(obj[i].checked ==false)
				{
					document.getElementById(checkname+"_selall").checked=false;
					b=false;
					break;
				}
				if(b==true){
					document.getElementById(checkname+"_selall").checked=true;
				}
			}
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
		</script>
	</head>
	<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

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

					<!-- center_nav 路径导航 -->
					<div id="center_nav_box">
						<div id="center_nav">
							当前所在位置>>系统维护>>业务日志
							<span id="spanCurrentPosition"></span>
						</div>
					</div>

					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">



								<table width="100%">
									<tr>
										<td width="15%">
											<div class="href_14px_gray">
												APS日志管理
											</div>
										</td>
										<td width="15%">
											<img src='../skin/default/images/list_fun1.gif'
												align='absmiddle'>
											&nbsp;&nbsp;
											<a href="#" onclick="show_role()">按条件查询</a>
										</td>
										<td width="50%">
											<img src='../skin/default/images/list_fun4.gif'
												align='absmiddle'>
											&nbsp;&nbsp;
											<a href="#" onclick="deleteapslog()">删除所选</a>
										</td>


										<td width="1%"></td>
										<td width="15%">


										</td>
										<td class="height25" >
											<select id="selType" onchange="javascript:changeview()" style="display:none">

												<option value="1" selected="selected"  >
													APS日志
												</option>
											</select>
										</td>
									</tr>
									<tr>
										<td colspan="2"></td>
									</tr>
								</table>
								<div id="divList"></div>


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
