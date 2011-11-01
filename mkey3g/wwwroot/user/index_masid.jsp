<%@page import="com.dheaven.mip.config.*"%>
<%@page import="com.dheaven.mip.ui.MipWebMoreUi;"%>
<%
//验证权限
if(request.getSession().getAttribute("user")==null || request.getSession().getAttribute("user").equals(""))
{//session
	out.print("<script>parent.location.href='../default.jsp?url="+request.getServletPath() + "?" +request.getQueryString()+"'</script>");
	return;
}
%>
<%@ page contentType="text/html; charset=UTF-8" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=ServerConfig.ALL_PAGE_TITLE %></title>
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
<script src="../dwr/interface/User2.js" type="text/javascript"></script>
<script src="../dwr/engine.js" type="text/javascript"></script>
<script src="../dwr/util.js" type="text/javascript"></script>
<!--ExtJs-->
<LINK href="../skin/ext-all.css" type=text/css rel=stylesheet />
<SCRIPT src="../skin/ext-base.js" type=text/javascript></SCRIPT>
<SCRIPT src="../skin/ext-all.js" type=text/javascript></SCRIPT>

<script type="text/javascript" src="../scripts/prototype.js"></script>
<script type="text/javascript" src="../scripts/transferxml.js"></script>


<script type="text/javascript">

			var progressBar;
			var state = 0;

			function clickme(){
			progressBar= new ProgressBar();
			var masid="M";
			progressBar.isNeedConfirmButton = false;
			progressBar.isNeedProgressBar = true;
			progressBar.SetStatus("<%= MipWebMoreUi.mip_user_index_masid_1 %>");
			var url = '../mas.do';	
			var reg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/
			var masip = document.getElementById('masip').value;
			if(!reg.test($F('masip'))){
				alert('<%= MipWebMoreUi.mip_user_index_masid_2 %>');
				progressBar.Close();
				return;
			}
			var reg1=/[\da-zA-Z]/
			for(var i=1;i<=13;i++){
		//	var j = "masid"+i;
			//alert(j);
				if(document.getElementById("masid"+i).value.length==0){
				
					progressBar= new ProgressBar();	
					progressBar.isNeedConfirmButton = true;
					progressBar.isNeedProgressBar = false;
					progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> <%= MipWebMoreUi.mip_user_index_masid_3 %>");;

					return;
				}
				if(!reg1.test(document.getElementById("masid"+i).value)){
					progressBar= new ProgressBar();	
					progressBar.isNeedConfirmButton = true;
					progressBar.isNeedProgressBar = false;
					progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'><%= MipWebMoreUi.mip_user_index_masid_4 %>");;
					return;
				}
				masid=masid+document.getElementById("masid"+i).value;
			}
			
			var pars = 'action=updateMasConfig&masid='+masid+'&password='+document.getElementById('maspwd').value+'&masip='+document.getElementById('masip').value;


			var myAjax = new Ajax.Request(
			url,
			{method: 'post', parameters: pars, onComplete: clickme_CallBack}
			);
		
	}
		function  clickme_CallBack(originalRequest)
	{

		try
		{
			var objXml = originalRequest.responseXML;
		//	 alert(objXml.getElementsByTagName("return")[0].firstChild.nodeValue);
			if(objXml.getElementsByTagName("return")[0].firstChild.nodeValue == "true")
			{
				//这里判断下到底是在进行初始化
				if(state==0){//这说明是在进行初始化
					//定向到下个需要进行的页面
					window.location.href="../init/init_enterprise.jsp";
				}else{//这说明是在进行正常的注册
					Ext.MessageBox.alert('<%= MipWebMoreUi.mip_user_index_masid_5 %>', '<%= MipWebMoreUi.mip_user_index_masid_6 %>',closeWindows());
				}
				
			
			}
			else
			{
				progressBar.Close();
				Ext.MessageBox.alert('<%= MipWebMoreUi.mip_user_index_masid_7 %>', '<%= MipWebMoreUi.mip_user_index_masid_8 %>'+objXml.getElementsByTagName("msg")[0].firstChild.nodeValue,clearinput());
					//		window.location.reload();
			//arent.parent.GB_CURRENT.hide();

			}
		}
		catch(err)
		{

			progressBar.Close();
			//Ext.MessageBox.alert('提示信息', '注册失败！失败原因：'+errorMessage,clearinput());
		}
		progressBar.Close();
		}
	function tabforward(){
			for(var i=1;i<13;i++){
			if(document.getElementById("masid"+i).value.length!=1){
				break;
			}else if(document.getElementById("masid"+i).value.length==1){
					document.getElementById("masid"+(i+1)).focus();
				}			
			}
	}
	function closeWindows(){	
			parent.parent.reregi();		
	}
	function reloadwindow(){
			window.location.reload();
	}
	function clearinput(){
			for(var i=1;i<=13;i++){
				document.getElementById("masid"+i).value="";
			}
				document.getElementById("maspwd").value="";
				document.getElementById("masip").value="";
	}
	function getServerState(){
		User2.getServerState({
			callback:function(otext){
				state=otext;
				if(otext==0){//这个说明是没有初始化的
					document.getElementById('subbutton').value="<%= MipWebMoreUi.mip_user_index_masid_9 %>";			
				}else{
					document.getElementById('subbutton').value="<%= MipWebMoreUi.mip_user_index_masid_10 %>";	
				}
			},
			errorHandler:function(errorString, exception) {
				//					alert("JavaClassName" + exception.javaClassName + ", message=" + exception.message);
				//alert(exception.message);
			}
		});
	}
	window.onload=function(){
		getServerState();
	}

