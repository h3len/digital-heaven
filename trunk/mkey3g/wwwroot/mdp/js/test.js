function Transfer(content, baseurl)
{
	content = content.substring(content.indexOf("��")+1,content.indexOf("��"));
	return content;
}