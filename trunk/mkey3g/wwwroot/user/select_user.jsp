<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_select_user_1 %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
 <script type="text/javascript" src="../scripts/common.js"></script>

	<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	<%
	boolean view = false;
	if(session.getAttribute("rolelist")!=null){
		List<String> list = (List<String>)session.getAttribute("rolelist");
		if(list.contains("mipcontact")){
			view= true;
		}
	}
	%>
 	 var root;
 	 var mytree;
 	 var pageid=1;
 	 var now_node;
 	 var showtype = 0; 
 	 
 	 
 	 var w1;
 	 var w2;
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_select_user_2 %>', function(btn){
					if(btn=='yes'){
							location.href='login.html';	
							return;					
							}
						}
						);
		}
		
		
function closemenu(){
		if(document.getElementById('center_left').style.display=='none'){
			document.getElementById("center_left").style.display='';
			document.getElementById("center_left").className = "center_left";
			document.getElementById("center_right").style.width = "77%";

			document.getElementById("treecontent").style.width="24%";
			document.getElementById("rightcontent").style.width="76%";				
		}
		else if
		(document.getElementById('center_left').style.display==''){
			document.getElementById("center_left").style.display='none';
			//document.getElementById("center_left").className = "center_left_close";
			document.getElementById("center_right").style.width = "99%";
			
			document.getElementById("treecontent").style.width=w1;
			document.getElementById("rightcontent").style.width=w2;			
		}
	}
	
	
	
	
	window.onload=function(){
		if(<%=view%>){
			$('center_right').style.display="";
			createTree();
		loadBranch("");
		}else{
			$('center_right').style.display="none";
			DHalert("<%= MipWebJSPUi.mipweb_user_select_user_3 %>");
		}

	    w1= document.body.clientWidth*0.77*0.24;
	    w2=document.body.clientWidth*(1-0.77*0.24);			
	}
