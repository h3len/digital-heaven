<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.service.impl.PermissionServiceImpl"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%
	//验证权限
	if (request.getSession().getAttribute("user") == null
			|| request.getSession().getAttribute("user").equals("")) {//session
		out.print("<script>top.location.href='../default.jsp?url="
				+ request.getServletPath() + "?"
				+ request.getQueryString() + "'</script>");
		return;
	} else {//权限
		String uid = (String) request.getSession().getAttribute("user");
		if (!uid
				.equals(com.dheaven.mip.dataaccess.vo.MipSysuser.Admin_UID)) {
			PermissionServiceImpl ps = (PermissionServiceImpl) ServerConfig.beanFacotry
					.getBean("permissionServiceImpl");
			if (ps.findUserPrivacyByUserIDAndCategoryID(uid, "mipmail") == null) {
				out
						.print("<script>top.location.href='../default_admin.jsp?url="
								+ request.getServletPath()
								+ "?"
								+ request.getQueryString()
								+ "'</script>");
				return;
			} else {
				java.util.List list = ps
						.findUserPrivacyByUserIDAndCategoryID(uid,
								"mipmail");
				if (list == null || list.size() == 0) {
					out
							.print("<script>top.location.href='../default_admin.jsp?url="
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

<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	<head>
		<title>UA信息详情</title>
		<script type="text/javascript">
				var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet"
			href="../css/luna/tab.css" />
		<script language="javascript" src="../scripts/selall.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/MipDeviceUaAction.js"
			type="text/javascript"></script>
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
//企业id
var uaid = "<%=request.getParameter("uaid") != null ? request
					.getParameter("uaid") : ""%>";
		window.onload=function(){
		showUAInfoByDeviceUAId(uaid);
		}
	function showUAInfoByDeviceUAId(uaid){
	 //开始提交数据
  	 Progress("数据正在载入...","提示");
     MipDeviceUaAction.showUaInfoByDeviceUaId(uaid,
			 	function(data){
			 		CloseProgress();
					dwr.util.setValues(data);
				}
			);	
	}
	
</script>
	</head>

	<body>
		<div class="up_title">
			<span class="blue_14_bold">UA信息管理</span>
		</div>
		<div class="up_subtitle">
			<span class="blue_12_bold">UA信息详情</span>
		</div>

		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">GW-UA（短）：</span>
				</td>
				<td align="left" id="gw_ua_short" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">GW-UA（长）：</span>
				</td>
				<td id="gw_ua_long" width="71%"  style="word-break:break-all; overflow:hidden;"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">操作系统：</span>
				</td>
				<td id="os_detail" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">分辨率：</span>
				</td>
				<td id="screensize" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">型号：</span>
				</td>
				<td id="type_name" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">官网名称：</span>
				</td>
				<td id="official_name" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">质量：</span>
				</td>
				<td id="weight" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">机身内存：</span>
				</td>
				<td id="innermomery" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">扩展内存：</span>
				</td>
				<td id="extmemory" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">摄像头：</span>
				</td>
				<td id="carner" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">网络：</span>
				</td>
				<td id="network" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">蓝牙：</span>
				</td>
				<td id="blueteeth" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">系统播放器：</span>
				</td>
				<td id="player" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">HTML版本：</span>
				</td>
				<td id="htmlversion" width="71%"></td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td align="left" width="26%">
					<span class="blue_12">WAP版本：</span>
				</td>
				<td id="wapversion" width="71%"></td>
			</tr>
		</table>
	</body>
</html>
