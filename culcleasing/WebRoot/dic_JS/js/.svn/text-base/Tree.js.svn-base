var tagCollection=new Array();
var vTotal=0;
var tagMoveStart=null;
var tagMoveEnd=null;
var TreeType="";
var source=null;
var style=null
var currentNode=null;

if(WpsRootPath==null) var WpsRootPath="/tenwa";

function loadRootXML()
{       
      source = new ActiveXObject("Msxml2.DOMDocument");
      style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");      
      
      source.async = false;
      style.async = false;
      source.resolveExternals = false;
      style.resolveExternals = false;                                  
      
     if (TreeStartNode && TreeStartNode!="")
       vStart=TreeStartNode;
     else
       vStart="root";   
            
      var SourceUrl=WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+"&id="+vStart;
    
      var args=loadRootXML.arguments;	
      if(args.length>0)
       if(args[0].indexOf("refreshcache=")!=-1){
         SourceUrl+="&"+args[0];
       }
                      
      source.load(SourceUrl);       
      style.load(WpsRootPath+"/xsl/TreeXSLForDialog.xsl");             
      var vBase="<span><img src='/tenwa/images/base.gif'style='margin-left:2;margin-right:4'>请选择..</span>"     
      var vHTML=source.transformNode(style);     
          
      document.all.treebody.innerHTML=vBase+vHTML;
}

function loadNodeXML(vNodeSrc){    
   if(source==null || style==null){		     
      source = new ActiveXObject("Msxml2.DOMDocument");
      style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");      
      
      source.async = false;
      style.async = false;
      source.resolveExternals = false;
      style.resolveExternals = false;         
      style.load(WpsRootPath+"/xsl/TreeXSLForDialog.xsl");                          	
   }         
   var src=WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+"&id="+vNodeSrc;    
   source.load(src);
            
   var vHTML=source.transformNode(style);  
   return vHTML;
}

function loadSearchXML()
{               
      var vType=getTreeType(TreeType);       
      var vKey=document.all.KeyWord.value;   
      if (TreeStartNode && TreeStartNode!="")
         vStart="&id="+TreeStartNode;
      else
         vStart="";                            
         
      source.load(WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+vStart+"&key="+vKey);  
      var vBase="<span><img src='/tenwa/images/base.gif'style='margin-left:2;margin-right:4'>请选择..</span>"
      var vHTML=source.transformNode(style);
      if(vHTML.toLowerCase().indexOf("openlink")==-1) vHTML="<p class=NoDocMsg>没有相关信息！</p>";                 
      document.all.treebody.innerHTML=vBase+vHTML;
}

function fn_search(){
  var vKey=document.all.KeyWord.value; 
  if(trim(vKey)=="")
  {
    alert("查询字符不能为空!");return false
  }
  if(vKey.indexOf(">")!=-1 || vKey.indexOf("<")!=-1 || vKey.indexOf("&")!=-1 ||vKey.indexOf("#")!=-1)
  {
    alert("查询字符有非法字符，请重试!");return false
  }  
  loadSearchXML();
  setAllVarEmpty()
}

function fn_return(){
  loadRootXML();
  setAllVarEmpty()
}

function setAllVarEmpty(){
  for(k=0;k<tagCollection.length;k++){   	
    tagCollection[k]=null;      	        
  }	
  tagCollection=new Array();
  vTotal=0;
  tagMoveStart=null;
  tagMoveEnd=null;
  currentNode=null;
}

function getTreeType(vType){    
  if (vType=="m") return "p";	
  if (vType.length==1) return vType;
  if (vType.indexOf("p")!=-1) return "p";
  if (vType.indexOf("g")!=-1) return "g";
  return "u";	
}	

function fn_getItemType(vTag){
  	var vFirstTag=vTag.parentElement.children[0];  	
  	if(vFirstTag.tagName=="IMG"){
    	if (vFirstTag.src.indexOf("depart")!=-1){
       		return "g";
       	}
    	else if (vFirstTag.src.indexOf("role")!=-1){
       		return "r";  
       	}
    	else if(vFirstTag.src.indexOf("group")!=-1){
    		return "g";   
		}
    	else{
       		return "p";    
       	}
	}
	else{
     	return "p";
	}
}

