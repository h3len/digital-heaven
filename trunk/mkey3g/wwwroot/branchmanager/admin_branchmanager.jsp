<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebJSPUi.mipweb_admin_branchmanager_1 %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
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
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
 	 var root;
 	 var mytree;
 	 var pageid=1;
 	 var now_node;
 	 
 	 var w1;
 	 var w2;
//得到企业id
 var enterpriseid = '<%=request.getParameter("enterpriseid") != null ? request.getParameter("enterpriseid"): request.getSession().getAttribute("enterpriseid")%>';
  
	window.onload=function(){
		//createTree();
		getRootBranch();
		loadBranch("");		
		now_branchid = "";
		showbranchlist();
		$('showcreate').style.display = "";
		w1= document.body.clientWidth*0.77*0.24;
		w2=document.body.clientWidth*(1-0.77*0.24);		
	}
	function createTree(){
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"-1",
		      text:" ",
		      expanded:true,
		      listeners:{
		      				//监听单击
							"click":function(node){ 
								pageid =1;
								now_node=node;
				    			showbranchlist();
				            }
						}
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:"<%= MipWebJSPUi.mipweb_admin_branchmanager_2 %>",
		  collapsible:true,
		  enableDD:true,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		  width:222,
		  autoWidth:false,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
	//这个方法是取根部门的
	function getRootBranch(){
	
				  Ext.QuickTips.init();
				  root=new Ext.tree.TreeNode({
				      id:"-1",
				      text:"<%= MipWebJSPUi.mipweb_admin_branchmanager_3 %>",
				      expanded:true,
				      listeners:{
				      				"dblclick":function(node){
										myExpand(node);
									},
				      				//监听单击
									"click":function(node){ 
										pageid =1;
										now_node = node;
						      			showbranchlist();
						            }
								}
				  });
				 mytree=new Ext.tree.TreePanel({
				  el:"tree",
				  animate:true,
				  title:"<%= MipWebJSPUi.mipweb_admin_branchmanager_4 %>",
				  collapsible:true,
				  enableDD:true,
				  enableDrag:true,
				  rootVisible:true,
				  autoScroll:true,
				  width:222,
				  autoWidth:false,
				  lines:true
				});
				mytree.setRootNode(root);//设置根节点
			 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(pid){
	var mark = 0;//保存
	
	Progress('<%= MipWebJSPUi.mipweb_admin_branchmanager_5 %>','<%= MipWebJSPUi.mipweb_admin_branchmanager_6 %>');
	BranchAction.loadBranch(pid,{
			callback:function(olist) {
					CloseProgress();					
					if(enterpriseid==""&&olist.length>0){
						now_branchid = olist[0].id;
						now_branchtext =olist[0].id;
						showbranchlist();
					}
					for(var i=0;i<olist.length;i++){
						var sub1=new Ext.tree.TreeNode({
						id:olist[i].id,
						text:olist[i].branchname,
						singleClickExpand:true,
						listeners:{
							//监听双击事件
							"dblclick":function(node){
								myExpand(node);
							},//监听单击
							"click":function(node){ 
								pageid =1;
								now_node = node;
				      			showbranchlist(); 
				            },
								//监听右键
							"contextmenu":function(node,e){
								//列出右键菜单
							var	menu=new Ext.menu.Menu([
								{
										text:"<%= MipWebJSPUi.mipweb_admin_branchmanager_7 %>",
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
				    DHalert(<%= MipWebJSPUi.mipweb_admin_branchmanager_8 %>"+errorString);
				}
	});
}
function showbranchlist(){
	var now_branchid ="";
	if(now_node!=null||now_node!=undefined){
		now_branchid = now_node.id;
		$('showcreate').style.display="";
	}
	Progress('<%= MipWebJSPUi.mipweb_admin_branchmanager_9 %>','<%= MipWebJSPUi.mipweb_admin_branchmanager_10 %>');
	  BranchAction.showBranchList(now_branchid,pageid,
			{
				callback:function(objXml) {
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../branchmanager/xslt/branchlist.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_admin_branchmanager_11 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_admin_branchmanager_12 %>"+errorString);
				}
			});
}

function myExpand(node){
	if(node.item(0)==undefined){
			BranchAction.loadBranch(node.id,{
				callback:function(olist) {
						
						CloseProgress();
				      
						for(var i=0;i<olist.length;i++){
							var childnode = new Ext.tree.TreeNode({
							id:olist[i].id,
							text:olist[i].branchname,
							hrefTarget:"mainFrame",
							listeners:{//监听
					          
								//监听双击事件
								"dblclick":function(node){
									myExpand(node);
								},//监听单击事件
								"click":function(node){ 
									pageid =1;
									now_node=node;
					                 showbranchlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"<%= MipWebJSPUi.mipweb_admin_branchmanager_13 %>",
											icon:"../theme/images/list.gif",
											handler:function(){
												showbranch(node.id);
											}
									}]);
									//显示在当前位置
									menu.showAt(e.getPoint());
								}
							}
							});
							node.appendChild(childnode);																		   
						    myExpand(childnode);
						    if(node.id==enterpriseid)	
						       node.expand();													
						}							
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_admin_branchmanager_14 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	showbranchlist();
}
function showbranch(branchid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_admin_branchmanager_15 %>", "../branchmanager/admin_showbranch.jsp?branchid="+branchid,550,878);
}

//删除一个部门
		function delbranch(branchid){
			Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_admin_branchmanager_16 %>', function(btn){
									if(btn=='yes'){
										BranchAction.deleteBranch(branchid,
											function(data){	
												if(data=='1'){
													DHalert("<%= MipWebJSPUi.mipweb_admin_branchmanager_17 %>");
													$('tree').innerHTML="";
													getRootBranch()
													loadBranch("");
													now_branchid = "";
													showbranchlist();
												}else{
													DHalert("<%= MipWebJSPUi.mipweb_admin_branchmanager_18 %>"+data);
												}		 
												
											}
										);
									}
				});
		}
		
		//创建一个部门信息
		function createbranch(){
			var now_branchid ="";
			if(now_node!=null||now_node!=undefined){
				now_branchid = now_node.id;
			}
			if(now_branchid=='-1'){
				DHalert("<%= MipWebJSPUi.mipweb_admin_branchmanager_19 %>") ;
				return ;
			}
			GB_showCenter("", "../branchmanager/create_branch.jsp?parentid="+now_branchid,460,460);
		}
			//关闭子页面
	function closePage(){
		CloseProgress();
		showbranchlist();
		$('tree').innerHTML="";
		getRootBranch();
		loadBranch("");
		GB_CURRENT.hide();
	}
	
		//修改一个部门信息
		function modbranch(bid){
			var now_branchid ="";
			if(now_node!=null||now_node!=undefined){
				now_branchid = now_node.id;
			}
			GB_showCenter("", "../branchmanager/mod_branch.jsp?bid="+bid+"&parentid="+now_branchid,460,460);
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
</script>
	</head>
	<body>
		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!-- begin center -->
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
							<%= MipWebJSPUi.mipweb_admin_branchmanager_20 %>
						</div>
					</div>
					<table width="99%" border="0" align="center" cellpadding="0"
						cellspacing="0" style="border: 1px solid #CAD7DF;">
						<tr>
							<td id="treecontent" width="24%">
								<div id="tree"
									style="margin: 0px; padding: 0px; valign: top; width:100%; height: 400px"></div>
							</td>
							<td id="rightcontent" width="76%" valign="top">
								<div style="margin: 0px; padding: 0px; clear: both">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td colspan="5" class="title">
												<%= MipWebJSPUi.mipweb_admin_branchmanager_21 %>
											</td>
										</tr>
										<tr id="showcreate" style="display: none">
											<td colspan="5" align="right">
												<input type="button" class="button_4 margin_right_5"
													value="<%= MipWebJSPUi.mipweb_admin_branchmanager_22 %>" onclick="javascript:createbranch();" />
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<table width="100%">
													<tr>
														<td width="252">
															<div class="submenu">
															</div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<div id="userlist"></div>
											</td>
										</tr>
									</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
