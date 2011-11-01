<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>修改业务系统</title>
		<script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 	</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var appid = '<%=request.getParameter("appid")%>';
		var pageid = '<%=request.getParameter("pageid")%>';
		window.onload=function(){
				getclientapp(enterpriseid,appid);
		}
		function modClientApp(){
			var cf = new CheckForm();
			if(cf.Trim($("appname").value)==""){
				DHalert("请输入业务系统名称！");
				return false;
			}
			if(cf.Trim($("appcode").value)==""){
				DHalert("请输入业务系统ID！");
				return false;
			}
			if(cf.Trim($("encode").value)==""){
				DHalert("请输入企业代码！");
				return false;
			}
			var nickname = cf.Trim($("nickname").value);
			if(!IsURL(nickname)){
				DHalert("请输入正确的域名！");
				return false;
			}
			MipClientAppAction.updateEnterpriseApp(enterpriseid,cf.Trim($("appcode").value),cf.Trim($("appname").value),appid,cf.Trim($("encode").value),nickname,{
				callback:function(oData){
					if(oData=="1"){
						parent.parent.DHalert("修改业务系统成功");
						parent.parent.ChangePage(pageid);
						parent.parent.GB_CURRENT.hide()
					}
				},
				errorHandler:function(errorString, exception) {
				    DHalert("修改业务系统失败，失败原因："+errorString);
				}
			});
		}
		function getclientapp(enterpriseid,appid){
			MipClientAppAction.findMipClientApp(enterpriseid,appid,{
				callback:function(oMap) {
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取系统业务失败，失败原因："+errorString);
						}
			});
		}
		
		function IsURL(str_url){ 
				if(str_url==null || str_url==""){
					return true;
				}
		        var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
		        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
		        + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
		        + "|" // 允许IP和DOMAIN（域名） 
		        + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
		        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
		        + "[a-z]{2,6})" // first level domain- .com or .museum  
		        + "(:[0-9]{1,4})?" // 端口- :80  
		        + "((/?)|" // a slash isn't required if there is no file name  
		        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
		        var re=new RegExp(strRegex);  
		        if (re.test(str_url)){ 
		            return (true);  
		        }else{  
		            return (false);  
		        } 
		    }
</script>
	</head>
	<body>
		<div class="up_title">
			<span class="href_14px_blue">企业业务系统&gt;&gt; 修改业务系统</span>
		</div>
		<div class="up_subtitle">
			<span>业务系统信息：</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统名称
				</td>
				<td width="71%">
					<input type="text" maxlength="20" value="" id="appname" />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统ID
				</td>
				<td width="71%">
					<input type="text" value="" id="appcode" disabled />
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					域名
				</td>
				<td width="71%">
					<input type="text" value="" id="nickname" />
				</td>
			</tr>
			<tr style="display: none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					企业代码
				</td>
				<td width="71%">
					<input type="text" value="" id="encode" disabled />
				</td>
			</tr>
			<tr class="height25" style="display: none">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					业务系统运行状态
				</td>
				<td width="71%" id="appstatus">
				</td>
			</tr>
		</table>
		<div style="text-align: center">
			<input type="button" onclick="javascript:modClientApp();" id="BtnOK"
				value="修改">
		</div>
	</body>
</html>