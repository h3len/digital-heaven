<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="mdp.xsl"/>
    <xsl:template match="/">
        <xsl:choose>
            <!--��������ʧ��-->
            <xsl:when test="//statuCode='-1'">
                <msc type="servermsg">
                    <msg buttonstyle="OK" show="true">��������ʧ��</msg>
                </msc>
            </xsl:when>

            <xsl:otherwise>
                <msc type="form" action="">
                    <head>
                        <title>ϵͳ����</title>
                    </head>
                    <body>
                        <img src="dwmy.jpg"/><br/>
                        <img src="zwgk.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1006&amp;nologin=true">������Ϣ����</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1007&amp;nologin=true">����ְ��</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">���߷���</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�ƻ��滮</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">��������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">��Ŀ���ʽ�</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">ͳ������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�㶫Ͷ��ָ��</a><br/>

                        <br/>
                        <img src="zwdt.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/subwork.asp?channalid=1013&amp;nologin=true">������̬</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">֪ͨ����</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�����⾭ó</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�ȵ�ר��</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�ص�</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">���¼�</a>
                        <br/>

                        <img src="ywbk.png"/>
                        <br/>

                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1019&amp;nologin=true">�ۺ�</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">����ó��</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">��������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">����Ͷ�ʺ���</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�ڰ�����</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">��ƽó��</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�������</a>
                        <br/>


                        <img src="zxbs.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1468&amp;nologin=true">�����������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">����ָ��</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">ҵ����ѯ</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">���ϰ���</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�������������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">�������</a><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/&amp;nologin=true">��ѯ�绰</a>
                        <br/>

                        <img src="gzhd.png"/><br/>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/consult.asp?id=1032&amp;nologin=true">��������</a>
                        &#160;<a href="?action=bs-transfer@mdp&amp;url=http://www.gddoftec.gov.cn/sub.asp?channalid=1033&amp;nologin=true">�����ʾ�</a><br/>


                        <!--<img src="sqhd.png"/><br/>
                        &#160;
                        <a href="?action=bs-transfer@mdp&amp;url=http://www.dgds.gov.cn/portal/jsp/portal/category_frame.jsp?categoryId=102644%26siteName=dg%26styleName=green%26portletStyleName=menu&amp;nologin=true">��ϵ����</a>
                        <br/>-->
                    </body>
                </msc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>