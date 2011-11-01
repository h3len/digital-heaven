<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>

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
			<script src="../dwr/interface/CatalogAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var roleid = '<%=request.getParameter("roleid")%>';
			var isEmoa=<%=com.dheaven.mip.util.DhServerNameUtils.Server_Name.equals(com.dheaven.mip.util.DhServerNameUtils.Server_Name)%>

			function showRole(){
			  Progress('<%= MipWebJSPUi.mipweb_user_joinsysuser_1 %>','<%= MipWebJSPUi.mipweb_user_joinsysuser_2 %>');
			  RoleAction.RoleShow(roleid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_3 %>"+errorString);
						}
					});
			}
			window.onload=function(){
//				if(isEmoa)
//					$("emoa_chk").style.display="";
				treemenu();
			}
			function modrole(){
				window.location.href="../user/modrole.jsp?roleid="+roleid;
			}
			function usermanager(){
				window.location.href="../user/rolejoinuser.jsp?roleid="+roleid;
			}
			function rolesetting(){
				window.location.href="../user/rolesetting.jsp?roleid="+roleid;
			}
			function roledel(){
				  Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_joinsysuser_4 %>', function(btn){
					if(btn=='yes'){
							 Progress('<%= MipWebJSPUi.mipweb_user_joinsysuser_5 %>','<%= MipWebJSPUi.mipweb_user_joinsysuser_6 %>');
							 RoleAction.RoleDelete(roleid,
								{
									callback:function(otxt) {
										if(otxt=='1'){
											parent.parent.closepage();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_7 %>"+otxt);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_8 %>"+errorString);
									}
								});
							}else{
							return false;	
							}
						}
						);
				
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_9 %>"+errorString);
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
			function adduser(){
				//添加业务类型
				if(isEmoa&&!$('oa').checked&&!$('mail').checked&&!$('base').checked&&!$('together').checked&&!$('integation').checked&&!$('other').checked){
				 	 DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_10 %>");
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
				 //完成添加
				 
				var strId = SelCatalogAndUser();
				if(strId==""){
					 DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_11 %>");
					 return;
				}
				Progress('<%= MipWebJSPUi.mipweb_user_joinsysuser_12 %>','<%= MipWebJSPUi.mipweb_user_joinsysuser_13 %>');
				User2.JoinUser(strId,$('catalogTree').value,servicetype,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 parent.parent.DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_14 %>");
										     parent.parent.ChangePage(parent.parent.pageid);
										     parent.parent.GB_CURRENT.hide();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_15 %>"+otext);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_joinsysuser_16 %>"+errorString);
									}
				})
			}		
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_joinsysuser_17 %><font color=#ff0000><%= MipWebJSPUi.mipweb_user_joinsysuser_18 %></font></span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_joinsysuser_19 %>
				</td>
				<td width="71%">
					<div id="divUserTree" style="text-align:left;height:260px;width:260px;border:1px solid black; overflow:auto;overflow-y:yes;overflow-x:yes;">
					<script src="../scripts/jsvm2/jsre.js" classpaht="webfx/xtree1.1.js"></script>
					<script  language="javascript">
					_import("com.eae.webfx.xtree.WebFXLoadTree");
					_import("com.eae.webfx.xtree.WebFXTree");
					_import("com.eae.webfx.xtree.WebFXTreeItem");	
					</script>
					<script type="text/javascript">
					var atree = new WebFXLoadTree("<%= MipWebJSPUi.mipweb_user_joinsysuser_20 %>","../catalog.do?action=GetCatalogForImportTextNode&catalogid=&bizUser=true&rnd="+Math.random());
					//当选中某个节点的时候，必须选中子，modify by yesun		
					atree.onCheck = function (node, tree)
					{
						//把子部门选上	
						if(node.isChecked() == true)
						{
							SelChildNodes(node);
							SelParentNode(node);
						}
						else
						{
							UnSelChildNodes(node);
							UnSelParentNode(node);
						}
					}
					atree.build();
					//全部展开
					atree.expandAll();
				
					//选择子
					function SelChildNodes(node)
					{
						var i = 0;
						for(i=0;i<node.childNodes.length;i++)
						{
							if(node.childNodes.length > 0)
								SelChildNodes(node.childNodes[i]);
								
							node.childNodes[i].check(true);
						}
					} 
					
					//取消选择子
					function UnSelChildNodes(node)
					{
						var i = 0;
						for(i=0;i<node.childNodes.length;i++)
						{
							if(node.childNodes.length > 0)
								UnSelChildNodes(node.childNodes[i]);
								
							node.childNodes[i].check(false);
						}
					} 
					
					//选择父,也需要递归
					function SelParentNode(node)
					{
						var pNode = node.parentNode;
						var ok = true;
						for(i=0;i<pNode.childNodes.length;i++)
						{	
							if(pNode.childNodes[i].isChecked() == false)
							{
								//只要有一个没有选中,则返回
								ok = false;
								break;			
							}	
						}
						if(ok == true)
						{
						  try{						
							pNode.check(true);
							SelParentNode(pNode);
							}catch(e ){
							
							}
						}
					}
					//取消选择父,这里有点特殊,取消选择的时候,需要递归取消所有父
					function UnSelParentNode(node)
					{
						var pNode = node.parentNode;
						try{
						pNode.check(false);
						UnSelParentNode(pNode);
						}catch(e){
						}
					}
					/*--------------------------------------------------------------
						功能：取得选中的选择部门或者用户的ID，用逗号隔开 by yesun
					---------------------------------------------------------------*/
					function SelCatalogAndUser()
					{
						var aobj = atree.getSelectedChildNodes();
						var strId = "";
						var strName = "";		
						for (var i = 0; i < aobj.length; i++)
						{
							if(aobj[i].text.indexOf("<%= MipWebJSPUi.mipweb_user_joinsysuser_21 %>")>-1){
						   		continue;
						    }
							strId += aobj[i].value+",";
							strName += aobj[i].text+",";			
						}
						if(strId.length > 0)
						{
							strId = strId.substring(0,strId.length-1);
							strName = strName.substring(0,strName.length-1);		
						}
						return strId;
					}	
				</script>
					
				</div>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_joinsysuser_22 %>
				</td>
				<td width="71%" >
					
					<select id="catalogTree"></select>
				
					<span style="color:red">*</span>
				</td>
			</tr>
			<tr id="emoa_chk" >
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="17%">
					<%= MipWebJSPUi.mipweb_user_joinsysuser_23 %>
				</td>
				<td width="80%" class="padding_bottom_3" i>
					<input type="checkbox" id="oa"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_24 %><input type="checkbox" id="mail"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_25 %><input type="checkbox" id="base"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_26 %><input type="checkbox" id="together"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_27 %><input type="checkbox" id="integation"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_28 %><input type="checkbox" id="other"></input><%= MipWebJSPUi.mipweb_user_joinsysuser_29 %>
				</td>
			</tr>
		</table>
		<div class="div_center"><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_joinsysuser_30 %>" onclick="adduser()"/><input type="button" class="button_2" value="<%= MipWebJSPUi.mipweb_user_joinsysuser_31 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
