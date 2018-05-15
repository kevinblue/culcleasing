//参考域Popup
//popup单选对话框操作
//当前支持的XMLHttpUrl类型
function tw_showPopupDialog(XMLHttpUrl,returnKeyList,responseType,popupHeight,exclude,isEmptyUse){  
   /*参数说明
     XMLHttpUrl: 指定数据源路径，视图/代理/servlet等
     returnKeyList: 返回的目标字段名称，多个返回用","分割
     responseType: 数据源返回的类型,"xml"/"text"; 默认为text
     popupHeight: 对话框高度,默认为140
     exclude: 排除显示的项目，用视图的第一列
     IsEmptyUse: 是否添加空值列，允许空值输出
   */	
  if(XMLHttpUrl==""){alert("路径不能为空!");return false;}		
  if(returnKeyList==""){alert("返回对象不能为空!");return false;}    
  var returnAry=returnKeyList.split(",");
  for(var i=0;i<returnAry.length;i++){
   if(!document.all[returnAry[i]]){
     alert("目标对象"+returnAry[i]+"不存在!");
     return false;	 
   }		
  }            
  if(!responseType)responseType="xml";
  if(!popupHeight)popupHeight="140";
  if(!exclude)exclude="";
  if(!isEmptyUse)isEmptyUse=true;
 
  var tw_mainPopup= new tw_popupClass(XMLHttpUrl,returnKeyList,responseType,popupHeight,exclude,isEmptyUse);      
  fn_showMenuPopup(tw_mainPopup);
}
	
var popupWindow=window.createPopup();
var popupReturnList=null;
function tw_popupClass(XMLHttpUrl,returnKeyList,responseType,popupHeight,exclude,isEmptyUse){
  this.popup=popupWindow;	
  this.tagUrl=XMLHttpUrl; 
  this.returnObject=returnKeyList.split(",");
  this.tagObject=document.all[this.returnObject[0]];
  this.exclude=exclude;
  this.isEmptyUse=false;
  if(isEmptyUse!=null) this.isEmptyUse=isEmptyUse;
  popupReturnList=returnKeyList;
  this.responseMethod ="text"; 
  if(responseType!="") this.responseMethod = responseType=="xml"?"xml":"text";   
  this.height=140;
  if(popupHeight!="") this.height=popupHeight;    
  
}

  tw_popupClass.prototype.popup_click=function(){        
    var vSrc =popupWindow.document.parentWindow.event.srcElement;     
    var returnAry=popupReturnList.split(","); 
    var tagObject=document.all[returnAry[0]];
    if(returnAry.length>1){
      tagObject.value=vSrc.innerText;
      for(var i=1;i<returnAry.length;i++)
      {      	
      	document.all[returnAry[i]].value=vSrc["param"+i];
      }		
    }
    else	
      tagObject.value=vSrc.innerText;
      
    tagObject.fireEvent("onchange");
    popupWindow.hide();
  }
  
  tw_popupClass.prototype.popup_mouseover=function(){
   var vSrc =popupWindow.document.parentWindow.event.srcElement;
   if(vSrc.tagName=="IMG")vSrc=vSrc.parentElement;
   vSrc.style.color="#ffffff";
   vSrc.style.background="#000080";
  }  
    
  tw_popupClass.prototype.popup_mouseout=function(){
  var vSrc =popupWindow.document.parentWindow.event.srcElement;
  if(vSrc.tagName=="IMG")vSrc=vSrc.parentElement;
  vSrc.style.color="";
  vSrc.style.background="";
 }   

	 
