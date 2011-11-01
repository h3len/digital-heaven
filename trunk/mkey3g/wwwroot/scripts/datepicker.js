/*****************************************************
 * My97 DatePicker Ver 2.0
 * BLOG: http://blog.csdn.net/my97/
 * MAIL: smallcarrot@163.com
 ****************************************************/
var dpcfg = {};
dpcfg.skin = "default";		
dpcfg.dateFmt = "%Y-%M-%D";
dpcfg.showTime = false;	
dpcfg.highLineWeekDay = true;
dpcfg.aWeekStr = ["日","一","二","三","四","五","六"];
dpcfg.aMonStr = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一","十二"];
dpcfg.todayStr = "今天";
dpcfg.okStr = "确定";
dpcfg.timeStr = "时间";
dpcfg.dateErrStr = "请输入一个正确的日期格式!";	






var $d=null;
function WdatePicker(el,dateFmt,showTime,skin){
this.win=window;
this.top=window;
while(this.top.parent.document!=this.top.document&&this.top.parent.document.getElementsByTagName("frameset").length==0){this.top=this.top.parent;}
this.eCont=(typeof el=='string')?document.getElementById(el):el;
this.dateFmt=(dateFmt==undefined||dateFmt==null)?dpcfg.dateFmt:dateFmt;
this.showTime=(showTime!=dpcfg.showTime)?showTime:dpcfg.showTime;
this.skin=(skin==undefined)?dpcfg.skin:skin;
if(this.top.document.dateDiv){
$d=this.top.document.dateDiv;
if($d.errPos!=undefined&&$d.errPos!=null){
if(!($d.obj.eCont.value==''||$d.obj._isDate($d.obj.eCont.value))){
$d.errPos.focus();
return;
}
else{
$d.errPos=null;
}
}
if($d.obj.eCont==this.eCont){
this._setOkInput();
$d.ifr.style.display='block';
$d.style.display='block';
return;
}
}
this.cssPath='../css/datepicker.css';
this.highLineWeekDay=dpcfg.highLineWeekDay;
this.aWeekStr=dpcfg.aWeekStr;
this.aMonStr=dpcfg.aMonStr;
this.todayStr=dpcfg.todayStr;
this.okStr=dpcfg.okStr;
this.timeStr=dpcfg.timeStr;
this.dateErrStr=dpcfg.dateErrStr;
this.an();
this.l=new Date();
this.ab=this.l.getFullYear();
this.w=this.l.getMonth()+1;
this.aa=this.l.getDate();
this.ai=this.l.getHours();
this.af=this.l.getMinutes();
this.ak=this.l.getSeconds();
this.am(this.eCont.value,this.dateFmt);
if(this.top.document.dateDiv==undefined){
this.dd=this.top.document.createElement("DIV");
this.dd.style.cssText='position:absolute;z-index:197;width:180px;';
this.dd.obj=this;
this.dd.className="WdateDiv";
this.dd.innerHTML=this.ad();
var ap=this.top.document.createElement('iframe');
this.dd.ifr=ap;
var q=this.dd.getElementsByTagName('input');
this.dd.mInput=q[0];
this.dd.yInput=q[1];
var ac=this.dd.getElementsByTagName('div');
this.dd.mDiv=ac[2];
this.dd.yDiv=ac[4];
this.dd.dDiv=ac[5];
this.dd.tDiv=ac[6].firstChild;
this.e=function(){
var evt=$d.obj.top.event;
var k=(evt.which==undefined)?evt.keyCode:evt.which;
if(!((k>=48&&k<=57)||(k>=96&&k<=105)||k==8||k==46||k==37||k==39)){evt.returnValue=false;}
}
this.dd.mInput.attachEvent('onkeydown',this.e);
this.dd.yInput.attachEvent('onkeydown',this.e);
this.dd.yInput.onblur=function(){
if(parseInt(this.value)!=$d.obj.g){
$d.obj.redraw();
}
this.className='yminput';
}
this.dd.mInput.onblur=function(){
if(this.value>12){
this.value='12'
}
else if(this.value<1){
this.value='1'
}
else if(parseInt(this.value)!=$d.obj.c){
$d.obj.redraw();
}
this.className='yminput';
}
this.dd.mInput.onfocus=function(){this.className='yminputfocus';this.select();$d.obj._fillmonth();$d.mDiv.style.display='block';};
this.dd.yInput.onfocus=function(){this.className='yminputfocus';this.select();$d.yDiv.style.display='block';};
this.dd.hhInput=q[2];
this.dd.mmInput=q[4];
this.dd.ssInput=q[6];
this.dd.okInput=q[7];
this.dd.hhInput.onfocus=this.dd.mmInput.onfocus=this.dd.ssInput.onfocus=function(){this.select();$d.obj.currFocus=this;}
this.dd.hhInput.onblur=function(){
if(parseInt(this.value)>23){this.value='23'}
else if(parseInt(this.value)<0){this.value='0'}
}
this.dd.mmInput.onblur=this.dd.ssInput.onblur=function(){
if(parseInt(this.value)>59){this.value='59'}
else if(parseInt(this.value)<0){this.value='0'}
}
this.dd.hhInput.attachEvent('onkeydown',this.e);
this.dd.mmInput.attachEvent('onkeydown',this.e);
this.dd.ssInput.attachEvent('onkeydown',this.e);
var ao=this.dd.getElementsByTagName('button');
this.dd.upButton=ao[0];
this.dd.downButton=ao[1];
this.dd.upButton.onclick=function(){
if($d.obj.currFocus==undefined){
$d.obj.currFocus=$d.mmInput;
}
if(($d.obj.currFocus==$d.hhInput&&parseInt($d.obj.currFocus.value)<23)||($d.obj.currFocus!=$d.hhInput&&parseInt($d.obj.currFocus.value)<59)){
$d.obj.currFocus.value=parseInt($d.obj.currFocus.value)+1;
}
$d.obj.currFocus.focus();
}
this.dd.downButton.onclick=function(){
if($d.obj.currFocus==undefined){
$d.obj.currFocus=$d.mmInput;
}
if(parseInt($d.obj.currFocus.value)>0){
$d.obj.currFocus.value=parseInt($d.obj.currFocus.value)-1;
}
$d.obj.currFocus.focus();
}
this.top.document.body.insertAdjacentElement('afterBegin',this.dd);
this.top.document.body.insertAdjacentElement('beforeEnd',this.dd.ifr);
this.top.document.dateDiv=this.dd;
this.eCont.getValue=function(){if(this.value!='')return $d.obj._returnDateStr(null,null,null,null,null,null,'%Y-%M-%D %h:%m:%s');};
}
else{
this.dd=this.top.document.dateDiv;
this.dd.obj.win=this.win;
this.dd.obj.top=this.top;
this.dd.obj.eCont=this.eCont;
this.dd.obj.showTime=this.showTime;
this.dd.obj.dateFmt=this.dateFmt;
this.dd.style.display='';
this.dd.mInput.value=this.c;
this.dd.yInput.value=this.g;
this.dd.dDiv.innerHTML=this.p();
if(this.showTime){
this.dd.tDiv.style.display='block';
this.dd.hhInput.value=this.u;
this.dd.mmInput.value=this.o;
this.dd.ssInput.value=this.ae;
}
else{
this.dd.tDiv.style.display='none';
}
}
this.aj();
this._fillyear();
this._setOkInput();
var objxy=this.eCont.getBoundingClientRect();
var mm=$getAbsM(this.top);
var currWinSize=$getClientWidthHeight(this.top);
var ddTop=mm.topM+objxy.bottom;
var ddLeft=mm.leftM+objxy.left;
if((ddTop+parseInt(this.dd.offsetHeight)<(currWinSize.height))||(ddTop-this.eCont.offsetHeight<this.dd.offsetWidth*0.8))
{
this.dd.style.top=this.top.document.body.scrollTop+ddTop+1;
}
else{
this.dd.style.top=this.top.document.body.scrollTop+ddTop-parseInt(this.dd.offsetHeight)-this.eCont.offsetHeight-3;
}

this.dd.style.left=-1+this.top.document.body.scrollLeft+Math.min(ddLeft,currWinSize.width-parseInt(this.dd.offsetWidth)-5);
this.dd.ifr.style.cssText='top:'+this.dd.style.top+';left:'+(this.dd.style.left)+';width:'+Math.min(180,(this.dd.offsetWidth-1))+';height:'+(this.dd.offsetHeight-1)+';position:absolute;z-index:196;overflow:hidden;border:0px;filter:alpha(opacity=0);';
}
WdatePicker.prototype.ah=function(){
var path='';
var scripts=document.getElementsByTagName("script");
for(var i=0;i<scripts.length;i++){
if(scripts[i].src.substring(scripts[i].src.length-14).toLowerCase()=='wdatepicker.js'){
path=scripts[i].src.substring(0,scripts[i].src.length-14);
break;
}
}
if(path.indexOf('://')==-1){
var a=this.top.location.href.toLowerCase();
var b=location.href.toLowerCase();
var al=bl=bls='';
var i,j,s='';
for(i=0;i<Math.max(a.length,b.length);i++){
if(a.charAt(i)!=b.charAt(i)){
j=i;
while(a.charAt(j)!='/'){if(j==0){break;}j-=1;}
al=a.substring(j+1,a.length);
al=al.substring(0,al.indexOf('/'));
bl=b.substring(j+1,b.length);
bl=bl.substring(0,bl.indexOf('/'));
break;
}
}
if(al!=''){for(i=0;i<al.split('/').length;i++){s+="../";}}
if(bl!=''){
bls=bl.split('/');
for(i=0;i<bls.length;i++){s+=bls[i]+'/';}
}
path=s+path;
}
this.cssPath=path+this.skin.toLowerCase()+'/datepicker.css';
}
WdatePicker.prototype.an=function()
{
if(!$d||($d&&$d.obj.skin!=this.skin)){
if($d){$d.obj.skin=this.skin;}
this.ah();
var needAddNew=true;
for(var i=this.top.document.styleSheets.length-1;i>=0;i--){
tempStyle=this.top.document.styleSheets[i];
if(tempStyle.href.substring(tempStyle.href.lastIndexOf('/')+1).toLowerCase()=='datepicker.css'){
if(tempStyle.href.toLowerCase()==this.cssPath.toLowerCase()){
needAddNew=false;
tempStyle.disabled=false;
continue;
}
else{
tempStyle.disabled=true;
}
}
}
if(needAddNew){
this.top.document.createStyleSheet(this.cssPath);
}
}
}
WdatePicker.prototype.am=function(str,fmt)
{
this.g=this.c=this.date=this.u=this.o=this.ae=-1;

var v=str.split(/\W+/);
var f=fmt.match(/%./g);

for(var i=0;i<f.length;i++){
if(v[i]){
if(f[i].toLowerCase()=='%y'){
this.g=parseInt(v[i],10);
if(isNaN(this.g)){this.g=this.ab;}
}
else if(f[i]=='%M'){
this.c=parseInt(v[i],10);
if(isNaN(this.c)){this.c=this.w;}
}
else if(f[i].toLowerCase()=='%d'){
this.date=parseInt(v[i],10);
if(isNaN(this.date)){this.date=this.aa;}
}
else if(f[i].toLowerCase()=='%h'){
this.u=parseInt(v[i],10);
if(isNaN(this.u)){this.u=this.ai;}
}
else if(f[i]=='%m'){
this.o=parseInt(v[i],10);
if(isNaN(this.o)){this.o=this.af;}
}
else if(f[i].toLowerCase()=='%s'){
this.ae=parseInt(v[i],10);
if(isNaN(this.ae)){this.ae=this.ak;}
}
}
}

if(!this._isDate(this.g+'-'+this.c+'-'+this.date)){
this.g=this.ab;this.c=this.w;this.date=this.aa;
}

if((this.u<0)||(this.u>23)){this.u=this.ai;}
if((this.o<0)||(this.o>59)){this.o=this.af;}
if((this.ae<0)||(this.ae>59)){this.ae=this.ak;}
}
WdatePicker.prototype._fillmonth=function()
{
var s=new Array(15);
s[0]="<table cellspacing=0 cellpadding=2 border=0>";
var i,n=0,v=parseInt(this.dd.mInput.value);
var aMonStrT=new Array(12);
var aMonStrV=new Array(12);
for(i=0;i<11;i++){
if(i+1==v){n=1;}
aMonStrT[i]=this.aMonStr[n+i];
aMonStrV[i]=n+i+1;
}
for(i=0;i<6;i++){
s[2*i+1]="<tr><td onmouseover=\"this.className='WdayOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.mInput.value='"+aMonStrV[i]+"';$d.mDiv.style.display='none';$d.mInput.blur();\">"+aMonStrT[i]+"</td>";
if(i==5){break;};
s[2*i+2]="<td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.mInput.value='"+aMonStrV[i+6]+"';$d.mDiv.style.display='none';$d.mInput.blur();\">"+aMonStrT[i+6]+"</td></tr>";
}
s[13]="<td align=center onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.mDiv.style.display='none';\">×</td</tr>";
s[14]="</table>";
this.dd.mDiv.innerHTML=s.join('');
}
WdatePicker.prototype._fillyear=function(minV,maxV)
{
if(minV==null||maxV==null){

minV=this.g-5;maxV=this.g+4;
}
var i;
var a=new Array(maxV-minV);
for(i=minV;i<=maxV;i++){
a[i-minV]=i;
}
var n=(a.length/2);
var s=new Array(8);
s[0]="<table cellspacing=0 cellpadding=2 border=0>";
for(i=0;i<n;i++){
s[i+1]="<tr><td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.yInput.value='"+a[i]+"';$d.yDiv.style.display='none';$d.yInput.blur();\">"+a[i]+"</td><td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.yInput.value='"+a[i+n]+"';$d.yDiv.style.display='none';$d.yInput.blur();\">"+a[i+n]+"</td></tr>";
}
s[6]="</table>";
s[7]="<table cellspacing=0 cellpadding=3 border=0><tr><td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown='$d.obj._fillyear("+(minV-10)+","+(maxV-10)+")'>←</td><td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown=\"$d.yDiv.style.display='none';$d.yInput.blur();\">×</td><td onmouseover=\"this.className='WymOn'\" onmouseout=\"this.className='Wym'\" onmousedown='$d.obj._fillyear("+(minV+10)+","+(maxV+10)+")'>→</td></tr></table>";
this.dd.yDiv.innerHTML=s.join('');
}
WdatePicker.prototype._returnDateStr=function(Y,M,D,h,m,s,fmt)
{
if(Y==null||Y==undefined){Y=this.g;}
if(M==null||M==undefined){M=this.c;}
if(D==null||D==undefined){D=this.date;}
if(h==null||h==undefined){h=this.u;}
if(m==null||m==undefined){m=this.o;}
if(s==null||s==undefined){s=this.ae;}
if(fmt==null){fmt=this.dateFmt;}
var sDate=fmt.replace(/%[Yy]/,this.t(Y,4)).replace(/%[M]/,this.t(M,2)).replace(/%[Dd]/,this.t(D,2));
if(this.showTime){
sDate=sDate.replace(/%[Hh]/,this.t(h,2)).replace(/%[m]/,this.t(m,2)).replace(/%[Ss]/,this.t(s,2));
}
return sDate;
}
WdatePicker.prototype.t=function(str,len){
str=str+'';
for(var i=str.length;i<len;i++){
str='0'+str;
}
return str;
}
WdatePicker.prototype._isDate=function(sDate){
return sDate.match(/^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[0-9])|([1-2][0-3]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?$/);
}
WdatePicker.prototype._isDateTime=function(sDateTime){
var Y,M,D,h,m,s;
var v=sDateTime.split(/\W+/);
var f=this.dateFmt.match(/%./g);
for(var i=0;i<f.length;i++){
if(f[i].toLowerCase()=='%y'){
Y=Number(v[i]);
if(isNaN(Y)){return false;}
}
else if(f[i]=='%M'){
M=Number(v[i]);
if(isNaN(M)){return false;}
}
else if(f[i].toLowerCase()=='%d'){
D=Number(v[i]);
if(isNaN(D)){return false;}
}
else if(f[i].toLowerCase()=='%h'){
h=Number(v[i]);
if(isNaN(h)){return false;}
}
else if(f[i]=='%m'){
m=Number(v[i]);
if(isNaN(m)){return false;}
}
else if(f[i].toLowerCase()=='%s'){
s=Number(v[i]);
if(isNaN(s)){return false;}
}
}
return this._isDate(Y+'-'+M+'-'+((D==undefined)?'1':D))&&(h==undefined||(h>=0)&&(h<=23))&&(s==undefined||(m>=0)&&(h<=59))&&(s==undefined||(s>=0)&&(s<=59));
}
WdatePicker.prototype.ad=function()
{
var s=new Array(9);

s[0]="<div id=dpTitle>"

s[1]="<div style='float:left;margin:2px'><div class='ymsel'></div>月份<input class='yminput' style='width:50px;' maxlength=2 value="+this.c+"></div>";

s[2]="<div style='float:right;margin:2px'><div class='ymsel'></div>年份<input class='yminput' style='width:60px;' maxlength=4 value="+this.g+"></div></div>";
s[3]="<div>";
s[4]=this.p();;
s[5]="</div>";
s[6]="<div>";
s[7]=this.ag();;
s[8]="</div>";
return s.join('');
}
WdatePicker.prototype.ag=function(){
var s=new Array(8);
s[0]="<div id=dpTime style='"+((this.showTime)?'':'display:none;')+"float:left;margin-top:3px'><table cellspacing=0 cellpadding=0 border=0><tr><td rowspan=2><span id=dpTimeStr>"+this.timeStr+"</span>";
s[1]=" <input class=tB maxlength=2 value="+this.u+"><input value=':' class=tm readonly>";
s[2]="<input class=tE maxlength=2 value="+this.o+"><input value=':' class=tm readonly>";
s[3]="<input class=tE maxlength=2 value="+this.ae+"></td><td>";
s[4]="<button id=dpTimeUp></button></td></tr><tr><td><button id=dpTimeDown></button></td></tr></table></div>"
s[5]="<div style='float:right;margin-top:3px;text-align:right'>";
s[6]="<input id=dpOkInput type=button style='height:20px;width:90%'></input>";
s[7]="</div>";
return s.join('');
}
WdatePicker.prototype._setOkInput=function(){
var d=$d.obj;
if(d.eCont.value==""){
$d.okInput.onclick=function(){var d=$d.obj;d.pickDate(d.ab,d.w,d.aa,d.ai,d.af,d.ak);}
$d.okInput.value=d.todayStr+((d.showTime)?"":(" "+d.t(d.ab,4)+'-'+d.t(d.w,2)+'-'+d.t(d.aa,2)));
}
else{
$d.okInput.onclick=function(){$d.obj.pickDate();}
$d.okInput.value=d.okStr;
}
}
WdatePicker.prototype.p=function(){
var str,firstDay,firstDate,lastDay,lastDate;
var i,j,k;
firstDay=new Date(this.g,this.c-1,1).getDay();
firstDate=1-firstDay;
lastDay=new Date(this.g,this.c,0).getDay();
lastDate=new Date(this.g,this.c,0).getDate();
str="<table id=dpDayTable width=100% border=0 cellspacing=0 cellpadding=0>";
str+="<tr id=dpWeekTitle align=center>";
for(i=0;i<7;i++){str+="<td>"+this.aWeekStr[i]+"</td>";}
str+="</tr>";
var classStr='';
var chassOnStr='';
for(i=1,j=firstDate;i<7;i++){
str+="<tr>";
for(k=0;k<7;k++){
if(j>=1&&j<=lastDate){
classStr=((this.highLineWeekDay&&(k==0||k==6))?'Wwday':'Wday');
classOnStr=((this.highLineWeekDay&&(k==0||k==6))?'WwdayOn':'WdayOn');
str+="<td align=center class="+classStr+" onclick=\"$d.obj.pickDate(null,null,"+j+");\" ";
str+="onmouseover=\"this.className='"+classOnStr+"'\" ";
str+="onmouseout=\"this.className='"+classStr+"'\"><span";
if((this.g==this.ab)&&(this.c==this.w)&&(j==this.aa)){
str+=" style='font-weight:bold'";
}
str+=">"+j+"</span>";
}
else{
str+="<td><span></span>";
}
j++;
str+="</td>";
}
str+="</tr>";
}
str+="</table>";
return str;
}
WdatePicker.prototype.aj=function(){
this.top.$d=this.top.document.dateDiv;
$d=this.top.$d;
}
WdatePicker.prototype.redraw=function(){
this.g=this.dd.yInput.value;
this.c=this.dd.mInput.value;
this.dd.dDiv.innerHTML=this.p();
}
WdatePicker.prototype.pickDate=function(Y,M,D,h,m,s){
if(Y==null){Y=this.dd.yInput.value;}
if(M==null){M=this.dd.mInput.value;}
if(D==null){D=this.date;}
this.g=Y;this.c=M;this.date=D;
if(this.showTime){
if(h==null){h=this.dd.hhInput.value;}
if(m==null){m=this.dd.mmInput.value;}
if(s==null){s=this.dd.ssInput.value;}
this.u=h;this.o=m;this.ae=s;
this.eCont.value=this._returnDateStr(Y,M,D,h,m,s);
}
else{this.eCont.value=this._returnDateStr(Y,M,D);}

this.dd.style.display='none';
this.dd.ifr.style.display='none';
}
if(navigator.product=='Gecko')
{
Window.prototype.__defineGetter__("screenLeft",function(){
return this.screenX+(this.outerWidth-this.innerWidth);
});

Window.prototype.__defineGetter__("screenTop",function(){
return screenY+(window.outerHeight-window.innerHeight);
});
Document.prototype.attachEvent=function(sType,fHandler){
var shortTypeName=sType.replace(/on/,"");
fHandler._ieEmuEventHandler=function(e){
window.event=e;return fHandler();
}
this.addEventListener(shortTypeName,fHandler._ieEmuEventHandler,false);
}
Document.prototype.createStyleSheet=function(cssPath){
var head=document.getElementsByTagName('HEAD').item(0);
var style=document.createElement('link');
style.href=cssPath;
style.rel='stylesheet';
style.type='text/css';
head.appendChild(style);
}
Event.prototype.__defineSetter__("returnValue",function(value){
if(!value){this.preventDefault();}return value;});
Event.prototype.__defineGetter__("srcElement",function(){
var node=this.target;
while(node.nodeType!=1){node=node.parentNode;}
return node;
});
Node.prototype.replaceNode=function(Node){this.parentNode.replaceChild(Node,this);}
Node.prototype.removeNode=function(removeChildren){
if(removeChildren){
return this.parentNode.removeChild(this);}
else{
var range=document.createRange();
range.selectNodeContents(this);
return this.parentNode.replaceChild(range.extractContents(),this);
}
}
HTMLElement.prototype.__defineSetter__("outerHTML",function(sHTML){
var r=this.ownerDocument.createRange();
r.setStartBefore(this);
var df=r.createContextualFragment(sHTML);
this.parentNode.replaceChild(df,this);
return sHTML;
});
HTMLElement.prototype.__defineGetter__("outerHTML",function(){
var attr;
var attrs=this.attributes;
var str="<"+this.tagName;
for(var i=0;i<attrs.length;i++){
attr=attrs[i];
if(attr.specified)
str+=" "+attr.name+'="'+attr.value+'"';
}
if(!this.canHaveChildren)
return str+">";
return str+">"+this.innerHTML+"</"+this.tagName+">";
});
HTMLElement.prototype.__defineGetter__("parentElement",function(){
if(this.parentNode==this.ownerDocument)return null;
return this.parentNode;
});
HTMLElement.prototype.attachEvent=function(sType,fHandler)
{
var shortTypeName=sType.replace(/on/,"");
fHandler._ieEmuEventHandler=function(e){
window.event=e;return fHandler();
}
this.addEventListener(shortTypeName,fHandler._ieEmuEventHandler,false);
}

HTMLElement.prototype.insertAdjacentElement=function(where,parsedNode){
switch(where){
case "beforeBegin":
this.parentNode.insertBefore(parsedNode,this);
break;
case "afterBegin":
this.insertBefore(parsedNode,this.firstChild);
break;
case "beforeEnd":
this.appendChild(parsedNode);
break;
case "afterEnd":
if(this.nextSibling)
this.parentNode.insertBefore(parsedNode,this.nextSibling);
else 
this.parentNode.appendChild(parsedNode);
break;
}
}
HTMLElement.prototype.getBoundingClientRect=function(){
var obj=this;
var top=obj.offsetTop;
var left=obj.offsetLeft;
var right=obj.offsetWidth;
var bottom=obj.offsetHeight;
while(obj=obj.offsetParent){
if(obj.style.position=='absolute'||obj.style.position=='relative'||(obj.style.overflow!='visible'&&obj.style.overflow!='')){
break;
}
top+=obj.offsetTop;
left+=obj.offsetLeft;
}
left-=document.body.scrollLeft;
top-=document.body.scrollTop;
right+=left;
bottom+=top;
return{'left':left,'top':top,'right':right,'bottom':bottom};
}
HTMLIFrameElement.prototype.__defineGetter__("Document",function(){return this.contentDocument});
}
function $getClientWidthHeight(win){
var cw=win.document.body.clientWidth;
var ch=win.document.body.clientHeight;
return{'width':cw,'height':ch};
}
function $getAbsM(topWin)
{
if(topWin==null){topWin=top;}
var leftM=0;var topM=0;
var z=window;
while(z!=topWin){
var ifs=z.parent.document.getElementsByTagName('iframe');
for(var i=0;i<ifs.length;i++){
try{
if(ifs[i].Document==z.document){
var rc=ifs[i].getBoundingClientRect();
leftM+=rc.left;
topM+=rc.top;
break;
}
}
catch(e){continue;}
}
z=z.parent;
}
return{'leftM':leftM,'topM':topM};
}
function disposeDatePicker(){
if($d!=undefined&&$d.obj!=undefined&&$d.obj.eCont!=window.event.srcElement){
var x=event.clientX;
var y=event.clientY;
var rc=$d.getBoundingClientRect();
if(x<rc.left||x>rc.right||y<rc.top||y>rc.bottom){
if($d.obj.eCont.value==''||$d.obj._isDateTime($d.obj.eCont.value)){
$d.errPos=null;
$d.yDiv.style.display=$d.mDiv.style.display='none';
$d.ifr.style.display='none';
$d.style.display='none';
}
else{
$d.errPos=$d.obj.eCont;
alert($d.obj.dateErrStr);
}
}
else{
$d.yDiv.style.display=$d.mDiv.style.display='none';}
}
}
document.attachEvent('onmousedown',disposeDatePicker);

