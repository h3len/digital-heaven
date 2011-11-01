/*
 * Ext JS Library 1.0 Beta 1
 * Copyright(c) 2006-2007, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://www.extjs.com/license
 */

Ext={};window["undefined"]=window["undefined"];Ext.apply=function(o,c,_3){if(_3){Ext.apply(o,_3);}if(o&&c){for(var p in c){o[p]=c[p];}}return o;};(function(){var _5=0;var ua=navigator.userAgent.toLowerCase();var _7=document.compatMode=="CSS1Compat",_8=ua.indexOf("opera")>-1,_9=ua.indexOf("webkit")>-1,_a=ua.indexOf("msie")>-1,_b=ua.indexOf("msie 7")>-1,_c=!_9&&ua.indexOf("gecko")>-1,_d=_a&&!_7,_e=(ua.indexOf("windows")!=-1||ua.indexOf("win32")!=-1),_f=(ua.indexOf("macintosh")!=-1||ua.indexOf("mac os x")!=-1);if(_a&&!_b){try{document.execCommand("BackgroundImageCache",false,true);}catch(e){}}Ext.apply(Ext,{isStrict:_7,SSL_SECURE_URL:"javascript:false",BLANK_IMAGE_URL:"http:/"+"/www.yui-ext.com/s.gif",emptyFn:function(){},applyIf:function(o,c){if(o&&c){for(var p in c){if(typeof o[p]=="undefined"){o[p]=c[p];}}}return o;},id:function(el,_14){_14=_14||"ext-gen";el=Ext.getDom(el);var id=_14+(++_5);return el?(el.id?el.id:(el.id=id)):id;},extend:function(){var io=function(o){for(var m in o){this[m]=o[m];}};return function(sc,sp,_1b){var F=function(){},scp,spp=sp.prototype;F.prototype=spp;scp=sc.prototype=new F();scp.constructor=sc;sc.superclass=spp;if(spp.constructor==Object.prototype.constructor){spp.constructor=sp;}sc.override=function(o){Ext.override(sc,o);};scp.override=io;Ext.override(sc,_1b);return sc;};}(),override:function(_20,_21){if(_21){var p=_20.prototype;for(var _23 in _21){p[_23]=_21[_23];}}},namespace:function(){var a=arguments,o=null,i,j,d,rt;for(i=0;i<a.length;++i){d=a[i].split(".");rt=d[0];eval("if (typeof "+rt+" == \"undefined\"){"+rt+" = {};} o = "+rt+";");for(j=1;j<d.length;++j){o[d[j]]=o[d[j]]||{};o=o[d[j]];}}},urlEncode:function(o){if(!o){return "";}var buf=[];for(var key in o){var _2d=typeof o[key];if(_2d!="function"&&_2d!="object"){buf.push(encodeURIComponent(key),"=",encodeURIComponent(o[key]),"&");}}buf.pop();return buf.join("");},each:function(_2e,fn,_30){if(typeof _2e.length=="undefined"||typeof _2e=="string"){_2e=[_2e];}for(var i=0,len=_2e.length;i<len;i++){if(fn.call(_30||_2e[i],_2e[i],i,_2e)===false){return i;}}},combine:function(){var as=arguments,l=as.length,r=[];for(var i=0;i<l;i++){var a=as[i];if(a instanceof Array){r=r.concat(a);}else{if(a.length!==undefined&&!a.substr){r=r.concat(Array.prototype.slice.call(a,0));}else{r.push(a);}}}return r;},escapeRe:function(s){return s.replace(/([.*+?^${}()|[\]\/\\])/g,"\\$1");},callback:function(cb,_3a,_3b,_3c){if(typeof cb=="function"){if(_3c){cb.defer(_3c,_3a,_3b||[]);}else{cb.apply(_3a,_3b||[]);}}},getDom:function(el){if(!el){return null;}return el.dom?el.dom:(typeof el=="string"?document.getElementById(el):el);},isOpera:_8,isSafari:_9,isIE:_a,isIE7:_b,isGecko:_c,isBorderBox:_d,isWindows:_e,isMac:_f,useShims:((_a&&!_b)||(_c&&_f))});})();Ext.namespace("Ext","Ext.util","Ext.grid","Ext.dd","Ext.tree","Ext.data","Ext.form","Ext.menu","Ext.state","Ext.lib");Ext.apply(Function.prototype,{createCallback:function(){var _3e=arguments;var _3f=this;return function(){return _3f.apply(window,_3e);};},createDelegate:function(obj,_41,_42){var _43=this;return function(){var _44=_41||arguments;if(_42===true){_44=Array.prototype.slice.call(arguments,0);_44=_44.concat(_41);}else{if(typeof _42=="number"){_44=Array.prototype.slice.call(arguments,0);var _45=[_42,0].concat(_41);Array.prototype.splice.apply(_44,_45);}}return _43.apply(obj||window,_44);};},defer:function(_46,obj,_48,_49){var fn=this.createDelegate(obj,_48,_49);if(_46){return setTimeout(fn,_46);}fn();return 0;},createSequence:function(fcn,_4c){if(typeof fcn!="function"){return this;}var _4d=this;return function(){var _4e=_4d.apply(this||window,arguments);fcn.apply(_4c||this||window,arguments);return _4e;};},createInterceptor:function(fcn,_50){if(typeof fcn!="function"){return this;}var _51=this;return function(){fcn.target=this;fcn.method=_51;if(fcn.apply(_50||this||window,arguments)===false){return;}return _51.apply(this||window,arguments);};}});Ext.applyIf(String,{escape:function(_52){return _52.replace(/('|\\)/g,"\\$1");},leftPad:function(val,_54,ch){var _56=new String(val);if(ch==null){ch=" ";}while(_56.length<_54){_56=ch+_56;}return _56;},format:function(_57){var _58=Array.prototype.slice.call(arguments,1);return _57.replace(/\{(\d+)\}/g,function(m,i){return _58[i];});}});String.prototype.toggle=function(_5b,_5c){return this==_5b?_5c:_5b;};Ext.applyIf(Number.prototype,{constrain:function(min,max){return Math.min(Math.max(this,min),max);}});Ext.applyIf(Array.prototype,{indexOf:function(o){for(var i=0,len=this.length;i<len;i++){if(this[i]==o){return i;}}return -1;},remove:function(o){var _63=this.indexOf(o);if(_63!=-1){this.splice(_63,1);}}});Date.prototype.getElapsed=function(_64){return Math.abs((_64||new Date()).getTime()-this.getTime());};

if(typeof jQuery=="undefined"){throw "Unable to load Ext, jQuery not found.";}(function(){Ext.lib.Dom={getViewWidth:function(_1){return _1?Math.max(jQuery(document).width(),jQuery(window).width()):jQuery(window).width();},getViewHeight:function(_2){return _2?Math.max(jQuery(document).height(),jQuery(window).height()):jQuery(window).height();},isAncestor:function(p,c){p=Ext.getDom(p);c=Ext.getDom(c);if(!p||!c){return false;}if(p.contains&&!Ext.isSafari){return p.contains(c);}else{if(p.compareDocumentPosition){return !!(p.compareDocumentPosition(c)&16);}else{var _5=c.parentNode;while(_5){if(_5==p){return true;}else{if(!_5.tagName||_5.tagName.toUpperCase()=="HTML"){return false;}}_5=_5.parentNode;}return false;}}},getRegion:function(el){return Ext.lib.Region.getRegion(el);},getY:function(el){return jQuery(el).offset().top;},getX:function(el){return jQuery(el).offset().left;},getXY:function(el){var o=jQuery(el).offset();return [o.left,o.top];},setXY:function(el,xy){el=Ext.fly(el,"_setXY");el.position();var _d=el.translatePoints(xy);if(xy[0]!==false){el.dom.style.left=_d.left+"px";}if(xy[1]!==false){el.dom.style.top=_d.top+"px";}},setX:function(el,x){this.setXY(el,[x,false]);},setY:function(el,y){this.setXY(el,[false,y]);}};Ext.lib.Event={getPageX:function(e){e=e.browserEvent||e;return e.pageX;},getPageY:function(e){e=e.browserEvent||e;return e.pageY;},getXY:function(e){e=e.browserEvent||e;return [e.pageX,e.pageY];},getTarget:function(e){return e.target;},on:function(el,_17,fn,_19,_1a){jQuery(el).bind(_17,fn);},un:function(el,_1c,fn){jQuery(el).unbind(_1c,fn);},purgeElement:function(el){jQuery(el).unbind();},preventDefault:function(e){e=e.browserEvent||e;e.preventDefault();},stopPropagation:function(e){e=e.browserEvent||e;e.stopPropagation();},stopEvent:function(e){e=e.browserEvent||e;e.preventDefault();e.stopPropagation();},onAvailable:function(id,fn,_24){var _25=new Date();var f=function(){if(_25.getElapsed()>10000){clearInterval(iid);}var el=document.getElementById(id);if(el){clearInterval(iid);fn.call(_24||window,el);}};var iid=setInterval(f,50);},resolveTextNode:function(_29){if(_29&&3==_29.nodeType){return _29.parentNode;}else{return _29;}},getRelatedTarget:function(ev){ev=ev.browserEvent||ev;var t=ev.relatedTarget;if(!t){if(ev.type=="mouseout"){t=ev.toElement;}else{if(ev.type=="mouseover"){t=ev.fromElement;}}}return this.resolveTextNode(t);}};Ext.lib.Ajax=function(){var _2c=function(cb){return function(xhr,_2f){if((_2f=="error"||_2f=="timeout")&&cb.failure){cb.failure.call(cb.scope||window,{responseText:xhr.responseText,responseXML:xhr.responseXML,argument:cb.argument});}else{if(cb.success){cb.success.call(cb.scope||window,{responseText:xhr.responseText,responseXML:xhr.responseXML,argument:cb.argument});}}};};return {request:function(_30,uri,cb,_33){jQuery.ajax({type:_30,url:uri,data:_33,timeout:cb.timeout,complete:_2c(cb)});},formRequest:function(_34,uri,cb,_37,_38,_39){jQuery.ajax({type:"POST",url:uri,data:jQuery(_34).formSerialize(),timeout:cb.timeout,complete:_2c(cb)});},isCallInProgress:function(_3a){return false;},abort:function(_3b){return false;}};}();Ext.lib.Anim=function(){var _3c=function(cb,_3e){var _3f=true;return {stop:function(_40){},isAnimated:function(){return _3f;},proxyCallback:function(){_3f=false;Ext.callback(cb,_3e);}};};return {scroll:function(el,_42,_43,_44,cb,_46){var _47=_3c(cb,_46);el=Ext.getDom(el);el.scrollLeft=_42.to[0];el.scrollTop=_42.to[1];_47.proxyCallback();return _47;},motion:function(el,_49,_4a,_4b,cb,_4d){return this.run(el,_49,_4a,_4b,cb,_4d);},color:function(el,_4f,_50,_51,cb,_53){var _54=_3c(cb,_53);_54.proxyCallback();return _54;},run:function(el,_56,_57,_58,cb,_5a,_5b){var _5c=_3c(cb,_5a);var o={};for(var k in _56){switch(k){case "points":var by,pts,e=Ext.fly(el,"_animrun");e.position();if(by=_56.points.by){var xy=e.getXY();pts=e.translatePoints([xy[0]+by[0],xy[1]+by[1]]);}else{pts=e.translatePoints(_56.points.to);}o.left=pts.left;o.top=pts.top;if(!parseInt(e.getStyle("left"),10)){e.setLeft(0);}if(!parseInt(e.getStyle("top"),10)){e.setTop(0);}break;case "width":o.width=_56.width.to;break;case "height":o.height=_56.height.to;break;case "opacity":o.opacity=_56.opacity.to;break;default:o[k]=_56[k].to;break;}}jQuery(el).animate(o,_57*1000,undefined,_5c.proxyCallback);return _5c;}};}();Ext.lib.Region=function(t,r,b,l){this.top=t;this[1]=t;this.right=r;this.bottom=b;this.left=l;this[0]=l;};Ext.lib.Region.prototype={contains:function(_67){return (_67.left>=this.left&&_67.right<=this.right&&_67.top>=this.top&&_67.bottom<=this.bottom);},getArea:function(){return ((this.bottom-this.top)*(this.right-this.left));},intersect:function(_68){var t=Math.max(this.top,_68.top);var r=Math.min(this.right,_68.right);var b=Math.min(this.bottom,_68.bottom);var l=Math.max(this.left,_68.left);if(b>=t&&r>=l){return new Ext.lib.Region(t,r,b,l);}else{return null;}},union:function(_6d){var t=Math.min(this.top,_6d.top);var r=Math.max(this.right,_6d.right);var b=Math.max(this.bottom,_6d.bottom);var l=Math.min(this.left,_6d.left);return new Ext.lib.Region(t,r,b,l);},adjust:function(t,l,b,r){this.top+=t;this.left+=l;this.right+=r;this.bottom+=b;return this;}};Ext.lib.Region.getRegion=function(el){var p=Ext.lib.Dom.getXY(el);var t=p[1];var r=p[0]+el.offsetWidth;var b=p[1]+el.offsetHeight;var l=p[0];return new Ext.lib.Region(t,r,b,l);};Ext.lib.Point=function(x,y){if(x instanceof Array){y=x[1];x=x[0];}this.x=this.right=this.left=this[0]=x;this.y=this.top=this.bottom=this[1]=y;};Ext.lib.Point.prototype=new Ext.lib.Region();if(Ext.isIE){jQuery(window).unload(function(){var p=Function.prototype;delete p.createSequence;delete p.defer;delete p.createDelegate;delete p.createCallback;delete p.createInterceptor;});}})();

