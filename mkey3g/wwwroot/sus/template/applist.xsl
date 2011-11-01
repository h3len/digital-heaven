<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:template match="msc">
		<msc type='form' showHead='false' showFoot='false'>
			<head>
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
			<body margin='0'>
				<span width="100%" dock="top"
					background="iphone/iphone_top_bg.png">
					<span width="29%">
						<input type="image" src="iphone/back02.png"
							src_down="iphone/back02_.png" href="script:back();" />
					</span>
					  <span width="42%" align="center" valign="center">
       					 <img src="iphone/top_line.png"/><font color="#FFFFFF">业务列表</font>
      				</span>
					<span width="29%" align="right"></span>
				</span>
				<span width="100%" id="all" visible="true">
					<xsl:apply-templates select="/msc/body/span"></xsl:apply-templates>
				</span>
			</body>
		</msc>
	</xsl:template>
	<xsl:template match="span">
		<span id="{@spanid}" width="100%" visible="true"
			background="img/list_bg.png" align="center" valign="center"
			href="{@actionurl}">
			<span width="1%">
				<img src="img/list_blank.png"></img>
			</span>
			<span width="99%" href="{@action}" valign="center">
				<span width="30%" align="center" valign="center">
					<img src="{@icon}" />
				</span>
				<span width="51%" valign="center">
					<span width="2%" />
					<font id="{@fontid}" size="m">
						<xsl:value-of select="@appname" />
					</font>
					<input type="hidden" id="{@inputid}" />
				</span>
				<span width="19%" align="center" valign="center">
					<img src="img/arrow.png" />
				</span>
			</span>
			<img src="img/line.png" />
		</span>
		<span width="100%" id="{@nullspanid}" visible="true" />
	</xsl:template>
</xsl:stylesheet>
