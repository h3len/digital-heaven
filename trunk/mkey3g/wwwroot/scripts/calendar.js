//Modify By Yesun Fixed IE/FireFox 2006-8-11

var calendar_DayNames = new Array("日","一","二","三","四","五","六");
var calendar_MonthNames = new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月");
function showCalendar(targetID, targetURL, dMonth, dYear, dDay,hasTaskDay)
{
    if(dMonth < 0)
    {       
        dMonth = 11;
        dYear--;
    }
    if(dMonth > 11)
    {
        dMonth = 0;
        dYear++;
    }
 
    var dNow = new Date();
    if(dDay == 90 && dMonth == dNow.getMonth() && dYear == dNow.getYear()) dDay = dNow.getDate();
    var dCurFD = new Date(dYear, dMonth, 1);
    var dGivenDate = new Date(dYear, dMonth, dDay);  
    var dCurrentMonthFirstSunday = dCurFD.getDay();
    var dCurrentViewDate = new Date(dCurFD);
    var iDays = 0;
    var weekMilliseconds = 1000*60*60*24*7;
    if(dCurrentMonthFirstSunday > 0) iDays =- dCurrentMonthFirstSunday;
    

    var fTrgt = targetURL;
    while (fTrgt.indexOf("'") >= 0) fTrgt = fTrgt.replace("'", "`");
    while (fTrgt.indexOf("`") >= 0) fTrgt = fTrgt.replace("`", "\\'");
 	var preMonth = (dMonth - 1);
  	var nextMonth = (dMonth + 1);
  	if(preMonth<0)
  		preMonth = 11;
  	if(nextMonth>=12)
  		nextMonth = 0;
    var oBuf = '<TABLE BORDER="0" style="border:0px #BEDCEB solid;" bordercolordark="#ffffff" bordercolorlight="#999999" WIDTH="100%" CELLSPACING="1" CELLPADDING="0">';       
    oBuf += '<TR><TD CLASS="calendarhd"><A style="font-size:12px;" HREF="javascript:showCalendar(\'' + targetID + "','" + fTrgt + "'," + (dMonth - 1) + ',' + dYear + ',90,\''+hasTaskDay+'\');"><<</A></TD>';
    oBuf += '<TD COLSPAN="5" CLASS="calendarhd">' + (calendar_MonthNames[dMonth]) + ' ' + dYear + '</TD>';
    oBuf += '<TD CLASS="calendarhd" style="font-size:12px;"><A HREF="javascript:showCalendar(\'' + targetID + "','" + fTrgt + "'," + (dMonth + 1) + ',' + dYear + ',90,\''+hasTaskDay+'\');">>></A></TD></TR>';
    oBuf += '<TR style="calendarhdrow">';
   

    for(var e=0; e < 7; e++) oBuf += '<TD CLASS="calendarDays" bgcolor="#E6F1F7" style="font-size:12px;">' + calendar_DayNames[e] + '</TD>';          
    oBuf += '</TR>';


    var nextMonthFirstDay = new Date(dYear, dMonth+1, 1);
    var IsNextMonthFirstDaySunday = nextMonthFirstDay.getDay()==0;


    for(var iRows=0; iRows < 6; iRows++)
    {
        dCurrentMonthDate = new Date(dCurFD.getFullYear(), dCurFD.getMonth(), dCurFD.getDate() + iDays);
        if(1==1)         
        {
			if(iRows==5 && dCurrentMonthDate.getMonth() > dCurFD.getMonth()) continue;        
			if(iRows==5 && IsNextMonthFirstDaySunday) continue;
                
        oBuf += '<TR CLASS="calendarContent">';
        for(var iCols=0; iCols < 7; iCols++)
        {
	        //周六周日 需要不同颜色区分
	    	var isNotWork = "";
	    	if( iCols == 0 || iCols == 6 )
	    		isNotWork = "bgcolor=\"#f2f8fb\"";
	    	else
	    		isNotWork = "bgcolor=\"#ffffff\"";
	    		

            dCurrentViewDate = new Date(dCurFD.getFullYear(), dCurFD.getMonth(), dCurFD.getDate() + iDays);
            var strCurrentDate = dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate() ;
			//alert(strCurrentDate);
			
			
			var args;

            
            if (targetURL.substr(0,11) == 'javascript:')
            {

              args = dCurrentViewDate.valueOf() + ")";
            }
            else
            {

              var sep = targetURL.indexOf('?') < 0 ? '?' : '&';
              args = sep + 'startDate=' + dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate() ;
            }
            args = "yesun";
            var xx = new Date();
			if( hasTaskDay.indexOf(strCurrentDate+",") > -1)
			{
				oBuf += "<TD class=\"hasTaskDay\" "+isNotWork+" onclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
			}
			else if((dGivenDate.toDateString() == dCurrentViewDate.toDateString()) && dCurrentViewDate.getMonth()==xx.getMonth() && (dDay != 90))
            {
                oBuf += "<TD CLASS=\"selectedDate\" "+isNotWork+" onclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
            }
            else
            {

                if(dCurrentViewDate.getMonth() != dMonth || iDays < 0) 
                {
                   oBuf += "<TD CLASS=\"negDate\" "+isNotWork+" onclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
                }
                else
                {
                    oBuf += "<TD CLASS=\"posDate\" "+isNotWork+" onclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
                }
            }            
            
            
            
            oBuf += dCurrentViewDate.getDate() +"</TD>";
            iDays++;
        }
        oBuf += '</TR>';
        }
    }

    oBuf += '</TABLE>';

    document.getElementById(targetID).innerHTML = oBuf;
}






