var vTotal=0;
var TreeType="";
var source=null;
var style=null
var currentNode=null;
var preSelect = null;

function loadRootXML()
{             
    if (TreeStartNode && TreeStartNode!="")
        vStart=TreeStartNode;
     else
        vStart="root";
    
      var SourceUrl=WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+"&id="+vStart;
      xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
      xmlhttp.Open("POST",SourceUrl,true);    
      xmlhttp.onreadystatechange=xmlhttpReturn;                          
      xmlhttp.Send();
}

function xmlhttpReturn(){
  style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument"); 
  style.async = false;  
  style.resolveExternals = false;           
  style.load(WpsRootPath+"/xsl/TreeXSLForDialog.xsl");             	
                      
  var vBase="<span><img src='/tenwa/images/base.gif'style='margin-left:2;margin-right:4'>请选择..</span>";       
 if(xmlhttp.readyState==4){	   
   if(xmlhttp.status==200){	       
     var vHTML=xmlhttp.responseXML.transformNode(style);        	 
     if(vHTML.toLowerCase().indexOf("openlink")==-1) vHTML="<p class=NoDocMsg>没有相关信息！</p>";
     document.all.treebody.innerHTML=vBase+vHTML;
   }
 }    	
}	

function loadNodeXML(vNodeSrc)
{    
   if(style==null){		           
      style = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
      style.load(WpsRootPath+"/xsl/TreeXSLForDialog.xsl");        
      style.async = false;      
      style.resolveExternals = false;         
                           	
   }         
   var SourceUrl=WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+"&id="+vNodeSrc;    
   xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
   xmlhttp.Open("POST",SourceUrl,false);                              
   xmlhttp.Send();
   var xml=xmlhttp.responseXML;  
   return xml.transformNode(style);
} 

function loadSearchXML()
{               
      var vType=getTreeType(TreeType);       
      var vKey=document.all.KeyWord.value;
      if (TreeStartNode && TreeStartNode!="")
          vStart="&id="+TreeStartNode;
       else
          vStart="";          
       
      var SourceUrl=WpsRootPath+"/servlet/tree?isuse=false&type="+getTreeType(TreeType)+vStart+"&key="+vKey;                                          
      xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
      xmlhttp.Open("POST",SourceUrl,true);  
      xmlhttp.onreadystatechange=xmlhttpReturn;                             
      xmlhttp.Send();      
}

function getTreeType(vType){    
  if (vType=="m") return "p";
  if (vType.length==1) return vType;
  if (vType.indexOf("p")!=-1) return "p";
  if (vType.indexOf("g")!=-1) return "g";
  return "p";	
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
}

function fn_return(){
  loadRootXML();
}

function showlayer(which){
	var args=showlayer.arguments;
	var vNodeSrc=args.length>1?args[1]:which;
	
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

function openLink(which){
  var tag=event.srcElement; 
  var args=openLink.arguments;
  var vText=args.length>1?args[1]:tag.innerText;
  if(vText=="") vText=tag.innerText;
  var vType=fn_getItemType(tag);     
  if (which=="root"||which=="null") return false;        
  if(TreeType=="m" || getTreeType(TreeType).indexOf(vType)!=-1)
    {       
      document.all("CurrentText").value=vText;
      document.all("CurrentValue").value=which;
      changeColor();
    }  
} 

function getLinkValue(LinkItem){
 if(!LinkItem) return "";
 var tmp=LinkItem.outerHTML.substring(LinkItem.outerHTML.indexOf("openLink")+8,LinkItem.outerHTML.length);
 var Sno=tmp.substring(tmp.indexOf("('")+2,tmp.indexOf("')"));  
 return Sno;  
}

function changeColor(){
	var vTag = event.srcElement;
	vTag.blur();
	var vTD = vTag;
 	while(vTD.tagName!="TD"){
 	   	  vTD=vTD.parentElement;}
 	
	vTD.parentElement.style.background="#000080";
    vTD.all.tags("A")[0].style.color="white"; 
	if (preSelect!=null){
		preSelect.parentElement.style.background ="#ffffff";
		preSelect.all.tags("A")[0].style.color="#000000";
	}
	preSelect = vTD;
}

function btnOK_click(){
  var vText=document.all("CurrentText").value;
  var vValue=document.all("CurrentValue").value;   
if(window.opener!=null){
   var tag=window.opener.document.all[window.name];
   var vText=document.all("CurrentText").value;
   var vValue=document.all("CurrentValue").value;   
   if (tag.tagName=="SELECT"){
      for (i=0;i<tag.length;i++)
         if (tag.options[i].text==vText){                
             window.opener.location.href=window.opener.location.pathname+"?openform&"+vText;     
             break;            
          }     
     }
   else{
       tag.value=vText;
       if (window.opener.document.all[window.name+"id"])
         window.opener.document.all[window.name+"id"].value=vValue;       
    } 
    self.close();
 }
}

function btnOKModal_click(){
	  var vText=document.all("CurrentText").value;
	  var vValue=document.all("CurrentValue").value;
	  var vAry=new Array(vText,vValue);
	  window.returnValue=vAry;
	  self.close();
}

function btnCancel_click(){
 self.close();
}

function btnCancelModal_click(){
	 window.returnValue=null;
	 self.close();
}

function IniSelect(){
  var vText=document.all("CurrentText");  
  var vValue=document.all("CurrentValue"); 	
  try{
  var tag=window.opener.document.all[window.name];
  if(tag && tag.value!="") vText.value=tag.value;
  
  var tag=window.opener.document.all[window.name+"ID"];
  if(tag && tag.value!="") vValue.value=tag.value;  	
  }
  catch(E){} 
}	
