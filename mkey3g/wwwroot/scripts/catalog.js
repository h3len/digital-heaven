	//在客户端递归，比服务器ｎ级递归来的快点
	var space = "";
	function BindCatalog(objCatalogListXml,objSelect,parentid,count)
	{
	    //alert(objCatalogListXml.xml);
		var nodelist = objCatalogListXml.selectNodes("/root/list/item")
		for ( var i = 0;i<nodelist.length;i++ )
		{
			
			  var objOption = document.createElement('OPTION');
			  space = "";
			  for(var j=0;j<count;j++)
			{
			 space += " 　";	            
			}     
			if(i == nodelist.length - 1)        
			{
			 space += "*";
			 //space += "┗";
			}
			else
			{									
			 space+= "*";
			 //space+= "┣";
			}							
			
			  objOption.text  = space + nodelist[i].getAttribute("name");
			  objOption.value = nodelist[i].getAttribute("id");
			  //IE和FireFox不同
			  document.all?objSelect.add(objOption):objSelect.appendChild(objOption);
			  
			  //递归子
			  count++;
			  BindCatalog_SelectChild(nodelist[i],objSelect,parentid,count)
			  count--;
            }
	}
	
	//递归子
	function BindCatalog_SelectChild(objCatalogListXml,objSelect,parentid,count)
	{
	    //alert(objCatalogListXml.xml);
		var nodelist = objCatalogListXml.selectNodes("item")
		for ( var i = 0;i<nodelist.length;i++ )
		{
            var objOption = document.createElement('OPTION');
            space = "";
            for(var j=0;j<count;j++)
		    {
			    space += " 　";	            
		    }     
		    if(i == nodelist.length - 1)        
		    {
			    space += "┗";
		    }
		    else
		    {									
			    space+= "┣";
		    }							
			
            objOption.text  = space + nodelist[i].getAttribute("name");
            objOption.value = nodelist[i].getAttribute("id");
            //IE和FireFox不同
            document.all?objSelect.add(objOption):objSelect.appendChild(objOption);
            //递归子
            count++;
            BindCatalog_SelectChild(nodelist[i],objSelect,parentid,count)
            count--;
		} 
	}
	
	//Bind Root Catalog
	function BindRootCatalog(objCatalogListXml,catalogtype,objSelect,parentid)
	{
		var nodelist = objCatalogListXml.selectNodes("/root/cataloglist/catalog")
		for ( var i = 0;i<nodelist.length;i++ )
		{
			if(nodelist[i].getAttribute("catalogtype") == catalogtype && nodelist[i].getAttribute("parentid") == parentid)
			{
                var objOption = document.createElement('OPTION');
                objOption.text  = "┣" + nodelist[i].getAttribute("catalogname");
                objOption.value = nodelist[i].getAttribute("id");
                objSelect.add(objOption);
            }
		} 
	}
	
	//取出cataloglist绑定到obj控件上
    function BindCatalogToObject(objCatalogListXml,catalogtype,obj,parentid)
    {
        try
        {		
            obj.innerHTML = "";
            var nodelist = objCatalogListXml.selectNodes("/root/cataloglist/catalog");
            var j = 0;
            for ( var i = 0;i<nodelist.length;i++ )
            {
                if(nodelist[i].getAttribute("catalogtype") == 0)
                {//每行16个分类
                    if(j>0 && j % 16 == 0)
                    {
                        obj.innerHTML += "<br/>";
                    }
                    if(nodelist[i].getAttribute("hrefurl") != "")
                    {		
                        obj.innerHTML += "·<a href=\""+nodelist[i].getAttribute("hrefurl")+"\" class=\"class\">"+nodelist[i].getAttribute("catalogname")+"</a>";
                    }
                    else
                    {
                       obj.innerHTML += "·<a href=\"/xml/catalog/"+nodelist[i].getAttribute("id")+"\" class=\"class\">"+nodelist[i].getAttribute("catalogname")+"</a>";
                    }			
                    j++;
                }
            }
        }
        catch(err)
        {
            alert(err.message);
        }
    }
