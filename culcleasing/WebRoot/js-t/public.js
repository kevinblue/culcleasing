var menu_prelink=null;  
var g_UserLanguage = "0";
var WpsRootPath="/tenwa";	
var dictPath="/dict/dialog/";

//通用的窗口定义函数
function fnGetWinStatus(x,y)
{
  var m=screen.availWidth/2-x/2;
  var n=screen.availHeight/2-y/2;
  var vArg=fnGetWinStatus.arguments;
  var vStyle=vArg.length>1?vArg[2]:"status=no,scrollbars=no,location=no,menubar=no,resizable=no";
 return 'left='+m.toString()+',top='+n.toString()+',width='+x.toString()+',height='+y.toString()+","+vStyle;
}

//通用模态对话框定义函数
function fnGetModalDialogStatus(x,y)
{
	var ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
	y=ver!=7?(y+32):y;	
	var vArg=fnGetModalDialogStatus.arguments;	
	var vStyle="status:no;scroll:off;help:no;resizeable:yes;location:no";	
	return 'dialogWidth:'+x.toString()+'px;dialogHeight:'+y.toString()+"px;"+vStyle;
}

//通用LDAP 组织结构多选,
function fn_MSelect(vKey,vType)
{  	
  var args=fn_MSelect.arguments;  
  var cgi="?type="+vType;
  cgi+=args.length>2?("&start="+args[2]):"";      	
  if (document.all(vKey)){  	  
  	 window.open("/tenwa/dialog/tree_MSelect.jsp"+cgi,vKey,fnGetWinStatus(700,520));
  } 
  else    	
     { alert("无目标域!");return false }
} 

//通用 LDAP 单选
function fn_SSelect(vKey,vType)
 {  	
  var args=fn_SSelect.arguments;
  var cgi="?type="+vType;
  cgi+=args.length>2?("&start="+args[2]):"";       	
  if (document.all(vKey)){
     var vUrl="/tenwa/dialog/tree_SSelect.jsp"+cgi;	 
     window.open(vUrl,vKey,fnGetWinStatus(400,400));
  } 
  else    	
     { alert("无目标域!");return false }
} 

//通用_Notes names 多选: 参数说明
function notes_MSelect(returnField,orgType,notesAddPath)
 {  	
  var args=notes_MSelect.arguments;  
  var cgi="?type="+orgType+"&path="+notesAddPath;
  cgi+=args.length>3?("&start="+args[3]):"";      	
  if (document.all(returnField)){  	  
     window.open("/tenwa/dialog/notes/notes_MSelect.jsp"+cgi,returnField,fnGetWinStatus(700,520));
  } 
  else    	
     { alert("无目标域!");return false }
} 

//通用Notes names单选: 
function notes_SSelect(vKey,vType,vPath)
 {  	
  var args=notes_SSelect.arguments;
  var cgi="?type="+vType+"&path="+vPath;
  cgi+=args.length>3?("&start="+args[3]):"";       	
  if (document.all(vKey)){
     var vUrl="/tenwa/dialog/notes/notes_SSelect.jsp"+cgi;	 
     window.open(vUrl,vKey,fnGetWinStatus(400,400));
  } 
  else    	
     { alert("无目标域!");return false }
} 

//通用字典选择 - 多选
function dict_MSelect(vKey,vType,vStart)
 {  
  var args=dict_MSelect.arguments;  
  var cgi="?type="+vType+"&id="+vStart;
  cgi+=args.length>3?("&ext="+args[3]):"";      	
  if (document.all[vKey]){  	  
  	 window.open(dictPath+"dict_MSelect.jsp"+cgi,vKey,fnGetWinStatus(700,520));
  } 
  else    	
     { alert("无目标域!");return false }
} 

//通用字典选择 - 模态多选
function dict_MSelectModal(vType,vStart)
 {  
  var args=dict_MSelectModal.arguments;  
  var cgi="?type="+vType+"&id="+vStart;
  cgi+=args.length>2?("&exe="+args[2]):"";        	  
  return window.showModalDialog(dictPath+"dict_MSelectModal.jsp"+cgi,"",fnGetModalDialogStatus(700,520)); 
} 

