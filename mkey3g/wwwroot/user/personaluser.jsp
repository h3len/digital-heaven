<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=MipWebJSPUi.mipweb_user_personaluser_1%></title>
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
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
 	 var root;
 	 var mytree;
 	 var pageid=1;
 	 var grouppageid=1;
 	 var now_branchid ="";
 	 var now_branchtext ="";
 	 var showtype = 0;//控制分页类型 1：分组 2：高级搜索
 	 var contactnum=0;
 	 var searchtype = "" ;
 	 var searchoption = "" ;
 	 var w1;
 	 var w2;
 	 //得到用户ID
 	 var userId = "<%=request.getParameter("user") != null ? request
							.getParameter("user")
							: request.getSession().getAttribute("user")%>";
 	 	window.onload=function(){
		document.getElementById("delmenu").style.display="" ;
		$('center_right').style.display="";
		DHTabPanel(ab,900,0,"tabs");
		createTree();
		showuserlist(); 
	    w1= document.body.clientWidth*0.77*0.24;
	    w2=document.body.clientWidth*(1-0.77*0.24);	
	    		
	}	
	
  
	
	function allexit(){
		Ext.Msg.confirm(nowtitle, '<%=MipWebJSPUi.mipweb_user_personaluser_3%>', function(btn){
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


	var tabPane;
    var ab=[[showtreeandusers,'<%=MipWebJSPUi.mipweb_user_personaluser_4%>'],[groupmanager,'<%=MipWebJSPUi.mipweb_user_personaluser_5%>'],[selfsetting,'<%=MipWebJSPUi.mipweb_user_personaluser_6%>']];
	function groupmanager(){
	$('personnaluser').style.display="none";
	$('groupmanage').style.display="";
	$('userdefined').style.display="none";
	getpersonalgrouplist();
	//window.location.href="../user/personalgroup.jsp"
	}
	function selfsetting(){
	$('personnaluser').style.display="none";
	$('groupmanage').style.display="none";
	$('userdefined').style.display="";
	self_getting();
	//window.location.href="../user/personal_sel_setting.jsp"
	}
	/**************************************
	     通讯录导入导出相关方法
	***************************************/
	//导入用户
	function impuser(){
	$('impview').style.display="";
	$('expview').style.display="none";
	$('userlist').style.display="none";
	$("showserch").style.display = "none";
	}
	//导出用户
	function expuser(){
	$('expview').style.display="";
	$('impview').style.display="none";
	$('userlist').style.display="none";
	$("showserch").style.display = "none";
	}
	
	   //根据类型导出用户
       	function exportdoc(){
       		if(document.getElementById("expexcel").checked==true){
       			window.location.href="../personal.do?action=exportExcel&type=excel";
       		}else if(document.getElementById("exptxt").checked==true){
       			window.location.href="../personal.do?action=exportExcel&type=csv";
       		}
       	}
       		
	  //导入文件
	  function upload(){
	  
	  document.getElementById("showserch").style.display = "none";
	       	if(document.getElementById("impexcel").checked==true){
		       		document.getElementById('ftype').value="excel";
	       		}
	       		if(document.getElementById("imptxt").checked==true){
		       		document.getElementById('ftype').value="txt";
	       		}
				var file=document.getElementById('file').value;
				if($('file').value == ''){
					DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_7%>");
					return ;
				}
				var file_type=file.substring(file.lastIndexOf(".")+1);
				if(document.getElementById("impexcel").checked==true){
					if(file_type.toLowerCase()!="xls"&&file_type.toLowerCase()!="xlsx"){
						DHalert('<%=MipWebJSPUi.mipweb_user_personaluser_8%>');
						return;
					}	
				}
				if(document.getElementById("imptxt").checked==true){
					if(file_type!="txt"){
						DHalert('<%=MipWebJSPUi.mipweb_user_personaluser_9%>');
						return;
					}	
				}
			//	alert(111);
			//	window.location.href="<%=request.getContextPath()%>/user/userimport.do";
			document.getElementById('form2').submit();
	}
	
	
	function createTree(){
		Ext.QuickTips.init();	
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%=MipWebJSPUi.mipweb_user_personaluser_10%>",
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
		
		var sub1=new Ext.tree.TreeNode({
		id:"-1",
		text:"<%=MipWebJSPUi.mipweb_user_personaluser_11%>",
		singleClickExpand:true,
		listeners:{
			//监听双击事件
			"dblclick":function(node){
				myExpand(node);
			},//监听单击
			"click":function(node){ 
				showtype = 1 ;
				pageid =1;
				now_branchid = "";
				now_branchtext = "";
                showuserlist(); 
            },
				//监听右键
			"contextmenu":function(node,e){
				//列出右键菜单
				/*
			var	menu=new Ext.menu.Menu([
				{
						text:"查看该部门详情",
						icon:"../theme/images/list.gif",
						handler:function(){
							showbranch(node.id);
						}
				},
				{
						text:"打开改部门当前节点",
						icon:"../theme/images/list.gif",
						handler:function(){
							myExpand(node);
						}
				}]);
				//显示在当前位置
				menu.showAt(e.getPoint());
				*/
			}
		}
	  });
	    root.appendChild(sub1);
	    myExpand(sub1);
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}

//获得树和联系人，update by mahm
function showtreeandusers(){
if(contactnum==0){
contactnum=1;
showuserlist();
}else{
window.location.reload();
}
}

function showuserlist(){
	if(showtype == 1){
		document.getElementById("delmenu").style.display="" ;
	}else{
		document.getElementById("delmenu").style.display="none" ;
	}
	$('personnaluser').style.display="";
	$('groupmanage').style.display="none";
	$('userdefined').style.display="none";
	$('searchoption').value ='';
   $('impview').style.display="none";
	$('expview').style.display="none";
	$('userlist').style.display="";
	$("showserch").style.display = "";
	showtype = 1;
	Progress('<%=MipWebJSPUi.mipweb_user_personaluser_16%>','<%=MipWebJSPUi.mipweb_user_personaluser_17%>'); 
	  User2.showPersonalUserList(now_branchid,pageid,
			{
				callback:function(objXml) {
					CloseProgress();
					DisplayTransformedXML(1, objXml, "../user/xslt/puserlist.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_18%>"+now_branchtext+"<%=MipWebJSPUi.mipweb_user_personaluser_19%>"+errorString);
				}
			});
			
			
}
//下面是批量删除
//全选的方法
	
	function checkall()
	{
		var cks = document.getElementsByName('mark');
		for(i = 0;i<cks.length;i++)
		{
			cks[i].checked = true;
		}
	}
	
	//反选的方法
	function inverse()
	{
		var cks = document.getElementsByName('mark');
		for(i = 0;i<cks.length;i++)
		{
			if(cks[i].checked)
			{
				cks[i].checked = false;
			}else
			{
				cks[i].checked = true;
			}
		}
	}
	function delUsers()
	{
		var cks = document.getElementsByName('mark');
		var nowgroupid = "" ;
		var values = new Array();
		for(i = 0;i<cks.length;i++)
		{
			if(cks[i].checked)
			{
				values.push(cks[i].value);
			}
		}
		if(values.length < 1)
		{
			DHalert('<%=MipWebJSPUi.mipweb_user_personaluser_20%>');
			return;
		}
		
		if(now_branchid!=""&&now_branchid!=null){
 			nowgroupid = now_branchid ;
 		}

		Ext.Msg.confirm(nowtitle, '<input type="radio" name="alldel" id="deluser" /><%=MipWebJSPUi.mipweb_user_personaluser_21%><input type="radio" name="alldel" id="exituser" /><%=MipWebJSPUi.mipweb_user_personaluser_22%>',function(btn)
		{
			if(btn=='yes'){
							var deltype="" ;
							if(document.getElementById('deluser').checked){
								deltype="0" ;
							}
							if(document.getElementById('exituser').checked){
								deltype="1" ;
							}			
							if(deltype==null||deltype==""){
								DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_23%>");
								return false ;
							}
							Progress('<%=MipWebJSPUi.mipweb_user_personaluser_24%>','<%=MipWebJSPUi.mipweb_user_personaluser_25%>');
							 User2.delSomeUsers(values,deltype,nowgroupid,
							{
								callback:function(msg) {
										CloseProgress();
										DHalert(msg);
										ChangePage(pageid);
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_26%>"+errorString);
								}
							});					
			}
		});
	}
function myExpand(node){
	if(node.item(0)==undefined){
			if(node.id=="-1"){
				User2.loadGroup("",{
				callback:function(olist) {
						CloseProgress();
						for(var i=0;i<olist.length;i++){
							var gname = olist[i].groupname;
							gname=gname.replace('<','&lt;');
							gname=gname.replace('>','&gt;');
							var childnode = new Ext.tree.TreeNode({
							id:olist[i].id,
							text:gname,
							hrefTarget:"mainFrame",
							listeners:{//监听
					          
								//监听双击事件
								"dblclick":function(node){
									myExpand(node);
								},//监听单击事件
								"click":function(node){ 
									showtype = 1 ;
									pageid =1;
									now_branchid = node.id;
									now_branchtext = node.text;
					                 showuserlist(node);
					            },
									//监听右键
								"contextmenu":function(node,e){
									//列出右键菜单
								var	menu=new Ext.menu.Menu([
									{
											text:"<%=MipWebJSPUi.mipweb_user_personaluser_27%>",
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
					    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_28%>"+errorString);
					}
		});
			}else{
			}
			
		
	}
}

//联系人信息分页
function ChangePage(pid){
	pageid = pid;
	if(showtype == 1){
		showuserlist();
		}else if(showtype == 2){
		searchuser();
		}
}
function showbranch(branchid){
	//GB_showCenter("部门详情", "../user/showbranch.jsp?branchid="+branchid,550,878);
	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_29%>", "../user/showgroup.jsp?groupid="+branchid,550,878);
}

function showuser(userid){
	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_30%>", "../user/showpersonaluser.jsp?userid="+userid,550,878);
}
function modgroup(groupid){
	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_31%>", "../user/modbranch.jsp?branchid="+branchid,550,878);	
}
 function add_user(){
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_32%>", "../user/addpersonaluser.jsp?groupid="+now_branchid,550,878);	
 }
 function moduser(userid){
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_33%>", "../user/modpersonaluser.jsp?userid="+userid,550,878);
 }
 function trauser(userid){
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_34%>", "../user/trapersonaluser.jsp?userid="+userid,550,878);
 }
 function adduser(userid){
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_35%>", "../user/insertpersonaluser.jsp?userid="+userid,550,878);
 }
 function fromcontant(){
 	//GB_showCenter("从内部通讯录导入", "../user/admin_personal_select_user.jsp?groupid="+now_branchid,550,878);
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_36%>", "../user/importcontactsysuser.jsp?groupid="+now_branchid,550,878);
 }

 function deluser(userid){
 	var nowgroupid = "" ;
 	if(now_branchid!=""&&now_branchid!=null){
 		nowgroupid = now_branchid ;
 	}
 	 Ext.Msg.confirm(nowtitle, '<input type="radio" name="alldel" id="deluser" /><%=MipWebJSPUi.mipweb_user_personaluser_37%><input type="radio" name="alldel" id="exituser" /><%=MipWebJSPUi.mipweb_user_personaluser_38%>', function(btn){
					if(btn=='yes'){
							var deltype="" ;
							if(document.getElementById('deluser').checked){
								deltype="0" ;
							}
							if(document.getElementById('exituser').checked){
								deltype="1" ;
							}			
							if(deltype==null||deltype==""){
								DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_39%>");
								return false ;
							}
							 User2.delPersonalUser(userid,deltype,nowgroupid,
							{
								callback:function(otext) {
									if(otext=='1'){
										DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_40%>");
										ChangePage(pageid);
									}else{
										DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_41%>"+otext);
									}
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_42%>"+errorString);
								}
							});					
							}
						}
						);
 		
 }
 
  	function forexample(type){
    		if(type=="excel"){
       			window.location.href="../personal.do?action=forexample&type=excel";
       		}else if(type=="csv"){
       			window.location.href="../personal.do?action=forexample&type=csv";
       		}
    	}
 function loadsearchuser(){
	searchtype = $('searchtype').value ;
 	searchoption = $('searchoption').value ;
	pageid=1;
	searchuser();
}

function searchuser(){
	 
	 Progress('<%=MipWebJSPUi.mipweb_user_personaluser_43%>','<%=MipWebJSPUi.mipweb_user_personaluser_44%>'); 
	 showtype = 2;
	 User2.searchPersonalUser(searchtype,searchoption,pageid,
			{
				callback:function(objXml) {
					$('delmenu').style.display = "none";//干掉删除按扭吧.
					CloseProgress();
					 DisplayTransformedXML(1, objXml, "../user/xslt/searchpuserlist.xsl",document.getElementById("userlist"));
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_45%>"+now_branchtext+"<%=MipWebJSPUi.mipweb_user_personaluser_46%>"+errorString);
				}
			});
}

//设置自定义字段
	function self_setting(){
		//可以保存为空吧，不可以么？
		 Progress('<%=MipWebJSPUi.mipweb_user_personaluser_47%>','<%=MipWebJSPUi.mipweb_user_personaluser_48%>');
		 if($('c1').value != ""){
		 if($('c1').value.replace(/\s/g,"")==""){
		 		DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_49%>");
				return false;
		 }
		 }
		 if($('c2').value != ""){
		  if($('c2').value.replace(/\s/g,"")==""){
		 		DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_50%>");
				return false;
		 }
		 }
		 if($('c3').value != ""){
		  if($('c3').value.replace(/\s/g,"")==""){
		 		DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_51%>");
				return false;
		 }
		 }
		 if($('c4').value != ""){
		  if($('c4').value.replace(/\s/g,"")==""){
		 		DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_52%>");
				return false;
		 }
		 }
		 if($('c5').value != ""){
		  if($('c5').value.replace(/\s/g,"")==""){
		 		DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_53%>");
				return false;
		 }
		 }
		 
		 cf = new CheckForm();
		 for(var i=1;i<=5;i++){
		 	for(var j=i+1;j<=5;j++){
		 	if(cf.Trim($('c'+i).value) != "" && cf.Trim($('c'+j).value) !=""){
			 	if(cf.Trim($('c'+i).value) == cf.Trim($('c'+j).value)){
				 	DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_54%>");
					return false;
			 	}
			 }
		 	}
		 }
		 if(checkSetting($('c1').value)){
		 	DHalert($('c1').value+"<%=MipWebJSPUi.mipweb_user_personaluser_55%>");
		 	return false ;
		 }
		  if(checkSetting($('c2').value)){
		 	DHalert($('c2').value+"<%=MipWebJSPUi.mipweb_user_personaluser_55%>");
		 	return false ;
		 }
		  if(checkSetting($('c3').value)){
		 	DHalert($('c3').value+"<%=MipWebJSPUi.mipweb_user_personaluser_55%>");
		 	return false ;
		 }
		  if(checkSetting($('c4').value)){
		 	DHalert($('c4').value+"<%=MipWebJSPUi.mipweb_user_personaluser_55%>");
		 	return false ;
		 }
		 if(checkSetting($('c5').value)){
		 	DHalert($('c5').value+"<%=MipWebJSPUi.mipweb_user_personaluser_55%>");
		 	return false ;
		 }		
		
		User2.setPsersonalSelf($('c1').value,$('c2').value,$('c3').value,$('c4').value,$('c5').value,{
			callback:function(objXml) {
				if(objXml=="1"){
					CloseProgress();
					DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_56%>");
				}else{
					CloseProgress();
					DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_57%>"+objXml);
				}
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_58%>"+errorString);
			}
		});
	
	}
	function checkSetting(stt){
		if(stt=='<%=MipWebJSPUi.mipweb_user_personaluser_59%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_60%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_61%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_62%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_63%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_64%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_65%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_66%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_67%>'||stt=='<%=MipWebJSPUi.mipweb_user_personaluser_68%>'){
			return true;
		}
		return false;
	}
	
	function self_getting(){
		Progress('<%=MipWebJSPUi.mipweb_user_personaluser_69%>','<%=MipWebJSPUi.mipweb_user_personaluser_70%>');
		User2.getPersonalSelf({
			callback:function(omap) {
				CloseProgress();
				dwr.util.setEscapeHtml(false);
				dwr.util.setValues(omap);
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_71%>"+errorString);
			}
		});
	}

//分组管理
	function ChangegroupPage(pid){
		grouppageid = pid;
		getpersonalgrouplist();
	}
	function getpersonalgrouplist(){
		User2.getpersonalgrouplist(grouppageid,{
			callback:function(objXml) {
				DisplayTransformedXML(1, objXml, "../user/xslt/pergrouplist.xsl",document.getElementById("grouplist"));
			},
			errorHandler:function(errorString, exception) {
				CloseProgress();
			    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_72%>"+errorString);
			}
		});
	}
	function showgroup(groupid){
		GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_73%>", "../user/showgroup.jsp?groupid="+groupid,550,878);
	}
	function modgroup(groupid){
		GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_74%>", "../user/modgroup.jsp?groupid="+groupid,550,878);
	}
	function delgroup(gourpid){
 	
 		Ext.Msg.confirm(nowtitle, '<%=MipWebJSPUi.mipweb_user_personaluser_75%>', function(btn){
					if(btn=='yes'){
							User2.delPersonalGroup(gourpid,
							{
								callback:function(otext){
									if(otext=='1'){
										DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_76%>");
										ChangegroupPage(pageid);
									}else{
										DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_77%>"+otext);
									}
								},
								errorHandler:function(errorString, exception) {
									CloseProgress();
								    DHalert("<%=MipWebJSPUi.mipweb_user_personaluser_78%>"+errorString);
								}
							});					
							}
						}
						);
 			
 
 }
  function add_group(){
 	GB_showCenter("<%=MipWebJSPUi.mipweb_user_personaluser_79%>", "../user/addgroup.jsp",550,878);	
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
function showmenu(){
		document.getElementById("center_left").style.display='block';
		document.getElementById("center_left").className = "center_left";
		document.getElementById("center_right").style.width = "77%";
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
					<table style="display: none" width="100%" height="29" border="0"
						cellpadding="0" cellspacing="0"
						background="/theme/images/alert_bg.gif">
						<tr>
							<td width="1%">
								<img src="/theme/images/alert_left.gif" width="5" height="29" />
							</td>
							<td width="2%">
								<img src="/theme/images/alert_bug.gif" />
							</td>
							<td width="90%">
								<a href="../minioa/admin_default.jsp"><%=MipWebJSPUi.mipweb_user_personaluser_80%><span
									class="red" id="oatodo">0</span><%=MipWebJSPUi.mipweb_user_personaluser_81%></a>
							</td>
							<td width="2%">
								<a href="#" onclick="getToDoNum()"><img
										src="/theme/images/alert_right.gif" width="24" height="29"
										border="0" />
								</a>
							</td>
						</tr>
					</table>
					<!-- 中部主要内容开始 -->
					<!-- center_nav 路径导航 -->
					<div id="center_nav_box">
						<div id="center_nav">
							<%=MipWebJSPUi.mipweb_user_personaluser_82%>
						</div>
					</div>
					<div id="tabs"></div>
					<%--联系人管理--%>
					<div id="personnaluser" style="display: none">
						<table width="99%" height="27" border="0" align="center"
							cellpadding="0" cellspacing="0" style="margin-top: 11px;">
							<tr>
								<td background="../theme/images/list_top_bg.jpg">
									<div class="list_top_left">
										<span class="gray_14_bold"><%=MipWebJSPUi.mipweb_user_personaluser_83%></span>
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
								<td id="treecontent" width="24%" valign="top">
									<div id="tree"
										style="margin: 0px; padding: 0px; width: 100%; valign: top; height: 400px"></div>
								</td>
								<td id="rightcontent" width="76%" valign="top">
									<div style="margin: 0px; padding: 0px; clear: both">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td colspan="6" class="title">
													<%=MipWebJSPUi.mipweb_user_personaluser_84%>
												</td>
											</tr>
											<tr>
												<td colspan="6">
													<table width="100%">
														<tr>
															<td colspan="6">


																<input type="button"
																	value="<%=MipWebJSPUi.mipweb_user_personaluser_85%>"
																	onclick="add_user()" class="button_4" />
																<input type="button"
																	value="<%=MipWebJSPUi.mipweb_user_personaluser_86%>"
																	onclick="fromcontant()" class="button_8" />
																<input type="button"
																	value="<%=MipWebJSPUi.mipweb_user_personaluser_87%>"
																	onclick="impuser()" class="button_4" />
																<input type="button"
																	value="<%=MipWebJSPUi.mipweb_user_personaluser_88%>"
																	onclick="expuser()" class="button_4" />
																<input type="button" class="button_2"
																	onclick="javascript:delUsers();" id="delmenu"
																	value="<%=MipWebJSPUi.mipweb_user_personaluser_89%>" />

															</td>

														</tr>
														<tr>
															<td colspan="6">
																<div id="showserch">
																	<%=MipWebJSPUi.mipweb_user_personaluser_90%>
																	<select id="searchtype">
																		<option value='0'>
																			<%=MipWebJSPUi.mipweb_user_personaluser_91%>
																		</option>
																		<option value='1'>
																			<%=MipWebJSPUi.mipweb_user_personaluser_92%>
																		</option>
																	</select>
																	<input type="text" id="searchoption"
																		class="input_text input_120px"
																		onmouseover="fEvent('mouseover',this)"
																		onfocus="fEvent('focus',this)"
																		onblur="fEvent('blur',this)"
																		onmouseout="fEvent('mouseout',this)" />
																	<input type="button"
																		value="<%=MipWebJSPUi.mipweb_user_personaluser_93%>"
																		class="button_2" onclick="loadsearchuser()" />
																</div>
															</td>
														</tr>
														<tr>
															<td colspan="6">
																<div id="userlist"></div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
									<table id="expview" style="display: none" width="100%"
										border="0" align="center" cellpadding="0" cellspacing="5">
										<tr>
											<td width="3%">
												<img src="../skin/default/images/text_icon.gif" />
											</td>
											<td width="26%">
												<%=MipWebJSPUi.mipweb_user_personaluser_94%>
											</td>
											<td width="71%">
												<input type="radio" id="expexcel" name="exptype"
													checked="true" />
												<%=MipWebJSPUi.mipweb_user_personaluser_95%>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" id="exptxt" name="exptype" />
												<%=MipWebJSPUi.mipweb_user_personaluser_96%>

											</td>

										</tr>
										<tr>
											<td colspan="2" align="center"></td>
											<td colspan="71%" align="left">
												<input name="button" class="button_5" type="button"
													onclick="exportdoc()"
													value="<%=MipWebJSPUi.mipweb_user_personaluser_97%>"
													size="10" />
											</td>
										</tr>
									</table>
									<%-- 导入用户--%>
									<div id="impview" style="display: none">
										<form id="form2" method="post" action="../userimport.do"
											enctype="multipart/form-data">
											<table width="100%" border="0" align="center" cellpadding="0"
												cellspacing="5">
												<tr>
													<td colspan="3" style="display: none">
														<font color="#ff0000"> <%=MipWebJSPUi.mipweb_user_personaluser_98%></font>
													</td>
												</tr>
												<tr>
													<td width="3%">
														<img src="../skin/default/images/text_icon.gif" />
													</td>
													<td width="10%">
														<%=MipWebJSPUi.mipweb_user_personaluser_99%>
													</td>
													<td width="81%" align="center">
														<input type="radio" id="impexcel" name="filetype"
															checked="true" />
														<%=MipWebJSPUi.mipweb_user_personaluser_100%>
														<a id="example" href="#" onclick="forexample('excel')"
															class="blue_12"><%=MipWebJSPUi.mipweb_user_personaluser_101%></a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<input type="radio" id="imptxt" name="filetype" />
														<%=MipWebJSPUi.mipweb_user_personaluser_102%>
														<a id="example" href="#" onclick="forexample('csv')"
															class="blue_12"><%=MipWebJSPUi.mipweb_user_personaluser_103%></a>
													</td>

												</tr>
												<tr>
													<td width="3%">
														<img src="../skin/default/images/text_icon.gif" />
													</td>
													<td width="10%">
														<%=MipWebJSPUi.mipweb_user_personaluser_104%>
													</td>
													<td width="81%">
														<input id="file" onpaste="return   false"
															onkeydown="return   false" type="file" name="file"
															style="width: 300px;" />
														<input id="ftype" name="ftype" type="hidden" />
														<input id="uploadtype" name="uploadtype" type="hidden"
															value="personnel" />
													</td>
												</tr>
												<tr>
													<td colspan="3">
														<div id="prompt">
															<font color="#ff0000"> <%=MipWebJSPUi.mipweb_user_personaluser_105%></font>
														</div>
													</td>
												</tr>
												<tr>
													<td colspan="3" align="center">
														<input name="button" type="button" id="BtnOK"
															onclick="javascript:upload();" class="button_5"
															value="<%=MipWebJSPUi.mipweb_user_personaluser_106%>" />
														&nbsp;&nbsp;&nbsp;&nbsp;
														<button style="display: none" class="button_4"
															onclick="parent.parent.GB_CURRENT.hide()">
															<%=MipWebJSPUi.mipweb_user_personaluser_107%>
														</button>
													</td>
												</tr>
											</table>
										</form>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<%--分组管理--%>
					<div id="groupmanage" style="display: none">
						<div class="border_blue" style="_margin-top: 20px; _height: 23px;">
							<div class="up_subtitle" style="_background: #e1ecf5;">
								<input type="button"
									value="<%=MipWebJSPUi.mipweb_user_personaluser_108%>"
									onclick="add_group()" class="button_4" />
							</div>

							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0" style="border: 1px solid #CAD7DF;">
								<tr>
									<td colspan="5">
										<table width="100%">
											<tr>
												<td colspan="5">
													<div id="mainbox">
														<div class="center_list_box">
															<div class="center_list">
																<div id="grouplist"></div>
															</div>
														</div>
													</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<%--自定义字段--%>
					<div id="userdefined" style="display: none">
						<div class="border_blue" style="_margin-top: 20px; _height: 23px;">
							<div class="up_subtitle"
								style="_background: #e1ecf5; _padding-left: 30px">
								<span><%=MipWebJSPUi.mipweb_user_personaluser_109%></span>
							</div>
							<table width="45%" border="0" align="center" cellpadding="0"
								cellspacing="5">
								<tr>
									<td width="3%">
										<img src="../skin/default/images/text_icon.gif" />
									</td>
									<td width="26%">
										<%=MipWebJSPUi.mipweb_user_personaluser_110%>
									</td>
									<td width="71%">
										<input type="text" id="c1" class="input_text input_180px"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" maxlength="10" />
									</td>
								</tr>
								<tr>
									<td width="3%">
										<img src="../skin/default/images/text_icon.gif" />
									</td>
									<td width="26%">
										<%=MipWebJSPUi.mipweb_user_personaluser_111%>
									</td>
									<td width="71%">
										<input type="text" id="c2" class="input_text input_180px"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" maxlength="10" />
									</td>
								</tr>
								<tr>
									<td width="3%">
										<img src="../skin/default/images/text_icon.gif" />
									</td>
									<td width="26%">
										<%=MipWebJSPUi.mipweb_user_personaluser_112%>
									</td>
									<td width="71%">
										<input type="text" id="c3" class="input_text input_180px"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" maxlength="10" />
									</td>
								</tr>
								<tr>
									<td width="3%">
										<img src="../skin/default/images/text_icon.gif" />
									</td>
									<td width="26%">
										<%=MipWebJSPUi.mipweb_user_personaluser_113%>
									</td>
									<td width="71%">
										<input type="text" id="c4" class="input_text input_180px"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" maxlength="10" />
									</td>
								</tr>
								<tr>
									<td width="3%">
										<img src="../skin/default/images/text_icon.gif" />
									</td>
									<td width="26%">
										<%=MipWebJSPUi.mipweb_user_personaluser_114%>
									</td>
									<td width="71%">
										<input type="text" id="c5" class="input_text input_180px"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" maxlength="10" />
									</td>
								</tr>
							</table>
							<div class="text_align_center padding_5">
								<input class="button_2" type="button"
									value="<%=MipWebJSPUi.mipweb_user_personaluser_115%>"
									onclick="self_setting()" />
							</div>
						</div>
					</div>





				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>
