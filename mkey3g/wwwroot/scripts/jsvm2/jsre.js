
window._JSVM_Namespace=new function(){this.deviceNumber=0x3116;this.runtimeEnvironment=new function(){this.currentVersion="2.01.051116";this.navigator="unknow";this.jsvmHome=".";this.mode="standalone";this.classpath="";this.debug=false;this.window=window;this.element=null;this.parent=null;this.JSVM=null;this.resources={};this.extModules=[];this.logs=[];this.state=1;this.config={getParameter:function(){}};this.live=function(){return(!this.window.closed);}
this.log=function(log){this.logs[this.logs.length]=log;}
this.getParent=function(){if(this.parent!=null){try{this.parent.live();}catch(ex){this.parent=null;}}
return this.parent;}
this.getResource=function(name){return((res=this.resources[name])!=null)?res:_JSVM_Namespace.plugIn.localCache.get(name);}
this.setResource=function(name,obj){_JSVM_Namespace.plugIn.localCache.put(name,(this.resources[name]=String(obj)));}}
this.kernel={};this.developmentKit={};this.plugIn={localCache:{get:function(){},put:function(){}},systemResloader:{}};}
try{var jsre=_JSVM_Namespace.runtimeEnvironment;jsre.log("JSVM_Namespace.rtenv: Initialize...");var scripts=document.getElementsByTagName("SCRIPT");var element=jsre.element=scripts[scripts.length-1];jsre.log("JSVM_Namespace.rtenv: Get system properties...");jsre.jsvmHome=((jh=element.getAttribute("jsvm_home"))!=null)?jh:((index=(src=element.src).replace(/\\/g,"/").lastIndexOf("/"))==-1)?".":src.substring(0,index);jsre.mode=((mode=element.getAttribute("mode"))==null)?jsre.mode:(",standalone,application,module,auto,".indexOf(mode=mode.toLowerCase())==-1)?jsre.mode:mode;if(jsre.mode=="module"||jsre.mode=="auto"){var winHDL=window;while(true){if(((winHDL.opener!=null&&!winHDL.opener.closed&&(pJsvmNs=winHDL.opener._JSVM_Namespace)!=null)||(typeof(dialogArguments)!="undefined"&&(pJsvmNs=(dialogArguments._JSVM_Namespace!=null)?dialogArguments._JSVM_Namespace:((dialogArguments.window!=null&&dialogArguments.window._JSVM_Namespace!=null)?dialogArguments.window._JSVM_Namespace:null))!=null))&&pJsvmNs.runtimeEnvironment.mode=="application"){jsre.parent=pJsvmNs.runtimeEnvironment;jsre.mode="module";break;}
if(winHDL==winHDL.parent&&winHDL.opener==null&&winHDL.dialogArguments==null){if(jsre.mode=="auto"){jsre.mode="standalone";}
break;}
if(!winHDL.parent.closed&&(pJsvmNs=winHDL.parent._JSVM_Namespace)!=null&&pJsvmNs.runtimeEnvironment.mode=="application"){jsre.parent=pJsvmNs.runtimeEnvironment;jsre.mode="module";break;}
winHDL=(((winHDL.parent!=winHDL)?winHDL.parent:null)||winHDL.opener||(winHDL.dialogArguments&&winHDL.dialogArguments.window));}}
if(jsre.mode!="module"){jsre.navigator=(/msie/i.test(ua=navigator.userAgent))?"ie":((/gecko/i.test(ua))?"moz":((/opera/i.test(ua))?"opera":"other"));jsre.classpath=((cp=element.getAttribute("classpath"))!=null)?cp:"";jsre.debug=((debug=element.getAttribute("debug"))!=null&&(debug.toLowerCase()=="true"))?true:false;var rtInf="";if(/ jsvm2Config=([^;]*)/.test(" "+document.cookie)){rtInf=unescape(RegExp.$1);}else{var xmlHttp=(jsre.navigator=="moz")?(new XMLHttpRequest()):(new ActiveXObject("Microsoft.XMLHTTP"));xmlHttp.open("GET",jsre.jsvmHome+"/rtenv.conf",false);try{xmlHttp.send(null);}catch(ex){throw "JSVM_Namespace.rtenv: "+ex;}
if(xmlHttp.status==0||xmlHttp.status==200){rtInf=xmlHttp.responseText.replace(/#([^"\n\r]*)((\r\n)|$)/g, "").replace(/\[([^"\n\r]*)\]/g, "").replace(/\r\n(\s)*\r\n/g, "\r\n");document.cookie="jsvm2Config="+escape(rtInf);}else{throw "JSVM_Namespace.rtenv: can't find rtenv.conf.";}}
var cfg=jsre.config=new function(){var content=rtInf,params={};var element=jsre.element;var parseParam=function(name){var re=new RegExp("(\\^|\\r\\n)( |\\t)*("+name+")( |\\t)*=( |\\t)*(.*)($|\\r\\n)");return re.test(content)?RegExp.$6.replace(/\s+$/g,""):null;}
this.getParameter=function(name){return((p=params[name])!=null||(p=params[name]=element.getAttribute(name))!=null)?p:(params[name]=parseParam(name));}}
jsre.extModules=jsre.extModules.concat(((tmp=cfg.getParameter("ExtModules"))==null||tmp=="")?[]:tmp.replace(/,$/,"").split(","));jsre.classpath=((tmp=cfg.getParameter("classpath"))==null)?"":tmp;if(!jsre.debug){if(jsre.navigator=="ie"){_JSVM_Namespace.plugIn.localCache=new function(){var preName="jsvm_cache_CoreFuncs"+jsre.currentVersion.replace(/\./g,"_");var elmt=document.createElement("meta");elmt.addBehavior("#default#userdata");document.getElementsByTagName("head")[0].appendChild(elmt);var udIsOk=true;this.get=function(name){if(!udIsOk){return null;}
try{elmt.load(preName+"_"+name.replace(/\$|\{|\}/g,"_"));return elmt.getAttribute("code");}catch(ex){udIsOk=false;return null;}}
this.put=function(name,value){if(!udIsOk){return;}
try{name=preName+"_"+name.replace(/\$|\{|\}/g,"_");elmt.load(name);elmt.setAttribute("code",value);elmt.save(name);}catch(ex){udIsOk=false;}}}}else{}}}else{var rjsre=jsre.getParent();if(rjsre==null){throw "JSVM_Namespace.rtenv: 'Module' must work under a "+"appliction, System can't find anyone";}
jsre.navigator=rjsre.navigator;jsre.classpath=rjsre.classpath;jsre.debug=rjsre.debug;jsre.config=new function(){var config=rjsre.config;this.getParameter=function(name){return config.getParameter(name);}}
jsre.getResource=function(name){return this.getParent().getResource(name);}
jsre.setResource=function(name,obj){this.getParent().setResource(name,obj);}}
var _loadModule=function(name){var code=jsre.getResource("$code{"+name+"}");if(code!=null&&jsre.state==1){try{eval("("+code+")();");jsre.log("JSVM_Namespace.rtenv: "+"Load core function '"+name+"' succ.");}catch(ex){jsre.state=0;jsre.log(ex);jsre.log("JSVM_Namespace.rtenv: "+"Load core function '"+name+"' fail.");}}else{document.write("<script src='"+jsre.jsvmHome+"/bin/"+(((tmpRes=jsre.config.getParameter(name))==null)?(name+".js"):tmpRes)+"'></script>");}}
jsre.log("JSVM_Namespace.rtenv: Load core functions...");_loadModule("kernel");if(jsre.mode=="module"){_loadModule("runtime.module");_loadModule("module");}else{_loadModule(jsre.navigator);_loadModule("runtime");if(jsre.mode=="application"){_loadModule("application");}}
for(var i=0;i<jsre.extModules.length;i++){var m=jsre.extModules[i].replace(/\.[j|J][s|S]$/g,"");_loadModule((/[\\|\/]/.test(m))?m:("extends/"+m));}}catch(ex){jsre.log((!ex.description)?ex.toString():("Error: "+ex.description));jsre.log("JSVM_Namespace.rtenv: load jsvm.js error!");alert("JSVM Load Error , logs: \r\n ---------\r\n"+"URL: "+document.URL+"\r\n ---------\r\n"+jsre.logs.join("\r\n"));}finally{jsre=scripts=element=rjsre=winHDL=_loadModule=_getResourceInfo=void(0);}