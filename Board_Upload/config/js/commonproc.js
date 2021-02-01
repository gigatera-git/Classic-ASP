//작성자 : gigatera
//설  명 : Main JavaScript



function pause(numberMillis) {
     var now = new Date();
     var exitTime = now.getTime() + numberMillis;


     while (true) {
          now = new Date();
          if (now.getTime() > exitTime)
              return;
     }
}


function pauseWithModal(numberMillis) {
        var dialogScript = 
           'window.setTimeout(' +
           ' function () { window.close(); }, ' + numberMillis + ');';
        var result = 
        // IE
         window.showModalDialog(
           'javascript:document.writeln(' +
            '"<script>' + dialogScript + '<' + '/script>잠시만 기다려 주세요")');

        // NN
        /* openDialog(
           'javascript:document.writeln(' +
            '"<script>' + dialogScript + '<' + '/script>잠시만 기다려 주세요"',
           'pauseDialog', 'modal=1,width=10,height=10');
        */
}




// 어래이여부를 확인
function isarray( obj ) {
    try {
        var len = obj.length;
        if(len > 1) {
            return true;
        }
        else {
            return false;
        }
    }
    catch (e) {
        return false;
    }
}



//오늘의 날짜를 YYYY-MM-DD형식으로 리턴


function getYesterday2()
{
	var day1 = new Date(); 
	var day2 = new Date(day1.getYear(), day1.getMonth(), day1.getDate()-1);   

	var y,m,d;
	y = day2.getFullYear();
	m = day2.getMonth()+1;
	d = day2.getDate();

	if (m<10)
	{
		m = '0' + m;
	}

	if (d<10)
	{
		d = '0' + d;
	}

	return y + '-' + m + '-' + d;
}

function tommorrow2()
{
	var day1 = new Date(); 
	var day2 = new Date(day1.getYear(), day1.getMonth(), day1.getDate()+1);   

	var y,m,d;
	y = day2.getFullYear();
	m = day2.getMonth()+1;
	d = day2.getDate();

	if (m<10)
	{
		m = '0' + m;
	}

	if (d<10)
	{
		d = '0' + d;
	}

	return y + '-' + m + '-' + d;
}

function getToday()
{
	var date = new Date();
	var y = date.getFullYear();
	var m = date.getMonth()+1; if ((""+m).length==1) m = "0"+m;
	var d = date.getDate(); if ((""+d).length==1) d = "0"+d;
	return y+"-"+m+"-"+d;
}


function getTime()
{
	var date = new Date();
	var hh = date.getHours(); if ((""+hh).length==1) hh = "0"+hh;
	var dd = date.getMinutes(); if ((""+dd).length==1) dd = "0"+dd;
	var ss = date.getSeconds(); if ((""+ss).length==1) ss = "0"+ss;

	return hh+':'+dd+':'+ss;
}

function getWeek()
{
	var date = new Date();
	var day = date.getDay();
	var week = "";

	if(day == 0) week = "일";      
	else if(day == 1) week = "월";
	else if(day == 2) week = "화";
	else if(day == 3) week = "수";
	else if(day == 4) week = "목";
	else if(day == 5) week = "금";
	else if(day == 6) week = "토";

	return week;
}

function getToday2()
{
	var date = new Date();
	var y = date.getFullYear();
	var m = date.getMonth()+1; if ((""+m).length==1) m = "0"+m;
	var d = date.getDate(); if ((""+d).length==1) d = "0"+d;
	return y+""+m+""+d;
}



function getYYYY()
{
	var date = new Date();
	return date.getFullYear();;
}

function getMM()
{
	var date = new Date();
	var m = date.getMonth()+1; if ((""+m).length==1) m = "0"+m;
	return m;
}

function getDD()
{
	var date = new Date();
	var d = date.getDate(); if ((""+d).length==1) d = "0"+d;
	return d;
}

function getPrevDD()
{
	var date = new Date();
	var d = date.getDate()-1; if ((""+d).length==1) d = "0"+d;
	return d;
}

//값이 null,"","undefined",space 이면 true 아니면 false 를 리턴
function IsNull(value)
{
	if(value != null && String(value) != "undefined")
		value = value.replace(/(^\s+)|(\s+$)/g,'');

	if(value == "" || value == null || String(value) == "undefined")
		return true;
	else
		return false;
}

