//两个日期的月份差
function fun_monthDiff(begindate,enddate){
		var v_begin = begindate.split("-");
		var v_end = enddate.split("-");
		return convCheck(v_begin,v_end);
}
function check(date){
        var v_year = date[0];
        var v_month = date[1];
        var v_day = date[2];
        var temp1 = v_year+v_month+v_day;
        return temp1;
}
function convCheck(begin,end){
       // var beginTime  = Number(check(begin));
       // var endTime = Number(check(end));
       // return parseInt((endTime - beginTime)/100);
	var v_year_b=begin[0];
	var v_year_e=end[0];
        var v_month_b = begin[1];
        var v_month_e = end[1];
	return parseInt((Number(v_year_e) - Number(v_year_b))*12+(Number(v_month_e) - Number(v_month_b)));


}
//租赁期限计算
function fun_term(varyear){
	var income_number = parseInt(document.forms[0].income_number.value);
	var income_number_year = parseInt(varyear);
	var allTerm = income_number*12/income_number_year;
	var begindate = document.forms[0].charge_first_date.value;
	var enddate = document.forms[0].rent_first_date.value;
	var diff = fun_monthDiff(begindate,enddate);
	var rent_interval = 12/income_number_year;
	if(diff>rent_interval){
		allTerm=allTerm+(diff-rent_interval);
	}else if(diff<rent_interval){
		allTerm=allTerm-(rent_interval-diff);
	}
	document.forms[0].lease_term.value = allTerm;
}



//租赁合同总金额 = 总租金+首付款+手续费
function fun_contract(){
	var allRent = 0.0;
	var varrent = 0.0;
	var number = 0.0;
	var first_payment = 0.0;
	var handling_charge = 0.0;
	var supervision_fee = 0.0;
	var insurance_lessee = 0.0;
	var nominalprice = 0.0;
	if(document.forms[0].rent.value!=''){
	varrent = parseFloat(document.forms[0].rent.value);
	}else{
	varrent = 0;
	}
	allRent = parseFloat(document.forms[0].allRent.value);
	first_payment = parseFloat(document.forms[0].first_payment.value);
	handling_charge = parseFloat(document.forms[0].handling_charge.value);
	supervision_fee = parseFloat(document.forms[0].supervision_fee.value);
	insurance_lessee = parseFloat(document.forms[0].insurance_lessee.value);
	nominalprice = parseFloat(document.forms[0].nominalprice.value);
	document.forms[0].total_amt.value =ForDight(allRent+ first_payment+handling_charge,2);
}
//我司实际需动用资金=申请金额（设备金额）-首付款-保证金-手续费-厂商返利-监管费+咨询费+保险费(我司支付)+其他费用
function fun_charge(){
	var equip_amt = 0.0;
	var first_payment = 0.0;
	var caution_money = 0.0;
	var handling_charge = 0.0;
	var return_amt = 0.0;
	var supervision_fee = 0.0;
	var consulting_fee = 0.0;
	var insurance_lessor = 0.0;
	var other_fee = 0.0;
	var first_rent = 0.0;
	var period_type ="";
	period_type = document.forms[0].period_type.value;
	if(period_type=="1"){
		first_rent = parseFloat(document.forms[0].rent.value);
	}
	eqump_amt = parseFloat(document.forms[0].equip_amt.value);
	first_payment = parseFloat(document.forms[0].first_payment.value);
	caution_money = parseFloat(document.forms[0].caution_money.value);
	handling_charge = parseFloat(document.forms[0].handling_charge.value);
	return_amt = parseFloat(document.forms[0].return_amt.value);
	supervision_fee = parseFloat(document.forms[0].supervision_fee.value);
	consulting_fee = parseFloat(document.forms[0].consulting_fee.value);
	insurance_lessor = parseFloat(document.forms[0].insurance_lessor.value);
	other_fee = parseFloat(document.forms[0].other_fee.value);
	document.forms[0].actual_fund.value = ForDight(eqump_amt-first_payment-caution_money-handling_charge-return_amt-supervision_fee+consulting_fee+insurance_lessor+other_fee,2);
}
//原年平均收益（静态收益）目前由用户手工填写
function fun_earn(){
	var rough_earn = 0.0;
	var actual_fund = 0.0;
	var lease_term = 0.0;
	fun_charge();
	rough_earn = parseFloat(document.forms[0].rough_earn.value);
	actual_fund = parseFloat(document.forms[0].actual_fund.value);
	lease_term = parseFloat(document.forms[0].lease_term.value);
	if(actual_fund!=""&&actual_fund!="0"&&lease_term!=""&&lease_term!="0"){ 
  		document.forms[0].year_earn.value =ForDight(rough_earn/actual_fund/lease_term*12*100,2); 
 	}else{ 
		document.forms[0].year_earn.value ="0"; 
	} 

}
//获取总租金，如果有调整，用调整后的总租金，否则用租金*还租次数
function fun_subRent(varall){
	if(varall!=null&&varall!=''){
		document.forms[0].allRent.value = varall;
	}else{
		document.forms[0].allRent.value = parseFloat(document.forms[0].rent.value)*parseFloat(document.forms[0].income_number.value);
	}
}
//租金计算方式0为已知利率算租金1已知租金算利率
function fun_style(varvalue){
	var varrate = document.forms[0].year_rate.value;
	var varrent = document.forms[0].rent.value;
	if(varvalue=="0"){
		if(varrate!=""){
			fun_rent();
		}
	}else if(varvalue=="1"){
		if(varrent!=""){
			fun_interest();
		}
	}
}

