<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.dheaven.mip.config.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=ServerConfig.ALL_PAGE_TITLE%></title>
		<script type="text/javascript">
            var GB_ROOT_DIR = "../skin/";
        </script>
		<script src="../scripts/transferxml.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipLdapAction.js" type="text/javascript"></script>
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
 		var id='<%=request.getParameter("id")%>';   		
        window.onload=function(){
        	find();
        }        
        
	 	function find(){               
			MipLdapAction.findLdapReflects(id,
			{
				callback:function(objXml) {
					DisplayTransformedXML(1, objXml, "xslt/ldapconnect.xsl",document.getElementById("divShow"));
				},
				errorHandler:function(errorString, exception) {
					exit();
				}
			});						
		}
		
		
		function scancel(){
		   parent.parent.closePage();
		}
		
		function submit(){
		   var objs=document.getElementsByName("ldap_field_name");
		   var obj=document.getElementsByName("ldap_field_value");
		   var str="";
		   var values="";
		   for(var i=0;i<objs.length;i++){
	          str+=objs[i].id+"="+objs[i].value;
	          str+=",";
		   }
		   for(var i=0;i<obj.length;i++){
	          values+=obj[i].id+"="+obj[i].value;
	          values+=",";
		   }
		   MipLdapAction.createLdapReflects(str,values,
			{
				callback:function(result) {
					if(result=='')
					   parent.parent.closePages("新建联系成功。");
					else{					   
					   find();
					   SDHalert(result,200);
					}					  
				},
				errorHandler:function(errorString, exception) {
					exit();
				}
			});
		}

     </script>

	</head>
	<body>
		<div class="center_list">
			<div class="border_bg">
				<div class="border_blue right_list04">
					<div class="clear"></div>
					<div id="divShow" class="padding5"></div>
					<div class="clear"></div>
					<div style="text-align:center">
					<input type="button" class="button_1" value="提 交" onclick="submit()">
					<span class="margin_left_10"></span>
					<input type="button" class="button_1" value="取 消" onclick="scancel()">
					</div>
				</div>
			</div>
		</div>
	</body>
</html>