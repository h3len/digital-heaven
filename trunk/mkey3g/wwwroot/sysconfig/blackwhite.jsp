<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.dataaccess.vo.MipBlackWhite"%>
<%@ page import="com.dheaven.mip.config.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script src="../dwr/interface/MipBlackWhiteAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script language="JavaScript">
			function showmenu(){
				document.getElementById("center_left").style.display='block';
				document.getElementById("center_left").className = "center_left";
				document.getElementById("center_right").style.width = "77%";
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
					//document.getElementById("center_left").className = "center_left_close";
					document.getElementById("center_right").style.width = "99%";
				}
			}
			var pageid=1;
			var type = 0;
			
			window.onload=function(){
		 		var tabs = new Ext.TabPanel({		        
				        //width:950,
				        activeTab: 0,
				        frame:true,
				        defaults:{autoHeight: true},
				        renderTo: 'tabcard',
				        items:[
				        /*
				         	{
				            title: '白名单',
				            listeners: {activate: getwhitenames},
				             html:'<div id="biz1"></div>',
				            id:'tabGOTONE'		            
				            },
				            */
				            {
				            title: '黑名单',
				            listeners: {activate: getblacknames},
				            html:'<div id="biz2"></div>',
				            id:'tabMZONE'
				            }
				        ]
				  	 	 });
				  	 	
 			
 		
 			}
 			//获得白名单列表，直读
 			function getwhitenames(){
 			    type=1;
 			    $('isshow').style.display="none";
 				getenterpriselist();
 			}
 			//获得黑名单列表，可度写
 			function getblacknames(){
 			    type=0;
 			     $('isshow').style.display="";
 				getenterpriselist();
 			}
			
			
			
			
			
 			function getWbList(){
 				MipBlackWhiteAction.getBwList($('enterprise').value,type,pageid,'',
				{	
					callback:function(objXml) {
							DisplayTransformedXML(1, objXml, "../sysconfig/xslt/blackwhite.xsl",document.getElementById("divList"));			
					}
				});
 			}
 			function add_blackwhite(){
 				GB_showCenter("", "../sysconfig/black_white_add.jsp?type="+type+"&eid="+$('enterprise').value,450,878);
 			}
 			function del_blackwhite(id){
 			if(!confirm(" 确认要删除这条记录么？")){
 				return false;
 			}
 				MipBlackWhiteAction.deleBlackWhite(id,
				{	
					callback:function(otext) {
							if(otext==1){
								DHalert("删除操作成功！");
								ChangePage(pageid);
							}else{
								alert(otext);
								DHalert(otext+"！");
							}
					}
				});
 			}
 			
 			function ChangePage(pid){
 				pageid = pid;
 				getWbList();
 			}
 			function getenterpriselist(){
 				MipBlackWhiteAction.getEnterpriseList({
	 				callback:function(ids) {
	 						$('enterprise').innerHTML="";
	 						var idname = ids.split(',');
							for(var i=0;i<idname.length;i++){
							if(idname[i]=="")
							continue;
								var node = idname[i].split('$');
								
								var objOption = document.createElement("OPTION");
								objOption.text = node[1];
								objOption.value =node[0];
								document.all?$('enterprise').add(objOption):$('enterprise').appendChild(objOption);
							}
							getWbList();
						}
 				});
 			}
 			function modify_blackwhite(id){
 			    GB_showCenter(type==0?"修改黑名单":"修改白名单", "../sysconfig/black_white_modify.jsp?type="+type+"&id="+id+"&pageid="+pageid,450,878);
 			}
 			function delblackwhite(id){
 				Ext.Msg.confirm('综合办公提醒您', '您确定要删除该记录？', function(btn){
					if(btn=='yes'){
 				MipBlackWhiteAction.deleBlack(id,
				{	
					callback:function(otext) {
							if(otext==1){
								SDHalert("删除操作成功！",130);
								ChangePage(pageid);
							}else{
								SDHalert(otext+"！",130);
							}
					},
					errorHandler:function(errorString, exception) {
						DHalert(errorString);														
					}
				});
				}
				});
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
					<!-- 中部主要内容开始 -->
					<div id="center_nav_box">
						<div id="center_nav">您现在所在位置 >> 配置管理 >> 黑白名单设置</div>
					</div>
					<table width="100%" height="29" border="0" cellpadding="0"
						cellspacing="0" background="../../theme/images/alert_bg.gif">
						<%--
						<tr>
							<td width="1%">
								<img src="../theme/images/alert_left.gif" width="5" height="29" />
							</td>
							<td width="2%">
								<img src="../theme/images/alert_bug.gif" />
							</td>
							<td width="90%">
								<a href="#">日志统计</a>
							</td>
							<td width="2%">
								<a href="#"><img src="../theme/images/alert_right.gif"
										width="24" height="29" border="0" />
								</a>
							</td>
						</tr>
						--%>
					</table>

					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">

								<div id="tabcard"></div>
								<table width="100%">
									<tr>
										<td width="80%">
											
										</td>
										<td>
											<%--<select style="display: none" id="type" disabled="true">
												<option value="<%=MipBlackWhite.TYPE_WHITE%>"
													selected="true">
													白名单
												</option>
												<option value="<%=MipBlackWhite.TYPE_BLACK%>">
													黑名单
												</option>
											</select>--%>
										</td>
										<td height="25">
											<select id="enterprise" onChange="getWbList();">
											</select>
										</td>
										<td id="isshow">
											<input name="button" value="添加" type="button" id="add"
												onclick="javascript:add_blackwhite();"></input>
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
