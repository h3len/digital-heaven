<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <msc type="form">
        <head>
            <title>
                <xsl:choose>
                    <xsl:when test="//title/.!=''">
                        <xsl:value-of select="//title/."/>
                    </xsl:when>
                    <xsl:otherwise>
                    江门社保查询
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
			<span width="100%" height="21px"><font color="#FF0000" size="4"> <xsl:value-of select="//font[@color='#FF0000' and @size='4']/."/></font></span>
			<p>请输入个人参保号（或个人身份证号）：<br/><input type="text" name="T1" size="20"/></p><br/>
			<p>请输入查询密码： <br/><input type="password" name="T2" size="21"/></p><br/><br/>
			<input type="hidden" name="T3" value="{//form/@action}" />
			<p align="center"><input type="submit" value="提交" name="submit" /></p>
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>