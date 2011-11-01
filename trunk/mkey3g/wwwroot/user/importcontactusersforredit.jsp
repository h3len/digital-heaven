<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%= MipWebJSPUi.mipweb_user_importcontactusers_1 %></title>
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
	var strId = "";
	var searchinfo = "";//查询条件
	var searchinfo_old ="";//保存查询条件
	var contactorphones = "<%=request.getParameter("contactorphones")!=null?request.getParameter("contactorphones"):""%>";
	var id = "<%=request.getParameter("id")%>";
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_importcontactusers_2 %>', function(btn){
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
		      text:"<%= MipWebJSPUi.mipweb_user_importcontactusers_3 %>",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:"<%= MipWebJSPUi.mipweb_user_importcontactusers_4 %>",
		  collapsible:true,
		  enableDD:false,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		 // autoHeight:false,
		  width:210,
		  autoWidth:false,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('<%= MipWebJSPUi.mipweb_user_importcontactusers_5 %>','<%= MipWebJSPUi.mipweb_user_importcontactusers_6 %>');
	
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
										text:"<%= MipWebJSPUi.mipweb_user_importcontactusers_7 %>",
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_8 %>"+errorString);
				}
	});
}
function showuserlist(){
	seachtype=1;
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_importcontactusers_9 %>','<%= MipWebJSPUi.mipweb_user_importcontactusers_10 %>'); 
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_11 %>"+errorString);
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
											text:"<%= MipWebJSPUi.mipweb_user_importcontactusers_12 %>",
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_13 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	searchinfo = searchinfo_old;
	if(searchinfo ==""||seachtype==1){
		showuserlist();
	}else if(seachtype==2){
		searchuser();
	}
}

