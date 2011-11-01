<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>

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
			
			var groupid = "<%=request.getParameter("groupid")%>";
		
			window.onload=function(){
				treemenu();
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusersforredit_8 %>"+errorString);
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
			
function adduser()
{
	//开始读取选中的用户和部门
	//SelCatalogAndUser();
	var strId = SelCatalogAndUser();
	if(strId==""){
	 DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusersforredit_9 %>");
	 return;
	}
	if(strId.length > 0 )
	{		
		 Progress('<%= MipWebJSPUi.mipweb_user_importcontactusersforredit_10 %>','<%= MipWebJSPUi.mipweb_user_importcontactusersforredit_11 %>');
		 User2.fromContact(strId,groupid,
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
			    DHalert("<%= MipWebJSPUi.mipweb_user_importcontactusersforredit_12 %>"+errorString);
			}
		});		
	}		
}			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			<div class="up_title">
			<span class="href_14px_blue">从通讯录导入用户</span>
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
					var atree = new WebFXLoadTree("集团列表","../catalog.do?action=GetCatalogForImportTextNode&catalogid=&bizUser=true&rnd="+Math.random());
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
							if(aobj[i].text.indexOf("[群组]")>-1){
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
			<tr style="display:none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					请选择要加入的群组
				</td>
				<td width="71%" >
					
					<select id="catalogTree"></select>
				
					<span style="color:red">*</span>
				</td>
			</tr>
		</table>
		<div class="div_center"><input type="button" class="button_2" value="确认" onclick="adduser()"/><input type="button" class="button_2" value="关闭" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
