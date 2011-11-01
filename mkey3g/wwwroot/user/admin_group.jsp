<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%= MipWebMoreUi.mip_user_admin_group_select_user_11 %></title>
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
 	// var now_branchtext ="";	
//得到企业id
 var enterpriseid = "<%=request.getParameter("enterpriseid")!=null?request.getParameter("enterpriseid"):request.getSession().getAttribute("enterpriseid")%>";
  
	window.onload=function(){
		//createTree();
		getRootBranch();
		loadBranch("");	

	    w1= document.body.clientWidth*0.77*0.24;
	    w2=document.body.clientWidth*(1-0.77*0.24);		
		//now_branchid = "";
	//	showbranchlist();
	}
	function showmenu(){
		document.getElementById("center_left").style.display='block';
		document.getElementById("center_left").className = "center_left";
		document.getElementById("center_right").style.width = "77%";
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
	//这个方法是取根部门的
	function getRootBranch(){
		Ext.QuickTips.init();
				  root=new Ext.tree.TreeNode({
				  		
				      id:"-1",
				      text:"<%= MipWebMoreUi.mip_user_admin_group_select_user_12 %>",
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
					  title:" ",
					  collapsible:true,
					  enableDD:false,
					  enableDrag:true,
					  rootVisible:true,
					  autoScroll:true,
					  width:222,
					  autoWidth:false
				  
				});
				mytree.setRootNode(root);//设置根节点
			 	mytree.render();//不要忘记render()下,不然不显示哦
	}
	function createTree(){
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"-1",
		      text:" ",
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
		  title:" ",
		  collapsible:true,
		  enableDD:false,
		  enableDrag:true,
		  rootVisible:true,
		  autoScroll:true,
		  containerScroll:true,
		  width:222,
		  autoWidth:false
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(enterpriseid){
	Progress('<%= MipWebMoreUi.mip_user_admin_group_select_user_13 %>','<%= MipWebMoreUi.mip_user_admin_group_select_user_14 %>');
	User2.getGroupList(enterpriseid,{
			callback:function(olist) {
					CloseProgress();
					if(enterpriseid==""&&olist.length>0){
						now_branchid = olist[0].id;
						now_branchtext =olist[0].id;
						showbranchlist();
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
								
							},//监听单击
							"click":function(node){ 
							myExpand(node);
								pageid =1;
								now_node=node;
				      			showbranchlist(); 
				            },
								//监听右键
							"contextmenu":function(node,e){
								//列出右键菜单
							var	menu=new Ext.menu.Menu([
								{
										text:"<%= MipWebMoreUi.mip_user_admin_group_select_user_15 %>",
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
					    root.appendChild(sub1);
					    myExpand(sub1);
					}
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_16 %>"+errorString);
				}
	});
}
function showbranchlist(){
	$('creategroup').style.display="";
	$('deletebranchgroup').style.display="";
	var now_branchid = "";
	if(now_node==null||now_node==undefined){
		now_branchid ="-1";
	}else{
		now_branchid= now_node.id;
	}
	Progress('<%= MipWebMoreUi.mip_user_admin_group_select_user_17 %>','<%= MipWebMoreUi.mip_user_admin_group_select_user_18 %>');
	  BranchAction.showGroupList(now_branchid,pageid,
			{
				callback:function(objXml) {
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../user/xslt/grouplist.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_19 %>"+errorString);
				}
			});
}

function myExpand(node){
	
	if(node.item(0)==undefined){
			User2.getGroupList(node.id,{
				callback:function(olist) {
						CloseProgress();
						for(var i=0;i<olist.length;i++){
							var groupname =olist[i].groupname;
							if(olist[i].groupname.indexOf('<')>=0||olist[i].groupname.indexOf('>')>=0){
								//alert(olist[i].groupname)
								groupname =  groupname.replace('<','&lt;')
								groupname =  groupname.replace('>','&gt;')
								//alert(groupname)
							}
							var childnode = new Ext.tree.TreeNode({
							id:olist[i].id,
							text:groupname,
							hrefTarget:"mainFrame",
							listeners:{//监听
					          
								//监听双击事件
								"dblclick":function(node){
									now_node=node;
									//alert(node.id)
									myExpand(node);
								},//监听单击事件
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
											text:"<%= MipWebMoreUi.mip_user_admin_group_select_user_20 %>",
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
					    DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_21 %>"+errorString);
					}
		});
		
	}
}
function ChangePage(pid){
	pageid = pid;
	showbranchlist();
}
function showbranch(branchid){
	GB_showCenter("<%= MipWebMoreUi.mip_user_admin_group_select_user_22 %>", "../user/admin_showgroup.jsp?branchid="+branchid,550,878);
}

//删除一个群组
		function delbranch(branchid){
			
			Ext.Msg.confirm(nowtitle, '<%= MipWebMoreUi.mip_user_admin_group_select_user_23 %>', function(btn){
									if(btn=='yes'){
										BranchAction.delGroup(branchid,
											function(data){	
												if(data=='1'){
													$('tree').innerHTML="";
													getRootBranch();
													loadBranch("");
													showbranchlist();
												}else{
													DHalert(data);
												}		 
												
												
											}
										);
									}
									return;
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
    
    
//批量删除群组
		function delbranchGroup(branchid){
			var chks = document.getElementsByName('idmark');
			var values = new Array();
			var j = 0 ;
			for(i = 0;i < chks.length ;i++)
			{
				if(chks[i].checked == true)
				{
					values[j] = chks[i].value;
					j = j+1 ;
				}
			}
			
			if(values.length < 1)
			{
				DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_24 %>");
				return;
			}
			Ext.Msg.confirm(nowtitle, '<%= MipWebMoreUi.mip_user_admin_group_select_user_25 %>', function(btn){
									if(btn=='yes'){
										BranchAction.delBranchGroup(values,
											function(data){	
												if(data=='1'){
													$('tree').innerHTML="";
													getRootBranch();
													loadBranch("");
													showbranchlist();
												}else{
													DHalert("操作失败，失败原因:"+data);
												}		 
												
												
											}
										);
									}
				});
		}
		
		//创建一个群组信息
		function createbranch(){
		//update by mahm
		if(now_node==null||now_node==""){
		GB_showCenter("", "../user/create_group.jsp?parentid=",460,460);
		}else if(now_node.id=='-1'){
			DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_26 %>");
			return false;
		}else{
		GB_showCenter("", "../user/create_group.jsp?parentid="+now_node.id,460,460);
		}
			
		}
			//关闭子页面
	function closePage(){
		CloseProgress();
		$('tree').innerHTML="";
		getRootBranch();
		loadBranch("");
		showbranchlist();
		GB_CURRENT.hide();
	}
	
		//修改一个群组信息
		function modbranch(bid){
			GB_showCenter("", "../user/mod_group.jsp?bid="+bid,460,460);
		}

//群组上移
function groupSortUp(groupId){
	var parentGroupId ;
	if(now_node==null||now_node.id==null||now_node.id==""||now_node.id==-1){
		parentGroupId = enterpriseid ;
	}else{
		parentGroupId = now_node.id ;
	}
	User2.groupSortUp(groupId,parentGroupId,
		{
			callback:function(data) {
					if(data=='1'){
						$('tree').innerHTML="";
						getRootBranch();
						loadBranch("");
						showbranchlist();
					}else{
						DHalert(data);
					}		 
			 },
			errorHandler:function(errorString, exception) {
			    DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_27 %>"+errorString);
			}
		});
}

//群组下移
function groupSortDown(groupId){
	var parentGroupId ;
	if(now_node==null||now_node.id==null||now_node.id==""||now_node.id==-1){
		parentGroupId = enterpriseid ;
	}else{
		parentGroupId = now_node.id ;
	}
	User2.groupSortDown(groupId,parentGroupId,
		{
			callback:function(data) {
					if(data=='1'){
						$('tree').innerHTML="";
						getRootBranch();
						loadBranch("");
						showbranchlist();
					}else{
						DHalert(data);
					}		 
			 },
			errorHandler:function(errorString, exception) {
			    DHalert("<%= MipWebMoreUi.mip_user_admin_group_select_user_28 %>"+errorString);
			}
		});
}
</script>
</head>
<body>
<!--Top Include-->
<jsp:include page="../user/top.jsp" flush="true"/>

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
	<div id="center_nav"><%= MipWebMoreUi.mip_user_admin_group_select_user_29 %></div>
</div>	

<table width="100%" height="27" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:11px;">
  <tr>
    <td background="../theme/images/list_top_bg.jpg"><div class="list_top_left"><span class="gray_14_bold"><%= MipWebMoreUi.mip_user_admin_group_select_user_30 %></span></div>
    <div class="list_top_right"><a href="#" class="white_12"></a></div></td>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #CAD7DF;">
  <tr>
    <td id="treecontent" width="24%" valign="top"><div id="tree" style="margin:0px;padding:0px;width:100%;overflow:hidden;height:400px;"></div></td>
    <td id="rightcontent" width="76%" valign="top"><div style="margin:0px;padding:0px;clear:both"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	</tr>
  <tr>
    <td  class="title"><%= MipWebMoreUi.mip_user_admin_group_select_user_31 %></td>
  </tr>
  <tr>
    <td>
    	<input type="button" class="button_2" value="<%= MipWebMoreUi.mip_user_admin_group_select_user_32 %>" id="creategroup" style="display:none" onclick="javascript:createbranch();"/>
    	<input type="button" class="button_2" value="<%= MipWebMoreUi.mip_user_admin_group_select_user_33 %>" id="deletebranchgroup" style="display:none" onclick="javascript:delbranchGroup();"/>
    </td>
  </tr>
  <tr>
    <td colspan="5">
				<table width="100%">
		 			<tr>
						<td>
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
<jsp:include page="bottom.jsp" flush="true"/>
<!--Bottom Include-->



</body>
</html>
