<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租赁公司收款列表(首付款)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//验证是否可以核销
var sql ="";
var id_s="";
var isAdd=0;
var sql_date ="";
function validata() {
document.getElementById("hx").disabled="disabled";
	sql="";
	id_s="";	
	sql_date="";			//得到复选框的集合
	var names=document.getElementsByName("list");
	var flag=0;
	
	for(i=0;i<names.length;i++){
		if (names[i].checked){
		isAdd=-1;
		//得到fact_money,fact_date,y,fid
		var fact_money= names[i].attributes["fact_money"].nodeValue;
		var fd= names[i].attributes["fact_date"].nodeValue;
		var fid= names[i].attributes["fid"].nodeValue;
		var y= names[i].attributes["y"].nodeValue;
		var yh= names[i].attributes["yh"].nodeValue;
		var zh= names[i].attributes["zh"].nodeValue;
		
		var fm = document.getElementById(fact_money).value;
		fm=parseFloat(fm);
		var fd = document.getElementById(fd).value;
		
		if (fd.length==0) {
			alert("请填写付款单号为"+fid+"的实际到帐日期!");
			flag++;
			return;
		}
			sql+="'"+fid+"','"+fd+"','"+yh+"','"+zh+"_";
			id_s+="'"+fid+"',";
			sql_date+=" update apply_info set status='已核销',fact_date='"+fd+"' where id='"+fid+"' and pay_type ='资金' ";
		}
	}
	if (flag==0 && isAdd==-1) {
		//拼凑执行的sql语句
		var sqldata=document.getElementById("sqldata");
			sql=sql.substring(0,sql.length-1);
			sqldata.value=sql;
			//更新的id集
		var sid=document.getElementById("sid");
			id_s=id_s.substring(0,id_s.length-1);
			sid.value=id_s;
			
			document.getElementById("sql_date").value=sql_date;
			document.dataNav.target="_blank";
			if (confirm("是否核销已勾选的付款单号("+id_s+")")){
				document.getElementById("savetype").value="add";
				document.dataNav.action="leasing_save.jsp";
				document.dataNav.submit();
				document.dataNav.action="leasing_list.jsp";
				document.dataNav.target="_self";
				}
			} else {
				alert("请勾选您要核销的付款单!");
			}
}
//驳回功能的验证
function validata_bh() {
	//是否有选中的付款单号
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//保存所要驳回的付款单号
	var sql_bh_ids="";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].attributes["fid"].nodeValue;
			str_bh+=fid+",";
			sql_bh_ids+="'"+fid+"',";
		}
	}

	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	if (flag_bh==0) {
		alert("请选择您要驳回的付款单号!");
		return false;
	}else {
		if (confirm("您是否确认驳回付款单(付款单号:'"+str_bh+"')?")) {
			document.getElementById("savetype").value="bh";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="leasing_save.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="leasing_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
</script>
</head>

<body onload="public_onload(0);">
<form action="leasing_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="sqldata" id="sqldata" type="hidden">
<input name="sid" id="sid" type="hidden">
<input name="sql_date" id="sql_date" type="hidden">
<input name="savetype" id="savetype" type="hidden" value="add">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">
<%
String dqczy=(String) session.getAttribute("czyid");
String sqlstr="";
ResultSet rs=null;

if(dqczy==null){%>
	<script language="javascript">
	window.parent.parent.location.replace("http://test.strongflc.com/names.nsf?logout");
	</script> 
<%}

String wherestr=" where 1=1 ";
	
String code = getStr( request.getParameter("code") );
String dls = getStr( request.getParameter("dls") );
String status = "未核销";

String fk_date_start = getStr( request.getParameter("fk_date_start") );
String fk_date_end = getStr( request.getParameter("fk_date_end") );
	
if ( !code.equals("") ) {
	wherestr = wherestr + " and apply.id  like '%" + code + "%'";
}
if ( !dls.equals("") ) {
	wherestr = wherestr + " and dld_name  like '%" + dls + "%'";
}
if ( !status.equals("") ) {
	wherestr = wherestr + " and status  like '%" + status + "%'";
}

if(fk_date_start!=null&&!fk_date_start.equals("")){
	wherestr+=" and convert(varchar(10),pay_date,21)>='"+fk_date_start+"' ";
}
if(fk_date_end!=null&&!fk_date_end.equals("")){
	wherestr+=" and convert(varchar(10),pay_date,21)<='"+fk_date_end+"' ";
}

sqlstr="select apply.*,dl.skyy as yh,dl.skzh as zh,title,khmc from apply_info  apply left join dl_mpxx dl  on apply.dld_id=dl.khbh ";
sqlstr+=" left join dbo.ifelc_conf_dictionary on ifelc_conf_dictionary.name=apply.pay_method "+wherestr;
sqlstr+=" and pay_type='资金' and apply.status<>'已驳回'  and isnull(is_sub,'')='已提交'  order by apply.create_date desc ";

%>		
			
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
    <td scope="row">付款单号:</td>
    <td>
  <input name="code" type="text"  size="10"  value="<%=code %>"   >
    </td>   
    <td scope="row">代理商:</td>
    <td> 
    <input name="dls" type="text"  size="10"  value="<%=dls %>"  >
	</td>
    <td scope="row">付款时间段:</td>
    <td colspan="5"> 
   
    <input name="fk_date_start" type="text"  size="10"   value="<%=fk_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(fk_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="fk_date_end" type="text"  size="10"   value="<%=fk_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(fk_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>
	     <input type="button" value="查询" onclick="dataNav.submit();">&nbsp;&nbsp;
		 <input type="button" value="清空" onclick="clearQuery();">
	</td>
  </tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			租赁公司收款列表（首期付款）
		</td>
	</tr>
</table>
<!--标题结束-->


<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
			<BUTTON class="btn_2" id="hx" name="btnHire" value="核销"  type="button" onclick="validata();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;核销</button>
			</td>
			<td>								
			 <BUTTON class="btn_2" name="btnBh" value="驳回"  type="button" onclick="validata_bh();">
			 <img src="../../images/hg.gif" align="absmiddle" border="0">&nbsp;驳回</button>
			</td>
			<td>
			</td>
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			<input name="ck_all" type="checkbox">&nbsp;全选
			<input name="inverse_ck_all" type="checkbox">&nbsp;反选
			</td>
		</tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplitNoCode.jsp" %>
	<!--翻页控制结束-->
	</td>
</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
<tr class="maintab_content_table_title"> 
	<th width="1%"></th> 	
    <th>付款单号</th>
    <th>代理商</th>
	<th>付款金额</th>
    <th>项目数量</th>
    <th>付款方式</th>
   
    <th>付款日期</th>
    <th>到帐日期</th>
    <th>状态</th>
</tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	//付款单号,应收金额,实收金额,实收日期,
	String fid=getDBStr(rs.getString("id"));
	String fact_money="fact_"+i;
	String fact_date="f_d_"+i;
	String y = formatNumberDoubleTwo(rs.getString("pay_amt"));
	String yh=getDBStr(rs.getString("yh"));
	String zh=getDBStr(rs.getString("zh"));
%>
	<tr>				
		<td>
		<input type="checkbox" name="list" yh="<%=yh %>" zh="<%=zh %>" fact_money="<%=fact_money %>" fact_date="<%=fact_date %>" y="<%=y %>"
		value="<%=getDBStr(rs.getString("id"))%>" fid="<%=fid %>">
		</td>

        <td align="center"><a href="leasing.jsp?czid=<%=getDBStr(rs.getString("id"))%>&fact_date=<%=getDBDateStr(rs.getString("fact_date")) %>" target="deltail"><%=getDBStr(rs.getString("id"))%></a></td>
       <td align="center"><%=getDBStr(rs.getString("dld_name")) %></td>
   
       <td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("pay_amt")) %></td>
       <td align="center"><%=getDBStr(rs.getString("proj_number")) %></td>
	   <td align="center"><%=getDBStr(rs.getString("title")) %></td>
        <td align="center"><%=getDBDateStr(rs.getString("pay_date")) %></td>
     
        <td align="center">   
        <input type="hidden" name="fact_money" value="0" id="<%=fact_money %>">
      	<input name="fact_date" type="text" size="15" id="<%=fact_date %>"  Require="true"   readonly maxlength="10" dataType="Date"> 
      	<img  onClick="openCalendar(<%=fact_date %>);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
        <td align="center"><%=getDBStr(rs.getString("status")) %></td>
	</tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div><!--报表结束-->
</form>
</body>
</html>