function deletebranch(branchid){
	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_importcontactusers_14 %>', function(btn){
					if(btn=='yes'){
								 BranchAction.deleteBranch(branchid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_15 %>");
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_16 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_17 %>"+errorString);
									}
								});			
							}
						}
						);
		}
	function modbranch(branchid){
		GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactusers_18 %>", "../user/modbranch.jsp?branchid="+branchid,550,878);	
	}
    function add_user(){
    	var nowgroupid ="";
    	if(now_node!=null&&now_node!=undefined){
    		nowgroupid = now_node.id;
    	}
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactusers_19 %>", "../user/adduser.jsp?branchid="+nowgroupid,550,878);	
    }
     function moduser(userid){
    	GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactusers_20 %>", "../user/moduser.jsp?userid="+userid,550,878);	
    }
    
    //add by mahm:用户转移部门或者复制到群组
    function transferuser(userid){
    var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactusers_21 %>", "../user/transferuser.jsp?userid="+userid+"&oldgroupid="+oldgroupid,550,878);	
    }
    
    
    function deluser(userid){
     var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    
    	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_importcontactusers_22 %>', function(btn){
					if(btn=='yes'){
								 User2.delUser(userid,0,oldgroupid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_23 %>");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_24 %>"+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_25 %>"+errorString);
									}
								});			
							}
						}
						);
    }
    
    
    
    function loadsearchuser(){
		pageid=1;
		seachtype=2;
		searchinfo_old = $("searchoption").value;
		ChangePage(pageid);
	}
	
	function searchuser(){
		 seachtype=2;
		 Progress('<%= MipWebJSPUi.mipweb_user_importcontactusers_26 %>','<%= MipWebJSPUi.mipweb_user_importcontactusers_27 %>'); 
		 User2.searchUserForSel($('searchtype').value,searchinfo_old,pageid,
				{
					callback:function(objXml) {
						//$('delmenu').style.display = "none";//干掉删除按扭吧.
						CloseProgress();
						 DisplayTransformedXML(1, objXml, "../user/xslt/user_list_selected_search.xsl",document.getElementById("userlist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_28 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_importcontactusers_29 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_30 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_31 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_32 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_33 %>"+errorString);
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
							 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_34 %>"+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_35 %>"+errorString);
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
			DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_36 %>");
			return;
		}
		
		//当前的群组ID
		var oldgroupid="";
	    if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}
		Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_importcontactusers_37 %>', function(btn){
			if(btn == 'yes')
			{
				Progress("<%= MipWebJSPUi.mipweb_user_importcontactusers_38 %>","<%= MipWebJSPUi.mipweb_user_importcontactusers_39 %>");
				User2.delUsers(values,0,oldgroupid,{
					callback:function(msg)
					{
						if(msg == "1")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_40 %>");
						}else if(msg == "0")
						{
							CloseProgress();
							DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_41 %>");
						}
						showuserlist();
					}
				});
			}
		});
    }
    
    
     //add by mahm:对查询出来后的用户进行删除
    function deluserfromgroups(userid){
  		  GB_showCenter("<%= MipWebJSPUi.mipweb_user_importcontactusers_42 %>", "../user/usergroups.jsp?userid="+userid,300,500);	
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
				DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_43 %>");
				return;
			}
			for(var i=0;i<values.length;i++){
				//alert(values[i].replace("'",""))
				var tmpvalue="";
			   if(values[i]!=null && values[i]!=undefined)
			   {
			    var selected_users=values[i].replace(/\'/g,"")
			    var tmpvalue = values[i].replace(/\'/g,"");
			    var oOptions =tmpvalue.split('$');
			    var oOption = document.createElement("OPTION");
			    var pos2 = $('possess2');
			    var b=false;
			    for(var j=0;j<pos2.length;j++){
			    	if(oOptions[0]==pos2[j].value)
			    		b=true;
			    }
			    if(b){
			    	continue;
			    }
				oOption.text = "<%= MipWebJSPUi.mipweb_user_importcontactusers_44 %>"+oOptions[1];
				oOption.value =oOptions[0];	
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
			 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_45 %>");
			 return;
			}
		   	 if(obj.length>0){
				   	 for(var i=0;i<obj.length;i++){
						   	 			 var mobile = obj[i].value;
						   	 			 var truename = obj[i].text;
								   	 	 //检验下有没有重复的
								   	 	 /*
								   	 	 var b=false;
								   	 	 	var tmpmobile=contactorphones;
								   	 	 	var array = tmpmobile.split(",");
								   	 	 for(var j=0;j<array.length;j++){
								   	 	 	if(array[j]==mobile){
								   	 	 		b=true;
								   	 	 		break;
								   	 	 	}
								   	 	 }
								   	 	 if(b){
								   	 	 	continue;
								   	 	 }
								   	 	 */
								   	 	 	strId += truename+"$||"+mobile+",";
								   	 	 }
						   	 	strId = strId.substring(0,strId.length-1);
				   	 }
				   	 /*
				   	 if(strId==""){
	 					DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_46 %>");
						 return;
						}
						*/
				   	 window.opener.adduserSfromIC(strId);
				   	 window.opener=null;
					 window.close();
	   	//window.location.href = "../im/mod_usersms.jsp?strId="+strId+"&shortmessageid="+id;
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
					DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusers_47 %>");
					for(var i=0; i < $('possess2').length; i++){
						$('possess2').remove(i);
						i--;
					}
					return;
				}
			}
		});
	}
	function goback(){
			 window.opener.adduserSfromIC(strId);
				   	 window.opener=null;
					 window.close();
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
										<span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_importcontactusers_48 %></span>
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
										style="margin:0px;padding:0px;valign:top;height:400px;overflow:hidden;"></div>
								</td>
								<td width="76%" valign="top" id="rightcontent">
									<div style="margin: 0px; padding: 0px; clear: both">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td colspan="5" class="title">
													<%= MipWebJSPUi.mipweb_user_importcontactusers_49 %>
												</td>
											</tr>
											<tr>

												<td colspan="5">
													<table width="100%">
														<tr>
															<td class="height25">
																<div class="submenu">
																	<%= MipWebJSPUi.mipweb_user_importcontactusers_50 %>
																	<select id="searchtype" onchange="clearSearch()">
																		<option value='0'>
																			<%= MipWebJSPUi.mipweb_user_importcontactusers_51 %>
																		</option>
																		<option value='1'>
																			<%= MipWebJSPUi.mipweb_user_importcontactusers_52 %>
																		</option>
																	</select>
																	<input type="text" id="searchoption" class="input_text"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" maxlength="20"/>
																	<input type="button" value="<%= MipWebJSPUi.mipweb_user_importcontactusers_53 %>" class="button_2"
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
																	value="<%= MipWebJSPUi.mipweb_user_importcontactusers_54 %>" onclick="add();"
																	style="width: 100px" />
															</td>
														</tr>
														<tr>
															<td>
																<input type="button" class="button_4"
																	value="<%= MipWebJSPUi.mipweb_user_importcontactusers_55 %>" onclick="delout()"
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
					<div style="text-align:center">
					<input type="button" value="<%= MipWebJSPUi.mipweb_user_importcontactusers_56 %>" onclick="subok()" />
					<input type="button" value="返回" onclick="goback();" />
					</div>
				</div>
			</div>
	</body>
</html>
