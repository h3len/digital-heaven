<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="/root">
		<div id="leftMenu_Box">
			<div id="leftMenu">
				<!-- START OF MENU -->
				<div id="left_topbg"></div>
				<div id="dhtmlgoodies_slidedown_menu">
					<ul>
						<xsl:apply-templates select="/root/category"></xsl:apply-templates>
					</ul>
				</div>
				<div id="left_botbg"></div>
				<!-- END OF MENU -->
			</div>
		</div>

	</xsl:template>
	<!--应用模板结束-->
	<xsl:template match="category">
		<li>
			<a href="{@url}" hideFocus="true" target="{@target}">
				<img src="../theme/images/left/{@logohref}" />
			</a>
			<ul class="left_submenu">
				<xsl:apply-templates select="childcat"></xsl:apply-templates>
			</ul>
		</li>
	</xsl:template>
	<xsl:template match="childcat">
		<li>
			<xsl:choose>
				<xsl:when test="@url!='zq.118114.cn'">
					<a href="{@url}" target="{@target}">
						<xsl:value-of select="@catename" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a href="http://{@url}" target="{@target}">
						<xsl:value-of select="@catename" />
					</a>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
</xsl:stylesheet>