//通用字典选择 - 单选
function dict_SSelect(vKey,vType, vStart,vContext)
 {  
  var args=dict_SSelect.arguments;
  var cgi="?type="+vType+"&id="+vStart;
  cgi+=args.length>3?("&ext="+args[3]):"";
  if (document.all[vKey]){
 	 if(vContext == "multiLanguage"){
	 	dictPath = "/multiLanguage/dialog/";
		if(args.length>4)
			cgi = cgi+"&multiType="+args[4];
	 }
	 var vUrl=dictPath+"dict_SSelect.jsp"+cgi;	
     window.open(vUrl,vKey,fnGetWinStatus(400,400));
  } 
  else    	
    { alert("无目标域!");return false }
} 
 
//通用字典选择 - 模态单选
function dict_SSelectModal(vType,vStart)
 {  	
  var args=dict_SSelectModal.arguments; 
  var cgi="?type="+vType+"&id="+vStart;
  cgi+=args.length>2?("&ext="+args[3]):"";       	
  var vUrl=dictPath+"dict_SSelectModal.jsp"+cgi;	 
  return window.showModalDialog(vUrl,"",fnGetModalDialogStatus(400,440)); 
} 

function dict_showMenu(pid,type){
   WpsRootPath="/dict";
   if(type==null)type="g";
   var vXMLUrl="/dict/servlet/tree?type="+type+"&id="+pid;    	   
   var vXSL="/dict/xsl/TreeXSLForMenu.xsl";
   var vList=new Array("userLanguage=0");    	
   return fn_transXMLT(vXMLUrl,vXSL,vList);	 
}	

function openMaxWindow(strURL,winName,strFeatures){
	var win = open(strURL,winName,strFeatures);
	win.moveTo(0,0);
	win.resizeTo(screen.availWidth,screen.availHeight);
}

function checkEmpty(vKey,vMsg){	
if (document.all(vKey))
   var vValue=document.all(vKey).value;
else 
   {
   alert ((g_UserLanguage=="1")?"The Field " + vKey +" doesn't exist!":"不存在的域:"+vKey);
   return false;
   }
      
if (trim(vValue)==""){
	alert((g_UserLanguage=="1")?vMsg +" must be filled in!":vMsg+ "必须填写并且不能为空格！");        
	return false;	 
 }
 return true;   
}

function trim(which){
  if(!which) return which;    
  return which.toString().replace(/(^\s*)|(\s*$)/g, "");
} 
  
//获得cookie
function getCookieVal (offset) {
 var endstr = document.cookie.indexOf (";", offset);
 if (endstr == -1)
 endstr = document.cookie.length;
 return unescape(document.cookie.substring(offset, endstr));
}

function GetCgiValue(vKey){
  var vCgi="&"+vKey+"=";  
  var vTmp=location.href.substring(location.href.indexOf(vCgi)+vCgi.length,location.href.length);
  return  vTmp.substring(0,vTmp.indexOf("&")!=-1?vTmp.indexOf("&"):vTmp.length)  
}

function GetCookie (name) {
var arg = name + "=";
var alen = arg.length;
var clen = document.cookie.length;
var i = 0;
while (i < clen) {
var j = i + alen;
if (document.cookie.substring(i, j) == arg)
return getCookieVal (j);
i = document.cookie.indexOf(" ", i) + 1;
if (i == 0) break; 
}
return null;
}  

//设置cookie
function SetCookie (name, value) {
var expdate = new Date ();
expdate.setTime (expdate.getTime() + (24 * 60 * 60 * 1000 * 31));

var argv = SetCookie.arguments;
var argc = SetCookie.arguments.length;
var expires = (argc > 2) ? argv[2] : null;
var path = (argc > 3) ? argv[3] : null;
var domain = (argc > 4) ? argv[4] : null;
var secure = (argc > 5) ? argv[5] : false;
document.cookie = name + "=" + escape (value) +
"; expires=" + expdate.toGMTString() +
((path == null) ? "" : ("; path=" + path)) +
((domain == null) ? "" : ("; domain=" + domain)) +
((secure == true) ? "; secure" : "");
}

