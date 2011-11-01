<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebJSPUi.mipweb_user_importcontactsysuser_3 %></title>
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
 	 var root;
 	 var mytree;
 	 var pageid=1;
	 var now_node;	 
	var contralenable ='3';
	
	var groupid = "<%=request.getParameter("groupid")%>";
	
	function allexit(){
		Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_1 %>', '<%= MipWebJSPUi.mipweb_user_importcontactsysuser_2 %>', function(btn){
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
			
		}
	}
	window.onload=function(){
		createTree();
		loadBranch("");
		
		
	}
	function createTree(){
		
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_importcontactsysuser_4 %>",
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
		  width:205,
		  //autoWidth:true,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_5 %>','<%= MipWebJSPUi.mipweb_user_importcontactsysuser_6 %>');
	
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
										text:"<%= MipWebJSPUi.mipweb_user_importcontactsysuser_7 %>",
										icon:"../theme/images/list.gif",
										handler:function(){
											//showbranch(node.id);
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_8 %>"+errorString);
				}
	});
}
function showuserlist(){
	seachtype=1;
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_9 %>','<%= MipWebJSPUi.mipweb_user_importcontactsysuser_10 %>'); 
	var now_branchid="";
	if(now_node!=null&&now_node!=undefined){
		now_branchid = now_node.id;
	}
	  User2.showUserListForSel(now_branchid,pageid,
			{
				callback:function(objXml) {
				//	$('delmenu').style.display = "";
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../user/xslt/user_list_selected.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_11 %>"+errorString);
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
											text:"<%= MipWebJSPUi.mipweb_user_importcontactsysuser_12 %>",
											icon:"../theme/images/list.gif",
											handler:function(){
												//showbranch(node.id);
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_13 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	if(seachtype==1){
	showuserlist();
	}else if(seachtype==2){
	searchuser();
	}
	
}

/*
function showbranch(branchid){
	//GB_showCenter("部门详情", "../user/showbranch.jsp?branchid="+branchid,550,878);
		GB_showCenter("群组详情", "../user/admin_showgroup.jsp?branchid="+branchid,550,878);
}
*/
/*
function showuser(userid){
	GB_showCenter("用户详情", "../user/showuser.jsp?userid="+userid,550,878);
}
*/
function deletebranch(branchid){
	Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_14 %>', function(btn){
					if(btn=='yes'){
								 BranchAction.deleteBranch(branchid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_15 %>");
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_16 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_17 %>"+errorString);
									}
								});			
							}
						}
						);
		}
	function modbranch(branchid){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_18 %>", "../user/modbranch.jsp?branchid="+branchid,550,878);	
	}
    function add_user(){
    	var nowgroupid ="";
    	if(now_node!=null&&now_node!=undefined){
    		nowgroupid = now_node.id;
    	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_19 %>", "../user/adduser.jsp?branchid="+nowgroupid,550,878);	
    }
     function moduser(userid){
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_20 %>", "../user/moduser.jsp?userid="+userid,550,878);	
    }
    
    //add by mahm:用户转移部门或者复制到群组
    function transferuser(userid){
    var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_21 %>", "../user/transferuser.jsp?userid="+userid+"&oldgroupid="+oldgroupid,550,878);	
    }
    
    
    function deluser(userid){
     var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    
    	Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_22 %>', '<%= MipWebJSPUi.mipweb_user_importcontactsysuser_23 %>', function(btn){
					if(btn=='yes'){
								 User2.delUser(userid,0,oldgroupid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_24 %>");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_25 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_26 %>"+errorString);
									}
								});			
							}
						}
						);
    }
    
    
    
    function loadsearchuser(){
		pageid=1;
		searchuser();
	}
	
	function searchuser(){
		 seachtype=2;
		 Progress('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_27 %>','<%= MipWebJSPUi.mipweb_user_importcontactsysuser_28 %>'); 
		 User2.searchUserForSel($('searchtype').value,$('searchoption').value,pageid,
				{
					callback:function(objXml) {
						//$('delmenu').style.display = "none";//干掉删除按扭吧.
						CloseProgress();
						 DisplayTransformedXML(1, objXml, "../user/xslt/user_list_selected_search.xsl",document.getElementById("userlist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_29 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_importcontactsysuser_30 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_31 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_32 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_33 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_34 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_35 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_36 %>"+errorString);
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
			DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_37 %>");
			return;
		}
		
		//当前的群组ID
		var oldgroupid="";
	    if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}
		Ext.Msg.confirm('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_38 %>', '<%= MipWebJSPUi.mipweb_user_importcontactsysuser_39 %>', function(btn){
			if(btn == 'yes')
			{
				Progress("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_40 %>","<%= MipWebJSPUi.mipweb_user_importcontactsysuser_41 %>");
				User2.delUsers(values,0,oldgroupid,{
					callback:function(msg)
					{
						if(msg == "1")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_42 %>");
						}else if(msg == "0")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_43 %>");
						}
						showuserlist();
					}
				});
			}
		});
    }
    
    
     //add by mahm:对查询出来后的用户进行删除
    function deluserfromgroups(userid){
  		  GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_44 %>", "../user/usergroups.jsp?userid="+userid,300,500);	
    }
   function add(){
			var chks = document.getElementsByName('idmark');
			var values = new Array();
			for(var i = 0;i < chks.length ;i++)
			{
				if(chks[i].checked == true)
				{
					values[i] = chks[i].value;
					
				}
			}
			
			if(values.length < 1)
			{
				DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_45 %>");
				return;
			}
			for(var i=0;i<values.length;i++){
				//alert(values[i].replace("'",""))
				var tmpvalue="";
			   if(values[i]!=null && values[i]!=undefined){
				    var selected_users=values[i].replace(/\'/g,"");
				    var tmpvalue = values[i].replace(/\'/g,"");
				    var oOptions =tmpvalue.split('$');
				    var oOption = document.createElement("OPTION");
				    var pos2 = $('possess2');
				    var b=false;
				    for(var j=0;j<pos2.length;j++){
				    	if(oOptions[2]==pos2[j].value){
				    		b=true;
				    	}
				    }
				    if(b){
				    	continue;
				    }
					oOption.text = oOptions[1];
					oOption.value =oOptions[2];	
					oOption.ondblclick= function(){
						delout();
					 }
				 document.all?$('possess2').add(oOption):$('possess2').appendChild(oOption);
			   }
			}
			enableDelUser();
		}
		
     	 function delme2(a){
			//alert(a)
			for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].value==a){
					$('possess2').remove(i);
				}
			}
		}
		function delout(){
			for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].selected==true){
						$('possess2').remove(i);
						i--;
				}
			}
		}
		function subok(){
	   		var obj= document.getElementById('possess2');
			if(obj.length==0){
			 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_46 %>");
			 return;
			}
			var userids = new Array() ;
			for(var i=0;i<obj.length;i++){
				if(obj[i].value!=null&&obj[i].value!=""){
					userids[i] = obj[i].value ;
				}
			}
		   	 if(obj.length>0){		
				 Progress('<%= MipWebJSPUi.mipweb_user_importcontactsysuser_47 %>','<%= MipWebJSPUi.mipweb_user_importcontactsysuser_48 %>');
				 User2.fromContact(userids,groupid,
				{
					callback:function(otext) {
						if(otext=='1'){
							parent.parent.ChangePage(parent.parent.pageid);
							parent.parent.GB_CURRENT.hide();
						}else{
							parent.parent.DHalert(otext) ;
							CloseProgress();
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_49 %>"+errorString);
					}
				});		
			}
		   	 
	}
	function enableDelUser(){
		var ids = document.getElementsByName('existids');
		var values = new Array();
		
		for(var i= 0;i<ids.length;i++){
			values.push(ids[i].value);
		}
		User2.enableExistUser(values,{
			callback:function(otext){
				if(otext==1){
					DHalert("<%= MipWebJSPUi.mipweb_user_importcontactsysuser_50 %>");
					for(var i=0; i < $('possess2').length; i++){
						$('possess2').remove(i);
						i--;
					}
					return;
				}
			}
		});
	}
</script>
	</head>
	<body>
		
		<div style="width:100%">
			<div style="width:100%">
				<div style="width:100%">
					<div>
							<table width="99%" height="27" border="0" align="center"
							cellpadding="0" cellspacing="0" style="margin-top: 11px;">
							<tr>
								<td background="../theme/images/list_top_bg.jpg">
									<div class="list_top_left">
										<span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_importcontactsysuser_51 %></span>
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
								<td width="24%" valign="top">
									<div id="tree"
										style="margin:0px;padding:0px;valign:top;height:400px;overflow:hidden;"></div>
								</td>
								<td width="76%" valign="top">
									<div style="margin: 0px; padding: 0px; clear: both">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td colspan="5" class="title">
													<%= MipWebJSPUi.mipweb_user_importcontactsysuser_52 %>
												</td>
											</tr>
											<tr>

												<td colspan="5">
													<table width="100%">
														<tr>
															<td class="height25">
																<div class="submenu">
																	<%= MipWebJSPUi.mipweb_user_importcontactsysuser_53 %>
																	<select id="searchtype" onchange="clearSearch()">
																		<option value='0'>
																			<%= MipWebJSPUi.mipweb_user_importcontactsysuser_54 %>
																		</option>
																		<option value='1'>
																			<%= MipWebJSPUi.mipweb_user_importcontactsysuser_55 %>
																		</option>
																	</select>
																	<input type="text" id="searchoption" class="input_text"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" maxlength="20"/>
																	<input type="button" value="<%= MipWebJSPUi.mipweb_user_importcontactsysuser_56 %>" class="button_2"
																		onclick="loadsearchuser()" />
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td colspan="5">
													<table width="100%" border="0" align="center" cellpadding="0"
											cellspacing="5">
											<tr>
												<td width="50%"  valign="top">
													<div id="userlist"></div>
												</td>

												<td width="15%" style="text-align: center" valign="top">
													<table>
														<tr><td height="160"></td></tr>
														<tr>
															<td>
																<input type="button" class="button_4"
																	value="<%= MipWebJSPUi.mipweb_user_importcontactsysuser_57 %>" onclick="add();"
																	style="width: 100px" />
															</td>
														</tr>
														<tr>
															<td>
																<input type="button" class="button_4"
																	value="<%= MipWebJSPUi.mipweb_user_importcontactsysuser_58 %>" onclick="delout()"
																	style="width: 100px" />
															</td>
														</tr>
													</table>
												</td>
												<td width="30%" valign="top">
													<select name="select" id="possess2" multiple="multiple"
																	style="height: 400px; width: 220px"
																	ondblclick="delout()">
															</select>
												</td>

											</tr>
										</table>
												
												</td>
											</tr>

										</table>
								</td>
							</tr>
						</table>
					</div>
					<div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_importcontactsysuser_59 %>" onclick="subok()" /></div>
				</div>
			</div>
	</body>
</html>
