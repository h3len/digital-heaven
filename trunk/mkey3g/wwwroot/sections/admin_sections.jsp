<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.plugin.sections.vo.MipSections"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
		    var GB_ROOT_DIR = "../skin/";
		</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../scripts/transferxml.js" type="text/javascript"></script>
		<script src="../dwr/interface/SectionsAction.js" type="text/javascript"></script>
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
			var extend_length=<%=com.dheaven.mip.plugin.sections.vo.MipSections.EXTENDS_NUM_LENGTH%>;
			var pageid=1;
			window.onload=function(){
				
				for(var i=1;i<=extend_length;i++){
					var oOption = document.createElement("OPTION");
					oOption.text = i+"<%= MipWebJSPUi.mipweb_sections_admin_sections_1 %>";
					oOption.value =i;			
					document.all?$('sections_type').add(oOption):$('sections_type').appendChild(oOption);
				}
				getSectionsList();
			}
 			function add_sections(){
 				GB_showCenter("<%= MipWebJSPUi.mipweb_sections_admin_sections_2 %>", "../sections/admin_add_sections.jsp",550,878);
 			}
 			function closewindow()
			{  
	           DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_3 %>");
			   getSectionsList();
			   GB_CURRENT.hide();
			}
			function getSectionsList(){
				Progress("<%= MipWebJSPUi.mipweb_sections_admin_sections_5 %>");
				SectionsAction.getSectionsByPageid($('sections_type').value,pageid,
				{
					callback:function(objXml) {
						CloseProgress();
						DisplayTransformedXML(1, objXml, "xslt/admin_sections_list.xsl",document.getElementById("divList"));
					},
					errorHandler:function(errorString,exception){
						CloseProgress();
						DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_6 %>"+errorString);
					}
				}
				);
			}
			function ChangePage(pid){
				pageid=pid;
				getSectionsList();
			}
			function ChangeOption(){
				pageid=1;
				getSectionsList();
			}
			function modsections(id){
				GB_showCenter("<%= MipWebJSPUi.mipweb_sections_admin_sections_7 %>", "../sections/admin_mod_sections.jsp?id="+id,550,878);
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
		    
		    function del_sections(values){
		    	
				Progress("<%= MipWebJSPUi.mipweb_sections_admin_sections_8 %>");
				SectionsAction.delSections(values,
				{
					callback:function(objXml) {
					
						CloseProgress();
						if(objXml=="1"){
							DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_9 %>");
							ChangePage(pageid)
						}else{
							DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_10 %>"+objXml);
						}
						
					},
					errorHandler:function(errorString,exception){
						CloseProgress();
						DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_11 %>"+errorString);
					}
				}
				);
		    }
		    function ask_del_section(){
		    	var chks = document.getElementsByName('idmark');
				var values = new Array();
				var j=0;
				for(i = 0;i < chks.length ;i++)
				{
					if(chks[i].checked)
					{
						values[j] = chks[i].id;
						j++;
					}
				}
				
				if(values.length < 1)
				{
					DHalert("<%= MipWebJSPUi.mipweb_sections_admin_sections_12 %>");
					return;
				}
		    	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_sections_admin_sections_13 %>', function(btn){
				if(btn=='yes'){
							del_sections(values);		
						}
					}
				);
		    }
		    function set_section(){
		    	GB_showCenter("<%= MipWebJSPUi.mipweb_sections_admin_sections_14 %>", "../sections/set_sections.jsp?id="+id,400,608);
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
	<div id="center_nav">您现在所在位置 >> 配置管理>> 号段管理配置</div>
</div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">


								<table width="100%">
									<tr>
										
										<td colspan="2">
											<input name="button" value="<%= MipWebJSPUi.mipweb_sections_admin_sections_16 %>" type="button" id="add" class="button_2"
												onclick="javascript:add_sections();"></input>
											<input name="button" value="<%= MipWebJSPUi.mipweb_sections_admin_sections_17 %>" type="button" id="del" class="button_2"
												onclick="javascript:ask_del_section();"></input>
										
											<select id="sections_type"  onchange="ChangeOption()"><option value="-1"><%= MipWebJSPUi.mipweb_sections_admin_sections_19 %></option></select>
											<input name="button" value="<%= MipWebJSPUi.mipweb_sections_admin_sections_18 %>" type="button" id="del" class="button_6"
												onclick="javascript:set_section();"></input>
										</td>

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











