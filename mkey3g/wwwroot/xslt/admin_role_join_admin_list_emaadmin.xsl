<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

  <table width="100%" class="border" cellpadding="5" cellspacing="0">
      <tr class="list_title_bg">
        <td width="20%"><div class="href_12px_blue_bold">序号</div></td>
        <td width="25%"><div class="href_12px_blue_bold">用户名</div></td>        
        <td width="25%"><div class="href_12px_blue_bold">管理集团/部门</div></td>
        <!--  
        <td width="30%"><div class="href_12px_blue_bold">创建日期</div></td>
        -->
        <td class="25%"><div class="href_12px_blue_bold">操 作</div></td>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/userlist/user"></xsl:apply-templates>
      <!--应用模板结束-->
      <tr>
		<td colspan="5" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
		  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
	      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
		  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
		</td>
	</tr>
      </table>
  </xsl:template>
  
  <xsl:template match="user">
   <tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
     <xsl:attribute name="id">tr_<xsl:value-of select="@id"/></xsl:attribute>
     <xsl:if test="position() mod 2 = 1">
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
     </xsl:if>     
     <td class="ac b">
       <xsl:value-of select="position()"/>
     </td>
      <td style="padding-left:4px;">
       <xsl:choose>
        <xsl:when test="@usetruename='true'"><xsl:value-of select="@truename" /></xsl:when>
        <xsl:otherwise><xsl:value-of select="@username" /></xsl:otherwise>
        </xsl:choose>
    </td>
    <td>
      <xsl:value-of select="@catalogname"/>
    </td>
   <!-- 
    <td>
      <xsl:value-of select="@createtime"/>
    </td>
     -->
    <td>
      <input disabled="true" type="button" class="button_4" value="退出角色">
        <xsl:attribute name="onclick">
          javascript:UnJoinUser("<xsl:value-of select="@id"/>");
        </xsl:attribute>
      </input>
    </td>
  </tr>
  <tr>
		<td colspan="5" class="list_line"></td>
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
