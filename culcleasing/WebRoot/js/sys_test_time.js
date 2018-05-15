//判断当前选择的日期与系统当前日期相差不在1年内
function validDate(chuanDate,date){
	//var now = Date().getDate();
	var now =date
	//var choiDate = $(":input[name='plan_date']").val();
	var choiDate = chuanDate
	var difDays = DateDiff(now, choiDate);
	//alert("当前日期："+now+"__"+choiDate+"相差"+difDays);
	if( choiDate < now ){
		alert("计划日期不能小于当前日期！系统将默认收/付时间为当前日期！");
		//clearText
		$(":input[name='plan_date']").val(now);
	}else if( difDays>300 ){
		alert("请选择有效的计划收/付款日期，超过当前系统时间较长！");
		//$(":input[name='plan_date']").val(now);
		//$(":input[name='plan_date']").val("");
	}
}
//计算天数差
function DateDiff(beginDate, endDate)   //计算天数的函数
{    
    //beginDate和endDate都是2007-8-10格式
    var arrbeginDate, Date1,Date2,arrendDate,iDays 
    arrbeginDate= beginDate.split("-") 
    Date1= new Date(arrbeginDate[1]+'-'+arrbeginDate[2]+'-'+arrbeginDate[0])    //转换为8-10-2007格式
    arrendDate= endDate.split("-") 
    Date2= new Date(arrendDate[1]+'-'+arrendDate[2]+'-'+arrendDate[0]) 
    iDays = parseInt(Math.abs(Date1- Date2)/1000/60/60/24)        //转换为天数 
    return iDays 
}