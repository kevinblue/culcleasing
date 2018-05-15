//////////////////////////////////
//打开日期输入组件 05.002 SOMAX 05.04.27
//////////////////////////////////
function openCalendar(ctrlobj,p)
{
	showx = event.screenX - event.offsetX - 0 ; 
	showy = event.screenY - event.offsetY - 20; 
	newWinWidth = 300 + 4 + 18;

	url= "/zdbmis/javascript/calendar/CalendarDlg.html";
	if(p==undefined)p="../../";
	if(document.location.protocol=="file:")url= p+"javascript/calendar/CalendarDlg.html"; //本地调试用
	
	retval = window.showModalDialog(url, ctrlobj , "dialogWidth:260px; dialogHeight:250px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:no;scrollbars:no;Resizable=no;"  );


}
 

/////////////////////////////////
// 确认关闭窗口 05.001 SOMAX
/////////////////////////////////
function cfClose(){
	if(confirm('确定要取消修改吗？'))window.close();
}


//////////////////////////////////////////////////////////////////
//生成option的html代码 05.003 SOMAX 07.1.16 
//比较数据库中查出的字符串并设置selected
// dbStr 数据库中查出的字符串
// arrStr 用于显示的option字符串组,用"|"隔开,如"aaa|bbb|ccc|ddd"
// arrVStr 用于value的字符串组,当缺少时等于arrStr
// dWrite 输出模式，如果是 1 则直接写出html，其他则返回字符串"tempHtml"
// comp 比较模式 与arrVStr比较（0）或与arrVStr比较 <- add 20070411 somax
/////////////////////////////////////////////////////////////////