//숫자인지를 검사...
function IsNumeric(val)
//숫자이면 true 숫자가 아니면 false 리턴
{
	var preStr = "0123456789";
	var res = 0;

	for (var i=0;i<String(val).length;i++)
	{
		for (var j=0;j<String(preStr).length;j++)
		{
			if ( String(val).charAt(i) == String(preStr).charAt(j) )
				res++;
		}
	}
	return ((res==String(val).length)?true:false);
}

//입력시 숫자 값인지를 체크
function IsNumber(obj,val)
{
	if ( trim(obj.value)=="" )
	{
		obj.value = val;
		obj.focus();
	}
	if ( !IsNumeric(obj.value) )
	{
		alert("숫자만 입력가능합니다");
		obj.value = val;
		obj.focus();
		return;
	}
}

//해당 객체의 값을 비움
function goClear(obj)
{
	obj.value = "";
	obj.focus();
}

//float 형(type)인지를 검사...
function IsFloat(val)
{
	//float형이면 true 아니면 false를 리턴
	if (String(val).substring(0,1) == ".")
	{
		//alert("맨 앞자리는 숫자만이 올수 있습니다");
		return false;
	}
	else if ( String(val).substring(String(val).length-1,String(val).length) == "." )
	{
		//alert("맨 뒷자리는 숫자만이 올수 있습니다");
		return false;
	}
	else
	{
		var preStr = "0123456789.";
		var res = 0;
		var jumcnt = 0;

		for (var i=0;i<String(val).length;i++)
		{
			if ( String(val).charAt(i) == "." )
				jumcnt++;

			for (var j=0;j<String(preStr).length;j++)
			{
				if ( String(val).charAt(i) == String(preStr).charAt(j) )
					res++;
			}
		}
		if (parseInt(jumcnt)>1) //중간에 점을 두개찍는것을 방지..
			return false;
		else
			return ((res==String(val).length)?true:false);
	}
}

//영문자인지 숫자인지를 검사...
function IsAlphaNumeric(val)
{
	//숫자 또는 영문자(대소문자 포함)이면 true 아니면 false를 리턴
	var preStr = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY";
	var res = 0;

	for (var i=0;i<String(val).length;i++)
	{
		for (var j=0;j<String(preStr).length;j++)
		{
			if ( String(val).charAt(i) == String(preStr).charAt(j) )
				res++;
		}
	}
	return ((res==String(val).length)?true:false);
}

//폼객체가 오브젝트인지 즉 존재하는지.. 검사..
function IsObject(obj)
//존재하면 true 아니면 false를 리턴
{
	return ((typeof(obj)=="object")?true:false);
}

//문자열 앞뒤 공백 제거...
function trim(str)
{
	return str.replace(/(^\s+)|(\s+$)/g,'');
}

//공백문자 체크
function check_space(str)
{	
	if (str.search(/\S/)<0)
	{
		return false;
	}
	var temp=str.replace(' ','');
	if (temp.length == 0)
	{
		return false;
	}
	return true;
}

//체크박스 ,(콤마) 로 묶기
function GlueCommaObject(form,obj)
{
	var str = "";
	if (obj.length>0)	
	{
		for (var i=0;i<obj.length;i++)
		{
			if (obj[i].checked)
			{
				if (str=="")
				{
					str = obj[i].value;
				}
				else
				{
					str = str + "," + obj[i].value;
				}
			}
		}
	}
	else
	{
		str = obj.value;
	}

	return str;
}


//배열폼값 ,(콤마) 로 묶기
function glue(obj,glueVal)
{
	var str = "";
	if (obj.length>0)	
	{
		for (var i=0;i<obj.length;i++)
		{
			if (trim(obj[i].value)!="")
			{
				if (str=="")
				{
					str = trim(obj[i].value);
				}
				else
				{
					str = str + glueVal + trim(obj[i].value);
				}
			}
		}
	}
	else
	{
		str = trim(obj.value);
	}

	return str;
}

