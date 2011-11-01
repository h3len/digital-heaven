<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.page import="org.dom4j.Document"/>
<jsp:directive.page import="com.dheaven.framework.util.XmlHelper"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>关于</title>
<link type="text/css" rel="stylesheet" href="../css/user.css" />
<style type="text/css">
body{background:url(../images/about_bg.jpg) repeat-x;}
.about{ text-align:center;width:600px; height:400px;margin:0px auto;}
.title{ font-size:14px; font-weight:bold;margin-top:15px;}
.copyright{ font-size:14px;margin-top:15px;color:#666}
.bold{font-weight:bold;}
</style>
</head>

<body>
<%Document doc = null;
			if(com.dheaven.mip.util.DhServerNameUtils.isCloud && com.dheaven.mip.util.HadoopUtils.isHadoop){
				java.io.File fileConfig = null;
				try {
					fileConfig = com.dheaven.mip.util.HadoopUtils.getFile(com.dheaven.mip.config.ServerConfig.installdir + java.io.File.separatorChar + com.dheaven.mip.config.ServerConfig.SIGN_FOLDER +java.io.File.separatorChar + "mdp.xml");
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
				doc = XmlHelper.openXmlDocument(com.dheaven.mip.config.ServerConfig.installdir + java.io.File.separatorChar + com.dheaven.mip.config.ServerConfig.SIGN_FOLDER, "mdp.xml"); 
			}
  %>
<div class="about">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td><br/><br/><br/></td></tr>
    <tr>
        <td><img src="../images/mkey3g_logo.gif" /></td>
        </tr>
    <tr>
        <td class="title">&nbsp;</td>
    </tr>
    <tr>
        <td width="100%" class="copyright">2008 Digital Heaven&reg; Corporation 保留所有权利</td>
    </tr>
    <tr>
        <td><p class="copyright">本产品使用权利属于</p>
<p class="title">北京数字天堂信息科技有限公司</p>
<p class="copyright">本产品提供商</p>
<p class="title">北京数字天堂信息科技有限公司</p><br />
<p class="copyright">签名信息</p></td>
    </tr>
    <tr>
        <td style="width:350px;border:1px solid #ccc; padding:10px;"><%
			
			if(doc!=null)
			{
				out.println("合作伙伴："+doc.getRootElement().attributeValue("partnerid")+"<br/>");
				out.println("产品名称："+doc.getRootElement().attributeValue("productName")+"<br/>");
				out.println("产品版本："+doc.getRootElement().attributeValue("productVersion")+"<br/>");
				out.println("规则版本："+doc.getRootElement().attributeValue("configVersion")+"<br/>");
				out.println("Build Id："+doc.getRootElement().attributeValue("productBuildId")+"<br/>");
				out.println("服务器MAC："+doc.getRootElement().attributeValue("mac")+"<br/>");
				out.println("磁盘序列号："+doc.getRootElement().attributeValue("diskSerial")+"<br/>");
				out.println("有效日期："+doc.getRootElement().attributeValue("validDate")+"<br/>");
				out.println("允许应用数："+doc.getRootElement().attributeValue("maxConfig")+"<br/>");
			}
		%></td>
    </tr>
</table>
 <div></div>
</div>
</body>
</html>
