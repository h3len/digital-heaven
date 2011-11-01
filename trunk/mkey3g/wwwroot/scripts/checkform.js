//??????
function jsTrim(s) {return s.replace(/(^\s+)|(\s+$)/g, "");}
//??????
function jsNoSpace(s) {return s.replace(/\s+/g, "");}
//???'?
function jsSafeInput(s) {return jsTrim(s.replace(/('+)/g,'?'));}

function jsSafeXML(s) {
	s = s.replace(/(&+)/g,'&amp;');
	s = s.replace(/(>+)/g,'&gt;');
	s = s.replace(/(<+)/g,'&lt;');
	s = s.replace(/("+)/g,'&quot;');
	s = s.replace(/('+)/g,'&apos;');
	return s;
}
function jsSafeXMLSBCcase(s) {
	s = s.replace(/(>+)/g,'?');
	s = s.replace(/(<+)/g,'?');
	s = s.replace(/("+)/g,'?');
	s = s.replace(/('+)/g,'?');
	s = s.replace(/(&+)/g,'?');
	return s;
}
function HTMLEncode(s) {
	s = s.replace(/(\s+)/g,'&nbsp;');
	s = s.replace(/(\n+)/g,'<br/>');
	return s;
}

//???&?
function jsSafeURL(s) {
	return jsTrim(s.replace(/(&+)/g,''));
}
//?????????
function jsSafeAll(s) {return jsSafeXML(jsSafeURL(s));}
//??????????????-?
function jsTel(s) {return s.replace(/[^\d|^-]/g,'');}
//???????
function jsIDNO(s){
	if (s==""){	return confirm("???????????????????????\n??????");}
	if (s.length != 15 & s.length != 18){
		alert("???????????");
		return false;
	}
	if (havenoNumber(s.substring(0,17))){
		alert("???????????");
		return false;
    }
	if (havenoNumber(s.substring(17,18)) & s.substring(17,18) != "x" & s.substring(17,18) != "X"){
		alert("???????????");
		return false;
	}
	return true;
}
//??????? ?? true
function havenoNumber(s){ //????????
   text="1234567890";
   for(i=0;i<=s.length-1;i++)
  {
      char1=s.charAt(i);
      index=text.indexOf(char1);
      if(index==-1)
      {
        return true; 
      }
   }
   return false;
}

//???????????
function getBirthdayFromIDno(IDno){
	var sBirthday;
	if(IDno.length==15){
		sBirthday = "19" + IDno.substring(6,8);
		sBirthday = sBirthday + "-" + IDno.substring(8,10);
		sBirthday = sBirthday + "-" + IDno.substring(10,12);
	}
	if(IDno.length==18){
		sBirthday = IDno.substring(6,10);
		sBirthday = sBirthday + "-" + IDno.substring(10,12);
		sBirthday = sBirthday + "-" + IDno.substring(12,14);
	}
	return sBirthday;
}

//????????
//??g_dateVal???"1980-01-01"
function isDate(g_dateVal){ 
	var s = g_dateVal.replace(/-/g,"/"); 
	var newdate=new Date(s); 
	var s = newdate.getYear();
	return isNAN(s);
} 

//???????objtxt?????????
/*??
	<input type="text" name="txtPrice" chname="??">
	<script language="javascript">
		if (checkobjmunber(txtPrice,0)){...}//??>=0
		if (checkobjmunber(txtPrice,1)){...}//??>0
		if (checkobjmunber(txtPrice){...}//????
	</script>
*/
function checkobjmunber(objtxt,izero){
	var chname;
	if (typeof(objtxt.chname)=="undefined"){
		chname = "??";
	}
	else{
		chname = jsTrim(objtxt.chname)
		if (chname==""){chname = "??";}
	}
	
	objtxt.value=jsTrim(objtxt.value);
	if (isNaN(parseFloat(objtxt.value))){
		alert(chname + "???????");
		objtxt.focus();return false;
	}
	objtxt.value=parseFloat(objtxt.value)
	if (izero>0){
		if(!(parseFloat(objtxt.value)>0)){
			alert(chname + "?????");
			objtxt.focus();return false;
		}
	}
	else if (izero>=0){
		if(!(parseFloat(objtxt.value)>=0)){
			alert(chname + "???????");
			objtxt.focus();return false;
		}
	}
	return true;
}
//?????email??
function isemail(emailstr) {
        if ((emailstr.indexOf('@', 0) == -1) || emailstr.indexOf('.') == -1) 
                {
            return false
        }
        else {
            return true
        }
 }
