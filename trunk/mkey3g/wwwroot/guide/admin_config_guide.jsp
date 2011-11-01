<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%
session.setAttribute(Constants.CONFIG_GUIDE,true);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>配置向导</title>
		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<script language="javascript" src="../skin/common.js"></script>
		<script src="../dwr/interface/EnterpriseAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
	var pageid = 1;
		   //初始化
		 	window.onload=function(){
				 showprofessioncode();
				 document.getElementById("comment").innerHTML  = "<span style=\"color:red\"><b>备注</b><ul style=\"margin-left:30px\"><li>1.集团业务码由2位字母组成，作为本集团所有业务系统ID的前缀</li><li>2.集团业务码初始化完成后，不允许修改</li></ul></span>";
 			}
		function showprofessioncode(){
		 	 EnterpriseAction.showprofessioncode({
						callback:function(data) {
							dwr.util.setValues(data);
							if(data["updateenable"]=="1"){
								$("professioncode").disabled = true;
							}else{
								$("professioncode").disabled = false;
							}
							check();
						},
						errorHandler:function(errorString, exception) {
						    DHalert("获取业务代码失败，失败原因："+errorString);
						}
					});
		  }
		  
		 function saveprofessioncode(){
		  		var cf = new CheckForm();
		  		if(cf.Trim($("professioncode").value)==""){
		  			DHalert("请输入集团业务码！");
		  			return false;
		  		}
		  		var code=/^[A-Za-z]{2}$/;
		  		if(code.test(cf.Trim($("professioncode").value))==false){
		  		DHalert("集团业务码必须由2位字母组成!");
		  		return false;
		  		}
				EnterpriseAction.createprofessioncode($("professioncode").value,{
	  				callback:function(data) {
	  					if(data=="1"){
	  						window.location.href="../guide/admin_apps_guide.jsp";
	  					}else if(data=="0"){
	  						showprofessioncode();
	  						DHalert("存在可用业务系统,不能修改集团业务码！");
	  					}
					},
					errorHandler:function(errorString, exception) {
					    DHalert("设置集团业务码失败，失败原因："+errorString);
					}
 				});
		  }
		  
		function check(){
			if($("professioncode").value.trim()==""){
		  		$("next").disabled=true;
		  		$("next2").disabled=true;
		  	}else{
		  		$("next").disabled=false;
		  		$("next2").disabled=false;
		  	}
		}
		
		var sp;
		function skip(sp){
			window.location.href="../guide/admin_apps_guide.jsp";
		}
	</script>
	</head>
	<body>

		<div class="up_subtitle">
			<span>集团业务码设置</span>
		</div>
		<table width="100%" align="center" cellpadding="0" cellspacing="5"
			id="baseinfoconfig" >
			<tr>
				<td>
					<fieldset>

						<table width="60%" border="0" align="center" cellpadding="0"
							cellspacing="5">
							<tr>
								<td colspan="3" class="text_icon2">
									<span class="href_14px_blue">集团业务码：</span>
								</td>
								<td colspan="3">
									<input type="text" onblur="check()" id="professioncode" class="input_text" maxlength="2"
											onmouseover="fEvent('mouseover',this)"
											onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
											onmouseout="fEvent('mouseout',this)" size="9"  />
								</td>
							</tr>
						</table>


						<div class="center_nav_line"></div>
						<div class="div_center padding_5">
							<input id="next" type="button" class="button_3" value="下一步" 
								onclick="saveprofessioncode()" />
							<input type="button" class="button_2" value="跳过" id="next2" 
								onclick="skip('0')"  />
						</div>
					</fieldset>
				</td>
			</tr>
		</table>
		<span id="comment" style="color:red">
	</body>
</html>