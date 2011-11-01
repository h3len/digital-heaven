<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.util.Constants"%>
<%@page import="com.dheaven.mip.util.DhServerNameUtils"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录方式配置</title>
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
		<script type="text/javascript" src="../scripts/mobiledisk.js"></script>
		<script type="text/javascript" src="../scripts/tabpane.js"></script>
		<script type="text/javascript" src="../scripts/xmlextend.js"></script>
		<!-- Dwr Js -->
		<script src="../dwr/interface/MipClientAppAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		   var enterpriseid ='<%=request.getParameter("enterpriseid")%>';
		   var pageid = '<%=request.getParameter("pageid")%>';
		   var appid ='<%=request.getParameter("appid")%>';
		   var authoaorserver = "";
		   window.onload= function(){
			   showtab();
			   showlonginType();
			   if('<%=Constants.IDENTIFY_USER_MODE%>'==2){
			   		$('bsadduser').style.display="none";
			   	}
		   }
		   
		   function  showtab(){
					  $('tabcard').innerHTML="";
						var tabs = new Ext.TabPanel({		        
				        activeTab: 0,
				        frame:true,
				        defaults:{autoHeight: true},
				        renderTo: 'tabcard',
				        items:[
				         	{
				            title: '多重校验配置',
				            listeners: {activate: showchkconfig},
				            id:'showchkconfig'		            
				            }
				            ,
				            {
				            title:'用户登录方式配置',
				            listeners: {activate: loginconfig},
				            id:'loginconfig'
				            }
				        ]
				  	 	 });
		         }
		   
		    function loginconfig(){
			    $("loginconfigid").style.display="";
			   	$("chkconfigid").style.display="none";
			   	showlonginType();
				//启用单点
				$("loginmethod").style.display=""
				if($('accounttype').value=="auth_by_standard"){
					$('auth_by_standard').checked= true;
					$('singletype').style.display="none";
					 $('bsadduser').style.display="none";
				}else{
					$('auth_enable_sso').checked= true;
					$('singletype').style.display="";
					//$('single').checked=true;
				    if($('userlogintype').value=="bs"){
				   if(<%=DhServerNameUtils.isCloud%>==false){
			   				$("authmethod").style.display="none";
			   			}
				    $('bsadduser').style.display="";
				    $('bs').checked=true;
						      if($('bsaddusertype').value=="1"){
						      //自动同步
						      $('autouser').checked=true;
						      }else{
						      //手动同步
						      $('unautouser').checked=true;
						      }
						      if($("addmethodtype").value = "1"){
						      	$("oaserverauth").checked = true;
						      }else{
						      	$("oaauth").checked = "true";
						      }
				    }else{
				    //dhmi
				   if(<%=DhServerNameUtils.isCloud%>==false){
			   				$("authmethod").style.display="none";
			   			}
				    $('dhmi').checked=true;
				    $("ssourltd").style.display="";
				    if($('bsaddusertype').value=="1"){
						//自动同步
						$('bsadduser').style.display="";
					  $('autouser').checked=true;
				      }else if($('bsaddusertype').value=="2"){
				      //手动同步
				      $('bsadduser').style.display="";
				      $('unautouser').checked=true;
				      }else{
				      	$('bsadduser').style.display="";
				      }
				    }
				}
				if('<%=Constants.IDENTIFY_USER_MODE%>'==2){
			   		$('bsadduser').style.display="none";
			   	}
			}
		   //根据情况显示单点登录类型	
		     function showlogintype(){
		      if($('single').checked==true){
		      	 $('loginmethod').style.display="";
		      	 if($("auth_by_standard").checked==true){
		      	 	 $('singletype').style.display="";
		      	 	 	if($('bs').checked==true){
		      	 	 		$('bsadduser').style.display="";
		      	 	 		if($('bsaddusertype').value=="1"){
						    //自动同步
					      	$('autouser').checked=true;
					      	}else{
					      	//手动同步
					      	$('unautouser').checked=true;
					      }
		      	 	 	}
		      	 }
		      }else if($('unsingle').checked==true){
		      		 $('loginmethod').style.display="none";
		      		 $('singletype').style.display="none";
				   	 $('bsadduser').style.display="none";
				   	 $('ssourltd').style.display="none";
		      }
		     
		   }
		   //如果选则bs登录方式需要自动显示增加用户方式
		    function showbsaddusertype(){
		    	if($('bs').checked==true){
		    		 $('bsadduser').style.display="";
		    		if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		    		  $("ssourltd").style.display="none";
		    	}else if($("dhmi").checked){
		    		 $("ssourltd").style.display="";
		    		  $('bsadduser').style.display="";
		    		 if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		    	}else{
		    		 $("ssourltd").style.display="none";
		    		 $('bsadduser').style.display="none";
		    		if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		    	}
		    	if('<%=Constants.IDENTIFY_USER_MODE%>'==2){
			   		$('bsadduser').style.display="none";
			   	}
		    }
			/**********************************************************
				保存业务系统的登录方式--by chb@20100623
			**********************************************************/
		   function savelogintype(){
			   var enablesso=0;
			   var ssotype="";
			   var autousertype="0";//0:不用管,1,自动同步,2,不同步
			   var account = "";
			   enablesso=1;
			   if($("auth_by_standard").checked==true){
			   		account = "auth_by_standard";
			   }
			    if($("auth_enable_sso").checked==true){
			   		account = "auth_enable_sso";
			   }
			   if($('bs').checked==true){
			  	 ssotype="bs";
			   }
			   if($('dhmi').checked==true){
			    ssotype="dhmi";
			   }
			   if($('autouser').checked==true){
			   	autousertype="1";
			   }else if($('unautouser').checked==true){
			    autousertype="2";
			   }
			   
			   if($("auth_by_standard").checked==true){
				  	authoaorserver = "-1";
			   }else{
			     if($('oaauth').checked==true){
				   	 authoaorserver="0";
				   }else{
				   	 authoaorserver="1";
				   }
			   }
			   authoaorserver = "-1"
			   Progress("正在更新设置....");
			   MipClientAppAction.saveAppLoginType(enablesso,ssotype,autousertype,$("ssourl").value,enterpriseid,appid,account,"0",authoaorserver,{
				 	 callback:function(data){
				 	 	CloseProgress();
						DHalert(data);
					},
					errorHandler:function(errorString, exception) {
					    DHalert("保存失败，失败原因："+errorString);
					}
				});	
		   }	
		   /***************************************************************
		   			展现多重校验配置---by chb@20100626
		   ***************************************************************/
		   function showchkconfig(){
		   	   $("loginconfigid").style.display="none";
		   	   $("chkconfigid").style.display="";
			   MipClientAppAction.showBindConfig(appid,
			 	  function(data){
						dwr.util.setValues(data);
						changeOpen();
						changeForce();
					}
			   );
		   }
		   /***************************************************************
		   			保存多重校验配置---by chb@20100626
		   ***************************************************************/
		   function savechkconfig(){
		   		if($("chkIsOpen").checked&&!$("chkIsForceCheck").checked&&!$("chkIsFreeCheck").checked){
		   			DHalert("强制模式与松散模式必须启用一个! ");
		   			return;
		   		}
		   		if($("chkIsOpen").checked&&!$("chkEnableImeiCheck").checked&&!$("chkEnableImsiCheck").checked){
		   			DHalert("手机设备信息与手机卡设备信息至少绑定一个! ");
		   			return;
		   		}
		   		MipClientAppAction.saveBandingConfig($("chkIsOpen").checked,$("chkIsFreeCheck").checked,$("chkIsForceCheck").checked,$("chkIsAuToBanding").checked,$("chkEnableImeiCheck").checked,$("chkEnableImsiCheck").checked,appid,{
					 	 callback:function(data){
		 	   				showchkconfig();
							SDHalert("修改成功!",130);
						},
						errorHandler:function(errorString, exception) {
						    DHalert("保存失败，失败原因："+errorString);
						}
					});
		   }

		   /***************************************************************
		   			展现业务系统登录方式配置---by chb@20100623
		   ***************************************************************/
		   function showlonginType(){
		   		MipClientAppAction.showAppLoginConfig(appid,
		   			function(data){
		   				if(data["hasMultiCheck"]){
		   					$("multiCheck").style.display="";
		   					$("chksave").style.display="";
		   					$("enabled").style.display="none";
		   				}else{
		   					$("multiCheck").style.display="none";
		   					$("chksave").style.display="none";
		   					$("enabled").style.display="";
		   				}
						dwr.util.setValues(data);
					}
		   		);
		   }
		    //如果选则使用对接系统账号还是本系统账号
		   function showloginmethod(){
		   		if($("auth_by_standard").checked){
		   			if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		   			$('singletype').style.display="";
		   			if($("bs").checked){
		   				$("bsadduser").style.display="";
		   			}else{
		   				$("bsadduser").style.display="none";
		   			}
		   			$("ssourltd").style.display="none";
		   			$("singletype").style.display="none";
		   			$("ssourltd").style.display="none";
		   			$("bsadduser").style.display="none";
		   		}else if($("auth_enable_sso").checked){
		   			if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		   			$('singletype').style.display="";
		   			if($("dhmi").checked){
		   				$("ssourltd").style.display="";
		   				$("bsadduser").style.display="";
		   			}else{
		   				if(<%=DhServerNameUtils.isCloud%>==false){
		   				$("authmethod").style.display="none";
		   			}
		   				$("ssourltd").style.display="none";
		   				$("bsadduser").style.display="";
		   			}
		   		}else{
		   			$('singletype').style.display="none";
		   			$("bsadduser").style.display="none";
		   			$("ssourltd").style.display="none";
		   		}
			   	  if('<%=Constants.IDENTIFY_USER_MODE%>'==2){
			   		$('bsadduser').style.display="none";
			      }
		   }
		   
		   function changeOpen(){
		   		if($("chkIsOpen").checked){
		   			$("chkIsForceCheck").disabled="";
		   			$("chkIsFreeCheck").disabled="";
		   			changeForce();
		   		}else{
		   			$("chkIsForceCheck").disabled="disabled";
		   			$("chkIsFreeCheck").disabled="disabled";
		   			$("chkIsAuToBanding").disabled="disabled";
		   			$("chkEnableImeiCheck").disabled="disabled";
		   			$("chkEnableImsiCheck").disabled="disabled";
		   			$("chkIsForceCheck").checked=false;
		   			$("chkIsFreeCheck").checked=false;
		   			$("chkIsAuToBanding").checked=false;
		   			$("chkEnableImeiCheck").checked=false;
		   			$("chkEnableImsiCheck").checked=false;
		   		}
		   }
		   
		   function changeForce(){
		   		if($("chkIsForceCheck").checked){
		   			$("chkIsAuToBanding").disabled="";
		   			$("chkEnableImeiCheck").disabled="";
		   			$("chkEnableImsiCheck").disabled="";
	   			}else if($("chkIsFreeCheck").checked){
	   				$("chkIsAuToBanding").disabled="disabled";
		   			$("chkIsAuToBanding").checked=false;
		   			$("chkEnableImeiCheck").disabled="";
		   			$("chkEnableImsiCheck").disabled="";
	   			}
		   }
		   
		   function chkForce(){
		   		$("chkIsFreeCheck").checked=false;
		   		$("chkIsForceCheck").checked=true;
		   		changeForce();
		   }
		   function chkFree(){
		   		$("chkIsForceCheck").checked=false;
		   		$("chkIsFreeCheck").checked=true;
		   		changeForce();
		   }
		   
		</script>
