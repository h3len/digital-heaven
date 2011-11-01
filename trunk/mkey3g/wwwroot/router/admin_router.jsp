<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE%></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../scripts/transferxml.js" type="text/javascript"></script>
		<script src="../dwr/interface/RouterAction.js" type="text/javascript"></script>
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
 		//公共变量
   		var pageid =1;
   		var now_type=0;
   		var ab=[[getFuzzy,'模糊路由配置'],[getExact,'精确路由配置']];
   		
        window.onload=function(){
        	DHTabPanel(ab,900,0,"tabs");
        }
        
        function getFuzzy(){
		 	now_type=0;
		 	getList();
		 	$('add_table').style.display="none";
	 	}
	 	
		 function getExact(){
		 	now_type=1;
		 	getList();
		 	$('add_table').style.display="";
		 } 
        
        
        
		/*  将所有的手机型 号列出*/
		function getList()
		{
				Progress("正在读取数据....");
				RouterAction.getRouterListPage(pageid,now_type,{
						callback:	function(objXml) {
							DisplayTransformedXML(1, objXml, "xslt/admin_router_list.xsl",document.getElementById("divList"));
								CloseProgress();
							},
						errorHandler:function(errorString, exception) {
								CloseProgress();
								DHalert("操作失败！失败原因:"+exception.message);		
							}
				})
		}
	
		
		/* 删除一条手机型号*/
		function delete_mobiletype(id)
		{
			Ext.Msg.confirm(nowtitle, '您确定要删除此手机路由？', function(btn){
			if(btn=='yes'){
				RouterAction.deleteExactRouter(id,
			{
				callback:function() {
			         getList();
				},
				errorHandler:function(errorString, exception) {
					DHalert("操作失败！失败原因:"+errorString);
				}
				});
				
		}
		});
		}
		
		//创建手机型号
		function add_mobiletype()
		{
			GB_showCenter("添加手机路由", "../router/admin_add_router.jsp",550,878);
		}
		function updata_mobiletype(id)
		{
			GB_showCenter("修改手机路由", "../router/admin_updata_router.jsp?id="+id,550,878);
		}
	   
		function closewindow()
		{  
          DHalert("操作成功！");
		   getList();
		   GB_CURRENT.hide();
		}
	   
	   
	   function ChangePage(pid){
	   	pageid=pid;
        getList();
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
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<!-- 中部主要内容开始 -->

					<div id="center_nav_box">
						<div id="center_nav">
							您现在所在位置 >> 配置管理 >> 通信路由配置
						</div>
					</div>
					<div id="tabs" style="border: 1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">

								<table width="100%" id="add_table" style="dpsplay:none">
									<tr>
										<td align="right">
											<input name="button" value="添加" type="button" id="add"
												class="button_2" onclick="javascript:add_mobiletype();"></input>
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