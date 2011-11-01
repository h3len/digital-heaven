<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../mdp.xsl"/>

    <xsl:template match="/">
        <xsl:choose>
            <!--网络连接失败-->
            <xsl:when test="//statuCode='-1'">
                <msc type="servermsg">
                    <msg buttonstyle="OK" show="true">网络连接失败</msg>
                </msc>
            </xsl:when>

            <xsl:otherwise>
                <msc type="form" action="">
                    <head>
                        <title>系统导航</title>

                    </head>
                    <body bgcolor="{$bodycolor}">
                        <img src="logo.jpg"/>
                        <br/>
                        <!--导航-->
                        <!--当前位置-->
                        <xsl:value-of select="translate(//td[@class='td01']/.,'  ','')"/>
                        <br/>  
                        <xsl:apply-templates select="//body/table[2]/tr[2]/td[2]/table[2]"/>
                        <!--业务咨询、政务邮箱等表格-->
                        <hr/>
                        <xsl:apply-templates select="//table[@class='list01']/tr[position()&gt;1]" mode="table"/>
                        <!--隐藏-->
                       
                        <hr/>
                        <a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">>>返回主页</a>
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--业务咨询、政务邮箱等表格-->
    <xsl:template match="tr" mode="table">
        <xsl:for-each select="td">
            <xsl:if test="position()!='1' and position()!='5'">
            <xsl:variable name="count" select="position()"/>
            <xsl:value-of select="//tr[@class='tit13']/td[$count]"/>：<xsl:apply-templates select="."/><br/>
            </xsl:if>
            <xsl:if test="position()='5'">
                <xsl:apply-templates/>
            </xsl:if>
        </xsl:for-each>
        <hr/>
        
    </xsl:template>
    <!--span标签-->
    <xsl:template match="span">
        <xsl:choose>
        <!--小标题-->
            <xsl:when test="@class='tit07'">
                <hr/>
                <img src="bt.png"/>
                    <font color="#bf0000">
                        <strong>
                            ==<xsl:value-of select="."/>==
                        </strong>
                    </font>&#160;
            </xsl:when>
            <!--标题-->
            <xsl:when test="@class='tit05'">
                <hr/>
                <font color="{$titlecolor}">
                    <strong>
                        <xsl:value-of select="."/>
                    </strong>
                </font>&#160;
            </xsl:when>
            <!--更多-->
            <xsl:when test="@class='con06'">
                <!--暂时要屏蔽-->
                <xsl:variable name="href">
                    <xsl:call-template name="ReplaceAll">
                        <xsl:with-param name="content" select="a/@href"/>
                        <xsl:with-param name="str" select="'&amp;'"/>
                        <xsl:with-param name="replacement" select="'%26'"/>
                    </xsl:call-template>
                </xsl:variable>
                    <a href="?action=bs-transfer@mdp&amp;url={$dwmy}/{$href}&amp;nologin=true" target="_blank">
                     更多..
                    </a>
            </xsl:when>
            <!--分页-->
            <xsl:when test="@class='page01'">
                <hr/>
                <xsl:apply-templates/>
            </xsl:when>
            <!--列表-->
            <xsl:when test="@class='con02'">   
                <xsl:variable name="href">
                    <xsl:call-template name="ReplaceAll">
                        <xsl:with-param name="content" select="a/@href"/>
                        <xsl:with-param name="str" select="'&amp;'"/>
                        <xsl:with-param name="replacement" select="'%26'"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="a/text()='&lt;返回上页&gt;'"/>
                    <!--附件-->
                    <xsl:when test="contains(a/@href,'UploadFile')">
                        <fileset name="file" enableadd="false" enabledel="false">
                            <fileitem href="?action=viewfileremote@mdp&amp;url={$dwmy}{$href}" caption="{a/.}">
                                <xsl:choose>
                                    <xsl:when test="substring-after(a/@href,'.')='pdf'">
                                        <xsl:attribute name="filetype">pdf</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="substring-after(a/@href,'.')='doc'">
                                        <xsl:attribute name="filetype">doc</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="substring-after(a/@href,'.')='xls'">
                                        <xsl:attribute name="filetype">xls</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="substring-after(a/@href,'.')='docx'">
                                        <xsl:attribute name="filetype">docx</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="substring-after(a/@href,'.')='ppt'">
                                        <xsl:attribute name="filetype">ppt</xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                            </fileitem>
                        </fileset>
                        <!--<a href="?action=viewfileremote@mdp&amp;url={$dwmy}{$href}">
                    <xsl:value-of select="."/>
                </a>-->
                    </xsl:when>   
                    <xsl:otherwise>
                       <a href="?action=bs-transfer@mdp&amp;url={$dwmy}/{$href}&amp;nologin=true" target="_blank">
                        <xsl:value-of select="a/."/>
                        </a>&#160;<!--<xsl:value-of select="../following-sibling::td/."/>-->  
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--td标签-->
    <xsl:template match="td">
        <xsl:choose>
            <xsl:when test="following-sibling::td/span[@class='con02']"></xsl:when>
            <xsl:otherwise>
             <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--p标签-->
    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="@align='left'">
                &#160;&#160;
                <xsl:apply-templates/>
                <br/>
            </xsl:when>
            <xsl:when test="@align='right'">
                <span width="100%" align="right">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="strong">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    <!--strong-->
    <xsl:template match="strong">
        <xsl:choose>
            <xsl:when test="a">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <font bold="true">
                    <xsl:value-of select="."/>
                </font>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!--a标签-->
    <xsl:template match="a">
        <xsl:variable name="href">
            <xsl:call-template name="ReplaceAll">
                <xsl:with-param name="content" select="@href"/>
                <xsl:with-param name="str" select="'&amp;'"/>
                <xsl:with-param name="replacement" select="'%26'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(@href,'http') and not(contains(@href,'8011'))">
                <a href="?action=bs-transfer@mdp&amp;url={$href}&amp;nologin=true" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <!--附件-->
            <xsl:when test="contains(@href,'UploadFile')">
                <fileset name="file" enableadd="false" enabledel="false">
                    <fileitem href="?action=viewfileremote@mdp&amp;url={$dwmy}{$href}" caption="{.}">
                        <xsl:choose>
                            <xsl:when test="substring-after(.,'.')='pdf'">
                                <xsl:attribute name="filetype">pdf</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="substring-after(.,'.')='doc'">
                                <xsl:attribute name="filetype">doc</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="substring-after(.,'.')='xls'">
                                <xsl:attribute name="filetype">xls</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="substring-after(.,'.')='docx'">
                                <xsl:attribute name="filetype">docx</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="substring-after(.,'.')='ppt'">
                                <xsl:attribute name="filetype">ppt</xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                    </fileitem>
                </fileset>
                <!--<a href="?action=viewfileremote@mdp&amp;url={$dwmy}{$href}">
                    <xsl:value-of select="."/>
                </a>-->

            </xsl:when>
            <!--图片-->
            <xsl:when test="img">
                <xsl:apply-templates select="img"/>
            </xsl:when>
            <!--领导名字-->
            <xsl:when test="contains(@href,'8011')">
                <xsl:value-of select="."/>&#160;
            </xsl:when>

            <xsl:otherwise>
                <a href="?action=bs-transfer@mdp&amp;url={$dwmy}/{$href}&amp;nologin=true" target="_blank">
                    <xsl:value-of select="."/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
     <!--input标签-->
    <xsl:template match="input">
        <xsl:choose>
        <!--GO按钮-->
            <xsl:when test="@type='image'">
                <input name="{@name}" value="{@value}" type="submit" id="{@id}"/>
                <input type="hidden" name="nologin" value="true"></input>
                <input type="hidden" name="sky" value="{substring-before(//url,'?')}"></input>
                <input type="hidden" name="channalid" value="{//param[@key='channalid']/@value}"></input>
                <input type="hidden" name="id" value="{//param[@key='id']/@value}"></input>
            </xsl:when>
            <xsl:otherwise>
                <input name="{@name}" value="{@value}" type="{@type}" id="{@id}"/>     
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <!--过滤图片-->
    <xsl:template match="img">
        <xsl:choose>
            <!--附件小图片-->
            <xsl:when test="contains(@src,'/file/')">
                <!--<img src="?action=viewimageremote@mdp&amp;url={$dwmy}{@src}&amp;nologin=true" alt="{@alt}"/>-->
            </xsl:when>
            <!--其它的-->
            <xsl:when test="contains(@src,'/admin/')">
                <img src="?action=viewimageremote@mdp&amp;url={$dwmy}{@src}&amp;nologin=true" alt="{@alt}"/>
            </xsl:when>
            <!--领导头像-->
            <xsl:when test="contains(@src,'8011')">
                <img src="?action=viewimageremote@mdp&amp;url={@src}&amp;nologin=true" alt="{@alt}"/>
                <br/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
