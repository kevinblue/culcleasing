var rootPath=location.href.substring(location.href.indexOf(location.host)+location.host.length+1);
rootPath=rootPath.substring(0,rootPath.indexOf("/"));
var dictPath="/dict/dialog/";
var WpsRootPath="/dict";

function dict_popupDialog(field,parentName){ 
  var vUrl=WpsRootPath+"/servlet/tree?type=p&id="+parentName;
  tw_showPopupDialog(vUrl,field,"")
}

//列表框
function dict_list(field,parentName,currentValue,returnKey){
  var args=dict_list.arguments; 
  var t="p";
  var isNameFull =true;
  if(args.length>4){ t=args[4];}
  if(args.length>5){ isNameFull=args[5];}
  if(returnKey==null)returnKey="title";  
  if(!document.all[field]) return false; 
  document.all[field].dictid=parentName; 
  document.all[field].attachEvent("onchange",dict_onchange);
  var vUrl=WpsRootPath+"/servlet/tree?type="+t+"&id="+parentName;  
  var vXML =ajax_getReturnXML(vUrl); 
  ajax_getOption(field,currentValue,returnKey,vXML,isNameFull);
  
}  

//复选框
function dict_ckb(field,parentName,currentValue,returnKey){
	  var args=dict_ckb.arguments; 
	  var t="p";  
	  var isNameFull =true;
	  if(args.length>4){ t=args[4];} 
	  if(args.length>5){ isNameFull=args[5];}
	  
	  if(returnKey==null)returnKey="title"; 	 	
	  var vUrl=WpsRootPath+"/servlet/tree?type="+t+"&id="+parentName;  
	  var vXML =ajax_getReturnXML(vUrl); 
	  return ajax_getCheckbox(field,currentValue,returnKey,vXML,isNameFull);
	}

 //根据name返回字典表title
 function dict_getTitle(parentName,currentValue){
 	  var vUrl=WpsRootPath+"/servlet/tree?type=p&id="+parentName;  
	  var vXML =ajax_getReturnXML(vUrl);		  	  
	  var fn="";
	  if(currentValue.indexOf(".")==-1)fn=parentName+"."+currentValue;
	  var node=vXML.documentElement.selectSingleNode("node[@name='"+currentValue+"' or @name='"+fn+"']");	  
	  if(node!=null){
	  	 return node.getAttribute("title");
	  }	  
	  return currentValue;
 }

 //响应onchange,存储名称或者key
 function dict_onchange(){
 	 var src=event.srcElement;
 	 var o=src.options[src.selectedIndex];
 	 if(document.all[src.name+"name"])document.all[src.name+"name"].value=o.text;
 	 if(document.all[src.name+"id"])document.all[src.name+"id"].value=o.value;
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
function dict_SSelect(vKey,vType,vStart)
 {  	
  var args=dict_SSelect.arguments;
  var cgi="?type="+vType+"&id="+vStart;
  cgi+=args.length>3?("&ext="+args[3]):"";         	
  if (document.all[vKey]){
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

function dict_sort(pid){
  var vUrl=dictPath+"/tree_order.jsp?parentid="+pid;	
  return window.open(vUrl,"",fnGetWinStatus(400,400));
}	

 //Ajax返回代理值
 function ajax_getReturnXML(vUrl){
   var xmlhttp_ser = new ActiveXObject( "Microsoft.XMLHTTP");
   xmlhttp_ser.Open("POST",vUrl,false);
   xmlhttp_ser.Send();     
   return xmlhttp_ser.responseXML;
 }


 //添加列表项 
 function ajax_getOption(vKey,vValue,returnKey,vXML,isNameFull){
   if(!document.all[vKey]) return false;
   //清空
   var sel=document.all[vKey];
   sel.options.length=0;
   var elements=vXML.documentElement.childNodes;
   //添加空节点
   var ele=document.createElement("OPTION");       
   ele.text=ele.value="";
   sel.add(ele);
   var s=0,is=false;
   try{
   for(var i=0;i<elements.length;i++){
     var ele=document.createElement("OPTION");       
     ele.text=elements[i].getAttribute("title");
     ele.value=elements[i].getAttribute(returnKey);     
     if(ele.value.indexOf(".")!=-1 && !isNameFull)ele.value=ele.value.substring(ele.value.lastIndexOf(".")+1);     
     if(ele.value==vValue){s=i;is=true;}     
     sel.add(ele);	   	  
   } 
   if(is)sel.selectedIndex=s+1;else sel.selectedIndex=s;
  }catch(e){}
 }
 
 function ajax_getCheckbox(vKey,vValue,returnKey,vXML,isNameFull){	
	   var vHTML="";
	   var elements=vXML.documentElement.childNodes;
	   var vi=","+vValue+",";
	   for(var i=0;i<elements.length;i++){
	     var t=elements[i].getAttribute("title");
	     var n=elements[i].getAttribute(returnKey);	     
	     if(n.indexOf(".")!=-1 && !isNameFull){ n=n.substring(n.lastIndexOf(".")+1);}   
	     var c="";
	     var key =","+n+",";	      	     
	     if(vi.indexOf(key)!=-1){c="checked";}; 	        
	     vHTML+="<INPUT name='"+vKey+"' label='"+t+"' type='checkbox' value='"+n+"' "	+c +">"+t+"</input>";   	  
	   }   
	   return vHTML;
	 }
 
function fnGetWinStatus(x,y)
{
  var m=screen.availWidth/2-x/2;
  var n=screen.availHeight/2-y/2;
  var vArg=fnGetWinStatus.arguments;
  var vStyle=vArg.length>1?vArg[2]:"status=no,scrollbars=no,location=no,menubar=no,resizable=no";
  return 'left='+m.toString()+',top='+n.toString()+',width='+x.toString()+',height='+y.toString()+","+vStyle;
}

function fnGetModalDialogStatus(x,y)
{
	var vArg=fnGetModalDialogStatus.arguments;
	var vStyle="status:no;scroll:off;help:no";
	return 'dialogWidth:'+x.toString()+'px;dialogHeight:'+y.toString()+"px;"+vStyle;
}