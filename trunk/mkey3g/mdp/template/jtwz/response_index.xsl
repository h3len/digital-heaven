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
                    交通违章查询
                    </xsl:otherwise>
                </xsl:choose>
            </title>
        </head>
        <body>
			车牌号码：<INPUT TYPE="text" NAME="JC" size="2" value="粤"><INPUT TYPE="text" NAME="HPHM" value="J" size="11">
			车辆类型：<SELECT size=1 name='hpzl'>
                        <OPTION value=01 selected>大型汽车</OPTION>
                        <OPTION value=02>小型汽车</OPTION>
                        <OPTION value=05>境外汽车</OPTION>
                        <OPTION value=06>外籍汽车</OPTION>
                        <OPTION value=07>两、三轮摩托车</OPTION>
                        <OPTION value=11>境外摩托车</OPTION>
                        <OPTION value=12>外籍摩托车</OPTION>
                        <OPTION value=15>挂车</OPTION>
                        <OPTION value=20>临时入境汽车</OPTION>
                        <OPTION value=21>临时入境摩托车</OPTION>
                        <OPTION value=22>临时行驶汽车</OPTION>
                        <OPTION value=23>公安警车</OPTION>
                        <option value=26>香港出入境车辆</option>
                        <option value=27>澳门出入境车辆</option>
                        <OPTION value=99>其它</OPTION>
                      </SELECT>
			车辆识别代号（或车架号）后4位：<INPUT TYPE="text" NAME="CJHM" size="8">
			<INPUT name="submit" TYPE="submit" value="提 交">
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>