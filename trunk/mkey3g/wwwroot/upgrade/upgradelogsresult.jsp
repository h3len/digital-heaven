<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=MipWebMoreUi.mip_user_admin_upgrade_10%></title>
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
<script src="../dwr/interface/app2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<!-- prototype -->
<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>
<script type="text/javascript" src="../scripts/xmlextend.js"></script>
<script language="javascript" type="text/javascript" src="../datepicker/WdatePicker.js"></script>
<link href="../datepicker/default/datepicker.css" rel="stylesheet" type="text/css" />
<link href="../datepicker/whyGreen/datepicker.css" rel="stylesheet" type="text/css" disabled="disabled" />
<script type="text/javascript">
</script>
</head>
<body>
	<%=MipWebMoreUi.mip_user_admin_upgrade_15%>
	<center>
		<jsp:include page="../getUpgradeLogs.do"></jsp:include>
	</center>
</body>
</html>
