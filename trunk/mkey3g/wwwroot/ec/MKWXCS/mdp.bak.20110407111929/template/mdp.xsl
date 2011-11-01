<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- 公用模板 -->
	<xsl:variable name="amp" select='"&amp;"'/>
	<!--共用地址-->
  <!--OA-->
  <xsl:variable name ="myurl">http://szoa1.sino-life.com:8001</xsl:variable>
  <!--PS-->
  <xsl:variable name="url">http://hrapp.sino-life.com</xsl:variable>
  <!--HEC-->
  <xsl:variable name ="HEC">http://hecapp.sino-life.com:8080</xsl:variable>
  <!--水费查询_梅州-->
  <xsl:variable name ="sfmz">http://m.wxcsmz.com</xsl:variable>

  
  <xsl:variable name ="gzyx">http://theater.mtime.com</xsl:variable>
  <xsl:variable name ="movie">http://movie.mtime.com</xsl:variable>
  
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

      <!--<xsl:when test="contains(@href,'javascript:doModalDO')">
        <xsl:apply-templates/>
      </xsl:when>-->
      
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="url">  </xsl:template>
	<!--font标签模板 修改人：王志坤-->
	<xsl:template match="font">
		<font>
			<xsl:attribute name="color"><xsl:value-of select="@color"/></xsl:attribute>
			<xsl:value-of select="."/>
		</font>
	</xsl:template>
	<!-- input标签模板 -->
	<xsl:template match="input">
		<xsl:choose>
			<xsl:when test="@name='__Click'"/>
			<xsl:when test="@type='radio'">
				<input type="{@type}" value="{@value}">
					<xsl:attribute name="type"><xsl:choose><xsl:when test="@type != ''"><xsl:value-of select="@type"/></xsl:when><xsl:otherwise>text</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="name"><xsl:if test="@name != ''"><xsl:value-of select="@name"/></xsl:if><xsl:if test="(not(@name) or @name='') and @id != ''"><xsl:value-of select="@id"/></xsl:if></xsl:attribute>
					<!--王志坤 这里新加的内容开始-->
					<xsl:if test="@readonly">
						<xsl:attribute name="readonly">true</xsl:attribute>
					</xsl:if>
  
					<xsl:if test="@checked">
						<xsl:attribute name="checked">true</xsl:attribute>
					</xsl:if>
				</input>
			</xsl:when>
			<xsl:otherwise>
				<input type="{@type}" value="{@value}">
					<xsl:attribute name="type"><xsl:choose><xsl:when test="@type != ''"><xsl:value-of select="@type"/></xsl:when><xsl:otherwise>text</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="caption"><xsl:choose><xsl:when test="@caption != ''"><xsl:value-of select="@caption"/></xsl:when><xsl:when test="@value != '' and (@type='submit' or @type='button')"><xsl:value-of select="@value"/></xsl:when></xsl:choose></xsl:attribute>
					<xsl:attribute name="name"><xsl:if test="@name != ''"><xsl:value-of select="@name"/></xsl:if><xsl:if test="(not(@name) or @name='') and @id != ''"><xsl:value-of select="@id"/></xsl:if></xsl:attribute>
					<!--王志坤 这里新加的内容开始-->
					<xsl:if test="@readonly">
						<xsl:attribute name="readonly">true</xsl:attribute>
					</xsl:if>
					<xsl:if test="@checked">
						<xsl:attribute name="checked">true</xsl:attribute>
					</xsl:if>
					<!--王志坤 这里新加的内容结束-->
					<xsl:if test="//param[@key=@name]/@value != ''">
						<!-- 需要从param参数中读取value -->
						<xsl:attribute name="value"><xsl:value-of select="//param[@key=@name]/@value"/></xsl:attribute>
					</xsl:if>
				</input>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- iImg标签模板 lch 2010年10月19日重写img模版 -->
  <xsl:template match ="img">
    <xsl:choose>
      <xsl:when test ="starts-with(@src,'http') or starts-with(@src,'www')">
        <img src="?action=viewimageremote@mdp&amp;url={@src}"/>
      </xsl:when>
      <xsl:otherwise>
        <img src="?action=viewimageremote@mdp&amp;url={$url}{@src}"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
	<!-- table标签模板 -->
	<xsl:template match="table">
		<xsl:apply-templates select="tbody"/>
		<xsl:apply-templates select="tr"/>
	</xsl:template>
	<!-- tr标签模板 -->
	<xsl:template match="tr">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<!-- td标签模板 -->
	<xsl:template match="td">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- hr标签模板 -->
	<xsl:template match="hr">
		<hr/>
	</xsl:template>
	<!-- ul标签模板 -->
	<xsl:template match="ul">
		<br/>
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<!-- li标签模板 -->
	<xsl:template match="li">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<!-- br标签模板 -->
	<xsl:template match="br">
		<br/>
	</xsl:template>
	<!-- p标签模板 -->
	<xsl:template match="p">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- div标签模板 -->
	<xsl:template match="div">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<!-- strong标签模板 -->
	<xsl:template match="strong">
		<font bold="true">
			<xsl:value-of select="."/>
		</font>
	</xsl:template>
	<!-- b标签模板 -->
	<xsl:template match="b">
		<font bold="true">
			<xsl:value-of select="."/>
		</font>
	</xsl:template>
	<!--textarea标签模板 -->
	<xsl:template match="textarea">
		<textarea name="{@name}" caption="{@caption}">
			<xsl:variable name="key" select="@name"/>
			<!--王志坤 这里新加的内容-->
			<xsl:if test="@readonly">
				<xsl:attribute name="readonly">true</xsl:attribute>
			</xsl:if>
			<!--王志坤 这里新加的内容结束-->
			<xsl:choose>
				<xsl:when test="//param[@key=$key]/@value != ''">
					<!-- 需要从param参数中读取value -->
					<xsl:value-of select="//param[@key=$key]/@value"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</textarea>
	</xsl:template>
	<!-- select标签模板 -->
	<xsl:template match="select">
		<select name="{@name}" caption="{@caption}">
			<xsl:attribute name="name"><xsl:choose><xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when><xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when></xsl:choose></xsl:attribute>
			<!--新加的内容 王志坤-->
			<xsl:if test="@disabled">
				<xsl:attribute name="disabled">true</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="option"/>
		</select>
	</xsl:template>
	<!-- option标签模板 -->
	<xsl:template match="option">
		<option value="{@value}">
			<xsl:if test="@selected != ''">
				<xsl:attribute name="selected">true</xsl:attribute>
			</xsl:if>
			<xsl:if test="not(@value)">
				<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
			</xsl:if>
			<xsl:variable name="key" select="../@name"/>
			<xsl:variable name="value" select="@value"/>
			<xsl:if test="//param[@key=$key]/@value = $value">
				<!-- 设置选中 -->
				<xsl:attribute name="selected">true</xsl:attribute>
			</xsl:if>
			<xsl:if test="@selected">
				<!-- 设置选中 -->
				<xsl:attribute name="selected">true</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="."/>
		</option>
	</xsl:template>
	<!--   描述：日期格式化模板  注意：仅可以将 1)04/01/2008 11:45:30 AM/PM 类型的 日期格式化为 2008-04-01 11:45:30    2)04/01/2008  格式化为 2008-04-01  3)如果传入的参数本身已经是 2008-04-01或者 2008-04-01 23:23:12这样的格式，则直接返回  -->
	<xsl:template name="FormatDate">
		<xsl:param name="DateTime"/>
		<xsl:choose>
			<xsl:when test="contains($DateTime,'PM') or contains($DateTime,'AM') or string-length(substring-before($DateTime,'/'))=2 ">
				<!-- new date format 2006-01-14 08:55:22 04/01/2008 11:45:30 AM-->
				<xsl:variable name="mo">
					<xsl:value-of select="substring($DateTime,1,2)"/>
				</xsl:variable>
				<xsl:variable name="day-temp">
					<xsl:value-of select="substring-after($DateTime,'/')"/>
				</xsl:variable>
				<xsl:variable name="day">
					<xsl:value-of select="substring-before($day-temp,'/')"/>
				</xsl:variable>
				<xsl:variable name="year-temp">
					<xsl:value-of select="substring-after($day-temp,'/')"/>
				</xsl:variable>
				<xsl:variable name="year">
					<xsl:value-of select="substring($year-temp,1,4)"/>
				</xsl:variable>
				<xsl:value-of select="$year"/>
				<xsl:value-of select="'-'"/>
				<xsl:value-of select="$mo"/>
				<xsl:value-of select="'-'"/>
				<xsl:value-of select="$day"/>
				<xsl:variable name="time">
					<xsl:value-of select="substring-after($year-temp,' ')"/>
				</xsl:variable>
				<xsl:if test="$time!=''">
					<xsl:value-of select="' '"/>
					<xsl:variable name="hh">
						<xsl:value-of select="substring($time,1,2)"/>
					</xsl:variable>
					<xsl:variable name="mm">
						<xsl:value-of select="substring($time,4,2)"/>
					</xsl:variable>
					<xsl:variable name="ss">
						<xsl:value-of select="substring($time,7,2)"/>
					</xsl:variable>
					<xsl:variable name="AM_PM">
						<xsl:value-of select="substring-after($time,' ')"/>
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
      <!--20101111新增修改-->
      <xsl:when test="string-length(substring-before($DateTime,'/'))=4 and not(contains($DateTime,':') or contains($DateTime,'M'))">
        <xsl:variable name="year">
          <xsl:value-of select="substring-before($DateTime,'/')"/>
        </xsl:variable>
        <xsl:variable name="mo_temp">
          <xsl:value-of select="substring-after($DateTime,'/')"/>
        </xsl:variable>
        <xsl:variable name="mo">
          <xsl:value-of select="substring-before($mo_temp,'/')"/>
        </xsl:variable>
        <xsl:variable name="day">
          <xsl:value-of select="substring-after($mo_temp,'/')"/>
        </xsl:variable>

        <xsl:value-of select="$year"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="$mo"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="$day"/>

      </xsl:when>
      <!--20101111新增修改-->
			<xsl:otherwise>
				<xsl:value-of select="$DateTime"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 将所有参数，以隐藏方式传入 -->
	<xsl:template match="param">
		<xsl:if test="@key!='method' and @key!='__Click_type'">
			<input type="hidden" name="{@key}" value="{@value}"/>
		</xsl:if>
	</xsl:template>
	<!-- 将隐藏控件传入 -->
	<xsl:template match="input" mode="hidden">
		<input type="hidden" value="{@value}">
			<xsl:attribute name="name"><xsl:choose><xsl:when test="@name != ''"><xsl:value-of select="@name"/></xsl:when><xsl:otherwise><xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:attribute>
		</input>
	</xsl:template>
	<!-- xslt中替换字符串 by yesun-->
	<xsl:template name="ReplaceAll">
		<xsl:param name="content"/>
		<xsl:param name="str"/>
		<xsl:param name="replacement"/>
		<xsl:if test="$content">
			<xsl:choose>
				<xsl:when test="contains($content,$str)">
					<xsl:value-of select="substring-before($content,$str)"/>
					<xsl:value-of select="$replacement"/>
					<xsl:call-template name="ReplaceAll">
						<xsl:with-param name="content" select="substring-after($content,$str)"/>
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
