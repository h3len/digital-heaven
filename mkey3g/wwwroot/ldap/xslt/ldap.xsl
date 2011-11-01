<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="ldap">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td colspan="10" align="center" class="page">
					共
					<font class="bolderred">
						<xsl:value-of
							select="/ldap/pagenumlist/@totalsize" />
					</font>
					条记录 共
					<font class="bolderred" id="totalpage">
						<xsl:value-of
							select="/ldap/pagenumlist/@totalpage" />
					</font>
					页 当前第
					<font class="bolderred">
						<xsl:value-of
							select="/ldap/pagenumlist/@currentpage" />
					</font>
					页
					<font class="bolder" style="cursor:pointer;"
						id="firstpage">
						<xsl:attribute name="onclick">javascript:ChangePage("1",true);</xsl:attribute>
						<xsl:attribute name="onmouseover">javascript:ChangePage("1",false);</xsl:attribute>
						[ 首页 ]
					</font>
					<font class="bolder" style="cursor:pointer;"
						id="prepage">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@prepage" />",true);</xsl:attribute>
						<xsl:attribute name="onmouseover">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@prepage" />",false);</xsl:attribute>
						[ 上一页 ]
					</font>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="/ldap/pagenumlist/pagenum" />
					<font class="bolder" style="cursor:pointer;"
						id="nextpage">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@nextpage" />",true);</xsl:attribute>
						<xsl:attribute name="onmouseover">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@nextpage" />",false);</xsl:attribute>
						[ 下一页 ]
					</font>
					<font class="bolder" style="cursor:pointer;"
						id="lastpage">
						<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@totalpage" />",true);</xsl:attribute>
						<xsl:attribute name="onmouseover">javascript:ChangePage("<xsl:value-of
								select="/ldap/pagenumlist/@totalpage" />",false);</xsl:attribute>
						[ 末页 ]
					</font>
				</td>
			</tr>
			<tr class="list_title_bg blue">
				<td width="40%" align="center">
					<font class="font_14">URL</font>
				</td>
				<td width="30%" align="center">
					<font class="font_14">DC</font>
				</td>
				<td width="30%" align="center">
					<font class="font_14">操 作</font>
				</td>
			</tr>
			<xsl:apply-templates select="/ldap/ldapinfo">
			</xsl:apply-templates>
		</table>
	</xsl:template>
	<!-- 分页模板 -->
	<xsl:template match="pagenum">
		<xsl:choose>
			<xsl:when test="@iscurrentpage='true'">
				[
				<font class="bolderred" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />",true);</xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of
							select="@page" />
					</xsl:attribute>
					<xsl:attribute name="onmouseover">javascript:ChangePage("<xsl:value-of
							select="@page" />",false);</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				]
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="@iscurrentpage='false'">
				<font class="bolder" style="cursor:pointer;">
					<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
							select="@page" />",true);</xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of
							select="@page" />
					</xsl:attribute>
					<xsl:attribute name="onmouseover">javascript:ChangePage("<xsl:value-of
							select="@page" />",false);</xsl:attribute>
					<xsl:value-of select="@page" />
				</font>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- 信息显示记录 -->
	<xsl:template match="/ldap/ldapinfo">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td align="left">
				<img src="../theme/images/list_icon.gif" />
				<font class="font_14">
					<xsl:value-of select="@url" />
				</font>
			</td>
			<td align="center">
				<font class="font_14">
					<xsl:value-of select="@dc" />
				</font>
			</td>
			<td align="center">
				<input type="button" value="删 除"
					class="button_1">
					<xsl:attribute name="onclick">
	              		javascript:deleteLdap('<xsl:value-of
							select="@id" />');
	            	</xsl:attribute>
				</input>
				<span class="margin_left_5"></span>
				<input type="button" value="修 改"
					class="button_1">
					<xsl:attribute name="onclick">
	              		javascript:editLdap('<xsl:value-of
							select="@id" />');
	            	</xsl:attribute>
				</input>
				<span class="margin_left_5"></span>
				<input  type="button" value="导入数据"
					class="button_2">
					<xsl:attribute name="onclick">
	              		javascript:testLdap('<xsl:value-of
							select="@id" />');
	            	</xsl:attribute>
				</input>
				<!-- span class="margin_left_5"></span>
				<input type="button" value="建立对应关系"
					class="button_4">
					<xsl:attribute name="onclick">
	              		javascript:connect('<xsl:value-of
							select="@id" />');
	            	</xsl:attribute>
				</input-->
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