function mSetOpt(dbStr,arrStr,arrVStr,dWrite,comp){
	var arr=arrStr.split("|");
	arrVStr=(arrVStr!=undefined && arrVStr!="")?arrVStr:arrStr;
	var arrV=arrVStr.split("|");
	var tempHtml="";
	var selectedStr="";
	var hasSelected=false;
	var compStr="";
	for (i=0;i<arr.length;i++){
		if(comp==0){
			compStr=arrV[i];
		}else{
			compStr=arr[i];
		}
		if(compStr==dbStr){
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
	
	if(dWrite==1){document.write(tempHtml)}else{return tempHtml}; //20070116 somax
}

////////////////////////////////////////
function w(str){
	document.write(str);	
}



///////////////////////////////////////
//数据操作 增加 删除 修改 05.006 SOMAX 07.10.19
//dataHander('add'|'del'|'mod'|'sh','xx_add.jsp','itemsName','additionalURLstr')
///////////////////////////////////////
function dataHander(act,theUrl,itemsName,str)
{
	var czid = false;
	var msg1 = "没有可";
	objItem=document.getElementsByName(itemsName);//070119
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
//打开弹出窗口 05.004 SOMAX 070119
//////////////////////////////////

function popUpWindow(URLStr,width, height,scrollmod)
{
	oT=document.getElementById("cellTitTxt");
	if(oT==null)return;
	if(width==undefined)width=650;
	if(height==undefined)height=550;
	if(scrollmod==undefined)scrollmod="yes";//070127 somax
	var left=(screen.width - width)/2;
	var top=(screen.height - height)/2;
  var srtWinName = (document.all)?oT.innerText:oT.textContent;//070125 somax
  srtWinName = srtWinName.replace('/[/\\\.\-\(\)（）]/g','');//05.003
  var sElm=(event.srcElement)?event.srcElement:event.target;//070125 somax
  //alert(sElm)
  sElm.openwin = open(URLStr, srtWinName , 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbar='+scrollmod+',resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
  sElm.openwin.focus();
}



//////////////////////////////////////
// NEW 设置上传组件的数量 05.002 SOMAX
//////////////////////////////////////
/* 上传组件页面元素
<input type="button" onclick="insRow('tabUpFile')" value="增加上传数"  name="addFileNum">
<table id="tabUpFile" border="0"></table>
<script>insRow('tabUpFile')</script>
*/

function insRow(tableName,accepttype)
{
if(accepttype==undefined)accepttype="zip|doc|rar";
var theTable = document.getElementById(tableName);
var i = theTable.rows.length;
if (i>100){
	alert('不能同时上传太多文件！');
	return;
}
var x = theTable.insertRow(i);
var y = x.insertCell(0);
y.innerHTML='<input name="filename'+ (i+1) +'" type="file" size="50" dataType="Filter" accept="'+accepttype+'"  >';
if(i>0)y.innerHTML+='<img class="click" src="../../style/default/images/sbtn_close.gif" onclick="delRow()" width="19" height="19" title="移除">';//有新增多条的功能 mod 20070313 somax
//y.innerHTML='<input name="filename'+ (i+1) +'" type="file" size="50" dataType="Filter" accept="zip|doc|rar" >';//无新增多条的功能
//document.getElementById('addFileNum').style.display='none';//屏蔽新增多条的功能
}

function delRow()//2005.05.18
{
var theTable= event.srcElement.parentNode.parentNode.parentNode;
var i = event.srcElement.parentNode.parentNode.rowIndex;
theTable.deleteRow(i);
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
        popUpWindow(url,280,350);
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
        popUpWindow(url,280,350);
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
 popUpWindow(url,280,350);
}
//////////////////////////////////


///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）  05.003 SUPER  --用于首层目录
///////////////////////////////////////
function SpecialDataWindow6(selfldname,tblname,listfld,listvalue,filterfld,filtertype,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象
{
url="func/specialdatawindow.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
 popUpWindow(url,280,350);
}
//////////////////////////////////


///////////////////////////////////////
//弹出数据检索选择窗口（含列表和查询）  07.001 SUPER
///////////////////////////////////////
function SpecialDataWindow5(selfldname,tblname,listfld,listvalue,filterfld,filtertype,wherestr,orderfld,dataobj,valueobj)
//selfldname--检索字段名称
//tblname-- 所查数据表名  
//listfld--list显示字段 listvalue--list实填值字段 filterfld--过滤字段 filtertype--过滤条件类型 orderfld--排序字段
//dataobj--返回数据显示对象  valueobj--返回数据实际值对象  wherestr--默认查询条件
{

url="../../func/specialdatawindow5.jsp?sf="+selfldname+"&tn="+tblname+"&lf="+listfld+"&lv="+listvalue+"&ff="+filterfld+"&ft="+filtertype+"&ws="+wherestr+"&of="+orderfld+"&do="+dataobj+"&vo="+valueobj
        popUpWindow(url,280,350);
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
        popUpWindow(url,280,350);
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
        popUpWindow(url,280,350);
}
//////////////////////////////////



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




// Node object

function Node(id, pid, name, url, title, target, icon, iconOpen, open) {

	this.id = id;

	this.pid = pid;

	this.name = name;

	this.url = url;

	this.title = title;

	this.target = target;

	this.icon = icon;

	this.iconOpen = iconOpen;

	this._io = open || false;

	this._is = false;

	this._ls = false;

	this._hc = false;

	this._ai = 0;

	this._p;

};





/*//////////////////////////////////////////////////
选择显示[其他]输入框  05.001 SOMAX 05.4.22
说明：如果select内容是“其他”，则显示input框让用户输入
范例：<select name="select1" onChange="setSelData(this,input1)" >.....</select>
	  <input style="display:none" id="input1" .... >
/*//////////////////////////////////////////////////
function setSelData(objSel,objInp){
	var disp;
	if(objInp.type!="object")objInp=document.getElementById(objInp); //070126 somax
  	objInp.value=objSel.value
	if (objSel.value=="其它"){
		disp=""
	}else{
		disp="none"
	}
	objInp.style.display=disp;
}



//**//////////////////////////////
function fixContent(obj,mod){
	var obj=document.getElementById(obj);
	var str="";
	//if(obj!=null)return;
		if(mod==1){
			str=obj.value.replace(/\r\n/g,'[BR]');
			obj.value=str;
		}else if(mod==-1){
			str=obj.value.replace(/\[BR\]/g,'\r\n');
			obj.value=str;
		}else if(mod==0){
			str=obj.innerHTML.replace(/\[BR\]/g,'<br>');
			obj.innerHTML=str;
		}else if(mod==2){
			var valu=document.getElementById("divHznr").innerHTML;
			str=valu.replace(/\r\n/g,'<br><!-- -->');
			//alert(obj.innerHTML);
			document.getElementById("divHznr").innerHTML=str//.replace(/\r\n/g,'<br>');
		}
		
			//alert(obj.innerHTML.substr(obj.innerHTML.search(Chr(10)),10));
		
			//alert(obj.innerHTML)
		
}







//////////////////////////// End UI///////////////////////////////


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
		theNewRow.cells[0].innerHTML=tit+"<br><br><img onClick='delCurExpRow()' alt='关闭' style='cursor:hand' src='../../style/default/images/expbtnclose.gif'>";

}




 
///////----------- similar "event" for firefox  -----------
if(window.Event){ window.constructor.prototype.__defineGetter__("event", function(){ var o = arguments.callee.caller; var e; while(o != null){ e = o.arguments[0]; if(e && (e.constructor == Event || e.constructor == MouseEvent)) return e; o = o.caller; } return null; }); }
///////----------------------------------------------------



