// JavaScript Document
// 最后修改时间 05.06.14 14:22





////////////////////////////////////
// 以下代码使得内容显示区域(cwCellContent)的大小随窗口变化而变化
// 并且更具需要设定滚动条的出现
// 05.003 SOMAX 05.05.19
///////////////////////////////////

window.onload=onWinLoad;
window.onresize=onWinResize;

function onWinLoad(){

	fixCCH();
	setReadonlyStyle();
	//document.body.scroll = "auto";
	//alert("debug");
}
function onWinResize(){
	fixCCH();
	//alert("debug");
}

var debug=true;
function fixCCH(){//2005.05.27
	if (document.body.clientHeight>300){
		//var offsetH=chheight-document.body.clientHeight;
		//alert(scroll.clientHeight);
		var offsetH=55;
		var hTop=(typeof(cwTop)!="object")?0:cwTop.clientHeight;
		var hCTop=(typeof(cwCellTop)!="object")?0:cwCellTop.clientHeight;
		var hC2=(typeof(cwCellContent2)!="object")?0:cwCellContent2.clientHeight;
		var hBb=(typeof(cwBtnBar)!="object")?0:cwBtnBar.clientHeight;
		var hTb=(typeof(cwToolbar)!="object")?0:cwToolbar.clientHeight;
		var hTbb=(typeof(cwTabBar)!="object")?0:cwTabBar.clientHeight;
		
		//offsetH+=hTop+hCTop+hCTb+hC2+hTb+hTbb;
		offsetH+=hTop+hCTop+hC2+hTb+hTbb+hBb;
		
		//if(document.all.cwTabBar!=undefined){offsetH+=document.all.cwTabBar.clientHeight}
		
		//if(debug)alert(hCTb);debug=false;
		document.all.cwCellContent.style.height=document.body.clientHeight-offsetH;
		
		document.body.scroll = "no";
	}else{
		document.body.scroll = "yes";
	}
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


function selectAllItems(items){//2005.6.14
	//var items= document.all.itemselect;
	for(i=0;i<items.length;i++){
		items[i].checked=event.srcElement.checked;
		
	}
	
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
		theNewRow.cells[0].innerHTML=tit+"<br><br><img onClick='delCurExpRow()' alt='关闭' style='cursor:hand' src='/ydmis/images/expbtnclose.gif'>";

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

	url= "/ydmis/js/CalendarDlg.html";
	
	if(document.location.protocol=="file:")url= "../js/CalendarDlg.html"; //调试用
	
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
		case "sh":
			if (czid == false){alert(msg1+"审核的项目！");return false}
			popUpWindow(theUrl+czid);
			break;
	}
	return false;
}


//////////////////////////////////
//打开弹出窗口 05.002 SOMAX
//////////////////////////////////

function popUpWindow(URLStr,width, height)
{
	if(width==undefined)width=650;
	if(height==undefined)height=500;
	var left=(screen.width - width)/2;
	var top=(screen.height - height)/2;
  
  var srtWinName = cwCellTopTitTxt.innerText;//05.002
  srtWinName =srtWinName.replace('/[/\\\.\-\(\)（）]/g','');//05.003
  event.srcElement.openwin = open(URLStr, srtWinName , 'toolbar=no,location=no,directories=no,status=yes,menub ar=no,scrollbar=no,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
  event.srcElement.openwin.focus();
}





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
//生成option的html代码 05.002 SOMAX 05.4.22
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
	var selectedStr="";
	var hasSelected=false;
	for (i=0;i<arr.length;i++){
		if(arr[i]==dbStr){
			selectedStr="selected";
			hasSelected=true;
		}else{
			selectedStr="";
		}
		tempHtml+="<option value='"+ arrV[i] +"' "+ selectedStr +">"+ arr[i]+"</option>";
	}
	if( !hasSelected &&dbStr!=""){
		tempHtml+="<option value='"+ dbStr +"' selected>"+ dbStr +"</option>";

	}
	return tempHtml;
}


////////////////////////////////////////
////////////////////////////////////////
function w(str){
	document.write(str);	
}





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
        popUpWindow(url,250,350);
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
