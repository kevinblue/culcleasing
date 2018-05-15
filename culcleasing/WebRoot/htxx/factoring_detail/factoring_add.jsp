<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保理明细 - 保理管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<style>
select{
width:50px;
}
</style>

<script type="text/javascript">
// 是否可以提交付款申请
function isSub(obj) {
		//得到复选框的集合
 	var names=document.getElementsByName("list");
 	var statu=0;
 	//var flag_fp=0;
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
				statu++;
				
				//判断发票号与发票日期
				//flag
				var flag_value=names[i].attributes["flag"].nodeValue;
				if (flag_value>0) {
					//flag_fp++;
					alert("项目"+names[i].attributes["xmNum"].nodeValue+"没有发票号或发票日期!");
					return false;
				}
		}
	}
	if (statu==0) {
			alert("请选择您要申请的项目!");
			return false;
	} else{
			document.search.action="factoring_save.jsp?savetype=add";
			var total = document.getElementById("factoring_rent").value;
			//alert(total);
			
			//return confirm("是否确认提交");
			search.submit();
	}
	return false;
	
}


function search_proj() {
	document.search.action="fpgl_add.jsp";
	document.search.submit();
}
function invoice_submit(){
	var cust_name=document.getElementById("cust_name").value;
	//alert(cust_name);
	if(cust_name==""||cust_name==null){
	alert("承租人不能为空");
	return false;
	}
	else{
	document.search.action="fpgl_add.jsp";
	document.search.submit();
	}
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;" class="linetype">
<form name="search" method="post" action="factoring_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >
<input id="factoring_date" name="factoring_date" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保理明细 &gt;保理增加
</td>
</tr>

<tr valign="top">
<td  align=center width=100% height=100% style="padding: 0px;">
<div style="margin-top: 0px;">
<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>




<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">保理信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>

<div style="margin-top: 5px;">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;margin: 0px;">
<div id="TD_tab_0">


<%
String dqczy=(String) session.getAttribute("czyid");
System.out.println("dqczy="+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where  1=1";
//factoring='是' and id not in (select contract_id from factoring_contract_Corresponding)and
String searchFld_tmp = "";
if( searchFld.equals("承租人") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("保理") ) {
	searchFld_tmp = "factoring";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),factoring_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),factoring_date,21)<='"+create_end_date+"' ";
}

String sqlstr = "select *  from vi_factoring_statistics " + wherestr+" order by contract_id"; 
System.out.println("###"+sqlstr);

%>




<input type="hidden" name="where_str" id="where_str" value="<%=wherestr%>" />


<!--可折叠查询开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
     保理维护</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
		
	
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|承租人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="25" value="<%= searchKey %>">
		添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
  <!--翻页控制结束-->
  <!--控制全选的-->
  
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">

 <tr>
   
	<td scope="row" colspan="1">
		
		
		
	</td>
	
        <td scope="row" colspan="1">
    保理编号&nbsp;&nbsp;<input class="text" name="factoring_num" id="factoring_num" type="text"   maxlength="60" size="10"/>&nbsp;&nbsp;
    保理银行&nbsp;&nbsp;<input class="text" name="factoring_backname" id="factoring_backname" type="text"   maxlength="60" size="10"/>&nbsp;&nbsp;
    保理帐户&nbsp;&nbsp;<input class="text" name="factoring_account" id="factoring_account" type="text"   maxlength="50" size="10"/>&nbsp;&nbsp;
    保理金额&nbsp;&nbsp;<input class="text" name="factoring_rent" id="factoring_rent" type="text" size="30" readonly="readonly"/></td>
    
    
	</tr>
	<tr>
	<td scope="row" colspan="1"></td>
	<td  scope="row" colspan="1">
	保理本金&nbsp;&nbsp;<input type="text"  class="text" name="factoring_corpus" id="factoring_corpus" readonly="readonly" size="30"/>&nbsp;&nbsp;
	保理利息&nbsp;&nbsp;<input type="text" class="text" name="factoring_interest" id="factoring_interest" readonly="readonly" size="30"/>&nbsp;&nbsp;
	偿还金额&nbsp;&nbsp;<input class="text" name="factoring_repay" id="factoring_repay" size="30"/>&nbsp;&nbsp;
	保理利率&nbsp;&nbsp;<input class="text" name="factoring_rate" id="factoring_rate" type="text" size="30"/></td>
  </tr>
  <tr>
  <td scope="row" colspan="1">
  <input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();"/>  全选/反选
  </td>
  <td>
  	融资金额&nbsp;&nbsp;<input class="text" name="lease_money" id="lease_money" type="text" size="30"/>&nbsp;&nbsp;
	省公司&nbsp;&nbsp;<input class="text" name="cust_name" id="cust_name" type="text" size="30"/>&nbsp;&nbsp;
    保理开始时间&nbsp;&nbsp;<input class="text" name="factoring_start_date" id="factoring_date" type="text" size="20" readonly="readonly"/><img  onClick="openCalendar(factoring_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;&nbsp;
    保理结束时间&nbsp;&nbsp;<input class="text" name="factoring_end_date" id="factoring_date" type="text" size="20" readonly="readonly"/><img  onClick="openCalendar(factoring_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;&nbsp;
	</td>
</tr>

