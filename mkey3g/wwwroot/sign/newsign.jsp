<%@ page contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.dheaven.mip.config.*"%>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<!-- css.css 通用css调用 -->
<link href="theme/css.css" rel="stylesheet" type="text/css" />
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<script language="javascript" src="../skin/common.js"></script>
<script src="../scripts/prototype.js" type="text/javascript"></script>
<script src="../scripts/transferxml.js" type="text/javascript"></script>

<script type="text/javascript">

	var path =decodeURIComponent(location.href);
    var type = "";
    if( path.indexOf("?") > -1)
    {
	    path = path.substring(path.lastIndexOf("?")+1);
	    if( path.indexOf("=") > -1)
	    {
	    	type = path.substring(path.lastIndexOf("=")+1);
	    }
    }


function signedfile(){

	if($F('signmessage')==''){
		alert('签名内容不能为空！');
		return false;
	}
	User2.signReq($F('signmessage'),
				{	
					callback:function(otext) {
							if(otext==1){
								alert("签名成功！请重新登录");
								if(type==1){
									location.href='../default_ecmanager.jsp';
								}else{
									location.href='../default_user.jsp';
								}
							}else{
								alert("签名失败！失败原因："+otext);
							}
					}
				});
}
	
</script>
</head>
<body>

<div style="background-color:#FEFAEE;border-top:1px solid #E6E6CE;border-bottom:1px solid #E6E6CE;margin-top:5px;text-align:center;">
<h1>MKey 3G服务器签名</h1>
</div>

<div style="margin-top:10px">
  <table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="20%" style="font-weight:bolder;">
					第一步：下载签名文件<br/>
				</td>
				<td width="80%">
					<a href="../masuser.do?action=downloadsign" >签名文件</a>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td style="font-weight:bolder;">
					第二步：输入签名信息
				</td>
				<td>
					<textarea id="signmessage" style="bolder-top:2px #ff0000 solid; word-break:break-all;width:100%;height:400px"></textarea>
				</td>
			</tr>
 			 <tr>
				<td colspan="3">
					<div style="text-align:center"><input type="button" value="确认激活系统 " onclick="signedfile()"/><input type="button" onclick="javascript:$('signmessage').value=''" value="重置输入框 " /> </div>
				</td>
				
			</tr>
  </table>
  </div>
</body>
</html>
