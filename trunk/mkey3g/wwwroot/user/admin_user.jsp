<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipUserPrivacy"%>
<%@page import="com.dheaven.mip.util.PermissionHelper"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebJSPUi.mipweb_user_admin_user_1 %></title>
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
	boolean isMipcontactManager = false;
	boolean isMipManager = false;
	int scope=0;
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out.print("<script>parent.location.href='../default.jsp?url="
		+ request.getServletPath() + "?"
		+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");

		if (!uid.equals(MipSysuser.Admin_UID)) {

			//只要用户有mipinfo模块的数据，不管那个部门，就表示有管理权限

			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
			.getBean("permissionServiceImpl");

			if (ps.findUserPrivacyByUserIDAndCategoryID(uid,
			"mipcontact") == null) {
			out.print("<script>parent.location.href='../default.jsp?url="
				+ request.getServletPath()
				+ "?"
				+ request.getQueryString()
				+ "'</script>");
		return;
			} else {
				java.util.List list = ps.findUserPrivacyByUserIDAndCategoryID(uid,
				"mipcontact");
				if (list != null && list.size() > 0) {
					MipUserPrivacy mipUserPrivacy = (MipUserPrivacy) list
					.get(0);
					if (PermissionHelper.getPermissionBit(mipUserPrivacy.getPrivacy(), 2))//2为内部通讯录管理权限
					{
						isMipcontactManager = true;
						scope = 1;
					}

				}
			}
		} else {
			isMipManager = true;
			scope=3;
		}
	}
%>
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
 	 var scope =<%=scope %>
 	 var isSearch = false ;
 	 var searchtype ;
 	 var searchvalue = "" ;
 	 
 	 var w1;
 	 var w2;
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_admin_user_2 %>', function(btn){
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
		var showtab = document.getElementsByName("limitsmark") ;
		if(<%=view%>){
			$('center_right').style.display="";
			createTree();
			loadBranch("");
			if(scope==1){
				document.getElementById("addmenu").style.display="" ;
				document.getElementById("delmenu").style.display="" ;
				//showtab.style.display = "block" ;
			}
		}else{
			$('center_right').style.display="none";
			DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_3 %>");
		}

	    w1= document.body.clientWidth*0.77*0.24;
	    w2=document.body.clientWidth*(1-0.77*0.24);			
	}
function createTree(){
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_admin_user_4 %>",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:" ",
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
	Progress('<%= MipWebJSPUi.mipweb_user_admin_user_5 %>','<%= MipWebJSPUi.mipweb_user_admin_user_6 %>');
	
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
								searchvalue = "" ;
								pageid =1;
								now_node=node;
				                showuserlist(); 
				            },
								//监听右键
							"contextmenu":function(node,e){
								//列出右键菜单
							var	menu=new Ext.menu.Menu([
								{
										text:"<%= MipWebJSPUi.mipweb_user_admin_user_7 %>",
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_8 %>"+errorString);
				}
	});
}
function showuserlist(){
	if(!isSearch&&scope==1){
		document.getElementById("delmenu").style.display="" ;
	}else{
		document.getElementById("delmenu").style.display="none" ;
	}
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_admin_user_9 %>','<%= MipWebJSPUi.mipweb_user_admin_user_10 %>'); 
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_11 %>"+errorString);
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
									searchvalue = "" ;
									pageid =1;
									now_node=node;
					                 showuserlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"<%= MipWebJSPUi.mipweb_user_admin_user_12 %>",
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_13 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	
	if(isSearch){
	searchuser();
	}else{
	showuserlist();
	}
}
function showbranch(branchid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_14 %>", "../user/showbranch.jsp?branchid="+branchid,550,878);
}
    function loadsearchuser(){	
		pageid=1;
		 searchvalue = $('searchoption').value ;
		 searchtype = $('searchtype').value ;
		searchuser();
	}
	function searchuser(){
		isSearch = true ;
		 Progress('<%= MipWebJSPUi.mipweb_user_admin_user_15 %>','<%= MipWebJSPUi.mipweb_user_admin_user_16 %>');
		 
		 showtype = 1;
		 User2.searchUser(searchtype,searchvalue,pageid,
				{
					callback:function(objXml) {
						$('delmenu').style.display = "none";//干掉删除按扭吧.
						CloseProgress();
						DisplayTransformedXML(1, objXml, "../user/xslt/userlistgroup.xsl",document.getElementById("divRoleList"));					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_17 %>"+errorString);
					}
				});
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
    
 function add_user(){
    	var nowgroupid ="";
    	if(now_node!=null&&now_node!=undefined){
    		nowgroupid = now_node.id;
    	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_18 %>", "../user/adduser.jsp?branchid="+nowgroupid,550,878);	
    }
     function moduser(userid){
    	var nowgroupid ="";
	   	if(now_node!=null&&now_node!=undefined){
	   		nowgroupid = now_node.id;
	   	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_19 %>", "../user/moduser.jsp?userid="+userid+"&nowgroupid="+nowgroupid,550,878);
    }
    
    
function deluser(userid){
     var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    	
    	Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_admin_user_20 %>', '<input type="radio" name="alldel" id="deluser" /><%= MipWebJSPUi.mipweb_user_admin_user_21 %><input type="radio" name="alldel" id="exituser" /><%= MipWebJSPUi.mipweb_user_admin_user_22 %>', function(btn){
					if(btn=='yes'){
								var deltype="" ;
								if(document.getElementById('deluser').checked){
									deltype="0" ;
								}
								if(document.getElementById('exituser').checked){
									deltype="1" ;
								}			
								if(deltype==null||deltype==""){
									DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_23 %>");
									return false ;
								}
								 User2.delUser(userid,0,oldgroupid,deltype,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_24 %>");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_25 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_26 %>"+errorString);
									}
								});			
							}
						}
						);
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
			DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_27 %>");
			return;
		}
		
		//当前的群组ID
		var oldgroupid="";
	    if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}
		Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_admin_user_28 %>', '<input type="radio" name="alldel" id="deluser" /><%= MipWebJSPUi.mipweb_user_admin_user_29 %><input type="radio" name="alldel" id="exituser" /><%= MipWebJSPUi.mipweb_user_admin_user_30 %>', function(btn){
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
					DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_31 %>");
					return false ;
				}
				Progress("<%= MipWebJSPUi.mipweb_user_admin_user_32 %>","<%= MipWebJSPUi.mipweb_user_admin_user_33 %>");
				User2.delUsers(values,0,oldgroupid,deltype,{
					callback:function(msg)
					{
						if(msg == "1")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_34 %>");
						}else if(msg == "0")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_admin_user_35 %>");
						}
						showuserlist();
					}
				});
			}
		});
    }
    