function createTree(){
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_select_user_4 %>",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:"<%= MipWebJSPUi.mipweb_user_select_user_5 %>",
		  collapsible:true,
		  enableDD:true,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		 // autoHeight:false,
		  width:222,
		  autoWidth:false,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('<%= MipWebJSPUi.mipweb_user_select_user_6 %>','<%= MipWebJSPUi.mipweb_user_select_user_7 %>');
	
	User2.getGroupList(branchid,{
			callback:function(olist) {
					
					CloseProgress();
					if(branchid==""&&olist.length>0){
						now_branchid = olist[0].id;
						now_branchtext ="";
						showuserlist();
					}
					for(var i=0;i<olist.length;i++){
						var sub1=new Ext.tree.TreeNode({
						id:olist[i].id,
						text:olist[i].groupname,
						singleClickExpand:true,
						listeners:{
							//监听双击事件
							"dblclick":function(node){
								myExpand(node);
							},//监听单击
							"click":function(node){ 
								pageid =1;
								now_node=node;
				                showuserlist(); 
				            },
								//监听右键
							"contextmenu":function(node,e){
								//列出右键菜单
							var	menu=new Ext.menu.Menu([
								{
										text:"<%= MipWebJSPUi.mipweb_user_select_user_8 %>",
										icon:"../theme/images/list.gif",
										handler:function(){
											showbranch(node.id);
										}
								}
								]);
								//显示在当前位置
								menu.showAt(e.getPoint());
							}
						}
					  });
					    root.appendChild(sub1);
					    
					    myExpand(sub1);
					    
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_select_user_9 %>"+errorString);
				}
	});
}
function showuserlist(){
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_select_user_10 %>','<%= MipWebJSPUi.mipweb_user_select_user_11 %>'); 
	showtype = 0;
	var now_branchid ="";
	if(now_node!=null&&now_node!=undefined){
		now_branchid = now_node.id;
	}
	  User2.showUserList(now_branchid,pageid,
			{
				callback:function(objXml) {
					CloseProgress();
					 DisplayTransformedXML(1, objXml, "../user/xslt/userlist.xsl",document.getElementById("divRoleList"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_select_user_12 %>"+errorString);
				}
			});
}


function myExpand(node){
	if(node.item(0)==undefined){
			User2.getGroupList(node.id,{
				callback:function(olist) {
						
						CloseProgress();
						for(var i=0;i<olist.length;i++){
							var childnode = new Ext.tree.TreeNode({
							id:olist[i].id,
							text:olist[i].groupname,
							hrefTarget:"mainFrame",
							listeners:{//监听
					          
								//监听双击事件
								"dblclick":function(node){
									myExpand(node);
								},//监听单击事件
								"click":function(node){ 
									pageid =1;
									now_node=node;
					                 showuserlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"<%= MipWebJSPUi.mipweb_user_select_user_13 %>",
											icon:"../theme/images/list.gif",
											handler:function(){
												showbranch(node.id);
											}
									}
									]);
									//显示在当前位置
									menu.showAt(e.getPoint());
								}
							}
							});
							node.appendChild(childnode);
							myExpand(childnode);
							node.expand();
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_select_user_14 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	
	if(showtype == 1){
	searchuser();
	}else{
	showuserlist();
	}
}
function showbranch(branchid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_select_user_15 %>", "../user/showbranch.jsp?branchid="+branchid,550,878);
}
function showuser(userid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_select_user_16 %>", "../user/showuser.jsp?userid="+userid,550,878);
}

    function loadsearchuser(){	
		pageid=1;
		searchuser();
	}
	function searchuser(){
		 Progress('<%= MipWebJSPUi.mipweb_user_select_user_17 %>','<%= MipWebJSPUi.mipweb_user_select_user_18 %>'); 
		 showtype = 1;
		 User2.searchUser($('searchtype').value,$('searchoption').value,pageid,
				{
					callback:function(objXml) {
						CloseProgress();
						DisplayTransformedXML(1, objXml, "../user/xslt/userlist.xsl",document.getElementById("divRoleList"));					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_select_user_19 %>"+errorString);
					}
				});
	}
	
</script>
</head>
	






<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
	
		<div id="center">
	

			<div id="center_right">
				<div id="close_menu" onClick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">

					<!-- center_nav 路径导航 -->
					
					<!-- 中部主要内容开始 -->
					<table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../theme/images/alert_bg.gif">
					  <tr>
					    <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
					    <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
					    <td width="90%"></td>
					    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="../theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
					  </tr>
					</table>
					
					<table width="99%" height="27" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:11px;">
					  <tr>
					    <td background="../theme/images/list_top_bg.jpg"><div class="list_top_left"><span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_select_user_20 %></span></div>
					    <div class="list_top_right"><a href="#" class="white_12"></a></div></td>
					  </tr>
					</table>
					

					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								
								
								<table width="99%" border="0" align="center" cellpadding="0"
									cellspacing="0" style="border: 1px solid #CAD7DF;">
									<tr>
										<td id="treecontent" width="24%" valign="top">
											<div id="tree"
												style="margin: 0px; padding: 0px;width:24%; valign: top; height: 400px;overflow:hidden;"></div>
										</td>
										<td id="rightcontent" width="76%" valign="top">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td colspan="5" class="title">
														<%= MipWebJSPUi.mipweb_user_select_user_21 %>
													</td>
												</tr>
												<tr>
													<td colspan="5">
														<table width="100%">
															<tr>

																<td>
																	<div style="float: right">
																		<%= MipWebJSPUi.mipweb_user_select_user_22 %>
																		<select id="searchtype">
																			<option value='0'>
																				<%= MipWebJSPUi.mipweb_user_select_user_23 %>
																			</option>
																			<option value='1'>
																				<%= MipWebJSPUi.mipweb_user_select_user_24 %>
																			</option>
																		</select>
																		<input type="text" id="searchoption" />
																		<input type="button" value="<%= MipWebJSPUi.mipweb_user_select_user_25 %>" class="button_2"
																			onclick="loadsearchuser()" />
																	</div>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td colspan="5">
														<div id="divRoleList"></div>
													</td>
												</tr>

											</table>
										</td>
									</tr>
								</table>	
								
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		
	</body>

</html>
