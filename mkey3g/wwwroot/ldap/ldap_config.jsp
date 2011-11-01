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
 		   		
        window.onload=function(){
        	find();
        }
        
        //分页显示的函数参数输入
			var pageNum = 1;
				
			function ChangePage(num,bool){
			   if(bool){
				   if(pageNum==num){				      
				      return;
				   }
			   	 
				pageNum = num;				
				find();
					
			  }else{
			     if(num==1&&pageNum==num){
			        document.getElementById("prepage").style.cursor="auto";
			        document.getElementById("firstpage").style.cursor="auto";			       
			        document.getElementById(num).style.cursor="auto";
			     }
			     var last=document.getElementById("totalpage").innerText;
			     if(num==last&&pageNum==num){
			        document.getElementById("nextpage").style.cursor="auto";
			        document.getElementById("lastpage").style.cursor="auto";
			        document.getElementById(num).style.cursor="auto";
			     }else{
			        if(pageNum==num)
			           document.getElementById(num).style.cursor="auto";
			     }
			  }
			}

		 	function find(){               
				MipLdapAction.findLdaps(pageNum,
				{
					callback:function(objXml) {
						DisplayTransformedXML(1, objXml, "xslt/ldap.xsl",document.getElementById("divShow"));
					},
					errorHandler:function(errorString, exception) {
						exit();
					}
				});						
			}
		
		
		function addLdap()
		{
			GB_showCenter("添加LDAP", "../ldap/createldap.jsp",400,500);
		}

		function editLdap(id)
		{
			GB_showCenter("修改LDAP", "../ldap/createldap.jsp?id="+id,400,500);
		}
		
		function connect(id){
		    GB_showCenter("建立对应关系", "../ldap/ldap_connect.jsp?id="+id,600,800);
		}
	   
		function closePage(){
		   pageNum=1;
		   GB_CURRENT.hide();
		   find();
		}
		
		function closePages(str){
		   pageNum=1;
		   GB_CURRENT.hide();		   
		   find();
		   SDHalert(str,130);
		}
		
		function testLdap(id){
		    MipLdapAction.testLdap(id,
				{
					callback:function(bool) {
						if(bool)
						   SDHalert("该LDAP连接测试成功。",130);
						else
						   SDHalert("该LDAP连接测试失败。",130);
					},
					errorHandler:function(errorString, exception) {
						exit();
					}
				});			
		}
		
		function deleteLdap(id){
		    Ext.Msg.confirm("LDAP管理","您确定要删除吗？",function(del){
			if(del=="yes"){
				MipLdapAction.deleteMipLdap(id,
				{
					callback:function(objXml) {
						SDHalert("删除成功。",130);
					    find();
					},
					errorHandler:function(errorString, exception) {						
					}
				  });
				}			
	 	  });  				
		}
     </script>
     
	</head>
	<body class="body_center"
		onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

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
				<div id="close_menu" onclick="javascript:closemenu()" class="hand"></div>
				<div id="center_right_main">
					<!-- 中部主要内容开始 -->

					<div id="center_nav_box">
						<div id="center_nav">
							您现在所在位置 >> 配置管理>> LDAP配置
						</div>
					</div>
					<div id="tabs" style="border: 1px solid #FFFFFF"></div>
					<div id="mainbox">
						<div class="center_list_box">
							<div class="center_list">
								<div class="border_bg">

									<div class="border_blue right_list04">
										<div class="padding_5">
											<div class="float_right">
												<input type="button" name="add" value="添 加"
													onclick="addLdap()" class="button_1" />
											</div>
										</div>
										<div class="clear"></div>
										<div id="divShow"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--Bottom Include-->
		<jsp:include page="../user/bottom.jsp" flush="true" />
		<!--Bottom Include-->
	</body>
</html>