</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;left: 0px; top: 0px;"
				id="mydiv";>
				
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="0" cellspacing="0" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
							 <th width="1%"></th> 						
	    <th>合同号</th>
	    <th>承租人</th>
	    <th>项目名称</th>
	    <th>合同期数</th>
	    <th>保理期数</th>
	    <th>保理租金</th>
	    <th>保理本金</th>
	    <th>保理利息</th>
	    <th>保理日期</th>
						</tr>
						<tbody id="data">
						<%
					//	String sqls="select * from vi_invoice where vi_invoice.id not in(select plan_id from proj_invoice_detail) ";
					//	System.out.println("sqls"+sqls);
					//	rs=db.executeQuery(sql);
						int n=0;
						//复选框id
						String ckid="";
						String contract_id;
						String factoring_date;
						String pro_id="";
						String plan_id="";
						String rent="";
						String invoice_name="";
						String corpus="";
						String interest="";
						String corpus_overage="";
						String factoring_pringcipal="";
						String factoring_rantal="";
						int flag=0;
				//		if ( intRowCount!=0 ){
						rs = db.executeQuery(sqlstr); 
						while(rs.next()){
					//	while( i < intPageSize && !rs.isAfterLast() ) {
					    flag=0;
						ckid="ck_"+n;
						//pro_id=getDBStr(rs.getString("i"));
						
						factoring_pringcipal=getDBStr(rs.getString("factoring_pringcipal"));
						factoring_rantal=getDBStr(rs.getString("factoring_rantal"));
					    plan_id=getDBStr(rs.getString("contract_id"));
					   // if(getDBStr(rs.getString("invoice_number")).trim().length()==0||getDBStr(rs.getString("invoice_date")).trim().length()==0 ){
					  //  flag++;
					  //  }
						 %>
						
						<tr>
							<td>
							<input type="hidden" name="factoring_date" id="factoring" value="<%=getDBDateStr( rs.getString("factoring_date") ) %>">
								<input  type="checkbox"  name="list" id="<%=ckid %>" onclick="makeValue();"  rent=<%=getDBStr( rs.getString("factoring_rent") )%> 
								 factoring_pringcipal=<%=getDBStr( rs.getString("factoring_pringcipal") ) %> factoring_rantal="<%=factoring_rantal %>"  
								 factoring_date=<%=  getDBDateStr( rs.getString("factoring_date") )%>
								plan_id=<%= getDBStr( rs.getString(("contract_id") )) %> flag="<%=flag %>" invoice_name=<%=getDBStr( rs.getString("cust_name") )  %>>
							</td>
	        				
	        				<td align="center"><%= getDBStr( rs.getString(("contract_id") )) %></td>
	        <td align="center">
		<%= getDBStr( rs.getString("cust_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
	   	<td align="center"><%= getDBStr( rs.getString(("lease_term") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("rent_lsit") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_rent") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_pringcipal") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_rantal") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("factoring_date") ) %></td>
		
						</tr>
						
						<%
						//rs.next();
		//				i++;
						} 
//						}
//    }
rs.close(); 
db.close();
						%>
						
	</tbody>					
</table>



<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>
</div>

<div style="margin-top: 5px;">
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</div>
</td>
</tr>
</table>  
</div>
<%

 %>
 
 <script type="text/javascript">

var sid="";
var sid2 ="";
var total=0.00;
var total2=0.00;
var total3=0.00;
var total4=0.00;
var total5=0.00;
var invoice_name="";
   
 function makeValue(){
 total=0;
 total2=0;
 total3=0;
 sid="";

 	//得到复选框的集合
 	var names=document.getElementsByName("list");
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
	    	var plan_id=names[i].attributes["plan_id"].nodeValue;
	    	var factoring_date =names[i].attributes["factoring_date"].nodeValue
	    	//invoice_name=names[i].attributes["invoice_name"].nodeValue;
	    	//alert(factoring_date);
			var rent=names[i].attributes["rent"].nodeValue;
			var factoring_pringcipal=names[i].attributes["factoring_pringcipal"].nodeValue;
			var factoring_rantal=names[i].attributes["factoring_rantal"].nodeValue;
			
		   //得到付款金额
		    total=total+parseFloat(rent);
		    total2=total2+parseFloat(factoring_pringcipal);
		    total3=total3+parseFloat(factoring_rantal);
		    sid=sid+plan_id+",";
		    sid2=sid2+factoring_date+",";
		    //alert("sid="+sid+"----sid2="+sid2);
	    }
	    
  	}
  	document.getElementById("factoring_rent").value=total;
  	document.getElementById("factoring_corpus").value=total2;
  	document.getElementById("factoring_interest").value=total3;
  	if(total=="0"){
  	invoice_name="";
  	}
  	//document.getElementById("invoice_name").value=invoice_name;
  	document.getElementById("plan_id").value=sid.substring(0,sid.length-1);
  	document.getElementById("factoring_date").value=sid2.substring(0,sid2.length-1);
  	
  	///plan_id.value=sid.substring(0,sid.length-1);
  	//alert(sid.substring(0,sid.length-1));
  	//alert(total+"=="+document.getElementById("plan_id").value);
 }

function isSelectAll () {

	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	makeValue();
}


//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
	
		search.action="export_save.jsp";
		document.getElementById("where_str").value="<%=wherestr%>";
  		search.submit();
		search.action="fpgl_add.jsp";
	}
	return false;
}
 </script>
 
 
</form>


<!-- end cwMain -->
</body>
</html>
