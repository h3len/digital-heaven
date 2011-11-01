<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipUi" %>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@page import="com.dheaven.mip.util.InterfaceUtils"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebJSPUi.mipweb_user_business_user_1 %></title>
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
	var username ="<%=session.getAttribute("username")%>";
	var nophoneflag ="<%=request.getParameter("nophone") !=null ? request.getParameter("nophone") : ""%>";
	var nophonecheck = nophoneflag; 
 	var root;
 	var mytree;
 	var pageid=1;
 	var now_branchid ="";
 	var now_branchtext ="";	
 	var by ;
	var key ;

	var isSearch = false ;

 	
 	var w1;
 	var w2; 
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_business_user_2 %>', function(btn){
					if(btn=='yes'){
							location.href='login.html';	
							return;					
							}
						}
						);
		}

	function showmenu(){
		document.getElementById("center_left_tree").style.display='block';
		document.getElementById("center_left").className = "center_left";
		document.getElementById("center_right").style.width = "77%";
		}


	window.onload=function(){
		if(nophoneflag=="nophone"){
			document.getElementById('keyword').style.display = "none";
			document.getElementById('searchby').options[2].selected='true';
		}
		createTree();
		loadBranch("");
		if(username=="emaadmin"){
		$('adduser').disabled=true;
		$('importuser').disabled=true;
		}
		if(!<%=Constants.canoperateuser %>){
			document.getElementById("adduser").style.display="none" ;
			document.getElementById("deluser").style.display="none" ;
		}
		
		w1= document.body.clientWidth*0.77*0.24;
		w2=document.body.clientWidth*(1-0.77*0.24);
	}
	function createTree(){
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_business_user_3 %>",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:"<%= MipWebJSPUi.mipweb_user_business_user_4 %>",
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
	Progress('<%= MipWebJSPUi.mipweb_user_business_user_5 %>','<%= MipWebJSPUi.mipweb_user_business_user_6 %>');
	BranchAction.loadBranch(branchid,{
			callback:function(olist) {
					
					CloseProgress();
					if(branchid==""&&olist.length>0){
						now_branchid = olist[0].id;
						now_branchtext =olist[0].id;
						showuserlist();
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
								now_branchid = node.id;
								now_branchtext = node.text;
				                showuserlist(); 
				            }
						}
					  });
					    root.appendChild(sub1);
					    myExpand(sub1);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_7 %>"+errorString);
				}
	});
}
function showuserlist(){

	isSearch = false ;
	var serchFlag = false;
	if(nophoneflag==''){
		serchFlag = true;
	}
	Progress('<%= MipWebJSPUi.mipweb_user_business_user_8 %>','<%= MipWebJSPUi.mipweb_user_business_user_9 %>'); 

	  User2.showBranchUserList(now_branchid,serchFlag,pageid,
			{
				callback:function(objXml) {
					CloseProgress();
					if(username!=""&&username=="emaadmin"){
						DisplayTransformedXML(1, objXml, "../user/xslt/user_biz_emaadmin.xsl",document.getElementById("userlist"));
					}else{
						DisplayTransformedXML(1, objXml, "../user/xslt/user_biz.xsl",document.getElementById("userlist"));
					}	
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_10 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_business_user_11 %>"+errorString);
				}
			});
}

//搜索方法
function doSearch()
{
	Progress('<%= MipWebJSPUi.mipweb_user_business_user_12 %>','<%= MipWebJSPUi.mipweb_user_business_user_13 %>');
	pageid = 1;
	by = $('searchby').value;
	key = $('keyword').value;
	if(key == '' && nophonecheck == '')
	{
		DHalert("<%= MipWebJSPUi.mipweb_user_business_user_14 %>");
		return false;
	}
	var type = '0';
	if(by != '' &&by == 'byphone')
	{
		type = '1';
	}else if(by!='' && by=='bynophone')
	{
		type = '2';
	}
	User2.searchSysUser(type,key,pageid,{
		callback:function(objxml) {
					isSearch = true ;
					if(username!=""&&username=="emaadmin"){
						DisplayTransformedXML(1, objxml, "../user/xslt/user_biz_emaadmin.xsl",document.getElementById("userlist"));
					}else{
						DisplayTransformedXML(1, objxml, "../user/xslt/user_biz_search.xsl",document.getElementById("userlist"));
					}
					CloseProgress();	
				},
		errorHandler:function(errorString, exception) {
			CloseProgress();
			DHalert("<%= MipWebJSPUi.mipweb_user_business_user_15 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_business_user_16 %>"+errorString);
		}
		});	
}

