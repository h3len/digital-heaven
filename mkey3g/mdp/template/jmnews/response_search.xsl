<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="mdp.xsl"/>
  <xsl:import href="config.xsl"/>
  <xsl:template match="/">
    <msc type="form" action="">
        <head>
            <title>
                <xsl:choose>
                    <xsl:when test="//title/.!=''">
                        <xsl:value-of select="//title/."/>
                    </xsl:when>
                    <xsl:otherwise>
                    东莞金盾测试
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
        			企业名称：<input type="text" name="corpName"/><br/>
        			注 册 号：<input type="text" name="registerNo"/><br/>
        			验 证 号：<input type="text" name="keycode"/><br/>
        			<img src="http://wsnj.gdgs.gov.cn/{//img[@alt='验证码']/@src}"/><br/>
        			<input type="submit" name="submitbutton" value="查询" />
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>