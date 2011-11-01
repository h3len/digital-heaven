<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="root">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="100%">
				<div class="submenu">
				<xsl:choose>
					<xsl:when test="/root/keyword/@enableMutiEnterprise='true'">
						<span style="float:left;display:inline;">
							<input class="button_6" name="button" value="添加邮箱配置" type="button" id="addmailconfig"
									onclick="javascript:showgenerallymailConfig('');"></input>
							<input class="button_2" name="button" value="删除" type="button"
									onclick="javascript:delAllSelect();"></input>
						</span>
					</xsl:when>
				</xsl:choose>
				<span style="float:right;display:inline">
					<select name="search_type" id="search_type">
						<option value="mailconfigname">按邮箱名</option>
						<option value="emailstyle">按邮箱类型</option>
						<option value="mailserver">按邮件服务器地址</option>
					</select>
					<input type="text" id="keyword"><xsl:attribute name="value"><xsl:value-of select="/root/keyword/@keyword" /></xsl:attribute></input>
					<input type="hidden" id="check_keyword">
						<xsl:attribute name="value"><xsl:value-of select="/root/keyword/@keyword" /></xsl:attribute>
					</input>
					<input type="hidden" id="check_search_type">
						<xsl:attribute name="value"><xsl:value-of select="/root/keyword/@search_type" /></xsl:attribute>
					</input>
					<input type="button" class="button_2" value="查询" onclick="javascript:searchmailconfig('serch')"></input>
				</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
						<tr class="list_title_bg">
						<xsl:choose>
						<xsl:when test="/root/keyword/@enableMutiEnterprise='true'">
			              <td width="6%" align="left"><a href="javascript:checkAll();" >全选</a>|<a href="javascript:inverse();" >反选</a></td>
			              </xsl:when>
			              </xsl:choose>
			              <td width="4%"></td>
			              <td width="27%" align="left">邮箱名</td>
			              <td width="24%" align="left">邮箱类型</td>
			              <td width="23%" align="left">邮件服务器地址</td>
			              <td width="15%" align="center">操作</td>
						</tr>
						<!--应用模板开始-->
						<xsl:apply-templates select="/root/list/mailconfig" />
						<tr>
							<td colspan="10" align="center" class="page" style="font-size:12px">
								共
								<font class="bolderred">
									<xsl:value-of select="/root/pagenumlist/@totalsize" />
								</font>
								条记录 共
								<font class="bolderred">
									<xsl:value-of select="/root/pagenumlist/@totalpage" />
								</font>
								页 当前第
								<font class="bolderred">
									<xsl:value-of select="/root/pagenumlist/@currentpage" />
								</font>
								页
								<font class="bolder" style="cursor:pointer;">
									<xsl:attribute name="onclick">javascript:ChangePage("1");</xsl:attribute>
									[ 首页 ]
								</font>

								<xsl:text> </xsl:text>
								<xsl:apply-templates select="/root/pagenumlist/pagenum" />
								<font class="bolder" style="cursor:pointer;">
									<xsl:attribute name="onclick">javascript:ChangePage("<xsl:value-of
										select="/root/pagenumlist/@totalpage" />");</xsl:attribute>
									[ 末页 ]
								</font>
							</td>
						</tr>
						<!--应用模板结束-->
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
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
	<!-- item数据模块 -->
	<xsl:template match="mailconfig">
		<tr onmouseover="this.className='tr_over';" onmouseout="this.className='tr_out';">
			<td align="center">
				<input type="checkbox" name="mark" value="{@id}" />
			</td>
            <td></td>
            <td align="left"><a href="#" onclick="showmailConfig('{@id}')"><xsl:value-of select="@mailconfigname"/></a></td>
			<td align="left"><xsl:value-of select="@emailstyle" /></td>
			<td align="left"><xsl:value-of select="@mailserver" /></td>
			<td>
				<input class="button_2" type="button" value="详 情" onclick="showmailConfig('{@id}')"/>
				<input class="button_2" type="button" value="修改信息" onclick="showgenerallymailConfig('{@id}')"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
