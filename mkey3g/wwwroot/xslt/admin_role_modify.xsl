<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
    <table cellpadding="0" cellspacing="5" width="100%">
      <tr>
        <td class="h30"></td>
      </tr>
      <tr>
        <td width="40%"><span class="href_14px_blue">角色名称：</span></td>
        <td>
          <input type="text" id="rolename" class="input_180px" maxlength="30" onFocus="fEvent('focus',this)" onBlur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)" onMouseOut="fEvent('mouseout',this)">
            <xsl:attribute name="value">
              <xsl:value-of select="/root/role/@rolename" />
            </xsl:attribute>
          </input>
          <span class="star"> *</span>
        </td>
      </tr>
      <tr>
        <td><span class="href_14px_blue">备 注：</span></td>
        <td>
          <textarea id="comment" class="input_180px" style="height:60px;" onFocus="fEvent('focus',this)" onBlur="fEvent('blur',this)" onMouseOver="fEvent('mouseover',this)" onMouseOut="fEvent('mouseout',this)">
            <xsl:value-of select="/root/role/@comment" />
          </textarea>
        </td>
      </tr>
      <tr>
        <td colspan="3"><div class="center_nav_line"></div>
        </td>
      </tr>
      
      <tr>
        <td class="ar h40" colspan="2"><div class="div_center">
          <input type="button" class="button" id="btnOK" onclick="javascript:RoleModify();" value="确认提交 "/>
          <input type="button" class="button" id="btnReturn" value="返回浏览信息 ">
            <xsl:attribute name="onclick">
              javascript:RoleShow('<xsl:value-of select="/root/role/@id" />');
            </xsl:attribute>
          </input></div>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>
