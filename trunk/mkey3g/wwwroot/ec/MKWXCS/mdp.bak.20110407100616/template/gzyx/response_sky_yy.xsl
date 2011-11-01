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
                <br/>
                <xsl:apply-templates select="//div"/>
            </body>
        </msc>

    </xsl:template>
    <xsl:template match="div">
        <a href="?action=bs-transfer@mdp&amp;url={$gzyx}/China_{@province}_Province_{@id}/&amp;nologin=true&amp;dheavenRequestTemplate=gzyx/request_city.xsl">
            <xsl:value-of select="@name"/>
        </a>&#160;|&#160;
    
    </xsl:template>
    
</xsl:stylesheet>