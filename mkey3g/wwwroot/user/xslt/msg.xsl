<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:template match="/root">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

<tr>
<td>

<table width="100%" border="0" cellspacing="0"
				cellpadding="0" >
				<tr>
					<td width="10%" class="list_title_bg">
						<div align="left">
							<input type="checkbox" id="sms_selall"
								onclick="checkall()" title="全选/不选" />
						</div>
					</td>
					<td width="35%" class="list_title_bg"><span class="href_12px_blue_bold">信息内容</span></td>
					<td width="15%" class="list_title_bg"><span class="href_12px_blue_bold">是否已处理</span></td>
					<td width="20%" class="list_title_bg"><span class="href_12px_blue_bold">创建日期</span></td>
					<td width="20%" class="list_title_bg"><span class="href_12px_blue_bold">处理日期</span></td>
				</tr>
				<!--应用模板开始-->
				<xsl:apply-templates select="/root/msg">
				</xsl:apply-templates>
				<!--应用模板结束-->
			</table>

</td></tr>
<tr>
	<td colspan="5" align="center" class="page"> 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalsize" /> </font>条记录 共<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@totalpage" /> </font>页 当前第<font class="bolderred"> <xsl:value-of select="/root/pagenumlist/@currentpage" /> </font>页 
	  <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>[ 首页 ]</font><xsl:text> </xsl:text>
      <xsl:apply-templates select="/root/pagenumlist/pagenum"/>
      <font class="bolder" style="cursor:pointer;"><xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of select="/root/pagenumlist/@totalpage" />");</xsl:attribute>[ 末页 ]</font>
	</td>
</tr>
</table>
	</xsl:template>
	<xsl:template match="msg">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';"
			 >
			
			<td class="list_tr">
				<div align="left">
					<input type="checkbox" value="{@id}" name="sms"
						onclick="isallsel('sms')" />
		</div>
			</td>
			<td>
				<div align="left" style ="word-break:break-all">
					<xsl:value-of select="@msgcontent" />
				</div>
			</td>
			<td>
				<div align="left">
					<img src="../skin/default/images/icon_run.gif"
						 id="img{@id}">
						<xsl:choose>
							<xsl:when test="@remind= '0'">
								<xsl:attribute name="src">
									../skin/default/images/icon_email.gif
								</xsl:attribute>
							</xsl:when>
							<xsl:when test="@remind = '1'">
								<xsl:attribute name="src">
									../skin/default/images/icon_mailR.gif
								</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</img>
				</div>
			</td>
			<td>
				<div align="left">
					<xsl:value-of select="@createtime" />
				</div>
			</td>

			<td>
				<div align="left">
				<xsl:value-of select="@remindtime" />
				</div>
			</td>

		</tr>
		

	</xsl:template>
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
