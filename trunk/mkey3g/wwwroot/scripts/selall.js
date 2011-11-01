
/*
 为了使提示框统一为ext add by mahongming
*/
document.write("<scr"+"ipt language=javascript src=../scripts/dh.js></scr"+"ipt>");

document.write("<scr"+"ipt language=javascript src=../scripts/ext-all.js></scr"+"ipt>");

document.write("<scr"+"ipt language=javascript src=../scripts/dtree.js></scr"+"ipt>");

/*
checkbox选择函数
引用该函数的页面
/charge/dealmain.asp
*/
function selall(selflag){
	if(typeof(formlist)=="undefined"){ DHalert("没有可以选择的对象！");	return false;}
	if(typeof(formlist.checkbox)=="undefined"){DHalert("没有可以选择的对象！");return false;}
	var len=formlist.checkbox.length;
	if(typeof(len)=="undefined"){
		if(selflag==2){
			formlist.checkbox.checked=(!formlist.checkbox.checked)&&(!formlist.checkbox.disabled);
		}
		else{
			formlist.checkbox.checked=selflag&&(!formlist.checkbox.disabled);
		}
	}
	else{
		if(selflag==2){
			for (i=0;i<len;i++){
				formlist.checkbox[i].checked=(!formlist.checkbox[i].checked)&&(!formlist.checkbox[i].disabled);
			}
		}
		else{
			for (i=0;i<len;i++){
				formlist.checkbox[i].checked=selflag&&(!formlist.checkbox[i].disabled);
			}
		}
	}
}


//sign:value间除逗号外的分隔符
function sel(sign) {
  	m_ids="";
	m_idCount=0;
	if(typeof(formlist)=="undefined"){DHalert("没有可以选择的对象！");return false;}
  	if(typeof(formlist.checkbox)=="undefined"){DHalert("没有可以选择的对象！");return false;}
  	if(typeof(sign)=="undefined"){sign="";}
  	var sum=0,str="";
  	var len=formlist.checkbox.length;
	if(typeof(len)=="undefined"){
		if(formlist.checkbox.checked){
			str=sign + formlist.checkbox.value + sign + ","
			sum=1;
		}
		else{
		DHalert("没有可以选择的对象！");
		return false;
		}
	}
	else{
		for (i=0;i<len;i++){
			if (formlist.checkbox[i].checked) 
			{
				str=str + sign + formlist.checkbox[i].value + sign + ",";
				sum=sum+1;
			}
		}
	}
	if (str==""){
	DHalert("没有可以选择的对象！");
	return false;}
	str=str.substring(0,str.length-1);
	m_ids=str;
	m_idCount=sum;
	return true;
}



/*
checkbox选择函数 By:cauchy
*/
function SelCheckbox(checkboxname,type){
	var obj = document.getElementsByName(checkboxname);
 	if (typeof(obj)=="undefined"|| obj==null || typeof(obj)!="object"){
  		DHalert("没有可以选择的对象！");
  		return false;
 	}
	var len = obj.length;
 	if (len==0 || typeof(len)=="undefined"|| len==null){
  		DHalert("没有可以选择的对象！");
  		return false;
 	}
	var i;
	if (type==0)//不选
	{
			for (i=0;i<len;i++){
				obj[i].checked = false;
			}
	}
	else if(type==1)//全选
	{
			for (i=0;i<len;i++){
				obj[i].checked = true;
			}
	}
	else if(type==3)//反选
	{
			for (i=0;i<len;i++){
				obj[i].checked = (!obj[i].checked);
			}
	}
}
/*
checkbox提取选择的value和个数；,以逗号隔开。 By:cauchy
*/
	function SelValue(checkboxname){
  	m_ids="";
		m_idCount=0;
		var sum=0,str="";	
		var obj = document.getElementsByName(checkboxname);
	 	if (typeof(obj)=="undefined"|| obj==null || typeof(obj)!="object"){
	  		DHalert("没有可以选择的对象！");
	  		return false;
	 	}
		var len = obj.length;
	 	if (len==0 || typeof(len)=="undefined"|| len==null){
	  		DHalert("没有可以选择的对象！");
	  		return false;
	 	}	
		for (	var i=0;i<len;i++){
			if(obj[i].checked ==true)
			{
				str += obj[i].value + ",";
				sum=sum+1;
			}
		}
		if (str==""){
			 DHalert("没有可以选择的对象！");	
			return false;
			}
		str=str.substring(0,str.length-1);
		m_ids=str;
		m_idCount=sum;
		return true;
	}
	function SelAllValue(checkboxname){
			m_ids="";
		m_idCount=0;
		var sum=0,str="";	
		var obj = document.getElementsByName(checkboxname);
	 	if (typeof(obj)=="undefined"|| obj==null || typeof(obj)!="object"){
	  		DHalert("没有可以选择的对象！");
	  		return false;
	 	}
		var len = obj.length;
	 	if (len==0 || typeof(len)=="undefined"|| len==null){
	  		//DHalert("没有可以选择的对象！");
	  		return false;
	 	}	
		for (	var i=0;i<len;i++){
			if(obj[i].checked ==true)
			{
				str += obj[i].value + ",";
				sum=sum+1;
			}
		}
//		if (str==""){alert("没有选择对象!");return false;}
		str=str.substring(0,str.length-1);
		m_ids=str;
		m_idCount=sum;
		return true;
	}