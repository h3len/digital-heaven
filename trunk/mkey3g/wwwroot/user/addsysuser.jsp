<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipMobileType"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>

		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/CatalogAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		
		<script language="javascript" src="scripts/check.js"></script>
		<script type="text/javascript" src="scripts/transferxml.js"></script>
		<script type="text/javascript" src="scripts/xmlextras.js"></script>
		
		<script type="text/javascript">
		var regtel = /^(\+)?(86)?(\d){0,4}(\-)?(\d){6,16}$/
			var branchid = '<%=request.getParameter("branchid")%>';
			var servertype='<%=DhServerNameUtils.Server_Name%>';
			var isEmoa=<%=com.dheaven.mip.util.DhServerNameUtils.Server_Name.equals(com.dheaven.mip.util.DhServerNameUtils.Server_Name)%>
			var checksernum = true;
			
			 var seachtype=0;//两种情况 1:按组查找 2：按条件搜索
		 	 var root;
		 	 var mytree;
		 	 var pageid=1;
			 var now_node;	 
			var contralenable ='3';
	
	var groupid = "<%=request.getParameter("groupid")%>";
			function getuserextend(){
			  User2.getUserExtend(
					{
						callback:function(obj) {
							if(obj.c1!=''&&obj.c1!=null&&obj.c1!='null'){
								addTr(obj.c1,"c1");
							}
							if(obj.c2!=''&&obj.c2!=null&&obj.c2!='null'){
								addTr(obj.c2,"c2");
							}
							if(obj.c3!=''&&obj.c3!=null&&obj.c3!='null'){
								addTr(obj.c3,"c3");
							}
							if(obj.c4!=''&&obj.c4!=null&&obj.c4!='null'){
								addTr(obj.c4,"c4");
							}
							if(obj.c5!=''&&obj.c5!=null&&obj.c5!='null'){
								addTr(obj.c5,"c5");
							}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_1 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				var arr = new Array(2,1) ;
				arr = [[addSysUser,'<%= MipWebJSPUi.mipweb_user_addsysuser_2 %>']] ;
				DHTabPanel(arr,"",0,'addandjoin') ;
				createTree();
				loadBranch("");
				treemenu();
				getappname();
			}

function addSysUser(){
	document.getElementById("adduser").style.display="" ;
	document.getElementById("joinuser").style.display="none" ;
	getMobileType();
	if(servertype=='<%=DhServerNameUtils.SERVER_EMA%>'){
		$('userctrlshow').style.display='';
		$('emoa_chk').style.display='';
	}else{
		$('userctrlshow').style.display='none';
		$('emoa_chk').style.display='none';
	}
	if(<%=DhServerNameUtils.isMKEY%>){
		$('tr_num').style.display='none';
	}else{
		$('tr_num').style.display='';
	}
}

function joinSysUser(){
	document.getElementById("adduser").style.display="none" ;
	document.getElementById("joinuser").style.display="" ;
}
			
			function addTr(cc,cid){
				var obj = $('user_table');
				var oTr = document.createElement("tr");
				var otd = document.createElement("td");
				otd.width="3%";
				otd.innerHTML = "<img src=\"../skin/default/images/text_icon.gif\" />";
				var otd1 = document.createElement("td");
				otd1.width="26%";
				otd1.innerHTML = cc;
				var otd2 = document.createElement("td");
				otd2.width="71%";
				otd2.innerHTML = "<input type=\"text\" id=\""+cid+"\"/>";
				oTr.appendChild(otd);
				oTr.appendChild(otd1);
				oTr.appendChild(otd2);
				obj.appendChild(oTr);
			}
			function addUser(){
			    var cf = new CheckForm();
                var temp=cf.Trim($('username').value);
     			if(temp==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_4 %>");
				 	return false;
				 }
				if(temp.indexOf("$")>-1||temp.indexOf("!")>-1||temp.indexOf("#")>-1||temp.indexOf("%")>-1||
					temp.indexOf("&")>-1||temp.indexOf("^")>-1||temp.indexOf("*")>-1||temp.indexOf("(")>-1||temp.indexOf(")")>-1){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_6 %>");
				 	 return false;
				 }
				 if(temp.length>20){
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_7 %>");
				 	return false;
				 }
				 temp=cf.Trim($('pwd').value);				 
     			if(temp =="" ){
					DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_8 %>");
					return false;
				}
				if(temp.length>20){
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_9 %>");
				 	return false;
				 }
				 if($('pwd').value.length<<%=com.dheaven.mip.util.Constants.PASSLENGTH%>){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_10 %><%=com.dheaven.mip.util.Constants.PASSLENGTH%><%= MipWebJSPUi.mipweb_user_addsysuser_11 %>");
				 	return false;
				 }
				 if($('pwd').value!=$('repwd').value){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_12 %>");
				 	return false;
				 }
				 var temp1=cf.Trim($('truename').value);
     			 if(temp1==''){
				 	DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_13 %>");
				 	return false;
				 }
				 if(temp1.length>20){
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_14 %>");
				 	return false;
				 }
     			//验证手机号，电话号码是否能为空
				var reg = /^(\+)?(\d)+$/
				//var mailreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
				var mailreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				temp=cf.Trim($('mobile').value);	
				 if(temp==''){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_15 %>");
				 	 return false;
				 }else{
						if(!cf.IsTel($('mobile').value)){
						 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_16 %>");
				 	 	 return false;
						 }
				 	}
				 if(!reg.test($('mobile').value)){
				 	 DHalert("	<%= MipWebJSPUi.mipweb_user_addsysuser_17 %>");
				 	 return false;
				 }
				 if($("quota").value!=""&&!cf.IsNumber($('quota').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_18 %>");
				 	 return false;
				 }
				 
				 if(!checksernum){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_19 %>");
				 	 return false;
				 }
				 var regExt = /^\d{0,6}$/;
				 if(cf.Trim($('companytel').value)!=""&&regExt.test(cf.Trim($('companytel').value))){
				 		DHalert("公司电话应为7-20位数字");
						return ;
				 }
				 if(cf.Trim($('hometel').value)!=""&&regExt.test(cf.Trim($('hometel').value))){
				 		DHalert("家庭电话应为7-20位数字");
						return ;
				 }
				 if($('companytel').value!=""&&!regtel.test($('companytel').value)){			
						DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_20 %>");
						return ;
				}
				 if($('hometel').value!=""&&!regtel.test($('hometel').value)){			
						DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_21 %>");
						return ;
				}
				 temp=cf.Trim($('city').value);	
				 if(temp.length>50){
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_22 %>");
				 	return false;
				 }
				 if($('email').value!=''&&!mailreg.test($('email').value)){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_23 %>");
				 	 return false;
				 }
				
				 //判断证件格式
				 var idtype = $('idtype').value;
				 if($('idno').value != '')
				 {
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_addsysuser_24 %>")
				 	{	
				 		var reg = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
				 		if(!reg.test($('idno').value)){
				 			DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_25 %>");
				 			return ;
				 		}
				 	}
				 	//不清楚军官证是什么格式,暂且就当都是数字吧.
				 	if(idtype == "<%= MipWebJSPUi.mipweb_user_addsysuser_26 %>")
				 	{
				 		if(!cf.IsNumber($('idno').value))
				 		{
				 			DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_27 %>");
				 			return;
				 		}
				 	}
				 }
				 if(servertype=='<%=DhServerNameUtils.SERVER_EMA%>'&&!$('oa').checked&&!$('mail').checked&&!$('base').checked&&!$('together').checked&&!$('integation').checked&&!$('other').checked){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_28 %>");
				 	 return false;
				 }
				 
				 var servicetype ="";
				 if($('oa').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mail').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('base').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('together').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integation').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('other').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
				 var c1="";
				 var c2="";
				 var c3="";
				 var c4="";
				 var c5="";
				 if($('c1')!=undefined){
				 	c1 = $('c1').value;
				 }
				 if($('c2')!=undefined){
				 	c2 = $('c2').value;
				 }
				 if($('c3')!=undefined){
				 	c3 = $('c3').value;
				 }
				 if($('c4')!=undefined){
				 	c4 = $('c4').value;
				 }
				 if($('c5')!=undefined){
				 	c5 = $('c5').value;
				 }
				 var comment = $('comment').value;
				 
				 if($('servicenum').value==''&& !<%=DhServerNameUtils.isMKEY%>){
				 	//用户扩展码为空，同时包含TC-CORE插件，则必须提醒用户了
				 	Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_addsysuser_29 %>', function(btn){
						if(btn=='yes'){
								 if(comment.length>40){
								 	 //备注超过40个字
							 		 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_addsysuser_30 %>', function(btn){
										if(btn=='yes'){
											//同意截取
											 comment = comment.substr(0,40);	
											 _addSysUser(branchid,comment,c1,c2,c3,c4,c5,servicetype);
										}else{
											//不同意截取，就重新填写吧
											return false;	
										}
									});
								 }else{
								 	//备注在40个字以内
									_addSysUser(branchid,comment,c1,c2,c3,c4,c5,servicetype);
								 }			
						}else{
							return ;	
						}
					}
				 );
				 }else{
				 	//用户扩展码不为空
				 	 if(comment.length>40){
				 		 Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_addsysuser_31 %>', function(btn){
							if(btn=='yes'){
								comment = comment.substr(0,40);	
								_addSysUser(branchid,comment,c1,c2,c3,c4,c5,servicetype);
							}else{
								return false;	
							}
						});
					 }else{
					 	//备注在40个字以内
						_addSysUser(branchid,comment,c1,c2,c3,c4,c5,servicetype);
					 }	
				 }
				
			 	
			}
			/***************************************************
				创建系统用户 by chb@2009-11-11
			***************************************************/
			function _addSysUser(branchid,comment,c1,c2,c3,c4,c5,servicetype){
				 var cf = new CheckForm();
				 Progress('<%= MipWebJSPUi.mipweb_user_addsysuser_32 %>','<%= MipWebJSPUi.mipweb_user_addsysuser_33 %>');
				 User2.addSysUser(branchid,cf.Trim($('username').value),$('pwd').value,cf.Trim($('mobile').value),$('truename').value,$('companytel').value,$('hometel').value,
				 $('city').value,$('idtype').value,$('idno').value,$('usertype').value,comment,$('email').value,$('mobiletype').value,c1,c2,c3,c4,c5,servicetype,$("quota").value,$('servicenum').value,DWRUtil.getValue("apps"),
					{
						callback:function(otext) {
							CloseProgress();
							if(otext=="1"){
								 parent.parent.DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_34 %>");
								 parent.parent.ChangePage(parent.parent.pageid);
								 parent.parent.GB_CURRENT.hide()
							}else{
								DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_35 %>"+otext);
							}
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_36 %>"+errorString);
						}
					});	
			}
			
			function getMobileType(){
				MobileAction.getMoblicTypeList({
					callback:function(objxml) {
										var nodes = objxml.selectNodes("//item");
										for(var i=0;i<nodes.length;i++){
												var oOption = document.createElement("OPTION");
												oOption.text = nodes[i].getAttribute("mobiletype");
												oOption.value = nodes[i].getAttribute("id");			
												document.all?$('mobiletype').add(oOption):$('mobiletype').appendChild(oOption);
										}
									},
									errorHandler:function(errorString, exception) {
										
									    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_37 %>"+errorString);
									}
				});
			}



