<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
  <xsl:choose>
  <xsl:when test="//error/. != ''">
  <table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
  <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';" style="cursor:pointer;">
      <td align="left" style="padding:3px;" colspan="10">
      <xsl:if test="//list/@parentPath">
      <xsl:attribute name="onclick">javascript:getMdpConfig('<xsl:value-of select="//list/@parentPath"/>');</xsl:attribute>      
      <img src="/theme/images/up.gif" />
      &#160;
        返回上级目录
        </xsl:if>
      </td>
    </tr>
    <tr>
    	<td>
  			<xsl:value-of select="//error/." />
  		</td>
  	</tr>
  	</table>
  </xsl:when>
  <xsl:otherwise>
  		<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff" >
  	<!-- header -->
		<tr class="header">
		  <td width="30%" class="list_title_bg"><div><span class="href_12px_blue_bold">名称</span></div></td>
		  <td class="list_title_bg"><span class="href_12px_blue_bold">修改日期</span></td>
		  <td class="list_title_bg"><span class="href_12px_blue_bold">类型</span></td>
		  <td class="list_title_bg"><span class="href_12px_blue_bold">大小</span></td>
		  <td class="list_title_bg"><span class="href_12px_blue_bold"></span></td>
		</tr>
	<!-- Content -->
		<xsl:if test="//list">
		
	<tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';" style="cursor:pointer;">
      <td align="left" style="padding:3px;" colspan="10">
      <xsl:if test="//list/@parentPath">
      <xsl:attribute name="onclick">javascript:getMdpConfig('<xsl:value-of select="//list/@parentPath"/>');</xsl:attribute>      
      <img src="/theme/images/up.gif" />
      &#160;
        返回上级目录
        </xsl:if>
      </td>
    </tr>
		
		
			<xsl:apply-templates  select="//list/dir"/>
			<xsl:apply-templates  select="//list/file"/>
		</xsl:if>
	<!-- footer -->
	<tr>
     </tr>
  	</table>
  </xsl:otherwise>
  </xsl:choose>
  
  
  </xsl:template>

  <xsl:template match="dir|file">
    <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';" style="cursor:pointer;">
      <td align="left" style="padding:3px;border-bottom:1px #ccc solid;">
      <xsl:attribute name="onclick">
      <xsl:choose>
       <xsl:when test="name()='dir'">
       javascript:getMdpConfig('<xsl:value-of select="@path"/>');
       </xsl:when>
       <xsl:otherwise>
       javascript:downloadFile('<xsl:value-of select="@path"/>');
       </xsl:otherwise>
      </xsl:choose>
      
      
      </xsl:attribute>
      <xsl:choose>
      <xsl:when test="name()='dir'">
      <img src="/images/folder.png" />
      </xsl:when>
      <xsl:otherwise>
      <img src="/images/file.png" />
      </xsl:otherwise>
      </xsl:choose>
      &#160;
        <xsl:value-of select="@name"/>
      </td>
      <td style="border-bottom:1px #ccc solid; color:gray;">
      <xsl:value-of select="@lastModifyDate"/>
      </td>
      <td align="left" style="border-bottom:1px #ccc solid;color:gray;">
       <xsl:choose>
      <xsl:when test="name()='dir'">
      文件夹
      </xsl:when>
      <xsl:otherwise>
      <xsl:value-of select="substring-after(@name,'.')"/>文件
      </xsl:otherwise>
      </xsl:choose>
      </td>
      <td align="left" style="border-bottom:1px #ccc solid;color:gray;">
	  <xsl:value-of select="@size"/>&#160;
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