var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var base64DecodeChars = new Array(
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
    -1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
    -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);
    
function base64encode(str) {
    var out, i, len;
    var c1, c2, c3;

    len = str.length;
    i = 0;
    out = "";
    while(i < len) {
 c1 = str.charCodeAt(i++) & 0xff;
 if(i == len)
 {
     out += base64EncodeChars.charAt(c1 >> 2);
     out += base64EncodeChars.charAt((c1 & 0x3) << 4);
     out += "==";
     break;
 }
 c2 = str.charCodeAt(i++);
 if(i == len)
 {
     out += base64EncodeChars.charAt(c1 >> 2);
     out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
     out += base64EncodeChars.charAt((c2 & 0xF) << 2);
     out += "=";
     break;
 }
 c3 = str.charCodeAt(i++);
 out += base64EncodeChars.charAt(c1 >> 2);
 out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
 out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6));
 out += base64EncodeChars.charAt(c3 & 0x3F);
    }
    return out;
}

function base64decode(str) {
    var c1, c2, c3, c4;
    var i, len, out;

    len = str.length;
    i = 0;
    out = "";
    while(i < len) {
 /* c1 */
 do {
     c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
 } while(i < len && c1 == -1);
 if(c1 == -1)
     break;

 /* c2 */
 do {
     c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
 } while(i < len && c2 == -1);
 if(c2 == -1)
     break;

 out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));

 /* c3 */
 do {
     c3 = str.charCodeAt(i++) & 0xff;
     if(c3 == 61)
  return out;
     c3 = base64DecodeChars[c3];
 } while(i < len && c3 == -1);
 if(c3 == -1)
     break;

 out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2));

 /* c4 */
 do {
     c4 = str.charCodeAt(i++) & 0xff;
     if(c4 == 61)
  return out;
     c4 = base64DecodeChars[c4];
 } while(i < len && c4 == -1);
 if(c4 == -1)
     break;
 out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
    }
    return out;
}

function hexString (num, wid)
{
   var str = "";
   var digit = 0;
   var hexDigits = "0123456789ABCDEF";

   while (num > 0)
   {
      digit = num % 16;
      str = hexDigits.charAt(digit) + str;
      num >>= 4;
   }

   while (str.length < wid)
      str = "0" + str;

   return str;
}

function convToUtf8 (unival)
{
   var utf8 = "";

   if (unival <= 0x7f)
   {
	if( unival == 0x20 ) {
		utf8 = "+";
	}
	else if( (unival >=0x30 && unival <=0x39) || (unival >= 0x41 && unival <= 0x5a) || (unival >= 0x61 && unival <= 0x7a ) ) {
		utf8 = String.fromCharCode(unival);
	}
	else {
		utf8 = "%" + hexString( unival, 2 );
	}
   }

   else if (unival <= 0x07FF)
   {
       utf8 = "%" + hexString(0xC0 + (unival >> 6), 2);
       utf8 += "%" + hexString(0x80 + (unival & 0x3F), 2);
   }

   else if (unival <= 0xFFFF)
   {
       utf8 = "%" + hexString(0xE0 + (unival >> 12), 2);
       utf8 += "%" + hexString(0x80 + ((unival >> 6) & 0x3F), 2);
       utf8 += "%" + hexString(0x80 + (unival & 0x3F), 2);
   }

   else if (unival <= 0x10FFFF)
   {
       utf8 = "%" + hexString(0xF0 + (unival >> 18), 2);
       utf8 += "%" + hexString(0x80 + ((unival >> 12) & 0x3F), 2);
       utf8 += "%" + hexString(0x80 + ((unival >> 6) & 0x3F), 2);
       utf8 += "%" + hexString(0x80 + (unival & 0x3F), 2);
   }

   return utf8;
}  