function ChangeSearchPage(pid){
	isSearch = true ;
	pageid = pid ;
	if(key == '' && nophonecheck == '')
	{
		DHalert("<%= MipWebJSPUi.mipweb_user_business_user_17 %>");
		return false;
	}
	var type = '0';
	if(by != '' &&by == 'byphone')
	{
		type = '1';
	}else if(by!='' && by=='bynophone')
	{
		type = '2';
	}
	
	User2.searchSysUser(type,key,pageid,{
		callback:function(objxml) {
					if(username!=""&&username=="emaadmin"){
						DisplayTransformedXML(1, objxml, "../user/xslt/user_biz_emaadmin.xsl",document.getElementById("userlist"));
					}else{
						DisplayTransformedXML(1, objxml, "../user/xslt/user_biz_search.xsl",document.getElementById("userlist"));
					}
					CloseProgress();	
				},
		errorHandler:function(errorString, exception) {
			CloseProgress();
			DHalert("<%= MipWebJSPUi.mipweb_user_business_user_18 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_business_user_19 %>"+errorString);
		}
		});	
}

function freeze(userid){
	Progress('<%= MipWebJSPUi.mipweb_user_business_user_20 %>','<%= MipWebJSPUi.mipweb_user_business_user_21 %>'); 
	  User2.freeze(userid,
			{
				callback:function(objXml) {
					CloseProgress();
					if(objXml=='1'){
							ChangePage(pageid);
						 DHalert("<%= MipWebJSPUi.mipweb_user_business_user_22 %>");
					}else{
						 DHalert("<%= MipWebJSPUi.mipweb_user_business_user_23 %>"+objXml);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_24 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_business_user_25 %>"+errorString);
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
									now_branchid = node.id;
									now_branchtext = node.text;
					                 showuserlist(node);
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_26 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	showuserlist();
}
function showbranch(branchid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_27 %>", "../user/showbranch.jsp?branchid="+branchid,550,878);
}
function showuser(userid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_28 %>", "../user/showsysuser.jsp?userid="+userid,550,878);
}
function enableuser(userid,type){
	if(type==0){
		Progress('<%= MipWebJSPUi.mipweb_user_business_user_29 %>','<%= MipWebJSPUi.mipweb_user_business_user_30 %>'); 
		 User2.closeuser(userid,
			{
				callback:function(otext) {
					if(otext=='1'){
						DHalert("<%= MipWebJSPUi.mipweb_user_business_user_31 %>");
						ChangePage(pageid);
					}else{
						DHalert("<%= MipWebJSPUi.mipweb_user_business_user_32 %>"+otext);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_33 %>"+errorString);
				}
			});
	}else{
		 User2.enableuser(userid,
			{
				callback:function(otext) {
					if(otext=='1'){
						DHalert("<%= MipWebJSPUi.mipweb_user_business_user_34 %>");
					    parent.parent.ChangePage(parent.parent.pageid);
					}else{
						DHalert("<%= MipWebJSPUi.mipweb_user_business_user_35 %>"+otext);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_36 %>"+errorString);
				}
			});
	}
	
	
}
function changepass(userid){

	if(isSearch){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_37 %>", "../user/changepass.jsp?userid="+userid+"&isSearch=true",300,400);
	}else{
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_37 %>", "../user/changepass.jsp?userid="+userid,300,400);
	}

}

function threeBindByuid(uid){
	GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_38 %>", "../user/threebind.jsp?uid="+uid,300,400);
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


function add_user(){
   	GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_39 %>", "../user/addsysuser.jsp?branchid="+now_branchid,550,878);	
}
function moduser(userid){
	if(isSearch){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_40 %>", "../user/modsysuser.jsp?userid="+userid+"&isSearch="+isSearch,550,878);
	}else{
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_40 %>", "../user/modsysuser.jsp?userid="+userid,550,878);
	}
}

function updatePass(){
   	GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_41 %>", "../user/updatePassValidate.jsp",550,878);	
}
 function deluser(userid){
    	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_business_user_42 %>', function(btn){
					if(btn=='yes'){
								 User2.delUser(userid,1,"","",
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_business_user_43 %>");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_business_user_44 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_45 %>"+errorString);
									}
								});			
							}
						}
						);
    }

function tempdata()
{
	var byname = false;
	var byphone = false;
	var bynophone = false;
	var name = '';
	var phone = '';
}
var cache = new tempdata();
function clearSearch(by)
{
	var val = '';
	
		if(by == 'byphone')
		{
			nophonecheck = '';
			document.getElementById('keyword').style.display = "";
			cache.byphone = true;
			cache.phone = val;			
		}else if(by == 'byname')
		{
			nophonecheck = '';
			document.getElementById('keyword').style.display = "";
			cache.byname = true;
			cache.name = val;
		}else if(by == 'bynophone')
		{
			nophonecheck = nophoneflag;
			document.getElementById('keyword').style.display = "none";
			cache.bynophone = true;
		}
	
	if(by == 'byname' && cache.byname)
	{
		$('keyword').value = cache.name;
	}else if(by == 'byphone' && cache.byphone)
	{
		$('keyword').value = cache.phone;
	}else if(by == 'bynophone' && cache.bynophone)
	{
		$('keyword').value = 'nophone';
	}
	else{
		$('keyword').value = '';
	}
}
//全选
function checkAll()
{
	var boxs = document.getElementsByName('mark');
	for(i = 0;i < boxs.length;i++)
	{
		boxs[i].checked = true;
	}
}

function inverse()
{
	var boxs  = document.getElementsByName('mark');
	for(i = 0;i < boxs.length;i++)
	{
		boxs[i].checked?boxs[i].checked = false:boxs[i].checked = true;
	}
}

//批量删除用户
function delAllSelect()
{
	var boxs = document.getElementsByName('mark');
	var values = new Array();
	for(i = 0;i < boxs.length;i++)
	{
		boxs[i].checked?values.push(boxs[i].value): i;
	}
	if(values.length == 0)
	{
		DHalert('<%= MipWebJSPUi.mipweb_user_business_user_46 %>');
		return;
	}
	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_business_user_47 %>', function(btn){
		if(btn == 'yes')
		{
			Progress("<%= MipWebJSPUi.mipweb_user_business_user_48 %>","<%= MipWebJSPUi.mipweb_user_business_user_49 %>");
			User2.delUsers(values,1,"","",{
				callback:function(msg){
						if(msg == "1")
						{
							CloseProgress();
							SDHalert("<%= MipWebJSPUi.mipweb_user_business_user_50 %>",130);
						}else if(msg == "0")
						{
							CloseProgress();
							SDHalert("<%= MipWebJSPUi.mipweb_user_business_user_51 %>",130);
						}
						if(isSearch){
							ChangeSearchPage(pageid) ;
						}else{
							showuserlist();
						}
				}
			});
		}
	});
}

