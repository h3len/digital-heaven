<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
  	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
  	<!-- header -->
		<tr class="header">
		  <td class="list_title_bg"><div></div></td>
		  <td width="13%" class="list_title_bg" align="center"><div class="href_12px_blue_bold">所在集团</div></td>
		  <td width="15%" class="list_title_bg"><div><span class="href_12px_blue_bold">绑定用户</span></div></td>
		  <td width="15%" class="list_title_bg"><div><span class="href_12px_blue_bold">绑定系统ID</span></div></td>
		  <td width="15%" class="list_title_bg"><span class="href_12px_blue_bold">绑定系统用户</span></td>
		  <td width="18%" class="list_title_bg"><span class="href_12px_blue_bold">绑定手机号</span></td>
		  <td width="18%" class="list_title_bg"><span class="href_12px_blue_bold">操作</span></td>
		</tr>
		
	<!-- Content -->
		<xsl:if test="/root/exts/ext">
			<xsl:apply-templates  select="/root/exts" mode="exts"/>
		</xsl:if>
	<!-- footer -->
		<tr>
			<td colspan="10" align="center" class="page"> 
				共<font class="bolderred"><xsl:value-of select="/root/@logsCount" /></font>条记录 
				共<font class="bolderred"><xsl:value-of select="/root/@pageCount" /> </font>页 
				当前第<font class="bolderred"> 
				  	 	<xsl:value-of select="/root/@pageId" /> 
				  	 </font>页 
				<xsl:if test="/root/exts/ext">
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
						[ 首页 ]
					</font>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="/root/pages/page"/>
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/@pageCount" />");</xsl:attribute>
						[ 末页 ]
					</font>
				</xsl:if>
			</td>
		</tr>
  	</table>
  </xsl:template>

  <xsl:template match="exts" mode="exts">
     <xsl:choose>
       <xsl:when test="ext">
         <xsl:apply-templates select="ext" mode="ext" />
       </xsl:when>
     </xsl:choose>
  </xsl:template>
  
  
   <xsl:template match="page">  
	  <xsl:choose>
	  	<xsl:when test="@cur = 'true'">
	  		[<font class="bolderred" style="cursor:pointer;">
	  			<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute>
	  			<xsl:value-of select="@page" />
	  		</font>]
	  		<xsl:text> </xsl:text>
	  	</xsl:when>
	    <xsl:otherwise>
	  		<font class="bolder" style="cursor:pointer;">
	  			<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute>
	  			<xsl:value-of select="@page" />
	  		</font>
	  		<xsl:text> </xsl:text>
	  	</xsl:otherwise>
	  </xsl:choose> 
  </xsl:template>

  <xsl:template match="ext" mode="ext">
    <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
      <td style="height:30px;" class="ac">
        <img src="/skin/default/images/list_icon.gif" />
      </td>
      <td align="center">
        <xsl:value-of select="@enterpriseName"/>
      </td>
      <td align="left">
        <xsl:value-of select="@username"/>
      </td>
      <td align="left">
        <xsl:value-of select="@sysid"/>
      </td>
      <td align="left">
        <xsl:value-of select="@oauser"/>
      </td>
      <td align="left">
        <xsl:value-of select="@mobile"/>
      </td>
      <td align="left">
        <input class="button" type="button" value="编辑" onclick="javascript:loadUpdateWin('{@id}');"  />
        <input class="button" type="button" value="删除" onclick="javascript:del('{@id}');" />
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
