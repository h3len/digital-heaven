<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="../mdp.xsl"></xsl:import>
  <xsl:variable name ="url">http://movie.mtime.com</xsl:variable>

  <xsl:template match="/html">
        <msc type="form" islogin="true">
            <head>
                <title></title>
                <script type="text/javascript">
                    <![CDATA[	
                    function aaa(){
                    alert('开发中.......');
				}
			]]>
                </script>
            </head>
            <body background="index_bg.png">
                <strong>请选择您所在的城市</strong>
                <hr color="{$hrcolor}" size="2"/>
                <span width="100%" align="center">
                <strong>A</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='A']"/>
                <hr color="{$hrcolor}" size="2"/>
                
                <span width="100%" align="center">
                    <strong>B</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='B']"/>
                <!--<xsl:apply-templates select="//div[@id='Beijing']" mode="ss"/>-->
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>C</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='C']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>D</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='D']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>E</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='E']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>F</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='F']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>G</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='G']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>H</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='H']"/>
                <xsl:apply-templates select="//div[substring(@id,1,1)='h']"/>
                <hr color="{$hrcolor}" size="2"/>

                <!--<span width="100%" align="center">
                    <strong>I</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='I']"/>
                <hr color="{$hrcolor}" size="2"/>-->

                <span width="100%" align="center">
                    <strong>J</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='J']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>K</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='K']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>L</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='L']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>M</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='M']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>N</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='N']"/>
                <hr color="{$hrcolor}" size="2"/>

                <!--<span width="100%" align="center">
                    <strong>O</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='O']"/>
                <hr color="{$hrcolor}" size="2"/>-->

                <span width="100%" align="center">
                    <strong>P</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='P']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>Q</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='Q']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>R</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='R']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>S</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='S']"/>
                <!--<xsl:apply-templates select="//div[@id='shanghai']" mode="ss"/>-->
                <hr color="{$hrcolor}" size="2"/>
                

                <span width="100%" align="center">
                    <strong>T</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='T']"/>
                <!--<xsl:apply-templates select="//div[@id='tianjin']" mode="ss"/>-->
                <hr color="{$hrcolor}" size="2"/>

                <!--<span width="100%" align="center">
                    <strong>U</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='U']"/>
                <hr color="{$hrcolor}" size="2"/>-->

                <!--<span width="100%" align="center">
                    <strong>V</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='V']"/>
                <hr color="{$hrcolor}" size="2"/>-->

                <span width="100%" align="center">
                    <strong>W</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='W']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>X</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='X']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>Y</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='Y']"/>
                <hr color="{$hrcolor}" size="2"/>

                <span width="100%" align="center">
                    <strong>Z</strong>
                </span>
                <xsl:apply-templates select="//div[substring(@id,1,1)='Z']"/>
                <hr color="{$hrcolor}" size="2"/>
            </body>
        </msc>

    </xsl:template>
    <xsl:template match="div">
        <xsl:choose>
            <xsl:when test="@id='Beijing' or @id='Shanghai' or @id='Tianjin' or @id='Chongqing'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Baotou' or @id='Bayannaoer' or @id='Eerduosi' or @id='Hohhot' or @id='Urumqi' or @id='Beihai'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_{@province}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Dujiangyan' or @id='Mianzhu'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Sichuan_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Gaizhou'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Liaoning_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Gejiu'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Yunnan_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Haian' or @id='Shuyang' or @id='Yangzhong'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Jiangsu_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='haiyan'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Zhejiang_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Houma' or @id='Changzhi'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Shanxi_Province2_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Liuyang'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Hunan_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Nanan'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Fujian_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Qingzhou' or @id='Zoucheng'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Shandong_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:when test="@id='Yuzhou'">
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_Henan_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:when>
            <xsl:otherwise>
                <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_{@province}_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
                    <xsl:value-of select="@name"/>
                </a>&#160;|&#160;
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>