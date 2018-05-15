// JavaScript Document
// 最后修改时间 09.02.12 14:22
// 修改人：SUN

function fun_winMax(){
	window.moveTo(0,0);window.resizeTo(screen.availWidth,screen.availHeight);
	if(navigator.userAgent.indexOf("MSIE")>0) {
		document.onkeydown = function() { 
			var type = event.srcElement.type; 
			var code = event.keyCode; 
			var ro = event.srcElement.readOnly; 
			return ((code != 8 && code != 13) || (type == 'text' && !ro && code != 13 ) || (type == 'textarea') || (type == 'submit' && code == 13)) 
		} 
	}
}

function setDivHeightJsp(name,Height)
{
			 bottomH=12;
 	reinitIframe(bottomH,name); 
}


////////////////////////////////////
// 以下代码使得内容显示区域(mydiv)的大小随窗口变化而变化
// 完全自适应
///////////////////////////////////

function public_onload(h){ 
	
 //自适应页尾高度 
 var bottomH ;     
 if((h && h!="")|| h==0)
 bottomH = h;
 else
 bottomH=12;
 	reinitIframe(bottomH);  
}

var debug=true;
///////////////////////////////////
//div自动适应窗口高度功能 王晓东 080721
//////////////////////////////////
	
//折叠显示区域
function fieldsetHidden(){
  var src=event.srcElement;
  var legent = src.parentElement;  
  var vTag=legent.nextSibling;
  vTag.style.display=(vTag.style.display && vTag.style.display!="")?"":"none";
  src.src = src.src.indexOf("_b")!=-1?src.src.replace(/_b/g,"_a"):src.src.replace(/_a/g,"_b"); 
  reinitIframe();
}

 //动态修改数据区域高度
