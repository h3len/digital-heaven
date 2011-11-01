<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加企业业务系统额限</title>
		<script type="text/javascript">
	 	   var GB_ROOT_DIR = "../skin/";
	 	</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
<script type="text/javascript">
		var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		var pageid = "<%=request.getParameter("pageid")%>";
		window.onload = function(){
			
			getAppLimit(enterpriseid);
		}
		
		
		
		function getAppLimit(){
			EnterpriseAction.findMipAppConfig(enterpriseid,{
				callback:function(oMap) {
							dwr.util.setValues(oMap);
						},
						errorHandler:function(errorString, exception) {
							CloseProgress();
						    DHalert("获取企业业务系统额限失败，失败原因："+errorString);
						}
			});
		}
		function saveAppLimitCount(){
			var limitcounts = "";
			var cf = new CheckForm();
			if(cf.Trim($("limitcount").value)==""){
				DHalert("请输入企业业务系统额限！");
				return false;
			}
			if(!cf.IsNumber($("limitcount").value)&&cf.Trim($("limitcount").value)!="0"&&cf.Trim($("limitcount").value)!="不限制"){
				DHalert("企业业务系统额限必须为数字！");
				return false;
			}
			if(cf.Trim($("limitcount").value)<0){
			DHalert("企业业务系统额限必须大于等于0");
			return false;
			}
			limitcounts = cf.Trim($("limitcount").value);
			if(cf.Trim($("limitcount").value)=="不限制"){
				limitcounts = "0";
			}
			EnterpriseAction.createLimitedApps(enterpriseid,limitcounts,{
				callback:function(oData){
					if(oData=="1"){
						parent.parent.DHalert("企业业务系统额限添加成功!");
						parent.parent.ChangePage(pageid);
						parent.parent.GB_CURRENT.hide();
					}
				},
				errorHandler:function(errorString, exception) {
				    DHalert("企业业务系统额限添加失败，失败原因："+errorString);
				}
			});
		}
		
</script>
</head>
<body>
<div class="up_title">
			<span class="href_14px_blue">企业业务系统额限 &gt;&gt; 添加企业业务系统额限</span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					企业业务系统额限
				</td>
				<td width="71%">
					<input type="text" value="" id="limitcount" maxlength="6"/>&nbsp;&nbsp;&nbsp;&nbsp;<span style = "color:red">输入0或输入汉字“不限制”代表没有限制</span>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					已接入企业业务系统数
				</td>
				<td width="71%" id="consumeapp">
				</td>
			</tr>
		</table>
		<div style="text-align:center">
			<input type="button" onclick="saveAppLimitCount();" id="BtnOK" value="确认"> 
			<input type="button" onclick="parent.parent.GB_CURRENT.hide()" value="关闭"/>
		</div>
</body>
</html>