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
			车牌号码：<input type="text" name="JC" value="粤" width="15px"/><input type="text" name="HPHM" value="J" width="50px"/><br/>
			车辆类型：<select name='hpzl'>
                        <option value="01">大型汽车</option>
                        <option value="02">小型汽车</option>
                        <option value="05">境外汽车</option>
                        <option value="06">外籍汽车</option>
                        <option value="07">两、三轮摩托车</option>
                        <option value="11">境外摩托车</option>
                        <option value="12">外籍摩托车</option>
                        <option value="15">挂车</option>
                        <option value="20">临时入境汽车</option>
                        <option value="21">临时入境摩托车</option>
                        <option value="22">临时行驶汽车</option>
                        <option value="23">公安警车</option>
                        <option value="26">香港出入境车辆</option>
                        <option value="27">澳门出入境车辆</option>
                        <option value="99">其它</option>
                      </select><br/>
			车辆识别代号（或车架号）后4位：<br/>
			<input type="text" name="CJHM" width="50px"/><input name="submit" type="submit" value="提 交"/>
        </body>
    </msc>
  </xsl:template>

</xsl:stylesheet>