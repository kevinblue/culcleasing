<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 所有未调息列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script>  
<script type="text/javascript">
//新增操作
function tiaoxi(){
//alert("join");
	var str_checkbos_list = '';
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var str = document.getElementsByName("checkbos_list");
    var i = 0;
    for (i = 0; i < str.length; i++)
    {
        if (str[i].checked)
        {
            selectedIndex = i;
            str_checkbos_list = str_checkbos_list + str[i].value + "#";
        }
    }
    if (selectedIndex < 0 )
    {
        alert("请先选择需要调息的数据行!");
        return false;
    }
   str_checkbos_list = str_checkbos_list.substring(0,str_checkbos_list.length-1);
    //window.open('tx_executeTx.jsp?all_checkbos_value='+str_checkbos_list,'进行调息','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
   //合同编号
   document.getElementById('all_checkbos_value').value = str_checkbos_list;
    //alert(str_checkbos_list);
    form1.action = "tx_executeTx.jsp";
    document.form1.target = "_blank";
    form1.submit();
}
//checkbos全选
function isSelectAll() {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
}
//调息之未调息记录模糊查询
function query(){
	//form1.action = "";
	//document.form1.target = "tx_showAll_wtx.jsp";
	form1.submit();
}
</script>
</head>
<body>
<%
	 //央行利率基准表中的主键,通过该主键在表fund_adjust_interest_contract中查询对应的contract_id
	String txId = getStr(request.getParameter("txId"));  
	String adjust_method = getStr(request.getParameter("adjust_method")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); 
	String start_date = getStr(request.getParameter("start_date"));
	//获取查询条件
	String drawings_id = getStr(request.getParameter("query_contract_id")); 
//	String start_date = getStr(request.getParameter("start_date")); //调息开始日期
	System.out.println("adjust_method<-123-->"+adjust_method);
	String str = "";
	ResultSet rs;
	//rate_float_type  rate_float_amt ajdustStyle
	// 利率浮动类型、利率调整值、调息方式
	StringBuffer sql = new StringBuffer();
	sql.append(" select * from vi_tx_showAll_fina_wtx vts")
	   .append(" where  not exists ( ")
	   .append(" select drawings_id from financing_adjust_interest_drawings fa  ")
	   .append(" where fa.drawings_id=vts.drawings_id  ");
	   if(!txId.equals("") && txId != null){
		  sql.append(" and adjust_id = "+txId+" ");//传入的ID是fund_standard_interest的ID
	    }   
	   sql.append(" ) ");
	   if(!drawings_id.equals("") && drawings_id != null){
		  sql.append(" and c.drawings_id like '%"+drawings_id+"%' ");//
	   }   
	   //若调息日期小于项目第，则不允许项目进行该次调息，反之则允许
	   //sql.append("  and  start_date<='"+start_date+"' ");
	   //过滤掉次日调息
	  // sql.append("  and adjust_style<>'按次日' and settle_method='"+adjust_method+"'");
	   //过滤掉只剩最后一期的(次调最后一期进行次期调息无意义)
	   sql.append(" and vts.drawings_id in (select drawings_id from financing_refund_plan where refund_plan_date>='"+start_date+"'  group by drawings_id )");
	   System.out.println("222222查询sql语句==>> "+sql.toString());
	   //fund_standard_interest
	   //String quer_ = "  select * from fund_standard_interest where id = '"+custId+"' ";
%>
<form name="form1" action="tx_showAll_wtx.jsp" method="post" onSubmit="return goPage()">
<!-- 央行利率基准表中的主键 ,选中的合同编号  -->
<input type="hidden" name="txId" id="txId" value="<%=txId%>"/>
<input type="hidden" name="adjust_method" id="adjust_method" value="<%=adjust_method%>"/>
<input type="hidden" name="all_checkbos_value" id="all_checkbos_value"/>
<input type="hidden" name="save_type" value="add" />
<input type="hidden" name="adjust_flag" id="adjust_flag" value="<%=adjust_flag%>">
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt"  valign="middle" id="cwCellTopTitTxt">
      	融资调息 &gt; 未调息记录列表
      </td>
      <td></td>
    </tr>
    <tr class="maintab" style="height: 25px">
		<td align="left" >               
			&nbsp;提款编号&nbsp;
			<input type="text" name="query_contract_id" value="<%=drawings_id%>" />
			
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="查询" border="0" align="absmiddle" >
			</a>
		</td>
		<td nowrap="nowrap" align="left">
		<%	
			if("否".equals(adjust_flag)){
		%>	
			<a href="#" onclick="tiaoxi();">
			<!-- onClick="dataHander('mod','tx_fsi_add.jsp?model=mod&key_id=',form1.key_id);" -->
            	<img src="../../images/sbtn_new.gif" alt="分配" border="0" align="absmiddle" >
          分配&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </a>
           <%
           }
           %>
       </td>
       
	</tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--翻页控制开始-->
<% 
	int intPageSize = 18;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr(request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sql.toString());

	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.form1;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>
</td>
</tr>
</table>
<!--翻页控制结束 style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      <!-- hidefocus --> 
	    <th width="1%">
	    	<input name="ck_all" id="ck_all" type="checkbox"   onclick="isSelectAll();">全选
	    </th>
	  
	    <th>授信标号</th>
		<th>授信合同编号</th>
	    <th>提款标号</th>
		<th>授信单位</th>
		<th>贷款类型</th>
		<th>还款方式</th>
		<th>提款金额</th>
		<th>利率浮动类型</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("drawings_id"))%>"/></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("credit_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("credit_contract_id"))%></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("drawings_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("crediter"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("drawings_type"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("refund_way"))%></td>
		<td align="center" nowrap><%= CurrencyUtil.convertFinance(rs.getString("drawings_money"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("drawings_rate_float_type"))%></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
  </div>
</form>
</body>
</html>