//计算租金0期末1期初
function fun_returnRent(rent_rate,leng,pcpl,other,period_type){
	var varreturn = "";
	if(period_type=="0"){
		varreturn = ForDight(fun_pmtStart(rent_rate,leng,pcpl,0),2);
	}else{
		varreturn = ForDight(fun_pmtEnd(rent_rate,leng,pcpl,0),2);
	}
	return leng!=0&&leng!=""?varreturn:0;
}
//期末计算公式
function fun_pmtStart(rate,volume,rent,futureValue){
	if(rate!=0){
		return (rate*Math.pow((1+rate),volume))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
	}else{ 
		return 0;
	}
}
//期初计算公式
function fun_pmtEnd(rate,volume,rent,futureValue){
	if(rate!=0){
		return (rate*Math.pow((1+rate),(volume-1)))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
	}else{ 
		return 0;
	}
}
//小数点后保留位数
function ForDight(Dight,How){       
	Dight = Math.round(Dight*Math.pow(10,How))/Math.pow(10,How);       
	return Dight;       
}
//根据设备金额和百分比求金额
function getMoney(varvalue,varobject,varBase){
	varobject.value=ForDight(varBase*varvalue/100,2);
}
//根据设备金额和金额求百分比
function fun_getRadio(varvalue,varobject,varBase){
	if(varvalue!=''&&varBase!=''&&varBase!=0){
		varobject.value=ForDight(varvalue/varBase*100,6);
	}else{
		varobject.value =0;
	}
}
//varA-varB
function fun_sub(varA,varB,varSub){
	varSub.value = ForDight(varA-varB,2);
}
//根据交易结构计算租金
function fun_rent(){
	var rent_style = document.forms[0].rent_style.value;
	if(rent_style=="0"){
		var pcpl = parseFloat(document.forms[0].lease_money.value);
		var leng = parseFloat(document.forms[0].lease_term.value);
		var volume = parseInt(document.forms[0].income_number_year.value);
		var period_type = document.forms[0].period_type.value;
		var rent_volume = parseInt(document.forms[0].income_number.value);
		var ivarvol = parseInt(document.forms[0].lease_term.value);
		var varRate = document.forms[0].year_rate.value;
		var rent_rate;
		if(varRate!=""){
			rent_rate = (parseFloat(varRate)/100/volume);
		}else{
			rent_rate = 0;
		}
		var varrent;
		if(rent_rate!=""&&rent_volume!=""&&pcpl!=""){
			varrent = fun_returnRent(rent_rate,rent_volume,pcpl,0,period_type);
		}else{
			varrent = 0;
		}
		document.forms[0].rent.value = varrent;
	}
}
//根据交易结构计算总租金
function fun_allRent(varyear_rate,varrent_volume,varpcpl){
	var rent_style = document.forms[0].rent_style.value;
	if(rent_style=="0"){
		var pcpl = parseFloat(varpcpl);
		var leng = parseFloat(document.forms[0].lease_term.value);
		var volume = parseInt(document.forms[0].income_number_year.value);
		var period_type = document.forms[0].period_type.value;
		var rent_volume = parseInt(varrent_volume);
		var ivarvol = parseInt(document.forms[0].lease_term.value);
		var varRate = varyear_rate;
		var rent_rate;
		if(varRate!=""){
			rent_rate = (parseFloat(varRate)/100/volume);
		}else{
			rent_rate = 0;
		}
		var varrent;
		if(rent_rate!=""&&rent_volume!=""&&pcpl!=""){
			varrent = fun_returnRent(rent_rate,rent_volume,pcpl,0,period_type);
		}else{
			varrent = 0;
		}
		document.forms[0].rent.value = varrent;
	}
}
//概算本金变化后重新计算租金
function fun_corpusToRent(){
	fun_rent();
}

