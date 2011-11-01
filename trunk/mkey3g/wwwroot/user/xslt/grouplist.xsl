<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/root">
  <table class="table01" width="98%" cellspacing="0" cellpadding="2">
            <tr class="bold">
            	<td width="15%"><a href="javascript:checkall();" >全选</a> / <a href="javascript:inverse();" >反选</a></td>
            	<td width="18%">排序</td>
              	<td width="28%">群组名称</td>
                <td width="38%">操作</td>
            </tr>
            
	<xsl:apply-templates select="/root/branch"></xsl:apply-templates>
	<tr>
	<td colspan="4" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
		</td>
	</tr>
 </table>  
 </xsl:template>
      <!--应用模板结束-->
	
	<xsl:template match="branch">
			 <tr>
			 	<td><input type="checkbox" name="idmark" value="'{@id}'" /></td>
			 	<td style="text-align:center">
              	  <img alt="上移" src="../theme/images/up.gif" onclick="groupSortUp('{@id}')" onmouseover="this.style.cursor='hand'" onMouseOut="fEvent('mouseout',this)"/>
			      <img alt="下移" src="../theme/images/down.gif" onclick="groupSortDown('{@id}')" onmouseover="this.style.cursor='hand'" onMouseOut="fEvent('mouseout',this)"/>
             	</td>
       			<td><a href="#" onclick="showbranch('{@id}')"><xsl:value-of select="@branchname"/></a></td>
				<td><input type="button" class="button_2" value="修改" onclick="modbranch('{@id}')"/> 
	      			<input type="button" class="button_2" value="删除" onclick="delbranch('{@id}')"/> 
	       			<input type="button" class="button_2" value="详情" onclick="showbranch('{@id}')"/> 
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