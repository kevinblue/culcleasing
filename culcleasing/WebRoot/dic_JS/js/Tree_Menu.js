var TreeType="";
var source=null;
var TreeKeyItem="";
var style=null
var  ProcSetParam = null;
var currentNode=null;
if(WpsRootPath==null) var WpsRootPath="/tenwa";
function loadRootXML()
{       
      source = new ActiveXObject("Msxml2.DOMDocument");
      style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");      
      XSLt=new ActiveXObject("Msxml2.XSLTemplate"); 
      
      source.async = false;
      style.async = false;
      source.resolveExternals = false;
      style.resolveExternals = false;                            
            
     if (TreeStartNode && TreeStartNode!="")
       vStart=TreeStartNode;
     else
       vStart="root";   
                        
      var SourceUrl=WpsRootPath+"/servlet/tree?type=g&parentid="+vStart;     
	  source.load(SourceUrl);   
      style.load(WpsRootPath+"/xsl/TreeXSLForMenu.xsl");  
    
      XSLt.stylesheet = style;
      ProcSetParam = XSLt.createProcessor();     
      ProcSetParam.input = source;
      if (TreeKeyItem!="")
        ProcSetParam.addParameter("ext",TreeKeyItem);
        
      ProcSetParam.transform(); 
      var vHTML=trim(ProcSetParam.output);            
      return vHTML;
}

function loadNodeXML(vNodeSrc)
{    
   if(source==null || style==null){		     
      source = new ActiveXObject("Msxml2.DOMDocument");
      style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");            
      source.async = false;
      style.async = false;
      source.resolveExternals = false;
      style.resolveExternals = false;         
      style.load(WpsRootPath+"/xsl/TreeXSLForMenu.xsl");                          	
   }         
   
   var src=WpsRootPath+"/servlet/tree?type=g&id="+vNodeSrc;  	
   source.load(src);     
   if(ProcSetParam==null){
     var XSLt=new ActiveXObject("Msxml2.XSLTemplate");
     XSLt.stylesheet = style;
     var ProcSetParam = XSLt.createProcessor(); 
   }
   ProcSetParam.input = source;
   ProcSetParam.transform();   
   var vHTML=trim(ProcSetParam.output);  
   return vHTML;
}

function showlayer(which){
	var args=showlayer.arguments;
	var vNodeSrc=args.length>1?args[1]:which;	
	var vTag=event.srcElement;
   	var vTD=vTag;
   	while(vTD.tagName!="TD"){
   	  vTD=vTD.parentElement;}
   	
    var currentImg=vTD.children[0];   
    if(vTD.parentElement.children[1].children[0]){       	
       var tmp=vTD.parentElement.children[1].children[0];
       if(tmp.tagName=="IMG" && tmp.src.indexOf("folder")!=-1)	  
        var folderImg=tmp;       
    }     
    var currentTD=vTD.parentElement.nextSibling.children[1];    
    if (currentTD.style.display=="none")
     {              
        currentTD.style.display="block";    	
    	if (currentTD.innerHTML=="")currentTD.innerHTML=loadNodeXML(vNodeSrc);             	     	     	    	  	   	
        currentImg.src=currentImg.src.replace("plus","minus");
        if(folderImg)folderImg.src=folderImg.src.replace("der.gif","deropen.gif");
     }	
    else{     
    	currentTD.style.display="none";        
        currentImg.src=currentImg.src.replace("minus","plus");    
        if(folderImg)folderImg.src=folderImg.src.replace("deropen.gif","der.gif");
    }
}

function trim(which){
  var vKey=which.substr(0,1);
   while(vKey==" "){
     which=which.substr(1);  
     vKey=which.substr(0,1)}  
  
   vKey=which.substr(which.length-1,1);
   while (vKey==" "){
     which=which.substr(0,which.length-1);
     vKey=which.substr(which.length-1,1);}   
   
   return which;
}   

function getTreeType(vType){     
  if (vType.indexOf("p")!=-1) return "p";
  if (vType.indexOf("g")!=-1) return "g";
  return "g";	
}

function getExtItemName(){
  if (TreeKeyItem!=null){    
    return TreeKeyItem!=""?("&ext="+TreeKeyItem):"";    
  }     
  else
    return "";   	
}