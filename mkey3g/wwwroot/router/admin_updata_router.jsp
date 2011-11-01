<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
	String username;
	if (request.getParameter("username") == null) {
		username = "";
	} else {
		username = new String(request.getParameter("username").getBytes("8859_1"), "utf-8");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加手机路由</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts_main.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<!-- Dwr Js -->
		<script src="../dwr/interface/RouterAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script type="text/javascript">
		 var id="<%=request.getParameter("id")%>";
		 var type=1;
		 var typeC="正则表达式";
	 var cf = new CheckForm()
	 
     	window.onload=function(){
    		RouterAction.getOneRouter(id,
			{
				callback:function(data){
					dwr.util.setEscapeHtml(false);
				   	dwr.util.setValues(data); 
				   	type=data["type"];
				   	if(type==1){
				   		typeC="手机号码";
				   		$("regularT").style.display="none";
				   	}else{
				   		$("regular").style.display="none";
				   		$("regularT").style.display="";
				   		$("regularT").value=data["regular"];
				   	}
				   		
				   	$("typeContent").innerHTML=typeC+":";
				},
				errorHandler:function(errorString,exception){
					DHalert("操作失败,失败原因: "+exception.message);
				}
            });
        }


//修改Router
     function updateMobiletype()
     {
     	var regular = cf.Trim($('regular').value);
     	if(type==0){
     		regular = cf.Trim($('regularT').value);
     	}
      if(regular ==""){
				DHalert(typeC+"不能为空! ");
				return false;
     	}
     if(type==1&&!cf.IsTel(regular)){
     			DHalert("手机号码格式不对 ！");
				return false;
     }
     if(type==0&&regular.length>200){
     			DHalert("正则表达式字数不能超过200 ！");
				return false;
     }
     
    
	Progress('正在发送数据到服务器....'); 
		if(type==1){
		     RouterAction.updataExactRouter(id,regular,$("operator").value,
					{
						callback:function(data){
							CloseProgress();
							parent.parent.closewindow(); 
						},
						errorHandler:function(errorString,exception){
							DHalert("操作失败,失败原因: "+exception.message);
						}
		            });
         }else{
         	RouterAction.updataFuzzyRouter(id,regular,
					{
						callback:function(data){
							CloseProgress();
							parent.parent.closewindow(); 
						},
						errorHandler:function(errorString,exception){
							DHalert("操作失败,失败原因: "+exception.message);
						}
		            });
         }
     }
</script>
	</head>
	<body
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<!-- 内容开始 -->
		<table width="50%" align="center">
			<tr>
				<td>
					<span class="href_12px_blue_bold">运营商:</span>
				</td>
				<td>
					<select id="operator" style="width: 130px">
						<option value="0">
							移动
						</option>
						<option value="1">
							电信
						</option>
						<option value="2">
							联通
						</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<span class="href_12px_blue_bold">路由方式:</span>
				</td>
				<td>
					<span class="href_12px_blue_bold" >
					<input type="text" id="typename" maxlength="20" style="width:130px"
						class="input_text input_180px" disabled="disabled"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
						onmouseout="fEvent('mouseout',this)" />
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="href_12px_blue_bold" id="typeContent"></span>
				</td>
				<td>
					<input type="text" id="regular" maxlength="50" style="width:130px"
						class="input_text input_180px"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
						onmouseout="fEvent('mouseout',this)" />
					<textarea  id="regularT"  cols="20" rows="7" style="display:none"
						onmouseover="fEvent('mouseover',this)"
						onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
						onmouseout="fEvent('mouseout',this)" ></textarea>
				</td>
			</tr>
		</table>
		<table width="50%" align="center">
			<tr>
				<td align="center">
					<input type="button" id="com" class="button_2" value="提交"
						onclick="javascript:updateMobiletype()">
				</td>
			</tr>
		</table>
	</body>
</html>
