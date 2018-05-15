 function public_onload(h){ 
 //自适应页面高度+底边距控制  
  var bottomH ;     
  if((h && h!="")|| h==0) bottomH = h;
   else
   bottomH=12;
 	reinitIframe(bottomH);      

  //设置语言
  if(document.all("Userlanguage"))g_UserLanguage = document.all("Userlanguage").value;
    else if (document.all("vUserlanguage"))g_UserLanguage = document.all("vUserlanguage").innerText;
 }
 
 //折叠操作区域
function fieldsetHidden(){
  var src=event.srcElement;
  var legent = src.parentElement;     
  var vTag=legent.nextSibling;
  vTag.style.display=(vTag.style.display && vTag.style.display!="")?"":"none";
  src.src = src.src.indexOf("_b")!=-1?src.src.replace(/_b/g,"_a"):src.src.replace(/_a/g,"_b");  
  try{fn_changeDivHeight()}catch(E){}
  reinitIframe(0);  
}

 //动态修改数据区域高度
function reinitIframe(h){
 var bottomH ;     
 if((h && h!="")|| h==0)
 bottomH = h;
 else
 bottomH=0;
 var divH = document.getElementById("mydiv");
 if(!divH) return false;
 var t=divH.offsetTop; 
 var o=divH;
 while(o=o.offsetParent)t+=o.offsetTop;     
 var reinitIframe_resize=function(){
 divH.style.height=window.document.body.clientHeight-t-bottomH; 
 //divH.style.width=window.document.body.clientWidth;
 }
 reinitIframe_resize();
 window.onresize=reinitIframe_resize;
}
 

function fnGetWinStatus(x,y)
{
  var m=screen.availWidth/2-x/2;
  var n=screen.availHeight/2-y/2;
  var vArg=fnGetWinStatus.arguments;
  var vStyle=vArg.length>1?vArg[2]:"status=no,scrollbars=no,location=no,menubar=no,resizable=no";

 return 'left='+m.toString()+',top='+n.toString()+',width='+x.toString()+',height='+y.toString()+","+vStyle;
}

// ------?????????------
function showSubMenu(which)
 {
  var vTmp=which.split("_");
  var vLayer=vTmp.length-1; 
  var cTds=document.all.tags("TD");
  var cImgs=document.all.tags("IMG"); 
  if ( cTds[which].style.display=="none")
   {
     cTds[which].style.display="block";
     var vImg=cImgs[which].src;
     cImgs[which].src=vImg.replace("close","open");
    }
   else   
    {
     cTds[which].style.display="none";
     var vImg=cImgs[which].src;
     cImgs[which].src=vImg.replace("open","close");
     }  
}

function menu_showSubLayer(menuID){  
  var vTag=event.srcElement;   
  while(vTag.tagName!="TD"){
    vTag=vTag.parentElement;	 
  }  	 	
  var vImg=vTag.children[0];
  var vTR=vTag.parentElement.nextSibling.children[0];  
  
  if(expandCookieID!=null){ 
    var cookieStr=GetCookie(expandCookieID);
    if(cookieStr==null)cookieStr="";  
    if(domain==null){
      var host=window.location.host;
      var domain=host.substring(host.indexOf("."),host.length);          
    }	
    var expires=30;    
            
    if(vTR.style.display=="none" && cookieStr.indexOf(menuID)==-1){       
      cookieStr+=";"+menuID;
    }
    else if(cookieStr.indexOf(";"+menuID)!=-1){
      cookieStr=cookieStr.replace(";"+menuID,"")
    }  
        
    SetCookie(expandCookieID,cookieStr,expires,"/",domain);
  }
    
  if(vTR){    	
   vImg.src=vImg.src.indexOf("add")!=-1?vImg.src.replace("add","sub"):vImg.src.replace("sub","add");
   vTR.style.display=vTR.style.display=="none"?"block":"none";	
  }   
}

function fn_ViewSelectAll(){ 
 if (!document.all.SelectedDOCs) return false; 
 var vTag=document.all.SelectedDOCs;
 
 var num=vTag.length;
 if (num==null) 
    vTag.checked=true;
 else  
   for(var i=0;i<vTag.length;i++)   
        vTag[i].checked=true;
}

function fn_ViewReset(){
 if (!document.all.SelectedDOCs) return false; 
 var vTag=document.all.SelectedDOCs;
 
 var num=vTag.length;
 if (num==null) 
    vTag.checked=false;
 else  
   for(var i=0;i<vTag.length;i++)   
        vTag[i].checked=false;
}

