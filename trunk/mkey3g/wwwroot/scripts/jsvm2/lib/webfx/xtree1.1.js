/**
* Created by Thu Dec 1 17:38:14 UTC+0800 2005
*/
_JSVM_Namespace.runtimeEnvironment
	.JSVM.getClassloader().loadLib(new function()
{
this.manifest =
{
"name" : "webfx xtree",
"uri" : "xtree1.1.js",
"version" : "1.0",
"lastModified" : "Thu Dec 1 17:38:14 UTC+0800 2005",
"author" : "webfx",
"remark" : ""
};
this.entity =
{
 "com.eae.webfx.xtree.WebFXLoadTree" : "(function(){_$package(\"com.eae.webfx.xtree\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var WebFXTreeAbstractNode=_$import(\"com.eae.webfx.xtree.WebFXTreeAbstractNode\");var WebFXTreeItem=_$import(\"com.eae.webfx.xtree.WebFXTreeItem\");var WebFXUtil=_$import(\"com.eae.webfx.xtree.WebFXUtil\");var WebFXTree=_$import(\"com.eae.webfx.xtree.WebFXTree\");var $class=com.eae.webfx.xtree.WebFXLoadTree=function(){return $WebFXLoadTree.apply(this,arguments);};var WebFXLoadTree=$class;$class.$extends(WebFXTree);var $WebFXLoadTree=function(sText,sXmlSrc,sAction,sBehavior,sIcon,sOpenIcon){$class.$super.call(this,sText,sAction,sBehavior,sIcon,sOpenIcon);this.src=sXmlSrc;this.loading=false;this.loaded=false;this.errorText=\"\";if(this.open)\r\nWebFXUtil.startLoadXmlTree(this.src,this);else{this._loadingItem=new WebFXTreeItem(WebFXTreeConfig.loadingText);this.add(this._loadingItem);}}\r\nWebFXLoadTree.prototype.expand=function(){if(!this.loaded&&!this.loading){WebFXUtil.startLoadXmlTree(this.src,this);}\r\n$class.$super.prototype.expand.call(this);};WebFXLoadTree.prototype.build=function(container){if(container==null){document.write(this.toString());}else{container.innerHTML=this.toString();}}})();",
 "com.eae.webfx.xtree.WebFXLoadTreeItem" : "(function(){_$package(\"com.eae.webfx.xtree\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var WebFXTreeAbstractNode=_$import(\"com.eae.webfx.xtree.WebFXTreeAbstractNode\");var WebFXTreeItem=_$import(\"com.eae.webfx.xtree.WebFXTreeItem\");var WebFXUtil=_$import(\"com.eae.webfx.xtree.WebFXUtil\");var WebFXLoadTree=_$import(\"com.eae.webfx.xtree.WebFXLoadTree\");var $class=com.eae.webfx.xtree.WebFXLoadTreeItem=function(){return $WebFXLoadTreeItem.apply(this,arguments);};var WebFXLoadTreeItem=$class;$class.$extends(WebFXTreeItem);var $WebFXLoadTreeItem=function(sText,sXmlSrc,sAction,eParent,sIcon,sOpenIcon,sRadio,sCheckBox,sValue,sChecked){$class.$super.call(this,sText,sAction,eParent,sIcon,sOpenIcon);this.radio=sRadio;this.checkbox=sCheckBox;this.value=sValue;this.checked=sChecked;this.src=sXmlSrc;this.loading=false;this.loaded=false;this.errorText=\"\";if(this.open){WebFXUtil.startLoadXmlTree(this.src,this);}else{this._loadingItem=new WebFXTreeItem(WebFXTreeConfig.loadingText);this.add(this._loadingItem);}}\r\nWebFXLoadTreeItem.prototype.expand=function(){if(!this.loaded&&!this.loading){WebFXUtil.startLoadXmlTree(this.src,this);}\r\n$class.$super.prototype.expand.call(this);};WebFXLoadTree.prototype.reload=WebFXLoadTreeItem.prototype.reload=function(){if(this.loaded){var open=this.open;try{while(this.childNodes.length>0){this.childNodes[this.childNodes.length-1].remove();}}catch(ex){}\r\nthis.loaded=false;this._loadingItem=new WebFXTreeItem(WebFXTreeConfig.loadingText);this.add(this._loadingItem);if(open){this.expand();}}else if(this.open&&!this.loading){WebFXUtil.startLoadXmlTree(this.src,this);alert(\"..\");}};})();",
 "com.eae.webfx.xtree.WebFXTree" : "(function(){_$package(\"com.eae.webfx.xtree\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var WebFXTreeAbstractNode=_$import(\"com.eae.webfx.xtree.WebFXTreeAbstractNode\");var $class=com.eae.webfx.xtree.WebFXTree=function(){return $WebFXTree.apply(this,arguments);};var WebFXTree=$class;$class.$extends(WebFXTreeAbstractNode);var $WebFXTree=function(sText,sAction,sBehavior,sIcon,sOpenIcon){$class.$super.call(this,sText,sAction);this.icon=sIcon||WebFXTreeConfig.rootIcon;this.openIcon=sOpenIcon||WebFXTreeConfig.openRootIcon;if(WebFXTreeConfig.usePersistence){this.open=(WebFXTreeHandler.cookies.getValue(this.id.substr(18,this.id.length-18))=='0')?false:true;}else{this.open=true;}\r\nthis.folder=true;this.rendered=false;this.onSelect=null;if(!WebFXTreeHandler.behavior){WebFXTreeHandler.behavior=sBehavior||WebFXTreeConfig.defaultBehavior;}\r\nthis.onCheck=null;}\r\nWebFXTree.prototype.setBehavior=function(sBehavior){WebFXTreeHandler.behavior=sBehavior;};WebFXTree.prototype.getBehavior=function(){return WebFXTreeHandler.behavior;};WebFXTree.prototype.getSelected=function(){if(WebFXTreeHandler.selected){return WebFXTreeHandler.selected;}else{return null;}}\r\nWebFXTree.prototype.remove=function(){}\r\nWebFXTree.prototype.expand=function(){this.doExpand();}\r\nWebFXTree.prototype.collapse=function(b){if(!b){this.focus();}\r\nthis.doCollapse();}\r\nWebFXTree.prototype.getFirst=function(){return null;}\r\nWebFXTree.prototype.getLast=function(){return null;}\r\nWebFXTree.prototype.getNextSibling=function(){return null;}\r\nWebFXTree.prototype.getPreviousSibling=function(){return null;}\r\nWebFXTree.prototype.keydown=function(key){if(key==39){if(!this.open){this.expand();}else if(this.childNodes.length){this.childNodes[0].select();}\r\nreturn false;}\r\nif(key==37){this.collapse();return false;}\r\nif((key==40)&&(this.open)&&(this.childNodes.length)){this.childNodes[0].select();return false;}\r\nreturn true;}\r\nWebFXTree.prototype.toString=function(){var str=\"<div id=\\\"\"+this.id+\"\\\" ondblclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.toggle(this);\\\" class=\\\"webfx-tree-item\\\" onkeydown=\\\"return com.eae.webfx.xtree.WebFXTreeHandler.keydown(this, event)\\\">\"+\"<img id=\\\"\"+this.id+\"-icon\\\" class=\\\"webfx-tree-icon\\\" src=\\\"\"+((WebFXTreeHandler.behavior=='classic'&&this.open)?this.openIcon:this.icon)+\"\\\" onclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.select(this);\\\">\"+\"<a href=\\\"\"+this.action+\"\\\" id=\\\"\"+this.id+\"-anchor\\\" onfocus=\\\"com.eae.webfx.xtree.WebFXTreeHandler.focus(this);\\\" onblur=\\\"com.eae.webfx.xtree.WebFXTreeHandler.blur(this);\\\"\"+(this.target?\" target=\\\"\"+this.target+\"\\\"\":\"\")+\">\"+this.text+\"</a></div>\"+\"<div id=\\\"\"+this.id+\"-cont\\\" class=\\\"webfx-tree-container\\\" style=\\\"display: \"+((this.open)?'block':'none')+\";\\\">\";var sb=[];for(var i=0;i<this.childNodes.length;i++){sb[i]=this.childNodes[i].toString(i,this.childNodes.length);}\r\nthis.rendered=true;return str+sb.join(\"\")+\"</div>\";};WebFXTree.prototype.build=function(container){if(container==null){document.write(this.toString());}else{container.innerHTML=this.toString();}}})();",
 "com.eae.webfx.xtree.WebFXTreeAbstractNode" : "(function(){_$package(\"com.eae.webfx.xtree\");var BObject=_$import(\"js.lang.BObject\");var ArrayList=_$import(\"js.util.ArrayList\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var $class=com.eae.webfx.xtree.WebFXTreeAbstractNode=function(){return $WebFXTreeAbstractNode.apply(this,arguments);};var WebFXTreeAbstractNode=$class;$class.$extends(BObject);var $WebFXTreeAbstractNode=function(sText,sAction){this.parentNode=null;this.childNodes=[];this.id=WebFXTreeHandler.getId();this.text=sText||WebFXTreeConfig.defaultText;this.action=sAction||WebFXTreeConfig.defaultAction;this._last=false;WebFXTreeHandler.all[this.id]=this;}\r\nWebFXTreeAbstractNode.prototype.add=function(node,bNoIdent){node.parentNode=this;this.childNodes[this.childNodes.length]=node;var root=this;if(this.childNodes.length>=2){this.childNodes[this.childNodes.length-2]._last=false;}\r\nwhile(root.parentNode){root=root.parentNode;}\r\nif(root.rendered){if(this.childNodes.length>=2){document.getElementById(this.childNodes[this.childNodes.length-2].id+'-plus').src=((this.childNodes[this.childNodes.length-2].folder)?((this.childNodes[this.childNodes.length-2].open)?WebFXTreeConfig.tMinusIcon:WebFXTreeConfig.tPlusIcon):WebFXTreeConfig.tIcon);this.childNodes[this.childNodes.length-2].plusIcon=WebFXTreeConfig.tPlusIcon;this.childNodes[this.childNodes.length-2].minusIcon=WebFXTreeConfig.tMinusIcon;this.childNodes[this.childNodes.length-2]._last=false;}\r\nthis._last=true;var foo=this;while(foo.parentNode){for(var i=0;i<foo.parentNode.childNodes.length;i++){if(foo.id==foo.parentNode.childNodes[i].id){break;}}\r\nif(i==foo.parentNode.childNodes.length-1){foo.parentNode._last=true;}else{foo.parentNode._last=false;}\r\nfoo=foo.parentNode;}\r\nWebFXTreeHandler.insertHTMLBeforeEnd(document.getElementById(this.id+'-cont'),node.toString());if((!this.folder)&&(!this.openIcon)){this.icon=WebFXTreeConfig.folderIcon;this.openIcon=WebFXTreeConfig.openFolderIcon;}\r\nif(!this.folder){this.folder=true;this.collapse(true);}\r\nif(!bNoIdent){this.indent();}}\r\nreturn node;}\r\nWebFXTreeAbstractNode.prototype.toggle=function(){if(this.folder){if(this.open){this.collapse();}else{this.expand();}}}\r\nWebFXTreeAbstractNode.prototype.select=function(){document.getElementById(this.id+'-anchor').focus();}\r\nWebFXTreeAbstractNode.prototype.deSelect=function(){document.getElementById(this.id+'-anchor').className='';WebFXTreeHandler.selected=null;}\r\nWebFXTreeAbstractNode.prototype.focus=function(){if((WebFXTreeHandler.selected)&&(WebFXTreeHandler.selected!=this)){WebFXTreeHandler.selected.deSelect();}\r\nWebFXTreeHandler.selected=this;if((this.openIcon)&&(WebFXTreeHandler.behavior!='classic')){document.getElementById(this.id+'-icon').src=this.openIcon;}\r\ndocument.getElementById(this.id+'-anchor').className='selected';document.getElementById(this.id+'-anchor').focus();if(WebFXTreeHandler.onSelect){WebFXTreeHandler.onSelect(this);}}\r\nWebFXTreeAbstractNode.prototype.blur=function(){if((this.openIcon)&&(WebFXTreeHandler.behavior!='classic')){document.getElementById(this.id+'-icon').src=this.icon;}\r\ndocument.getElementById(this.id+'-anchor').className='selected-inactive';}\r\nWebFXTreeAbstractNode.prototype.doExpand=function(){if(WebFXTreeHandler.behavior=='classic'){document.getElementById(this.id+'-icon').src=this.openIcon;}\r\nif(this.childNodes.length){document.getElementById(this.id+'-cont').style.display='block';}\r\nthis.open=true;if(WebFXTreeConfig.usePersistence){WebFXTreeHandler.cookies.setValue(this.id.substr(18,this.id.length-18),'1');}}\r\nWebFXTreeAbstractNode.prototype.doCollapse=function(){if(WebFXTreeHandler.behavior=='classic'){document.getElementById(this.id+'-icon').src=this.icon;}\r\nif(this.childNodes.length){document.getElementById(this.id+'-cont').style.display='none';}\r\nthis.open=false;if(WebFXTreeConfig.usePersistence){WebFXTreeHandler.cookies.setValue(this.id.substr(18,this.id.length-18),'0');}}\r\nWebFXTreeAbstractNode.prototype.expandAll=function(){this.expandChildren();if((this.folder)&&(!this.open)){this.expand();}}\r\nWebFXTreeAbstractNode.prototype.expandChildren=function(){for(var i=0;i<this.childNodes.length;i++){this.childNodes[i].expandAll();}}\r\nWebFXTreeAbstractNode.prototype.collapseAll=function(){this.collapseChildren();if((this.folder)&&(this.open)){this.collapse(true);}}\r\nWebFXTreeAbstractNode.prototype.collapseChildren=function(){for(var i=0;i<this.childNodes.length;i++){this.childNodes[i].collapseAll();}}\r\nWebFXTreeAbstractNode.prototype.indent=function(lvl,del,last,level,nodesLeft){if(lvl==null){lvl=-2;}\r\nvar state=0;for(var i=this.childNodes.length-1;i>=0;i--){state=this.childNodes[i].indent(lvl+1,del,last,level);if(state){return;}}\r\nif(del){if((level>=this._level)&&(document.getElementById(this.id+'-plus'))){if(this.folder){document.getElementById(this.id+'-plus').src=(this.open)?WebFXTreeConfig.lMinusIcon:WebFXTreeConfig.lPlusIcon;this.plusIcon=WebFXTreeConfig.lPlusIcon;this.minusIcon=WebFXTreeConfig.lMinusIcon;}else if(nodesLeft){document.getElementById(this.id+'-plus').src=WebFXTreeConfig.lIcon;}\r\nreturn 1;}}\r\nvar foo=document.getElementById(this.id+'-indent-'+lvl);if(foo){if((foo._last)||((del)&&(last))){foo.src=WebFXTreeConfig.blankIcon;}else{foo.src=WebFXTreeConfig.iIcon;}}\r\nreturn 0;}\r\nWebFXTreeAbstractNode.prototype.update=function(){document.getElementById(this.id+'-anchor').innerHTML=this.text;}\r\nWebFXTreeAbstractNode.prototype.getRootNode=function(){var pNode=this.parentNode;if(pNode==null){return this;}\r\nwhile(pNode.parentNode!=null){pNode=pNode.parentNode;}\r\nreturn pNode;}\r\nWebFXTreeAbstractNode.prototype.getSelectedChildNodes=function(){try{var radioObjName=WebFXTreeConfig.elementPrefix+\"selRadioObj\";var checkObjName=WebFXTreeConfig.elementPrefix+\"selCheckObj\";var list=new ArrayList();var sels=document.getElementsByName(radioObjName);var l=sels.length;for(var i=0;i<l;i++){if(sels[i].checked){var sId=sels[i].getAttribute(\"oid\");var node=WebFXTreeHandler.getObjectById(sId);if(node.getRootNode()==this){list.add(node);}}}\r\nsels=document.getElementsByName(checkObjName);l=sels.length;for(var i=0;i<l;i++){if(sels[i].checked){var sId=sels[i].getAttribute(\"oid\");var node=WebFXTreeHandler.getObjectById(sId);if(node.getRootNode()==this){list.add(node);}}}\r\nreturn list.toArray();}catch(ex){ex.printStackTrace();return [];}}})();\r\nWebFXTreeAbstractNode.prototype.getAllChildNodes=function(){alert("xxxxx");try{var radioObjName=WebFXTreeConfig.elementPrefix+\"selRadioObj\";var checkObjName=WebFXTreeConfig.elementPrefix+\"selCheckObj\";var list=new ArrayList();var sels=document.getElementsByName(radioObjName);var l=sels.length;for(var i=0;i<l;i++){var sId=sels[i].getAttribute(\"oid\");var node=WebFXTreeHandler.getObjectById(sId);if(node.getRootNode()==this){list.add(node);}}\r\nsels=document.getElementsByName(checkObjName);l=sels.length;for(var i=0;i<l;i++){var sId=sels[i].getAttribute(\"oid\");var node=WebFXTreeHandler.getObjectById(sId);if(node.getRootNode()==this){list.add(node);}}\r\nreturn list.toArray();}catch(ex){ex.printStackTrace();return [];}}})();",
 "com.eae.webfx.xtree.WebFXTreeConfig" : "(function(){_$package(\"com.eae.webfx.xtree\");var System=_$import(\"js.lang.System\");var StyleSheet=_$import(\"js.dom.StyleSheet\");var $class=com.eae.webfx.xtree.WebFXTreeConfig=function(){return $WebFXTreeConfig.apply(this,arguments);};var WebFXTreeConfig=$class;$class.$extends(_JSVM_Namespace.kernel.Object);var $WebFXTreeConfig=function(){}\r\nvar resroot=System.getClassHome()+\"/com/eae/webfx/xtree/__res\";WebFXTreeConfig.rootIcon=resroot+'/images/foldericon.png';WebFXTreeConfig.openRootIcon=resroot+'/images/openfoldericon.png';WebFXTreeConfig.folderIcon=resroot+'/images/foldericon.png';WebFXTreeConfig.openFolderIcon=resroot+'/images/openfoldericon.png';WebFXTreeConfig.fileIcon=resroot+'/images/file.png';WebFXTreeConfig.iIcon=resroot+'/images/I.png';WebFXTreeConfig.lIcon=resroot+'/images/L.png';WebFXTreeConfig.lMinusIcon=resroot+'/images/Lminus.png';WebFXTreeConfig.lPlusIcon=resroot+'/images/Lplus.png';WebFXTreeConfig.tIcon=resroot+'/images/T.png';WebFXTreeConfig.tMinusIcon=resroot+'/images/Tminus.png';WebFXTreeConfig.tPlusIcon=resroot+'/images/Tplus.png';WebFXTreeConfig.blankIcon=resroot+'/images/blank.png';WebFXTreeConfig.defaultText='Tree Item';WebFXTreeConfig.defaultAction='javascript:void(0);';WebFXTreeConfig.defaultBehavior='classic';WebFXTreeConfig.usePersistence=true;WebFXTreeConfig.loadingText=\"loading...\";WebFXTreeConfig.loadErrorTextTemplate=\"load fail \\\"%1%\\\"\";WebFXTreeConfig.emptyErrorTextTemplate=\"Error \\\"%1%\\\" NotFound TreeNode! \";WebFXTreeConfig.defaultCssUrl=resroot+'/css/xtree.css';WebFXTreeConfig.elementPrefix=\"webfx-\";js.dom.StyleSheet.addCssLink(WebFXTreeConfig.defaultCssUrl);})();",
 "com.eae.webfx.xtree.WebFXTreeHandler" : "(function(){_$package(\"com.eae.webfx.xtree\");var System=_$import(\"js.lang.System\");var Cookie=_$import(\"js.io.Cookie\");var $class=com.eae.webfx.xtree.WebFXTreeHandler=function(){return $WebFXTreeHandler.apply(this,arguments);};var WebFXTreeHandler=$class;$class.$extends(_JSVM_Namespace.kernel.Object);var $WebFXTreeHandler=function(){}\r\nWebFXTreeHandler.idCounter=0;WebFXTreeHandler.idPrefix=\"webfx-tree-object-\";WebFXTreeHandler.all={};WebFXTreeHandler.behavior=null;WebFXTreeHandler.selected=null;WebFXTreeHandler.onSelect=null;WebFXTreeHandler.getId=function(){return this.idPrefix+this.idCounter++;}\r\nWebFXTreeHandler.toggle=function(oItem){this.all[oItem.id.replace('-plus','')].toggle();}\r\nWebFXTreeHandler.select=function(oItem){this.all[oItem.id.replace('-icon','')].select();}\r\nWebFXTreeHandler.focus=function(oItem){this.all[oItem.id.replace('-anchor','')].focus();}\r\nWebFXTreeHandler.blur=function(oItem){this.all[oItem.id.replace('-anchor','')].blur();}\r\nWebFXTreeHandler.keydown=function(oItem,e){return this.all[oItem.id].keydown(e.keyCode);}\r\nWebFXTreeHandler.cookies=new js.io.Cookie();WebFXTreeHandler.insertHTMLBeforeEnd=function(oElement,sHTML){if(oElement.insertAdjacentHTML!=null){oElement.insertAdjacentHTML(\"BeforeEnd\",sHTML);return;}\r\nvar df;var r=oElement.ownerDocument.createRange();r.selectNodeContents(oElement);r.collapse(false);df=r.createContextualFragment(sHTML);oElement.appendChild(df);}\r\nWebFXTreeHandler.getObjectById=function(sId){return this.all[sId];}\r\nWebFXTreeHandler.check=function(e){var evt=e||event;var elm=System.isIeBrowser()?evt.srcElement:evt.currentTarget;var node=WebFXTreeHandler.getObjectById(elm.getAttribute(\"oid\"));var tree=node.getRootNode();var hdle=tree.onCheck;if(typeof(hdle)==\"function\"){if(hdle(node,tree)==false){if(System.isIeBrowser()){event.returnValue=false;}else{evt.preventDefault();}}}}})();",
 "com.eae.webfx.xtree.WebFXTreeItem" : "(function(){_$package(\"com.eae.webfx.xtree\");var StringBuffer=_$import(\"js.lang.StringBuffer\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var WebFXTreeAbstractNode=_$import(\"com.eae.webfx.xtree.WebFXTreeAbstractNode\");var $class=com.eae.webfx.xtree.WebFXTreeItem=function(){return $WebFXTreeItem.apply(this,arguments);};var WebFXTreeItem=$class;$class.$extends(WebFXTreeAbstractNode);var $WebFXTreeItem=function(sText,sAction,eParent,sIcon,sOpenIcon,sRadio,sCheckBox,sValue,sChecked){$class.$super.call(this,sText,sAction);this.radio=sRadio;this.checkbox=sCheckBox;this.value=sValue;this.checked=sChecked;if(WebFXTreeConfig.usePersistence){this.open=(WebFXTreeHandler.cookies.getValue(this.id.substr(18,this.id.length-18))=='1')?true:false;}else{this.open=false;}\r\nif(sIcon){this.icon=sIcon;}\r\nif(sOpenIcon){this.openIcon=sOpenIcon;}\r\nif(eParent){eParent.add(this);}}\r\nWebFXTreeItem.prototype.remove=function(){var iconSrc=document.getElementById(this.id+'-plus').src;var parentNode=this.parentNode;var prevSibling=this.getPreviousSibling(true);var nextSibling=this.getNextSibling(true);var folder=this.parentNode.folder;var last=((nextSibling)&&(nextSibling.parentNode)&&(nextSibling.parentNode.id==parentNode.id))?false:true;this.getPreviousSibling().focus();this._remove();if(parentNode.childNodes.length==0){document.getElementById(parentNode.id+'-cont').style.display='none';parentNode.doCollapse();parentNode.folder=false;parentNode.open=false;}\r\nif(!nextSibling||last){parentNode.indent(null,true,last,this._level,parentNode.childNodes.length);}\r\nif((prevSibling==parentNode)&&!(parentNode.childNodes.length)){prevSibling.folder=false;prevSibling.open=false;iconSrc=document.getElementById(prevSibling.id+'-plus').src;iconSrc=iconSrc.replace('minus','').replace('plus','');document.getElementById(prevSibling.id+'-plus').src=iconSrc;document.getElementById(prevSibling.id+'-icon').src=WebFXTreeConfig.fileIcon;}\r\nif(document.getElementById(prevSibling.id+'-plus')){if(parentNode==prevSibling.parentNode){iconSrc=iconSrc.replace('minus','').replace('plus','');document.getElementById(prevSibling.id+'-plus').src=iconSrc;}}}\r\nWebFXTreeItem.prototype._remove=function(){for(var i=this.childNodes.length-1;i>=0;i--){this.childNodes[i]._remove();}\r\nfor(var i=0;i<this.parentNode.childNodes.length;i++){if(this==this.parentNode.childNodes[i]){for(var j=i;j<this.parentNode.childNodes.length;j++){this.parentNode.childNodes[j]=this.parentNode.childNodes[j+1];}\r\nthis.parentNode.childNodes.length-=1;if(i+1==this.parentNode.childNodes.length){this.parentNode._last=true;}\r\nbreak;}}\r\nWebFXTreeHandler.all[this.id]=null;var tmp=document.getElementById(this.id);if(tmp){tmp.parentNode.removeChild(tmp);}\r\ntmp=document.getElementById(this.id+'-cont');if(tmp){tmp.parentNode.removeChild(tmp);}}\r\nWebFXTreeItem.prototype.expand=function(){this.doExpand();document.getElementById(this.id+'-plus').src=this.minusIcon;}\r\nWebFXTreeItem.prototype.collapse=function(b){if(!b){this.focus();}\r\nthis.doCollapse();document.getElementById(this.id+'-plus').src=this.plusIcon;}\r\nWebFXTreeItem.prototype.getFirst=function(){return this.childNodes[0];}\r\nWebFXTreeItem.prototype.getLast=function(){if(this.childNodes[this.childNodes.length-1].open){return this.childNodes[this.childNodes.length-1].getLast();}else{return this.childNodes[this.childNodes.length-1];}}\r\nWebFXTreeItem.prototype.getNextSibling=function(){for(var i=0;i<this.parentNode.childNodes.length;i++){if(this==this.parentNode.childNodes[i]){break;}}\r\nif(++i==this.parentNode.childNodes.length){return this.parentNode.getNextSibling();}else{return this.parentNode.childNodes[i];}}\r\nWebFXTreeItem.prototype.getPreviousSibling=function(b){for(var i=0;i<this.parentNode.childNodes.length;i++){if(this==this.parentNode.childNodes[i]){break;}}\r\nif(i==0){return this.parentNode;}else{if((this.parentNode.childNodes[--i].open)||(b&&this.parentNode.childNodes[i].folder)){return this.parentNode.childNodes[i].getLast();}else{return this.parentNode.childNodes[i];}}}\r\nWebFXTreeItem.prototype.keydown=function(key){if((key==39)&&(this.folder)){if(!this.open){this.expand();}else{this.getFirst().select();}\r\nreturn false;}else if(key==37){if(this.open){this.collapse();}else{this.parentNode.select();}\r\nreturn false;}else if(key==40){if(this.open){this.getFirst().select();}else{var sib=this.getNextSibling();if(sib){sib.select();}}\r\nreturn false;}else if(key==38){this.getPreviousSibling().select();return false;}\r\nreturn true;}\r\nWebFXTreeItem.prototype.toString=function(nItem,nItemCount){var foo=this.parentNode;var indent='';if(nItem+1==nItemCount){this.parentNode._last=true;}\r\nvar i=0;while(foo.parentNode){foo=foo.parentNode;indent=\"<img id=\\\"\"+this.id+\"-indent-\"+i+\"\\\" src=\\\"\"+((foo._last)?WebFXTreeConfig.blankIcon:WebFXTreeConfig.iIcon)+\"\\\">\"+indent;i++;}\r\nthis._level=i;if(this.childNodes.length){this.folder=1;}else{this.open=false;}\r\nif((this.folder)||(WebFXTreeHandler.behavior!='classic')){if(!this.icon){this.icon=WebFXTreeConfig.folderIcon;}\r\nif(!this.openIcon){this.openIcon=WebFXTreeConfig.openFolderIcon;}}else if(!this.icon){this.icon=WebFXTreeConfig.fileIcon;}\r\nvar label=this.text.replace(/</g,'&lt;').replace(/>/g,'&gt;');var sb=new StringBuffer();sb.append(\"<div id=\\\"\"+this.id+\"\\\" ondblclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.toggle(this);\\\" class=\\\"webfx-tree-item\\\" onkeydown=\\\"return com.eae.webfx.xtree.WebFXTreeHandler.keydown(this, event)\\\">\"+indent+\"<img id=\\\"\"+this.id+\"-plus\\\" src=\\\"\"+((this.folder)?((this.open)?((this.parentNode._last)?WebFXTreeConfig.lMinusIcon:WebFXTreeConfig.tMinusIcon):((this.parentNode._last)?WebFXTreeConfig.lPlusIcon:WebFXTreeConfig.tPlusIcon)):((this.parentNode._last)?WebFXTreeConfig.lIcon:WebFXTreeConfig.tIcon))+\"\\\" onclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.toggle(this);\\\">\"+\"<img id=\\\"\"+this.id+\"-icon\\\" class=\\\"webfx-tree-icon\\\" src=\\\"\"+((WebFXTreeHandler.behavior=='classic'&&this.open)?this.openIcon:this.icon)+\"\\\" onclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.select(this);\\\">\");var svalue=this.value;var selectedstr=\"\";if(svalue==null){svalue=this.text;}\r\nif(this.radio==\"Y\"||this.radion==\"y\"||this.radio==\"true\"){sb.append(\"<input type=\\\"Radio\\\" id=\\\"\"+this.id+\"-radio\\\" oid=\\\"\"+this.id+\"\\\" name=\\\"\"+WebFXTreeConfig.elementPrefix+\"selRadioObj\\\" value=\\\"\"+svalue+\"\\\" \");sb.append(\"onclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.check(arguments[0]);\\\" >\");}else if(this.checkbox==\"Y\"||this.checkbox==\"y\"||this.checkbox==\"true\"){if(this.checked==\"Y\"||this.checked==\"y\"||this.checked==\"true\"){selectedstr=\"checked\";}\r\nsb.append(\"<input type=\\\"Checkbox\\\" id=\\\"\"+this.id+\"-check\\\" oid=\\\"\"+this.id+\"\\\" name=\\\"\"+WebFXTreeConfig.elementPrefix+\"selCheckObj\\\" value=\\\"\"+svalue+\"\\\" \"+selectedstr+\" \");sb.append(\"onclick=\\\"com.eae.webfx.xtree.WebFXTreeHandler.check(arguments[0]);\\\" >\");}\r\nvar isScript=(this.action.indexOf(\"javascript:\")==0);var hrefstr=isScript?\"#\":this.action;var clickstr=isScript?(this.action.substring(11)+\";return false;\"):\"\";sb.append(\"<a href=\\\"\"+hrefstr+\"\\\" id=\\\"\"+this.id+\"-anchor\\\" oid=\\\"\"+this.id+\"\\\" onfocus=\\\"com.eae.webfx.xtree.WebFXTreeHandler.focus(this);\\\" onblur=\\\"com.eae.webfx.xtree.WebFXTreeHandler.blur(this);\\\"\"+(this.target?\" target=\\\"\"+this.target+\"\\\"\":\"\")+\" onclick=\\\"\"+clickstr+\"\\\"\"+\">\"+label+\"</a></div>\"+\"<div id=\\\"\"+this.id+\"-cont\\\" class=\\\"webfx-tree-container\\\" style=\\\"display: \"+((this.open)?'block':'none')+\";\\\">\");for(var i=0;i<this.childNodes.length;i++){sb.append(this.childNodes[i].toString(i,this.childNodes.length));}\r\nthis.plusIcon=((this.parentNode._last)?WebFXTreeConfig.lPlusIcon:WebFXTreeConfig.tPlusIcon);this.minusIcon=((this.parentNode._last)?WebFXTreeConfig.lMinusIcon:WebFXTreeConfig.tMinusIcon);sb.append(\"</div>\");return sb.toString();}\r\nWebFXTreeItem.prototype.isChecked=function(bChecked){var elm=document.getElementById(this.id+\"-radio\")||document.getElementById(this.id+\"-check\");return(elm!=null)?elm.checked:null;}\r\nWebFXTreeItem.prototype.check=function(bChecked){if(bChecked==null){bChecked=true;}\r\nvar elm=document.getElementById(this.id+\"-radio\")||document.getElementById(this.id+\"-check\");if(elm!=null){elm.checked=bChecked;}}})();",
 "com.eae.webfx.xtree.WebFXUtil" : "(function(){_$package(\"com.eae.webfx.xtree\");var BObject=_$import(\"js.lang.BObject\");var WebFXTreeConfig=_$import(\"com.eae.webfx.xtree.WebFXTreeConfig\");var WebFXTreeHandler=_$import(\"com.eae.webfx.xtree.WebFXTreeHandler\");var $class=com.eae.webfx.xtree.WebFXUtil=function(){return $WebFXUtil.apply(this,arguments);};var WebFXUtil=$class;$class.$extends(BObject);var $WebFXUtil=function(){}\r\nWebFXUtil.startLoadXmlTree=function(sSrc,jsNode){if(jsNode.loading||jsNode.loaded){return;}\r\njsNode.loading=true;var xmlHttp=Class.forName(\"js.net.XmlHttp\").create();xmlHttp.open(\"GET\",sSrc,true);xmlHttp.onreadystatechange=function(){if(xmlHttp.readyState==4){WebFXUtil.xmlFileLoaded(xmlHttp.responseXML,jsNode,sSrc);}};window.setTimeout(function(){xmlHttp.send(null);},10);}\r\nWebFXUtil.parseTemplateString=function(sTemplate){var args=arguments;var s=sTemplate;s=s.replace(/\\%\\%/g,\"%\");for(var i=1;i<args.length;i++)\r\ns=s.replace(new RegExp(\"\\%\"+i+\"\\%\",\"g\"),args[i])\r\nreturn s;}\r\nWebFXUtil.xmlFileLoaded=function(oXmlDoc,jsParentNode,sSrc){if(jsParentNode.loaded)\r\nreturn;var bIndent=false;var bAnyChildren=false;jsParentNode.loaded=true;jsParentNode.loading=false;if(oXmlDoc==null||oXmlDoc.documentElement==null){try{oXmlDoc=Class.forName(\"js.net.XmlDom\").create();oXmlDoc.load(sSrc);}catch(ex){oXmlDoc=null;}}\r\nif(oXmlDoc==null||oXmlDoc.documentElement==null){jsParentNode.errorText=WebFXUtil.parseTemplateString(WebFXTreeConfig.loadErrorTextTemplate,jsParentNode.src);}else{var root=oXmlDoc.documentElement;var cs=root.childNodes;var l=cs.length;for(var i=0;i<l;i++){if(cs[i].tagName==\"TreeNode\"){bAnyChildren=true;bIndent=true;jsParentNode.add(WebFXUtil.xmlTreeToJsTree(cs[i]),true);}}\r\nif(!bAnyChildren)\r\njsParentNode.errorText=WebFXUtil.parseTemplateString(WebFXTreeConfig.emptyErrorTextTemplate,jsParentNode.src);}\r\nif(jsParentNode._loadingItem!=null){jsParentNode._loadingItem.remove();bIndent=true;}\r\nif(bIndent){}\r\nif(jsParentNode.errorText!=\"\")\r\nwindow.status=jsParentNode.errorText;}\r\nWebFXUtil.xmlTreeToJsTree=function(oNode){var text=oNode.getAttribute(\"text\");var action=oNode.getAttribute(\"action\");var parent=null;var icon=oNode.getAttribute(\"icon\");var openIcon=oNode.getAttribute(\"openIcon\");var src=oNode.getAttribute(\"src\");var target=oNode.getAttribute(\"target\");var sRadio=oNode.getAttribute(\"radio\");var sCheckbox=oNode.getAttribute(\"checkbox\");var sValue=oNode.getAttribute(\"value\");var sChecked=oNode.getAttribute(\"checked\");var jsNode;if(src!=null&&src!=\"\"){jsNode=Class.forName(\"com.eae.webfx.xtree.WebFXLoadTreeItem\").newInstance(text,src,action,parent,icon,openIcon,sRadio,sCheckbox,sValue,sChecked);}else{jsNode=Class.forName(\"com.eae.webfx.xtree.WebFXTreeItem\").newInstance(text,action,parent,icon,openIcon,sRadio,sCheckbox,sValue,sChecked);}\r\nif(target!=\"\"){jsNode.target=target;}\r\nvar cs=oNode.childNodes;var l=cs.length;for(var i=0;i<l;i++){if(cs[i].tagName==\"TreeNode\")\r\njsNode.add(WebFXUtil.xmlTreeToJsTree(cs[i]),true);}\r\nreturn jsNode;}})();",
 "null" : null
};
});

