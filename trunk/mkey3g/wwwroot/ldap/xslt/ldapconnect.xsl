<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="ldap">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr class="list_title_bg blue">
				<td width="15%" align="center">
					<font class="font_14">字段名</font>
				</td>
				<td width="10%" align="center">
					<font class="font_14">字段类型</font>
				</td>
				<td width="10%" align="center">
					<font class="font_14">字段长度</font>
				</td>
				<td width="10%" align="center">
					<font class="font_14">允许为NULL</font>
				</td>
				<td width="30%" align="center">
					<font class="font_14">对应LDAP字段名</font>
				</td>
				<td width="25%" align="center">
					<font class="font_14">默认值</font>
				</td>
			</tr>
			<xsl:apply-templates select="/ldap/ldapinfo">
			</xsl:apply-templates>
		</table>
	</xsl:template>
	<!-- 信息显示记录 -->
	<xsl:template match="/ldap/ldapinfo">
		<tr onmouseover="this.className='tr_over';"
			onmouseout="this.className='tr_out';">
			<td align="left">
				<font class="font_14">
					<xsl:value-of select="@field_name" />
				</font>
			</td>
			<td align="center">
				<font class="font_14">
					<xsl:value-of select="@field_type" />
				</font>
			</td>
			<td align="center">
				<font class="font_14">
					<xsl:value-of select="@field_precision" />
				</font>
			</td>
			<td align="center">
				<font class="font_14">
					<xsl:if test="@nullable=1">是</xsl:if>
					<xsl:if test="@nullable=0">否</xsl:if>
				</font>
			</td>
			<td align="center">
				<input type="text" name="ldap_field_name"
					maxlength="100" class="input_text" 
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)">
					<xsl:attribute name="id">
	              		<xsl:value-of select="@id" />
	            	</xsl:attribute>
	            	<xsl:attribute name="value">
	              		<xsl:value-of select="@ldap_field_name" />
	            	</xsl:attribute>
				</input>
			</td>
			<td align="center">
				<input type="text" name="ldap_field_value"
					maxlength="100" class="input_text" 
					onmouseover="fEvent('mouseover',this)"
					onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"
					onmouseout="fEvent('mouseout',this)">
					<xsl:attribute name="id">
	              		<xsl:value-of select="@id" />
	            	</xsl:attribute>
	            	<xsl:attribute name="value">
	              		<xsl:value-of select="@ldap_field_value" />
	            	</xsl:attribute>
				</input>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
