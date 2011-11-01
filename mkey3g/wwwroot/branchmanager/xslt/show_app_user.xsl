<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/root">
	<input type="hidden" id="count" value="/root/@count"/>
	<table width="100%" cellpadding="0" cellspacing="0">
	
<tr>
<td>
	<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
	
	<tr class="list_title_bg">
		<td></td>
		<td align="center" width="15%" class="list_title_bg">
		<xsl:choose>
			<xsl:when test="/root/@canopapp='true'">
			<a href="javascript:checkall();" >全选</a>/<a href="javascript:inverse();" >反选</a>
			</xsl:when>
		</xsl:choose>
		</td>
		<td width="25%"><div align="center"><span class="blue_12_bold">系统用户名</span></div></td>
		<td width="25%"><div align="center"><span class="blue_12_bold">业务系统用户名</span></div></td>
		<td width="25%"><div align="center"><span class="blue_12_bold">操作</span></div></td>
		</tr>
	   <!--应用模板开始-->
  <xsl:apply-templates select="/root/item"></xsl:apply-templates>         
      <!--应用模板结束-->
      
<tr>
	<td colspan="10" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
	<xsl:apply-templates select="/root/pagenumlist/pagenum"/>
	<font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>    
	</td>
</tr>
</table>

</td></tr>
</table>
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
		<xsl:template match="item">
	<tr onmouseover="this.className='tr_over';"   onmouseout="this.className='tr_out';">
			<td class="list_tr">
				<div align="center">
					<img src="../theme/images/list_icon.gif" width="16"
						height="16" />
				</div>
			</td>
			<td align="center">
			<xsl:choose>
				<xsl:when test="@canopapp='true'">
					<input type="checkbox" name="idmark" value="'{@id}'" />
				</xsl:when>
			</xsl:choose>
			
			
			</td>
			<td><div align="center">
				<xsl:value-of select="@sysusername" /></div>
			</td>
			<td>
				<div align="center">
					<xsl:choose>
						<xsl:when
							test="@appusername!=''">
							<xsl:value-of select="@appusername" />
						</xsl:when>
						<xsl:otherwise>
							未绑定用户
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</td>
			<td><div align="center">
				<input type="button" value="绑定用户"  class="button_4" onclick="javascript:adddappbinduser('{@id}')"/>
				<xsl:choose>
						<xsl:when
							test="@appusername!=''">
							<input type="button" value="解除绑定"  class="button_4" onclick="javascript:unbinduser('{@id}')"/>
						</xsl:when>
				</xsl:choose>
			</div></td>
	</tr>
	<tr>
		<td colspan="4" class="list_line"></td>
	</tr>
	</xsl:template>
</xsl:stylesheet>
