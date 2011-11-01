<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.dataaccess.vo.MipSysuser"%>
<%
String ctcc="none";
String admin="none";
if(MipSysuser.USR_LOGIN_TYPE_ENMANAGER==(Integer)session.getAttribute("loginport"))
		admin="";
if(MipSysuser.USR_LOGIN_TYPE_CTCCMANAGER==(Integer)session.getAttribute("loginport"))
		ctcc="";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>业务日志</title>
<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
<script language="javascript" src="../skin/common.js"></script>
<link href="../skin/common.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
<!--GrayBox-->
<script type="text/javascript" src="../skin/AJS.js"></script>
<script type="text/javascript" src="../skin/AJS_fx.js"></script>
<script type="text/javascript" src="../skin/gb_scripts.js"></script>
<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
<!-- Dwr Js -->
<script src="../dwr/interface/BusinessLogs.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<!--ExtJs-->
<LINK href="../skin/ext-all.css" type=text/css rel=stylesheet />
<SCRIPT src="../skin/ext-base.js" type=text/javascript></SCRIPT>
<SCRIPT src="../skin/ext-all.js" type=text/javascript></SCRIPT>
<!-- prototype -->
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/xmlextend.js"></script>
<script language="javascript" type="text/javascript" src="../datepicker/WdatePicker.js"></script>
<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css" />
<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled" />
<!-- 新的时间控件 -->
<script type="text/javascript" src="../skin/calendar/calendar.js"></script>
<script type="text/javascript" src="../skin/calendar/lang/calendar-zh.js"></script>
<link href="../skin/calendar/css/zpcal.css" rel="stylesheet" type="text/css" />
<link href="../skin/calendar/websiskin/calendar/themes/winxp.csssheet" type="text/css" />
<link href="../skin/calendar/themes/system.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
/*

	by wl
*/
	function search(){
		if(!$F('starttime')==''&&!parent.parent.CheckDateTime($('starttime').value)){
			parent.parent.DHalert('起始时间格式不正确');
			return false;
		}
		if($F('starttime')==""&&$F('endtime')!=""){
			parent.parent.DHalert('起始时间为空，请输入起始时间');
			return false;
		}
		if(!$F('endtime')==''&&!parent.parent.CheckDateTime($('endtime').value)){
			parent.parent.DHalert('结束时间格式不正确');
			return false;
		}
		if($F('starttime')!=""&&$F('endtime')==""){
			//Ext.MessageBox.alert('输入错误', '终止时间',failmethod());
			parent.parent.DHalert('结束时间为空，请输入结束时间');
			return false;
		}
		//if($F('starttime')!=""&&$F('endtime')!=""){
		//	if($F('starttime')>=$F('endtime')){
		//		parent.parent.DHalert('起始时间不能晚于或等于结束时间');
		//		return false;
		//	}
		//}
	
		var searchrole="enterprise="+rp($F('enterprise'))
											+",to="+$F('to')
											+",starttime="+$F('starttime')
											+",endtime="+$F('endtime')
										+",type="+$F('type');
		parent.parent.pageid=1;	
		parent.parent.search(searchrole);
										
	}
</script>
</head>
<body style="width:620px;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

  <table width="620" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr style="display:<%=ctcc%>">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%" >
					企业名称
				</td>
				<td width="71%">
					<input name="text" type="text" id="enterprise" class="input_180px"
						tabindex="1" onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)"  />
				</td>
			</tr>
				
			<tr style="display:<%=admin%>">
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					目标用户
				</td>
				<td width="71%">
					<input name="text" type="text" id="to" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)"  />
				</td>
			</tr>
  			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					起始时间：
				</td>
				<td width="71%">
							<input type="text" name="date2" id="starttime" size="30" />
							<img alt='从日历选择' src='../skin/calendar/themes/icons/calendar2.gif' border='0' id='start'  onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" />


					<script type="text/javascript">
							var cal1 = new Zapatec.Calendar.setup({
							
							inputField     :    "starttime",     // id of the input field
							singleClick    :     false,     // require two clicks to submit
							ifFormat       :    '%Y-%m-%d %H:%M:00',     // format of the input field
							showsTime      :     true,     // show time as well as date
							button         :    "start"  // trigger button 
					
							});
		
					</script>
					
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					结束时间：
				</td>
				<td width="71%">
						
						<input type="text" name="date2" id="endtime" size="30" />
							<img alt='从日历选择' src='../skin/calendar/themes/icons/calendar2.gif' border='0' id='end'  onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" />

							<script type="text/javascript">
							var cal2 = new Zapatec.Calendar.setup({
							
							inputField     :    "endtime",     // id of the input field
							singleClick    :     false,     // require two clicks to submit
							ifFormat       :    '%Y-%m-%d %H:%M:00',     // format of the input field
							showsTime      :     true,     // show time as well as date
							button         :    "end"  // trigger button 
					
							});
		
						</script>
				</td>
			</tr>
			<tr>
				<td width="3%" >
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					类型
				</td>
				<td width="71%">
						<select name="apptype" id="type" class="input_180px"
						 onfocus="fEvent('focus',this)"
						onblur="fEvent('blur',this)"
						onmouseover="fEvent('mouseover',this)"
						onmouseout="fEvent('mouseout',this)"
						>
						<option value="">任意</option>
						<option value="ip-push">ip push</option>
						<option value="web-push">web push</option>
						<option value="sms-push">明文短信</option>
						<option value="mms-push">彩信</option>
						<option value="wap-push">wap push</option>
						<option value="mail-push">邮件</option>
						<option value="emn-push">激活短信</option>
					</select>
				</td>
			</tr>
  <tr>
			<td colspan="3">
				<div class="div_center"><input type="image" src="../skin/default/images/button_search.gif" width="60px" height="22px" onclick="javascript:search();return false;" style="float:rigth"/></div>
			</td>
		</tr>
  
  
  </table>
</body>
</html>