function reinitIframe(h,name){
 //自适应页尾高度 
 var bottomH ;     
 if((h && h!="")|| h==0)
 bottomH = h;
 else
 bottomH=0;
 var divname = "mydiv";
 if(name!=""&&name!=undefined)divname=name;
 var divH = document.getElementById(divname);
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

var preTr=null;
var preColor="";
//鼠标悬停修改背景颜色
function fn_changeTrColor(){  	   	
  try{	
  var tag=event.srcElement;	
  while(tag.tagName!="TR")tag=tag.parentElement;  
  switch(event.type){
   case "mouseover": 
    preColor=tag.currentStyle.backgroundColor;	
    if(tag.currentStyle.highLightColor)tag.style.background=tag.currentStyle.highLightColor;
    else tag.style.background="#f4f9ff";
    break;
   case "mouseout": 
    if(preTr!=tag)tag.style.background=preColor;
    break;
  }}catch(E){}	
}

///////////////////////////////////
// 设置只读input框的样式 05.002 05.04.27
//////////////////////////////////
function setReadonlyStyle(){
	var allInputs=document.all.cwCellContent.all;
	//var allInputs=document.getElementsByTags("input");
	//alert(allInputs.length);	
	for (i=0;i<allInputs.length;i++){
		theObj = allInputs[i];
			if(theObj.getAttribute("readonly")){
				theObj.className="readonly";
			}
	}
}

/*///////////////////////////////////////////
//选中所有 2005.6.15
/*///////////////////////////////////////////
function selectAllItems(items){
	//var items= document.all.itemselect;
	if(items==undefined)return;
	if (items.length==undefined){
		items.checked=event.srcElement.checked;
	}
	for(i=0;i<items.length;i++){
		items[i].checked=event.srcElement.checked;
		
	}
	
}




/////////////////////////////////
// 两SELECT框间互操作 SOMAX
/////////////////////////////////

function selectAllOption(box){

	if(box==null||box=='')	return;
	if(typeof(box)!="object")box=eval(box);
	for (i = 0; i < box.options.length; i++) {
		box.options[i].selected = true;
	}
}
function unSelectAllOption(flist){
	if(flist==null)return;
	for (i = 0; i < flist.options.length; i++) {
		flist.options[i].selected = false;
	}
}

function move(fbox, tbox){
	if(fbox==null || tbox==null || fbox.selectedIndex==-1)	return;
	fOpts=fbox.options;
	tOpts=tbox.options;
	for(i=0;i<fbox.length;i++){
		if (fOpts[i].selected){
			tOpts.add(new Option(fOpts[i].text,fOpts[i].value));
			fbox.options.remove(i)
			i--;
		}
	}
}

function removeOption(box){
	if(box==null)return;
	var option = box.options;
	for(var i=option.length-1;i>-1;i--){
		if(option[i].selected==true)option.remove(option[i].index);
	}
}


function switchOption(box,offset){
	if(box=='')	return;
	if(typeof(box)!="object")box=eval(box);
	if(box==null||box.selectedIndex==-1)return;

	var lastIndex = box.options.length-1;
	var selIndex = box.selectedIndex;
	if(selIndex==0 && offset<0 )return;
	if(selIndex==lastIndex && offset>0 )return;

	var swOption	= box.options[selIndex+offset];
	var selOption	= box.options[selIndex] ;
	var selText		= selOption.text;
	var selValue	= selOption.value;

	selOption.text	= swOption.text;
	selOption.value	= swOption.value;
	swOption.text	= selText;
	swOption.value= selValue;

	swOption.selected = true;
	box.selectedIndex = selIndex+offset;

}

function wheelmove(){
	if(event.wheelDelta>0){
		switchOption(event.srcElement,-1);
	}else{
		switchOption(event.srcElement,1);	
	}
}

function getSelTxt(selObj){
	if (selObj.disabled) return;
	return selObj.options[selObj.selectedIndex].text;
}
function getSelValue(selObj){
	if (selObj.disabled) return;
	return selObj.options[selObj.selectedIndex].value
}

function setActObj(objName,actObj){
	if(typeof(actObj)!="object")actObj=document.all.actObj;
	
	if(actObj.value!=""){
		document.all(actObj.value).parentNode.className="selectBox";
	}
	document.all(objName).parentNode.className="selectedBox";
	actObj.value=objName;
}














/*///////////////////////////////////////////
设置表格内显示条目 05.001 SOMAX	05.4.22
说明：设置表格内显示条目
参数: arrObj:表格对象, setClass：要显示的id
用法范例：onChange="setContClass(arrObj,this.value)"
/*///////////////////////////////////////////



function setContClass(arrObj,setClass){//05.04.30
	var disp="";
	for(i=0;i<arrObj.length;i++){ 
		if(!!arrObj[i].contclass){
			var arrClass=arrObj[i].contclass.split("|");
			for(j=0;j<arrClass.length;j++){
				if(arrClass[j]==setClass){
					disp="";
					j=arrClass.length;
				}else{
					disp="none";
				}
			}
			arrObj[i].style.display=disp;
		}
	}
}


/*//////////////////////////////////////////////////
选择显示[其他]输入框  05.001 SOMAX 05.4.22
说明：如果select内容是“其他”，则显示input框让用户输入
范例：<select name="select1" onChange="setSelData(this,input1)" >.....</select>
	  <input style="display:none" name="input1" .... >
/*//////////////////////////////////////////////////
function setSelData(objSel,objInp){
	var disp;
  	objInp.value=objSel.value
	if (objSel.value=="其他"){
		disp=""
	}else{
		disp="none"
	}
	objInp.style.display=disp;
}



/*//////////////////////////////////////////////////
扩展式表格函数 05.001 SOMAX 05.04.16
expmode=0|1,默认为0
HTML结构及初始化代码如下
<div id="table1" expmode=0> 
  <div id="tablenode"> 
    <div id="tabletit" onClick="expThis()">tit</div> 
    <div id="tablesub">...</div> 
  </div>
  ...
</div>
<script>initExpTable(table1,0);</script>
*/////////////////////////////////////////////////



function expTable(tablesub){


		if(tablesub.style.display!="none"){
			tablesub.style.display="none";
			tablesub.parentNode.all.tabletit.className="tabtit";
		}else{
			tablesub.style.display="";
			tablesub.parentNode.all.tabletit.className="tabtitExp";
			//alert(document.all.cwCellContent.scroll)//.scrollBy(0,172);
		}
		//alert(tablesub.parentNode.all[0].id)

	
}

function setAllTable(table,disp){
	var arrtablesub=table.all.tablesub;
	var theclassname=(disp=="none")?"tabtit":"tabtitExp"
	for (i=0;i<arrtablesub.length;i++){
		arrtablesub[i].style.display=disp;
			arrtablesub[i].parentNode.all.tabletit.className=theclassname;
	}
	
}

function closeAllTable(table){
	setAllTable(table,"none");
}

function expAllTable(table){
	setAllTable(table,"");
}


function expThis(){
	var theTable =event.srcElement.parentNode.parentNode;
	var thetablesub = event.srcElement.parentNode.all.tablesub;
	if (theTable.expmode==1 )closeAllTable(theTable);
	expTable(thetablesub);
}

function initExtTable(table,index){
	closeAllTable(table);

	if (typeof(index)=="string"){
		var arrIndex=eval(index.split("|"));
		for(i=0;i<arrIndex.length;i++){
			expTable(table.all.tablesub[arrIndex[i]]);
		}
	}

	
	
}






/*/////////////////////////////////////////////////
名称：扩展数据列表函数 05.002 SOMAX 05.04.27
功能：在当前行下面插入一行并在里面加载新的页面
用法：expShow(URLString);
范例：<td><a onClick="expShow('list3.html')">text</a></td>
			(注意事件触发层次)
/*/////////////////////////////////////////////////
function insExpRow(table,idx){
	var x = table.insertRow(idx);
	var y = x.insertCell(0);
	return x;
}

function delExpRow(table,idx){
	table.deleteRow(idx);
}
function delCurExpRow(){
	var theCurRow =event.srcElement.parentNode.parentNode;
	var theTable =theCurRow.parentNode.parentNode;
	var theIndex =theCurRow.rowIndex;
	delExpRow(theTable,theIndex);
	theTable.rows[theIndex-1].isExp=false;
}

function expShow(url,tit){
	var theCurRow =event.srcElement.parentNode.parentNode;
	var theTable =theCurRow.parentNode.parentNode;
	var theIndex =theCurRow.rowIndex+1;
	if(!theCurRow.isExp){
		theNewRow=insExpRow(theTable,theIndex);
		theNewRow.className="cwDLRow";
		theNewRow.valign="top";
		theNewRow.cells[0].align="center";
		theNewCell=theNewRow.insertCell(1);
		theNewCell.innerHTML='<iframe name="ifm'+theIndex+'" width="100%" height="300" frameborder="0"></iframe>';
		theNewCell.colSpan=theTable.rows[0].cells.length;
		theCurRow.isExp=true;
	}
	theTable.all("ifm"+theIndex).src=url;
	//theNewRow.cells[0].all[0].innerHTML=tit;
		theNewRow.cells[0].innerHTML=tit+"<br><br><img onClick='delCurExpRow()' alt='关闭' style='cursor:hand' src='/iulcleasing/images/expbtnclose.gif'>";

}






















//////////////////////////////////////
// NEW 设置上传组件的数量 05.002 SOMAX
//////////////////////////////////////
/* 上传组件页面元素
<input type="button" onclick="insRow('tabUpFile')" value="增加上传数"  name="addFileNum">
<table id="tabUpFile" border="0"></table>
<script>insRow('tabUpFile')</script>
*/

function insRow(tableName)
{
var theTable = document.getElementById(tableName)
var i = theTable.rows.length;
var x = theTable.insertRow(i);
var y = x.insertCell(0);
y.innerHTML='<input name="name'+ (i+1) +'" type="file" size="50" dataType="Filter" accept="zip|jpg|jpeg|gif|bmp|xls|doc|ppt|mpp|rar|txt"  ><input type="button" onclick="delRow()" value="删除">';//有新增多条的功能
//y.innerHTML='<input name="filename'+ (i+1) +'" type="file" size="50" dataType="Filter" accept="zip|jpg|jpeg|gif|bmp|xls|doc|ppt|mpp|rar|txt" >';//无新增多条的功能
//document.getElementById('addFileNum').style.display='none';//屏蔽新增多条的功能
}

function delRow()//2005.05.18
{
var theTable= event.srcElement.parentNode.parentNode.parentNode;
var i = event.srcElement.parentNode.parentNode.rowIndex;
theTable.deleteRow(i);
}








//////////////////////////////////
//打开日期输入组件 05.002 SOMAX 05.04.27
//////////////////////////////////
function openCalendar(ctrlobj)
{
	showx = event.screenX - event.offsetX - 0 ; 
	showy = event.screenY - event.offsetY - 20; 
	newWinWidth = 300 + 4 + 18;

	url= "/culcleasing/js/CalendarDlg.html";
	
	if(document.location.protocol=="file:")url= "/culcleasing/js/CalendarDlg.html"; //调试用
	
	retval = window.showModalDialog(url, ctrlobj , "dialogWidth:260px; dialogHeight:250px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:no;scrollbars:no;Resizable=no; "  );

/*//05.4.27
	if( retval != null ){
		ctrlobj.value = retval;
	}else{
		//alert("canceled");
	}
	*/
}


///////////////////////////////////////
//数据操作 增加 删除 修改 05.005 SOMAX 05.06.08
///////////////////////////////////////
function dataHander(act,theUrl,objItem,str)
{
	var czid = false;
	var msg1 = "没有可";
	if (objItem!=null){
		if(objItem.length==undefined){
			if(objItem.checked){
				czid=objItem.value;
			}
		}else{
			for (i=0;i<objItem.length;i++){
				if (objItem[i].checked){
					czid=objItem[i].value;
				}
			}
		}
		msg1 = "请选中要";
	}
	str=(str!=undefined)?str:""
	
	switch(act){
		case "add":
			popUpWindow(theUrl + str);
			break;
		case "del":
			if (!czid){alert(msg1+"删除的项目！");return false}
			//openModalWin(theUrl+czid);
			popUpWindow(theUrl+czid);
			break;
		case "mod":
			if (czid == false){alert(msg1+"修改的项目！");return false}
			
			popUpWindow(theUrl+czid);
			break;
			
			
		case "add_modal":
			popUpWindow(theUrl + str,700,520);
			break;
		case "add2_modal":
			if (!czid){alert(msg1+"新增的项目！");return false}
			//openModalWin(theUrl+czid);
			popUpWindow(theUrl+czid,700,520);
			break;
		case "del_modal":
			if (!czid){alert(msg1+"删除的项目！");return false}
			//openModalWin(theUrl+czid);
			popUpWindow(theUrl+czid,700,520);
			break;
		case "mod_modal":
			if (czid == false){alert(msg1+"修改的项目！");return false}
			popUpWindow(theUrl+czid,700,520);
			break;
		case "sh_modal":
			if (czid == false){alert(msg1+"审核的项目！");return false}
			popUpWindow(theUrl+czid,700,520);
			break;
	}
	return false;
}


//////////////////////////////////
//打开弹出窗口 05.002 SOMAX
//////////////////////////////////

function popUpWindow(URLStr,width, height)
{
	if(width==undefined && height==undefined)
    {
          event.srcElement.openwin = open(URLStr);
          event.srcElement.openwin.focus();
    }
	else
	{
	      	var left=(screen.width - width)/2;
	        var top=(screen.height - height)/2;
  
            event.srcElement.openwin = open(URLStr,"","width= "+width+ ",height="+height+",left="+left+",top="+top);
            event.srcElement.openwin.focus();
	}
}	
	//if(width==undefined)width=600
	//if(height==undefined)height=500

  /*
  var srtWinName = cwCellTopTitTxt.innerText;//05.002
  srtWinName =srtWinName.replace(/[/\\\.\-\(\)（）]/g,'');//05.003
  event.srcElement.openwin = open(URLStr, srtWinName );
  event.srcElement.openwin.focus();
  */






///////////////////////////////////////
////打开ModalDialog窗口 05.001 SOMAX
//////////////////////////////////////
function openModalWin(winName,ctrlObj)
	{
		dW=600;
		dH=400;
		showx = (window.screen.width-dW)/2; 
		showy = (window.screen.height-dH)/2;
	
		retval = window.showModalDialog(winName, "", "dialogWidth:"+dW+"px; dialogHeight:"+dH+"px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:no;scrollbars:no;Resizable=no; "  );
		if( retval != null ){
			ctrlobj.value = retval;
		}else{
			//alert("canceled");
		}
}

///////////////////////////////////////







/////////////////////////////////
// 确认关闭窗口 05.001 SOMAX
/////////////////////////////////
function cfClose(){
	if(confirm('确定要取消修改吗？'))window.close();
}



//////////////////////////////
//数据列表翻页 05.003 SOMAX
/////////////////////////////
//前置变量（在调用页内声明）：
//  cp - 当前页码  例：var cp = <%= intPage %>;
//  lp - 最后页码  例：var lp = <%= intPageCount %>;
//  nf - 翻页模块所在的form对象  例：var nf = document.dataNav;
//调用方法：
//  onClick="goPage('first')"
//参数：p - "first"|"prev"|"next"|"last"|"jump"
//////////////////////////////


	function goPage(p){
		if (cp==undefined ||lp == undefined || nf == undefined) return false;
		var currentPage = cp;
		var firstPage = 1 ;
		var pervPage = currentPage - 1;
		var nextPage = currentPage + 1;
		var lastPage = lp;
		with (nf){
			page.value=page.value.replace(/\D/g,'');
			switch (p){
				case "first":
					page.value = firstPage;
					//submit();
					break;
				case "prev":
					page.value = pervPage;
					//submit();
					break;
				case "next":
					page.value = nextPage;
					//submit();
					break;	
				case "last":
					page.value = lastPage;
					//submit();
					break;
				case "jump":
					if(page.value!=""){
						//return true;
					}
					break;
			}
			
		if(page.value=="")return false;
		nf.submit();

		}
	}

//////////////////////////////////////////////////////////////////
//生成option的html代码 05.001 SOMAX
//比较数据库中的字符串并设置selected
// dbStr 数据库中查出的字符串
// arrStr 用于显示的option字符串组,用"|"隔开,如"aaa|bbb|ccc|ddd"
// arrVStr 用于value的字符串组,当缺少时等于arrStr
///////////////////////////////////////////////////

function mSetOpt(dbStr,arrStr,arrVStr){
	var arr=arrStr.split("|");
	arrVStr=(arrVStr!=undefined && arrVStr!="")?arrVStr:arrStr;
	var arrV=arrVStr.split("|");
	var tempHtml="";
	for (i=0;i<arr.length;i++){
		tempHtml+="<option value='"+ arrV[i] +"' "+ ((arrV[i]==dbStr)?"selected":"") +">"+ arr[i]+"</option>";
	}
	return tempHtml;
}



////////////////////////////////////////
////////////////////////////////////////
function w(str){
	document.write(str);	
}




///////////////////////////////////////
//强制限制小数点后位数,n--待处理数字pos--小数点后保留位数
///////////////////////////////////////
function forcepos(n,pos)
{ 

 // str=n.toString();

  var pow = Math.pow(10, pos);
  str=(Math.round(n*pow)/pow).toString();


  var i=str.indexOf(".");

  var len=str.length; 
  var tempstr="";  

if (i>0)
{
  if (len-i>pos)
  {
    tempstr=str.substring(0,i)+str.substring(i,i+pos+1);
  }
  else
  {
    tempstr=str;  
  }
  var l=0;
  while (l==1)
  {
      
      if ((tempstr.substring((tempstr.length-2),(tempstr.length-1))=="0") && (tempstr.indexOf(".")>=0))
      {
           tempstr=tempstr.substring(0,(tempstr.length-2));
      }
      else
      {
           l=1;
      }
  }
}
else
{
    tempstr=str;  
}
  return tempstr;  
}

//////////////////////////////////


///////////////////////////////////////
//弹出简单数据选择窗口（只含列表）  05.003 SUPER
///////////////////////////////////////
function SimpleDataWindow(checkobj,checkfldname,tblname,listfld,listvalue,filterfld,filtertype,orderfld,dataobj,valueobj)
//checkobj--应检查前导字段对象  checkfldname--前导字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象
{
    var msg1 = "请先填写"+checkfldname;
    if (checkobj.value==""){alert(msg1);return false}
url="../../func/simpledatawindow.jsp?tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&fv="+checkobj.value+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,420,420);
}
//////////////////////////////////