var viewSelectReset=0;
function fn_ViewSelectReset(){ 
 if (!document.all.SelectedDOCs) return false;   
 var vSrc=event.srcElement;
 var vImg=vSrc.tagName=="A"?vSrc.children[0]:vSrc; 
 var vLink=vSrc.tagName=="A"?vSrc:vSrc.parentElement;	   
 if (viewSelectReset==0)
 { 		
  vImg.src=vImg.src.replace("select","clear");
  vImg.src=vImg.src.replace("selall","rese"); 
  vImg.alt="重置";
  if(vLink)vLink.innerHTML=vLink.innerHTML.replace("全选","重置");   
  var vAction=true;
  viewSelectReset=1;
 }
 else
 {  
  vImg.src=vImg.src.replace("clear","select");
  vImg.src=vImg.src.replace("rese","selall");
  vImg.alt="全选";
  if(vLink)vLink.innerHTML=vLink.innerHTML.replace("重置","全选");   
  var vAction=false;
  viewSelectReset=0;
 }			
 
 var vTag=document.all.SelectedDOCs; 
 var num=vTag.length;
 if (num==null) 
    vTag.checked=vAction;
 else  
   for(var i=0;i<vTag.length;i++)   
     vTag[i].checked=vAction;
}

function fn_ViewDelete(){
      
if(fn_checkSelectEmpty("SelectedDOCs")==false){
  alert(g_UserLanguage=="0"?"???????????":"Please select files deleted!");
  return false;}
else
  if(confirm(g_UserLanguage=="0"?"?????????":"Confirm deleteing these files?")) document.forms[0].del.click(); 
}

function fn_checkSelectEmpty(vKey){   
  var num=0;
  if (!document.all(vKey)) 
      return false; 
  var vTag=document.all(vKey);  
  
  var ss=vTag.length;  
  if (!ss)
     {if(vTag.checked==true) num++;}      
  else
    for(var i=0;i<vTag.length;i++)   
      if(vTag[i].checked==true) num++;      
   
  if (num==0)
    return false;
  else     
   return true; 
}

function fn_getSelectValue(vKey){
  if(!fn_checkSelectEmpty(vKey)){
    alert("请选择待处理项目");
    return false;   
  }
  var vTag=document.all(vKey);    
  var vValue="";  
  var ss=vTag.length;  
  if (!ss)
     {if(vTag.checked==true) vValue=vTag.value;}      
  else
    for(var i=0;i<vTag.length;i++)   
      if(vTag[i].checked==true){
        vValue+=vValue==""?vTag[i].value:(";"+vTag[i].value);}   
  return vValue;
}

//????
function fn_SelectRelativeDoc(){
  var vDBPath=location.pathname.substring(1,location.pathname.indexOf(".nsf")+4);  
  var vDocID=fn_getCurrentDocID(); 
  if(document.all.ThemeWord) var vThemes=document.all.ThemeWord.value; 
  var v_url=root_path+"/DesignShare.nsf/SelectRelativeDocForm?openform";
  v_url+="&database="+vDBPath+"&docid="+vDocID+"&key="+vThemes;    
  window.open(v_url,"RelDocID",fnGetWinStatus(400,420));
}

//???????
function fn_showWaitBar(){                  
     var v_args=fn_showWaitBar.arguments; 
     var v_tag=event.srcElement; 
     var v_text=v_tag.tagName=="INPUT"?v_tag.value:v_tag.innerText;           
     v_text=v_args[0]!=null && v_args[0]!=""?v_args[0]:v_text;
     var v_div=document.createElement("DIV");          
      v_div.className="waitPopup";
      v_div.innerHTML="<p style='margin-top:6'>"+v_text+"???,???...</p>";
      var v_body=window.document.body;     
      v_div.style.left=v_args[1]!=null && v_args[1]!=""?v_args[1]:(v_body.offsetWidth-160)/2;         
      v_div.style.top=v_args[2]!=null && v_args[2]!=""?v_args[2]:(v_body.offsetHeight)/2-20;                 
      target_div=document.forms[0].appendChild(v_div);        
      document.body.style.cursor="wait";  
      v_tag.style.cursor="wait";    
 }

function changeModalColumn(){ 
  var tagDiv=document.all.TableList.all.tags("SPAN"); 
  var vSel=event.srcElement;
  var vNum=parseInt(vSel.options[vSel.selectedIndex].text); 
  var vWidth=((100-1)/vNum)+"%";
  if (tagDiv.length>0)
    for (i=0;i<tagDiv.length;i++)
      tagDiv[i].style.width=vWidth; 
}


//?????????
function ChangeMarquee(sfield){
	if (document.all[sfield].getAttribute("status")=="stop") {
		document.all[sfield].start();
		document.all[sfield].setAttribute("status","start");}
	else {
		document.all[sfield].stop();
		document.all[sfield].setAttribute("status","stop");}
}

