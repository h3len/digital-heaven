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
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>	
		 <link rel="stylesheet" type="text/css" href="../theme/css.css" />
	 <script type="text/javascript" src="../scripts/common.js"></script>
		
		<script type="text/javascript">
			var roleid = '<%=request.getParameter("roleid")%>';
			function showRole(){
			  Progress('正在获取角色详情....','权限管理');
			  RoleAction.RoleShow(roleid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("操作失败，失败原因："+errorString);
						}
					});
			}
			window.onload=function(){
				treemenu();
			}
			function modrole(){
				window.location.href="../role/modrole.jsp?roleid="+roleid;
			}
			function usermanager(){
				window.location.href="../role/rolejoinuser.jsp?roleid="+roleid;
			}
			function rolesetting(){
				window.location.href="../role/rolesetting.jsp?roleid="+roleid;
			}
			function roledel(){
				  Ext.Msg.confirm('综合办公提醒您', '确认删除该角色？', function(btn){
					if(btn=='yes'){
							 Progress('正在删除角色详情....','权限管理');
							 RoleAction.RoleDelete(roleid,
								{
									callback:function(otxt) {
										if(otxt=='1'){
											parent.parent.closepage();
										}else{
											DHalert("删除角色失败，失败原因："+otxt);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("删除角色失败，失败原因："+errorString);
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
					    DHalert("获取角色列表失败，失败原因："+errorString);
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
				var strId = SelCatalogAndUser();
				Progress('正在添加用户....','角色管理');
				RoleAction.JoinUser(roleid,strId,$('catalogTree').value,{
					callback:function(otext) {
										CloseProgress();
										if(otext=="1"){
											 //parent.parent.DHalert("添加用户成功!!!");
											window.location.href="../role/rolejoinuser.jsp?roleid="+roleid;
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
			function killErrors() {
				return true;
			}
			window.onerror = killErrors;		
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">角色用户管理</span>
		</div>
		<div class="up_subtitle">
			<span>加入用户：</span>
		</div>
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					请选择用户
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
					var atree = new WebFXLoadTree("集团列表","../catalog.do?action=GetCatalogForTextNode&catalogid=&bizUser=true&rnd="+Math.random());
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
					  try{
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
						
					   
							pNode.check(true);
							SelParentNode(pNode);
						  
							
						}
						 }catch(e){
						   
						   }
					}
					//取消选择父,这里有点特殊,取消选择的时候,需要递归取消所有父
					function UnSelParentNode(node)
					{
						var pNode = node.parentNode;
						
							try{
								if(node.parentNode!=null){
									pNode.check(false);
									UnSelParentNode(pNode);
								}
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
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					请选择要管理的部门
				</td>
				<td width="71%" >
					
					<select id="catalogTree"></select>
				
					<span style="color:red">(*注：请选择用户所在的集团)</span>
				</td>
			</tr>
			
		</table>
		<div class="div_center"><input type="button" class="button_2" value="确认" onclick="adduser()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="button_2" value="返回" onclick="window.history.go(-1)"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="button_2" value="关闭" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