function URLEncoder( sstr ) 
{
	var dstr = "";
	var value = 0;
	if ((sstr != null) && (sstr != ""))
	{
		for( i = 0; i < sstr.length; i++ )
		{
			value = sstr.charCodeAt(i);
			dstr += convToUtf8( value );
		}
	}
	return dstr;
}

 
 //通用XML/XSl转化
 function fn_transXML(vXMLUrl,vXSL){
   var _source = new ActiveXObject("Msxml2.DOMDocument");
   var style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");      
   _source.async = false;
   style.async = false;
   _source.resolveExternals = false;
   style.resolveExternals = false;
   
   if(vXMLUrl.xml) _source = vXMLUrl;
   else if(vXMLUrl.indexOf("<?xml")!=-1)      
     _source.loadXML(vXMLUrl);	
   else
     _source.load(vXMLUrl);
   
   if (vXSL.indexOf("/")!=-1)
    style.load(vXSL);
   else
    style.load("/WebOA/xsl/"+vXSL);	
    
   if(_source.xml!="") 
    return _source.transformNode(style);   
   else
    return "<div style='margin:4px,6px'>暂无内容</div>";   
 } 

//通用XML/XSlT转化
 var transxmlObject=null;
 var transObject=function(_source,style,param)
 {
  this.source=_source;	  
  this.style=style; 
  this.param=param;
 } 
 
 function fn_transXMLT(vXMLUrl,vXSL,vList){	
   var _source = new ActiveXObject("Msxml2.DOMDocument");
   var style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
   var XSLt=new ActiveXObject("Msxml2.XSLTemplate");
   _source.async = false;
   style.async = false;
   _source.resolveExternals = false;
   style.resolveExternals = false;
      
   if(vXMLUrl.xml) _source = vXMLUrl;
   else if(vXMLUrl.indexOf("<?xml")!=-1){
      _source.loadXML(vXMLUrl);	
   }
   else	
      _source.load(vXMLUrl);         
//  var a=window.open("");a.document.body.innerText=_source.xml;
   if (vXSL.indexOf("/")!=-1)
    style.load(vXSL);
   else
    style.load("/tenwa/xsl/"+vXSL);
       
   if(_source.xml!=""){ 
     XSLt.stylesheet = style;
     var Proc = XSLt.createProcessor(); 
     Proc.input = _source; 
     for (var i=0;i<vList.length;i++){	
       var paramName=vList[i].substring(0,vList[i].indexOf("="));
       var paramValue=vList[i].substring(vList[i].indexOf("=")+1);
       Proc.addParameter(paramName,paramValue);
     }
     transxmlObject=new transObject(_source,vXSL,vList);     
     Proc.transform();
     var vHTML=Proc.output;         
     return vHTML;  
   }      
   else
    return "<div style='margin:4px,6px'>暂无内容</div>";       
 } 

 function fn_transSearch(){
  if(!document.all.XMLSearch)return false; 
  var vKey=document.all.XMLSearch.value;
  if(vKey=="") return false;
  if(transxmlObject==null) return false;  
  var _source=transxmlObject.source;
  _source.setProperty("SelectionLanguage","XPath");
  var Nodes=_source.documentElement.selectNodes("viewentry/entrydata[contains(text,'"+vKey+"')]");   
  var newSource= new ActiveXObject("Msxml2.DOMDocument");  
  newSource.async = false;
  newSource.resolveExternals = false;
  newSource.loadXML("<root></root>");   
  for(var i=0;i<Nodes.length;i++){
    newSource.documentElement.appendChild(Nodes[i].parentNode); 
  }
  var preNodes=_source.documentElement.selectNodes("viewentry");
  preNodes.removeAll();
  var Nodes=newSource.documentElement.childNodes; 
  _source.documentElement.setAttribute("toplevelentries",Nodes.length);
  for(var j=0;j<Nodes.length;j++){ 
    var nodeTmp=Nodes[j].cloneNode(true);
    var node=_source.documentElement.appendChild(nodeTmp);  
    node.setAttribute("position",j+1); 
  } 
  return fn_transXMLT(_source,transxmlObject.style,transxmlObject.param);
}