//체크박스 리스트 체킹 검사.. 
function CheckTheCheckBoxList(form,obj)
{
	var _chk = 0;
	if (obj.length>0)
	{
		for(var i=0;i<obj.length;i++)
		{
			if (obj[i].checked)
				_chk++;
		}
	}
	else
	{
		if (obj.checked)
			_chk++;
	}
	if (_chk==0) return 0; //no select
	if (_chk==1) return _chk; //only one select...
	if (_chk>1) return 2; //one more select
}

//체크박스 클리어
function ClearTheCheckBoxList(obj)
{
	if (obj.length>0)
	{
		for (var i=0;i<obj.length;i++)
			obj[i].checked = false;
	}
	else
	{
		obj.checked = false;
	}
}

//check box 모두 선택/헤제..
//val이 true이면 선택 false이면 해제
function SelectAll(obj,val)
{
	if (!IsObject(obj))
	{
		alert("해당항목이 없습니다");
		return;
	}
	else
	{
		if (obj.length>1)
		{
			for (var i=0;i<obj.length;i++)
			{
				obj[i].checked = val;
			}
		}
		else
		{
			obj.checked = val;
		}
	}
}

//셀렉트 박스에서 CELL 제거...
function SelectRemove(obj)
{
	for (var i=0;i<obj.length;i++)
	{
		obj.options.remove(0);
	}
}

//텍스트 박스에 글 쓸때 글자수 제안하기...
function countit(form,obj,size)
{ 
	var _objLen = obj.value.length;
	if (_objLen >= size)
	{
		alert(size+"자 이상 쓸수 없습니다");
		obj.value = obj.value.substring(0,size-2);
		obj.focus();
		return;
	}
	else
	{
		form._chr_cnt.value = obj.value.length;
	}
	
} 

//윈도우 새창 화면 가운데에 띄우기
function NewWindowOpen(objWinName,winName,url,vWidth,vHeight,vScroll,vSize,vState,vPoint)
{
	if(vPoint == 1){
		x = 0;
		y = 0;
	}
	else if(vPoint == 2){
		x = screen.width/2 - vWidth/2 ;
		y = (screen.height/2 - vHeight/2)-50; 
	}
	else{
		x = screen.width - vWidth;
		y = 0;
	}
	
	if(vScroll == 1){
		vScroll = "yes";
	}
	else{
		vScroll = "no";
	}
	if(vSize == 1){
		vSize = "yes";
	}
	else{
		vSize = "no";
	}
	if(vState == 1){
		vState = "yes";
	}
	else{
		vState = "no";
	}
	objWinName = window.open(url,winName,"width=" + vWidth + ",height="+vHeight+",top="+y+",left="+x+",status="+vState+",scrollbars="+vScroll+",resizable="+vSize);
	objWinName.focus();
}

// min과 max사이의 값인지를 검사...
function checkLength(obj, min, max, nullable)
{
	if (!nullable) 
	{
		len = obj.value.length;
		if (len < min || len > max)
			return false;
	}
	return true;
}

//한글인지 검사...
function withHangul(str)
//한글이면 true를 아니면 false를 리턴
{
	var refCode = 0;
	
	for(i = 0 ; i < str.length ; i++)
	{
		var code = str.charCodeAt(i);
		var ch = str.substr(i,1).toUpperCase()

		code = parseInt(code);

		if ( (ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255 || code < 0 )) )
		{
			return true;	
		}
	}

	return false;
}

