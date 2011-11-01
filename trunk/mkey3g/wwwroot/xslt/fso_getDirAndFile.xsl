<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/root">

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td>名称</td>
      <td align="left">大小</td>
      <td align="center" width="8%">类型</td>
      <td align="center" width="25%">修改日期</td>
      <td align="center" width="10%">操作</td>
    </tr>
    <tr>
      <td colspan="5" height="4"><hr color="#7EABE7" style="height:1px"/></td>
    </tr>
	<xsl:apply-templates select="dirs/root/dir">
        <xsl:sort select="." order="ascending"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="files/root/file">
    	<xsl:sort select="name" order="ascending"/>
    </xsl:apply-templates>
    <tr>
      <td colspan="5" height="4"><hr color="#7EABE7" style="height:1px"/></td>
    </tr>
    <tr>
      <td colspan="5" align="right">
      	<xsl:value-of select="count(dirs/root/dir)"/>个文件夹，
      	<xsl:value-of select="count(files/root/file)"/>个文件，
      	<xsl:value-of select="sum(files/root/file/@filesize)"/>K
      </td>
    </tr>
</table>
</xsl:template>
<xsl:template match="dirs/root/dir">
	<tr>
		<td>			
			 <xsl:choose>
				<xsl:when test="@possess='private'">
	        		<input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@path"/></xsl:attribute></input>
				</xsl:when>
				<xsl:when test="@possess='common'">
					<xsl:if test="@managermobiledisk='yes'">
						<input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@path"/></xsl:attribute></input>			
					</xsl:if>		       
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
						
			<xsl:element name="a">
				<xsl:attribute name="href">#</xsl:attribute>
				<xsl:attribute name="path"><xsl:value-of select="@path"/></xsl:attribute>
				<xsl:attribute name="onclick">javascript:getDirAndFile(this.path,"<xsl:value-of select="@possess"/>");showOnTree(this.path,"<xsl:value-of select="@possess"/>");return false;</xsl:attribute>
				<img src="../images/icons/folder.png" border="0"/>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				<xsl:value-of select="."/>
			</xsl:element>
		</td>
		<td align="left">　</td>
		<td align="center">文件夹</td>
		<td align="center"><xsl:value-of select="substring(@datelastmodified,1,20)"/></td>
        <td align="center">
        
        
         <xsl:choose>
			<xsl:when test="@possess='private'">
        		<a><xsl:attribute name="href">#</xsl:attribute>
        		<xsl:attribute name="onclick">javascript:filerename("<xsl:value-of select='@path'/>","<xsl:value-of select="."/>");</xsl:attribute>改名</a>
			</xsl:when>
			<xsl:when test="@possess='common'">
				<xsl:choose>
					<xsl:when test="@managermobiledisk='yes'">
						<a><xsl:attribute name="href">#</xsl:attribute>
		        		<xsl:attribute name="onclick">javascript:adminfilerename("<xsl:value-of select='@path'/>","<xsl:value-of select="."/>");</xsl:attribute>改名</a> 					
					</xsl:when>
					<xsl:otherwise>
						无权限
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			无权限
			</xsl:otherwise>
		</xsl:choose>
        
       
        </td>

	</tr>
</xsl:template>

<xsl:template match="files/root/file">
	<tr>
		<td>
			<xsl:choose>
				<xsl:when test="@possess='private'">
			        <input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@url"/></xsl:attribute></input>
				</xsl:when>			
				<xsl:when test="@possess='common'">
					<xsl:if test="@managermobiledisk='yes'">
						<input type="checkbox" id="checkbox"><xsl:attribute name="value"><xsl:value-of select="@url"/></xsl:attribute></input>
					</xsl:if>			        
				</xsl:when>
				<xsl:otherwise>			
				</xsl:otherwise>
			</xsl:choose>   
			<xsl:element name="a">
			<xsl:attribute name="href">../mobiledisk.do?action=DownloadFile&amp;filepath=<xsl:value-of select="@url"/>&amp;type=<xsl:value-of select="@possess"/></xsl:attribute>
			<img border="0"><xsl:attribute name="src">../images/icons/<xsl:value-of select="@pic"/>.png</xsl:attribute></img>
			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
			<xsl:value-of select="substring(@name,1,30)"/>
			</xsl:element>
		</td>
		<td align="left"><xsl:value-of select="@size"/>KB</td>
		<td align="center"><xsl:value-of select="@type"/></td>
		<td align="center"><xsl:value-of select="substring(@datelastmodified,1,20)"/></td>
        <td align="center">
        
         <xsl:choose>
			<xsl:when test="@possess='private'">
		        <a><xsl:attribute name="href">#</xsl:attribute>
		        <xsl:attribute name="onclick">javascript:filerename("<xsl:value-of select='@url'/>","<xsl:value-of select="@name"/>");</xsl:attribute>改名</a> 
			</xsl:when>
			
			<xsl:when test="@possess='common'">
				<xsl:choose>
					<xsl:when test="@managermobiledisk='yes'">
		        		<a><xsl:attribute name="href">#</xsl:attribute>
		        		<xsl:attribute name="onclick">javascript:adminfilerename("<xsl:value-of select='@url'/>","<xsl:value-of select="@name"/>");</xsl:attribute>改名</a>				
					</xsl:when>
					<xsl:otherwise>
						无权限
					</xsl:otherwise>
				</xsl:choose> 
			</xsl:when>
			<xsl:otherwise>
			无权限
			</xsl:otherwise>
		</xsl:choose>      
        </td>
	</tr>
</xsl:template>

</xsl:stylesheet>