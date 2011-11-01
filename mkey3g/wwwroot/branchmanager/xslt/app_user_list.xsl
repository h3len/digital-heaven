<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/root">
  <table class="table01" width="98%" cellspacing="0" cellpadding="3">
            <tr class="bold">
              <td width="30%"><a href="javascript:checkall();" >全选</a> / <a href="javascript:inverse();" >反选</a></td>
              <td width="30%">姓名</td>
              <td width="30%">手机号</td>
            </tr>
            
	<xsl:apply-templates select="/root/user"></xsl:apply-templates>
	<tr>
	<td colspan="3" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <br/>
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
		</td>
	</tr>
          </table>  
 </xsl:template>
      <!--应用模板结束-->

	
	<xsl:template match="user">
			 <tr>
			  <td><input type="checkbox" name="idmark" value="'{@sysid}'" /></td>
              <td><xsl:value-of select="@sysusername"/></td>
              <td><xsl:value-of select="@mobile"/></td>
              <!-- <td><xsl:value-of select="@createtime"/></td> -->
            </tr>
	</xsl:template>
<!-- 分页模板 -->   
 <xsl:template match="pagenum">  
  <xsl:choose>
  	<xsl:when test="@iscurrentpage='true'">
  	[<font class="bolderred" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute><xsl:value-of select="@page" /></font>]<xsl:text> </xsl:text>
  	</xsl:when>
    <xsl:when test="@iscurrentpage='false'">
  	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="@page" />");</xsl:attribute><xsl:value-of select="@page" /></font><xsl:text> </xsl:text>
  	</xsl:when>
  </xsl:choose> 
  </xsl:template>


</xsl:stylesheet>