//通用XML/XSlT转化 
 function fn_transXMLT_A(vXMLUrl,vXSL,vList,vTag){
   //异步提交	   
   var d=document.createElement("DIV");  
   d.innerHTML=reloadInfo; 
   d.style.float="left";
   var d1=vTag.appendChild(d);   
   var xa = new ActiveXObject( "Microsoft.XMLHTTP" );
   xa.Open("POST",vXMLUrl,true);
   xa.onreadystatechange=function(){return response_transXMLT(xa,vXSL,vList,d1)};
   xa.Send();    
 }   
 
 function response_transXMLT(http,vXSL,vList,vTag){  	
   if(http.readyState==4){	   
     if(http.status==200){ 	
       var s = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
       var t=new ActiveXObject("Msxml2.XSLTemplate");
       s.async = false;
       s.resolveExternals = false;
       if (vXSL.indexOf("/")!=-1) s.load(vXSL);
       else s.load("/tenwa/xsl/"+vXSL);
       if(s.xml!=""){
       var x = http.responseXML;       
        t.stylesheet = s;   	
        var p = t.createProcessor();
        p.input = x;
        for (var i=0;i<vList.length;i++){	
         var pN=vList[i].substring(0,vList[i].indexOf("="));
         var pV=vList[i].substring(vList[i].indexOf("=")+1);
         p.addParameter(pN,pV);
        }
        p.transform();
        vTag.innerHTML=trim(p.output);
     }
     else{
       vTag.innerHTML="暂无内容!";
     }       
   } 
  } 
 }	
  
function getXmlHttp(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest){
		objXMLHttp = new XMLHttpRequest();}
	else if(window.ActiveXObject){
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");}
	return objXMLHttp;
}

  
 //返回代理HTML
 function ajax_getAgentReturnHTML(vUrl){
   var xmlhttp_ser = getXmlHttp();
   xmlhttp_ser.open("POST",vUrl,false);
   xmlhttp_ser.send();         
   return xmlhttp_ser.responseText;    
 }
 
 function ajax_getReturnText(vUrl){
   return ajax_getAgentReturnHTML(vUrl); 	
 }	 
 //Ajax返回XML
 function ajax_getReturnXML(vUrl){
   var xmlhttp_ser = getXmlHttp();
   xmlhttp_ser.open("POST",vUrl,false);
   xmlhttp_ser.send();     
   return xmlhttp_ser.responseXML;
 }


//为指定窗口添加script引用 
function pub_addScript(vSrc,where){  
   var tag_document=where=="window"?window.document:(where=="top"?window.top.document:element.document);      
   var new_script=document.createElement("SCRIPT");
   new_script.language="javascript";
   new_script.src=vSrc;
   tag_document.body.appendChild(new_script);
}

function hasScript(vSrc){
  var scripts=document.scripts;	 
  for(var i=0;i<scripts.length;i++){
    if(scripts[i].src && scripts[i].src.toLowerCase()==	vSrc.toLowerCase()) return true;
 }	
  return false;
}	

function pub_selectColor(){
	//选择颜色
	 var args = pub_selectColor.arguments;
	 var iniColor = args.length>0?args[0]:"";//初始颜色 	 
	 var iniType = args.length>1?args[1]:""; //颜色类型:rgb,空为16进制	 
	 if(iniType=="rgb"){	   	
	   var vTmp=iniColor.substring(iniColor.indexOf("(")+1,iniColor.indexOf(")")).split(",");
	   iniColor="";
	   for(var i=0;i<vTmp.length;i++){
	     var key = parseInt(vTmp[i]).toString(16);	 
	     iniColor+=key.length<2?("0"+key):key;	
	   }
	 }		 	 
	
	 if (!document.all.edit_helper){
	    var v_object = "<OBJECT ID=edit_helper CLASSID=\"clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b\" WIDTH=1 Height=1></OBJECT>";    
	    document.body.insertAdjacentHTML("afterEnd",v_object);   
	 }	
	    
	 var sColor = document.all.edit_helper.ChooseColorDlg(iniColor);        	   		
	 sColor = sColor.toString(16);	 	
	 if (sColor.length <6){
	    var sTempString ='000000'.substring(0,6-sColor.length);
	    sColor = sTempString.concat(sColor);
	 }
	 	 
	 if(iniType=="rgb"){
	   var rgb="";
	   for(var i=0;i<3;i++){	
	      rgb+=","+parseInt(sColor.substring(2*i,2*i+2),16).toString(10);	      
	   }  
	   sColor="RGB("+rgb.substr(1)+")";	 
	 }	 
	 return sColor;	
}

