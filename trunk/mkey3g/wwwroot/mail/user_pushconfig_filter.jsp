<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>

<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>PUSH时间设置</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />

		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<link type="text/css" rel="stylesheet" href="css.css" />

		<!-- Dwr Js -->
		<script src="../dwr/interface/PushFilter.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>

		<script language="javascript" type="text/javascript">
		//公共变量
		var progressBar;
		var currentMsgId=0 ;
		var pageid =1;
	
		function jsTrim(s) {return s.replace(/(^\s+)|(\s+$)/g, "");}
		function addnew() {
		
		if($("s_msg").value=="" && $("s_content").value!=4 && $("s_mode").value!=3)
		{
		  DHalert("请输入内容");
		  $("s_msg").focus();
		  return false;
		}
		
		
		if($("s_content").value == 3 && $("s_msg").value.indexOf("e")>-1)
		{
		    DHalert("请不要按科学计数法输入数据");
		    $("s_msg").focus();
		    return false;
		}
		 if($("s_content").value == 3 && checkobjmunber($("s_msg"),0)==false)
		{
		  DHalert("请输入大于0的整数");
		  $("s_msg").focus();
		  return false;
		}
	
		var isok = false;
	        if($("s_content").value==1 && $("s_mode").value==3)
	        {
	          Filterform.submit();
	          return;
	        }
	
	        if($("s_content").value==4)
	        {
	          Filterform.submit();
	          return;
	        }
	
		if ($("s_msg").value == "" && $("s_content").value != 3 && ($("s_mode").value == 1 || $("s_mode").value == 2))
			isok = true;
	
		if ($("s_msg").value != "" && $("s_content").value != 4)
			isok = true;
		if (isok == true)
		{
			if ($("s_content").value != 4)
			{
				Filterform.submit();
			}
			else
			{
				if ($("s_msg").value >= 0)
					Filterform.submit();
			}
		}
	}
	
	function add_s_mode(a_value, a_text)
	{
		var oOption = document.createElement("OPTION");
		oOption.text = a_text;
		oOption.value = a_value;
		document.all?$("s_mode").add(oOption):$("s_mode").appendChild(oOption);
	}
	
	function checkobjmunber(objtxt,izero){
	
		var chname;
		if (typeof(objtxt.chname)=="undefined"){
			chname = "内容";
		}
		else{
			chname = jsTrim(objtxt.chname)
			if (chname==""){chname = "内容";}
		}
	
		objtxt.value=jsTrim(objtxt.value);
		if (isNaN(parseFloat(objtxt.value))){
			//alert(chname + "不是有效数字！");
			objtxt.focus();return false;
		}
		objtxt.value=parseFloat(objtxt.value)
		if (izero>0){
			if(!(parseFloat(objtxt.value)>0)){
				//alert(chname + "需大于零！");
				objtxt.focus();return false;
			}
		}
		else if (izero>=0){
			if(!(parseFloat(objtxt.value)>=0)){
				//alert(chname + "需大于等于零！");
				objtxt.focus();return false;
			}
		}
		return true;
	}
	
	function select_content_onchange()
	{
		var i = 0;
		$('size').innerText="";
		for (i; i < $("s_mode").length; i++){
			$("s_mode").remove(i);
			i--;
		}
	
		if ($("s_content").value == "1")
		{
	          $("s_msg").style.display = "";
			add_s_mode("1", "包含");
			add_s_mode("2", "不包含");
	                add_s_mode("3", "为空");
		}
	    else if ($("s_content").value == "2")
		{
	                $("s_msg").style.display = "";
			add_s_mode("1", "包含");
			add_s_mode("2", "不包含");
		}
		else if ($("s_content").value == "3")
		{
	        $("s_msg").style.display = "";
			add_s_mode("3", "大于");
			add_s_mode("4", "小于");
			$('size').innerText="KB";
			
		}
		else if ($("s_content").value == "4")
		{
	         
	        $("s_msg").style.display = "none";
	        add_s_mode("5", "重要");
			add_s_mode("6", "普通");
			add_s_mode("7", "不重要");
		}
		$('s_msg').value="";
	}
	
	function s_mode_change()
	{
		if($("s_content").value=="3")//这是邮件大小
		{
			 $("s_msg").style.display="";
			 return;
		}
		if($("s_mode").value=="3" || $("s_mode").value=="5" || $("s_mode").value=="6" || $("s_mode").value=="7")
		{
		$("s_msg").value="";
		$("s_msg").style.display="none";
		}
		else
		{
		$("s_msg").style.display="";
		}

	}
	
	function del(delid)
	{
		if(confirm("确认要删除该规则吗？"))
		{
			location.href="admin_push_filter.aspx?delid="+delid;
		}
	}
	/*--------------------------------------------------------------
		功能：保存规则
	--------------------------------------------------------------*/
	
	function Save(){

		
		if($("s_msg").value=="" && $("s_content").value!="4" && $("s_mode").value!="3")
		{
		  DHalert(" 请输入内容！！！ ");
		  $("s_msg").focus();
		  return false;
		}
	
		if($("s_content").value == "3" && $("s_msg").value.indexOf("e")>-1)
		{
		    DHalert("请不要按科学计数法输入数据！");
		    $("s_msg").focus();
		    return false;
		}
		
		var reg=/^\d+$/;
		if($("s_content").value == "3" && $("s_msg").value<=0){
		  DHalert("请输入大于0的整数！");
		  $("s_msg").focus();
		  return false;
		}
		
		if($("s_content").value == "3" && !reg.test($('s_msg').value)){
		  DHalert("请输入大于0的整数！");
		  $("s_msg").focus();
		  return false;
		}
		
		//限制邮件大小为10M
		if(10240 < $('s_msg').value){
		  	DHalert("邮件大小不能超过10M！");
			  $("s_msg").focus();
			  return false;
		}


		//开始保存数据
		Progress('正在保存数据....','邮箱设置中');
			
			PushFilter.saveFilter($('s_content').value,$('s_mode').value,$('s_deal').value,$('s_msg').value,
					function(data){
							CloseProgress();
							if(data=='2'){
							   DHalert("邮箱过滤规则已存在,请重新设置！");
							   return;
							}
							if(data == "1"){
								
								DHalert("操作成功！");
								LoadFilterList();
							}else{
								DHalert("操作失败，失败原因："+data);
							}
							
					});
	}

	/*--------------------------------------------------------------
		功能：载入邮件过滤列表
	--------------------------------------------------------------*/
	
	function LoadFilterList(){
				Progress("正在载入数据...","邮箱配置");
				PushFilter.loadFilterList(pageid,
					function(objXml){
					CloseProgress();
					try{
			  			  document.getElementById("list").innerHTML = "";
						DisplayTransformedXML(1, objXml, "../xslt/mailfilter_list.xsl",document.getElementById("list"));
							
					}catch(err){
						DHalert(errorMessage);
					}
				});		

	}
	window.onload=function(){
		LoadFilterList();
	}
	/*--------------------------------------------------------------
		功能：删除
	--------------------------------------------------------------*/
	function FilterDelete(id){
		Ext.Msg.confirm(nowtitle, '确定删除该过滤规则吗？', function(btn){
			if(btn=='yes'){
				Progress("正在发送数据到服务器...","邮箱配置");
				PushFilter.delFilter(id,
				 	function(data){
				 	CloseProgress();
				 	if(data == "1"){
					 	LoadFilterList();
				 	}else{
				 		DHalert(data);
				 	}
				 	});
				 	return;
			}
			//return;
    	});
	}
	

	function ChangePage(pid){
		pageid=pid;
		LoadFilterList();
	}
