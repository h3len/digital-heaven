<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="root"><link type="text/css" rel="stylesheet" href="../css/user.css" />

  <table width="100%" class="border" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
      <tr class="header">
        <th class="ac" width="40">序号</th>
        <th width="30%">用户名</th>
        <th width="30%" class="ac">创建日期</th>
        <th width="10%">状态</th>
        <th class="ac">操 作</th>
      </tr>
      <!--应用模板开始-->
      <xsl:apply-templates select="/root/adminlist/admin">
      <xsl:sort select='@vdatetime' order='ascending' />
      </xsl:apply-templates>
      <!--应用模板结束-->
  </table>
  </xsl:template>
  
  <xsl:template match="admin">
   <tr>
     <xsl:attribute name="id">tr_<xsl:value-of select="@id"/></xsl:attribute>
     <xsl:if test="position() mod 2 = 1">
       <xsl:attribute name="class">AlternatingItemTemplate</xsl:attribute>
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#C8E8DE'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.cssText='AlternatingItemTemplate'</xsl:attribute>
     </xsl:if>
     <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="class">ItemTemplate</xsl:attribute>
       <xsl:attribute name="onmouseover">javascript:this.style.backgroundColor='#C8E8DE'</xsl:attribute>
       <xsl:attribute name="onmouseout">javascript:this.style.cssText='ItemTemplate'</xsl:attribute>
     </xsl:if>     
     <td class="ac b">
       <xsl:value-of select="position()"/>
     </td>
      <td style="padding-left:4px;">
        <a><xsl:attribute name="style">cursor:hand;text-decoration:underline;color:#039;font-weight:bolder;</xsl:attribute><xsl:attribute name="onclick">
          javascript:AdminShow("<xsl:value-of select="@id"/>");
        </xsl:attribute>
        <xsl:choose>
        <xsl:when test="@usetruename='true'"><xsl:value-of select="@truename" /></xsl:when>
        <xsl:otherwise><xsl:value-of select="@username" /></xsl:otherwise>
        </xsl:choose>        
      </a>
    </td>
    <td class="ac">
      <xsl:value-of select="@vdatetime"/>
    </td>
    <td>
    <xsl:choose>
            <xsl:when test="@ischeck = '-1'">
              <span class="b">已冻结</span>
            </xsl:when>
            <xsl:when test="@ischeck = '0'">
              <span class="r">待审核</span>
            </xsl:when>
            <xsl:when test="@ischeck = '1'">
              <span class="g">已审核</span>
            </xsl:when>
            <xsl:otherwise>未知</xsl:otherwise>
    </xsl:choose>
    </td>
    <td class="ac">
      <input type="button" class="button" value=" 加入用户">
        <xsl:attribute name="onclick">
          javascript:JoinUser("<xsl:value-of select="@id"/>");
        </xsl:attribute>
      </input>
     </td>
   </tr>
 </xsl:template>
</xsl:stylesheet>
