<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />
  <table cellpadding="0" cellspacing="10" width="100%">
    <tr>
      <td class="h30"></td>
    </tr>
    <tr>
      <td class="text_icon2" width="40%"><span class="href_14px_blue">角色名称：</span></td>
      <td>
        <xsl:value-of select="/root/role/@rolename"/>
      </td>
    </tr>
    <tr>
      <td class="text_icon2"><span class="href_14px_blue">备 注：</span></td>
      <td style="word-break: break-all">
        <xsl:value-of select="/root/role/@comment"/>
      </td>
    </tr>
    <tr><td class="ar" colspan="2"><div class="center_nav_line"></div></td></tr>
    <tr>
      <td class="ar h40" colspan="2"><div class="div_center">
        <input type="button" class="button" id="btnModify" value=" 修改信息 ">
          <xsl:attribute name="onclick">
            javascript:LoadRoleModify("<xsl:value-of select="/root/role/@id" />");
          </xsl:attribute>
        </input>
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