//通讯录导入用户

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
	function createTree(){
		
		Ext.QuickTips.init();
		  root=new Ext.tree.TreeNode({
		      id:"root",
		      text:"<%= MipWebJSPUi.mipweb_user_addsysuser_38 %>",
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
		  height:390,
		  //autoWidth:true,
		  lines:true
		});
		mytree.setRootNode(root);//设置根节点
	 	mytree.render();//不要忘记render()下,不然不显示哦
	}
function loadBranch(branchid){
	Progress('<%= MipWebJSPUi.mipweb_user_addsysuser_39 %>','<%= MipWebJSPUi.mipweb_user_addsysuser_40 %>');
	
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
										text:"<%= MipWebJSPUi.mipweb_user_addsysuser_41 %>",
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_42 %>"+errorString);
				}
	});
}
function showuserlist(){
	seachtype=1;
	$('searchoption').value ='';
	Progress('<%= MipWebJSPUi.mipweb_user_addsysuser_43 %>','<%= MipWebJSPUi.mipweb_user_addsysuser_44 %>'); 
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
				    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_45 %>"+errorString);
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
											text:"<%= MipWebJSPUi.mipweb_user_addsysuser_46 %>",
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_47 %>"+errorString);
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
  
    function loadsearchuser(){
		pageid=1;
		searchuser();
	}
	
	function searchuser(){
		 seachtype=2;
		 Progress('<%= MipWebJSPUi.mipweb_user_addsysuser_48 %>','<%= MipWebJSPUi.mipweb_user_addsysuser_49 %>'); 
		 User2.searchUserForSel($('searchtype').value,$('searchoption').value,pageid,
				{
					callback:function(objXml) {
						//$('delmenu').style.display = "none";//干掉删除按扭吧.
						CloseProgress();
						 DisplayTransformedXML(1, objXml, "../user/xslt/user_list_selected_search.xsl",document.getElementById("userlist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_50 %>"+now_branchtext+"<%= MipWebJSPUi.mipweb_user_addsysuser_51 %>"+errorString);
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
				DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_52 %>");
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
				    		DHalert(oOptions[1]+"已经添加到列表中!");
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
			var count=0;
			for(var j=0;j<$('possess2').length;j++){
			   if($('possess2')[j].selected==true){
			     count=count+1;
			   }
			}
			if(count==0){
			   	DHalert("请选择要删除的联系人进行删除!");
			}
			for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].selected==true){
						$('possess2').remove(i);
						i--;
				}
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
					DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_53 %>");
					for(var i=0; i < $('possess2').length; i++){
						$('possess2').remove(i);
						i--;
					}
					return;
				}
			}
		});
	}



			function treemenu(){
				CatalogAction.GetAllCatalogList('<%=session.getAttribute("enterpriseid")%>',{
					callback:function(objXml) {
										CloseProgress();
										//clear select
						for(var i = $('catalogTree').length;i>=0;i--)
						{
							$('catalogTree').remove(i);
						}
						
						var nodeList = objXml.selectNodes("/root/catlist/cat");
						for(var i=0;i<nodeList.length;i++)
						{
							var objOption = document.createElement("OPTION");
							objOption.text = nodeList[i].attributes[1].value;
							objOption.value = nodeList[i].attributes[0].value;		
							document.all?$('catalogTree').add(objOption):$('catalogTree').appendChild(objOption);
							//get child catalog
							GetChildCatalog(nodeList[i],0);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_54 %>"+errorString);
					}
				});
			}
				/*-------------------------------------------------------------
		功能：取得子部门 - 无级分类
	--------------------------------------------------------------*/
			function GetChildCatalog(objXml,count)
			{
				//alert(objXml.xml);
				var nodeList = objXml.selectNodes("catlist/cat");
				//alert(nodeList.length);
				for(var i=0;i<nodeList.length;i++)
				{
					//get attribute
					//alert(nodeList[i].attributes[1].value);
					//生成select树 for 更换部门
					
					var space="";
					for(var j = 0;j<count;j++)
					{
						space += "　"
					}
					if(i == nodeList.length-1)
						space+="　┗";
					else
						space+="　┣"
						
					var objOption = document.createElement("OPTION");
					objOption.text = space+nodeList[i].attributes[1].value;
					objOption.value = nodeList[i].attributes[0].value;		
					document.all?$('catalogTree').add(objOption):$('catalogTree').appendChild(objOption);
					count++;
					GetChildCatalog(nodeList[i],count);
					count--;		
				}
			}
			function importuser(){
				//完成添加
				var obj= document.getElementById('possess2');
				if(obj.length==0){
				 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_55 %>");
				 return;
				}
				var userids="," ;
				for(var i=0;i<obj.length;i++){
					if(obj[i].value!=null&&obj[i].value!=""){
						userids += obj[i].value+"," ;
					}
				}
				
				//添加业务类型
				if(servertype=='<%=DhServerNameUtils.SERVER_EMA%>'&&!$('oa1').checked&&!$('mail1').checked&&!$('base1').checked&&!$('together1').checked&&!$('integation1').checked&&!$('other1').checked){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_56 %>");
				 	 return false;
				 }
				 var servicetype ="";
				 if($('oa1').checked){
				 	servicetype = servicetype+","+"1";
				 }
				  if($('mail1').checked){
				 	servicetype = servicetype+","+"2";
				 }
				  if($('base1').checked){
				 	servicetype = servicetype+","+"3";
				 }
				  if($('together1').checked){
				 	servicetype = servicetype+","+"4";
				 }
				  if($('integation1').checked){
				 	servicetype = servicetype+","+"5";
				 }
				  if($('other1').checked){
				 	servicetype = servicetype+","+"6";
				 }
				 servicetype = servicetype.substring(1);
				 
				Progress('<%= MipWebJSPUi.mipweb_user_addsysuser_57 %>','<%= MipWebJSPUi.mipweb_user_addsysuser_58 %>');
				User2.JoinUser(userids,$('catalogTree').value,servicetype,$('user_type').value,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 parent.parent.DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_59 %>");
										     parent.parent.ChangePage(parent.parent.pageid);
										     parent.parent.GB_CURRENT.hide();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_60 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_61 %>"+errorString);
									}
				})
			}
		function checknum(){
			if($('servicenum').value==''){
				checksernum=true;
				return;
			}
			var regnum = /^\d$/;
			if(!regnum.test($('servicenum').value)){
				$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_62 %>";
			}
			$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_63 %>";
			User2.checknum('',$('servicenum').value,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_64 %>";
											checksernum=true;
										}else{
											$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_65 %>";
											checksernum=false;
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_addsysuser_66 %>"+errorString);
									}
				})
		}
		function getCanUseServiceNum(){
			$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_69 %>";
			User2.getCanUseServiceNum({
					callback:function(data) {
						dwr.util.setValues(data);
						
						if($('servicenum').value==''){
							$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_67 %>";
						}else{
							$('isok').innerHTML="<%= MipWebJSPUi.mipweb_user_addsysuser_68 %>";
						}
						
						checksernum=true;
					},
					errorHandler:function(errorString, exception) {
						
					    //DHalert("添加用户失败，失败原因："+errorString);
					}
				})
		}
		
		function getappname(){
	   	 	MipClientAppAction.getAllAppByUidEnterpriseid(null,"<%=session.getAttribute("enterpriseid")%>",{
					callback:function(objXml) {
						DisplayTransformedXML(1, objXml, "../user/xslt/app_list.xsl",document.getElementById("applist"));
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("获取数据失败，失败原因："+errorString);
					}
			});
 		}
		</script>
	</head>
	<body style="width: 100%;"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<div>
			<div id="addandjoin"></div>
			<div id="adduser">
				<div class="up_title">
					<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_addsysuser_70 %></span>
				</div>
				<table class="table_reg" width="50%" border="0" align="center"
					cellpadding="0" cellspacing="0">
					<tbody id="user_table">
						<tr>
							<td width="3%">
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="15%">
								<%= MipWebJSPUi.mipweb_user_addsysuser_71 %>
							</td>
							<td width="80%">
								<input type="text" id="username" maxlength="50" class="input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
								*
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_72 %>
							</td>
							<td >
								<input type="password" id="pwd" class="input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" maxlength="20" />
								*	
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_73 %>
							</td>
							<td >
								<input type="password" id="repwd" class="input_text" 
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" maxlength="20" />
								*
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_74 %>
							</td>
							<td >
								<input type="text" id="truename" class="input_text" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
								*
							</td>
						</tr>
		
						<!-- 
					<tr>
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="26%">
							部门代码
						</td>
						<td width="71%" id="enterprisecode">
						</td>
					</tr>
					 -->
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_75 %>
							</td>
							<td >
								<input type="text" id="mobile" class="input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" maxlength="20" />
								*
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_76 %>
							</td>
							<td  class="padding_bottom_3">
							<select id="mobiletype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
									<option value='<%=MipMobileType.MOBILE_TYPE_OTHER%>'>
										<%= MipWebJSPUi.mipweb_user_addsysuser_77 %>
									</option>
								</select>
							
							</td>
						</tr>
						<tr style="display:none">
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_78 %>
							</td>
							<td >
								<input type="text" id="quota" class="input_text" maxlength="5"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" size="9"/><font color="red"><small>提示:月配额超过30000条，系统默认为不限</small></font>
							</td>
						</tr>
						<tr id="tr_num">
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_79 %>
							</td>
							<td>
								<input type="text" id="servicenum" class="input_text" maxlength="20"
									onmouseover="fEvent('mouseover',this)"
									onblur="checknum()"
									onmouseout="fEvent('mouseout',this)" size="9" />

								<span id="isok" style="color:red"></span><input type="button" value="<%= MipWebJSPUi.mipweb_user_addsysuser_80 %>" class="button_4" onclick="getCanUseServiceNum()"/>
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_81 %>
							</td>
							<td >
								<input type="text" id="companytel" class="input_text" maxlength="20"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_82 %>
							</td>
							<td >
								<input type="text" id="hometel" class="input_text" maxlength="20"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_83 %>
							</td>
							<td >
								<input type="text" id="city" class="input_text" maxlength="50"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_84 %>
							</td>
							<td >
								<input type="text" id="email" class="input_text" maxlength="100"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_85 %>
							</td>
							<td  class="padding_bottom_3">
							<select id="idtype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
									<option value="<%= MipWebJSPUi.mipweb_user_addsysuser_86 %>">
										<%= MipWebJSPUi.mipweb_user_addsysuser_86 %>
									</option>
									<option value="<%= MipWebJSPUi.mipweb_user_addsysuser_87 %>">
										<%= MipWebJSPUi.mipweb_user_addsysuser_87 %>
									</option>
									<option value="<%= MipWebJSPUi.mipweb_user_addsysuser_88 %>">
										<%= MipWebJSPUi.mipweb_user_addsysuser_88 %>
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_89 %>
							</td>
							<td >
								<input type="text" id="idno" class="input_text" maxlength="20"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" />
							</td>
						</tr>
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_90 %>
							</td>
							<td  class="padding_bottom_3">
							<select id="usertype" 
								    class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:20px">
									<option value="WEB">
										WEB
									</option>
									<option value="WAP">
										WAP
									</option>
									<option value="CLIENT">
										CLIENT
									</option>
								</select>
							</td>
						</tr>
						<tr id="userctrlshow">
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_91 %>
							</td>
							<%if(DhServerNameUtils.isEMOA){ %>
							<%if(Constants.APP_AUTHEN_VALUE.equals("3")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("1")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%}else if(Constants.APP_AUTHEN_VALUE.equals("2")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("13")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} else if(Constants.APP_AUTHEN_VALUE.equals("12")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("23")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else if(Constants.APP_AUTHEN_VALUE.equals("123")){%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<% }else{%>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa" style="display:none"></input><input type="checkbox" id="mail" style="display:none"></input><input type="checkbox" id="base" style="display:none"></input><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
						<%}else{ %>
							<td  class="padding_bottom_3">
								<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_addsysuser_92 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_addsysuser_93 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_addsysuser_94 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_addsysuser_95 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_addsysuser_96 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_addsysuser_97 %>
							</td>
						<%} %>
						</tr>
		
						<tr>
							<td >
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td >
								<%= MipWebJSPUi.mipweb_user_addsysuser_98 %>
							</td>
							<td >
								<textarea id="comment"  class="input_250px input_text"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)"
									onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"
									style="height:50px"></textarea>
							</td>
						</tr>
						<tr>
						<td >
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td >
							<%= MipWebJSPUi.mipweb_user_addsysuser_122 %>
						</td>
						<td width="80%" class="padding_bottom_3" id="applist">
						</td>
					</tr>
					</tbody>
				</table>
		
				<div class="div_center padding_top_10 margin_top_10">
					<input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_addsysuser_99 %>" onclick="addUser()" />
					&nbsp;&nbsp;&nbsp;
					<input class="button_2" type="button" value="<%= MipWebJSPUi.mipweb_user_addsysuser_100 %>"
						onclick="parent.parent.GB_CURRENT.hide()" />
				</div>
			</div>
			<div id="joinuser" style="display:none"  onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
				<div class="up_title">
					<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_addsysuser_101 %><font color=#ff0000><%= MipWebJSPUi.mipweb_user_addsysuser_102 %></font></span>
				</div>
				<table width="850px" border="0" align="center" cellpadding="0"
					cellspacing="3">
					<tr>
						<td width="100%" colspan="3">
							<div style="width:100%">
								<div style="width:100%">
									<div style="width:100%">
										<div>
												<table width="100%" height="27" border="0" align="center"
												cellpadding="0" cellspacing="0" style="margin-top: 5px;">
												<tr>
													<td background="../theme/images/list_top_bg.jpg">
														<div class="list_top_left">
															<span class="gray_14_bold"><%= MipWebJSPUi.mipweb_user_addsysuser_103 %></span>
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
															style="margin:0px;padding:0px;valign:top;height:420px;overflow:hidden;"></div>
													</td>
													<td width="76%" valign="top">
														<div style="margin: 0px; padding: 0px; clear: both">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td colspan="5" class="title">
																		<%= MipWebJSPUi.mipweb_user_addsysuser_104 %>
																	</td>
																</tr>
																<tr>
					
																	<td colspan="5">
																		<table width="100%">
																			<tr>
																				<td class="height25">
																					<div class="submenu">
																						<%= MipWebJSPUi.mipweb_user_addsysuser_105 %>
																						<select id="searchtype" onchange="clearSearch()">
																							<option value='0'>
																								<%= MipWebJSPUi.mipweb_user_addsysuser_106 %>
																							</option>
																							<option value='1'>
																								<%= MipWebJSPUi.mipweb_user_addsysuser_107 %>
																							</option>
																						</select>
																						<input type="text" id="searchoption" class="input_text"
																							onmouseover="fEvent('mouseover',this)"
																							onfocus="fEvent('focus',this)"
																							onblur="fEvent('blur',this)"
																							onmouseout="fEvent('mouseout',this)" maxlength="20"/>
																						<input type="button" value="<%= MipWebJSPUi.mipweb_user_addsysuser_108 %>" class="button_2"
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
																						value="<%= MipWebJSPUi.mipweb_user_addsysuser_109 %>" onclick="add();"
																						style="width: 100px" />
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<input type="button" class="button_4"
																						value="<%= MipWebJSPUi.mipweb_user_addsysuser_110 %>" onclick="delout()"
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
										
									</div>
								</div>
						</td>
					</tr>
					<tr height="25">
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="26%" align="right">
							<%= MipWebJSPUi.mipweb_user_addsysuser_111 %>
						</td>
						<td width="71%" >
							&nbsp;&nbsp;&nbsp;
							<select id="catalogTree"></select>
						
							<span style="color:red">*</span>
						</td>
					</tr>
					<tr>
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="17%" align="right">
							<%= MipWebJSPUi.mipweb_user_addsysuser_112 %>
						</td>
						<td width="80%" class="padding_bottom_3">
							&nbsp;&nbsp;&nbsp;
							<select id="user_type">
								<option value="WEB">
									WEB
								</option>
								<option value="WAP">
									WAP
								</option>
								<option value="CLIENT">
									CLIENT
								</option>
							</select>
						</td>
					</tr>
					<tr id="emoa_chk" >
						<td width="3%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="17%" align="right">
							<%= MipWebJSPUi.mipweb_user_addsysuser_113 %>
						</td>
						<td width="80%" class="padding_bottom_3">
							&nbsp;&nbsp;&nbsp;<input type="checkbox" id="oa1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_114 %><input type="checkbox" id="mail1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_115 %><input type="checkbox" id="base1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_116 %><input type="checkbox" id="together1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_117 %><input type="checkbox" id="integation1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_118 %><input type="checkbox" id="other1"></input><%= MipWebJSPUi.mipweb_user_addsysuser_119 %>
						</td>
					</tr>
				</table>
				<div class="div_center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_addsysuser_120 %>" onclick="importuser()"/><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_addsysuser_121 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
				
			</div>
		</div>
		

	</body>
</html>
