var source;
var style;
var XSLt;
var ProcSetParam;
var maxLoadCount=600;

function loadCateXML(){
   var page=1;   
   source = new ActiveXObject("Msxml2.DOMDocument");
   style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
   XSLt=new ActiveXObject("Msxml2.XSLTemplate");
     
   source.async = false;
   style.async = false;
   source.resolveExternals = false;
   style.resolveExternals = false;
     
   var args=loadCateXML.arguments;
   var cgi="";   
   if(args.length>0)
   {    
    cgi="&basedn="+args[0];
   }         
   else{
    cgi="&basedn=root";
   }
         
   var vXSLName="view_LDAPlist.xsl";  
   if(xmlSource.indexOf("tenwa")!=-1){	
     var v_src="/tenwa/tree?type=p"+cgi;
   }
   else
   { 
     var v_src=xmlSource+"&uid="+args[0];
   }
   source.load(v_src);   
   style.load("/tenwa/xsl/"+vXSLName);
         
   if(style.parseError.errorCode != 0) {        
		showError();
   }
         
   XSLt.stylesheet = style;
   ProcSetParam = XSLt.createProcessor();
   ProcSetParam.input = source;    
   XSLSetCurrentPage(page);   
   XSLSetPageCount(15);         
   doTransform();
}	

function getResearchXML(){
   var page=1;   
   var vXSLName="view_LDAPlist.xsl";   
   
   source = new ActiveXObject("Msxml2.DOMDocument");
   style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
   XSLt=new ActiveXObject("Msxml2.XSLTemplate");
     
   source.async = false;
   style.async = false;
   source.resolveExternals = false;
   style.resolveExternals = false;
   
   var v_args=getResearchXML.arguments;
   var vKey=v_args.length>0?v_args[0]:"";        
   
   var v_src="/tenwa/tree?type=p&basedn=root&key="+vKey;   
   source.load(v_src);
  
   style.load(rootPath+"/xsl/"+vXSLName);   
   if(style.parseError.errorCode != 0){        
	showError();
   }   
   
   XSLt.stylesheet = style;
   ProcSetParam = XSLt.createProcessor();
   ProcSetParam.input = source;    
   XSLSetCurrentPage(page); 
   XSLSetPageCount(15);         
   doTransform();       
}	

function XSLSetCurrentPage(page){
   ProcSetParam.addParameter("currentPage",page); 
}

function XSLSetPageCount(count){
   ProcSetParam.addParameter("pageCount",count);
}


function NextPage(){
  var currentPage=document.all.currentPage.value;
  var totalPage=document.all.totalPage.value;
  var page=parseInt(currentPage)<parseInt(totalPage)?parseInt(currentPage)+1:totalPage;
  
 // reloadXML(page);  
  XSLSetCurrentPage(page);
  doTransform(); 
}

function PrePage(){
  var currentPage=document.all.currentPage.value;
  var page=currentPage>1?currentPage-1:1;
    
  //reloadXML(page); 
  XSLSetCurrentPage(page);
  doTransform(); 
}

function FirstPage(){
//  reloadXML(1);
  XSLSetCurrentPage(1);
  doTransform(); 
}

function LastPage(){
  var totalPage=document.all.totalPage.value;
  //reloadXML(totalPage);
  XSLSetCurrentPage(totalPage);
  doTransform();   
}

function TurnToPage(){
  var v_tag=event.srcElement;	
  var  page=v_tag.options[v_tag.selectedIndex].text;  
  //reloadXML(page); 
  XSLSetCurrentPage(page);  
  doTransform();   
}

function changePagecount(){
  var v_tag=event.srcElement;	
  var count=v_tag.options[v_tag.selectedIndex].text;   	
 
  document.all.pageCount.value=count;
  //??????
  var totalRecord=document.all.totalRecord.value!=""?document.all.totalRecord.value:"0"; 
  var totalPage=totalRecord%count!=0?parseInt(totalRecord/count)+1:parseInt(totalRecord/count);
  //????
  var page=document.all.currentPage.value>totalPage?totalPage:document.all.currentPage.value;  
  if (page!=document.all.currentPage.value){
   // reloadXML(page); 
    XSLSetCurrentPage(page);
   }
  XSLSetPageCount(count);
  doTransform();   
  
}

var preSortColumn="";
var sortOrder="ascending";
function sort(column){    	
  ProcSetParam.addParameter("sortColumn",column);
  if (preSortColumn==column)    
     sortOrder=sortOrder=="ascending"?"descending":"ascending";  
  ProcSetParam.addParameter("sortOrder",sortOrder);       
  doTransform();
  preSortColumn=column;
}

function doTransform() {	
	if (getReadyState()){
		ProcSetParam.transform();
		var sss=trim(ProcSetParam.output);		
		document.all("TableList").innerHTML =sss;
       }
}

function reloadXML(page){
  var currentPage=document.all.currentPage.value;  
  var pageCount=document.all.pageCount.value;
  //????????????
  var vRecord0=parseInt((currentPage*pageCount-1)/maxLoadCount);
  var vRecord1=parseInt((page*pageCount-1)/maxLoadCount);
  
  if (vRecord0!=vRecord1){
     start=vRecord1*maxLoadCount+1;         
    source.load(src);}
}

function getReadyState() {
	if (source.readyState == 4) {
		return true;
	}
	setTimeout("getReadyState()", 100);}

function showError() {
	var strError = new String;
	var err = source.parseError;
	strError = 'Error!\n' +
	'file url: '+err.url +' \n'+
	'line no.:'+err.line +'\n'+
	'char: '+ err.linepos + '\n' +
	'source: '+err.srcText+'\n'+
	'code: '+err.errorCode+'\n'+
	'description: '+err.reason+'\n';
	document.all.TableList.innerHTML = strError;
}
