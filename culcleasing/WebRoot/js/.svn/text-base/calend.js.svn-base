function openCalendar(ctrlobj,p)
{
	showx = event.screenX - event.offsetX - 0 ; 
	showy = event.screenY - event.offsetY - 20; 
	newWinWidth = 300 + 4 + 18;
   // alert("test");
	url= "../../js/CalendarDlg.html";
	//local test
	//if(p==undefined)p="../../";
	//if(document.location.protocol=="file:")url= p+"javascript/calendar/CalendarDlg.html"; //本地调试用
	
	retval = window.showModalDialog(url, ctrlobj , "dialogWidth:260px; dialogHeight:250px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:no;scrollbars:no;Resizable=no;"  );


}