function showlayer(which){		
	var args=showlayer.arguments;
	var vNodeSrc=args.length>1?args[1]:which;
	/*
	var img=document.all.tags("IMG");
	var td=document.all.tags("TD");
   	var currentImg=img["img_"+which];
   	var currentTD=td[which];*/
   	var vTag=event.srcElement;
   	var vTD=vTag;
   	while(vTD.tagName!="TD"){
   	  vTD=vTD.parentElement;	
        }   		
        var currentImg=vTD.children[0];
   	var currentTD=vTD.parentElement.nextSibling.children[1];
	
    if (currentTD.style.display=="none")
     {              
        currentTD.style.display="block";    	
    	if (currentTD.innerHTML=="")    	 
    	  currentTD.innerHTML=loadNodeXML(vNodeSrc);             	     	     	    	  	   	
        currentImg.src=currentImg.src.replace("plus","minus");
     }	
    else{     
    	currentTD.style.display="none";        
        currentImg.src=currentImg.src.replace("minus","plus");    
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

function IsItemHidden(vTag){
    var flag=true;
    var treebody=document.all.treebody;
    var vTmp=vTag;
    while (flag && vTmp!=treebody){    
     if (vTmp.style.display=="none") flag=false;
     vTmp=vTmp.parentElement;}     
     
    return flag;
}


function openLink(which){
  addToText(event.srcElement);
}   

function addToText(LinkItem){ 
    var CurrentText=document.all("CurrentText");
    var CurrentValue=document.all("CurrentValue");
  
    var tmp=LinkItem.outerHTML.substring(LinkItem.outerHTML.indexOf("openLink")+8,LinkItem.outerHTML.length);
    var Sno=tmp.substring(tmp.indexOf("('")+2,tmp.indexOf("')"));
    //??????????         
    var vType=fn_getItemType(LinkItem);
    var preFix=vType=="p"?"":(vType+"_");
    var IsCheck=(TreeType=="m" || TreeType.indexOf(vType)!=-1)?true:false;    
    if(Sno!="root" && Sno!="null" && IsCheck){
    	LinkItem.parentElement.style.background="#000080";
        LinkItem.style.color="white";                     
        tagCollection[vTotal]=LinkItem; 
        vTotal++;               
        
        //?????          
       if (CurrentText.value=="")
       {        	           	        	
        	CurrentText.value=preFix+LinkItem.innerText;
                CurrentValue.value=Sno;                
	}
	else if(CurrentValue.value.toLowerCase().indexOf(Sno.toLowerCase())==-1){
       	   CurrentText.value+=";"+preFix+LinkItem.innerText;
           CurrentValue.value+=";"+Sno;
	}
   }                
}

document.onclick=function(){
	//???????
	//??Shift??
	var tag=event.srcElement; 	
	if(tag.tagName=="TD"){
		document.selection.empty();               
        var link=tag.children;
                
        for (ii=0;ii<link.length;ii++){            
			if(link[ii].tagName=="A" &&link[ii].outerHTML.indexOf("openLink")!=-1){
			    currentNode=link[ii];
            	addToText(link[ii]);
            }
      	}
 	}   
}

document.ondblclick=function(){	
	var tag=event.srcElement;	
	if(tag.tagName=="TD")
	{
    	  document.selection.empty();  
    	  var link=tag.children;    	  
    	  for(i=0;i<link.length;i++){
      		if(link[i].tagName=="A" && link[i].outerHTML.indexOf("openLink")!=-1){
         		addToText(link[i]);
         	}
          }
	}
 	else if(tag.tagName=="A" && tag.outerHTML.indexOf("openLink")!=-1)
 	{
      	  addToText(tag);
 	} 	    	
    btnAdd_click();
}

document.onmousedown=function(){
	var tag=event.srcElement;	
	var tds=document.all.tags("TD"); 
	var link=document.all.tags("A");
	var CurrentText=document.all("CurrentText");
	var CurrentValue=document.all("CurrentValue");

 	document.selection.empty();
 	tagMoveStart=tag; 
 	if(tag.tagName=="TD"){
    	var vTmp=tag.children;    	
    	for(i=0;i<vTmp.length;i++){
     		if(vTmp[i].tagName=="A"){
     			tagMoveStart=vTmp[i];
     		}
     	}
    }
     
 	if (!treebody.contains(tag) || event.shiftKey){
 		return false;
 	}
 	
 	for(k=0;k<vTotal;k++){
   		tagCollection[k].parentElement.style.background="#ffffff";
   		tagCollection[k].style.color="black"; 
   		tagCollection[k]=null;
 	}

  	tagCollection=new Array();
  	vTotal=0;
  	CurrentText.value="";
  	CurrentValue.value="";
}

document.onmouseup=function(){
	///????????
	var tag=event.srcElement;		
	var treebody=document.all.treebody;
	if (!treebody.contains(tag)) return false;
	
	if(tag.tagName!="TD" && tag.tagName!="A"){
		return false;
	}		
	//??????tag
	if(tag.tagName=="TD"){
    	var vTmp=tag.children;    	    	
    	for (i=0;i<vTmp.length;i++)
     		if(vTmp[i].tagName=="A")
     		{     		
     			tagMoveEnd=vTmp[i]; 		
     			break;
     		}     	
 	}
 	else
 	  tagMoveEnd=tag;
 	
 	currentNode=tagMoveEnd;  	
 	 	    
	if(tagMoveStart==tagMoveEnd){
		return false; 
	}

	//??range???????
 	var sel=document.selection;
 	var range=sel.createRange();
 	var list=range.text;
 	document.selection.empty(); 
 	
 	if(list==""){
 		return false;
 	}
 	
 	
 	var link=document.links;
 	var IsSelect=false;
 	
 	for (i=0;i<link.length;i++){  
    	if(tagMoveStart==null||tagMoveStart==link[i]){
    		IsSelect=true;
    	}
    	
    	if(IsSelect && list.indexOf(link[i].innerText)!=-1 && link[i].outerHTML.indexOf("openLink")!=-1){ 
        	//??????
           	var flag=true;                  
           	var vTmp=link[i];
           	
           	while (flag && vTmp!=treebody){
              	if(vTmp.style.display=="none"){
              		flag=false;
              	}
              	
  			vTmp=vTmp.parentElement;  
			}
	}
		
        if(flag)addToText(link[i]);
        
        if (tagMoveEnd==link[i]){
        	IsSelect=false;
        	return false;
		}                            
   	}
}

function node_movePrev(){
 if(!currentNode) return false;  	  	
 alert(currentNode.innerText);
 var table_current=node_getParent();
 var tr_parent=table_current.parentElement.parentElement; 
 if(tr_parent.parentElement.children[tr_parent.rowIndex-1])
 {
   var vLink=tr_parent.parentElement.children[tr_parent.rowIndex-1].all.tags("A")[0];
   vLink.focus();   
   currentNode=vLink;   
 }  
}

function tree_RefreshCache(){
	loadRootXML("refreshcache=true");
	setAllVarEmpty();
}
	
function node_moveNext(){
 if(!currentNode) return false;  	  	 	  	
 var table_current=node_getParent();
 var tr_parent=table_current.parentElement.parentElement;  
 if(tr_parent.nextSibling)
 {
   var vLink=tr_parent.nextSibling.all.tags("A")[0];
   vLink.focus(); 
   currentNode=vLink;   
 }  
}	

function node_reVeal(){
 if(!currentNode) return false;  	  	
 var table_current=node_getParent();
 var td_parent=table_current.parentElement;
 td_parent.style.display="none";
 if(document.all.tags("IMG")[td_parent.id]){
   var v_img=document.all.tags("IMG")[td_parent.id];
   v_img.src=v_img.src.replace("minus","plus");
 } 
    
 var tr_parent=td_parent.parentElement; 
 if(tr_parent.parentElement.children[tr_parent.rowIndex-1])  
 {
   var vLink=tr_parent.parentElement.children[tr_parent.rowIndex-1].all.tags("A")[0];
   vLink.focus(); 
   currentNode=vLink;    
 }  	 
}

function  node_getParent(){  	
  var tag_current=currentNode;
  var tag_parent=tag_current.parentElement;  
  while (tag_parent.tagName!="TABLE")
    tag_parent=tag_parent.parentElement;    
  return tag_parent; 	
}	