</head>
<body>
		<div id="tabcard"> </div>
		<input type="hidden" id="issso"/>
		<input type="hidden" id="bsaddusertype"/>
		<input type="hidden" id="userlogintype"/>
		<input type="hidden" id="accounttype"/>
		<input type="hidden" id="addmethodtype"/>
		<div id="loginconfigid"> 
					<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="5">
						<tr id="loginmethod" style="display:none">
							<td width="20%" align="right">
									启用单点登录：
							</td>
							<td width="65%">
								<input type="radio" onclick="javascript:showloginmethod()"   name="loginmethodname" id="auth_by_standard" checked/>否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" onclick="javascript:showloginmethod()"   name="loginmethodname" id="auth_enable_sso"/>是
							</td>
						</tr>
						<tr id="singletype" style="display:none">
							<td width="15%" align="right">
								单点登录方式：
							</td>
							<td width="75%">
								<input type="radio"  onclick="javascript:showbsaddusertype()"    name="login_type" id="bs" checked/><span id="bsvalue">BS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input type="radio" onclick="javascript:showbsaddusertype()"   name="login_type" id="dhmi" />DHMI
							</td>
						</tr>
						<tr id="ssourltd" style="display:none">
							<td width="15%" align="right">
								 SSOURL：
							</td>
							<td width="75%">
								<input type="text"  class="input_text_long" onmouseover="fEvent('mouseover',this)"
									onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
									onmouseout="fEvent('mouseout',this)" name="ssourl" id="ssourl" maxlength="1000" size="50"/>
							</td>
						</tr>
						
							<tr id="bsadduser" style="display:none">
								<td width="15%" align="right">
									单点类型：
								</td>
								<td width="75%">
									<input type="radio"   name="addusertype" id="autouser" checked/>独立鉴权
									<input type="radio"  name="addusertype" id="unautouser"/>与平台共同鉴权
								</td>
							</tr>
							<tr id="authmethod" style="display:none">
								<td width="15%" align="right">
									用户鉴权方式：
								</td>
								<td width="75%">
									<input type="radio"   name="addoaauth" id="oaauth"/>OA鉴权
									<input type="radio"  name="addoaauth" id="oaserverauth"/>OA和Mkey同时鉴权
								</td>
							</tr>
							<tr>
								<td width="15%" align="right">
								
								</td>
								<td id="showbuttontype" width="75%">
									<input name="button" type="button" class="button_2"
											onclick="javascript:savelogintype();" value="保存" />
								</td>
								
							</tr>
						</table>
			</div>
			
		<div id="chkconfigid">
		<table width="200px" border="0" align="center" cellpadding="0"
						cellspacing="5">
			<tr id="multiCheck">
				<td style="text-align:left">
					<input type="checkbox" id="chkIsOpen" onclick="changeOpen(this.checked)"/>启用多重校验<br/>
					<input type="radio" onclick="chkForce()" id="chkIsForceCheck"  disabled="disabled"/>强制模式
					<input type="radio" onclick="chkFree()" id="chkIsFreeCheck"  disabled="disabled"/>松散模式<br/>
					<input type="checkbox" id="chkIsAuToBanding" disabled="disabled"/>自动绑定<br/>
					<input type="checkbox" id="chkEnableImeiCheck" disabled="disabled"/>绑定手机设备信息<br/>
					<input type="checkbox" id="chkEnableImsiCheck" disabled="disabled"/>绑定手机卡信息
				</td>
			</tr>
			<tr><td></td></tr>
			<tr id = "chksave">
				<td id="showbuttontype" width="75%" style="text-align:center">
					<input name="button" type="button" class="button_2"
						onclick="javascript:savechkconfig();" value="保存" />
				</td>
				
			</tr>
			<tr id="enabled" align="center">
				<td >
					<span style="color:red" >此功能受限</span>
				</td>
			</tr>
		</table>
		</div>
</body>
</html>