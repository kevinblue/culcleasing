function IniSelect(){  
  var vTo=document.all("tmpOwners");
  var flag;   
  if (window.name=="" || !opener.document.all[window.name] || opener.document.all[window.name].value=="") return false;  
      var vStr=opener.document.all[window.name].value;
      var vKey=";";
      var list1=vStr.split(vKey);
     
     if (opener.document.all[window.name+"Sno"]){
       var vStr=opener.document.all[window.name+"Sno"].value;                
       var vKey=";"
       var list2=vStr.split(vKey);
       }       
     else{
       var list2=new Array();
       for(i=0;i<list1.length;i++)
         list2[i]=list1[i]
     }  
         
     for (i=0;i<list1.length;i++){
         flag=true;
         for (j=0;j<vTo.options.length;j++)
             if (list1[i]==vTo.options[j].text){flag=false;break;}  
         if(flag)
         {    
          var ele=document.createElement("OPTION");
          ele.index=i+1;
          ele.text=trim(list1[i]);
          ele.value=trim(list2[i]);
          vTo.add(ele);
        }
    }   
}

//È¡Ïû²Ù×÷
function btnCancel_click(){
  if(source)source=null;	
  if(style)style=null;
  self.close();
}  

function btnAdd_click(){	
   var vTo=document.all("tmpOwners");
   var vFromText=document.all("CurrentText");
   var vFromValue=document.all("CurrentValue");  
    
   if (vFromText.value=="") return false;
   var list1=vFromText.value.split(";");
   var list2=vFromValue.value.split(";");
   for (i=0;i<list1.length;i++)          
       if (list1[i]!="" && list2[i]!="root" && list2[i].value!="null"){
            flag=true;
            for (j=0;j<vTo.options.length;j++)
            if (list2[i]==vTo.options[j].value) {flag=false;break;}           
             
            if (flag){
               var ele=document.createElement("OPTION");
               ele.index=vTo.options.length;
               ele.text=list1[i];               
               ele.value=list2[i];            
               vTo.add(ele);} 
          } 
   fn_recordSelect();       
}

function btnAddall_click(){
   var vTo=document.all("tmpOwners");
   var link=document.all.treebody.document.all.tags("A");

   for (i=0;i<link.length;i++){
   
         var vType=fn_getItemType(link[i]);
         var preFix=vType=="p"?"":(vType+"_");
         var IsCheck=(TreeType=="m" || TreeType.indexOf(vType)!=-1)?true:false; 
    
        if (link[i].outerHTML.indexOf("openLink")!=-1 && IsCheck){         
          var tmp=link[i].outerHTML.substring(link[i].outerHTML.indexOf("openLink")+8,link[i].outerHTML.length);  
          var Sno=tmp.substring(tmp.indexOf("('")+2,tmp.indexOf("')"));   
      
          var flag2=true;
          for(j=0;j<vTo.options.length;j++)  
            if (vTo.options[j].value==Sno){flag2=false;break;}                 
             
         if (flag2 && Sno!="root" && Sno!="null" && IsItemHidden(link[i])){      
           var ele=document.createElement("OPTION");
           ele.index=vTo.options.length;
           ele.text=preFix+link[i].innerText;
           ele.value=Sno;
           vTo.add(ele);}       
      }   
    }
   fn_recordSelect();  
}

function btnDel_click(){
 var vTo=document.all.tmpOwners;
 for(i=0;i<vTo.options.length;i++){
   if(i==0 && vTo.options[i].text.indexOf("-----")!=-1)i++;   
   if(vTo.options[i].selected){
      vTo.options[i]=null;
      --i;
     }    
  }
 fn_recordSelect();
}

function btnDelall_click(){
 var vTo=document.all.tmpOwners;
 for(i=0;i<vTo.options.length;i++){
     if(i==0 && vTo.options[i].text.indexOf("-----")!=-1)
     {
       i++;	       
     }	
     vTo.options[i]=null;
     --i;
 } 
 fn_recordSelect();
}

function btnOK_click(){
  var vTo=document.all.tmpOwners;
  var vText="";
  var vValue="";
  
  if(source)source=null;	
  if(style)style=null;

if(window.opener!=null)
 {
   for(i=1;i<vTo.options.length;i++)
     if (i==1){ 
        vText=vTo.options[i].text;
        vValue=vTo.options[i].value;}
     else{
        vText+=";"+vTo.options[i].text;
        vValue+=";"+vTo.options[i].value;}                
   	
    window.opener.document.all[window.name].value=vText;  
    if (window.opener.document.all[window.name+"Sno"]){        
        window.opener.document.all[window.name+"Sno"].value=vValue;}        
     self.close();
  }
}

function fn_recordSelect()
{
  var vTmp="";  
  var vValueList="";
  var vTo=document.all.tmpOwners;      
  if (document.all.JobOwnersOS){
      for(i=0;i<vTo.options.length;i++)
         if (vTmp.indexOf(vTo.options[i].text)==-1){
            var vTag=vTo.options[i];	 
            vTmp+=vTag.text+"|"+vTag.value+";";             
            vValueList+=vTag.value+";";           
         }   
         
   vTmp=vTmp.substr(0,vTmp.length-1);
   vValueList=vValueList.substr(0,vValueList.length-1);       
   document.all.JobOwnersOS.value = vTmp;   
   if (document.all.JobOwnersOSSno)      
      document.all.JobOwnersOSSno.value = vValueList;
 }
}



