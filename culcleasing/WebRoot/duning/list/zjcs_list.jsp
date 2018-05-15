<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期情况 -租金催收</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("duning-zjcs-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchtype = getStr( request.getParameter("searchtype") );
String star = getStr( request.getParameter("star") );
String end = getStr( request.getParameter("end") );
String date = getStr( request.getParameter("date") );
double floor=0;
double ceil=0;
ResultSet rs;
String wherestr="";
if( searchFld.equals("客户名称") ) {
	wherestr += " and  cust_name like '%"+searchKey+"%'";
}else if( searchFld.equals("合同编号") ) {
	wherestr += " and contract_id like '%"+searchKey+"%'";
}else if(searchFld.equals("担保人")){
	wherestr += " and assuror like '%"+searchKey+"%'";
}else if(searchFld.equals("分公司")){
	wherestr += " and sale_name like '%"+searchKey+"%'";
}else if(searchFld.equals("催款员")){
	wherestr += " and dun like '%"+searchKey+"%'";
}else if(searchFld.equals("业务员")){
	wherestr += " and proj_manage like '%"+searchKey+"%'";
}
if(!star.equals("")&&!end.equals("")){
try{
		floor=Double.parseDouble(star);
		ceil=Double.parseDouble(end);
		wherestr += " and out_counts <="+ceil+" and out_counts >="+floor ;
}catch (Exception e) {
		searchKey="";
		%>
        <script>alert('期数只能是数字!');</script>
		<%
}
}
if(date.equals("")||date==""){
	date=getSystemDate(0);
}
String sqlstr ="";
String where1="";
if(searchtype.equals("3")||searchtype.equals("")){
	//where1=" and 100>info.contract_status and  info.contract_status>30 ";
	where1=" and duning.out_rent>0";
}else if(searchtype.equals("0")){
	where1=" and out_counts>0 and hire_date<dateadd(mm,-1,dateadd(dd,-datepart(dd,"+getSystemDate(1)+")+1,"+getSystemDate(1)+"))";
	//and out_rent>=out_rent_0  out_rent_3=0 and out_rent_0=rent
}else if(searchtype.equals("1")){
	where1=" and out_counts=0 and contract_id in(select contract_id from fund_rent_plan where datediff(dd,plan_date,'"+date+"')>-4 and datediff(dd,plan_date,'"+date+"')<=0 )";
}else if(searchtype.equals("2")){
	where1=" and duning.cust_id in (select cust_id from cust_attention) ";
}
sqlstr="select * from (select info.cust_id,out.contract_id,cust_name,dbo.getmodelbyid(device_type) as device_type,addr,mobile_number,dbo.getusername(proj_manage) as proj_manage,dbo.getassuror(out.contract_id) as assuror,(select top 1 nextliaison_date from dunning_record as re where re.cust_id=info.cust_id order by dunningrecord_id desc) as nextliaison_date,dbo.bb_getBadNub('2000-1-1','"+date+"',out.contract_id)as out_counts,(out_rent_0+out_rent_3+out_rent_6+out_rent_9+out_rent_12) as out_rent,dbo.bb_getPunishInterest(out.contract_id,'"+date+"') as out_penalty ,(select sum(isnull(rent,0)+isnull(rent_adjust,0)) from fund_rent_plan where contract_id=out.contract_id)-(select  sum(isnull(rent,0)+isnull(rent_adjust,0)) from fund_rent_income where contract_id=out.contract_id) as rent_balance,(dit.income_number-(select max(plan_list) from fund_rent_income where contract_id=out.contract_id)) as list,out_rent_0,out_rent_3,out_rent_6,out_rent_9,out_rent_12 ,equip_num,dbo.fk_getname(info.proj_dept) as sale_name,pay_type= CASE  dit.income_number_year when '1' then '月付' when '3' then '季付' when '6' then '半年付' when '12' then '年付' end,dit.income_number,(select top 1 isnull(rent,0)+isnull(rent_adjust,0) from fund_rent_plan where contract_id=out.contract_id and datediff(dd,plan_date,'"+date+"')<=0 order by id) as rent,(select sum(isnull(rent,0)+isnull(rent_adjust,0)+isnull(penalty,0)) from fund_rent_income where contract_id=out.contract_id and hire_date=(select max(hire_date) from fund_rent_income where contract_id=out.contract_id)) as hire_rent,(select max(hire_date) from fund_rent_income where contract_id=out.contract_id) as hire_date,(select top 1 pay_date  from dunning_record as re where re.cust_id=info.cust_id order by dunningrecord_id desc) as p_plan_date ,equip_sn,isnull(dit.actual_start_date,dit.start_date) as start_date,(select top 1 plan_date from fund_rent_plan where contract_id=out.contract_id and datediff(dd,plan_date,'"+date+"')<=0 order by plan_date) as plan_date,dbo.getusername(dun.dun) as dun from(select info.contract_id,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=30 and datediff(dd,plan_date,'"+date+"')>0)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=30 and datediff(dd,plan_date,'"+date+"')>0)) as out_rent_0 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=60 and datediff(dd,plan_date,'"+date+"')>30)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=60 and datediff(dd,plan_date,'"+date+"')>30))as out_rent_3 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=90 and datediff(dd,plan_date,'"+date+"')>60)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=90 and datediff(dd,plan_date,'"+date+"')>60))as out_rent_6 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=120 and datediff(dd,plan_date,'"+date+"')>90)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=120 and datediff(dd,plan_date,'"+date+"')>90))as out_rent_9,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')>120)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')>120))as out_rent_12 from contract_info as info  ) as out left join contract_info as info on (out.contract_id=info.contract_id)left join contract_equip as eq on(out.contract_id=eq.contract_id)left join vi_cust_all_info as cust on(info.cust_id=cust.cust_id)left join contract_condition as dit on(out.contract_id=dit.contract_id) left join contract_dun as dun on (out.contract_id=dun.contract_id)) as duning where 1=1 "+where1 +wherestr+" order by out_counts desc"; 
System.out.println(sqlstr);
%>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="0">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 租金催收 &gt;逾期情况</td>
  </tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->
      
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<form name="dataNav1" action="zjcs_list.jsp" onSubmit="goPage()">
  <tr class="maintab">
<td align="left" height="0">

        &nbsp;按&nbsp;<select name="searchFld">
          <script>w(mSetOpt("<%= searchFld %>","|客户名称|担保人|合同编号|分公司|催款员|业务员"));</script>
        </select>
        <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
          已逾
         <input name="star" type="text" size="3"  maxlength="3" value="<%=star %>">到
         <input name="end" type="text" size="3"  maxlength="3" value="<%=end %>">期&nbsp;&nbsp;&nbsp;&nbsp;
       截止日期为:
        <input name="date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=date %>"><img  onClick="openCalendar(date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
        <input type="radio" name="searchtype" <%if(searchtype.equals("3")||searchtype.equals(""))out.print("checked");%> value="3">查看全部<input type="radio"  <%if(searchtype.equals("0"))out.print("checked");%>  name="searchtype" value="0">查看特殊<input type="radio"  <%if(searchtype.equals("1"))out.print("checked");%>   name="searchtype" value="1">查看预逾期<input type="radio"  <%if(searchtype.equals("2"))out.print("checked");%>  name="searchtype" value="2">查看关注
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
       </td>
        </tr>
        <tr class="maintab">
  
  <td align="right" width="40%"><!--翻页控制开始-->
      <% 
	int intPageSize = 20;   //一页显示的记录数
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
	rs = db.executeQuery(sqlstr); 

	rs.last();                                      //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	System.out.println(sqlstr);
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
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0"></td>
          </tr>
        </table>
     </td>
  </tr>
   </form>
</table>

<!--翻页控制结束-->
<!--
</form>
<form name="list">
-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;height:470px;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table  style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      <th ></th>
      <th >合同编号</th>
      <th >客户名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	  <th >机编号</th>
	  <th >联系方式</th>
      <th >催款员&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <th >起租日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <th >下一次处理日</th>      
	  <th >最近一次付款金额/时间&nbsp;&nbsp;</th>
      <th >租金总余额/未还款期数</th>
      <th colspan="3">逾期</th>
      <th >逾期1～30</th>
      <th >逾期31～60</th>
      <th >逾期61～90</th>
      <th >逾期91～120</th>
      <th >逾期>=121</th>
	  <th >台数</th>
	  <th >分公司</th>
	  <th >付款方式</th>
	  <th >总期数</th>
	  <th >月还款</th>    
      <th >计划下次还款日</th>
	  <th >&nbsp;承诺还款日&nbsp;</th>
      <th >设备型号</th>
      <th >&nbsp;业务员&nbsp;</th>
	  <th >担保人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>      
	  <th >客户地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
      </tr>
      <tr class="maintab_content_table_title">
	  <th ></th>
	  <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
      <th>期数</th>
      <th>总金额</th>
      <th>总违约金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
      <th ></th>
	  <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
	  <th></th>
      </tr>
      <%	  
System.out.println(sqlstr);
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
		System.out.println(sqlstr+"=========="+i);
%>
      <tr class="cwDLRow">
      <%
	  String dj="";
	  double out_counts=rs.getDouble("out_counts");
	  if(out_counts>=3.0){
		  dj="<span style=\"font-size:16px;color:#F00\">危险</span>";
	  }else if(out_counts>=2.0){
		  dj="<span style=\"font-size:16px;color:#FC0\">警告</span>";
	  }
	  %>
      <td ><%=dj%></td>
       <td ><%= getDBStr( rs.getString("contract_id") ) %></td>
        <td ><a href="zjcs.jsp?cust_id=<%= getDBStr(rs.getString("cust_id") ) %>&enddate=<%=date %>&contract_id=<%= getDBStr(rs.getString("contract_id") ) %>" target="_blank"><%= getDBStr(rs.getString("cust_name") ) %></a></td>
		<td ><%= getDBStr( rs.getString("equip_sn") ) %></td>
        
        <td ><%= getDBStr( rs.getString("mobile_number") ) %></td>
        <td ><%= getDBStr( rs.getString("dun") ) %></td>
        <td ><%= getDBDateStr( rs.getString("start_date") ) %></td>
        <td ><%= getDBDateStr( rs.getString("nextliaison_date") ) %></td>        
        <td ><%= formatNumberStr( rs.getString("hire_rent") ,"#,##0.00" ) %><span style="color:#F00"> / </span><%= getDBDateStr( rs.getString("hire_date") ) %></td>  
        <td ><%= formatNumberStr( rs.getString("rent_balance")  ,"#,##0.00") %><span style="color:#F00"> / </span><%= getDBStr( rs.getString("list") ) %></td>
        <td >&nbsp;&nbsp;<%= formatNumberDoubleTwo(out_counts) %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_penalty")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_0") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_3")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_6") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_9"),"#,##0.00")%>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_12") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= getDBStr( rs.getString("equip_num") ) %>&nbsp;&nbsp;</td>
        <td ><%= getDBStr( rs.getString("sale_name") ) %></td>
        <td ><%= getDBStr( rs.getString("pay_type") ) %></td>      
        <td >&nbsp;&nbsp;<%= getDBStr( rs.getString("income_number") ) %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("rent") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td ><%= getDBDateStr( rs.getString("plan_date") ) %></td>     
        <td ><%= getDBDateStr( rs.getString("p_plan_date") ) %></td>  
        <td ><%= getDBStr( rs.getString("device_type") ) %></td> 
        <td ><%= getDBStr( rs.getString("proj_manage") ) %></td>
        <%
		String temp=getDBStr(rs.getString("assuror"));
		if(temp.length()>1){
		temp=temp.substring(0,temp.length()-33);
		}
		%>
        <td ><%= temp %></td>        
        <td ><%= getDBStr( rs.getString("addr") ) %></td>
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
<!--报表结束-->
</body>
</html>
