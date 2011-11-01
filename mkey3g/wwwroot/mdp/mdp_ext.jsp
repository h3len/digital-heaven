<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script type="text/javascript">
   			 var GB_ROOT_DIR = "../skin/";
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script language="javascript" src="/scripts/common.js"></script>
		<link href="/theme/css.css" rel="stylesheet" type="text/css" />
	
		<title>MDP扩展账号绑定</title>
		
		
		<script src="/dwr/interface/MdpExtentionService.js" type="text/javascript"></script>
		<script src="/dwr/engine.js" type="text/javascript"></script>
		<script src="/dwr/util.js" type="text/javascript"></script>
		
		<script type="text/javascript" src="/skin/AJS.js"></script>
		<script type="text/javascript" src="/skin/AJS_fx.js"></script>
		<script type="text/javascript" src="/skin/gb_scripts.js"></script>
		<link href="/skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="/skin/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="/skin/calendar/lang/calendar-zh.js"></script>
		<link href="/skin/calendar/css/zpcal.css" rel="stylesheet"
			type="text/css" />
		<link href="/skin/calendar/website/css/template.css"
			rel="stylesheet" type="text/css" />
		<link href="/skin/calendar/themes/winxp.css" rel="stylesheet"
			type="text/css" />
		

		<script type="text/javascript">
		var progressBar;
		var pageid = "1";
		
		function Init(){
		     Progress("Loading....");
		     MdpExtentionService.loadExtList(1,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_list.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		function ChangePage(pageid){
		     Progress("Loading....");
		     MdpExtentionService.loadExtList(pageid,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_list.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		function loadCreateWin(){
			Progress("Loading....");
			MdpExtentionService.getEnterpriseList(pageid,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_create.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		
		function extCreate(){
			var newmipuser = document.getElementById("newmipuser").value;//mip登录用户名
			var newoauser = document.getElementById("newoauser").value;//oa登录用户名
			var newoapwd = document.getElementById("newoapwd").value;//oa登录密码
			var newoaid = document.getElementById("newoaid").value;//oaID
			var sysid = document.getElementById("sysid").value;//sysid
			var newmobile = document.getElementById("newmobile").value;// 手机号码
			if(newmipuser.length==0){
				DHalert("MIP登录用户名不能为空");return;
			}
			if(sysid.length==0){
				DHalert("系统ID不能为空");return;
			}
			if(newoauser.length==0){
				DHalert("系统登录用户名不能为空");return;
			}
			if(newoapwd.length==0){
				DHalert("系统登录密码不能为空");return;
			}
			if(newoaid.length==0){
				DHalert("企业ID不能为空");return;
			}
			Progress("正在保存数据....");
			
			MdpExtentionService.updateMdpExt("create","",newoaid,newmipuser,sysid,newoauser,newoapwd,newmobile,
			{
				callback:function(data) {
					if(data == "0"){
						DHalert("创建成功");
						Init();
					}
					else{
						DHalert("创建失败,请重试!");
					}
						
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		//加载更新窗口
		function loadUpdateWin(extid){
		     Progress("正在加载数据....");
		     
		     MdpExtentionService.getMdpExt(extid,
			{
				callback:function(objXml) {
					document.getElementById("divContent").innerHTML = "";
					DisplayTransformedXML(1, objXml, "/xslt/mdp_ext_update.xsl",document.getElementById("divContent"));
					CloseProgress();
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
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
			
			if(sysid.length==0){
				DHalert("系统ID不能为空");return;
			}
			if(newmipuser.length==0){
				DHalert("MIP登录用户名不能为空");return;
			}
			if(newoauser.length==0){
				DHalert("系统登录用户名不能为空");return;
			}
			if(newoapwd.length==0){
				DHalert("系统登录密码不能为空");return;
			}
			if(newoaid.length==0){
				DHalert("企业ID不能为空");return;
			}
			
			Progress("正在更新数据....");
			MdpExtentionService.updateMdpExt("update",pk,newoaid,newmipuser,sysid,newoauser,newoapwd,newmobile,
			{
				callback:function(data) {
					if(data == "0"){
						DHalert("更新成功");
						Init();
					}
					else{
						DHalert("更新失败,请重试!");
					}
						
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		//删除
		function del(extid){
			if(!confirm("确认要删除该MDP扩展用户么?")){
				return;
			}
			Progress("正在操作....");
		    MdpExtentionService.delMdpExt(extid,
			{
				callback:function(data) {
					if(data == "0"){
						DHalert("删除成功");
						Init();
					}
					else{
						DHalert("删除失败,请重试!");
					}
						
				},
				errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
			});
		}
		
		//打开选择mip用户的窗口
		function chooseMipUser(obj){
			var catId = document.getElementById('newoaid').value;
			if(catId .length==0){
				DHalert("请先选择集团！");
				return ;
			}
			var swidth = 350;
			var  sheight = 500;
			var l = ( screen.availWidth - swidth ) / 2;
    		var  t = ( screen.availHeight - sheight) / 2;      
			var winMipUserChooser = window.open("chooseMipUser.jsp?cat="+catId,"mipUserChooser",'left=' + l +',top=' + t 
+"toolbar=0,menubar=0,resizable=1,width="+swidth+",height="+sheight);
		}
		
		function closemenu(){
			if(document.getElementById('center_left').style.display=='none'){
				document.getElementById("center_left").style.display='';
				document.getElementById("center_left").className = "center_left";
				document.getElementById("center_right").style.width = "77%";
			}
			else if
			(document.getElementById('center_left').style.display==''){
				document.getElementById("center_left").style.display='none';
				//document.getElementById("center_left").className = "center_left_close";
				document.getElementById("center_right").style.width = "99%";
			}
		}
	</script>
	</head>
	<body bgcolor="#f8f8f8" onLoad="javascript:Init();">
		<!--Top Include-->
		<jsp:include page="../user/top.jsp" flush="true" />
		<!--Top Include-->
		
		<div id="center">
			<div id="center_left" class="center_left">
				<!--Strat center_left_tree-->
				<div id="center_left_tree">
					<div id="center_left_tree_top"></div>
					<div id="center_left_tree_bg">

					</div>
					<div id="center_left_tree_bom"></div>
				</div>
			</div>
				<div id="center_right">
					<div id="close_menu" onClick="javascript:closemenu()" class="hand"></div>
						<div id="center_right_main">
							<div id="center_nav_box">
								<div id="center_nav">
									您现在所在位置 >> 配置管理 >> 接入配置
								</div>
							</div>
							<div id="mainbox">
								<div  class="center_list">
									<table width="100%"  class="margin_left_5">
											<tr>
												<td colspan="2" width="100%" align="right">
													<input type="button" value="创建绑定账号" onclick="javascript:loadCreateWin();" />
												</td>
											</tr>
										</table>
									<div class="clear"></div>
									<div id="divContent"></div>
								</div>	
							</div>
					</div>
			</div>
		</div>

		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="/user/bottom.jsp" flush="true" />
		<!--Bottom Include-->

	</body>
</html>
