<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 电信租金台帐报表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
	<script Language="Javascript" src="../../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript">
	//查询条件变更为空时后面的输入框值清空
	function init_searchKey(){
		var searchFld  = document.dataNav1.searchFld.value;
		//alert(searchFld);
		if(searchFld == null || searchFld == ""){
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = true;
		}else{
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = false;
		}
	}
</script>

<%
	String dqczy=(String) session.getAttribute("czyid");
	//System.out.println("dqczy="+dqczy);

	
		Calendar ca = Calendar.getInstance();
		ca.setTime(new java.util.Date());
		SimpleDateFormat simpledate = new SimpleDateFormat("yyyyMMdd");
		String date = simpledate.format(ca.getTime());
		int years = ca.get(Calendar.YEAR);





	String searchFld = getStr( request.getParameter("searchFld") );
	System.out.println("searchFld==>"+searchFld);
	
	String searchKey = getStr( request.getParameter("searchKey") );
	String searchKey2 = getStr( request.getParameter("searchKey2") );
	
	String create_start_date = getStr( request.getParameter("create_start_date") );
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = "";
	if(create_start_date != null && !create_start_date.equals("")){
		//转换日期格式
	    //java.util.Date cDate = sdf.parse(create_start_date);  
	    //java.sql.Date now_date = new java.sql.Date(cDate.getTime()); 
		//nowDateTime = sdf.format(now_date);//格式化称固定的格式
		nowDateTime=create_start_date;
	}else{
		//获取系统当前日期 
		nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	}
	create_start_date = nowDateTime;
	
	String year = "";//年份
	ResultSet rs;
	ResultSet rs2=null;
	
	//合同编号|银行合同编号|开户银行|维护人员
	String wherestr = " where ci.industry_type='电信' ";
	//String searchFld_tmp = "";
	//if( searchFld.equals("合同编号")){
	//	searchFld_tmp = "cont.contract_id";
	//}
	//else if( searchFld.equals("电信公司名称")){
	//	searchFld_tmp = "cust.cust_name";
	//}
	//else{
	//	searchFld_tmp = "";
	//}
	
	if ( !searchKey.equals("") ) {
	
		wherestr = wherestr + " and vca.cust_name like '%" + searchKey + "%'";
	}
	if ( !searchKey2.equals("") ) {
	
		wherestr = wherestr + " and vca2.cust_name like '%" + searchKey2 + "%'";
	}
	//截取年份作为查询条件必用字段 CONVERT (varchar(4),'2010-04-09',20)
	//if(create_start_date!=null && !create_start_date.equals("")){
		//year = create_start_date.substring(0,4);//截取年份
	//	year=create_start_date;
		//wherestr = wherestr +" and convert(varchar(10),update_time,21) >= '"+create_start_date+"' ";
	//}
	//if((searchFld.equals("电信公司名称") || searchFld.equals("")) && searchKey.equals("")){
	//	wherestr = wherestr + " and cust.cust_name  like '%电信%'";
	//}
	//sign_date 的查询也需要遵循选择的时间
	//wherestr = wherestr + " and   cont.sign_date like '%" + year + "%'";
	String plan_date="";
	//拼装报表的SQL语句
	String sql =  "Select distinct CONVERT(varchar(7), plan_date, 111) as plan_date from fund_rent_plan frp left join contract_info ci on frp.contract_id=ci.contract_id left join vi_cust_all_info vca on ci.cust_id=vca.cust_id left join mproj_info mp on ci.main_proj_id=mp.proj_id left join vi_cust_all_info vca2 on mp.cust_id=vca2.cust_id "+wherestr;
	rs = db.executeQuery(sql); 
	List l_date_list=new ArrayList();
	while(rs.next()){
	plan_date=getDBStr(rs.getString("plan_date"));
	l_date_list.add(plan_date);
	//System.out.println("plan_date=="+plan_date);
	//System.out.println("l_date_list的长度==="+l_date_list.size());
	}
	rs.close();
	String  sqlstr="select vca.cust_name,count(ci.contract_id) con_num,sum(equip_amt) equip_amt,ci.cust_id from contract_info ci ";
		   	sqlstr+="left join contract_condition cc on ci.contract_id=cc.contract_id left join vi_cust_all_info vca on ";
			sqlstr+="ci.cust_id=vca.cust_id  left join mproj_info mp on ci.main_proj_id=mp.proj_id left join vi_cust_all_info vca2 on mp.cust_id=vca2.cust_id "+wherestr+" group by vca.cust_name,ci.cust_id ";
	System.out.println("电信报表信息###"+sqlstr);
%>
<script type="text/javascript">

