<%@ page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>角色详情</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">
    var GB_ROOT_DIR = "../skin/";
</script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		<script src="../dwr/interface/CatalogAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/RoleAction.js" type="text/javascript"></script>
		<script src="../dwr/interface/User2.js" type="text/javascript"></script>
		<script src="../dwr/interface/BranchAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<script src="../dwr/interface/MipAdminUser.js" type="text/javascript"></script>
		
		
		<script language="javascript" type="text/javascript">
		
		var pageid;
		var roleid = '<%=request.getParameter("roleid")%>';
	
		window.onload = function(){
		
			
			pageid = 1;
			
	  		getAllAdmin();
  	  }
  	  
	    
	    function getAllAdmin(){
	    		    
	    	MipAdminUser.getAllMipAdminUser(pageid,roleid,{
	    	
		    		callback:function(objXml) {
					DisplayTransformedXML(1, objXml, "../permission/xslt/show_permission.xsl",document.getElementById("divList"));
					CloseProgress();
	    	
	    			},
	    		
					errorHandler:function(errorString, exception) {
					alert(exception.message);
				}
	    	
	    	});
	    
	    }
	    
	    
	   /**删除一个管理员的操作**/
	   function delAdminUser(adminid){
	   
	   		MipAdminUser.deleteMipAdminUser(adminid,{
	   		
               callback:function(obj) {
               DHalert("删除用户成功！");
               getAllAdmin();
			   },
			   errorHandler:function(errorString, exception) {
				alert(exception.message);
			   }
	   		
	   		
	   		});

	   
	   }
	   
	   /**更新**/
   		function updataAdminUser(adminid){
   			
			GB_showCenter("", "../permission/updateAdminUser.jsp?adminid="+adminid,300,450);
 		}
 		
	   	/**添加**/
   		function addAdminUser(){
   			
			GB_showCenter("", "../permission/addAdminUser.jsp",300,450);
 		}
 		
 		/****/
		function closePage(str){
		   DHalert(str);
		   GB_CURRENT.hide();
		   pageid=1;
		   getAllAdmin();
		}
		
		/****/
		function CZ(eid){
			
			Ext.Msg.confirm("系统信息" ,"确定为<span style='color:red' >"+$('inputrealname'+eid).value +"</span>重置密码？", function(btn){
					if(btn=='yes'){
								alert("aaaaaaa");
								alert($('inputarea'+eid).value);
								
								$('divarea1'+eid).innerHTML=$('inputarea'+eid).value;
								var employeeId = $('inputEID'+eid).value;
								var username =$('inputrealname'+eid).value;
								var area = $('inputarea'+eid).value;
								UserAction.CZpwd(eid,employeeId,username,area,pageNum,"0",
								   	function(objXml){
									   DisplayTransformedXML(1, objXml, "xslt/user.xsl",document.getElementById("divShow"));
									   DHalert("密码已重置请确认！");
									}
								);
					 }
			});
				
			}
			
		/**添加 **/	
		function joinUser(){
			var ids = checkallid();
			
			RoleAction.JoinUser(roleid,ids,'-1',{
				    		callback:function(obj) {
					    		if(obj==1){
					    			window.location.href="../user/rolejoinuser.jsp?roleid="+roleid;
					    		}else{
					    			 DHalert("加入用户失败！失败原因："+obj);
					    			
					    		}
				    			
			    			},
							errorHandler:function(errorString, exception) {
							alert(exception.message);
							}
					
					});
			
		}
		
		function checkallid(){
			var ids ="";
			var obj=document.getElementsByName("box");
			for(var i=0;i<obj.length;i++){
				if(obj[i].checked==true){
					ids = ids+","+obj[i].value;
					
				}
			}
			if(ids.indexOf(",")==0){
				ids = ids.substring(1);
			}
			return ids;
		}
		
			function gohome(){
			window.location.href="rolejoinuser.jsp?roleid="+roleid;
			}
			

		

		</script>
		
		
	</head>
	<body style="width:860px;overflow:hidden;" onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		<div class="up_title">
			<span class="href_14px_blue up_subtitle">用户列表</span>
		</div>
		<div>
			&nbsp;
		</div>
		<div id="divlist"></div>
		<div class="div_center"><input id="rolejoin" type="button" class="button_4" value="加入用户" onclick="joinUser()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button_2" value="返回" onclick="gohome()"/> &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="关闭"  class="button_2"  onclick="parent.parent.GB_CURRENT.hide()"/></div>
	</body>
</html>
