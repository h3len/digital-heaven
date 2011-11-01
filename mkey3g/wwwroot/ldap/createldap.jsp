<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>LDAP管理</title>
		<script src="../dwr/interface/MipLdapAction.js" type="text/javascript"></script>
		<script src="../dwr/engine.js" type="text/javascript"></script>
		<script src="../dwr/util.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../theme/css.css" />
		<script type="text/javascript" src="../scripts/common.js"></script>

		<script type="text/javascript">
		    var id='<%=request.getParameter("id")%>';
		    var old_url="";
			window.onload =function(){
				if(id!='null')
				   editLdap();
				else
				  id="";
			}

			function editLdap(){
				MipLdapAction.getMipLdap(id,
				{
					callback:function(obj) {
						if(obj){
						    DWRUtil.setValue("url",obj.url);
						    old_url=obj.url;
						    DWRUtil.setValue("dc",obj.dc);
						    DWRUtil.setValue("cn",obj.cn);
						    DWRUtil.setValue("username",obj.username);
						    DWRUtil.setValue("password",obj.password);
						    DWRUtil.setValue("table_name",obj.table_name);
						    DWRUtil.setValue("table_id",obj.table_id);
						}
					},
					errorHandler:function(errorString, exception) {					
						parentexit();
					}
				});
			}
			
			function saveEntity(){
			   var cf=new CheckForm();
			   var url=DWRUtil.getValue("url");
			   var dc=DWRUtil.getValue("dc");
			   var cn=DWRUtil.getValue("cn");
			   var username=DWRUtil.getValue("username");
			   var password=DWRUtil.getValue("password");
			   var table_name=DWRUtil.getValue("table_name");
			   var table_id=DWRUtil.getValue("table_id");
			   if(cf.Trim(url)==""){
			       SDHalert("URL不能为空。",130);
			       return;
			   }
			   if(cf.Trim(dc)==""){
			       SDHalert("DC不能为空。",130);
			       return;
			   }
			   if(cf.Trim(cn)==""){
			       SDHalert("CN不能为空。",130);
			       return;
			   }
			    if(cf.Trim(username)==""){
			       SDHalert("用户名不能为空。",130);
			       return;
			   }
			    if(cf.Trim(password)==""){
			       SDHalert("密码不能为空。",130);
			       return;
			   }			   
			   if(id==''||(id!='' && url!=old_url)){
			      MipLdapAction.isExsitLdap(url,
					{
						callback:function(result) {
						    if(result)
						       SDHalert("该LDAP配置已存在。",130);
						    else{
						       createMipLdap();
						    }
						},
						errorHandler:function(errorString, exception) {						
							parentexit();	
						}
					});
			   }else{
			      createMipLdap();
			   }			   
			}
			
			function createMipLdap(){
			   var cf=new CheckForm();
			   var url=DWRUtil.getValue("url");
			   var dc=DWRUtil.getValue("dc");
			   var cn=DWRUtil.getValue("cn");
			   var username=DWRUtil.getValue("username");
			   var password=DWRUtil.getValue("password");
			   var table_name=DWRUtil.getValue("table_name");
			   var table_id=DWRUtil.getValue("table_id");
			   url=cf.Trim(url);
			   dc=cf.Trim(dc);
			   cn=cf.Trim(cn);
			   username=cf.Trim(username);
			   password=cf.Trim(password);
			   table_name=cf.Trim(table_name);
			   table_id=cf.Trim(table_id);
			   MipLdapAction.createMipLdap(id,url,dc,cn,username,password,table_name,table_id,
				{
					callback:function(objXml) {
					    scancel();	
					},
					errorHandler:function(errorString, exception) {						
						parentexit();	
					}
				});
			}
			
			function reset(){
			   DWRUtil.setValue("url","");
			   DWRUtil.setValue("dc","");	
			   DWRUtil.setValue("cn","");
			   DWRUtil.setValue("username","");
			   DWRUtil.setValue("password","");	
			   DWRUtil.setValue("table_name","");
			   DWRUtil.setValue("table_id","");	   
			}
			
			function scancel(){
			   parent.parent.closePage();
			}
		</script>
	</head>
	<body>


		<div class="border_bg">
			<div id="content" style="margin-top: 20px">
				<table width="100%" align="center">
					<tr>
						<td width="30%" align="right">
							URL：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="url" maxlength="100" class="input_text" style="width:200px"
								onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							<span class="margin_left_15"></span>
						</td>
						<td>							
							<em class='blue'>输入形式如：ldap://192.168.0.3:389</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							DC：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="dc" maxlength="100" class="input_text" style="width:200px"
								onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							<span class="margin_left_15"></span>
						</td>
						<td>							
							<em class='blue'>输入形式如：d-heaven.com</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							CN：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="cn" maxlength="100" class="input_text" style="width:200px"
								onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							<span class="margin_left_15"></span>
						</td>
						<td>							
							<em class='blue'>输入形式如：CN=test,CN=Users</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							用户名：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="username" maxlength="100" style="width:200px"
								class="input_text" onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr>
						<td width="30%" align="right">
							密码：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="password" id="password" maxlength="100" style="width:200px"
								class="input_text" onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr style="display:none">
						<td width="30%" align="right">
							导入的数据库表名：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="table_name" maxlength="100" style="width:200px"
								class="input_text" onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr style="display:none">
						<td width="30%" align="right">
							导入的数据库表主键名：
							<span class="margin_left_15"></span>
						</td>
						<td>
							<input type="text" id="table_id" maxlength="100" style="width:200px"
								class="input_text" onmouseover="fEvent('mouseover',this)"
								onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
								onmouseout="fEvent('mouseout',this)" />
							<em class='red'>*</em>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="border_bottom padding_20"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<div class="padding_20 text_align_center">
								<input class="button_2" type="submit" value="提 交"
									onclick="saveEntity()" />
								<span class="margin_left_5"></span>
								<input class="button_2" type="reset" value="重 置"
									onclick="reset()" />
								<span class="margin_left_5"></span>
								<input class="button_2" type="button" value="取 消"
									onclick="scancel()" />
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>