//用户上移排序
function sortuserup(userId){
	var branchId = now_branchid ;
	
	User2.sortUserUp(branchId,userId,
		{
			callback:function(msg){
					if(msg == "1")
					{
						showuserlist();
					}else
					{
						DHalert(msg);
					}
			},
			errorHandler:function(errorString, exception) {
			    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_52 %>"+errorString);
			}
		})
}

//用户下移排序
function sortuserdown(userId){
	var branchId = now_branchid ;
	
	User2.sortUserDown(branchId,userId,
		{
			callback:function(msg){
					if(msg == "1")
					{
						showuserlist();
					}else
					{
						DHalert(msg);
					}
			},
			errorHandler:function(errorString, exception) {
			    DHalert("<%= MipWebJSPUi.mipweb_user_business_user_53 %>"+errorString);
			}
		})
}
              /**从excel中导入系统用户**/
			function importSysUser(){
					GB_showCenter("<%=MipWebJSPUi.mipweb_user_import_sys_user_1%>","../user/importSysuser.jsp?enterpriseid="+now_branchid+"&pageid="+pageid,550,878);
			}
			
	function extendbutton(userid,name,url){
		GB_showCenter(name,url+"?userid="+userid+"&enterpriseid="+now_branchid+"&pageid="+pageid,550,878);
	}
	//用户证书
	function showcert(id){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_business_user_67 %>","../user/sysuserCert.jsp?id="+id,400,600);
	}
	
	function applyCert(){
		var boxs = document.getElementsByName('mark');
		var values = new Array();
		for(var i = 0;i<boxs.length;i++){
			if(boxs[i].checked){
				values.push(boxs[i].value);
			}
		}
		if(values.length == 0)
		{
			DHalert('<%= MipUi.get("mipweb_user_business_user_70") %>');
			return;
		}
		Progress('<%= MipUi.get("mipweb_user_business_user_48") %>','<%= MipUi.get("mipweb_user_business_user_49") %>');
		User2.applyCert(values,
		{
			callback:function(data){
				if(data==""){
					CloseProgress();
					SDHalert("<%= MipWebJSPUi.mipweb_user_business_user_50 %>",130);
				}else{
					CloseProgress();
					DHalert(data);
				}
			},errorHandler:function(errorString,exception){
				DHalert('<%= MipUi.get("mipweb_user_business_user_52") %>'+errorString);
			}
		}
		);
	}
	function updateCert(){
		var boxs = document.getElementsByName('mark');
		var values = new Array();
		for(var i = 0;i<boxs.length;i++){
			if(boxs[i].checked){
				values.push(boxs[i].value);
			}
		}
		if(values.length == 0)
		{
			DHalert('<%= MipUi.get("mipweb_user_business_user_72") %>');
			return;
		}
		Progress('<%= MipUi.get("mipweb_user_business_user_48") %>','<%= MipUi.get("mipweb_user_business_user_49") %>');
		User2.updateCert(values,
		{
			callback:function(data){
				if(data==""){
					CloseProgress();
					SDHalert("<%= MipWebJSPUi.mipweb_user_business_user_50 %>",130);
				}else{
					CloseProgress();
					DHalert(data);
				}
			},errorHandler:function(errorString,exception){
				DHalert('<%= MipUi.get("mipweb_user_business_user_52") %>'+errorString);
			}
		}
		);
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
					<div id="center_nav_box">
						<div id="center_nav">
							<%= MipWebJSPUi.mipweb_user_business_user_54 %>
						</div>
					</div>
					<!-- 中部主要内容开始 -->


					<table width="100%" height="27" border="0" align="center"
						cellpadding="0" cellspacing="0" style="margin-top: 11px;">
						<tr>
							<td background="../theme/images/list_top_bg.jpg">
								<div class="list_top_left">
									<span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_business_user_55 %></span>
								</div>
								<div class="list_top_right">
									<a href="#" class="white_12"></a>
								</div>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" align="left" cellpadding="0"
						cellspacing="0" class="border_blue">
						<tr>
							<td id="treecontent" width="24%" valign="top">
								<div id="tree"
									style="margin: 0px; padding: 0px;width:24%; valign: top; height: 400px"></div>
							</td>
							<td id="rightcontent" width="76%" valign="top">
								<div style="margin: 0px; padding: 0px; clear: both">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td colspan="5" class="title">
												<%= MipWebJSPUi.mipweb_user_business_user_56 %>
											</td>
										</tr>
										<tr>

											<td colspan="5">
												<table width="100%">
													<tr>
														<td width="100%">
															<div class="submenu">
																<span style="float:left;display:inline;">																
																<input id="adduser" type="button" class="button_2"
																	value="<%= MipWebJSPUi.mipweb_user_business_user_57 %>" onclick="add_user()" />	
																<input id="importuser" type="button" class="button_4" value="<%=MipWebJSPUi.mipweb_user_business_user_64 %>" onclick="importSysUser()"/>														
																<input id="deluser" type="button" class="button_2"
																	value="<%= MipWebJSPUi.mipweb_user_business_user_58 %>" onclick="javascript:delAllSelect();" />
																<%if(Constants.IDENTIFY_USER_MODE!=2){ %>
																<input id="updatePass" type="button" class="button_4"
																	value="<%= MipWebJSPUi.mipweb_user_business_user_59 %>" onclick="updatePass()" />
																<%if(InterfaceUtils.getMipSSLInterface()!=null){ %>
																<input id="applycert" type="button" class="button_4" value='<%=MipUi.get("mipweb_user_business_user_68") %>' onclick="applyCert()"/>
																<input id="updatecert" type="button" class="button_4" value='<%=MipUi.get("mipweb_user_business_user_71") %>' onclick="updateCert()"/>
																<%} %>
																</span>
																<% }%>
																<span style="float:right;display:inline">
																<%= MipWebJSPUi.mipweb_user_business_user_60 %>
																<select id="searchby"
																	onchange="javascript:clearSearch(this.value);">
																	<option value="byname">
																		<%= MipWebJSPUi.mipweb_user_business_user_61 %>
																	</option>
																	<option value="byphone">
																		<%= MipWebJSPUi.mipweb_user_business_user_62 %>
																	</option>
																	<option  value="bynophone">
																		<%= MipWebJSPUi.mipweb_user_business_user_66 %>
																	</option>
																</select>
																<input type="text" value="" id="keyword" maxlength="20"
																	onmouseover="fEvent('mouseover',this)"
																	onfocus="fEvent('focus',this)"
																	onblur="fEvent('blur',this)"
																	onmouseout="fEvent('mouseout',this)" class="input_text_short" />
																<input type="button" value="<%= MipWebJSPUi.mipweb_user_business_user_63 %>" class="button_2"
																	onclick="javascript:doSearch();" />
																</span>
															</div>
														</td>
														<td>
														</td>
													</tr>
												</table>
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
														<td>
															<!-- 
				<form action="" method="post" name="f">姓名：<input name="" type="text" value="" size="12" maxlength="12" />
				   <input name="" type="image" src="../theme/images/search.gif" />
				</form>				 -->
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
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->



	</body>
</html>
