<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>还款计划-修改</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//填写本金后计算利息
function calcMoney(){
	var refund_corpus = $(":input[name='refund_corpus']").val();
	//alert("还款本金"+refund_corpus);
	var reg = /^[0-9]+(\.[0-9]+)?$/;  
	if( isNaN(refund_corpus) || !reg.test(refund_corpus)){  
        alert('还本金额填写格式有误！');  
        $(":input[name='refund_corpus']").val('0');
        $(":input[name='refund_corpus']").focus();  
    }else{
      	//获取还款日期
      	var refund_plan_date = $(":input[name='refund_plan_date']").val();
      	if(refund_plan_date==''){
      		alert("请选择本次还款日期！");
      	}else{
	      	var drawings_date = $(":input[name='drawings_date']").val();
	      	var drawings_fact_rate = $(":input[name='drawings_fact_rate']").val();
	      	//alert("提款日期"+drawings_date+" 提款利率"+drawings_fact_rate);
	      	var dayObj = DateDiff(drawings_date, refund_plan_date);
	      	//alert("付息天数"+dayObj);
	      	var resInterest = calcInterest(refund_corpus, drawings_fact_rate, dayObj);
	      	//alert("利息计算结果"+resInterest);
	      	var refund_otherfee_money = $(":input[name='refund_otherfee_money']").val();
	      	if(isNaN(refund_otherfee_money) || !reg.test(refund_otherfee_money)){
	      		alert('其他费用金额填写格式有误！');  
		        $(":input[name='refund_otherfee_money']").val('0');
		        $(":input[name='refund_otherfee_money']").focus();  
	      	}else{
		      	//赋值操作
				setVal(refund_corpus,resInterest, refund_otherfee_money);	      	
	      	}
      	}
    }
}
//其他费用变化时更新总额
function calcTotalMoney(){
	var reg = /^[0-9]+(\.[0-9]+)?$/;  
	var refund_otherfee_money = $(":input[name='refund_otherfee_money']").val();
    if(isNaN(refund_otherfee_money) || !reg.test(refund_otherfee_money)){
     	alert('其他费用金额填写格式有误！');  
        $(":input[name='refund_otherfee_money']").val('0');
        $(":input[name='refund_otherfee_money']").focus();  
    }else{
     	//赋值操作
		$(":input[name='refund_subtotal']").val(FloatAdd($(":input[name='refund_money']").val(),refund_otherfee_money));    	
    }
}

//利息计算
function calcInterest(corpusObj,rateObj,dayObj){
	var resVal = 0;
	//X=P*R*(Day/360)
	//P:本金
	//R:利率
	//Day:付息天数（还款日期-提款日期）"
	resVal = (corpusObj*1.00)*(rateObj*1.00)*(dayObj*1.00/360)
	resVal = returnFloat2(resVal);
	return resVal;
}

function returnFloat0(value) {  //将小数点清零   
    value = Math.round(parseFloat(value));   
    return value;   
   }   
  
function returnFloat1(value) { //保留一位小数点   
    value = Math.round(parseFloat(value) * 10) / 10;   
    if (value.toString().indexOf(".") < 0)   
     value = value.toString() + ".0";   
    return value;   
   }   
  
function returnFloat(value){  //保留两位小数点   
    value = Math.round(parseFloat(value) * 100) / 100;   
    if (value.toString().indexOf(".") < 0) {   
     value = value.toString() + ".00";   
    }   
    return value;   
   }   
  
function returnFloat2(value) { //保留两位小数点，一位小数自动补零   
    value = Math.round(parseFloat(value) * 100) / 100;   
    var xsd = value.toString().split(".");   
    //Ext.log(xsd.length);   
    if(xsd.length==1){   
     value = value.toString()+".00";   
     return value;   
    }   
    if(xsd.length>1){   
     if(xsd[1].length<2){   
      value = value.toString()+"0";     
     }   
     return value;   
    }   
   }   

//保留N位小数点   
function returnFloat(value,number){   
 var divisor = '1';   
 for(i = 1; i <= number; i++){   
  divisor += '0';   
 }   
 divisor = parseInt(divisor);   
 value = Math.round(parseFloat(value)*divisor)/divisor;   
 if(value.toString().indexOf(".") < 0 && number > 0){          
  value = value.toString() + '.';   
  for(i = 1; i <= number; i++){   
   value += '0';   
  }   
 }   
 return value;   
}  

//计算利息进行赋值操作
function setVal(refund_corpus,refund_interest,refund_otherfee_money){
	//利息金额
	$(":input[name='refund_interest']").val(refund_interest);
	//本息合计
	$(":input[name='refund_money']").val(FloatAdd(refund_corpus, refund_interest));
	//本次还款合计
	$(":input[name='refund_subtotal']").val(FloatAdd(FloatAdd(refund_corpus, refund_interest),refund_otherfee_money));
}