</script>
	</head>
	<body>

		<!-- 内容开始 -->
		<div align="center">

			<form name="Filterform" id="Filterform">
				<table width="100%" align="center" cellspacing="0" bgcolor="#f8f8f8"
					style='BORDER: #8ca5b5 1px solid; margin-top: 10px;'>

					<input type="hidden" id="issave" name="issave" value="1" />
					<tr>
						<td height="30" align="left" nowrap>
							<div style="Z-INDEX: 9">
								&nbsp;
								<span class="href_12px_red_bold">第1步:</span>&nbsp;
								<select id="s_content" name="s_content"
									onchange="javascript:select_content_onchange()">
									<option value="1" selected>
										邮件主题
									</option>
									<option value="2">
										发件人
									</option>
									<option value="3">
										邮件大小
									</option>
									<option value="4">
										优先级
									</option>
								</select>
								<select name="s_mode" id="s_mode" class="drpdwn"
									onchange="javascript:s_mode_change()">
									<option value="1" selected>
										包含
									</option>
									<option value="2">
										不包含
									</option>
									<option value="3">
										为空
									</option>
								</select>
								<input type="text" id="s_msg" name="s_msg" maxlength="30"
									class="input_text input_120px"
									onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)"></input>
								<span id="size" style="COLOR: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td height="30" align="left" nowrap>
							&nbsp;
							<span class="href_12px_red_bold">第2步:</span>&nbsp;
							<select id="s_deal" name="s_deal">
								<option value="4" selected>
									不推送
								</option>
								<option value="2" selected>
									不提醒
								</option>
								<option value="1">
									直接删除
								</option>
							</select>
							&nbsp;&nbsp;&nbsp;
							<input type="button" class="button_5" ID="btnOK" value="创建新规则"
								onclick="javascript:Save();" />
						</td>
					</tr>
				</table>
				<div id="list" style="height: 330px; overflow: auto;"></div>
				<br />
				<table width="99%" border="0" align="center" cellspacing="0"
					bgcolor="#EEEEEE" style='BORDER-TOP: #8ca5b5 1px solid'>
					<tr>
						<td colspan="2" height="10">
						</td>
					</tr>
					<tr style="display:none">
						<td width="15%" valign="top">
							&nbsp;
							<font color="#ff3333">&nbsp;邮件大小</font>
						</td>
						<td width="85%">
							您输入的邮件大小单位是"千字节(KB)".
							<br />
						</td>
					</tr>
					<tr>
						<td colspan="2" height="10"></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