//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="report_books_export.jsp";
  		form1.submit();
		dataNav1.action="report_rent_books_list.jsp";
	}
    
	return false;
}
</script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
	 <form name="dataNav1" action="report_rent_books_list.jsp" method="post">		
	 <input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
	 <input type="hidden" name="query_sql2" id="query_sql2" value="<%=sql%>"/>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt;电信租金台帐报表</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
				<td align="left" colspan="2">               
					<%-- &nbsp;按&nbsp;
						<select name="searchFld" onchange="init_searchKey()">
							<script type="text/javascript" >
								w(mSetOpt("<%= searchFld %>","|合同编号|电信公司名称"));
							</script>
				        </select>
					&nbsp;查询&nbsp;--%>
					&nbsp;&nbsp;&nbsp;省公司&nbsp;&nbsp;
					<input name="searchKey2" accesskey="s" type="text" size="15" value="<%= searchKey2 %>">
					&nbsp;&nbsp;&nbsp;分公司&nbsp;&nbsp;
					<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		<%--选择具体年份 <input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
		<select name="create_start_date">
<script type="text/javascript">
for(var i=<%=years %>;i><%=years-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}


</script>

</select>
<script type="text/javascript">
$("select[name='create_start_date']").val(<%=create_start_date %>);
</script>
--%>
 <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<td>
					<a href="#" accesskey="n" 
						onClick="isExport()">
						<img   src="../../images/Excel.png" alt="导出" align="absmiddle">
					</a>
				</td>
		    </tr>
        </table>
        <!--操作按钮结束--></td>
      <td align="right" width="90%"><!--翻页控制开始-->
        <% 
	int intPageSize = 10;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 

System.out.println("%%%%===================================%%"+sqlstr);
    rs = db.executeQuery(sqlstr); 


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
		var nf = document.dataNav1;
	</script>
            <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
              <% } %>
              第 <font color="red"><%=intPage%></font> 页
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>转到
              <input name="page" type="text" size="2" value="1">
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;height:430;overflow:auto;position: relative;"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      		<th>序号</th>
	     <th>分公司</th>
	    <th>合同数量</th>
	    <th>设备款金额</th>
	    <%
	    for(int m=0;m<l_date_list.size();m++){

	    %>
	     <th><%=l_date_list.get(m)%>租金</th>
	     <th>本金</th>
	     <th>利息</th>
	    <%
	    }
	    
	     %>
	   
	   
      </tr>

<%	  
//formatNumberStr(getDBStr( rs.getString("srent")),"#,##0.00")
String cust_id="";
if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	cust_id=getDBStr(rs.getString("cust_id"));
%>

      <tr>
      	<td align="center" nowrap><%=i+1 %></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("cust_name")) %></td>
        <td align="center" nowrap><a href="report_con_detail_list.jsp?cust_id=<%=cust_id %>" target="_self"><%=getDBStr(rs.getString("con_num")) %></a></td>
		<td align="center" nowrap><%=getDBStr(rs.getString("equip_amt")) %></td>
		
		    <%
	    for(int m=0;m<l_date_list.size();m++){
	    	String total_rent="";
	    	String total_corpus="";
	    	String total_interest="";
	    	String sql2="select dbo.bb_getMonthRent('"+cust_id+"','"+l_date_list.get(m)+"',1) as total_rent, dbo.bb_getMonthCorpus('"+cust_id+"','"+l_date_list.get(m)+"',1) as total_corpus, dbo.bb_getMonthInterest('"+cust_id+"','"+l_date_list.get(m)+"',1) as total_interest";
	    	System.out.println("sql2==="+sql2);
	    	rs2 = db2.executeQuery(sql2);
	    	if(rs2.next()){
	    	 total_rent=getDBStr(rs2.getString("total_rent"));
	    	 total_corpus=getDBStr(rs2.getString("total_corpus"));
	    	 total_interest=getDBStr(rs2.getString("total_interest"));
	    	 System.out.println("total_rent==="+total_rent);
	    	 }
	    	if(rs2!=null){
			rs2.close();
			}
			
			
	    	 
	    %>
	     <td align="center" nowrap><%=formatNumberStr(total_rent,"#,##0.00") %></td>
	     <td align="center" nowrap><%=formatNumberStr(total_corpus,"#,##0.00") %></td>
	     <td align="center" nowrap><%=formatNumberStr(total_interest,"#,##0.00") %></td>
	    <%
	   
	    }
	     if(rs2!=null){
			rs2.close();
			}
	     %>
		
      </tr>
<%
		rs.next();
		i++;
	}
}
}

rs.close(); 
db.close();
%>
    </table>
  </div>
    </form>
  <!--报表结束-->

</body>
</html>
<%if(null != db2){db2.close();}%>