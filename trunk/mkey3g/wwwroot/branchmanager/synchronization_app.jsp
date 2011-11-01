<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>企业业务系统同步</title>
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
		var appid = '<%=request.getParameter("appid")%>';
		var pageid = '<%=request.getParameter("pageid")%>';
		window.onload = function(){
			showsynserialnum();
		}
		
		
		function showsynserialnum(){
			EnterpriseAction.showsynserialnum(appid,
				function(data){
					dwr.util.setValues(data);
				}
			);
		}
		
		function synapp(){
			var cf = new CheckForm();
			if(cf.Trim($("serialnum").value)==""){
				DHalert("请输入业务系统序列号！");
				return false;
			}
			if(cf.Trim($("serialnum").value).length!=32){
				DHalert("业务系统序列号固定为32位！");
				return false;
			}
			Ext.Msg.confirm('系统提醒您', '您确定要正式上线？',function(btn)
			{
			if(btn == 'yes')
			{
			Progress('正在同步...','');
			EnterpriseAction.synAppBySerialnum(appid,cf.Trim($("serialnum").value),{
				callback:function(oData){
					if(oData=='1'){
						CloseProgress();
						parent.parent.DHalert("业务系统上线完成！");
					}else{
						CloseProgress();
						parent.parent.DHalert(oData);
					}
					//parent.parent.ChangePage(pageid);
					//parent.parent.GB_CURRENT.hide()
				},
				errorHandler:function(errorString, exception) {
					CloseProgress();
				    DHalert("同步业务系统失败，失败原因："+errorString);
				}
			});
				}
		});
		}
</script>
</head>
<body>
<div class="up_title" >
			<span class="href_14px_blue">业务系统上线</span>
		</div>
		<div class="up_subtitle">
			<span>输入序列号：</span>
		</div>
		<table  border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					序列号
				</td>
				<td width="71%">
				<input type="text" id="serialnum" class="input_text" maxlength="32"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" />
				</td>
			</tr>
		</table>
		<div style="text-align:center">
			<input type="button" onclick="javascript:synapp();"  id="BtnOK" value="确认"> 
		</div>
</body>
</html>