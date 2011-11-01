<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
    <table cellpadding="0" cellspacing="5" class="table" width="100%">
      <tr> 
        <td colspan="2" class="header"></td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td class="ar" width="35%"><span class="href_14px_blue">角色名称：</span></td>
        <td class="al">
          <input type="text" id="rolename" class="input_180px" maxlength="30" onFocus="fEvent('focus',this)" onBlur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)" onMouseOut="fEvent('mouseout',this)"/>
          <span class="star"> *</span>
        </td>
      </tr>
      <tr>
        <td class="ar"><span class="href_14px_blue">备 注：</span></td>
        <td class="al">
        	<span>
          <textarea id="comment"  class="input_180px" style="height:60px;" onFocus="fEvent('focus',this)" onBlur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)" onMouseOut="fEvent('mouseout',this)"></textarea>
       		</span>
       		<span style="color:red;text-align:center">
       			限40字
       		</span>
        </td>
      </tr>
      <tr>
        <td colspan="3"><div class="center_nav_line"></div>
        </td>
      </tr>
      <tr>
        <td class="ar" colspan="2"><div class="div_center">
          <input type="button" class="button" id="btnOK" onclick="javascript:RoleCreate();" value=" 确认提交 "/>
          <input type="button" class="button" id="btnReturn" value=" 返回浏览列表 ">
            <xsl:attribute name="onclick">
              javascript:GetRoleList();
            </xsl:attribute>
          </input></div>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>