function fn_showMenuPopup(vPopupClass){
   var vSrc=event.srcElement;   
   var v_popupBody=vPopupClass.popup.document.body;         
   v_popupBody.style.border="2px outset #ffffff";  
   v_popupBody.innerHTML="<div style='height:"+(parseInt(vPopupClass.height)-4).toString()+";overflow-y:auto;overflow-x:hidden'>"+getFieldValueList(vPopupClass)+"</div>";
   var vTags=v_popupBody.all.tags("TD");
   for (i=0;i<vTags.length;i++)
   {      
     vTags[i].onclick=vPopupClass.popup_click;
     vTags[i].onmouseover=vPopupClass.popup_mouseover;
     vTags[i].onmouseout=vPopupClass.popup_mouseout;
     vTags[i].style.cssText="font-size:12px;padding-top:1px;cursor:default";
   }
      
   var vHeight=vPopupClass.height;
   var vOffsetTop=vPopupClass.tagObject.offsetHeight+2;
   var vOffsetWidth=vPopupClass.tagObject.offsetWidth;
   vPopupClass.popup.show(0,vOffsetTop,vOffsetWidth,vHeight,vPopupClass.tagObject);
}

function getFieldValueList(vPopupClass){            
      var vUrl=vPopupClass.tagUrl;        
      var xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP");
      xmlhttp.Open("POST",vUrl,false);
      xmlhttp.Send();
      if(vPopupClass.responseMethod=="xml"){
        var xmlDoc=xmlhttp.responseXML;       
        var subNodes=xmlDoc.documentElement.childNodes;        
        var vList=new Array();     
        for(var i=0;i<subNodes.length;i++){
          var vValue=subNodes[i].getAttributeNode("title").text; 
          vList[i]=vValue;         	
        }        
      }
      else{      
          var v_div=document.createElement("DIV");  
   	  v_div.innerHTML=xmlhttp.responseText;   
   	  var vList=trim(v_div.innerText).split(";"); 
      }	
      
      if (vList[0]!=""){        
         var vHTML="<Table width='98%' frame='border' border='0' cellpadding='0' cellspacing='0'>";                
        
        //添加空值 
        if (vPopupClass.isEmptyUse){
          var params=vList[0].split("|");
          if(params.length>1){
            var param="";	
            for(var j=1;j<params.length;j++){
               param+="param"+j+"=  "; 	
            }		
            vHTML+="<tr><td "+param+"> </td></tr>";		
          } 
          else
           vHTML+="<tr><td ></td> </tr>";	
        }	
        
        for(var i=0;i<vList.length;i++){
         if(vList[i].indexOf("|")!=-1){
           var params=vList[i].split("|");
           var param="";
           for(var j=1;j<params.length;j++){
              param+="param"+j+"="+params[j]+"  "; 	
           }		
           if(vPopupClass.exclude!=params[0])
            vHTML+="<tr><td "+param+">"+params[0]+"</td></tr>";
         }	
        else{	
          if(vPopupClass.exclude!=vList[i])	
            vHTML+="<tr><td>"+vList[i]+"</td></tr>";        
          }
        }
        vHTML+="</Table>"; 	
        return vHTML; 
      }
}

function getViewEntryList(viewPath,keyValue,col){               
    var ret=new Array();
    if(!viewPath) return ret;
    if(!col && col!=0) col=0;
    var para="";
    var vUrl="";
    var i;

    para="&count=10000";
    if(keyValue) para+="&RestrictToCategory="+URLEncoder(keyValue);  
    vUrl=viewPath+"?ReadViewEntries"+para;    
    var xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
    xmlhttp.open("Post",vUrl,false);
    xmlhttp.send();  
    var xmldoc=new ActiveXObject("Msxml2.DOMDocument");
    xmldoc.async = false;
    xmldoc.load(xmlhttp.responseXML); 
   
    if(!xmldoc.documentElement) return ret;
    var root=xmldoc.documentElement;
    
    var na=root.selectNodes("//entrydata[@columnnumber='"+(parseInt(col)-1)+"']");    
    if(na.length>0){
        ret.length=na.length;
        for(i=0;i<na.length;i++){      
           ret[i]=na[i].text;
        }
    }
    return ret;
}
