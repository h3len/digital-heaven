<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<table width="100%" class="text_align_center" cellspacing="0"
			cellpadding="4">
			<tr class="list_title_bg">
				<td width="10%"><a href="javascript:checkAll();" >全选</a>|<a href="javascript:inverse();" >反选</a></td>
              	<td width="8%"  style="text-align:center">排序</td>
              	<td width="25%" style="text-align:left">姓名</td>
              	<td width="18%" style="text-align:left">手机号</td>
              	<td width="12%">是否业务用户</td>
              	<td >操作</td>
			</tr>

			<xsl:apply-templates select="/root/user"></xsl:apply-templates>
			<tr>
				<td colspan="7" align="center" class="page">
					共
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@totalsize" />
					</font>
					条记录 共
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@totalpage" />
					</font>
					页 当前第
					<font class="bolderred">
						<xsl:value-of
							select="/root/pagenumlist/@currentpage" />
					</font>
					页
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
						[ 首页 ]
					</font>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="/root/pagenumlist/pagenum" />
					<font class="bolder" style="cursor:pointer;">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
								select="/root/pagenumlist/@totalpage" />");</xsl:attribute>
						[ 末页 ]
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--应用模板结束-->


	<xsl:template match="user">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';" height="24px">
			<td>
              	<input type="checkbox" name="mark" value="{@id}" />
            </td>
			  <td style="text-align:center">
              	  <img alt="上移" src="../theme/images/up.gif" onclick="sortuserup('{@id}')" onmouseover="this.style.cursor='hand'" onMouseOut="fEvent('mouseout',this)"/>
			      <img alt="下移" src="../theme/images/down.gif" onclick="sortuserdown('{@id}')" onmouseover="this.style.cursor='hand'" onMouseOut="fEvent('mouseout',this)"/>
              </td>
			<td style="text-align:left">
				<a href="#" onclick="showuser('{@id}')">
					<xsl:value-of select="@username" />
				</a>
			</td>
			<td style="text-align:left">
				<xsl:value-of select="@mobile" />
			</td>
			<td>
				<xsl:if test="@ismipuser = 'true'">
					<a href="#" onclick="enableuser('{@id}',0)">
						<img src="../images/true.gif" />
					</a>
				</xsl:if>
				<xsl:if test="@ismipuser = 'false'">
					<a href="#" onclick="enableuser('{@id}',1)">
						<img src="../images/false.gif" />
					</a>
				</xsl:if>
			</td>
			<td>
				<input class="button_2" type="button" value="详 情"
					onclick="showuser('{@id}')" />
				<xsl:if test="@canoperateuser = 'true'">
					<input class="button_2" type="button" value="修改信息"
						onclick="moduser('{@id}')" />
					<xsl:if test="@ismipuser = 'true'">
						<input class="button_2" type="button" value="修改密码"
							onclick="changepass('{@id}')" />
					</xsl:if>
					<xsl:if test="@ismipuser = 'false'">
						<input class="button_2" type="button" value="修改密码"
							onclick="DHalert('非业务用户没有密码！');" />
					</xsl:if>
				</xsl:if>
				<input type="button" class="button_6" value="手机信息绑定"
					onclick="threeBindByuid('{@id}')" />
				<input type="button" class="button_2" value="用户证书"
					onclick="showcert('{@id}')"/>
				<xsl:if test="@freeze ='1'">
					<input type="button" class="button_2" value="解冻"
						onclick="freeze('{@id}')" />
				</xsl:if>
				<xsl:apply-templates select=".//button"></xsl:apply-templates>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="list_line"></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="button">
		<input type="button" class="button_2" value="{@name}"
						onclick="extendbutton('{@id}','{@name}','{@url}')" />
	</xsl:template>
	<!-- 分页模板 -->
	<xsl:template match="pagenum">
		<xsl:choose>
			<xsl:when test="@iscurrentpage='true'">
				[
				<font class="bolderred" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				]
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="@iscurrentpage='false'">
				<font class="bolder" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />");</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
