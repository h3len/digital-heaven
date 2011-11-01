<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="msc">
		<msc type="form" id="homepage"  showHead="true" showFoot="true">
			<head>
				<title>业务列表</title>
				<script>
					<![CDATA[
					function runApp(appid,id){
					var applist = msc.listApp();
					for(var i=0;i<applist.length;i++){
						if(applist[i]==appid){
						var appsXml=document.implementation.createDocument(null, null, null);
						if(application.fso.fileExists('jsdata:appsXml.xml')){
							appsXml.load('jsdata:appsXml.xml');
						}
						var apps=appsXml.documentElement.childNodes;
						var thisApp=appsXml.documentElement.getElementById(appid);
						var time=thisApp.getAttribute('runtime');
						thisApp.setAttribute('runtime',(new Number(time)+1).toString());
						var len = apps.length;
						var one;
						var two;
                        for(var i=0;i<len;i++){ 
							for(var j=i+1;j<len;j++){
							one=new Number(apps[i].getAttribute('runtime'));
							two=new Number(apps[j].getAttribute('runtime'));
							if(one<two){
									var tempId=apps[j].getAttribute('id');
									var tempDomain=apps[j].getAttribute('domain');
									var tempRuntime=apps[j].getAttribute('runtime');
                                     apps[j].setAttribute('id',apps[i].getAttribute('id'));
                                     apps[j].setAttribute('domain',apps[i].getAttribute('domain'));
                                     apps[j].setAttribute('runtime',apps[i].getAttribute('runtime'));
                                     apps[i].setAttribute('id',tempId);
                                     apps[i].setAttribute('domain',tempDomain);
                                     apps[i].setAttribute('runtime',tempRuntime);
							}
						}
						}
						var _fso = new Fso();
                        _fso.writeXMLDocument(appsXml,'jsdata:appsXml.xml');
						
						
							msc.run(appid);
							return false;
						}
					}
					location.href='?action=getDomainAppInfo@sus&domainappid='+id;
				}
				function back(){
				 if(msc.listApp().length>1){
				 	 location.href="viewSet1.xml";
				 }else{
				 	 location.href="addServer.xml";
				 }
				}
				]]>
				</script>
			</head>
			<body margin="0" bgcolor="#f1f2f3">
    <span width="100%" dock="top" background="iphone/iphone_top_bg.png">
     
    </span>
    
      <img src="img/top.png"/>
   
<img src="img/line.png"/>

    <span width="100%" height="24"/>
  
    <xsl:apply-templates select="/msc/body/span"></xsl:apply-templates>
  </body>
  <foot>
       <item id="chaoshiButton" type="button" caption="返　回" href="script:back();" align="primary"/>
  </foot>

</msc>
</xsl:template>
<xsl:template match="span">
	<span  width="33%" visible="true"  align="center" valign="center">
        <span width="100%" align="center" valign="center">
          <input type="image" href="{@actionurl}" src="{@icon}" src_down="{@icon}" src_focus="{@icon}"/>
        </span>
        <span  width="100%" align="center" valign="center">
          <font id="{@fontid}" size="m"><xsl:value-of select="@appname" /></font>
        </span>
    </span>
</xsl:template>
</xsl:stylesheet>
