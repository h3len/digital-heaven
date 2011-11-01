<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/root">
  
  <table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
            <tr class="bold lmtd2 list_title_bg"  align="center">
            	<br/>
            	<td width="15%"></td>
            	<td width="15%">管理员名称</td>
              	<td width="15%">管理员姓名</td>
                <td width="55%">操作</td>

            </tr>

	<xsl:apply-templates select="/root/list/adminuser"></xsl:apply-templates>
	<tr>
	<td colspan="8" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
		</td>
	</tr>
 </table>
 </xsl:template>
      <!--应用模板结束-->

	<xsl:template match="adminuser">
			 <tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
			 
 			 	<td style="text-align:center">
		 			
			 	</td>
			 	

			 	<td style="text-align:center">
		 			<xsl:value-of select="@manager" />
			 	</td>
			 	
			 	<td style="text-align:center">
		 			<xsl:value-of select="@username" />
			 	</td>
			 	<td style="text-align:center">
			 		<!-- 隐藏的获取值的div_start -->
					<div align="center"  style="display:none">
						<input name="realnames" id="inputrealname{@adminid}" type="input" value="{@username}" ></input>
					</div>
					
					
		 			<input type="button" value="修改"  class="button_2" onclick="javascript:updataAdminUser('{@adminid}')"/>
		 			<xsl:text> </xsl:text>
		 			<input type="button" value="删除"  class="button_2" onclick="javascript:delAdminUser('{@adminid}')"/>
		 			<xsl:text> </xsl:text>
		 			<input type="button"  class="button_4"  value="重置密码"><xsl:attribute name="onclick">javascript:CZ('<xsl:value-of select="@adminid" />');</xsl:attribute></input>
			 		
			 	</td>
			 	
			  <tr>
			<td colspan="5" class="list_line"></td>
			</tr>
			 
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