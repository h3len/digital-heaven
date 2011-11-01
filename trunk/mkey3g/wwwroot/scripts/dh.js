/*--------------------------------------------------------------------------*/

/* dh.js 

/* version 1.0
/* author yesun 

/* date 2008-1-31

/* comment 常用javascript类库

/*--------------------------------------------------------------------------*/
	//就是个可以自定义宽度的弹出框啦
	function SDHalert(content,width)
	{
		Ext.Msg.show({title:nowtitle,msg:content,width:width,buttons:Ext.MessageBox.OK});
	}
	//测试字符串是否是IP地址
	//如下格式也会不通过检测 192.002.02.2 包括0将不通过检查
	//第一段及最后一段将不能包含0
	function isIp(str)
	{
		var patten = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
		if(!patten.test(str))
		{
			return false;
		}
		
		var iparr = str.split('.');
		if(iparr.length != 4)
		{
			return false;
		}
		//判断IP不能以0开头或结尾
		if(iparr[0].indexOf('0') == 0 || iparr[3].indexOf('0') == 0)
		{
			return false;
		}
		for(i = 0;i < iparr.length ;i ++)
		{
			if(iparr[i].length > 1)
			{
				if(iparr[i].indexOf('0') == 0)
				{
					return false;
				}
			}
		}
		return true;
	}
	