///////////////////////////////////////
//弹出简单数据选择窗口（只含列表）  05.003 SUPER //05.4.29 SMX
///////////////////////////////////////
function SimpleDataWindow1(checkobj,checkfldname,tblname,listfld,listvalue,filterfld,filtertype,orderfld,dataobj,valueobj)
//checkobj--应检查前导字段对象  checkfldname--前导字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象
{

    var msg1 = "请先填写"+checkfldname;
    if (checkobj.value==""){alert(msg1);return false}
url="../../func/simpledatawindow1.jsp?tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&fv="+checkobj.value+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,250,350);
}
//////////////////////////////////


///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）  05.003 SUPER
///////////////////////////////////////
function SpecialDataWindow(selfldname,tblname,listfld,listvalue,filterfld,filtertype,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象
{

url="../../func/specialdatawindow.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,420,420);
}
//////////////////////////////////

///////////////////////////////////////
//弹出设备数据检索选择窗口（含列表和查询）---同时复写多个数据字段  05.004 SUPER
///////////////////////////////////////
function SpecialDataWindowSB(selfldname,tblname,listfld,listvalue,hiddenfield,filterfld,filtertype,hiddenwhere,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 hiddenfield--其他需填充字段（请严格按照顺序） filterfld--过滤字段 filtertype--过滤条件类型  hiddenwhere--固定过滤条件 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象+其他需填充对象
{
url="../../func/specialdatawindowsb.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&hf="+hiddenfield+"&ff="+filterfld+"&ft="+filtertype+"&hw="+hiddenwhere+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,250,350);
}
//////////////////////////////////



///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）---同时复写多个数据字段  05.004 SUPER
///////////////////////////////////////
function SpecialDataWindow1(selfldname,tblname,listfld,listvalue,hiddenfield,filterfld,filtertype,hiddenwhere,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 hiddenfield--其他需填充字段（请严格按照顺序） filterfld--过滤字段 filtertype--过滤条件类型  hiddenwhere--固定过滤条件 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象+其他需填充对象
{

url="../../func/specialdatawindow1.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&hf="+hiddenfield+"&ff="+filterfld+"&ft="+filtertype+"&hw="+hiddenwhere+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,250,350);
}
//////////////////////////////////

///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）  05.003 SUPER
///////////////////////////////////////
function SpecialDataWindow2(selfldname,tblname,listfld,listvalue,filterfld,filtertype,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象
{

url="../../func/specialdatawindow2.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,250,350);
}
//////////////////////////////////




///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）  08.04 SUPER
///////////////////////////////////////
function OpenDataWindow(checkobj,checkfldname,checkfld,checktype,selfldname,tblname,listfld,listvalue,filterfld,orderfld,ordertype,dataobj,valueobj)
//checkobj--应检查前导字段对象,以"|"分隔
//checkfldname--前导字段中文名称,以"|"分隔
//checkfld--前导字段名,以"|"分隔
//checktype--前导字段数据类型,以"|"分隔,枚举值：string,number
//selfldname--检索字段中文名称,以"|"分隔
//tblname-- 所查数据表名或视图名
//listfld--list显示字段
//listvalue--list实填值字段,以"|"分隔
//filterfld--筛选字段
//orderfld--排序字段,以"|"分隔
//ordertype--排序方式,升序或降序,以"|"分隔
//dataobj--返回数据显示对象
//valueobj--返回数据实际值对象+其他需填充对象,以"|"分隔
{
   if (checkobj!="")
   {
       var checkobjarray=checkobj.split("|");
       var checkfldnamearray=checkfldname.split("|");
       var checkvalue="";
       for(i=0;i<checkobjarray.length;i++)
       {
            if (eval(checkobjarray[i]).value=="")
            {
                 alert("请先填写"+checkfldnamearray[i]);
                 return false;
            }
            else
            {
                checkvalue+="|"+eval(checkobjarray[i]).value;
            }
       }
       checkvalue=checkvalue.substr(1);
   }
url="../../func/datawindow.jsp?cf="+checkfld+"&ct="+checktype+"&cv="+checkvalue+"&sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&of="+orderfld+"&ot="+ordertype+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,420,420);
}
//////////////////////////////////



//////////////////////////////////
function ForbidErrorKeydown()
{
	if(navigator.userAgent.indexOf("MSIE")>0) {
		document.onkeydown = function() { 
			var type = event.srcElement.type; 
			var code = event.keyCode; 
			var ro = event.srcElement.readOnly; 
			return ((code != 8 && code != 13) || (type == 'text' && !ro && code != 13 ) || (type == 'textarea') || (type == 'submit' && code == 13)) 
		} 
	} 
}


///////////////////////////////
function datediff(Type,DateOne,DateTwo)   
{    
    var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));   
    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);   
    var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));   
   
    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));   
    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);   
    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));   
    if (Type=='day')
    {
	    var days=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);    
	    return days;
    }
    return 0;
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