<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.MipSysuserServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.ServerConfig"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<jsp:directive.page import="org.apache.commons.lang.CharUtil"/>
<jsp:directive.page import="org.dom4j.Document"/>
<jsp:directive.page import="com.dheaven.framework.util.XmlHelper"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
<style type="text/css">
img{vertical-align:middle;}
</style>   
    <title>MDP 应用签名管理</title>
	<script type="text/javascript" src="../../scripts/jquery/jquery-1.2.3.pack.js"></script>
	<script type="text/javascript" src="../../scripts/transferxml.js"></script>
	<script type="text/javascript" src="../../scripts/xmlextend.js"></script>
	<link type="text/css" rel="stylesheet" href="../css/user.css" />
	
	<script type="text/javascript">
		var progressBar;
		
		//下载
		function DownloadCSR()
		{
			window.open("../mdp/sign.do?action=DownloadCSR","");
		}
		//激活
		function ActiveMDP()
		{
			document.getElementById("loading").innerHTML = "数据提交中...";
			$.ajax({
			 type: "POST",
			 url: "sign.do",
			 data: "action=ActiveMDP&content="+document.getElementById("content").value,
			 dataType: "text",
			 success: function(data){
			 /*
				 	if(data == "签名正常")
				 	{
				 		document.getElementById("loading").innerHTML = "激活成功!";
				 	 	//alert("激活成功");
				 	}
				 	else
				 	{
				 		document.getElementById("loading").innerHTML = data;
				 	 	//alert(data);
			 	 	}*/
			 	 	alert(data);
			 	 	location.reload();
				} 
			});
		}
		
		
	</script>
	</head>
	
	<body style="padding:0px;margin:0px;">
		<div id="main" style="width:100%;padding:0px;">
			<div id="menu" style="width:156px; padding:0px;float:left;">
			 <table width="156" border="0" align="center" cellpadding="0" id="menutable" cellspacing="0">		
			  <tr><td height="4"></td></tr> 
			  
			  <tr>
			    <td height="24" background="../images/admin_left_2.gif" onMouseOver="this.background='../images/admin_left_3.gif'" onMouseOut="this.background='../images/admin_left_2.gif'"><div align="" style="padding-left:35px;"><a href="mdpadmin/index.jsp" target="main">MDP配置管理</a></div></td>
			  </tr>	
			  <tr>
				<td height="24" background="../images/admin_left_1.gif"><div style="color:#ffffff;font-size:13px;padding-left:35px;">MDP应用签名管理</div></td>
			  </tr>
			</table>
		</div>
		<div id="mainbox" style="width:80%;height:auto;float:left;">
			<div class="nav">
				<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0><TBODY><TR>
				<TD class=navigation>&nbsp;<IMG alt="" src="../images/icon.gif" align=baseline border=0>&nbsp;<font color=#052968>当前位置：</font><a href="../user/main.jsp"><font color=#052968>管理首页</font></a><font color=#052968>&nbsp;<IMG alt="" src="../images/next.gif" align=baseline border=0>&nbsp; </font><font color=#052968>MDP应用签名管理</font></TD></TR></TBODY></TABLE><span id="spanCurrentPosition"></span>
			</div>
			
			<div id="divContent" style="float:right;width:100%;">
			<fieldset>
			<legend>MDP应用签名流程</legend>
			<p style="text-align:left; padding:15px; font-size:12px;">
			1) Partner管理员启动MSC服务器<br/>
			2) Partner管理员访问MSC服务器签名查看页面，下载应用签名请求文件<br/>
			3) Partner通过数字天堂业务支撑系统提交签名请求文件<br/>
			4) 数字天堂相关负责人审核该签名请求，若审核通过，执行第6步，否则执行第5步；<br/>
			5) 通知Partner签名审核失败<br/>
			6) 将应用签名响应文件发还给Partner<br/>
			7) Partner登录MSC服务器，填写签名响应信息<br/>
			8) MSC服务器解密签名信息<br/>
			9) MSC服务器比对签名合法性，若签名信息与服务器信息匹配，则执行第11步，否则执行第10步；<br/>
			10) 提示签名信息不匹配<br/>
			11) 提示验证成功，将签名信息保存入签名响应文件中。<br/>
			备注：<br/>
			1) MSC服务器启动时，会首先会在ServerConfig.installDir/crypto/mdp目录下检索应用签名请求文件，若没有找到，则生成一个新的应用签名请求文件，并保存在ServerConfig.installDir/crypto/mdp目录下；<br/>
			2) 应用签名响应文件会自动保存在ServerConfig.installDir/crypto/mdp目录下。
			</p>
			<p style="text-align:right;margin:15px;clear:both;"><input type="button" onClick="javascript:DownloadCSR();" value="下载签名请求文件"/></p>
			</fieldset>
			
			<fieldset>
			<legend>MDP应用激活</legend>
			<p style="text-align:left; padding:15px; font-size:14px;">
			当前状态：<font color="Red"><%
			Document doc = null;
			if(com.dheaven.mip.util.DhServerNameUtils.isCloud && com.dheaven.mip.util.HadoopUtils.isHadoop){
				java.io.File fileConfig = null;
				try {
					fileConfig = com.dheaven.mip.util.HadoopUtils.getFile(ServerConfig.installdir + java.io.File.separatorChar + ServerConfig.SIGN_FOLDER +java.io.File.separatorChar + "mdp.xml");
				} catch (java.io.IOException e) {
					e.printStackTrace();
				}
				if(fileConfig != null && fileConfig.exists() && fileConfig.isFile()){
					try {
						doc = XmlHelper.openXmlDocument(new java.io.FileInputStream(fileConfig));
					} catch (java.io.FileNotFoundException e) {
						e.printStackTrace();
					}
				}
			}
			else{
				doc = XmlHelper.openXmlDocument(ServerConfig.installdir + java.io.File.separatorChar + ServerConfig.SIGN_FOLDER, "mdp.xml"); 
			}
			
			String state = "-1";
			if(doc!=null && doc.getRootElement().getText()!=null)
			{
				state = doc.getRootElement().getText().trim();
			}
			if(state.equals("1"))
			{
				out.println("MDP应用已激活");
			}
			else if(state.equals("2"))
			{
				out.println("MDP应用试用模式");
			}
			else if(state.equals("3"))
			{
				out.println("MDP应用已关闭");
			}
			else if(state.equals("4"))
			{
				out.println("MDP应用签名出现异常");
			}
			else if(state.equals("-1"))
			{
				out.println("MDP应用尚未激活");
			}%></font>
			<textarea id="content" style="width:100%;height:200px;" onDblclick="this.select()"></textarea>
			
			<div id="loading"></div>
			
			<p style="text-align:right;margin:15px;clear:both;"><input type="button" onClick="javascript:ActiveMDP();" value="激活MDP应用"/></p>
			</fieldset>
			</div>
		</div>
		<div style="margin-top:700px;"></div>
	</body>
</html>
