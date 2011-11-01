<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/root/dhmiconfig">
      <table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	      <tr class="header"> 
	        <td colspan="2" class="list_title_bg">DHMI配置信息</td>
	      </tr>
	      <tr>
	        <td></td>
	      </tr>
	      <tr><td align="right">透传地址:</td><td ><input type="text" name="appServerURL" style="width:200px" id="appServerURL" value="{@appServerURL}"/>(如:http://192.168.0.1:8080/dhmi)</td></tr>
		  <tr><td align="right">当前服务器地址:</td><td ><input type="text" id="mdpServerURL" style="width:200px" value="{@mdpServerURL}"/>(如:http://192.168.0.1:8080)</td></tr>
        <tr>
          <td align="right">是否启用MSC自动转换：</td>
          <td>
           <input type="checkbox" id="enableMsc2to3">
             <xsl:if test="@enableMsc2to3 = 'true'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>(选中该项将自动转换MSC为MSC3)
          </td>
        </tr>
        <tr><td><input type="hidden" id="appid" value="{@appid}"/></td></tr>
		   <tr>
		  	 <td align="right">
		  		<input type="button" class="button"  id="btnOK" name="btnOK" onclick="javascript:SaveOrUpdate('{@appid}');" value=" 确认提交 "/>
		  		<input type="button" class="button"  id="btnOK" name="btnOK" onclick="javascript:location.href='/mdpdhmi/config.jsp';" value=" 返回列表 "/>
         </td>
        <td>
		</td>
		</tr>	     
	    </table>
  </xsl:template>
 
</xsl:stylesheet>