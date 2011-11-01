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
if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle 
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
		alert("文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
		return false;
	}
	if(foldername.lastIndexOf("*")>-1||foldername.lastIndexOf("?")>-1||foldername.lastIndexOf("\"")>-1){
		alert("文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
		return false;
	}
	if(foldername.lastIndexOf("<")>-1||foldername.lastIndexOf(">")>-1||foldername.lastIndexOf("|")>-1){
		alert("文件名不能包含下列任何字符之一：\n"+"\\ / : * ? \" < > |");
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
