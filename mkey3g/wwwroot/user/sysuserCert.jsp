<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.ui.MipUi"%>
<%@page import="com.dheaven.mip.util.InterfaceUtils"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'sysuserCert.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>
	<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
	<script language="javascript" src="../skin/common.js"></script>

	<script src="../dwr/engine.js" type="text/javascript"></script>
	<script src="../dwr/util.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../theme/css.css" />
	<link rel="stylesheet" type="text/css" href="../theme/layout.css" />
	<script type="text/javascript" src="../scripts/common.js"></script>
	<script src="../dwr/interface/User2.js" type="text/javascript"></script>
	<!--GrayBox-->
	<script type="text/javascript" src="../skin/AJS.js"></script>
	<script type="text/javascript" src="../skin/AJS_fx.js"></script>
	<script type="text/javascript" src="../skin/gb_scripts.js"></script>
	<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript">
  var id = '<%=request.getParameter("id")%>';
  var reasonvalue = "32768";
  var sslcfgvalue='';
  	window.onload = function(){
  		var tabs = new Ext.TabPanel({		        
				        //width:950,
				        activeTab: 0,
				        frame:true,
				        defaults:{autoHeight: true},
				        renderTo: 'tabcard',
				        items:[
				         	{
				            title: '证书详情',
				            listeners: {activate: showCert},
				             html:'<div id="biz1"></div>',
				            id:'tabGOTONE'		            
				            },
				            {
				            title: '导入证书',
				            listeners: {activate: importCert},
				            html:'<div id="biz2"></div>',
				            id:'tabMZONE'
				            }
				            ,
				            <%if(InterfaceUtils.getMipSSLInterface()!=null){ %>
				            {
				            title: '吊销证书',
				            listeners: {activate: revCert},
				            html:'<div id="biz3"></div>',
				            id:'tabCZONE'
				            },
				            <%}%>
				            {
				            title: '删除证书',
				            listeners: {activate: delCert},
				            html:'<div id="biz4"></div>',
				            id:'tabEZONE'
				            },
				            {
				            title: 'SSL配置',
				            listeners: {activate: sslconfig},
				            html:'<div id="biz5"></div>',
				            id:'tabDZONE'	
				            }
				        ]
				  	 	 });
		getCert();
  	}
  	function showCert(){
  		document.getElementById("showcert").style.display="";
  		document.getElementById("importcert").style.display="none";
  		document.getElementById("revokecert").style.display="none";
  		document.getElementById("deletecert").style.display="none";
  		document.getElementById("sslconfig").style.display="none";
  	}
  	function importCert(){
  		document.getElementById("showcert").style.display="none";
  		document.getElementById("importcert").style.display="";
  		document.getElementById("revokecert").style.display="none";
  		document.getElementById("deletecert").style.display="none";
  		document.getElementById("sslconfig").style.display="none";
  		form1.reset();
  	}
  	function revCert(){
  		document.getElementById("showcert").style.display="none";
  		document.getElementById("importcert").style.display="none";
  		document.getElementById("revokecert").style.display="";
  		document.getElementById("deletecert").style.display="none";
  		document.getElementById("sslconfig").style.display="none";
  	}
  	function delCert(){
  		document.getElementById("showcert").style.display="none";
  		document.getElementById("importcert").style.display="none";
  		document.getElementById("revokecert").style.display="none";
  		document.getElementById("deletecert").style.display="";
  		document.getElementById("sslconfig").style.display="none";
  	}
  	function sslconfig(){
  		document.getElementById("showcert").style.display="none";
  		document.getElementById("importcert").style.display="none";
  		document.getElementById("revokecert").style.display="none";
  		document.getElementById("deletecert").style.display="none";
  		document.getElementById("sslconfig").style.display="";
  		showsslcfg();
  	}
  	function getCert(){
  		User2.getSysuserCert(id,
  		{
  			callback:function(data){
  				if(data!=null&&data!=""){
  					dwr.util.setValues(data);
  				}else{
  					SDHalert("该用户没有证书",130);
  				}
  			},errorHandler:function(errorString,exception){
  				DHalert("<%=MipWebJSPUi.mipweb_user_business_user_53%>"+errorString);
  			}
  		});
  	}
  	function upload(){
  		var file = document.getElementById('file').value;
  		if(document.getElementById('file').value==""){
  			DHalert("导入的文件不能为空！");
  			return;
  		}
  		if(document.getElementById('certpass').value==""){
  			DHalert("证书密码不能为空！");
  			return ;
  		}
  		var file_type=file.substring(file.lastIndexOf(".")+1);
  		/*if(file_type!="bat"&&file_type!="cer"&&file_type!="pfx"){
  			DHalert("导入的文件类型不正正确");
  			return;
  		}*/
  		document.form1.action="../certimport.do?id="+id+"&certpass="+document.getElementById('certpass').value;
  		form1.submit();
  	}
  	//吊销证书
  	function revokeCert(){
  		Progress("<%= MipWebJSPUi.mipweb_user_business_user_48 %>","<%= MipWebJSPUi.mipweb_user_business_user_49 %>");
		User2.revokeCert(id,reasonvalue,
		{
			callback:function(data){
				CloseProgress();
				if(data==""){
					document.getElementById("subject").innerHTML="";
					document.getElementById("version").innerHTML="";
					document.getElementById("validfrom").innerHTML="";
					document.getElementById("validto").innerHTML="";
					document.getElementById("issuer").innerHTML="";
					document.getElementById("serialNumber").innerHTML="";
					SDHalert("<%= MipWebJSPUi.mipweb_user_business_user_50 %>",130);
				}else{
					DHalert(data);
				}
			},errorHandler:function(errorString,exception){
				CloseProgress();
				DHalert('<%= MipUi.get("mipweb_user_business_user_52") %>'+errorString);
			}
		}
		);
	}
	//删除证书
	function deleteCert(){
		Progress("<%= MipWebJSPUi.mipweb_user_business_user_48 %>","<%= MipWebJSPUi.mipweb_user_business_user_49 %>");
		User2.deleteCert(id,
		{
			callback:function(){
				CloseProgress();
				document.getElementById("subject").innerHTML="";
				document.getElementById("version").innerHTML="";
				document.getElementById("validfrom").innerHTML="";
				document.getElementById("validto").innerHTML="";
				document.getElementById("issuer").innerHTML="";
				document.getElementById("serialNumber").innerHTML="";
				SDHalert('删除成功',130);
			},errorHandler:function(errorString,exception){
				CloseProgress();
				DHalert('<%=MipUi.get("mipweb_user_business_user_52")%>'+errorString);
			}
		}
		);
	}
	function changereason(){
		var reasonobj = document.getElementById("reason");
		for(var i = 0;i<reasonobj.length;i++){
			if(reasonobj[i].selected==true){
				reasonvalue=reasonobj[i].value;
			}
		}
	}
	function updatesslcfg(){
		Progress("<%= MipWebJSPUi.mipweb_user_business_user_48 %>","<%= MipWebJSPUi.mipweb_user_business_user_49 %>");
		if(document.getElementById("sslcfg1").checked){
			sslcfgvalue='1';
		}else{
			sslcfgvalue='0';
		}
		User2.updatesslcfg(id,sslcfgvalue,
		{
			callback:function(data){
				CloseProgress();
				if(data==null){
					SDHalert("更新失败",130);
				}else{
					dwr.util.setValues(data);
					SDHalert("更新成功",130);
				}
			},errorHandler:function(errorString,exception){
				CloseProgress();
				DHalert('<%=MipUi.get("mipweb_user_business_user_52")%>'+errorString);
			}
		}
		);
	}
	function showsslcfg(){
		User2.showsslcfg(id,
		{
			callback:function(data){
				dwr.util.setValues(data);
			},errorHandler:function(errorString,exception){
				DHalert('<%=MipUi.get("mipweb_user_business_user_52")%>'+errorString);
			}
		}
		);
	}
  </script>
	<body>
		<div id="mainbox">
			<div class="center_nav_box">
				<div class="center_nav">
					<div id="tabcard"></div>
					<table id="showcert" style="display: none" width="100%"
						" border="0" align="center" cellpadding="0" cellspacing="5">
						<tr>
							<td width="5%">
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="20%">
								持有人信息:
							</td>
							<td width="75%">
								<div id="subject"></div>
							</td>
						</tr>
						<tr>
						<td width="5%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="20%">
							X.509版本号:
						</td>
						<td width="75%">
							<div id="version"></div>
						</td>
						</tr>
						<td width="5%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="20%">
							有效期起始日期:
						</td>
						<td width="75%">
							<div id="validfrom"></div>
						</td>
						</tr>
						<td width="5%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="20%">
							有效期结束日期:
						</td>
						<td width="75%">
							<div id="validto"></div>
						</td>
						</tr>
						<td width="5%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="20%">
							颁发机构信息:
						</td>
						<td width="75%">
							<div id="issuer"></div>
						</td>
						</tr>
						<td width="5%">
							<img src="../skin/default/images/text_icon.gif" />
						</td>
						<td width="20%">
							证书序列号:
						</td>
						<td width="75%">
							<div id="serialNumber"></div>
						</td>
						</tr>
					</table>
					<table id="importcert" style="display: none" width="100%"
						" border="0" align="center" cellpadding="0" cellspacing="0">
					<form id = "form1" name="form1" method="post" action="../certimport.do" enctype="multipart/form-data">
						<tr>
							<td width="3%" align="right">
								<img src="../skin/default/images/text_icon.gif" />
							<br></td>
							<td width="26%" align="center">导入证书：</td>
							<td width="71%" align="left"><input type="file" id = "file" NAME="file" onpaste="return   false" 
							  onkeydown="return   false" style="width: 300px;"></input><br></td>
						</tr>
						<tr>
							<td width="3%" align="right">
								<img src="../skin/default/images/text_icon.gif" />
							<br></td>
							<td width="26%" align="center">证书密码：</td>
							<td width="71%" align="left"><input type="password" id="certpass" style="width: 235px;"></td>
						</tr>
						<tr align="center"><td colspan="3"><input type="button" class="button_4" onclick="upload()" value="导入证书"></input></td></tr>
					</form>
					</table>
					<table id="revokecert" style="display: none" width="100%"
						" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td width="3%" align="right">
								<img src="../skin/default/images/text_icon.gif" />
							<br>
							</td>
							<td width="20%" align="center">吊销证书的原因：</td>
							<td width="30%" align="center">
								<select id = "reason" onchange="changereason()">
									<option value="32768">
										吊销原因未指明
									</option>
									<option value="16384">
										私钥泄露
									</option>
									<option value="8192">
										CA泄露
									</option>
									<option value="4096">
										从属关系改变
									</option>
									<option value="2048">
										延期
									</option>
									<option value="1024">
										操作终止
									</option>
									<option value="512">
										证书挂起
									</option>
									<option value="256">
										从CRL移走
									</option>
								</select>
							</td>
							<td width="47%" align="left"><input type="button" class="button_4" value="吊销证书" onclick="revokeCert()"</td>
						</tr>
					</table>
					<table id="deletecert" style="display: none" width="100%"
						" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><input type="button" class="button_4" value="删除证书" onclick="deleteCert()"/></td>
						</tr>
					</table>
					<table id="sslconfig" style="display: none" width="100%"
						" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td width="3%" align="right">
								<img src="../skin/default/images/text_icon.gif" />
							<br>
							</td>
							<td width="50%" align="center" >
								是否是证书用户：
								<input type="radio" id = "sslcfg1" name="sslcfg" value='1'>是</input>
								<input type="radio" id = "sslcfg2" name="sslcfg" value='0'>否</input>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="button" class="button_2" value="提交" onclick="updatesslcfg()"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clear"></div>
	</body>
</html>