function fn_addCurrentRefreshUrl(){
  var currentUrl=window.location.href;
  var parentUrl=window.parent.location.href;
  SetCookie("wps_currentUrl",currentUrl);  
  SetCookie("wps_parrentUrl",parentUrl); 	
}	

//---- 主选择卡效果-------
function chgTabN()
{
  var tag=event.srcElement;
  var which=tag.id.substr(tag.id.length-1,1);
  ShowTabN(which);
}

function ShowTabN(which) 
{
 if (which==null) which="0";
 var ele=document.all["Form_tab_"+which];
 var hightColor="#8DB2E3";	 	
 if(ele.currentStyle.highLightColor) hightColor=ele.currentStyle.highLightColor;
 
 var TotalTab=ele.parentElement.children.length;   
 if (TotalTab<2) return false;

for (i=0;i<TotalTab;i++){ 
   if(document.all["Form_tab_"+i].innerText!="")
   {  	  
    if(i==which)
    {     	 
      if(document.all["TD_tab_"+i]) document.all["TD_tab_"+i].style.display="block";
      document.all["Form_tab_"+i].className="seltab_s1";
    }   
    else
    {
     if(document.all["TD_tab_"+i]) document.all["TD_tab_"+i].style.display="none";
     document.all["Form_tab_"+i].className="seltab_s2";
    }  
  }
 } 
}

function showSubClass(){        	 
  var vTag=event.srcElement;
  while (vTag.tagName!="TD")
     vTag=vTag.parentElement;
     
  var vNext=vTag.parentElement.nextSibling.children[1];
  var vImg=vTag.children[0];    
  var icon = vTag.nextSibling.children[0];  
  vNext.style.display=vNext.style.display!="none"?"none":"";
  vImg.src=vNext.style.display=="none"?vImg.src.replace("minus","plus"):vImg.src.replace("plus","minus");   
  if(icon.src && icon.src.indexOf("folder")!=-1)icon.src=vNext.style.display=="none"?icon.src.replace("folderopen.","folder."):icon.src.replace("folder.","folderopen.");
}

//---- 子选择卡效果-------
function chgTabSub()
{
  var tag=event.srcElement;
  var which=tag.id.substr(tag.id.length-1,1);
  ShowTabSub(which);
}

function ShowTabSub(which) 
{
 if (which==null) which="0";
 var ele=document.all["Form_s_tab_"+which];
 var hightColor="#8DB2E3";	 	
 if(ele.currentStyle.highLightColor) hightColor=ele.currentStyle.highLightColor;
 
 var TotalTab=ele.parentElement.children.length;   
 if (TotalTab<2) return false;
 
 
 for (i=0;i<TotalTab;i++)
   if( which==i)
     {
      document.all("TD_s_tab_"+which).style.display="block";      
      if (which==1)
       { document.all("Form_s_tab_"+which).className="seltab_s1";}      
      else if (which==0)
       { document.all("Form_s_tab_"+which).className="seltab_s1";}             
      else
       { document.all("Form_s_tab_"+which).className="seltab_s1";}       
     }   
 for (i=0;i<TotalTab;i++)
   if( which!=i)
     {
	   document.all("TD_s_tab_"+i).style.display="none";
       if (i==0)
        { document.all("Form_s_tab_"+i).className="seltab_s2";}
       else if (i==1)
       { document.all("Form_s_tab_"+i).className="seltab_s2";}  
       else
       { document.all("Form_s_tab_"+i).className="seltab_s2";}         
     } 
}

function showSubAttach(){
  var vTag=event.srcElement;    
  var vTr=vTag;
  while(vTr.tagName!="DIV"){vTr=vTr.parentElement;}  
  var vImg=vTr.children[0];
  vTr.nextSibling.style.display=vImg.src.indexOf("_a")!=-1?"":"none";
  vImg.src=vImg.src.indexOf("_a")!=-1?vImg.src.replace("_a","_b"):vImg.src.replace("_b","_a");
}

function view_showWait(action){
 var reloadInfo="<center><div style=\"margin-top:40px\"><img src=\"/report/images/loading.gif\" align=absmiddle/><font color=#808080>&nbsp;&nbsp;"+action+"进行中，请稍候...</font></div></center>";	 
 if(document.all.Tablelist)document.all.Tablelist.innerHTML=reloadInfo;
}	

function setCheckValue(name,value){	
       var tags=document.all[name];
       if(!tags.length)tags.checked=tags.value==value;
       else{
         var vs=value.split(",");
         for(var i=0;i<tags.length;i++){
              tags[i].checked=vs.contains(tags[i].value);
         }
       }   
}