//期初（期末）支付变更后重新计算租金
function fun_period_rent(varValue,varUrl){
	var rent_style = document.forms[0].rent_style.value;
	if(rent_style=="0"){
		var pcpl = parseFloat(document.forms[0].lease_money.value);
		var leng = parseFloat(document.forms[0].lease_term.value);
		var volume = parseInt(document.forms[0].income_number_year.value);
		var period_type = varValue;
		var rent_volume = parseInt(document.forms[0].income_number.value);
		var ivarvol = parseInt(document.forms[0].lease_term.value);
		var varRate = document.forms[0].year_rate.value;
		var rent_rate = (parseFloat(varRate)/100/volume);
		document.forms[0].rent.value = fun_returnRent(rent_rate,rent_volume,pcpl,0,period_type);
	}else{
		var pcpl = parseFloat(document.forms[0].lease_money.value);
		var leng = parseFloat(document.forms[0].lease_term.value);
		var volume = parseInt(document.forms[0].income_number_year.value);
		var period_type =varValue;
		var rent_volume = parseInt(document.forms[0].income_number.value);
		var ivarvol = parseInt(leng);
		var returnNo= 12.0/volume;
		var varObject = document.forms[0].rent.value;
		xmlHttp = GetXmlHttpObject();
		var url = varUrl+"?Nper="+rent_volume+"&Pv="+pcpl+"&Fv="+0+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
	  	xmlHttp.onreadystatechange = stateChanged;	
	  	xmlHttp.open("POST",url,true);
	  	xmlHttp.send(null);
	}
}
//根据租金计算年利率
function fun_interest_rent(varUrl){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number_year.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume =  parseInt(document.forms[0].income_number.value);;
	var ivarvol = parseInt(leng);
	var returnNo= 12/volume;
	var varObject = document.forms[0].rent.value;
	xmlHttp = GetXmlHttpObject();
	var url = varUrl+"?Nper="+rent_volume+"&Pv="+pcpl+"&Fv="+0+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
  	xmlHttp.onreadystatechange = stateChanged;	
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);
}
//根据租金计算年利率varpcpl(租金概算本金)varrent_volume(还租次数)varrent(每期租金)
function fun_all_interest_rent(varUrl,varpcpl,varrent_volume,varrent){
	var pcpl = parseFloat(varpcpl);
	var volume = parseInt(document.forms[0].income_number_year.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume =  parseInt(varrent_volume);
	var ivarvol = parseInt(leng);
	var returnNo= 12/volume;
	var varObject = varrent;
	xmlHttp = GetXmlHttpObject();
	var url = varUrl+"?Nper="+rent_volume+"&Pv="+pcpl+"&Fv="+0+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
  	xmlHttp.onreadystatechange = stateChanged;	
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);
}
//ajax
var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest){
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
////返回年利率
function stateChanged(){
	if(xmlHttp.readyState == 4)	{
		var vDiv = document.createElement("DIV");
	 	vDiv.innerHTML = xmlHttp.responseText;
		var returnvalue = vDiv.innerText;
		document.forms[0].year_rate.value = returnvalue;
	}	
}
//提交交易结构数据
function fun_rentSub_rent(varUrl,varTarget,vartype,obj){
	var varrate = document.forms[0].year_rate.value;
	var varrent = document.forms[0].rent.value;
	if(varrate!=""&&varrent!=""){
		document.forms[0].savetype.value=vartype;
		document.forms[0].action=varUrl;
		document.forms[0].target=varTarget;
		document.forms[0].submit();
	}else{
		alert("租金和利率不能为空");
		return false;
	}
}
//提交交易结构数据并计算我司实际需动用资金
function fun_prodRent(){
	var caution_money_ratio = parseFloat(document.forms[0].caution_money_ratio.value);
	var lessee_caution_ratio = parseFloat(document.forms[0].lessee_caution_ratio.value);
	var vndr_caution_ratio = parseFloat(document.forms[0].vndr_caution_ratio.value);
	var sale_caution_ratio = parseFloat(document.forms[0].sale_caution_ratio.value);
	var caution_deduction_ratio = parseFloat(document.forms[0].caution_deduction_ratio.value);
	if((lessee_caution_ratio+vndr_caution_ratio+sale_caution_ratio)>caution_money_ratio){
		alert("供应商代理商客户保证金之和应小于租赁保证金");
		return false;
	}
	if(caution_deduction_ratio>caution_money_ratio){
		alert("保证金抵扣金额应小于租赁保证金");
		return false;
	}
	var rent_value = document.forms[0].rent.value;
	var rent_style = document.forms[0].rent_style.value;
	fun_charge();
	fun_earn();
	if(rent_value!=""){
		if(rent_style=="1"){
			fun_interest();
		}
		fun_rentSub();
	}else{
		alert("租金不能为空");return false;
	}
}
//计算年利率
function fun_prodRentInterest(){
	var rent_value = document.forms[0].rent.value;
	var rent_style = document.forms[0].rent_style.value;
	if(rent_value!=""){
		if(rent_style=="1"){
			fun_interest();
		}
	}else{
		alert("租金不能为空");return false;
	}
}
//计算二期租金支付日
function fun_secDate(varInte){
	varFirst = document.forms[0].charge_first_date.value;
	var intInte = 0;
	if(varInte!=""&&varInte!=0){
		intInte = 12/parseInt(varInte);
	}
	var firstDate = StringToDate(varFirst);
	firstDate.setMonth(firstDate.getMonth()+intInte);
	document.forms[0].rent_first_date.value = firstDate.toText("yyyy-MM-dd");
}
function StringToDate(DateStr)   
{    
   
    var converted = Date.parse(DateStr);   
    var myDate = new Date(converted);   
    if (isNaN(myDate))   
    {    
        //var delimCahar = DateStr.indexOf('/')!=-1?'/':'-';   
        var arys= DateStr.split('-');   
        myDate = new Date(arys[0],--arys[1],arys[2]);   
    }   
    return myDate;   
}
Date.prototype.toText = function(style){
    if (style == null) style = 'yyyy-MM-dd hh:mm';
    var compare = {
         'y+' : 'y', 
         'M+' : 'M',  
         'o+' : 'o',  
         'd+' : 'd',  
         'D+' : 'D', 
         'h+' : 'h',  
         'H+' : 'H',  
         'm+' : 'm',  
         'i+' : 'i',  
         's+' : 's',
         'S+' : 'S' 
    };
    var result = {
         'y':this.getFullYear(),
         'M':(this.getMonth() < 9) ? ("0" + (1+this.getMonth())) : (1+this.getMonth()),
         'o':(1+this.getMonth()),
         'd':(this.getDate() < 10) ? ("0" + this.getDate()) : this.getDate(),
         'D':this.getDate(),
         'h':(this.getHours()< 10) ? ("0" + this.getHours()):this.getHours(),
         'H':this.getHours(),
         'm':(this.getMinutes()<10)? ("0" + this.getMinutes()):this.getMinutes(),
         'i':this.getMinutes(),
         's':(this.getSeconds()<10)? ("0" + this.getSeconds()):this.getSeconds(),
         'S':this.getSeconds()
    };
    var tmp = style;
    for( var k in compare){
        if (new RegExp('(' + k + ')').test(style)) {
            tmp = tmp.replace(RegExp.$1,result[compare[k]]);
       };
   };
   return tmp;

}
//填写保证金比率率后系统自动添加承租客户的保证金比率和保证金抵扣的比率
function fun_margin(){
	var caution = document.forms[0].caution_money_ratio.value;
	document.forms[0].lessee_caution_ratio.value = caution;
	document.forms[0].caution_deduction_ratio.value = caution;
}
//填写保证金后系统自动添加承租客户的保证金和保证金抵扣金额
function fun_marginMoney(){
	var caution = document.forms[0].caution_money.value;
	document.forms[0].lessee_caution_money.value = caution;
	document.forms[0].caution_deduction_money.value = caution;
}
//如果交易结构中有年利率、首付款、保证金等信息，一旦设备金额变更，提示用户重新计算
function fun_equipChange(){
	var year_rate = document.forms[0].year_rate.value;
	var first_payment = document.forms[0].first_payment.value;
	var caution_money = document.forms[0].caution_money.value;
	var handling_charge = document.forms[0].handling_charge.value;
	var return_amt = document.forms[0].return_amt.value;
	var supervision_fee = document.forms[0].year_rate.value;
	if((year_rate!=""&&year_rate!="0")||(first_payment!=""&&first_payment!="0")||(caution_money!=""&&caution_money!="0")||(handling_charge!=""&&handling_charge!="0")||(return_amt!=""&&return_amt!="0")||(supervision_fee!=""&&supervision_fee!="0")){
		alert("设备金额已改变，请确认其他信息是否正确");
	}
}