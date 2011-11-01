<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<% if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.parent.location.href='../default_ecmanager.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>
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
			var userid = '<%=request.getParameter("userid")%>';
			var oldgroupid = '<%=request.getParameter("oldgroupid")%>';
			
			
			function showRole(){
			  Progress('<%= MipWebJSPUi.mipweb_user_transferuser_1 %>','<%= MipWebJSPUi.mipweb_user_transferuser_2 %>');
			  RoleAction.RoleShow(roleid,
					{
						callback:function(oMap) {
							CloseProgress();
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_3 %>"+errorString);
						}
					});
			}
			window.onload=function(){
				getseltgroup() ;
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
				  Ext.Msg.confirm(nowtitle, '<%= MipWebJSPUi.mipweb_user_transferuser_4 %>', function(btn){
					if(btn=='yes'){
							 Progress('<%= MipWebJSPUi.mipweb_user_transferuser_5 %>','<%= MipWebJSPUi.mipweb_user_transferuser_6 %>');
							 RoleAction.RoleDelete(roleid,
								{
									callback:function(otxt) {
										if(otxt=='1'){
											parent.parent.closepage();
										}else{
											DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_7 %>"+otxt);
										}
									},
									errorHandler:function(errorString, exception) {
										CloseProgress();
									    DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_8 %>"+errorString);
									}
								});
							}else{
							return false;	
							}
						}
						);
				
			}
			
			//获得联系人已存在的群组
			function getseltgroup(){
				CatalogAction.getGroupsByUserid(userid,
					{
						callback:function(objXml) {
						CloseProgress();
						var nodeList = objXml.selectNodes("/root/catlist/cat");
						for(var i=0;i<nodeList.length;i++)
						{
							var objOption = document.createElement("OPTION");
							objOption.text = nodeList[i].attributes[1].value;
							objOption.value = nodeList[i].attributes[0].value;
							objOption.name="fromgroupName" ;
							document.all?$('catalogoutTree').add(objOption):$('catalogoutTree').appendChild(objOption);
						}
						//ajax是个异步过程,只能在里面处理,如果在外面写的话可能出现obj为空.
						var obj = document.getElementById('catalogoutTree') ;
						for(var i = 0 ; i<obj.length ; i++){
							if(oldgroupid!=""&&obj[i].value==oldgroupid){
								obj.disabled = "true" ;
								obj[i].selected="true" ;
							}
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_9 %>"+errorString);
					}
				});
				
				treemenu();
			}
			function treemenu(){
				CatalogAction.getGroupsTree('<%=session.getAttribute("enterpriseid")%>',{
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
					    DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_10 %>"+errorString);
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
				var type="";
				if($('trgroup').checked==true){
				type="1";
				}
				if($('cpgroup').checked==true){
				type="2";
				}
				if(type==""){
				DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_11 %>");
				}
					User2.opUser(userid,$('catalogTree').value,type,$('catalogoutTree').value,{
						callback:function(otext) {
											if(otext=="1"){
												 parent.parent.DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_12 %>");
											     parent.parent.ChangePage(parent.parent.pageid);
											     parent.parent.GB_CURRENT.hide();
											}else{
												DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_13 %>"+otext);
											}
										},
										errorHandler:function(errorString, exception) {
											CloseProgress();
										    DHalert("<%= MipWebJSPUi.mipweb_user_transferuser_14 %>"+errorString);
										}
					})
			}	
		
		function checkout(type){
			if(type==0){
				document.getElementById("fromgroup").style.display="" ;
			}
			if(type==1){
				document.getElementById("fromgroup").style.display="none" ;
			}
		}	
		</script>
	</head>
	<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
			
		<table width="620" border="0" align="center" cellpadding="0"
			cellspacing="3">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_transferuser_15 %>
				</td>
				<td width="71%" >
				<input type="radio" checked name="opgroup" id="trgroup" onclick="checkout(0)" /><%= MipWebJSPUi.mipweb_user_transferuser_16 %>
				<input type="radio" name="opgroup" id="cpgroup" onclick="checkout(1)" /><%= MipWebJSPUi.mipweb_user_transferuser_17 %>
					
				</td>
			</tr>
			<tr id="fromgroup" height="25">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_transferuser_18 %>
				</td>
				<td width="71%" >
					
					<select id="catalogoutTree" name="fromgroupName"></select>
				
					<span style="color:red">*</span>
				</td>
			</tr>	
			<tr height="25">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_transferuser_19 %>
				</td>
				<td width="71%" >
					
					<select id="catalogTree"></select>
				
					<span style="color:red">*</span>
				</td>
			</tr>
			
		</table>
		<div class="div_center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_transferuser_20 %>" onclick="adduser()"/><input type="button" value="<%= MipWebJSPUi.mipweb_user_transferuser_21 %>" onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
