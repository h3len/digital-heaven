<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>业务系统接入用户</title>
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
		<script src="../dwr/interface/CatalogAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
	 var enterpriseid = '<%=session.getAttribute("enterpriseid") %>' ;
	 var appid = '<%=request.getParameter("appid")%>';
 	 var seachtype=0;//两种情况 1:按组查找 2：按条件搜索
 	 var root;
 	 var mytree;
 	 var pageid=1;
	 var now_node;	 
	var apppageid = '<%=request.getParameter("pageid")!=null?request.getParameter("pageid"):1%>';
	function allexit(){
		Ext.Msg.confirm(nowtitle, '您确定要退出？', function(btn){
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
		showuserlist() ;
		
	}
	function createTree(){
		
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"集团列表",
		      expanded:true
		  });
		 mytree=new Ext.tree.TreePanel({
		  el:"tree",
		  animate:true,
		  title:"集团公司",
		  collapsible:true,
		  enableDD:true,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		  autoHeight:false,
		  width:222,
		  autoWidth:false,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('正在获取集团列表..','角色用户管理');
	BranchAction.loadBranch(branchid,{
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
						text:olist[i].branchname,
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
										text:"群组",
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
				    DHalert("获取内部通讯录失败，失败原因："+errorString);
				}
	});
}
function showuserlist(){
	seachtype=1;
	$('searchoption').value ='';
	Progress('正在获取用户.......','用户管理'); 
	var now_branchid="";
	if(now_node!=null&&now_node!=undefined){
		now_branchid = now_node.id;
	}
	if(now_branchid==null||now_branchid==''){
		now_branchid = enterpriseid;
	}
	  User2.showBranchAppUserList(now_branchid,pageid,appid,
			{
				callback:function(objXml) {
					//alert(objXml.xml);
				//	$('delmenu').style.display = "";
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../branchmanager/xslt/app_user_list.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("获取用户失败，失败原因："+errorString);
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
					                 showuserlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"群组",
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
					    DHalert("获取内部通讯录失败，失败原因："+errorString);
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
function deletebranch(branchid){
	Ext.Msg.confirm(nowtitle, '您确定要删除该部门？', function(btn){
					if(btn=='yes'){
								 BranchAction.deleteBranch(branchid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("删除部门成功！");
										}else{
											CloseProgress();
											 DHalert("删除部门失败，失败原因："+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("删除部门失败，失败原因："+errorString);
									}
								});			
							}
						}
						);
		}
	function modbranch(branchid){
		GB_showCenter("修改部门信息", "../user/modbranch.jsp?branchid="+branchid,550,878);	
	}
    function add_user(){
    	var nowgroupid ="";
    	if(now_node!=null&&now_node!=undefined){
    		nowgroupid = now_node.id;
    	}
    	GB_showCenter("添加用户", "../user/adduser.jsp?branchid="+nowgroupid,550,878);	
    }
     function moduser(userid){
    	GB_showCenter("修改用户信息", "../user/moduser.jsp?userid="+userid,550,878);	
    }
    
    //add by mahm:用户转移部门或者复制到群组
    function transferuser(userid){
    var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    GB_showCenter("转移用户", "../user/transferuser.jsp?userid="+userid+"&oldgroupid="+oldgroupid,550,878);	
    }
    
    
    function deluser(userid){
     var oldgroupid="";
    if(now_node!=null&&now_node!=undefined){
		oldgroupid = now_node.id;
	}
    
    	Ext.Msg.confirm(nowtitle, '您确定要删除该用户？', function(btn){
					if(btn=='yes'){
								 User2.delUser(userid,0,oldgroupid,
								{
									callback:function(objXml) {
										if(objXml=="1"){
											CloseProgress();
											 DHalert("删除该用户成功！");
											 ChangePage(pageid);
										}else{
											CloseProgress();
											 DHalert("删除该用户失败，失败原因："+objXml);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("删除该用户失败，失败原因："+errorString);
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
		 Progress('正在查询用户.......','登录中'); 
		 User2.searchSysRoleUser($('searchtype').value,$('searchoption').value,appid,pageid,
				{
					callback:function(objXml) {
						CloseProgress();
						 DisplayTransformedXML(1, objXml, "../branchmanager/xslt/app_user_list.xsl",document.getElementById("userlist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("获取"+now_branchtext+"中的用户失败，失败原因："+errorString);
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
							 DHalert("上移用户失败，失败原因："+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("上移用户失败，失败原因："+errorString);
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
							 DHalert("下移用户失败，失败原因："+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("下移用户失败，失败原因："+errorString);
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
							 DHalert("上移用户失败，失败原因："+objXml);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("上移用户失败，失败原因："+errorString);
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
			DHalert("请选择要删除的用户!");
			return;
		}
		
		//当前的群组ID
		var oldgroupid="";
	    if(now_node!=null&&now_node!=undefined){
			oldgroupid = now_node.id;
		}
		Ext.Msg.confirm(nowtitle, '您确定要删除选择的用户？', function(btn){
			if(btn == 'yes')
			{
				Progress("正在处理请求,请稍后...","请稍后");
				User2.delUsers(values,0,oldgroupid,{
					callback:function(msg)
					{
						if(msg == "1")
						{
							CloseProgress();
							DHalert("操作已成功!");
						}else if(msg == "0")
						{
							CloseProgress();
							DHalert("批量删除失败!");
						}
						showuserlist();
					}
				});
			}
		});
    }
    
    
     //add by mahm:对查询出来后的用户进行删除
    function deluserfromgroups(userid){
  		  GB_showCenter("从群组中删除用户信息", "../user/usergroups.jsp?userid="+userid,300,500);	
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
				DHalert("请选择要添加的用户!");
				return;
			}
			for(var i=0;i<values.length;i++){
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
			    	if(oOptions[0]==pos2[j].value){
			    		b=true;
			    		DHalert(oOptions[1]+"已经添加到列表中!");
			    	}
			    }
			    if(b){
			    	continue;
			    }
				oOption.text = "[用户]"+oOptions[1];
				oOption.value =oOptions[0];	
				oOption.ondblclick= function(){
					delout();
				 }
				 document.all?$('possess2').add(oOption):$('possess2').appendChild(oOption);
			   }
			}
		}
		function delout(){
			var count=0;
			for(var j=0;j<$('possess2').length;j++){
			   if($('possess2')[j].selected==true){
			     count=count+1;
			   }
			}
			if(count==0){
			   	DHalert("请选择要删除的用户!");
			}
		  for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].selected==true){
						$('possess2').remove(i);
						i--;
				}
			}
		}
		function SelCatalogAndUser(){
	    	var obj= document.getElementById('possess2');
			var strId = "";
		   	 if(obj.length>0){
					for (var i = 0; i < obj.length; i++)
						{
							strId += obj[i].value+",";
						}
						if(strId.length > 0)
						{
							strId = strId.substring(0,strId.length-1);
						}
						   	 	
		     }
			return strId;	 
		   	 
	}
	function adduser(){
				var strId = SelCatalogAndUser();
				if(strId==''||strId==null){
					window.opener.getAppUserList();
					window.opener=null;
					window.close();
					return;
				}
				Progress('正在添加用户....','业务系统接入用户');
				EnterpriseAction.addAppUsers(strId,appid,enterpriseid,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											window.opener.getAppUserList();
											 window.opener=null;
											 window.close();
										}else{
											DHalert("添加用户失败，失败原因："+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("添加用户失败，失败原因："+errorString);
									}
				})
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
										<span class="gray_14_bold">用户管理</span>
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
										style="margin:0px;padding:0px;valign:top;height:466px;overflow:hidden;"></div>
								</td>
								<td width="76%" valign="top">
									<div style="margin: 0px; padding: 0px; clear: both">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td colspan="5" class="title">
													用户列表
												</td>
											</tr>
											<tr>

												<td colspan="5">
													<table width="100%">
														<tr>
															<td class="height25">
																<div class="submenu">
																	查询类型：
																	<select id="searchtype" onchange="clearSearch()">
																		<option value='0'>
																			按用户姓名
																		</option>
																		<option value='1'>
																			按用户手机号
																		</option>
																	</select>
																	<input type="text" id="searchoption" class="input_text"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" maxlength="20"/>
																	<input type="button" value="查询" class="button_2"
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
																	value="添加 &gt;&gt;" onclick="add();"
																	style="width: 100px" />
															</td>
														</tr>
														<tr>
															<td>
																<input type="button" class="button_4"
																	value="删除 &lt;&lt;" onclick="delout()"
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
					<div style="text-align:center"><input type="button" value="确定" onclick="adduser()" /></div>
				</div>
			</div>
	</body>
</html>
