//by chb
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