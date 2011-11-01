<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dheaven.mip.ui.MipWebJSPUi;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
       <title><%= MipWebJSPUi.mipweb_user_import_user_last_1 %></title>
       <script language="javascript" src="../skin/common.js"></script>
		<link href="../skin/common.css" rel="stylesheet" type="text/css" />
		<link href="../skin/default/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../scripts/prototype.js"></script>
		<script type="text/javascript" src="../scripts/transferxml.js"></script>
       <script type="text/javascript">
       	var type='<%=request.getParameter("type")%>';
       	window.onload=function(){
       		for(var i=0;i<14;i++){
       			if(i==0){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="A";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==1){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="B";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==2){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="C";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==3){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="D";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==4){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="E";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==5){
       				for(var j=1;j<11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="F";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==6){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="G";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==7){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="H";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==8){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="I";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==9){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="J";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==10){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="K";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==11){
       				for(var j=1;j<=9;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="L";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==12){
       				for(var j=1;j<=9;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="M";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			}
       			if(i==13){
       				for(var j=1;j<=11;j++){
       					var option = document.createElement("option");
	       				option.value=i;
	       				option.text="N";
	       				document.all?$(j+'th').add(option):$(j+'th').appendChild(option);
       				}
       			} 			
       		}
       	}
       	function deloption(obj){
       		if(!obj.value==""){
       			for(var j=1;j<=11;j++){
       					if(obj==$(j+'th'))
       						continue;
       					for(var k =0;k<$(j+'th').length;k++){
       						if($(j+'th')[k].value==obj.value){
       							$(j+'th').remove(k);
       							k--;
       						}
       							
       					}
    			}
       		}else{//重新生成把
       			
       		}      		
       	}
       	function importoption(){
    

       		var url = '../masuser.do';
			var pars = 'action=importExcel&truename='+$('1th').value+'&mobile='+$('2th').value+'&companytel='+$('3th').value+'&hometel='+$('4th').value+'&email='+$('5th').value+'&city='+$('6th').value+'&groupname='+$('7th').value+'&username='+$('8th').value+'&idno='+$('9th').value+"&mobiletype="+$('10th').value+"&usertype="+$('11th').value;

			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: importoption_CallBack}
			);
       	}
       	function importoption_CallBack(originalRequest){
       		try
			{

				var objXml = originalRequest.responseXML;
				if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
				{
					alert("<%= MipWebJSPUi.mipweb_user_import_user_last_2 %>"+objXml.getElementsByTagName("node")[0].firstChild.nodeValue);
					parent.parent.GB_CURRENT.hide();
				}
				else
				{
					alert("<%= MipWebJSPUi.mipweb_user_import_user_last_3 %>"+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue);
				}
			}
			catch(err)
			{
				progressBar.isNeedConfirmButton = true;
				progressBar.isNeedProgressBar = false;
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebJSPUi.mipweb_user_import_user_last_4 %>"+errorMessage);
			}
       	}
       </script>
  </head>
  
  <body>
		<div class="up_title">
			<span class="href_14px_blue"><%= MipWebJSPUi.mipweb_user_import_user_last_5 %></span>
		</div>
		<div class="up_subtitle">
			<span><%= MipWebJSPUi.mipweb_user_import_user_last_6 %></span>
		</div>
		<table width="600px" border="0" align="center" cellpadding="0"
			cellspacing="5">
				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_7 %>
				</td>
				<td width="71%">
					<select id="8th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_8 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_9 %>
				</td>
				<td width="71%">
					<select id="1th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_10 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_11 %>
				</td>
				<td width="71%">
					<select id="9th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_12 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_13 %>
				</td>
				<td width="71%">
					<select id="2th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_14 %></option>
					</select>
				</td>
			</tr>
				<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_15 %>
				</td>
				<td width="71%">
					<select id="10th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_16 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_17 %>
				</td>
				<td width="71%">
					<select id="3th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_18 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_19 %>
				</td>
				<td width="71%">
					<select id="4th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_20 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					EMIAL
				</td>
				<td width="71%">
					<select id="5th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_21 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_22 %>
				</td>
				<td width="71%">
					<select id="6th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_23 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_24 %>
				</td>
				<td width="71%">
					<select id="11th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_25 %></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="3%">
					<img src="../skin/default/images/text_icon.gif" />
				</td>
				<td width="26%">
					<%= MipWebJSPUi.mipweb_user_import_user_last_26 %>
				</td>
				<td width="71%">
					<select id="7th">
					<option value=""><%= MipWebJSPUi.mipweb_user_import_user_last_27 %></option>
					</select>
				</td>
			</tr>
			
		</table>
		<div style="text-align:center"><input type="button" value="<%= MipWebJSPUi.mipweb_user_import_user_last_28 %>" onclick="importoption()"><input type="button" value="<%= MipWebJSPUi.mipweb_user_import_user_last_29 %>" onclick="parent.parent.GB_CURRENT.hide()" /></div>
  </body>
</html>
