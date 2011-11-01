<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import ="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import ="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>    
    <title>发送设置短信</title>
   <script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
  <!-- common.js 通用js调用 -->
	<script language="javascript" src="../scripts/common.js"></script>
	<!-- css.css 通用css调用 -->
	<link href="../theme/css.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>		
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
		<script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		
				<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript">
		var userid = '<%=request.getParameter("uid")%>';
		var threebind = '<%=com.dheaven.mip.util.Constants.ema_need_threebind%>';
		window.onload=function(){
		  
		  User2.getthreebindInfo(userid,
					function(config){
						dwr.util.setValues(config);
						if(threebind==1){
                        $('showimsi').style.display="none";
						}else if(threebind==2){
						 $('showimei').style.display="none";
						}
						
					}
				);
		}
		
		function bindthree(){
			if(!<%=Constants.canopthreebind %>){
				parent.parent.GB_CURRENT.hide() ;
			}else{
				 User2.threebind(userid,$('imsi').value,$('imei').value,
				{
					callback:function(otext) {
						if(otext=='1'){
							parent.parent.DHalert("手机相关信息绑定成功！");
							parent.parent.GB_CURRENT.hide()
						}else{
							DHalert(otext);
						}
					},
					errorHandler:function(errorString, exception) {
						CloseProgress();
					    DHalert("绑定失败，失败原因："+errorString);
					}
				});
			}
		}
	
</script>
</head>
  
<body>
	 <table width="100%" " border="0" align="center"	cellpadding="0" cellspacing="0">
	  <tr id="showimei">
	 <td><span class="blue_12">手机设备信息：</span></td>
	 <td><input type="type" id="imei" value="" maxlength="100"/></td>
	 </tr>
	 <tr id="showimsi">
	 <td><span class="blue_12">手机卡信息：</span></td>
	 <td><input type="type" id="imsi" value="" maxlength="100" /></td>
	 </tr>
	 <tr><td colspan="2" align="center"><input type="button" id="checkimsi" class="button_2" value="提交" onclick="javascript:bindthree();"/> </td></tr>
	 </table>

  </body>
</html>
