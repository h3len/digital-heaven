<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
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
                    <body>
                        <img src="dwmy.jpg"/><br/>
                        <img src="zwgk.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1006&amp;nologin=true">政府信息公开</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1007&amp;nologin=true">机构职能</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">政策法规</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">计划规划</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">人事任免</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">项目与资金</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">统计数据</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">广东投资指南</a><br/>

                        <br/>
                        <img src="zwdt.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/subwork.asp?channalid=1013&amp;nologin=true">工作动态</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">通知公告</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">城市外经贸</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">热点专题</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">重点活动</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">大事记</a>
                        <br/>

                        <img src="ywbk.png"/>
                        <br/>

                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1019&amp;nologin=true">综合</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">对外贸易</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">利用外资</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">对外投资合作</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">口岸建设</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">公平贸易</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">区域合作</a>
                        <br/>


                        <img src="zxbs.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1468&amp;nologin=true">行政许可事项</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">办事指南</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">业务咨询</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">网上办理</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">非行政许可事项</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">表格下载</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">咨询电话</a>
                        <br/>

                        <img src="gzhd.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/consult.asp?id=1032&amp;nologin=true">政务邮箱</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1033&amp;nologin=true">调查问卷</a><br/>


                        <!--<img src="sqhd.png"/><br/>
                        &#160;
                        <a href="?action=bs-transfer@mdp&amp;url=http://www.dgds.gov.cn/portal/jsp/portal/category_frame.jsp?categoryId=102644%26siteName=dg%26styleName=green%26portletStyleName=menu&amp;nologin=true">联系我们</a>
                        <br/>-->
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>