</script>
</head>
<body onkeydown="if(event.keyCode=='13'&&event.srcElement.type!='textarea') return false;">

                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="5">
                  <tr>
                    <td width="4%"><img src="../skin/default/images/text_icon.gif" width="16" height="16" /></td>
                    <td width="23%"><span class="href_12px_red_bold">MASID：</span></td>
                    <td width="73%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><div align="center">
                          <input type="text" class="input_35px" tabindex="1" disabled="true" value="M" size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input  id="masid1" type="text" class="input_35px" tabindex="2" onkeyup="tabforward()"  onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid2" type="text" class="input_35px" tabindex="3" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input  id="masid3" type="text" class="input_35px" tabindex="4" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid4" type="text" class="input_35px" tabindex="5" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"   size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid5" type="text" class="input_35px" tabindex="6" onkeyup="tabforward()"  onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid6" type="text" class="input_35px" tabindex="7" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid7" type="text" class="input_35px" tabindex="8" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid8" type="text" class="input_35px" tabindex="9" onkeyup="tabforward()"  onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid9" type="text" class="input_35px" tabindex="10" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid10" type="text" class="input_35px" tabindex="11" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid11" type="text" class="input_35px" tabindex="12" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid12" type="text" class="input_35px" tabindex="13" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                        <td><div align="center">
                          <input id="masid13" type="text" class="input_35px" tabindex="14" onkeyup="tabforward()" onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)"  size="1" maxlength="1" emptyok="false"/>
                        </div></td>
                       </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td width="4%">&nbsp;</td>
                    <td colspan="2"><img src="../skin/default/images/index_masid.gif" width="824" height="121" /></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="4%"><img src="../skin/default/images/text_icon.gif" width="16" height="16" /></td>
                    <td width="23%"><span class="href_12px_red_bold"><%= MipWebMoreUi.mip_user_index_masid_11 %></span></td>
                    <td width="73%"><input id="maspwd" type="password" class="input_180px" tabindex="1" o onMouseOver="fEvent('mouseover',this)" onMouseOut="fEvent('mouseout',this)" emptyok="false"/></td>
                  </tr>
                  <tr>
                    <td width="4%">&nbsp;</td>
                    <td width="23%">&nbsp;</td>
                    <td width="73%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="4%"><img src="../skin/default/images/text_icon.gif" width="16" height="16" /></td>
                    <td width="23%"><span class="href_12px_red_bold"><%= MipWebMoreUi.mip_user_index_masid_12 %></span></td>
                    <td width="73%"><input id="masip" type="text" class="input_180px" tabindex="1" o onmouseover="fEvent('mouseover',this)" onmouseout="fEvent('mouseout',this)" emptyok="false"/></td>
                  </tr>
                  <tr>
                    <td colspan="3"><div class="center_nav_line"></div></td>
                  </tr>
                  <tr>
                    <td height="64" colspan="3"><div align="center">
                      <input name="submit" type="button" value="<%= MipWebMoreUi.mip_user_index_masid_13 %>" id="subbutton" onclick="clickme();"/>
                    </div></td>
                  </tr>
                </table>

</body>
</html>