//删除查询出来的用户
function delsearchuser(userid){
     GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_36 %>", "../user/usergroups.jsp?userid="+userid,300,500);
}
    
function showuser(userid){
	var nowgroupid ="";
   	if(now_node!=null&&now_node!=undefined){
   		nowgroupid = now_node.id;
   	}
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_37 %>", "../user/showuser.jsp?userid="+userid+"&nowgroupid="+nowgroupid,550,878);
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
    GB_showCenter("<%= MipWebJSPUi.mipweb_user_admin_user_38 %>", "../user/transferuser.jsp?userid="+userid+"&oldgroupid="+oldgroupid,550,878);	
    }
    
//上移下移
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
						<div id="center_nav"><%= MipWebJSPUi.mipweb_user_admin_user_39 %></div>
					</div>
					<!-- 中部主要内容开始 -->
					<table  style="display:none" width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../theme/images/alert_bg.gif">
					  <tr>
					    <td width="1%"><img src="../theme/images/alert_left.gif" width="5" height="29" /></td>
					    <td width="2%"><img src="../theme/images/alert_bug.gif" /></td>
					    <td width="90%"><a href="../minioa/admin_default.jsp"><%= MipWebJSPUi.mipweb_user_admin_user_40 %><span class="red" id="oatodo">0</span><%= MipWebJSPUi.mipweb_user_admin_user_41 %></a></td>
					    <td width="2%"><a href="#" onclick ="getToDoNum()"><img src="../theme/images/alert_right.gif" width="24" height="29" border="0" /></a></td>
					  </tr>
					</table>
					
					<table width="99%" height="27" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:11px;">
					  <tr>
					    <td background="../theme/images/list_top_bg.jpg"><div class="list_top_left"><span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_admin_user_42 %></span></div>
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
														<%= MipWebJSPUi.mipweb_user_admin_user_43 %>
													</td>
												</tr>
												<tr>
													<td>
														<input type="button" id="addmenu" style="display: none" class="button_5" value="<%= MipWebJSPUi.mipweb_user_admin_user_44 %>" onclick="add_user()"/>
													</td>
													<td>
														<input type="button" id="delmenu" style="display: none" class="button_2" value="<%= MipWebJSPUi.mipweb_user_admin_user_45 %>" onclick="javascript:delUsers();"/>
													</td>
													<td colspan="3">
														<table width="100%">
															<tr>

																<td>
																	<div style="float: right">
																		<%= MipWebJSPUi.mipweb_user_admin_user_46 %>
																		<select id="searchtype">
																			<option value='0'>
																				<%= MipWebJSPUi.mipweb_user_admin_user_47 %>
																			</option>
																			<option value='1'>
																				<%= MipWebJSPUi.mipweb_user_admin_user_48 %>
																			</option>
																		</select>
																		<input type="text" id="searchoption" />
																		<input type="button" value="<%= MipWebJSPUi.mipweb_user_admin_user_49 %>" class="button_2"
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
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>

</html>
