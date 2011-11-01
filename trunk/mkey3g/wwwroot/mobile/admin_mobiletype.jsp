<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../scripts/transferxml.js" type="text/javascript"></script>
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
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
   		var listtypevalue = "<%=request.getParameter("type")%>";
	   //初始化
    /*	Event.observe(window, 'load', function(){
		 getMobiletypeList();
		});*/
        window.onload=function(){
        if(listtypevalue=='0'){
        $('spanCurrentPosition').innerHTML='<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_1 %>';
        }else{
        $('spanCurrentPosition').innerHTML='<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_2 %>';
        }
         getMobiletypeList();
        }
		/*  将所有的手机型 号列出*/
		function getMobiletypeList()
		{
			if(listtypevalue=='0'){//如果是取手机型号列表
				Progress("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_3 %>");
				MobileAction.getMoblicTypeListPage(pageid,
							function(objXml) {
							DisplayTransformedXML(1, objXml, "xslt/admin_mobiletye_list.xsl",document.getElementById("divList"));
								CloseProgress();
					}
				)
			}else{
				 Progress("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_4 %>");
				MobileAction.getMplistByPid(pageid,
							function(objXml) {
							DisplayTransformedXML(1, objXml, "xslt/admin_packet_list.xsl",document.getElementById("divList"));
							CloseProgress();
					}
				)
			}
		}
	
		
		/* 删除一条手机型号*/
		function delete_mobiletype(id)
		{
			Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_5 %>', function(btn){
			if(btn=='yes'){
				MobileAction.MobileTypeDelete(id,
			{
				callback:function(oText) {
				if(oText=="1"){
			         DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_6 %>");
			         getMobiletypeList();
				}else{
			          DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_7 %>"+oText);
				}
				},
				errorHandler:function(errorString, exception) {
					DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_8 %>"+errorString);
				}
				});
				
		}
		});
		}
		function onemobiletype(id)
		{
			GB_showCenter("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_9 %>", "../mobile/admin_one_mobiletype.jsp?id="+id,550,878);
		}
		//创建手机型号
		function add_mobiletype()
		{
			if(listtypevalue=='0'){//如果是取手机型号列表
				GB_showCenter("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_10 %>", "../mobile/admin_add_mobiletype.jsp",550,878);
			}else{
				GB_showCenter("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_11 %>", "../mobile/admin_add_packet.jsp",550,878);
			}
			
		}
		function updata_mobiletype(id)
		{
			GB_showCenter("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_12 %>", "../mobile/admin_updata_mobiletype.jsp?id="+id,550,878);
		}
	   
		function closewindow()
		{  
          DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_13 %>");
		   getMobiletypeList();
		   GB_CURRENT.hide();
		}
	   
	   
	  <%--
	  //用GFGW中导入（后台没有方法）
	  function gfgw()
	   {
			Progress("正在读取数据....");
			Mas2.getMoblicTypeByGFGW(
			{
				callback:function(objXml) {
					MobileAction.getMoblicTypeListPage(pageid,
						function(objXml) {
							DisplayTransformedXML(1, objXml, "xslt/admin_mobiletye_list.xsl",document.getElementById("divList"));
							CloseProgress();
						}
					);
				},
				errorHandler:function(errorString,exception){
					DHalert("操作失败，请重试！失败原因："+errorString);
				}
			}
			);
	   }--%>
	   function delete_packet(id){
	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_14 %>', function(btn){
			if(btn=='yes'){
				MobileAction.delPacket(id,
			{
				callback:function(oText) {
				if(oText=="1"){
				    DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_15 %>");
			         getMobiletypeList();
				}else{
				 DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_16 %>"+oText);
				}
				},
				errorHandler:function(errorString, exception) {
					DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_17 %>"+errorString);
				}
				});
				
		}
		});
	   }
	   function ChangePage(pid){
	   	pageid=pid;
        getMobiletypeList();
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
	<div id="center_nav"><%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_18 %> <span id="spanCurrentPosition"></span></div>
</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">


								<table width="100%">
									<tr>
										<%--	<td width="80%">
											<div class="href_14px_gray">
												<select id="listtype" onchange="getMobiletypeList()">
													<option value="0">
														手机型号列表
													</option>
													<option value="1" selected>
														资源包列表
													</option>
												</select>
											</div>
										</td>
										<td style="display: none">
											<input name="button" value="从GEGW导入" type="button" class="button_5" id="gfgw"
												onclick="javascript:gfgw();"></input>
										</td>
										--%>
										<td align = "right">
											<input name="button" value="<%= MipWebJSPUi.mipweb_mobile_admin_mobiletype_19 %>" type="button" id="add" class="button_2"
												onclick="javascript:add_mobiletype();"></input>
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

<%--<body class="body_center"
	onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

	<!--Top Include-->
	<jsp:include page="../user/top.jsp" flush="true" />
	<!--Top Include-->

	<div class="center_nav">
		·当前所在位置：
		<a href="../user/main.jsp">首页</a> >>
		<a href="../mas/default.jsp">移动办公维护</a> >>

		<span id="spanCurrentPosition">手机型号列表</span>
	</div>
	<div class="center_nav_line"></div>
	<div class="clear"></div>
	<div class="center">
		<div class="clear"></div>
		<div class="center_menu_top">
			<!-- center_menu_top -->
			<div id="center_menu_top">
				<ul>
					<li>
						<a href="../mas/admin_config.jsp"><span>移动办公信息配置</span> </a>
					</li>
					<li>
						<a href="../mas/admin_device_config.jsp?type=system"><span>移动办公设备配置</span>
						</a>
					</li>
					<li>
						<a href="../mas/admin_mas_uphold.jsp"><span>升级维护通知</span> </a>
					</li>
					<li>
						<a href="../mas/admin_platmanage.jsp"><span>管理参数配置</span> </a>
					</li>
					<li>
						<a href="../mas/admin_mastimesync.jsp"><span>时钟同步</span> </a>
					</li>
					<li>
						<a href="../mas/admin_ip.jsp"><span>企业外部网管系统</span> </a>
					</li>
					<li id="current">
						<a href="../mobile/admin_mobiletype.jsp"><span>客户端软件管理</span> </a>
					</li>
					<li></li>
					<li></li>
				</ul>
			</div>
		</div>
		<div id="mainbox">
			<div class="center_list_box">
				<div class="center_list">
					<table width="100%">
						<tr>
							<td width="80%">
								<div class="href_14px_gray">
									<select id="listtype" onchange="getMobiletypeList()">
										<option value="0">
											手机型号列表
										</option>
										<option value="1" selected>
											资源包列表
										</option>
									</select>
								</div>
							</td>
							<td style="display: none">
								<input name="button" value="从GEGW导入" type="button" id="gfgw"
									onclick="javascript:gfgw();"></input>
							</td>
							<td>
								<input name="button" value="添加" type="button" id="add"
									onclick="javascript:add_mobiletype();"></input>
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
	<!--Bottom Include-->
	<jsp:include page="../user/bottom.jsp" flush="true" />
	<!--Bottom Include-->
</body>
</html>
--%>