//通用的颜色选择函数 fn_selectColor(returnKey,[colorMode])   
function fn_selectColor(vKey){
   if(!document.getElementById(vKey)) return false;
   var args=fn_selectColor.arguments;      
   var vtype=args.length>1?args[1]:"";
   var tag=document.getElementById(vKey);
   var vColor=pub_selectColor(tag.value,vtype);
   tag.style.background=vColor;
   tag.value=vColor;
}

function contentMaxEdit(vKey){
   var src=$(vKey);
   if(!src) return false;
   if(src.type!="textarea" && src.type!="text") return false;     
   var vUrl = "/tenwa/dialog/maxEdit.htm";
   var preV = src.value;
   var arg= contentMaxEdit.arguments[1]?contentMaxEdit.arguments[1]:"";
   var size_x = arg=="max"?"600":(arg=="middle"?"450":"400");
   var size_y = arg=="max"?"450":(arg=="middle"?"320":"250");
   var res= showModalDialog(vUrl,src,fnGetModalDialogStatus(size_x,size_y)+";resizable:yes");    
   if(res!=null){ 
      src.value = res;    	     
      try{if(!checkValid(src)){src.value=preV;return false}}catch(E){};//交验函数     
   }    
 }

Date.prototype.parse=function(mode)
{
  var m=this.getMonth()+1;m=m<10?("0"+m):m;	
  var d=this.getDate();d=d<10?("0"+d):d;
  var h=this.getHours();h=h<10?("0"+h):h;
  var mm=this.getMinutes();mm=mm<10?("0"+mm):mm;
  var s=mode.replace("YYYY",this.getYear()).replace("MM",m).replace("DD",d).replace("HH",h).replace("MM",mm);	
  return s;	 
}
function hid(obj,v){if($(obj)!=null)$(obj).style.display = v?"none":"";} //按条件隐藏对象
function $(obj){return typeof(obj)=="string"?document.getElementById(obj):obj}
Array.prototype.contains=function(n){return (","+this.join(",")+",").indexOf(","+n+",")!=-1;}

var Class = {create: function(){return function(){this.initialize.apply(this, arguments);}}}
var jsonLocale=Class.create();
jsonLocale.prototype={
   base:"domino.public.share",
  lang:"zh-CN",  
  ini:true,  
  host:"",
  initialize:function(base,type,lang){		    
    this.base=base;
    if(type=="")type="2"; 
    this.type=type;
    if(lang!="")this.lang=lang; 
    else  lang=GetCookie("locale");   
    try{          
     var vUrl="/multiLanguage/loadPropAction.do?type="+type+"&path="+this.base+"&locale="+this.lang;     
     var json=this.send(vUrl);            
     json=json.replace(/{}/g,"");   
     this.localeString=json;     
     this.locale=eval("("+json+")");
     this.ini=true;           
    }
    catch(e){this.ini=false}    
  },
  $:function(key,d){    	
   return this.getLangByKey(key,d);	 
  },	
  getLangByKey:function(key,d){
    try{      
     var ss=eval("this.locale."+(this.type=="2"?key.toLowerCase():key));
     if(!ss) return d;
     return ss;
    }
    catch(e){return d;} 	    
  },
  send:function(vUrl){
    var xmlhttp_ser = new ActiveXObject( "Microsoft.XMLHTTP");
    xmlhttp_ser.Open("POST",vUrl,false);
    xmlhttp_ser.Send();         
    return xmlhttp_ser.responseText;
  }
} 

//调用多语言设置
function setMultiLanguage(parentId, key, label){  
  if(label==null){
    var tag=event.srcElement.parentElement.children[0]; 	
    label=tag.value;
  }
  var url="/multiLanguage/reference.do?method=init&open=outer&key="+key+"&parentId="+parentId+"&label="+encodeURI(label);
  window.showModelessDialog(url,null,fnGetModalDialogStatus(520,400));
}
