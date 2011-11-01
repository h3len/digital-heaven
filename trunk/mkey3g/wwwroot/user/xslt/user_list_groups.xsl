<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/root">
  <table class="table01" width="98%" cellspacing="0" cellpadding="4">
            <tr class="bold">
              <td width="15%">姓名</td>
              <td width="15%">手机号</td>
              <td width="20%">家庭住址</td>
              <!-- <td width="20%">创建时间</td> -->
               <td width="30%">操作</td>
            </tr>
            
	<xsl:apply-templates select="/root/user"></xsl:apply-templates>
	<tr>
	<td colspan="5" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
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
              <td><a href="#" onclick="showuser('{@id}')"><xsl:value-of select="@username"/></a></td>
              <td><xsl:value-of select="@mobile"/></td>
              <td>
              	<xsl:choose>
              		<xsl:when test = "string-length(@city)&lt;10">
              			<xsl:value-of select="@city"/>
              		</xsl:when>
              		<xsl:otherwise>
              			<xsl:value-of select="substring(@city,1,10)"/>
              			......
              		</xsl:otherwise>
              	</xsl:choose>
              </td>
              <!-- <td><xsl:value-of select="@createtime"/></td> -->
              <td><input type="button" class="button_2" value="详情" onclick="showuser('{@id}')"/><input type="button" class="button_2" value="修改" onclick="moduser('{@id}')"/>
              <input type="button" class="button_2" value="删除" onclick="deluserfromgroups('{@id}')"/>
              <input type="button" class="button_2" value="转移" onclick="transferuser('{@id}')"/>
               </td>
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