//封装进度条
function Progress(msg, title)
{
		if(title == null)
			title = nowtitle;
		if(msg == null)
			msg = "正在载入...";
		Ext.MessageBox.show({
           title: nowtitle,
           msg: msg,
           progressText: msg,
           width:260,
		   //buttons: Ext.MessageBox.OK,
           icon:'ext-mb-Loading_Blue', //custom class in msg-box.html
           progress:false,
           closable:true,
           animEl: 'mb6'
       });
}
//关闭进度 
function CloseProgress(){
	Ext.MessageBox.hide();
}


 
   /*
   功能：封装Ext提示框（alert）
   ----------------------------------------------------------*/
  function DHalert(msg){
  	Ext.Msg.alert(nowtitle,msg);
  }
  
 
   /*
   功能：选项卡(数组个数为选项卡的个数)
   参数依次是：tpnum为一个二维数组tpnum[0][0]:选项卡调用js方法名
   							 tpnum[0][1]:选项卡title
   			twidth:选项卡的宽度
   			scTab:显示第几个选项卡
				tabdiv:内容显示div的id
   ----------------------------------------------------------*/
  function DHTabPanel(tpnum,twidth,scTab,tabdiv){
  
   var len=tpnum.length;
   var itemsvalue="";
   var i=0;
  	// basic tabs 1, built from existing content
    var tabs = new Ext.TabPanel({
    	activeTab: scTab, 
        renderTo: tabdiv,
        //width:twidth,
        autoWidth:true,
        frame:true,
      	height:10
    });
   for(i=0;i<len;i++){
  	 addTab(tpnum[i][1],tpnum[i][0],i);  
   }

   	function addTab(pTitle,onactivefun,i){
        tabs.add({
            title: pTitle,
            iconCls: 'tabs',
            listeners: {activate:onactivefun},
            id:i,
            closable:false
        });
    }
	tabs.setActiveTab(scTab);
	tabs.show();
  }
  
  /*
   功能：常用方法
  ----------------------------------------------------------*/
  
    
  /*
    简单数据校验
    调用示例：
    var cf = new CheckForm();
    var isValidate = cf.IsEmail(email);
    ---------------------------------------------------------*/
 function CheckForm()
 {
	//定义
	this.Trim = Trim;
	this.TrimAll = TrimAll;
	this.SafeInput = SafeInput;
	this.SafeXML = SafeXML;
	this.SafeXMLSBCcase = SafeXMLSBCcase;
	this.SafeURL = SafeURL;
	this.SafeAll = SafeAll;
	this.HTMLEncode = HTMLEncode;	
	this.IsTel = IsTel;
	this.IsIdno = IsIdno;
	this.IsNumber = IsNumber;
	this.getBirthdayFromIdno = getBirthdayFromIdno;
	this.IsDate = IsDate;
	this.checkObjIsNumber = checkObjIsNumber;
	this.GetRadioValue = GetRadioValue;
	this.checkForm = checkForm;
	this.IsEmail = IsEmail;
	this.IPChk = IPChk;	
	
	//是否为电子邮件
	function IsEmail(s)
	{
		var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(reg.test(s))
			return true;
		else
			return false;
	}
	
	//验证电话号码，只允许数字和“-”
	function IsTel(s)
	{
		var reg = /^(\+)?(86)?(\d){6,20}$/;
		if(reg.test(s))
			return true;
		else
			return false;
	}
	


		//判断ip地址是否合法
		function IPChk(IPStr)
	{
		var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	    var reg = IPStr.match(exp);
	    if(reg==null)
	    {
	        return false;
	    }
	    else
	    {
	        return true;
	    }
	}

	
	//去除首尾空格
	function Trim(s) {return s.replace(/(^\s+)|(\s+$)/g, "");}
	//去除全部空格	
	function TrimAll(s) {return s.replace(/\s+/g, "");}
	//去除“'”	
	function SafeInput(s) {
	return Trim(s.replace(/('+)/g,'’'));}	
	//转换非法字符for Xml
	function SafeXML(s) {
		s = s.replace(/(&+)/g,'&amp;');
		s = s.replace(/(>+)/g,'&gt;');
		s = s.replace(/(<+)/g,'&lt;');
		s = s.replace(/("+)/g,'&quot;');
		s = s.replace(/('+)/g,'&apos;');
		return s;
	}
	//转换非法字符for Xml
	function SafeXMLSBCcase(s) {
		s = s.replace(/(>+)/g,'＞');
		s = s.replace(/(<+)/g,'＜');
		s = s.replace(/("+)/g,'＂');
		s = s.replace(/('+)/g,'＇');
		s = s.replace(/(&+)/g,'＆');
		return s;
	}
	//Html Encode
	function HTMLEncode(s) {
		s = s.replace(/(\s+)/g,'&nbsp;');
		s = s.replace(/(\n+)/g,'<br/>');
		return s;
	}	
	//去除“&”
	function SafeURL(s) {
		return Trim(s.replace(/(&+)/g,''));
	}
	//去除所有不安全字符
	function SafeAll(s) {
		s = s.replace(/(&+)/g,'');
		s = s.replace(/(>+)/g,'');
		s = s.replace(/(<+)/g,'');
		s = s.replace(/("+)/g,'');
		s = s.replace(/('+)/g,'');
	//return SafeXML(SafeURL(s));
	return s;
	}
	
	//验证身份证号码
	function IsIdno(s){
		if (s==""){	return confirm("没有填写身份证号，这样将无法判定其生日！\n确定继续吗？");}
		if (s.length != 15 & s.length != 18){
			DHalert("","请填入正确的身份证号码");
			return false;
		}
		if (!IsNumber(s.substring(0,17))){
			DHalert("","请填入正确的身份证号码");
			return false;
			
	    	}
		if (!IsNumber(s.substring(16,17)) & s.substring(16,17) != "x" & s.substring(16,17) != "X"){
			DHalert("","请填入正确的身份证号码");
			return false;
		}
		return true;
	}
	//含有非数字字符 返回 true
	function IsNumber(s){ //适于校验非负整数
	   var reg = /^[01233456789]{1,}$/;
		if(reg.test(s))
			return true;
		else
			return false;
	}
	
	//从身份证号里面得到日期
	function getBirthdayFromIdno(IDno){
		var sBirthday;
		if(IDno.length==15){
			sBirthday = "19" + IDno.substring(6,8);
			sBirthday = sBirthday + "-" + IDno.substring(8,10);
			sBirthday = sBirthday + "-" + IDno.substring(10,12);
		}
		if(IDno.length==18){
			sBirthday = IDno.substring(6,10);
			sBirthday = sBirthday + "-" + IDno.substring(10,12);
			sBirthday = sBirthday + "-" + IDno.substring(12,14);
		}
		return sBirthday;
	}
	

	
	//判断日期是否合法
	//参数g_dateVal格式："1980-01-01"
	function IsDate(g_dateVal){ 
		//var s = g_dateVal.replace(/-/g,"/");
		var reg = /[\d]{4}[-][\d]{2}[-][\d]{2}/; 
		return reg.test(g_dateVal)
	} 
	//判断是否位数字
	function checkObjIsNumber(objtxt,izero){
		var chname;
		if (typeof(objtxt.chname)=="undefined"){
			chname = "对象";
		}
		else{
			chname = Trim(objtxt.chname)
			if (chname==""){chname = "对象";}
		}
		
		objtxt.value=Trim(objtxt.value);
		if (isNaN(parseFloat(objtxt.value))){
			DHalert("",chname + "不是有效数字！");
			objtxt.focus();return false;
		}
		objtxt.value=parseFloat(objtxt.value)
		if (izero>0){
			if(!(parseFloat(objtxt.value)>0)){
				DHalert("",chname + "需大于零！");
				objtxt.focus();return false;
			}
		}
		else if (izero>=0){
			if(!(parseFloat(objtxt.value)>=0)){
				DHalert("",chname + "需大于等于零！");
				objtxt.focus();return false;
			}
		}
		return true;
	}

	
	/*----------------------------------------------------------
        功能：验证某个form或者div里面的控件是否合法 , 下面的控件只允许在IE下运行
    -----------------------------------------------------------*/
	function checkForm(formname){
		/*
		formname要求格式为"form"+业务英文名称
		txt格式为:name格式为"txt"+输入域英文名称 ; chname格式为输入域中文名称
		*/
		if( formname == null || formname == "" || typeof(formname) == "undefined" )
		{
			DHalert("","对不起,formname参数错误");
			return;
		}
		var _progressBar = new ProgressBar();
		with (formname){
			var elements = Form.getElements(formname);
			var len = elements.length;
			for(var i=0; i<len; i++){
				if (elements[i].type=="text"||elements[i].type=="password"||elements[i].tagName=="textarea"){
					elements[i].value=Trim(elements[i].value);

					//不能为空
		            DHalert("",elements[i].value);
		            DHalert("",elements[i].notempty);
					if ((elements[i].value=="")&&(elements[i].notempty=="true")){
						_progressBar.isNeedConfirmButton = true;
					    _progressBar.focusItem = elements[i].id;
					    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起,请填写" + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "！");
					    return false;
					}
					//电话
					if( elements[i].notempty=="true" )
					{
						//不能为空，并且判断tel
						if ((elements[i].istel=="true") && !IsTel(elements[i].value) ){
							_progressBar.isNeedConfirmButton = true;
						    _progressBar.focusItem = elements[i].id;
						    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "格式不正确！");
						    return false;
						}
					}
					else
					{
						//可以为空，但是如果有内容就需要判断
						if (elements[i].value!="" && (elements[i].istel=="true") && !IsTel(elements[i].value) ){
							_progressBar.isNeedConfirmButton = true;
						    _progressBar.focusItem = elements[i].id;
						    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "格式不正确！");
						    return false;
						}
					}
					//邮件
					if( elements[i].notempty=="true" )
					{
						//不能为空，并且判断email
						if ((elements[i].isemail=="true") && !IsEmail(elements[i].value)){
						_progressBar.isNeedConfirmButton = true;
					    _progressBar.focusItem = elements[i].id;
					    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "格式不正确！");
					    return false;
						}
					}
					else
					{
						//可以为空，但是如果有内容就需要判断
						if (elements[i].value != "" && (elements[i].isemail=="true") && !IsEmail(elements[i].value)){
						_progressBar.isNeedConfirmButton = true;
					    _progressBar.focusItem = elements[i].id;
					    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "格式不正确！");
					    return false;
						}
					}					
					//数字
					if( elements[i].notempty=="true" )
					{
						if ((elements[i].isnumber=="true") && !IsNumber(elements[i].value)){
							_progressBar.isNeedConfirmButton = true;
						    _progressBar.focusItem = elements[i].id;
						    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "必须为数字！");
						    return false;
						}
					}
					else
					{
						if (elements[i].value != "" && (elements[i].isnumber=="true") && !IsNumber(elements[i].value)){
							_progressBar.isNeedConfirmButton = true;
						    _progressBar.focusItem = elements[i].id;
						    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起," + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "必须为数字！");
						    return false;
						}
					}
				}
				else if (elements[i].tagName=="SELECT"){
					if(elements[i].value==""){
						//alert("请选择" + elements[i].chname + "！");
						_progressBar.isNeedConfirmButton = true;
					    _progressBar.focusItem = elements[i].id;
					    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起，请选择" + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "！");
					    return false;
					}
				}
				else if (elements[i].tagName=="INPUT"&&elements[i].type=="radio"){
					//radio需默认有选择
					if(elements[i].notempty == "true")
					{
						var radios = document.getElementsByName(elements[i].name);					
						var radioValue = "";
						for(var j=0 ;j<radios.length;j++)
						{
							if(radios[j].checked)
							{
								radioValue = radios[j].value;
							}
						}
						if(radioValue == "")
						{
							_progressBar.isNeedConfirmButton = true;
						    _progressBar.focusItem = elements[i].id;
						    _progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 对不起，请选择" + (typeof(elements[i].chname)=="undefined"?"该对象":elements[i].chname) + "！");
						    return false;
						}
					}
				}				
			}
		}		
		_progressBar.Close();
		return true;
	}
}


/*----------------------------------------------------------
    功能：取得Radio的值
-----------------------------------------------------------*/
function GetRadioValue(radioname)
{
    var radiolist = document.getElementsByName(radioname);
    for(var i = 0;i < radiolist.length;i++)
    {
        if( radiolist.item(i).checked == true )
            return radiolist.item(i).value;
    }
}

/*----------------------------------------------------------
    功能：设置Radio的默认值
-----------------------------------------------------------*/
function SetRadioValue(radioname,radiovalue)
{
    var radiolist = document.getElementsByName(radioname);
    for(var i = 0;i < radiolist.length;i++)
    {
        if(radiolist.item(i).value == radiovalue)
            radiolist.item(i).checked = true;
    }
}


/*
    Extend StringBuffer
    调用示例：
    var sb = new StringBuffer();
    sb.append("abcd");
    sb.toString();
    --------------------------------------------------*/
function StringBuffer(string) {
    this.buffer = [];
    this.append(string);
}
StringBuffer.prototype.append = function (string) {
    if (string) {
        //this.buffer.push(string); //用下面的兼容性好些，速度也快一点(IE6下测试的)
        this.buffer[this.buffer.length] = string;
    }
    return this;
};
StringBuffer.prototype.toString = function (separator) {
    return this.buffer.join(separator || "");
};




/*
    扩展firefox对selectSingleNode,selectNodes的支持
    示例代码：
    objXml.selectNodes("/users");//支持firefox下调用
-------------------------------------------------------------------------*/
var  isIE  =   !! document.all;
      if ( ! isIE){
     var  ex;
    XMLDocument.prototype.__proto__.__defineGetter__( " xml " ,  function (){
         try {
             return   new  XMLSerializer().serializeToString( this );
        } catch (ex){
             var  d  =  document.createElement( " div " );
            d.appendChild( this .cloneNode( true ));
             return  d.innerHTML;
        }
    });
    Element.prototype.__proto__.__defineGetter__( " xml " ,  function (){
         try {
             return   new  XMLSerializer().serializeToString( this );
        } catch (ex){
             var  d  =  document.createElement( " div " );
            d.appendChild( this .cloneNode( true ));
             return  d.innerHTML;
        }
    });
    XMLDocument.prototype.__proto__.__defineGetter__( " text " ,  function (){
         return   this .firstChild.textContent
    });
    Element.prototype.__proto__.__defineGetter__( " text " ,  function (){
         return   this .textContent
    });

    XMLDocument.prototype.selectSingleNode = Element.prototype.selectSingleNode = function (xpath){
         var  x = this .selectNodes(xpath)
         if ( ! x  ||  x.length < 1 ) return   null ;
         return  x[ 0 ];
    }
    XMLDocument.prototype.selectNodes = Element.prototype.selectNodes = function (xpath){
         var  xpe  =   new  XPathEvaluator();
         var  nsResolver  =  xpe.createNSResolver( this .ownerDocument  ==   null   ? 
             this .documentElement :  this .ownerDocument.documentElement);
         var  result  =  xpe.evaluate(xpath,  this , nsResolver,  0 ,  null );
         var  found  =  [];
         var  res;
         while  (res  =  result.iterateNext())
            found.push(res);
         return  found;
    }
}

/*
    加入收藏
    ------------------------------------------------------------*/
function addBookmark(title,url) {
    if (window.sidebar) {   
        window.sidebar.addPanel(title, url,"");   
    } else if( document.all ) {  
        window.external.AddFavorite( url, title);  
    } else if( window.opera && window.print ) {  
        return true;  
    }  
}





/*  
 * 设置状态栏
 * add by zzc
/*--------------------------------------------------------------------------*/
function setStatusBarText(text)
{
	window.status = text;
}


/* input特效 add by Gaojingliang */

function $( id ){return document.getElementById( id );}


function inputEvent(){
var obj = document.getElementsByTagName('input');
	for(var i=0;i<obj.length;i++){
		
		if(obj[i].type == 'text' || obj[i].type == 'password'){
		
		obj[i].onfocus=function(){
			fEvent('focus',this);
		};
		obj[i].onblur=function(){
			fEvent('blur',this);
		};
		obj[i].onmouseover=function(){
			fEvent('mouseover',this);
		};
		obj[i].onmouseout=function(){
			fEvent('mouseout',this);
		}
		//alert(obj[i].onMouseOver)
		}
	}
}

	

	
	
	function fEvent(sType,oInput){
	
		switch (sType){
			case "focus" :
				oInput.isfocus = true;
			case "mouseover" :
				oInput.style.borderColor = '#9ecc00';
				oInput.style.backgroundColor = '#FFF7D7';
				break;
			case "blur" :
				oInput.isfocus = false;
			case "mouseout" :
				if(!oInput.isfocus){
					oInput.style.borderColor='#484848';
				oInput.style.backgroundColor = '#FFFFFF';
				}
				break;
		}
	} 

/* 全选 add by Gaojingliang */

/* checkbox显示隐藏div add by Gaojingliang */
function show_checkbox_div(id){
	if(document.getElementById('checkbox'+id).checked==true){
		document.getElementById('checkbox_div'+id).style.display="";
	}
	else if(document.getElementById('checkbox'+id).checked!=true){
		document.getElementById('checkbox_div'+id).style.display="none";
	}
}

/* 显示简单信息 add by Gaojingliang */
var Hide=null; 
function ShowHideThing(HideThing){ 
  var obj = document.getElementById(HideThing); 
  if (Hide!=null&&Hide!=obj) 
    Hide.style.display='none'; 
  Hide=obj; 
  if (obj.style.display=='none'){ 
    obj.style.display=''; 
  }else{ 
    obj.style.display='none'; 
  } 
} 

/* Graybox add by Gaojingliang */
function closebox(){
	parent.parent.GB_CURRENT.hide();
	parent.parent.location.reload();
}


/* PNG图象透明 add by Gaojingliang */
function correctPNG() 
{
for(var i=0; i<document.images.length; i++)
{
var img = document.images[i]
var imgName = img.src.toUpperCase()
if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
{
var imgID = (img.id) ? "id='" + img.id + "' " : ""
var imgClass = (img.className) ? "class='" + img.className + "' " : ""
var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
var imgStyle = "display:inline-block;" + img.style.cssText 
if (img.align == "left") imgStyle = "float:left;" + imgStyle
if (img.align == "right") imgStyle = "float:right;" + imgStyle
if(img.parentElement!=undefined){
if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle 
}
var strNewHTML = "<span " + imgID + imgClass + imgTitle
+ " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
+ "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
img.outerHTML = strNewHTML
i = i-1
}
}
}
if (document.all){
 window.attachEvent('onload',correctPNG)//IE中
}
else{
 window.addEventListener('load',correctPNG,false);//firefox
}



//这个是ext的回掉，alert后回掉返回
function failmethod(){
	return ;
}
/*****************************************
为String对象添加Trim()方法
*******************************************/
String.prototype.Trim = function() 
{ 
    return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 
/*********************************
	新建文件夹时检验是否存在非法字符
*********************************/
function CheckFolderName(foldername){
	if(foldername.lastIndexOf("\\")>-1||foldername.lastIndexOf("/")>-1||foldername.lastIndexOf(":")>-1){
		DHalert("","文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
		return false;
	}
	if(foldername.lastIndexOf("*")>-1||foldername.lastIndexOf("?")>-1||foldername.lastIndexOf("\"")>-1){
		DHalert("","文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
		return false;
	}
	if(foldername.lastIndexOf("<")>-1||foldername.lastIndexOf(">")>-1||foldername.lastIndexOf("|")>-1){
		DHalert("","文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
		return false;
	}
	return true;
}	
/****************************************
	替换特殊字符－－用于检验文件夹名称
****************************************/
function rp(str){
	str=str.Trim();
	str=str.replace(/\%/g,"%25");
	str=str.replace(/\+/g,"%2B");
	str=str.replace(/\&/g,"%26");
	str=str.replace(/\./g,"");	
	return str;
}
/****************************************
	替换特殊字符－－用于检验文件名称
****************************************/
function rpf(str){
	str=str.Trim();
	str=str.replace(/\%/g,"%25");
	str=str.replace(/\+/g,"%2B");
	str=str.replace(/\&/g,"%26");
	return str;
}

/*  Ext JS Library 1.1 定义类似于office的二级菜单 by Gaojingliang   */


/*开始： cookies*/
function ResetCookie()
{
  SetCookie("admin_username", "", null, "/");
  SetCookie("admin_password", "", null, "/");  
}

function ResetUserCookie()
{
	SetCookie("user_username", "", null, "/");
  	SetCookie("user_password", "", null, "/");
}


function getCookieVal (offset)
{
  var endstr = document.cookie.indexOf (";", offset);
  if (endstr == -1)
  endstr = document.cookie.length;
  return unescape(document.cookie.substring(offset, endstr));
}


function GetCookie (name)
{
  var arg = name + "=";
  var alen = arg.length;
  var clen = document.cookie.length;
  var i = 0;
  while (i < clen) {
    var j = i + alen;
    if (document.cookie.substring(i, j) == arg)
    return getCookieVal (j);
    i = document.cookie.indexOf(" ", i) + 1;
    if (i == 0) break;
  }
  return null;
}

function SetCookie (name, value)
{
  var argv = SetCookie.arguments;
  var argc = SetCookie.arguments.length;
  var expires = (argc > 2) ? argv[2] : null;
  var path = (argc > 3) ? argv[3] : null;
  var domain = (argc > 4) ? argv[4] : null;
  var secure = (argc > 5) ? argv[5] : false;
  document.cookie = name + "=" + escape (value) +
  ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
  ((path == null) ? "" : ("; path=" + path)) +
  ((domain == null) ? "" : ("; domain=" + domain)) +
  ((secure == true) ? "; secure" : "");
}

/*结束： cookies*/


/*transferxml*/

eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('r s(a,b,c,d){4=9.t;u=9.v;2(4=="w"){0 e;0 f;0 g;0 h;2(k(b)=="l"){h=b}5{h=(1 x()).y(b,"z/A")}e=1 B();e.C("D",c,3);e.E(6);f=e.F;g=1 G();g.H(f);g.I(6,"m",a);2(h==6){J("K数据源错误")}0 i=g.L(h,M);d.n="";d.N(i)}5 2(4=="O P Q"){0 f;0 h;0 j;0 g;h=1 7("8.R");h.o=3;h.p=3;2(k(b)=="l"){h.q(b)}5{h.S(b)}0 f=1 7("8.T");f.o=3;f.q(c);f.p=3;j=1 7("8.U");j.V=f;g=j.W();g.X=h;g.Y("m",a);g.Z();d.n=g.10}}',62,63,'var|new|if|false|BrowserName|else|null|ActiveXObject|Msxml2|navigator|||||||||||typeof|object|selected_packet|innerHTML|async|resolveExternals|load|function|DisplayTransformedXML|appName|Version|appVersion|Netscape|DOMParser|parseFromString|text|xml|XMLHttpRequest|open|GET|send|responseXML|XSLTProcessor|importStylesheet|setParameter|alert|XML|transformToFragment|document|appendChild|Microsoft|Internet|Explorer|DOMDocument|loadXML|FreeThreadedDOMDocument|XSLTemplate|stylesheet|createProcessor|input|addParameter|transform|output'.split('|'),0,{}))






//+---------------------------------------------------   
//| 日期合法性验证   
//| 格式为：YYYY-MM-DD或YYYY/MM/DD   
//+---------------------------------------------------   
function IsValidDate(DateStr)    
{    
    var sDate=DateStr.replace(/(^\s+|\s+$)/g,''); //去两边空格;  
    if(sDate=='') return true;    
    //如果格式满足YYYY-(/)MM-(/)DD或YYYY-(/)M-(/)DD或YYYY-(/)M-(/)D或YYYY-(/)MM-(/)D就替换为''    
    //数据库中，合法日期可以是:YYYY-MM/DD(2003-3/21),数据库会自动转换为YYYY-MM-DD格式    
    var s = sDate.replace(/[\d]{4,4}[\-]{1}[\d]{1,2}[\-]{1}[\d]{1,2}/g,'');  
    if (s=='') //说明格式满足YYYY-MM-DD或YYYY-M-DD或YYYY-M-D或YYYY-MM-D    
    {    
        var t=new Date(sDate.replace(/\-/g,'/'));    
        var ar = sDate.split(/[-/:]/);    
        if(ar[0] != t.getFullYear()||ar[1]!= t.getMonth()+1 ||ar[2]!=t.getDate())    
        {    
            //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
            return false;    
        }    
    }    
    else    
    {    
        //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
        return false;    
    }    
    return true;    
}    
//+---------------------------------------------------   
//| 日期时间检查   
//| 格式为：YYYY-MM-DD HH:MM:SS   
//+---------------------------------------------------   
function CheckDateTime(str)   
{    
    var reg = /^(\d+)-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;    
    var r = str.match(reg); 
    if(r==null)return false;    
    r[2]=r[2]-1;   
	if(r[1].length>4)return false;
    var d= new Date(r[1],r[2],r[3],r[4],r[5],r[6]);    
    if(d.getFullYear()!=r[1])return false;    
    if(d.getMonth()!=r[2])return false;    
    if(d.getDate()!=r[3])return false;    
    if(d.getHours()!=r[4])return false;    
    if(d.getMinutes()!=r[5])return false;    
    if(d.getSeconds()!=r[6])return false;    
    return true;    
}   
function clearinput(obj){
	if(obj.value=='按标题搜索'){
		obj.value='';
	}
} 
   
