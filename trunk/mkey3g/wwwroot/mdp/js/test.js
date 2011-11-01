function Transfer(content, baseurl)
{
	content = content.substring(content.indexOf("ÎÒ")+1,content.indexOf("ÈË"));
	return content;
}