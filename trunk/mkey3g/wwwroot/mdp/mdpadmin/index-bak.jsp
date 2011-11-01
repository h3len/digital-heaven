<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.MipSysuserServiceImpl"%>
<%@ page import="com.dheaven.mip.config.ServerConfig"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out
		.print("<script>parent.location.href='../../default.jsp?url="
				+ request.getServletPath()
				+ "?"
				+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");
		if (!uid
		.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)) {
			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
			.getBean("permissionServiceImpl");
			if (ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmdp") == null) {
		out
				.print("<script>parent.location.href='../../default.jsp?url="
				+ request.getServletPath()
				+ "?"
				+ request.getQueryString()
				+ "'</script>");
		return;
			} else {
		java.util.List list = ps
				.findUserPrivacyByUserIDAndCategoryID(uid,
				"mipmdp");
		if (list == null || list.size() == 0) {
			out
			.print("<script>parent.location.href='../../default.jsp?url="
					+ request.getServletPath()
					+ "?"
					+ request.getQueryString()
					+ "'</script>");
			return;
		}
			}
		}
	}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>客户系统账号密码绑定</title>
		<script type="text/javascript" src="../../scripts/prototype.js"></script>
		<script type="text/javascript" src="../../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../../scripts/tabpane.js"></script>
		<script language="javascript" src="../../scripts/selall.js"></script>
		<script type="text/javascript" src="../../scripts/xtree.js"></script>
		<script type="text/javascript" src="../../scripts/xmlextend.js"></script>
		<script type="text/javascript" src="../../scripts/xmlextras.js"></script>
		<script type="text/javascript" src="../../scripts/xloadtree.js"></script>
		<link type="text/css" rel="stylesheet" href="../../css/xtree.css" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../../css/luna/tab.css" />
		<link type="text/css" rel="stylesheet" href="../../css/user.css" />

		<script type="text/javascript">
	/*
		@comment MDP配置关键界面，主要为管理员和普通用户绑定账号等操作
		@author yesun
		@date 2008-10-20
	*/
	
		var progressBar;
		function Init(){
		 	$('divExtCreate').style.display = "none";
			 //$('header').style.display = "";
			 $('main').style.display = "";
			 progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在载入数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getExtListByUser";
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: GetExtListByUser_CallBack}
		     );
		}
		function GetExtListByUser_CallBack(originalRequest){
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_list_of_oa.xsl",document.getElementById("main"));
			progressBar.Close();
		}
		
		//根据oa id，查询ext list 
		function query(){
			 var oaId = document.getElementById("oaid").value;
			 if(oaId.length==0){
			 	alert("请输入OA ID");
			 	return;
			 }
			 $('divExtCreate').style.display = "none";
			 //$('header').style.display = "";
			 $('main').style.display = "";
			 progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在载入数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getExtListOfOA&oa="+oaId;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: GetExtList_CallBack}
		     );
		}
		
		function GetExtList_CallBack(originalRequest){
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_list_of_oa.xsl",document.getElementById("main"));
			progressBar.Close();
		}
		//新建窗口展现,需要判断是管理员还是个人
		function loadCreateWin(){
			//$('header').style.display = "none";
			$('main').style.display = "none";
			$('divExtCreate').style.display = "";
			 progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在载入数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getEnterpriseListOfCurUser";
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: getEnterpriseListOfCurUser_CallBack}
		     );
			
		}
		function getEnterpriseListOfCurUser_CallBack(originalRequest){
			//<root><enterprise id="" name=""></enterprise><enterprise id="" name=""></enterprise></root>
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_create.xsl",document.getElementById("divExtCreate"));	
			progressBar.Close();
		}
		//新建提交
		function extCreate(){
			var newmipuser = document.getElementById("newmipuser").value;//mip登录用户名
			var newoauser = document.getElementById("newoauser").value;//oa登录用户名
			var newoapwd = document.getElementById("newoapwd").value;//oa登录密码
			var newoaid = document.getElementById("newoaid").value;//oaID
			var sysid = document.getElementById("sysid").value;//sysid
			var newmobile = document.getElementById("newmobile").value;// 手机号码
			if(newmipuser.length==0){
				alert("MIP登录用户名不能为空");return;
			}
			if(sysid.length==0){
				alert("系统ID不能为空");return;
			}
			if(newoauser.length==0){
				alert("系统登录用户名不能为空");return;
			}
			if(newoapwd.length==0){
				alert("系统登录密码不能为空");return;
			}
			if(newoaid.length==0){
				alert("企业ID不能为空");return;
			}
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在保存数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=createMdpExt&oa="+newoaid+"&sysid="+sysid+"&oauser="+newoauser+"&oapwd="+newoapwd+"&mipuser="+newmipuser+"&mobile="+newmobile;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: extCreate_CallBack}
		     );
		}
		function extCreate_CallBack(originalRequest){
			progressBar.Close();
			
			if(originalRequest.responseText-0==0){
				//返回0则成功
				alert("添加成功。");
				return loadCreateWin();
			}else{
				alert("添加失败。");
			}
			
		}
		//加载查看明细窗口
		function view(extid){
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在加载数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getMdpExt&id="+extid;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: loadViewWin_CallBack}
		     );
		}
		function loadViewWin_CallBack(originalRequest){
			//$('header').style.display = "none";
			$('main').style.display = "none";
			$('divExtCreate').innerHTML = "";			
			$('divExtCreate').style.display = "";
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_view.xsl",document.getElementById("divExtCreate"));
			progressBar.Close();
			
			
		}
		//加载更新窗口
		function loadUpdateWin(extid){
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在加载数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getMdpExt&id="+extid;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: loadUpdateWin_CallBack}
		     );
		}
		function loadUpdateWin_CallBack(originalRequest){
			//$('header').style.display = "none";
			$('main').style.display = "none";
			$('divExtCreate').innerHTML = "";			
			$('divExtCreate').style.display = "";
			var objXml = originalRequest.responseXML;
			DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_update.xsl",document.getElementById("divExtCreate"));
			progressBar.Close();
		}
		
		//如果用户已经设置，则修改
		function checkUser(){
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在加载数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=getMdpExtByUserId&userid="+document.getElementById("newmipuser").value;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: checkUser_CallBack}
		     );
		}
		function checkUser_CallBack(originalRequest){
			//$('header').style.display = "none";
			var objXml = originalRequest.responseXML;
			if(originalRequest.responseText.length > 0)
			{
			
				$('main').style.display = "none";
				$('divExtCreate').innerHTML = "";			
				$('divExtCreate').style.display = "";
			
				DisplayTransformedXML(1, objXml, "../../xslt/mdp_ext_update.xsl",document.getElementById("divExtCreate"));
			}
			progressBar.Close();
		}
		
		//执行更新提交
		function extUpdate(){
			var pk = document.getElementById("extPk").value;//mdpExtention pk
			var newmipuser = document.getElementById("newmipuser").value;//mip登录用户名
			var newoauser = document.getElementById("newoauser").value;//oa登录用户名
			var newoapwd = document.getElementById("newoapwd").value;//oa登录密码
			var newoaid = document.getElementById("newoaid").value;//oaID
			var sysid = document.getElementById("sysid").value;//sysid
			var newmobile = document.getElementById("newmobile").value;// 手机号码
			
			if(document.getElementById('modPwdTr1')&&document.getElementById('modPwdTr1').style.display==''){
				var newoapwd2 = document.getElementById("newoapwd2").value;//新oa登录密码
				var newoapwd2Confirm = document.getElementById("newoapwd2Confirm").value;// 确认密码	
				if(newoapwd2 .length==0){
					alert("新密码不能为空！");	
					return;
				}
				if(newoapwd2!=newoapwd2Confirm){
					alert("新密码和确认密码必须相同！");	
					return ;
				}
				newoapwd=newoapwd2;
				
			}
			if(sysid.length==0){
				alert("系统ID不能为空");return;
			}
			if(newmipuser.length==0){
				alert("MIP登录用户名不能为空");return;
			}
			if(newoauser.length==0){
				alert("系统登录用户名不能为空");return;
			}
			if(newoapwd.length==0){
				alert("系统登录密码不能为空");return;
			}
			if(newoaid.length==0){
				alert("企业ID不能为空");return;
			}
			
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在更新数据....");
			 var url = "../../mdpExt.do";
		     var pars = "action=updateMdpExt&id="+pk+"&oa="+newoaid+"&sysid="+sysid+"&oauser="+newoauser+"&oapwd="+newoapwd+"&mipuser="+newmipuser+"&mobile="+newmobile;;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: extUpdate_CallBack}
		     );
		}
		function extUpdate_CallBack(originalRequest){
			progressBar.Close();
			
			if(originalRequest.responseText-0==0){
				//返回0则成功
				alert("更新成功。");
				return query();
			}else{
				alert("更新失败。");
			}
			
		}
		//删除
		function del(extid){
			if(!confirm("确认要删除该MDP扩展用户么?")){
				return;
			}
			progressBar = new ProgressBar();
		     progressBar.isNeedProgressBar = true;
		     progressBar.SetStatus("正在删除数据....");
		      var url = "../../mdpExt.do";
		     var pars = "action=delMdpExt&id="+extid;
		     var myAjax = new Ajax.Request(
			     	url,
	    	     {method: 'post', parameters: pars, onComplete: del_CallBack}
		     );
		}
		function del_CallBack(originalRequest){
			progressBar.Close();			
			if(originalRequest.responseText-0==0){
				//返回0则成功
				alert("删除成功。");
				return Init();
			}else{
				alert("删除失败。");
			}
		}
		//打开选择mip用户的窗口
		function chooseMipUser(obj){
			var catId = document.getElementById('newoaid').value;
			if(catId .length==0){
				alert("所属集团不能为空！");
				return ;
			}
			var swidth = 350;
			var  sheight = 500;
			var l = ( screen.availWidth - swidth ) / 2;
    		var  t = ( screen.availHeight - sheight) / 2;      
			var winMipUserChooser = window.open("chooseMipUser.jsp?cat="+catId,"mipUserChooser",'left=' + l +',top=' + t 
+"toolbar=0,menubar=0,resizable=1,width="+swidth+",height="+sheight);
			
			//winMipUserChooser.moveTo(findPosY(obj),findPosX(obj));
		}
		//更新密码
		function extUpdatePwd(btn){
			if(document.getElementById('modPwdTr1').style.display=='none'){
				document.getElementById('modPwdTr1').style.display='';
				btn.value='取消';
				document.getElementById('modPwdTr2').style.display='';
			}else{
				document.getElementById('modPwdTr1').style.display='none';
				btn.value='修改密码';
				document.getElementById('modPwdTr2').style.display='none';
			}
		}
		////////////////////////////////////////////////////
		function findPosX(obj)
		  {
		    var curleft = 0;
		    if(obj.offsetParent)
		        while(1) 
		        {
		          curleft += obj.offsetLeft;
		          if(!obj.offsetParent)
		            break;
		          obj = obj.offsetParent;
		        }
		    else if(obj.x)
		        curleft += obj.x;
		    return curleft;
		  }
		
		  function findPosY(obj)
		  {
		    var curtop = 0;
		    if(obj.offsetParent)
		        while(1)
		        {
		          curtop += obj.offsetTop;
		          if(!obj.offsetParent)
		            break;
		          obj = obj.offsetParent;
		        }
		    else if(obj.y)
		        curtop += obj.y;
		    return curtop;
		  }
		  ///////////////////////////////////////////////
	</script>
		<style type="text/css">
	<!--
	body {
		background-image: url(images/bgg.gif);
	}
	-->
	</style>
	</head>

	<body bgcolor="#f8f8f8" onLoad="javascript:Init();">

		<div id="menu" style="width:156px; padding:0px;float:left;">
			<table width="156" border="0" align="center" cellpadding="0"
				id="menutable" cellspacing="0">
				<tr>
					<td height="4"></td>
				</tr>
				<tr>
					<td height="24" background="../../images/admin_left_1.gif">
						<div style="color:#ffffff;font-size:13px;padding-left:35px;">
							接入配置
						</div>
					</td>
				</tr>
				<%
			       if(request.getSession().getAttribute("user").equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)){ %>
			    <tr>
			    	<td height="24" background="../../images/admin_left_3.gif" onMouseOver="this.background='../../images/admin_left_3.gif';document.body.style.cursor='hand';" onMouseOut="this.background='../../images/admin_left_3.gif';document.body.style.cursor='default';">
			    	<div align="" style="padding-left:35px;">
			    	<a onclick="location.href='mdp_logs.jsp';" target="main">接入日志</a>
			    	</div></td>
			     </tr>
			    <%} %>
			    <tr>
				    <td height="24" background="../../images/admin_left_3.gif" onMouseOut="document.body.style.cursor='default';" onMouseOver="document.body.style.cursor='hand';" >
					    <div align="" style="padding-left:35px;">
					    	<a onclick="window.open('/mdp/tools/compare.jsp')" target="main">参数对比</a>
					    </div>
				    </td>
			   </tr>
		
			</table>
		</div>


		<div id="mainbox" style="width:80%;height:auto;">


			<div id="divContent" style="float:right;width:100%;">
				<div id="main"></div>
				<div id="divExtCreate" style="display:none;"></div>
			</div>
			
			</div>
			<div style="margin-top:100px;"></div>
			

	</body>
</html>
