<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/log">
    <div align="center" width="100%" >
      
    	<table width="80%" cellpadding="2" cellspacing="2" bgcolor="#ffffff">
        <tr>
          <td align="right" style="height:30px;" width="30%">
            企业简称：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="enterprisecode/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            企业名称：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="enterprisename/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            业务系统简称：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="appid/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            登录用户名：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="username/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            用户真实姓名：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="userrealname/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            请求地址：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="url/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            请求方式：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="method/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            响应状态码：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="statuscode/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            响应时间(秒)：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="timecount/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            备注(描述)：
          </td>
          <td align="left" width="69%">
            <xsl:value-of select="note/."/>
          </td>
        </tr>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            请求是否成功：
          </td>
          <td align="left" width="69%">
            <xsl:choose>
              <xsl:when test="issuc/. = 'true'">
                <img src="/mdp/images/true.gif" />
              </xsl:when>
              <xsl:otherwise>
                <img src="/mdp/images/false.gif" />
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <xsl:if test="issuc/. = 'false'">
          <tr>
            <td colspan="50" class="list_line"></td>
          </tr>
          <tr>
            <td align="right" style="height:30px;" width="30%">
              是否已处理：
            </td>
            <td align="left" width="69%">
              <xsl:choose>
                <xsl:when test="ishandle/. = 'true'">
                  <img src="/mdp/images/true.gif" /> 处理时间：<xsl:value-of select="handletime/."/>
                </xsl:when>
                <xsl:otherwise>
                  <img src="/mdp/images/false.gif" />
                  <!--<a href="">标记为已处理</a>-->
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td colspan="50" class="list_line"></td>
          </tr>
          <tr>
            <td align="right" style="height:30px;" width="30%">
              是否已邮件通知：
            </td>
            <td align="left" width="69%">
              <xsl:choose>
                <xsl:when test="issendmail/. = 'true'">
                  <img src="/mdp/images/true.gif" /> 邮件通知时间： <xsl:value-of select="sendmailtime/."/>
                </xsl:when>
                <xsl:otherwise>
                  <img src="/mdp/images/false.gif" />
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
        </xsl:if>
        <tr>
          <td colspan="50" class="list_line"></td>
        </tr>
        <tr>
          <td align="right" style="height:30px;" width="30%">
            附件下载：
          </td>
          <td align="left" width="69%">
            <xsl:choose>
              <xsl:when test="not(files/file)">无附件!</xsl:when>
              <xsl:otherwise>
                <table border="1" width="200">
                  <xsl:apply-templates select="files/file" />
                  
                </table>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
	    </table>
    </div>
  </xsl:template>

  <xsl:template match="file">
    <tr>
      <td>
        <font color="#999999">
          <a href="/mdp.do?action=getMdpTempFile&amp;appid={/log/appid/.}&amp;filename={@fileName}">[<xsl:value-of select="@fileType"/>]</a>
        </font>
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
