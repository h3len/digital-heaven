/*****************************************************
'目的：     请求目标ISAPI，发送及返回数据
'输入：		无
'返回：		无
'*****************************************************/	
function GetISAPIData(strPageURL,sxml){

//alert(strPageURL);
//查到这里，就出问题了，取不出数据，
	var xmlErrMsg=new ActiveXObject("Microsoft.XMLDOM")
	try {
		m_xmlHttp.Open("POST",strPageURL, false)
		//location.href=strPageURL;
		//alert(strPageURL);
		//alert(m_xmlHttp.Open("POST",strPageURL, false));
	}
	catch (exception) {
		alert('连接应用服务器出错！请检查网络连接是否正常。'+exception.description)
    	return false
	}
	try {
		if (typeof(sxml)=="undefined"){
			m_xmlHttp.Send()
		}
		else{
			m_xmlHttp.Send(sxml)
		}
	}
	catch (exception) {
		alert('服务器忙!请稍后再试!')
    	return false
	}
	if (m_xmlHttp.statusText!="OK"){
		alert("服务器报错！请确定服务器和数据库正常！\n错误编号：" + m_xmlHttp.status + "\n错误描述：" + m_xmlHttp.statusText)
		return false
	}
	if (!m_xmlHttp.responseXML) {
		alert('应用服务器返回错误数据！')
    	return false
	}
	//var tmps=m_xmlHttp.responsetext.substr(40)
	xmlErrMsg.loadXML(m_xmlHttp.responsetext);
	if (xmlErrMsg.selectSingleNode("//errmsg")!=null){
		/*if (isNaN(parseInt(xmlErrMsg.selectSingleNode("//errno").text))){
			alert(xmlErrMsg.selectSingleNode("//errmsg").text);
		}
		else{*/
			alert("报错模块：" + xmlErrMsg.selectSingleNode("//funcid").text + "\n错误编号：" + xmlErrMsg.selectSingleNode("//errno").text + "\n错误描述：" + xmlErrMsg.selectSingleNode("//errmsg").text);
		//}
		return false
	}
	return true;
}