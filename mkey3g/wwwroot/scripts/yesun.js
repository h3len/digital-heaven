/*---功能：自定义Js组件
    Date:2007-8-30
    Author:yesun
--------------------------------------------*/

var Yesun = {};

Yesun.Validate = function (ruleModel)
{
	this.browser = navigator.appVersion;
	this.ruleModel = ruleModel;
	
	//校验数据
	this.Run = function()
	{
		for(var i=0;i<this.ruleModel.length;i++)
		{
		   var id = this.ruleModel.getId(i);
		   if(typeof(document.getElementById(id)) == "undefined")
			   {
			   	alert("页面上不存在控件["+id+"]");
			   }
			 else
			   {
			   var obj = document.getElementById(id);
			   //IsEmpty
			   if(this.ruleModel.getIsEmpty(i) == false)
			   		{
			   	if(obj.value == null || obj.value == "")
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不能为空");
									
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
	   		//IsEmail
	   		if(this.ruleModel.getIsEmail(i) == true)
			   		{
			   	if(obj.value !="" && IsEmail(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
	   		//IsNumber
	   		if(this.ruleModel.getIsNumber(i) == true)
			   		{
			   	if(obj.value !="" && IsNumber(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
			   //IsDate
	   		if(this.ruleModel.getIsDate(i) == true)
			   		{
			   	if(obj.value !="" && IsDate(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
			   //IsDateTime
	   		if(this.ruleModel.getIsDateTime(i) == true)
			   		{
			   	if(obj.value !="" && IsDateTime(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   //IsTime
	   		if(this.ruleModel.getIsTime(i) == true)
			   		{
			   	if(obj.value !="" && IsTime(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
	   		//IsTel
	   		if(this.ruleModel.getIsTel(i) == true)
			   		{
			   	if(obj.value !="" && IsTel(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
	   		//IsIp
	   		if(this.ruleModel.getIsIp(i) == true)
			   		{
			   	if(obj.value !="" && IsIp(obj.value) == false)
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"不合法");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
			   //MaxLength
	   		if(this.ruleModel.getMaxLength(i) > 0)
			   		{
			   	if(obj.value !="" && obj.value.length > this.ruleModel.getMaxLength(i))
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"超出最大长度"+ this.ruleModel.getMaxLength(i) +"个字符");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		
			   //MinLength
	   		if(this.ruleModel.getMinLength(i) > 0)
			   		{
			   	if(obj.value !="" && obj.value.length < this.ruleModel.getMinLength(i))
			   			{
			   				if(typeof(this.ruleModel.getErrorMsg(i)) != "undefined")
										alert("错误提示\r\n"+this.ruleModel.getErrorMsg(i));
									else
										alert("错误提示\r\n"+this.ruleModel.getName(i)+"最小长度不能少于"+ this.ruleModel.getMinLength(i) +"个字符");
									obj.focus();
									obj.select();
									return false;
			   			}
			   		}
			   		//可继续扩展
			   		//TODO
			   		
			   }
		}
		return true;
	}
	
	
	/*---若干私有方法
	-------------------*/
	//是否为电子邮件
	function IsEmail(s)
	{
		var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(reg.test(s))
			return true;
		else
			return false;
	}
	
	//是否为IP
	function IsIp(s)
	{
		var reg=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/; 
		if(reg.test(s))
			return true;
		else
			return false;
	}
	
	//验证电话号码，只允许数字和“-”
	function IsTel(s)
	{
		var reg = /^([\d\-]{7,15})$/g;
		if(reg.test(s))
			return true;
		else
			return false;
	}
	//验证身份证号码
	function IsIdno(s){
		if (s==""){	return confirm("没有填写身份证号，这样将无法判定其生日！\n确定继续吗？");}
		if (s.length != 15 & s.length != 18){
			alert("请填入正确的身份证号码");
			return false;
		}
		if (IsNumber(s.substring(0,17))){
			alert("请填入正确的身份证号码");
			return false;
	    }
		if (IsNumber(s.substring(17,18)) & s.substring(17,18) != "x" & s.substring(17,18) != "X"){
			alert("请填入正确的身份证号码");
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
	
	//判断日期是否合法
	function IsDate(s)
	{
	   	 //对日期格式进行验证 要求为2000-2099年  格式为 yyyy-mm-dd 并且可以正常转换成正确的日期
	  var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
		 if(reg.test(s))
				return true;
			else
				return false;
	}
	
	function IsDateTime(s)
	{
	  var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/; 
		 if(reg.test(s))
				return true;
			else
				return false;
	}
	
	function IsTime(s)
	{
		var a = s.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/);
		if (a == null) {return false;}
		if (a[1]>24 || a[3]>60 || a[4]>60)
		{
			return false
		}
		return true;
	}
	
}

//RuleModel - 校验规则
Yesun.RuleModel = function(config)
{
    this.config = config;
    this.length = config.length;
    this.lookup={};
    for(var i=0;i<this.length;i++){
        if(typeof this.config[i].id=="undefined"){this.config[i].id=i;}
        this.lookup[this.config[i].id]=this.config[i];
    		}
    this.getId = function(col){return this.config[col].id;},
    this.getName = function(col){return this.config[col].name;},
    this.getIsEmpty = function(col){return this.config[col].isEmpty;}
    this.getIsEmail = function(col){return this.config[col].isEmail;}
    this.getIsNumber = function(col){return this.config[col].isNumber;}
    this.getIsTel = function(col){return this.config[col].isTel;}
    this.getIsIp = function(col){return this.config[col].isIp;}
    this.getIsDate = function(col){return this.config[col].isDate;}
    this.getIsTime = function(col){return this.config[col].isTime;}
    this.getIsDateTime = function(col){return this.config[col].isDateTime;}
    this.getMaxLength = function(col){return this.config[col].maxLength;}
    this.getMinLength = function(col){return this.config[col].minLength;}
    this.getErrorMsg = function(col){return this.config[col].errorMsg;}
}






/*---功能：自定义DataTable
    将指定的xml数据绑定到指定的控件上，兼容多浏览器
    xmlSource数据格式，比如<root><item/></root>
    Date:2007-7-15
    Author:yesun
--------------------------------------------*/
Yesun.DataTable = function (xmlSource, obj, colModel)
{
    //是否需要的参数
    //是否需要Caption
    this.isNeedCaption = true;
    //是否需要分页
    this.isNeedPageNav = false;
    //是否需要列序号
    this.isNeedNumber = true;
    //是否需要checkbox
    this.isNeedCheckBox = false;
    
    //判断xmlSource，然后转换为dom
    this.xmlSource;
    //浏览器版本
    this.browser = navigator.appVersion;
    //数据标签
    this.dataSourceTag = 'item';
    
    //列配置
    this.colModel = colModel;
     
    //数据绑定对象
    this.deskObject = obj;
    //标题
    this.caption;
    this.captionAlign = 'left';
    //总页数
    this.totalPage = 1;
    //当前页码
    this.currentPage = 1;
    
    this.BindData = function()
    {    
        //如果传入的xmlSource是字符串则需要转换为dom，多浏览器判断
        if(typeof(xmlSource) == "object")
        { //如果传入的就是xml dom
            this.xmlSource = xmlSource;
        }
        else
        {
            if(this.browser.indexOf('MSIE') > -1)
            {
                //IE
                this.xmlSource = new ActiveXObject("Msxml2.DOMDocument");
                this.xmlSource.async = false;
                this.xmlSource.resolveExternals = false;
                //判断数据源是String还是Xml Dom
                if(typeof(XmlDocumentInput) == "object")
                {//xml dom
			        this.xmlSource.load(xmlSource);
                }
                else
                {//string
        	        this.xmlSource.loadXML(xmlSource);
                }
            }
            else
            {
                //FF
                this.xmlSource = (new DOMParser()).parseFromString(xmlSource,"text/xml");
            }
        }
        var sb = new StringBuffer();
        if(this.isNeedCaption== true && this.caption != '')
            sb.append("<p class='caption' align='"+this.captionAlign+"'>"+this.caption+"</p>");
            
        sb.append("<table class='table' width='"+this.width+"'>");
        
        sb.append("<tr class='header'>");
        if(this.isNeedNumber == true)
            sb.append("<td width='30' class='ac'>序号</td>");
            
        if(this.isNeedCheckBox == true)
            sb.append("<td width='30' class='ac'>选择</td>");
            
        var items = this.xmlSource.selectNodes('//'+this.dataSourceTag);
        
        //循环头Header
        for(var i=0;i<this.colModel.length;i++)
        {
            if(typeof(this.colModel.getColumnWidth(i)) != 'undefined')
                sb.append("<td width='"+this.colModel.getColumnWidth(i)+"'>"+this.colModel.getColumnHeader(i)+"</td>")
            else
                sb.append("<td>"+this.colModel.getColumnWidth(i)+"</td>")
        }
        
        sb.append("</tr>");
        var sbPage = new StringBuffer();
        if(this.isNeedPageNav == true)
        {
            var nextPage = parseInt(this.currentPage) + 1;
            if(nextPage > this.totalPage) nextPage = 1;
            var prevPage = parseInt(this.currentPage) - 1;
            if(prevPage < 1) prevPage = 1;
        
        
            sbPage.append("<tr><td colspan='30' align='right' class='pageNav'>");
            sbPage.append("第<span class='red'>"+this.currentPage+"/"+this.totalPage+"</span>页&#160;&#160;");
            sbPage.append("<img src='/images/First.gif' alt='首页' class='hand' onclick='javascript:changePage(1)'/>&#160;");
            sbPage.append("<img src='/images/Prev.gif' alt='上一页' class='hand' onclick='javascript:changePage("+prevPage+")'/>&#160;");
            var showPageCount = 9;
            var startIndex = 1;
            var endIndex = showPageCount;                     
            startIndex = parseInt(this.currentPage) - parseInt(showPageCount/2);
            endIndex = parseInt(this.currentPage) + parseInt(showPageCount/2);
            if(startIndex < 1)
            {
                startIndex = 1;
                endIndex = showPageCount;
            }
            if(endIndex > this.totalPage)
                endIndex = this.totalPage;
            
            for(var i=startIndex;i<=endIndex;i++)
            {
                if(i == this.currentPage)
                    sbPage.append("<span class='red underline'>"+i+"</span> ");
                else
                    sbPage.append("<a href='javascript:changePage("+i+");'>"+i+"</a> ");
            }
            sbPage.append("<img src='/images/Next.gif' alt='下一页' class='hand' onclick='javascript:changePage("+nextPage+")'/>&#160;");
            sbPage.append("<img src='/images/Last.gif' alt='尾页' class='hand' onclick='javascript:changePage("+this.totalPage+")'/>&#160;");
            sbPage.append("</td></tr>");
            
            sb.append(sbPage.toString());
        }
        
        for(var i=0;i<items.length;i++)
        {   
            if( i % 2 == 0)
                sb.append("<tr class='alt'>");
            else
                sb.append("<tr>");
            if(this.isNeedNumber == true)
               sb.append("<td class='ac'>"+(i+1)+"</td>");   
            if(this.isNeedCheckBox == true)
               sb.append("<td class='ac'><input type='checkbox' name='checkbox' value='"+items[i].getAttribute("id")+"'/></td>");   
                           
            //循环字段Value
            for(var j=0;j<this.colModel.length;j++)
            {
                if(typeof(this.colModel.getColumnHref(j)) != 'undefined')
                {
                    var href = this.colModel.getColumnHref(j);
                    if(href.indexOf("{") > -1)
                    {
                        var re = /{[a-zA-Z\-_]+}/ig;
                        var fields = href.match(re);
                        var arr = fields.toString().split(",");
                        for(var k=0;k<arr.length;k++)
                        {
                            var field = arr[k].replace("{","").replace("}","");
                            href = href.replace("{"+field+"}", items[i].getAttribute(field));
                        }
                    }
                    sb.append("<td><a href='"+href+"'>"+items[i].getAttribute(this.colModel.getColumnDataIndex(j))+"</a></td>")
                }
                else
                {
                    if(items[i].getAttribute(this.colModel.getColumnDataIndex(j)) != null)
                        sb.append("<td>"+items[i].getAttribute(this.colModel.getColumnDataIndex(j))+"</td>")
                    else
                        sb.append("<td></td>")
                 }
            }
            sb.append("</tr>");
        }
        
        if(items.length < 1)
             sb.append("<tr><td colspan='30'>暂时没有数据</td></tr>");
        
        
        if(this.isNeedPageNav == true)
        {
            sb.append(sbPage.toString());
        }
        
        
        sb.append("</table>");
        
        this.deskObject.innerHTML = sb.toString();
    }
}

//ColumnModel - 自定义列
Yesun.ColumnModel = function(config)
{
    this.config = config;
    this.length = config.length;
    
    this.lookup={};
    for(var i=0;i<this.length;i++){
        if(typeof this.config[i].dataIndex=="undefined"){this.config[i].dataIndex=i;}
        if(typeof this.config[i].id=="undefined"){this.config[i].id=i;}
        this.lookup[this.config[i].id]=this.config[i];
    }
    this.getColumnId = function(col){return this.config[col].id;},
    this.getColumnHeader = function(col){return this.config[col].header;}
    this.getColumnWidth = function(col){return this.config[col].width;}
    this.getColumnDataIndex = function(col){return this.config[col].dataIndex;}
    this.getColumnHref = function(col){return this.config[col].href;}
    this.getColumnText = function(col){return this.config[col].text;}
}


//StringBuffer
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


//扩展dom操作selectSingleNode,selectNodes
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
