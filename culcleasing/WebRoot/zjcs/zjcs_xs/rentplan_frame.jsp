<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<%
	ResultSet rs;
	String sqlstr="";
	String wherestr=" where 1=1";
	
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));
	
	//如果临时表中没有数据则将before表中的数据插入临时表
	int i_count=0;
	sqlstr="select count(*) as i_count from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		i_count=rs.getInt("i_count");
	}rs.close();
	if(i_count>0){
	
	}else{
		sqlstr="insert into fund_rent_plan_temp(measure_id,contract_id, rent_list, plan_status, plan_date, rent_adjust, eptd_rent, rent, straight_interest, corpus, year_rate, interest, rent_overage, corpus_overage, interest_overage, penalty_overage, penalty, rent_type, creator, create_date, modificator, modify_date) select '"+doc_id+"', contract_id, rent_list, plan_status, plan_date, rent_adjust, eptd_rent, rent, straight_interest, corpus, year_rate, interest, rent_overage, corpus_overage, interest_overage, penalty_overage, penalty, rent_type, creator, create_date, modificator, modify_date from fund_rent_plan_before where contract_id='"+contract_id+"'";
		db.executeUpdate(sqlstr);
	}
	
	//偿还计划
	String rent_list="";
	String plan_date="";
	String rent="";
	String corpus="";
	String interest="";
	String rent_adjust="";
	List l_rent_list = new ArrayList();
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_rent_adjust = new ArrayList();
	sqlstr="select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' order by rent_list";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		rent_list = getDBStr(rs.getString("rent_list"));
		plan_date = getDBDateStr(rs.getString("plan_date"));
		rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
		corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus")));
		interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest")));
		rent_adjust = formatNumberDoubleTwo(getDBStr(rs.getString("rent_adjust")));
		l_rent_list.add(rent_list);
		l_plan_date.add(plan_date);
		l_rent.add(rent);
		l_corpus.add(corpus);
		l_interest.add(interest);
		l_rent_adjust.add(rent_adjust);
	}rs.close();
	
	
	db.close();
	//System.out.println(getDateAdd("2009-01-31",1,"mm").substring(0,8)+"15");
 %>
<body style="overflow:auto;" >
<form name="form1" method="post" target="_black" action="rentplan_sc.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="租金调整"  type="submit">
									<img src="../../images/save.gif" align="absmiddle" border="0">租金调整</button>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>利息</th>
        <th>调整租金</th>
      </tr>
  

<%	  
	for ( int i=0;i<l_rent_list.size();i++){
%>

      <tr class="maintab_content_table_title">
		<td><%= l_rent_list.get(i) %></td> 
		<td><%= l_plan_date.get(i) %></td> 
		<td><%=formatNumberStr( l_rent.get(i).toString(),"#,##0.00") %></td> 
		<td><%=formatNumberStr( l_corpus.get(i).toString() ,"#,##0.00")%></td> 
		<td><%= formatNumberStr(l_interest.get(i).toString(),"#,##0.00") %></td>
		<td><input name="rent_adjust" type="text" value="<%=l_rent_adjust.get(i) %>"  dataType="Money" size="10" maxB="20"></td>
		
      </tr>
<%
	}
%>
    </table>


</div>
</div>
</form>
</body>
</html>
<script language="javascript">

</script>