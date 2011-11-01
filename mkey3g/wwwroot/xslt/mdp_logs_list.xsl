<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
    <div >
      <xsl:if test="/list/logs/@scale != ''">
         <div width="100%" align="right">
          <font color="#FF0000">
          成功数/总数[<font class="bolderred"><xsl:value-of select="/list/logs/@suc"/>/<xsl:value-of select="/list/logs/@logsCount"/></font>],成功率<xsl:value-of select="/list/logs/@scale" />
          [<a href="javascript:exportToXls('{/list/logs/@logsCount}','{/list/logs/@suc}','{/list/logs/@scale}','xls')">导出为excel</a>]
          [<a href="javascript:exportToXls('{/list/logs/@logsCount}','{/list/logs/@suc}','{/list/logs/@scale}','xml')">导出为xml</a>]
          [<a href="javascript:exportToXls('{/list/logs/@logsCount}','{/list/logs/@suc}','{/list/logs/@scale}','html')">导出为html</a>]
          </font>
         </div>
      </xsl:if>
    	<table width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
	    <!-- header -->
	    <tr class="header">
	      <td class="list_title_bg" align="center"><div></div></td>
	      <td class="list_title_bg"><div align="center"><span class="href_12px_blue_bold">业务系统</span></div></td>
	      <td class="list_title_bg" align="center"><div class="href_12px_blue_bold">用户</div></td>
	      <td width="30%" class="list_title_bg" align="center"><div><span class="href_12px_blue_bold">请求地址</span></div></td>
	      <td class="list_title_bg" align="center"><span class="href_12px_blue_bold">请求方式</span></td>
	      <td class="list_title_bg" align="center"><span class="href_12px_blue_bold">状态码</span></td>
	      <td class="list_title_bg" align="center"><div><span class="href_12px_blue_bold">请求时间</span></div></td>
	      <td class="list_title_bg" align="center"><span class="href_12px_blue_bold">响应(秒)</span></td>
	      <td class="list_title_bg" align="center"><span class="href_12px_blue_bold">描述</span></td>
	      <td class="list_title_bg"><span class="href_12px_blue_bold">操作</span></td>
	    </tr>
  		
    <!-- Content -->
	    <xsl:if test="//list/logs/log">
		    <xsl:apply-templates  select="//list/logs" mode="logs"/>
	    </xsl:if>
    <!-- footer -->
	    <tr>
		    <td colspan="10" align="center" class="page"> 
          共<font class="bolderred"><xsl:value-of select="/list/logs/@logsCount" /></font>条数据,
			    共<font class="bolderred"><xsl:value-of select="/list/logs/@pageCount" /> </font>页 
			    当前第<font class="bolderred"> 
			  	 	    <xsl:value-of select="/list/logs/@pageId" /> 
			  	     </font>页 
			    <xsl:if test="/list/logs/log">
				    <font class="bolder" style="cursor:pointer;">
					    <xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
					    [ 首页 ]
				    </font>
				    <xsl:text> </xsl:text>
				    <xsl:apply-templates select="/list/pagelist/page"/>
				    <font class="bolder" style="cursor:pointer;">
					    <xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/list/logs/@pageCount" />");</xsl:attribute>
					    [ 末页 ]
				    </font>
			    </xsl:if>
		    </td>
	    </tr>
	    </table>
    </div>
  
  </xsl:template>

  <xsl:template match="logs" mode="logs">
     <xsl:choose>
       <xsl:when test="log">
         <xsl:apply-templates select="log" mode="log" />
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

  <xsl:template match="log" mode="log">
    <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
      <td style="height:30px;" align="center" class="ac">
        &#160;<xsl:choose>
          <xsl:when test="@isSuc = '0'">
            <img src="/mdp/images/false.gif" />
          </xsl:when>
          <xsl:otherwise>
            <img src="/mdp/images/true.gif" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td align="center">
        <xsl:value-of select="@appid"/>
      </td>
      <td align="center">
        <xsl:attribute name="onclick">javascript:copyToClipboard("<xsl:value-of select="@operateUserName"/>");</xsl:attribute>
        <xsl:attribute name="title">点击复制:<xsl:value-of select="@operateUserName"/></xsl:attribute>
        <xsl:value-of select="@operateUserName"/>
      </td>
      <td align="center" onMouseOut="document.body.style.cursor='default';" onMouseOver="document.body.style.cursor='hand';">
        <xsl:attribute name="onclick">javascript:copyToClipboard("<xsl:value-of select="@requestUrl"/>");</xsl:attribute>
        <xsl:choose>
          <xsl:when test="string-length(@requestUrl) &gt; 40">
            <xsl:attribute name="title">点击复制:<xsl:value-of select="@requestUrl"/></xsl:attribute>
            <xsl:value-of select="substring(@requestUrl,0,40)"/>...
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="title">点击复制:<xsl:value-of select="@requestUrl"/></xsl:attribute>
            <xsl:value-of select="@requestUrl"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td align="center">
        <xsl:value-of select="@requestMethod"/>
      </td>
      <td align="center">
	      <xsl:value-of select="@responseStatus"/>
      </td>
      <td align="center" onMouseOut="document.body.style.cursor='default';" onMouseOver="document.body.style.cursor='hand';">
        <xsl:attribute name="onclick">javascript:copyToClipboard("<xsl:value-of select="@operateTime"/>");</xsl:attribute>
        <xsl:attribute name="title">点击复制:<xsl:value-of select="@operateTime"/></xsl:attribute>
        <xsl:value-of select="@operateTime"/>
      </td>
      <td align="center">
        [<xsl:value-of select="@responseTimeCount"/>]
      </td>
      <td align="center">
        <xsl:choose>
          <xsl:when test="string-length(@note) &gt; 20">
           <xsl:attribute name="onclick">javascript:copyToClipboard("<xsl:value-of select="@note"/>");</xsl:attribute>
            <xsl:attribute name="title">点击复制:<xsl:value-of select="@note"/></xsl:attribute>
            <xsl:value-of select="substring(@note,0,20)"/>...
          </xsl:when>
          <xsl:otherwise>
           <xsl:attribute name="onclick">javascript:copyToClipboard("<xsl:value-of select="@note"/>");</xsl:attribute>
            <xsl:attribute name="title">点击复制:<xsl:value-of select="@note"/></xsl:attribute>
            <xsl:value-of select="@note"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <input type="button" class="button" value="详情" onclick='javascript:GB_showCenter("日志详情", "/mdp/mdp_logs_detail.jsp?logid={@logid}",550,878);' />
      </td>
    </tr>
    <tr>
      <td colspan="50" class="list_line"></td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
