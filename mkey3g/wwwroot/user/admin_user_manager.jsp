<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebJSPUi.mipweb_user_admin_user_manager_1 %></title>
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



		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
 var seachtype=0;//两种情况 1:按组查找 2：按条件搜索
 var searchvalue = "" ;
 	 var root;
 	 var mytree;
 	 var pageid=1;
	 var now_node;	 
	var w1=0;
	var w2=0;
	var isSearch = false ;
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_admin_user_manager_2 %>', function(btn){
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
		createTree();
		loadBranch("");
		
		w1= document.body.clientWidth*0.77*0.24;
		w2=document.body.clientWidth*(1-0.77*0.24);
	}
	function createTree(){
		w1= document.body.clientWidth*0.77*0.24;
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_admin_user_manager_3 %>",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:" ",
		  collapsible:true,
		  enableDD:false,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		 // autoHeight:false,
		  width:w1,
		  autoWidth:false,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('<%= MipWebJSPUi.mipweb_user_admin_user_manager_4 %>','<%= MipWebJSPUi.mipweb_user_admin_user_manager_5 %>');
	
	User2.getGroupList(branchid,{
			callback:function(olist) {
					
					CloseProgress();
					if(branchid==""&&olist.length>0){
						now_branchid = olist[0].id;
						now_branchtext ="";
						showuserlist();
					}
					dwr.util.setEscapeHtml(false);
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
								isSearch = false ;
								pageid =1;
								now_node=node;
				                showuserlist(); 
				            },
								//监听右键
							"contextmenu":function(node,e){
								//列出右键菜单
							var	menu=new Ext.menu.Menu([
								{
										text:"<%= MipWebJSPUi.mipweb_user_admin_user_manager_6 %>",
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_7 %>"+errorString);
				}
	});
}
function showuserlist(){
	seachtype=1;
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_admin_user_manager_8 %>','<%= MipWebJSPUi.mipweb_user_admin_user_manager_9 %>'); 
	var now_branchid="";
	if(now_node!=null&&now_node!=undefined){
		now_branchid = now_node.id;
	}
	  User2.showUserList(now_branchid,pageid,
			{
				callback:function(objXml) {
					$('delmenu').style.display = "";
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../user/xslt/user_list.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
					if(errorString=="网页过期，请重新登录"){
						window.location.reload();
					}
				    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_10 %>"+errorString);
				}
			});
}

function myExpand(node){
	if(node.item(0)==undefined){
			User2.getGroupList(node.id,{
				callback:function(olist) {
						dwr.util.setEscapeHtml(false);
						CloseProgress();
						for(var i=0;i<olist.length;i++){
							var groupname =olist[i].groupname;
							if(olist[i].groupname.indexOf('<')>=0||olist[i].groupname.indexOf('>')>=0){
								groupname =  groupname.replace('<','&lt;')
								groupname =  groupname.replace('>','&gt;')
							}
							var childnode = new Ext.tree.TreeNode({
							id:olist[i].id,
							text:groupname,
							hrefTarget:"mainFrame",
							listeners:{//监听
					          
								//监听双击事件
								"dblclick":function(node){
									myExpand(node);
								},//监听单击事件
								"click":function(node){ 
									isSearch = false ;
									pageid =1;
									now_node=node;
					                 showuserlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"<%= MipWebJSPUi.mipweb_user_admin_user_manager_11 %>",
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_12 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	if(!isSearch){
		showuserlist();
	}else{
		searchuser();
	}
	
}
function showbranch(branchid){
	//GB_showCenter("部门详情", "../user/showbranch.jsp?branchid="+branchid,550,878);
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_13 %>", "../user/admin_showgroup.jsp?branchid="+branchid,550,878);
}
function showuser(userid){
	var nowgroupid ="";
   	if(now_node!=null&&now_node!=undefined){
   		nowgroupid = now_node.id;
   	}
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_14 %>", "../user/showuser.jsp?userid="+userid+"&nowgroupid="+nowgroupid,550,878);
}
function deletebranch(branchid){
	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_admin_user_manager_15 %>', function(btn){
					if(btn=='yes'){
								 BranchAction.deleteBranch(branchid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_16 %>");
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_17 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_18 %>"+errorString);
									}
								});			
							}
						}
						);
		}
	function modbranch(branchid){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_19 %>", "../user/modbranch.jsp?branchid="+branchid,550,878);	
	}
    function add_user(){
    	var nowgroupid ="";
    	if(now_node!=null&&now_node!=undefined){
    		nowgroupid = now_node.id;
    	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_20 %>", "../user/adduser.jsp?branchid="+nowgroupid,550,878);	
    }
     function moduser(userid){
     	var nowgroupid ="";
	   	if(now_node!=null&&now_node!=undefined){
	   		nowgroupid = now_node.id;
	   	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_21 %>", "../user/moduser.jsp?userid="+userid+"&nowgroupid="+nowgroupid,550,878);	
    }
    
    //add by mahm:用户转移部门或者复制到群组
    function transferuser(userid){
    var oldgroupid="";
    if(!isSearch){
    	if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}else{
			oldgroupid='<%=session.getAttribute("enterpriseid")%>'
		}
    }
   
    GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_22 %>", "../user/transferuser.jsp?userid="+userid+"&oldgroupid="+oldgroupid,550,878);	
    }
    
    
    function deluser(userid){
     var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    	
    	Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_admin_user_manager_23 %>', '<input type="radio" name="alldel" id="deluser" /><%= MipWebJSPUi.mipweb_user_admin_user_manager_24 %><input type="radio" name="alldel" id="exituser" /><%= MipWebJSPUi.mipweb_user_admin_user_manager_25 %>', function(btn){
					if(btn=='yes'){
								var deltype="" ;
								if(document.getElementById('deluser').checked){
									deltype="0" ;
								}
								if(document.getElementById('exituser').checked){
									deltype="1" ;
								}			
								if(deltype==null||deltype==""){

									DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_26 %>");

									return false ;
								}
								 User2.delUser(userid,0,oldgroupid,deltype,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_27 %>");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_28 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_29 %>"+errorString);
									}
								});			
							}
						}
						);
    }
    
    
    
    function loadsearchuser(){
    	seachtype=$('searchtype').value;
		searchvalue = $('searchoption').value ;
		pageid=1;
		searchuser();
	}
	
	function searchuser(){
		 isSearch = true ;


		 Progress('<%= MipWebJSPUi.mipweb_user_admin_user_manager_30 %>','<%= MipWebJSPUi.mipweb_user_admin_user_manager_31 %>');
		 User2.searchUser(seachtype,searchvalue,pageid,
				{
					callback:function(objXml) {
						$('delmenu').style.display = "none";//干掉删除按扭吧.
						CloseProgress();
						 DisplayTransformedXML(1, objXml, "../user/xslt/user_list_groups.xsl",document.getElementById("userlist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_32 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_admin_user_manager_33 %>"+errorString);
					}
				});
	}
	function upuser(userid){
	     var now_branchid="";
		if(now_node!=null&&now_node!=undefined){
			now_branchid = now_node.id;
		}
		 User2.upuser(userid,now_branchid,
				{
					callback:function(objXml) {
						if(objXml=='1'){
							ChangePage(pageid);
						}else{
							 DHalert(objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert(errorString);
					}
				});
	}
	function downuser(userid){
		  var now_branchid="";
		if(now_node!=null&&now_node!=undefined){
			now_branchid = now_node.id;
		}
		 User2.downuser(userid,now_branchid,
				{
					callback:function(objXml) {
						if(objXml=='1'){
							ChangePage(pageid);
						}else{
							 DHalert(objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert(errorString);
					}
				});
	}
	function orderagain(){
		var now_branchid="";
		if(now_node!=null&&now_node!=undefined){
			now_branchid = now_node.id;
		}
		 User2.orderagain(now_branchid,
				{
					callback:function(objXml) {
						if(objXml=='1'){
							ChangePage(pageid);
						}else{
							 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_34 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_35 %>"+errorString);
					}
				});
	}
	//清空查询内容
	function clearSearch(){
		$('searchoption').value="";
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
   //批量删除用户
    function delUsers()
    {
		var chks = document.getElementsByName('idmark');
		var values = new Array();
		for(i = 0;i < chks.length ;i++)
		{
			if(chks[i].checked == true)
			{
				values[i] = chks[i].value;
				
			}
		}
		
		if(values.length < 1)
		{
			DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_36 %>");
			return;
		}
		
		//当前的群组ID
		var oldgroupid="";
	    if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}
		Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_admin_user_manager_37 %>', '<input type="radio" name="alldel" id="deluser" /><%= MipWebJSPUi.mipweb_user_admin_user_manager_38 %><input type="radio" name="alldel" id="exituser" /><%= MipWebJSPUi.mipweb_user_admin_user_manager_39 %>', function(btn){
			if(btn == 'yes')
			{	
				var deltype="" ;
				if(document.getElementById('deluser').checked){
					deltype="0" ;
				}
				if(document.getElementById('exituser').checked){
					deltype="1" ;
				}			
				if(deltype==null||deltype==""){

					DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_40 %>");
					return false ;
				}
				Progress("<%= MipWebJSPUi.mipweb_user_admin_user_manager_41 %>","<%= MipWebJSPUi.mipweb_user_admin_user_manager_42 %>");
				User2.delUsers(values,0,oldgroupid,deltype,{
					callback:function(msg)
					{
						if(msg == "1")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_43 %>");
						}else if(msg == "0")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_manager_44 %>");
						}
						showuserlist();
					}
				});
			}
		});
    }
    
    
     //add by mahm:对查询出来后的用户进行删除
    function deluserfromgroups(userid){
  		  GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_manager_45 %>", "../user/usergroups.jsp?userid="+userid,300,500);	
    }
    
    
</script>
	</head>
	<body>
		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!-- begin center -->
		<div id="center">

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
						<div id="center_nav_box">
							<div id="center_nav">
								<%= MipWebJSPUi.mipweb_user_admin_user_manager_46 %>
							</div>
						</div>
						<!-- 中部主要内容开始 -->


						<table width="99%" height="27" border="0" align="center"
							cellpadding="0" cellspacing="0" style="margin-top: 11px;">
							<tr>
								<td background="../theme/images/list_top_bg.jpg">
									<div class="list_top_left">
										<span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_admin_user_manager_47 %></span>
									</div>
									<div class="list_top_right">
										<a href="#" class="white_12"></a>
									</div>
								</td>
							</tr>
						</table>
						<table width="99%" border="0" align="center" cellpadding="0"
							cellspacing="0" style="border: 1px solid #CAD7DF;">
							<tr>
								<td width="24%" valign="top" id="treecontent">
									<div id="tree"
										style="margin:0px;padding:0px;valign:top;height:400px;width:24%;overflow:hidden;"></div>
								</td>
								<td width="76%" valign="top" id="rightcontent">
									<div style="margin: 0px; padding: 0px; clear: both">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td colspan="5" class="title">
													<%= MipWebJSPUi.mipweb_user_admin_user_manager_48 %>
												</td>
											</tr>
											<tr>

												<td colspan="5">
													<table width="100%">
														<tr>
															<td class="height25">
																<div class="submenu">
				<input type="button" class="button_5" value="<%= MipWebJSPUi.mipweb_user_admin_user_manager_49 %>" onclick="add_user()"/>
				<input type="button" id="delmenu" class="button_2" value="<%= MipWebJSPUi.mipweb_user_admin_user_manager_50 %>" onclick="javascript:delUsers();"/>
				<!--  <a href="#" onclick="add_user()">新增联系人</a>
				<a href="#" id="delmenu" onclick="javascript:delUsers();">删除</a>
				-->
<input style="display:none" type="button" value="<%= MipWebJSPUi.mipweb_user_admin_user_manager_51 %>" onclick="orderagain()" class="button_4 margin_right_10"/>

																	<%= MipWebJSPUi.mipweb_user_admin_user_manager_52 %>
																	<select id="searchtype" onchange="clearSearch()">
																		<option value='0'>
																			<%= MipWebJSPUi.mipweb_user_admin_user_manager_53 %>
																		</option>
																		<option value='1'>
																			<%= MipWebJSPUi.mipweb_user_admin_user_manager_54 %>
																		</option>
																	</select>
																	<input type="text" id="searchoption" class="input_text"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" maxlength="20"/>
																	<input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_user_manager_55 %>" class="button_2"
																		onclick="loadsearchuser()" />
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
