<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<% 
    String username;
    if(request.getParameter("username") == null) {
       username = "";
    } else {
			username=new String(request.getParameter("username").getBytes("8859_1"),"utf-8");
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title><%= MipWebJSPUi.mipweb_mobile_admin_add_packet_1 %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		    var GB_ROOT_DIR = "../skin/";
		</script>
		<!-- common.js 通用js调用 -->
		<script language="javascript" src="../scripts/common.js"></script>
		<!-- css.css 通用css调用 -->
		<link href="../theme/css.css" rel="stylesheet" type="text/css" />		
		<!--GrayBox-->
		<script type="text/javascript" src="../skin/AJS.js"></script>
		<script type="text/javascript" src="../skin/AJS_fx.js"></script>
		<script type="text/javascript" src="../skin/gb_scripts_main.js"></script>
		<link href="../skin/gb_styles.css" rel="stylesheet" type="text/css" />
		
		<!-- Dwr Js -->
		<script src="../dwr/interface/MobileAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		
<script type="text/javascript">
	var mobiletypelist ="";
	function uploadpacket(){
		window.open("add_packet.jsp","<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_2 %>","height=150,width=500,top=100,left=200,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
	}
	function addpacket(){
		if($('packetname').value==''){			
			 DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_3 %>");
			return false;
		}
		if($('packetname').value.replace(/(^\s*)|(\s*$)/g, "")==''){
			 DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_4 %>");
			return false;
		}
		if($('sourcename').value==''){
			DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_5 %>");
			return false;
		}
		getnowtypelist();
		if(mobiletypelist==''){
			DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_6 %>");
			return false;
		}
		MobileAction.addPacket($('packetname').value,mobiletypelist,$('sourcename').value,$('sourcetruename').value,
			{
				callback:function(data){
			
					if(data=="1")
					{
						parent.parent.closewindow(); 
					}
					else
					{
						DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_7 %>"+data);
					}              
				},
				errorHandler:function(errorString,exception){
					DHalert("<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_8 %>"+exception.message);
				}
            });
	}
	window.onload=function(){
		getAllMobiletypeList();
	}
	function getAllMobiletypeList(){
		MobileAction.getAllMobiletypeList(
			{
				callback:function(olist){
						for(var i=0;i<olist.length;i++){
						var objOption = document.createElement("OPTION");
						objOption.text = olist[i].mobiletype;
						objOption.value = olist[i].id;
						objOption.ondblclick= function(){
								 	delme1(this.value)
								 }
						document.all?$('lbvto').add(objOption):$('lbvto').appendChild(objOption);
					}
				},
				errorHandler:function(errorString,exception){
					alert(exception.message);
				}
            });
	}
	function delme1(a){
			for(var i=0; i < $('lbvto').length; i++){
				if($('lbvto')[i].value==a){
						var otext = $('lbvto')[i].text;
						var obj = $('possess2');
						var b = false;
						for(var j=0;j<obj.length;j++){
							if(obj[j].value==$('lbvto')[i].value){
								b=true;
								break;
							}
						}
						if(b)
							continue;
						var oOption = document.createElement("OPTION");
						oOption.text =otext;
						oOption.value =$('lbvto')[i].value;			
						oOption.ondblclick= function(){
						 	delme2(this.value)
						 }
					document.all?$('possess2').add(oOption):$('possess2').appendChild(oOption);
				}
			}
		}
			function delme2(a){

			for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].value==a){
					$('possess2').remove(i);
					i--;
				}
			}
		}
		
		function add(){
			var  oObject =$('lbvto');

			
				for(var i=0; i < oObject.length; i++){
				if(oObject[i].selected==true){
						var otext = oObject[i].text;
						var obj = $('possess2');
						var b = false;
						for(var j=0;j<obj.length;j++){
							if(obj[j].value==oObject[i].value){
								b=true;
								break;
							}
						}
						if(b)
							continue;
						var oOption = document.createElement("OPTION");
						oOption.text = otext;
						oOption.value =oObject[i].value;	
				
						oOption.ondblclick= function(){
						 	delme2(this.value)
						 }
						document.all?$('possess2').add(oOption):$('possess2').appendChild(oOption);
						
					}
				}

		}
		function delout(){
			for(var i=0; i < $('possess2').length; i++){
				if($('possess2')[i].selected==true){
						$('possess2').remove(i);
						i--;
				}
			}
		}
		function show(){
			add();
		}
		function getnowtypelist(){
			
			for(var i=0; i < $('possess2').length; i++){
				mobiletypelist = mobiletypelist + $('possess2')[i].value +',';
			}
		}
</script>
  </head>
  <body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">
		 <!-- 内容开始 -->
		<table wideh="80%" align="center">
		<tr>
		<td>
  	<span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_packet_9 %></span></td><td><input type="text" id="packetname"
										 maxlength="20" class="input_text input_180px"
onmouseover="fEvent('mouseover',this)"
																onfocus="fEvent('focus',this)"
																onblur="fEvent('blur',this)"
																onmouseout="fEvent('mouseout',this)"/></td></tr>
 		<tr><td colspan="2">
 		<table width="850px" border="0" align="center" cellpadding="0"
			cellspacing="5">
			<tr>
				<td width="40%" bgcolor="#E7EFF8">

					<table>
						<tr>
							<td width="3%">
								<img src="../skin/default/images/text_icon.gif" />
							</td>
							<td width="33%">
								<span id="mark"><%= MipWebJSPUi.mipweb_mobile_admin_add_packet_10 %></span>
							</td>
							<td width="67%">
								<select name="lbvto" id="lbvto" size="6" multiple="multiple"
									ondblclick="show()" style="height:130px;width:200px"></select>
							</td>
						</tr>
					</table>

				</td>

				<td width="15%" style="text-align:center">
					<table>
						<tr>
							<td>
								<input type="button" class="button_4" value="<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_11 %>" onclick="add();"
									style="width:100px" />
							</td>
						</tr>
						<tr>
							<td>
								<input type="button" class="button_4" value="<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_12 %>" onclick="delout()"
									style="width:100px" />
							</td>
						</tr>
					</table>
				</td>
				<td width="40%" bgcolor="#E7EFF8">
					<table>
						<tr>
							<td width="25%" style="text-align:right">
								<span><%= MipWebJSPUi.mipweb_mobile_admin_add_packet_13 %></span>
							</td>
							<td width="75%">
								<select name="select" id="possess2" multiple="multiple"
									style="height:160px;width:220px" ondblclick="delout()">
								</select>
							</td>
						</tr>
					</table>
				</td>

			</tr>
		</table>
 		
 		
 		</td></tr>

 		<tr><td><span class="href_12px_blue_bold"><%= MipWebJSPUi.mipweb_mobile_admin_add_packet_14 %></span></td><td><input type="text" id="sourcename" readOnly="true"/><input type="button" class="button_4" value="<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_15 %>" onclick="uploadpacket()"/></td></tr>

										</table>
	<table wideh="80%" align="center">
	<tr><td>
	<input type="hidden" id='sourcetruename'/>
  <input type="button" id="com" class="button_2" value="<%= MipWebJSPUi.mipweb_mobile_admin_add_packet_16 %>"  onclick="javascript:addpacket()">
  </td></tr>
  </table>
  </body>
</html>
