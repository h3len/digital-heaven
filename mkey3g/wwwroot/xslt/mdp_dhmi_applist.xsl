<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
  
  <xsl:choose>
  	<xsl:when test="/root/@type = 'branches'">
  		<!-- 企业列表  -->
  		企业列表：
  		<select id="enterpriseSelect" onchange="javascript:getAppListById(this.value)">
  			<xsl:apply-templates select="/root/list/branch" />
  		</select>
  	</xsl:when>
  	<xsl:otherwise>
  		<!-- 应用列表 -->
  		<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
  		<!-- header -->
		<tr class="header">
		  <td class="list_title_bg"><div></div></td>
		  <td width="70%" class="list_title_bg" align="left"><div class="href_12px_blue_bold">业务系统名称</div></td>
		  <td width="18%" class="list_title_bg"><span class="href_12px_blue_bold">操作</span></td>
		</tr>
		
		<!-- Content -->
		<xsl:if test="/root/list/app">
			<xsl:apply-templates  select="//app"/>
		</xsl:if>
	
  	</table>
  	</xsl:otherwise>
  </xsl:choose>
  	
  </xsl:template>


  <xsl:template match="app">
    <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
      <td style="height:30px;" class="ac">
        <img src="/skin/default/images/list_icon.gif" />
      </td>
      <td align="left">
        <xsl:value-of select="@appname"/>
      </td>
      <td align="left">
        <input class="button" type="button" value="设置" onclick="javascript:getDhmiConfig('{@appid}');"  />
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="branch">
 	 <option value="{@id}"><xsl:value-of select="@name" /></option>  
  </xsl:template>

</xsl:stylesheet>