/*------------------------------
	大日历
-------------------------------*/
function showBigCalendar(targetID, targetURL, dMonth, dYear, dDay,hasTaskDay)
{
    if(dMonth < 0)
    {       
        dMonth = 11;
        dYear--;
    }
    if(dMonth > 11)
    {
        dMonth = 0;
        dYear++;
    }
 
    var dNow = new Date();
    if(dDay == 90 && dMonth == dNow.getMonth() && dYear == dNow.getYear()) dDay = dNow.getDate();
    var dCurFD = new Date(dYear, dMonth, 1);
    var dGivenDate = new Date(dYear, dMonth, dDay);  
    var dCurrentMonthFirstSunday = dCurFD.getDay();
    var dCurrentViewDate = new Date(dCurFD);
    var iDays = 0;
    var weekMilliseconds = 1000*60*60*24*7;
    if(dCurrentMonthFirstSunday > 0) iDays =- dCurrentMonthFirstSunday;
    

    var fTrgt = targetURL;
    while (fTrgt.indexOf("'") >= 0) fTrgt = fTrgt.replace("'", "`");
    while (fTrgt.indexOf("`") >= 0) fTrgt = fTrgt.replace("`", "\\'");
 	var preMonth = (dMonth - 1);
  	var nextMonth = (dMonth + 1);
  	if(preMonth<0)
  		preMonth = 11;
  	if(nextMonth>=12)
  		nextMonth = 0;
  		
  	//var calWidth = "100%";
  	//calWidth = document.body.clientWidth * 79/100;
    var oBuf = '<TABLE bgColor="eeeeee" BORDER="0" id="calTable" style="border:0px #BEDCEB solid;" bordercolordark="#ffffff" bordercolorlight="#999999" WIDTH="100%" CELLSPACING="1" CELLPADDING="0">';       
    oBuf += '<TR><TD CLASS="calendarhd"><A HREF="javascript:showBigCalendar(\'' + targetID + "','" + fTrgt + "'," + (dMonth - 1) + ',' + dYear + ',90,\''+hasTaskDay+'\');"><<'+calendar_MonthNames[preMonth]+'</A></TD>';
    oBuf += '<TD COLSPAN="5" CLASS="calendarhd">' + (calendar_MonthNames[dMonth]) + ' ' + dYear + '</TD>';
    oBuf += '<TD CLASS="calendarhd"><A HREF="javascript:showBigCalendar(\'' + targetID + "','" + fTrgt + "'," + (dMonth + 1) + ',' + dYear + ',90,\''+hasTaskDay+'\');">'+calendar_MonthNames[nextMonth]+'>></A></TD></TR>';
    oBuf += '<TR style="calendarhdrow">';
   

    for(var e=0; e < 7; e++) oBuf += '<TD CLASS="calendarDays" bgcolor="#E6F1F7">' + calendar_DayNames[e] + '</TD>';          
    oBuf += '</TR>';


    var nextMonthFirstDay = new Date(dYear, dMonth+1, 1);
    var IsNextMonthFirstDaySunday = nextMonthFirstDay.getDay()==0;


    for(var iRows=0; iRows < 6; iRows++)
    {
        dCurrentMonthDate = new Date(dCurFD.getFullYear(), dCurFD.getMonth(), dCurFD.getDate() + iDays);
        if(1==1)         
        {
			if(iRows==5 && dCurrentMonthDate.getMonth() > dCurFD.getMonth()) continue;        
			if(iRows==5 && IsNextMonthFirstDaySunday) continue;
                
        oBuf += '<TR CLASS="calendarContent" height="90">';
        for(var iCols=0; iCols < 7; iCols++)
        {

			//周六周日 需要不同颜色区分
	    	var isNotWork = "";
	    	if( iCols == 0 || iCols == 6 )
	    		isNotWork = "bgcolor=\"#f2f8fb\"";
	    	else
	    		isNotWork = "bgcolor=\"#ffffff\"";
	    		
            dCurrentViewDate = new Date(dCurFD.getFullYear(), dCurFD.getMonth(), dCurFD.getDate() + iDays);
            var strCurrentDate = dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate() ;
			//alert(strCurrentDate);
			
			
			var args;

            
            if (targetURL.substr(0,11) == 'javascript:')
            {

              args = dCurrentViewDate.valueOf() + ")";
            }
            else
            {
              var sep = targetURL.indexOf('?') < 0 ? '?' : '&';
              args = sep + 'startDate=' + dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate() ;
            }
            args = "ok";
            //alert(dGivenDate.toDateString()+" == "+dCurrentViewDate.toDateString());
            
			if( hasTaskDay.indexOf(strCurrentDate+",") > -1)
			{
				oBuf += "<TD "+isNotWork+" align=left valign=top style=\"font-weight:bolder;cursor:pointer;text-align:left;\" ondblclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
			}
			else if((dGivenDate.toDateString() == dCurrentViewDate.toDateString()) && (dDay != 90))
            {
                oBuf += "<TD style=\"background:#FDF7DB;text-align:center;cursor:pointer;\" align=left valign=top style=\"font-weight:bolder;cursor:pointer;text-align:left;\" ondblclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
                
            }
            else
            {

                if(dCurrentViewDate.getMonth() != dMonth || iDays < 0) 
                {
                   oBuf += "<TD "+isNotWork+" align=left valign=top bgcolor=\"#E6F1F7\" style=\"cursor:pointer;text-align:left;\" ondblclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
                }
                else
                {
                    oBuf += "<TD "+isNotWork+" align=left valign=top bgcolor=\"#E6F1F7\" style=\"cursor:pointer;text-align:left;\" ondblclick=\"javascript:SelectDate('"+dCurrentViewDate.getFullYear()+ '-' + (dCurrentViewDate.getMonth()+1) + '-' +dCurrentViewDate.getDate()+"');\">";
                }
            }    
            var a = "#E6F1F7";
			if((dGivenDate.toDateString() == dCurrentViewDate.toDateString()) && (dDay != 90))
            {       
	            a = '#E0C331';
            }
            
            var content = GetUserCalendarContentByDate(dCurrentViewDate.getYear()+"-"+(dCurrentViewDate.getMonth()+1)+"-"+dCurrentViewDate.getDate());
            //dCurrentViewDate.getDate()
            //取得日程内容 for MonthView
            oBuf +=  "<div style=\"font-size:10px;background-color:"+a+";text-align:right;width:100%;\">"+dCurrentViewDate.getDate()+"</div><div style=\"font-size:11px;font-weight:normal;width:100%;cursor:pointer;\">"+content+"</div></TD>";
            iDays++;
        }
        oBuf += '</TR>';
        }
    }

    oBuf += '</TABLE>';

    document.getElementById(targetID).innerHTML = oBuf;
}
