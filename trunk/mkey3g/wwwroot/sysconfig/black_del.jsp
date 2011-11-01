<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>黑白名单：添加新用户</title>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/Mas2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!-- 新的时间控件 -->
		<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="../skin/calendar/lang/calendar-zh.js"></script>
		<link href="../skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="../skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="../skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
<script type="text/javascript">
var id='<%=request.getParameter("id")%>';
var enterpriseid='<%=request.getParameter("enterpriseid")%>';
function delmobile(){
	if($('efftime').value.Trim()==""){
			DHalert("请选择生效时间！");
			return false;
		}
	Mas2.deleBlackWhite(enterpriseid,id,$('efftime').value,
				{	
					callback:function(otext) {
							if(otext==1){
								DHalert("删除操作成功！");
								parent.parent.getWbList();
								parent.parent.GB_CURRENT.hide();
							}else{
								DHalert(otext+"！");
							}
					},
					errorHandler:function(errorString, exception) {
						DHalert(errorString);														
					}
				});
}
	
function remove86(num){
	if(num.indexOf("+")==0)
		num=num.substr(1);
	if(num.indexOf("86")==0)
		num=num.substr(2);
	return num;
}
	
function changeType(checktype){
	for(i=0;i<4;i++){
		if(i==checktype)
			$("checktype_"+i).style.display="";
		else
			$("checktype_"+i).style.display="none";
	}
}
</script>
</head>
<body>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					生效日期
				</td>
				<td width="71%">
					<input type="text" name="date2" id="efftime" size="30" onpaste="return false" onkeydown="return false"/>
														<img alt='从日历选择'
															src='../skin/calendar/themes/icons/calendar2.gif'
															border='0' id='end'
															onmouseover="this.style.cursor='pointer'"
															onmouseout="this.style.cursor='default'" />

														<script type="text/javascript">
														var cal2 = new Zapatec.Calendar.setup({
														
														inputField     :    "efftime",     // id of the input field
														singleClick    :     false,     // require two clicks to submit
														ifFormat       :    '%Y-%m-%d',     // format of the input field
														showsTime      :     true,     // show time as well as date
														button         :    "end"  // trigger button 
												
														});
														</script>
				</td>
			</tr>
		</table>
		<div style="text-align:center"><input type="button" onclick="delmobile();" class="button_2" id="BtnOK" value="确认">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="button"  class="button_2" value="取消" onclick="parent.parent.GB_CURRENT.hide()" /></div>
</body>
</html>