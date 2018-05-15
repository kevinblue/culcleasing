<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 电信项目收付款统计</title>
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
	//合同编号|银行合同编号|开户银行|维护人员
	String wherestr = " where  cont.industry_type='电信'";
	String searchFld_tmp = "";
	if( searchFld.equals("合同编号")){
		searchFld_tmp = "cont.contract_id";
	}
	else if( searchFld.equals("电信公司名称")){
		searchFld_tmp = "cust.cust_name";
	}
	else{
		searchFld_tmp = "";
	}
	
	if ( !searchFld.equals("") && !searchKey.equals("") ) {
	
		wherestr = wherestr + " and " + searchFld_tmp +  " like '%" + searchKey + "%'";
	}
	//截取年份作为查询条件必用字段 CONVERT (varchar(4),'2010-04-09',20)
	if(create_start_date!=null && !create_start_date.equals("")){
		//year = create_start_date.substring(0,4);//截取年份
		year=create_start_date;
		//wherestr = wherestr +" and convert(varchar(10),update_time,21) >= '"+create_start_date+"' ";
	}
	if((searchFld.equals("电信公司名称") || searchFld.equals("")) && searchKey.equals("")){
		wherestr = wherestr + " and cust.cust_name  like '%电信%'";
	}
	//sign_date 的查询也需要遵循选择的时间
	wherestr = wherestr + " and   cont.sign_date like '%" + year + "%'";
	
	//拼装报表的SQL语句
	StringBuffer sql = new StringBuffer();
	sql.append(" select distinct  ")
		.append(" cont.contract_id as contract_id,cont.project_name as project_name, ")
		.append(" cust.cust_name as cust_name,frp.srent as srent, ")
		.append(" htjy.income_number_year as  income_number_year,htjy.lease_term as lease_term, ")
		.append(" cont.sign_date as sign_date,  ")
		.append(" CONVERT (varchar(8), htjy.start_date,20) + CONVERT (varchar(2),htjy.income_day) as start_date, ")
		.append(" htjy.equip_amt as equip_amt,ffc.fact_money as fact_money, ")
		.append(" CONVERT (varchar(10), ffc.fact_date,20) as fact_date, ")
		.append(" jx.jx_1_rent as jx_1_rent,jx.jx_2_rent as jx_2_rent,jx.jx_3_rent as jx_3_rent, ")
		.append(" jx.jx_4_rent as jx_4_rent,jx.jx_5_rent as jx_5_rent,jx.jx_6_rent as jx_6_rent, ")
		.append(" jx.jx_7_rent as jx_7_rent,jx.jx_8_rent as jx_8_rent,jx.jx_9_rent as jx_9_rent, ")
		.append(" jx.jx_10_rent as jx_10_rent,jx.jx_11_rent as jx_11_rent,jx.jx_12_rent as jx_12_rent, ")
		
		.append(" sh.sh_1_rent as sh_1_rent,sh.sh_2_rent as sh_2_rent,sh.sh_3_rent as sh_3_rent, ")
		.append(" sh.sh_4_rent as sh_4_rent,sh.sh_5_rent as sh_5_rent,sh.sh_6_rent as sh_6_rent, ")
		.append(" sh.sh_7_rent as sh_7_rent,sh.sh_8_rent as sh_8_rent,sh.sh_9_rent as sh_9_rent, ")
		.append(" sh.sh_10_rent as sh_10_rent,sh.sh_11_rent as sh_11_rent,sh.sh_12_rent as sh_12_rent ")
		.append(" from contract_info as cont ")
		
		.append(" left join  proj_info  as proj   ")//-- 查询项目名称,签约日
		.append(" on cont.proj_id = proj.proj_id ")
		
		.append(" left join vi_cust_all_info as cust  ")//-- 查询公司名称
		.append(" on cont.cust_id =  cust.cust_id ")
		
		.append(" left join  ")
		.append(" ( ")
		.append(" 	select  distinct  contract_id,sum(isnull(rent,0)) as srent from fund_rent_plan group by contract_id ")
		.append(" )  as frp   ")//--查询租金金额
		.append(" 	on cont.contract_id = frp.contract_id ")
		
		.append(" left join contract_condition as htjy    ")//--查询支付方式,租期
		.append(" on cont.contract_id = htjy.contract_id  ")
		
		.append(" left join ( ")
		.append(" 	select distinct  contract_id,max(fact_date)as fact_date,sum(fact_money) as fact_money  ")
		.append(" 	from fund_fund_charge  left join  base_feetype  ")
		.append(" 	on fund_fund_charge.fee_type = base_feetype.feetype_number ")
		.append(" 	where feetype_name = '设备款' and item_method='付款' group by contract_id ")
		.append(" ) as ffc  ")//--查询实际付款
		.append(" on cont.contract_id = ffc.contract_id ")
		
		.append(" left join fund_rent_income as fri  ")//--查询实收租金
		.append(" on cont.contract_id = fri.contract_id ")
		
		.append(" left join ( ")//--计划收的租金
		.append(" 	select   contract_id, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-01%' then frp.rent else 0 end) as jx_1_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-02%' then frp.rent else 0 end) as jx_2_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-03%' then frp.rent else 0 end) as jx_3_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-04%' then frp.rent else 0 end) as jx_4_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-05%' then frp.rent else 0 end) as jx_5_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-06%' then frp.rent else 0 end) as jx_6_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-07%' then frp.rent else 0 end) as jx_7_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-08%' then frp.rent else 0 end) as jx_8_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-09%' then frp.rent else 0 end) as jx_9_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-10%' then frp.rent else 0 end) as jx_10_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-11%' then frp.rent else 0 end) as jx_11_rent, ")
		.append(" 	sum(case when CONVERT (varchar(7), frp.plan_date,20) like '"+year+"-12%' then frp.rent else 0 end) as jx_12_rent ")
		.append(" 	from fund_rent_plan frp group by contract_id ")
		.append(" ) jx on cont.contract_id = jx.contract_id ")
		
		.append(" left join(   ")//--查询实收租金
		.append("    select contract_id,  ")// --这里的2010-07中的2010是根据传入的年份确定的
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-01%' then fri.rent else 0 end) as sh_1_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-02%' then fri.rent else 0 end) as sh_2_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-03%' then fri.rent else 0 end) as sh_3_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-04%' then fri.rent else 0 end) as sh_4_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-05%' then fri.rent else 0 end) as sh_5_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-06%' then fri.rent else 0 end) as sh_6_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-07%' then fri.rent else 0 end) as sh_7_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-08%' then fri.rent else 0 end) as sh_8_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-09%' then fri.rent else 0 end) as sh_9_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-10%' then fri.rent else 0 end) as sh_10_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-11%' then fri.rent else 0 end) as sh_11_rent, ")
		.append(" sum(case when CONVERT (varchar(7), fri.hire_date,20) like '"+year+"-12%' then fri.rent else 0 end) as sh_12_rent ")
		
		.append("    from	fund_rent_income as fri group by contract_id ")
		.append(" )as sh ")
		.append(" on cont.contract_id = sh.contract_id  ")
		// ---传入的字段这2个条件不为空就加上，为空就步拼接，注意编号和名称换成传入的字段
		.append(wherestr)
		//.append(" where cont.contract_id = '2010-00141-445-00000'--合同编号 ")
		//.append(" and cust.cust_name like'%公司%'--电信公司名称 ")
		.append("  "); 
	String sqlstr = sql.toString(); 
	System.out.println("电信报表信息###"+sqlstr);