//浮点数加法运算   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
} 
 //浮点数减法运算   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //动态控制精度长度   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
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
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//提取参数drawings_id,doc_id
String item_id = getStr( request.getParameter("item_id") ); 
String drawings_id = getStr( request.getParameter("drawings_id") );

//加载当前还款计划数据
String drawings_date = "";
String refund_list = "";//期数
String refund_rate = ""; //还款利率
String refund_plan_date = ""; //还款日期
String refund_corpus = "";//本金
String refund_interest = ""; //利息
String refund_money = "";//本息合计
String refund_otherfee_money = "";//其他费用金额
String refund_otherfee_type = "";//其他费用类型
String refund_subtotal = "";//本次还款小计
String refund_remark = "";//备注

String col_str="refund_plan_id,refund_list,refund_plan_date,refund_rate,refund_corpus";
col_str += ",refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,remark,";
col_str += "(select drawings_date from financing_drawings where drawings_id=financing_refund_plan_temp.drawings_id) as drawings_date";

sqlstr = "Select "+ col_str +" from financing_refund_plan_temp where refund_plan_id='"+item_id+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	drawings_date = getDBDateStr(rs.getString("drawings_date"));
	refund_list = getDBStr(rs.getString("refund_list"));
	refund_rate = getDBStr(rs.getString("refund_rate"));
	refund_plan_date = getDBDateStr(rs.getString("refund_plan_date"));
	refund_corpus = getDBStr(rs.getString("refund_corpus"));
	refund_interest = getDBStr(rs.getString("refund_interest"));
	refund_money = getDBStr(rs.getString("refund_money"));
	refund_otherfee_money = getDBStr(rs.getString("refund_otherfee_money"));
	refund_otherfee_type = getDBStr(rs.getString("refund_otherfee_type"));
	refund_subtotal = getDBStr(rs.getString("refund_subtotal"));
	refund_remark = getDBStr(rs.getString("remark"));
}
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">还款计划&gt; 修改</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="refund_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="savetype" value="updRefund">
<input type="hidden" name="drawings_date" value="<%=drawings_date %>">
<input type="hidden" name="drawings_fact_rate" value="<%=refund_rate %>">

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">期数</td>
    <td scope="row">
    	<input type="text" name="refund_list" style="width:150px;" dataType="Integer" Require="ture" readonly="readonly" value="<%=refund_list %>">
	    <span class="biTian">*</span>
    </td>
    
    <td scope="row">还款日期</td>
    <td scope="row">
		<input name="refund_plan_date" type="text" style="width:150px;" readonly="readonly" dataType="Date" Require="ture" value="<%=refund_plan_date %>"
	    	onpropertychange="calcMoney()">
	    <img  onClick="openCalendar(refund_plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
	    height="19" border="0" align="absmiddle">
	    <span class="biTian">*</span>
    </td>
  </tr>
     
  <tr>
    <td scope="row" id="bj_1">还本金额</td>
    <td scope="row">
	    <input name="refund_corpus" style="width:150px;" type="text" value="<%=refund_corpus %>" dataType="Money" Require="ture" onchange="calcMoney()">
	    <span class="biTian">*</span>
    </td>
    
    <td scope="row">付息金额</td>
    <td scope="row">
    	<input name="refund_interest" style="width:150px;" type="text" value="<%=refund_interest %>" readonly="readonly">
   		<span class="biTian">*</span>
    </td>
  </tr>
  
  <tr>
  	<td scope="row">本息合计</td>
    <td scope="row" colspan="3">
	    <input name="refund_money" style="width:150px;" type="text" value="<%=refund_money %>" readonly="readonly">
    </td>
  </tr>
     
  <tr>
    <td scope="row">其他费用金额</td>
    <td scope="row">
	    <input name="refund_otherfee_money" style="width:150px;" type="text" value="<%=refund_otherfee_money %>" dataType="Money" onchange="calcTotalMoney()">
    </td>
    
    <td scope="row">其他费用类型</td>
    <td scope="row">
  	  <select style="width:150px;" name="refund_otherfee_type" id="refund_otherfee_type"></select>
	  <script language="javascript" class="text">
	 	 dict_list("refund_otherfee_type","HKFeetype","<%=refund_otherfee_type %>","title");
	  </script>
    </td>
  </tr>
  
   <tr>
  	<td scope="row">本次还款总计</td>
    <td scope="row" colspan="3">
	    <input name="refund_subtotal" style="width:150px;" type="text" value="<%=refund_subtotal %>" readonly="readonly">
    </td>
  </tr>
     
  <tr>
  <td scope="row">备注</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="remark"><%=refund_remark %></textarea>
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div></td></tr></table>
<!-- end cwMain -->
</body>
</html>

