<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/mdpExt"><link type="text/css" rel="stylesheet" href="../css/user.css" />
		<input type="hidden" id="extPk" value="{@id}"/>	
		<table cellpadding="0" cellspacing="0" class="table" width="100%">
	      <tr> 
	        <td colspan="2" class="header">绑定账号信息</td>
	      </tr>
	      <tr>
	        <td></td>
	      </tr>
	      <tr>
			  <td class="ar">所属集团：</td>
			  <td class="al">
			  	<input type="text" name="newoaname" id="newoaname" value="{@branchname}" readonly="true"></input>
			  	<input type="hidden" name="newoaid" id="newoaid" value="{@oaid}"></input>			  	
			  </td>
		  </tr>	
	      <tr>
		      <td  class="ar">MIP登录用户:</td>
		      <td class="al">
		      	<input type="hidden" name="newmipuser" id="newmipuser" value="{@userid}"></input>
		      	<input type="text" name="newmipuserName" id="newmipuserName" value="{@mipUserName}"  readonly="true"></input>		      	
		      </td>
	      </tr>
		  <tr><td  class="ar" >系统登录名:</td><td class="al"><input type="text"  maxlength="50" name="newoauser" id="newoauser" size="20" value="{@oauser}"  readonly="true"/></td></tr>
		  <tr><td class="ar">系统登录密码：</td><td class="al"><input maxlength="20" type="password" name="newoapwd" id="newoapwd" value="{@oapwd}"  readonly="true"/></td></tr>
		  <tr><td class="ar">用户手机号：</td><td class="al"><input maxlength="20" type="text" name="newmobile" id="newmobile" value="{@mobile}" readonly="true"/></td></tr>	
		  <tr>
		  	 <td  class="ar" colspan="2">		  		
		  		<input type="button" class="button" id="btnReturn" value=" 返回浏览列表 " onclick="javascript:Init();"/>
		 	 </td>
		  </tr>	     
	    </table>
  </xsl:template>
</xsl:stylesheet>
