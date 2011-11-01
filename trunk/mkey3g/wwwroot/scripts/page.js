/*
Modify By Yesun 2006-5-31
*/

var url,re,CurrentPage,FirstPageUrl,PrevPageUrl,NextPageUrl,LastPageUrl,CurrPage,PageCount,prevpage,nextpage,PageStart,PageEnd,i,ipage;
   url=""+document.location;
   if (url.indexOf("pageid=")==-1)
    {
     CurrPage=1;
    } 
   else
    {
      re=/(\S.*)(pageid=\d*)(\S.*|\S*)/g;   
      CurrentPage=url.replace(re,"$2"); 
      url=url.replace("&"+CurrentPage,""); 
      url=url.replace(CurrentPage+"&",""); 
      url=url.replace(CurrentPage,"");      
      CurrentPage=CurrentPage.replace("pageid=","")
      CurrPage=CheckNum(CurrentPage,1)	 
   }      
   if (url.indexOf("?")==-1)
    {
     url=url+"?";
     }  
   else
     {
     url=url+"&"; 
   }
   url=url.replace("?&","?");  
   url=url.replace("&&","&");
function CheckNum(str,num)
{
	 str=""+str;
     if (str.length>=1)
       {
       mynum=parseInt(str);
       if (isNaN(mynum))
         {
         mynum=num;
         }
       }  
	   else
      {
	   mynum=num;
      } 	
	  return (mynum);
}
function CheckPage()  
{
	 url=url+'&pageid='	
	 url=url.replace("?&","?");
	 url=url.replace("&&","&");
	 ipage=document.getElementById("pageid").value;
	 ipage=CheckNum(ipage,1)
	 if (ipage>=PageCount)
	 {
	   ipage=PageCount;
	 }
	 else if (ipage<=1)
	 {
	   ipage=1;
	 }
	 else
	 {
       ipage=ipage;
	 }
	 location.href=url+ipage;
     //document.iform.action=url+ipage;
     //document.iform.submit();
}     
function ShowoPage(Tabstart,Tabend,CurrPageFont1,CurrPageFont2,PageCountFont1,PageCountFont2,PrePageFont1,PrePageFont2,RecCountFont1,RecCountFont2,FirstFont,PrevFont,NextFont,LastFont,Jump,PageNumFont1,PageNumFont2,PageNumFont3,PageNumFont4,LinkFont1,LinkFont2,LinkFont3,LinkFont4,RecCount,RecPerPage,PageNum,pageInt)  
  {
    if (RecCount%RecPerPage==0)
     {
        PageCount=RecCount/RecPerPage;
     }
   else
     {
       PageCount=(parseInt(RecCount/RecPerPage)+1);
    }
	  prevpage=parseInt(CurrPage-1);
	   if (prevpage<1)
	   {
		   prevpage=1;
	   }
	   nextpage=parseInt(CurrPage+1)
	   if (nextpage>PageCount)
	   {
		   nextpage=PageCount;
	   }
	if  (CurrPage==1&&PageCount==1)
     {
       CurrPage=1;
	   FirstPageUrl="<font color=#999999>"+LinkFont3+FirstFont+LinkFont4+"</font>";
	   PrevPageUrl="<font color=#999999>"+LinkFont3+PrevFont+LinkFont4+"</font>";
	   NextPageUrl="<font color=#999999>"+LinkFont3+NextFont+LinkFont4+"</font>";
       LastPageUrl="<font color=#999999>"+LinkFont3+LastFont+LinkFont4+"</font>";
     }
     else if (CurrPage<=1)
     {
       CurrPage=1;
	   FirstPageUrl="<font color=#999999>"+LinkFont3+FirstFont+LinkFont4+"</font>";
	   PrevPageUrl="<font color=#999999>"+LinkFont3+PrevFont+LinkFont4+"</font>";
       if(RecCount>RecPerPage)
       {
       NextPageUrl="<A href=\""+url+"pageid="+nextpage+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+NextFont+LinkFont2+"</A>";
       LastPageUrl="<A href=\""+url+"pageid="+PageCount+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+LastFont+LinkFont2+"</A>";
       }
       else
       {
       NextPageUrl="<font color=#999999>"+LinkFont1+NextFont+LinkFont2+"</font>";
       LastPageUrl="<font color=#999999>"+LinkFont1+LastFont+LinkFont2+"</font>";
       }
     }
   else if (CurrPage>=PageCount)
     {
       CurrPage=PageCount;
	   FirstPageUrl="<A href=\""+url+"pageid=1\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+FirstFont+LinkFont2+"</A>";
	   PrevPageUrl="<A href=\""+url+"pageid="+prevpage+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+PrevFont+LinkFont2+"</A>";
	   NextPageUrl="<font color=#999999>"+LinkFont3+NextFont+LinkFont4+"</font>";
       LastPageUrl="<font color=#999999>"+LinkFont3+LastFont+LinkFont4+"</font>";
     }
	  
   else
     {
       CurrPage=CurrPage;	   
	   FirstPageUrl="<A href=\""+url+"pageid=1\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+FirstFont+LinkFont2+"</A>";
	   PrevPageUrl="<A href=\""+url+"pageid="+prevpage+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+PrevFont+LinkFont2+"</A>";
       NextPageUrl="<A href=\""+url+"pageid="+nextpage+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+NextFont+LinkFont2+"</A>";
       LastPageUrl="<A href=\""+url+"pageid="+PageCount+"\" style=\"color:#000000;text-decoration:none;\">"+LinkFont1+LastFont+LinkFont2+"</A>";
  }
  if (CurrPage-PageNum<=1)
     {
       PageStart=1;
     }
   else
     {
       PageStart=CurrPage-PageNum;
   }
  if (CurrPage+PageNum>=PageCount)
     {
       PageEnd=PageCount;
     }
    else
     {
      PageEnd=CurrPage+PageNum;
  }
  if(pageInt>=PageCount)
  {
	RecPerPage=RecCount-RecPerPage*(PageCount-1);
  }
  if(PageCount==0)
  {
	PageCount=1;
  }
  document.write ("<FORM name=\"iform\">"+Tabstart);
  document.write (CurrPageFont1+CurrPage+CurrPageFont2+PageCountFont1+PageCount+PageCountFont2+PrePageFont1);
  document.write (RecPerPage+PrePageFont2+RecCountFont1+RecCount+RecCountFont2+FirstPageUrl+PrevPageUrl);
  for (i=PageStart;i<=PageEnd;i++)
  {
   if (i==CurrPage)
     {
     document.write ("&nbsp;"+PageNumFont3+"<font style=\"background-color:#999;color:#000;\">"+i+"</font>"+PageNumFont4+"&nbsp;");
     } 
   else
     {
	 document.write ("&nbsp;<A href=\""+url+"pageid="+i+"\" class=num style=\"text-decoration:none\">"+PageNumFont1+i+PageNumFont2+"</A>&nbsp;");
	 }
   }
  document.write (NextPageUrl+LastPageUrl+Jump);
  document.write ("<INPUT type=\"text\" style=\"background-color:#ffffff;text-align:center;color:green;font-weight:bolder;\" name=\"pageid\" size=\"2\" maxlength=\"7\" style=\"border: 1px solid #000000;font-size: 12px;color: #000000;height: 18px;\" id=\"pageid\" value=\""+pageInt+"\"> <INPUT type=\"button\" onclick=\"javascript:CheckPage();\" style=\"border: 1px solid #000000;font-size: 12px;height: 18px;\" value=\"Go\" name=\"submit\">"+Tabend+"</FORM>");  
}