//메일 주소 검사...
function isValidEmail(val) 
//올바른 메일이면 true 아니면 false를 리턴
{
    var valid = false;
    if(withHangul(val))
    { 
       //alert("EMAIL에 한글은 사용하실수 없습니다");
       return false;
    }else 
    {
       valid = true;       
    }
       
    // space within email?
    if (val.indexOf(" ") != -1)
	{
        //alert("Email주소에 공백은 허용되지 않습니다");
		return false;
	}
    else if (val.indexOf("@") < 1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '@'이 누락되었습니다");
		return false;
	}
    else if (val.indexOf(".") == -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '.'이 누락되었습니다");
		return false;
	}
    else if (val.indexOf("..") != -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '..'은 입력되어질수 없습니다");
		return false;
	}
    else if (val.indexOf(",") != -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. ','은 입력되어질수 없습니다");
		return false;
	}
    else if (val.indexOf("'") != -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '''은 입력되어질수 없습니다");
		return false;
	}
    else if (val.indexOf("@.") != -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '@' 다음에 바로 '.'이 올수 없습니다");
		return false;
	}
    else if (val.indexOf(".@") != -1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '@' 이전에는 '.'이 올수 없습니다");
		return false;
	}
    else if (val.indexOf(".") - val.indexOf("@") == 1)
	{
        //alert("Email주소 지정이 잘못되었습니다. '@' 다음에 바로 '.'이 올수 없습니다");
		return false;
	}
    else if (val.charAt(val.length-1) == '.')
	{
        //alert("Email주소 지정이 잘못되었습니다. '.'은 Email주소 끝에 올수 없습니다");
		return false;
	}
    else
        return true;
} 


//주민번호체크////
function IsJumin(str1,str2)
//올바른 메일 주소이면 1을 아니면 다른숫자(함수내 참조)를 리턴
{
	if(str1.length != 6)
		return -1;
	else if(isNaN(str1) )
		return -2;
	else if(str2.length != 7)
		return -3;
	else if(isNaN(str2))
		return -4;
	else if(parseInt(str2.substr(0,1)) != 1 && parseInt(str2.substr(0,1)) != 2 && parseInt(str2.substr(0,1)) != 3 && parseInt(str2.substr(0,1)) != 4)
		return -5;
	else
	{
		var total=0;
		var namuji=0;
		var key="234567892345";
		num=String(str1)+String(str2);
	 
		for (i=0 ; i<=11 ; i=i+1)
			total=parseInt(total) + parseInt(num.charAt(i)) * parseInt(key.charAt(i))

    namuji=eval(total % 11)
    
		if (namuji==0)
			namuji=10;
		 
		if(namuji==1)
			namuji=11;

		total=eval(11-namuji);
	 
		if (total!=num.charAt(12))
			return -6;
		else
			return 1;
	}
}

// 사업자등록번호 체크
function IsBusinessNumber(vencod) 
{
        var sum = 0;
        var getlist =new Array(10);
        var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
        
        for (var i=0; i<10; i++)
        { 
        	getlist[i] = vencod.substring(i, i+1); 
        }
        for (var i=0; i<9; i++)
        { 
        	sum += getlist[i]*chkvalue[i]; 
        }
        
        sum = sum + parseInt((getlist[8]*5)/10);
        sidliy = sum % 10;
        sidchk = 0;
        
        if (sidliy != 0) 
        	sidchk = 10 - sidliy; 
        else 
        	sidchk = 0; 
        
        if(sidchk != getlist[9]) 
        	return false; 
        
        return true;
}

// 재외국인 번호 체크
function IsForeigner(fgnno)
{
        var sum=0;
        var odd=0;
        buf = new Array(13);
        
        for (i=0; i<13; i++) 
        { 
        	buf[i]=parseInt(fgnno.charAt(i)); 
        }
        
        odd = buf[7]*10 + buf[8];
        
        if (odd%2 != 0) 
        	return false; 
        
        if ( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) 
              return false;

        multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
        
        for (i=0, sum=0; i<12; i++)
        	sum += (buf[i] *= multipliers[i]);
        	
        sum = 11 - (sum%11);
        
        if (sum >= 10)
        	sum -= 10;
        	
        sum += 2;
        
        if (sum >= 10)
        	sum -= 10;
        	
        if (sum != buf[12])
        	return false;
        	
        return true;
}

//간단한 문자열을 alert하고, 수행을 중단하는 함수
function die(str)
{
	alert(str);
	return;
}


//특정 문자를 제거해 주는 함수
function charTerminate(str,chr)
{
	var returnStr = "";
	for(var i=0;i<trim(str).length;i++)
	{
		if (str.charAt(i)!=chr)
			returnStr = returnStr + str.charAt(i);
	}
	return returnStr;
}


//업로드 가능한 확장자
function isUploadFile(filename)
{
	var fileExt = new Array('zip','rar','hwp','doc','rtf','xls','ppt','jpeg','jpe','jpg','gif','JPEG','JPE','JPG','GIF'); //가능한 확장자
	var curfileExt = "";
	var extCorrect = false;

	if (String(filename).length>0)
	{
		curfileExt = String(filename).split('.')[String(filename).split('.').length-1];
		for (var i=0;i<fileExt.length;i++)
		{
			if (fileExt[i]==curfileExt)
			{
				extCorrect=true;
			}
		}
	}
	else
	{
		extCorrect=true; //없어도 되므로, 없을시는 true를 리턴
	}
	return extCorrect;
}



//이미지 확장자 검색////
function isCorrectImage(imgVal)
{
	var fileExt = new Array('jpeg','jpe','jpg','gif','JPEG','JPE','JPG','GIF','png','PNG'); //가능한 이미지 확장자
	var curfileExt = "";
	var extCorrect = false;

	if (String(imgVal).length>0)
	{
		curfileExt = String(imgVal).split('.')[String(imgVal).split('.').length-1];
		//alert(curfileExt);
		for (var i=0;i<fileExt.length;i++)
		{
			if (fileExt[i]==curfileExt)
			{
				extCorrect=true;
			}
		}
	}
	else
	{
		extCorrect=true; //이미지는 없어도 되므로, 없을시는 true를 리턴
	}
	return extCorrect;
}

//등록 불가능한 확장자들
function isDenyExt(imgVal)
{
	var fileExt = new Array('exe','com','bat','dll','sys','EXE','COM','BAT','DLL','SYS'); //가능한 이미지 확장자
	var curfileExt = "";
	var extCorrect = false;

	if (String(imgVal).length>0)
	{
		curfileExt = String(imgVal).split('.')[String(imgVal).split('.').length-1];
		for (var i=0;i<fileExt.length;i++)
		{
			if (fileExt[i]==curfileExt)
			{
				extCorrect=true;
			}
		}
	}
	else
	{
		extCorrect=true; //이미지는 없어도 되므로, 없을시는 true를 리턴
	}
	return extCorrect;
}

function mEmGET(arrayKey, arrayValue, Value) { 
    count = arrayKey.length; 
    for(i=0;i<count;i++) { 
        if(arrayKey[i]==Value) { 
            return arrayValue[i]; 
            break; 
        } 
    } 
} 
// ie ativeX 출력 변경 함수 
function mEmbed() { 
var emtype; 
    var key = new Array(); 
    var value = new Array(); 
  // error_check=0; 
    for(i=0;i<mEmbed.arguments.length;i++) { 
        data = mEmbed.arguments[i].split('='); 
        key[i] = data[0]; 
        value[i] = data[1]; 
    } 

    contents = ''; 
srcdata = mEmGET(key,value,'src').toLowerCase(); 

    classid = mEmGET(key,value,'classid'); 
    codebase = mEmGET(key,value,'codebase'); 
    
if(/\.(swf)$/.test(srcdata)) { //flash 
        classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'; 
        codebase = 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.c-ab#version=6,0,29,0'; 
emtype="flash"; 
    } else if(/\.(wmv|wma|asf|avi|wav|asx|mpeg|mp3|midi|aiff|au|wpl|wm|wmx|wmd|wmz)$/.test(srcdata)){//media 
        classid = 'CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95'; 
        codebase = 'http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'; 
emtype="media"; 
} 
    if(classid && codebase) { 
        contents += '<object'; 
        if(classid) { 
            contents += ' classid="' + classid + '"'; 
        } 
        if(codebase) { 
            contents += ' codebase="' + codebase + '"'; 
        } 
        count = key.length; 
        for(i=0;i<count;i++) { 
            if(value[i]!='') { 
                if(key[i]!='src') { 
                    contents += ' ' + key[i] + '="' + value[i] + '"'; 
                } 
            } 
        } 
        contents += '>'; 
        for(i=0;i<count;i++) { 
            if(value[i]!='') { 
                if(emtype=='flash' && key[i]=='src') { 
                    contents += '<param name="movie" value="' + value[i] + '" />'; 
                } else  if(emtype=='media' && key[i]=='src') { 
                    contents += '<param name="filename" value="' + value[i] + '" />'; 
                } else { 
                    contents += '<param name="' + key[i] + '" value="' + value[i] + '" />'; 
                } 
            } 
        } 
    } 
    contents += '<embed'; 
    for(i=0;i<count;i++) { 
        if(value[i]!='') { 
            contents += ' ' + key[i] + '="' + value[i] + '"'; 
        } 
    } 
    contents += '>'; 
    contents += '</embed>'; 
    if(classid && codebase) { 
        contents += '</object>'; 
    } 
    document.write(contents); 
//return contents; 
} 
//사용법 <script language="javascript">mEmbed('src=/images/flash/main/scroll_menu.swf','width=302','height=71','quality=high','wmode=parent');</script>



function setEmbed() 
{ 
  var obj = new String; 
  var parameter = new String; 
  var embed = new String; 
  var html = new String; 
  var allParameter = new String; 
  var clsid = new String; 
  var codebase = new String; 
  var pluginspace = new String; 
  var embedType = new String; 
  var src = new String; 
  var width = new String; 
  var height = new String; 

    
  this.init = function( getType , s ,w , h ) { 
      
      if ( getType == "flash") 
      { 

        clsid = "D27CDB6E-AE6D-11cf-96B8-444553540000";        
        codebase = "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"; 
        pluginspage = "http://www.macromedia.com/go/getflashplayer"; 
        embedType = "application/x-shockwave-flash"; 
      } 
      /* type 추가 
      else if ( ) 
      { 
      } 
      */ 
            
      parameter += "<param name='movie' value='"+ s + "'>\n";  
      parameter += "<param name='quality' value='high'>\n";    
      
      src = s; 
      width = w; 
      height = h; 
  } 
  
  this.parameter = function( parm , value ) {      
      parameter += "<param name='"+parm +"' value='"+ value + "'>\n";        
      allParameter += " "+parm + "='"+ value+"'"; 
  }  
  
  this.show = function() { 
      if ( clsid ) 
      { 
        obj = "<object classid=\"clsid:"+ clsid +"\" codebase=\""+ codebase +"\" width='"+ width +"' height='"+ height +"'>\n"; 
      } 
      
      embed = "<embed src='" + src + "' pluginspage='"+ pluginspage + "' type='"+ embedType + "' width='"+ width + "' height='"+ height +"'"+ allParameter +" ></embed>\n"; 
      
      if ( obj ) 
      { 
        embed += "</object>\n"; 
      } 
      
      html = obj + parameter + embed; 
      
      document.write( html );  
  } 
  
}  
/*
======================= 
사용예 


<script  type="text/javascript"> 
setem = new setEmbed(); 
setem.init('flash','/fla/main_menu.swf','100%','80'); 
setem.parameter('wmode','transparent'); 
setem.parameter('FlashVars','main=<?=$_PAGE[MENU]?>'); 
setem.show(); 
</script> 

====================== 

*/





function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}



function setCookie( name, value, expiredays )
{
        var todayDate = new Date();
        todayDate.setDate( todayDate.getDate() + expiredays );
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie(name)
{
	var Found = false
	var start, end
	var i = 0

   while(i <= document.cookie.length) {
		 start = i
		 end = start + name.length
		 if(document.cookie.substring(start, end) == name) {
			 Found = true
			break
		 }
		 i++
   }

	if(Found == true) {
		start = end + 1
		end = document.cookie.indexOf(";", start)
		if(end < start)
			end = document.cookie.length
		return document.cookie.substring(start, end)
	}
	return ""
}


//아이프레임 사이즈 자동 조정하기
function resizeFrame(name)
{
  var oBody = document.body;
  var oFrame = parent.document.all(name);
  var min_height = 0;
  var min_width = 0; 
  
  var i_height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
  var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);
  
  if(i_height < min_height) i_height = min_height;
  if(i_width < min_width) i_width = min_width;
  oFrame.style.height = i_height;
  //oFrame.style.width = i_width;
}
//사용예
// window.onload = new Function("resizeFrame('frame_board');");


function getRadioValue(obj)
{
	var res = '';

	for (var i=0;i<obj.length;i++)
	{
		if (obj[i].checked)
		{
			res = obj[i].value;
		}
	}

	return res;
}

/*
function setObjBgBlink(obj, color1, color2, timeout)
{
	var c1 = color1;
	var c2 = color2;

	if (trim(c1)=='')
	{
		c1 = 'red';
	}
	if (trim(c2)=='')
	{
		c2 = 'white';
	}
	
	if (obj.style.background==c1)
		obj.style.background = c2;
	else
		obj.style.background = c1;

	setTimeout("setObjBgBlink()",timeout);
}
*/



function GetTextLength(text){
	return text.length;
}
 
function GetTextByte(text){
	var length = 0;
	var ch;
	for (var i = 0; i < text.length; i++) {
		ch = escape(text.charAt(i));
		if ( ch.length == 1 ) {
			length++;
		}else if (ch.indexOf("%u") != -1) {
			length += 2;
		}else if (ch.indexOf("%") != -1) {
			length += ch.length/3;
		}
	}
	return length;
}



/** * string String::cut(int len) * 한글도 고려하여 길이 리턴 */ 
String.prototype.cut = function(len) {
var str = this;
var s = 0;
for (var i=0; i<str.length; i++) {
s += (str.charCodeAt(i) > 128) ? 2 : 1;
//if (s > len) return str.substring(0,i) + "...";
if (s > len) return str.substring(0,i);
} 
return str;
} 


/** * bool String::bytes(void) * 해당스트링의 바이트단위 길이를 리턴 */
String.prototype.bytes = function() {
	var str = this; 
	var s = 0;
	for (var i=0; i<str.length; i++) s += (str.charCodeAt(i) > 128) ? 2 : 1;
	return s; 
} 

/***
// 사용 방법 text = "나는 대한민국 국민이다. 우리나라 만세";
alert(text.cut(5));
alert("length: " + text.length + " : bytes : " + text.bytes());
if (text.bytes() > 5) {
	alert("내용이 너무 깁니다");
} else {
	alert(bbb.bytes()); 
}
***/





/* 
 * 
 * 같은 값이 있는 열을 병합함
 * 
 * 사용법 : $('#테이블 ID').rowspan(0);
 * 
 */    
$.fn.rowspan = function(colIdx, isStats) {       
    return this.each(function(){      
        var that;     
        $('tr', this).each(function(row) {      
            $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
                 
                if ($(this).html() == $(that).html()
                    && (!isStats 
                            || isStats && $(this).prev().html() == $(that).prev().html()
                            )
                    ) {            
                    rowspan = $(that).attr("rowspan") || 1;
                    rowspan = Number(rowspan)+1;
 
                    $(that).attr("rowspan",rowspan);
                     
                    // do your action for the colspan cell here            
                    $(this).hide();
                     
                    //$(this).remove(); 
                    // do your action for the old cell here
                     
                } else {            
                    that = this;         
                }          
                 
                // set the that if not already set
                that = (that == null) ? this : that;      
            });     
        });    
    });  
}; 
 
 
/* 
 * 
 * 같은 값이 있는 행을 병합함
 * 
 * 사용법 : $('#테이블 ID').colspan (0);
 * 
 */  
$.fn.colspan = function(rowIdx) {
    return this.each(function(){
         
        var that;
        $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
            $(this).find('th').filter(':visible').each(function(col) {
                if ($(this).html() == $(that).html()) {
                    colspan = $(that).attr("colSpan") || 1;
                    colspan = Number(colspan)+1;
                    $(that).attr("colSpan",colspan);
                    $(this).hide(); // .remove();
                } else {
                    that = this;
                }
                 
                // set the that if not already set
                that = (that == null) ? this : that;
                 
            });
        });
    });
}


//========================================================================================================================
//version 2
/*
We have them already.

$.isNumeric
$.isArray
$.delay
$('input:radio[name=radiobuttonname]:checked').val()
$('input[name=checkboxname]:checkbox:checked').length;
$("input[name='checkboxname']:checkbox:checked").map(function () {return this.value;}).get();

.toLowerCase()
.toUpperCase()

모두 선택 예제
$("#chkall").click(function() { //select all
		$(".chkea").prop('checked', $(this).is(":checked"));
});

select 박스 선택값 얻기
$("#exp_date option:selected").val();

*/