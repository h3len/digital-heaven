<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/root">
      <table width="100%" cellpadding="2" cellspacing="2"  bgcolor="#ffffff">
	      <tr class="header"> 
	        <td colspan="2" class="list_title_bg">绑定客户系统账号</td>
	      </tr>
	      <tr>
	        <td></td>
	      </tr>
	      <tr>
			  <td align="right">所属集团：</td>
			  <td >			  	
			  	<select name="newoaid" id="newoaid" class="input_text" >
			  		<option value="">请选择...</option>
					<xsl:apply-templates select="branch"/>
			  	</select>			  	
			  </td>
		  </tr>	
	      <tr>
		      <td align="right">选择MIP登录用户:</td>
		      <td>
		      	<input type="hidden" id="newmipuser" name="newmipuser"></input>		      
		      	<input type="text"  id="newmipuserName" name="newmipuserName" readonly="true" class="input_text"></input><span class="star"> *</span><input type="button" class="button" value="请选择..." onclick="javascript:chooseMipUser(this);"></input>		      	
		      </td>
	      </tr>
	      <tr><td  align="right">系统ID:</td><td ><input type="text" class="input_text"  maxlength="50" name="sysid" id="sysid" size="20"/><span class="star"> *</span>(如：oa、erp、crm等)</td></tr>
		  <tr><td align="right">系统登录名:</td><td ><input type="text" class="input_text" maxlength="50" id="newoauser" size="20"/><span class="star"> *</span></td></tr>
		  <tr><td align="right">系统登录密码：</td><td><input maxlength="20" class="input_text" type="password" id="newoapwd"/><span class="star"> *</span></td></tr>
		  <tr><td align="right">用户手机号：</td><td ><input maxlength="20" class="input_text" type="text" name="newmobile" id="newmobile"/></td></tr>
		  <tr>
		  	 <td align="right">
		  		<input type="button" class="button"  id="btnOK" name="btnOK" onclick="javascript:extCreate();" value=" 确认提交 "/>
         </td>
        <td>
          <input type="button" class="button" id="btnReturn" value=" 返回列表 " onclick="javascript:Init();"/>
		 	 </td>
		  </tr>	     
	    </table>
  </xsl:template>
 
   <!-- 超级管理员新增用户界面 -->
  <xsl:template match="/root" mode="sysAdmin">
  	
  </xsl:template>
  
  <xsl:template match="branch">
  	<option value="{@id}"><xsl:value-of select="@branchname"></xsl:value-of></option>
  </xsl:template>
</xsl:stylesheet>