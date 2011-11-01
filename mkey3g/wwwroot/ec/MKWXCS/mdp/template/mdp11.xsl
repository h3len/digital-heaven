<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- 公用模板 -->
    <xsl:variable name="amp" select='"&amp;"'/>
    <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>
    <xsl:variable name ="gzyx">http://theater.mtime.com</xsl:variable>
    <!--区分线条颜色-->
    <xsl:variable name="hrcolor" select="'#0066CC'"/>
    <!-- a标签模板 -->
    <xsl:template match="a">
        <xsl:choose>
            <xsl:when test="@href != ''">
                <a href="{@href}" target="{@target}">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="url">
    </xsl:template>

    <xsl:template match ="font">
        <font>
            <xsl:if test="not(@color)=false">
                <xsl:attribute name="color">
                    <xsl:choose>
                        <xsl:when test="@color">
                            <xsl:value-of select="'ff0000'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@color"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@face='黑体'">
                <xsl:attribute name="bold">true</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </font>
    </xsl:template>

    <!-- input标签模板 -->
    <xsl:template match="input">
        <xsl:choose>
            <xsl:when test="@type='button'">
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@type='radio'">
                    <br/>
                </xsl:if>
                <input type="{@type}" value="{@value}">
                    <xsl:attribute name="type">
                        <xsl:choose>
                            <xsl:when test="@type != ''">
                                <xsl:value-of select="@type"/>
                            </xsl:when>
                            <xsl:otherwise>text</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>

                    <xsl:attribute name="caption">
                        <xsl:choose>
                            <xsl:when test="@caption != ''">
                                <xsl:value-of select="@caption"/>
                            </xsl:when>
                            <xsl:when test="@value != '' and (@type='submit' or @type='button')">
                                <xsl:value-of select="@value"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:attribute>

                    <xsl:attribute name="name">
                        <xsl:if test="@name != ''">
                            <xsl:value-of select="@name"/>
                        </xsl:if>
                        <xsl:if test="@type= 'file'">
                            <xsl:attribute name="name">
                                <xsl:text>dh_fileset_</xsl:text>
                                <xsl:value-of select="@name"/>
                            </xsl:attribute>
                        </xsl:if>

                        <xsl:if test="(not(@name) or @name='') and @id != ''">
                            <xsl:value-of select="@id"/>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:if test="@type='radio' or @type='checkbox'">
                        <xsl:attribute name="checked">
                            <xsl:if test="@checked">
                                <xsl:value-of select="'true'"/>
                            </xsl:if>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@readonly or @disabled">
                        <xsl:attribute name="readonly">true</xsl:attribute>

                    </xsl:if>
                </input>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--img标签模板-->
    <xsl:template match="img">
        <br/>
        <img src="{@src}"/>
    </xsl:template>

    <!-- table标签模板 -->
    <xsl:template match="table">
        <xsl:apply-templates select="tbody"/>
        <xsl:apply-templates select="tr"/>
    </xsl:template>

    <!-- tr标签模板 -->
    <xsl:template match="tr">
        <xsl:apply-templates />
        <br/>
    </xsl:template>

    <!-- td标签模板 -->
    <xsl:template match="td">
        <xsl:apply-templates />
    </xsl:template>

    <!-- hr标签模板 -->
    <xsl:template match="hr">
        <hr/>
    </xsl:template>

    <!-- ul标签模板 -->
    <xsl:template match="ul">
        <xsl:apply-templates />
    </xsl:template>

    <!-- li标签模板 -->
    <xsl:template match="li">
        <xsl:apply-templates />
    </xsl:template>

    <!-- br标签模板 -->
    <xsl:template match="br">
    </xsl:template>


    <!-- p标签模板 -->
    <xsl:template match="p">
        <xsl:apply-templates />
    </xsl:template>

    <!-- div标签模板 -->
    <xsl:template match="div">
        <xsl:apply-templates />
    </xsl:template>

    <!-- strong标签模板 -->
    <xsl:template match="strong">
        <font bold="true">
            <xsl:value-of select="."></xsl:value-of>
        </font>
    </xsl:template>

    <!--b标签模板 -->
    <xsl:template match="b">
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>

    <!--textarea标签模板 -->
    <xsl:template match="textarea">
        <xsl:choose>
            <xsl:when test="@style='display:none'">
            </xsl:when>
            <xsl:otherwise>
                <textarea name="{@name}" caption="{@caption}">
                    <xsl:if test ="@readonly">
                        <xsl:attribute name ="readonly">true</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </textarea>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- select标签模板 -->
    <xsl:template match="select">
        <select name="{@name}" caption="{@caption}">
            <xsl:attribute name="name">
                <xsl:choose>
                    <xsl:when test="@name">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="enable">
                <xsl:if test="@disabled='true'">false</xsl:if>
            </xsl:attribute>
            <xsl:apply-templates select="option"/>

        </select>
    </xsl:template>
    <!-- option标签模板 -->
    <xsl:template match="option">
        <option value="{@value}">
            <xsl:if test ="@selected">
                <xsl:attribute name="selected">true</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="."/>
        </option>
    </xsl:template>

    <!-- 
  	描述：日期格式化模板
  	注意：仅可以将 1)04/01/2008 11:45:30 AM/PM 类型的 日期格式化为 2008-04-01 11:45:30  	
  				2)04/01/2008  格式化为 2008-04-01
  				3)如果传入的参数本身已经是 2008-04-01或者 2008-04-01 23:23:12这样的格式，则直接返回
  -->
    <xsl:template name="FormatDate">
        <xsl:param name="DateTime" />
        <xsl:choose>
            <xsl:when test="contains($DateTime,'PM') or contains($DateTime,'AM') or string-length(substring-before($DateTime,'/'))=2 ">
                <!-- new date format 2006-01-14 08:55:22 04/01/2008 11:45:30 AM-->
                <xsl:variable name="mo">
                    <xsl:value-of select="substring($DateTime,1,2)" />
                </xsl:variable>
                <xsl:variable name="day-temp">
                    <xsl:value-of select="substring-after($DateTime,'/')" />
                </xsl:variable>
                <xsl:variable name="day">
                    <xsl:value-of select="substring-before($day-temp,'/')" />
                </xsl:variable>
                <xsl:variable name="year-temp">
                    <xsl:value-of select="substring-after($day-temp,'/')" />
                </xsl:variable>
                <xsl:variable name="year">
                    <xsl:value-of select="substring($year-temp,1,4)" />
                </xsl:variable>
                <xsl:value-of select="$year"/>
                <xsl:value-of select="'-'"/>
                <xsl:value-of select="$mo"/>
                <xsl:value-of select="'-'"/>
                <xsl:value-of select="$day"/>

                <xsl:variable name="time">
                    <xsl:value-of select="substring-after($year-temp,' ')" />
                </xsl:variable>
                <xsl:if test="$time!=''">
                    <xsl:value-of select="' '"/>
                    <xsl:variable name="hh">
                        <xsl:value-of select="substring($time,1,2)" />
                    </xsl:variable>
                    <xsl:variable name="mm">
                        <xsl:value-of select="substring($time,4,2)" />
                    </xsl:variable>
                    <xsl:variable name="ss">
                        <xsl:value-of select="substring($time,7,2)" />
                    </xsl:variable>
                    <xsl:variable name="AM_PM">
                        <xsl:value-of select="substring-after($time,' ')" />
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$AM_PM='PM'">
                            <xsl:value-of select="$hh+12"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$hh"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="':'"/>
                    <xsl:value-of select="$mm"/>
                    <xsl:value-of select="':'"/>
                    <xsl:value-of select="$ss"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$DateTime"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 将隐藏控件传入 -->
    <xsl:template match="input" mode="hidden">
        <input type="hidden" value="{@value}">
            <xsl:attribute name="name">
                <xsl:choose>
                    <xsl:when test="@name != ''">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </input>
    </xsl:template>


    <!--xslt中替换字符串 by yesun-->
    <xsl:template name="ReplaceAll">
        <xsl:param name="content"/>
        <xsl:param name="str"/>
        <xsl:param  name="replacement"/>
        <xsl:if test="$content">
            <xsl:choose>
                <xsl:when test="contains($content,$str)">
                    <xsl:value-of select="substring-before($content,$str)"/>
                    <xsl:value-of select="$replacement"/>
                    <xsl:call-template name="ReplaceAll">
                        <xsl:with-param name="content" select="substring-after($content,$str)" />
                        <xsl:with-param name="str" select="$str"/>
                        <xsl:with-param name="replacement" select="$replacement"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$content"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>