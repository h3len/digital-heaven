<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="root">
  <xsl:variable name="parentId" select="catlist/@parentid"/>
  <xsl:choose >
  	<xsl:when test="$parentId!=''">
		<div><a href="JavaScript:GetCatalogList('{$parentId}');GetUserList('{$parentId}');">后退&gt;&gt;</a></div>
	</xsl:when>
</xsl:choose>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td>
<table width="100%" cellpadding="2" cellspacing="0"  bgcolor="#ffffff">
      <tr class="header">
        <td width="60%" style="padding-left:4px;">名 称</td>       
        <td width="40%">类型</td>
       
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/catlist/cat"></xsl:apply-templates>
      <!--应用模板结束-->
</table>

</td></tr></table>

  </xsl:template>
  <xsl:template match="cat">
    <tr onMouseOut="this.style.backgroundColor='#fff'" onMouseOver="this.style.backgroundColor='#E2EEF3'">
      <td style="padding-left:4px;"  width="60%">
      <img src="../../images/icon_create_usergroup.gif"/><xsl:text>	</xsl:text>
      <a style="cursor:pointer;text-decoration:underline;color:Red;font-weight:bolder;" onclick='JavaScript:GetCatalogList("{@id}");GetUserList("{@id}");'><xsl:value-of select="@catalogname" /></a>
      </td>
      
      <td width="40%">  
	      <xsl:choose>
	      <xsl:when test="//catlist/@isChildCompany='false' and //catlist/@parentid = ''">集团</xsl:when>
	      <xsl:when test="//catlist/@isChildCompany='true'">部门</xsl:when>
	      <xsl:otherwise>部门</xsl:otherwise>
	      </xsl:choose> 
      </td>
      
       </tr>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. 保留所有权力.
<metaInformation>
<scenarios ><scenario default="yes" name="场景1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\xx.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->