%>
<script type="text/javascript">

//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="exportReport_save.jsp";
  		form1.submit();
		dataNav1.action="report_dianxin_list.jsp";
	}
    
	return false;
}
</script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
	 <form name="dataNav1" action="report_dianxin_list.jsp" method="post">		
	 <input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt;电信项目收付款统计</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;
						<select name="searchFld" onchange="init_searchKey()">
							<script type="text/javascript" >
								w(mSetOpt("<%= searchFld %>","|合同编号|电信公司名称"));
							</script>
				        </select>
					&nbsp;查询&nbsp;
					<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		选择具体年份<%-- <input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">--%>
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
						<img   src="../../images/sbtn_new.gif" alt="导出" align="absmiddle">
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
	     <th>合同编号</th>
	    <th>项目名称</th>
	    <th>电信公司名称</th>
	    <th>租金总金额</th>
	    <th>支付方式</th>
	    <th>租期</th>
	    <th>签约日</th>
	    <th>起租日</th>
	    <th>设备金额</th>
	    <th>实际付款</th>
	    <th>支付日期</th>
	    <th>一月计划租金</th>
	    <th>二月计划租金</th>
	    <th>三月计划租金</th>
	    <th>四月计划租金</th>
	    <th>五月计划租金</th>
	    <th>六月计划租金</th>
	    <th>七月计划租金</th>
	    <th>八月计划租金</th>
	    <th>九月计划租金</th>
	    <th>十月计划租金</th>
	    <th>十一月计划租金</th>
	    <th>十二月计划租金</th>
	    <th>一月实收租金</th>
	    <th>二月实收租金</th>
	    <th>三月实收租金</th>
	    <th>四月实收租金</th>
	    <th>五月实收租金</th>
	    <th>六月实收租金</th>
	    <th>七月实收租金</th>
	    <th>八月实收租金</th>
	    <th>九月实收租金</th>
	    <th>十月实收租金</th>
	    <th>十一月实收租金</th>
	    <th>十二月实收租金</th>
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td align="center" nowrap><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td align="center" nowrap><%=getDBStr( rs.getString("project_name") ) %></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("cust_name")) %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("srent")),"#,##0.00")%></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("income_number_year")) %></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("lease_term")) %></td>
		<td align="center" nowrap><%= getDBDateStr( rs.getString("sign_date")) %></td>
		<td align="center" nowrap><%= getDBDateStr( rs.getString("start_date")) %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("equip_amt")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("fact_money")),"#,##0.00") %></td>
		<td align="center" nowrap><%= getDBDateStr( rs.getString("fact_date")) %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_1_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_2_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_3_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_4_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_5_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_6_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_7_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_8_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_9_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_10_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_11_rent")),"#,##0.00")%></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("jx_12_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_1_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_2_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_3_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_4_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_5_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_6_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_7_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_8_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_9_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_10_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_11_rent")),"#,##0.00") %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("sh_12_rent")),"#,##0.00") %></td>
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
