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
<title>租金管理 - 发票管理</title>

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
			document.search.action="fpgl_save.jsp?savetype=add";
			if(document.getElementById("invoice_number").value.length==0){
			alert("请选择发票号!");
				return false;
			}
		 if (document.getElementById("invoice_date").value.length==0) {
				alert("请选择应付日期!");
				return false;
			}
			
			return confirm("是否确认提交");
			
	}
	return false;
	
}


function search_proj() {
	document.search.action="fpgl_add.jsp";
	document.search.submit();
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;" class="linetype">
<form name="search" method="post" action="fpgl_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
发票管理 &gt;发票增加
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
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>




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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">发票信息</td>
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
String sqlstr;
//ResultSet rs;

//得到当前登陆的用户
String dqczy = (String) session.getAttribute("czyid");

//查询条件判断
//String contract_id="";
//String cust_name="";
//String create_start_date="";
//String create_end_date="";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("承租人") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("登记人") ) {
	searchFld_tmp = "dbo.GETUSERNAME(creator)";
}else{
	searchFld_tmp = "";
}
if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+create_end_date+"' ";
}
String where_str =wherestr;

String sql="select * from vi_invoice " + where_str+" and vi_invoice.id not in(select plan_id from proj_invoice_detail where proj_invoice_detail.proj_invoice_id in(select id from proj_invoice)) order by plan_date desc";
rs=db.executeQuery(sql);
System.out.println("sql="+sql);

sqlstr="select * from vi_invoice where vi_invoice.id not in(select plan_id from proj_invoice_detail)";

System.out.println("sqlstr="+sqlstr);
String id="";
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 

	id=getDBStr(rs.getString("id"));
}
rs.close();

String contract_id1="";
String cust_name1="";
//处理项目基本信息中产品类型为中文的选择
String prod_id_str="";
sqlstr="select * from ifelc_conf_dictionary where name='EquipType'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	prod_id_str=prod_id_str+"|"+getDBStr(rs.getString("title"));
}rs.close();


%>


<input type="hidden" name="savetype" value="add">
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="plan_id" id="plan_id"/>
<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />


<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
  
  <tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;<select class="text" name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|承租人|登记人"));</script></select>&nbsp;查询&nbsp;<input class="text" name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		添加日期<input class="text" name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input class="text" name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input  name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
	
  <tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
 <tr>
   
   
	
	<td scope="row" colspan="2">
		
		<input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选/反选
	</td>
    
	
	 <td scope="col">发票金额:</td>
    <td> 
    <input class="text" name="invoice_total" id="invoice_total" type="text"  readonly maxlength="10" size="10">
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
       						<th>序号</th>
	    <th>项目名称</th>
	    <th>合同额</th>
	    <th>合同编号</th>
	    <th>发票抬头</th>
	    <th>本期数</th>
	    <th>总期数</th>
	    <th>租金</th>
	    <th>还款日期</th>
		<th>本金</th>
		<th>利息</th>
						</tr>
						<tbody id="data">
						<%
						String sqls="select * from vi_invoice where vi_invoice.id not in(select plan_id from proj_invoice_detail)";
						System.out.println("sqls"+sqls);
						rs=db.executeQuery(sql);
						int n=0;
						//复选框id
						String ckid="";
						String pro_id="";
						String plan_id="";
						String rent="";
						int flag=0;
						while(rs.next()){
					    flag=0;
						ckid="ck_"+n;
						pro_id=getDBStr(rs.getString("proj_id"));
						rent=getDBStr(rs.getString("rent"));
					    plan_id=getDBStr(rs.getString("id"));
					   // if(getDBStr(rs.getString("invoice_number")).trim().length()==0||getDBStr(rs.getString("invoice_date")).trim().length()==0 ){
					  //  flag++;
					  //  }
						 %>
						
						<tr>
							<td>
								<input  type="checkbox"  name="list" id="<%=ckid %>" onclick="makeValue();"  rent="<%=rent%>" plan_id=<%= getDBStr( rs.getString(("id") )) %> flag="<%=flag %>">
							</td>
	        				
	        				<td align="center"><%= getDBStr( rs.getString(("id") )) %></td>
		<td align="center">
		<%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString(("net_lease_money") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("income_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("rent") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest") ) %></td>
						</tr>
						
						<%
						n++;
						} %>
						
	</tbody>					
</table>

</div>
</div>
</div>
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
rs.close(); 
db.close();

 %>
 
 <script type="text/javascript">

var sid="";
var total=0;
   
 function makeValue(){
 total=0;
 sid="";

 	//得到复选框的集合
 	var names=document.getElementsByName("list");
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
	    	var plan_id=parseFloat(names[i].attributes["plan_id"].nodeValue);
			var rent=names[i].attributes["rent"].nodeValue;
		   //得到付款金额
		    total=total+parseFloat(rent);
		    sid=sid+plan_id+",";
	    }
	    
  	}
  	document.getElementById("invoice_total").value=total;
  	document.getElementById("plan_id").value=sid.substring(0,sid.length-1);
  	///plan_id.value=sid.substring(0,sid.length-1);
  	///alert(sid.substring(0,sid.length-1));
  	///alert(total+"=="+document.getElementById("plan_id").value);
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
