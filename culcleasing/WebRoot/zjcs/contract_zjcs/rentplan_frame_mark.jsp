<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同交易结构 - 租金测算查询</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript">
function addText(proj_id,measure_type)
{
    //document.form1.textOne.value = proj_id;
    alert(proj_id);
} 
</script>
</head>
<%
	ResultSet rs;
	String sqlstr = "";
	String wherestr = " where 1=1";
	
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String measure_type = getStr(request.getParameter("measure_type"));//租金计算方法

	String equip_amt = "";//设备款
	String caution_money = "";//保证金
	String handling_charge = "";//手续费
	String start_date = "";//起租日
	String year_rate = "";//年利率
	String income_number = "";//期数
	String lease_money = "";//融资额
	String period_type = "";//付租类型
	String income_number_year = "";//付租方式
	String consulting_fee = "";//咨询费
	//String plan_status = "";//回笼状态
	

	//偿还计划
	String rent_list="";
	String plan_date="";
	String rent="";
	String corpus_market = "";//市场本金
	String interest_market="";//市场利息
	String corpus_overage_market="";//市场本金余额
	
	String rent_overage="";
	String plan_status="";
	
	List l_rent_list = new ArrayList();
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus_market = new ArrayList();
	List l_interest_market = new ArrayList();
	List l_corpus_overage_market = new ArrayList();//
	
	List l_rent_overage = new ArrayList();//剩余租金
	List l_plan_status = new ArrayList();//回笼状态

	
	String query_sql = "select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' order by rent_list";
	rs = db.executeQuery(query_sql);//执行最终的租金测算列表查询语句
	while(rs.next()){
		rent_list = getDBStr(rs.getString("rent_list"));
		plan_date = getDBDateStr(rs.getString("plan_date"));
		rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
		corpus_market = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")));
		interest_market = formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")));
		corpus_overage_market = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")));
		
		rent_overage = formatNumberDoubleTwo(getDBStr(rs.getString("rent_overage")));
		plan_status = getDBStr(getDBStr(rs.getString("plan_status")));
		//rent_adjust = formatNumberDoubleTwo(getDBStr(rs.getString("rent_adjust")));
		l_rent_list.add(rent_list);
		l_plan_date.add(plan_date);
		l_rent.add(rent);
		l_corpus_market.add(corpus_market);
		l_interest_market.add(interest_market);
		l_rent_overage.add(rent_overage);
		l_corpus_overage_market.add(corpus_overage_market);
		
		l_plan_status.add(plan_status);
		//l_rent_adjust.add(rent_adjust);
	}

	//查询租金本金利息的三个分别得总合
	String query_count = "select sum(rent) as count_rent,sum(corpus_market) as count_corpus,sum(interest_market) as count_interest from fund_rent_plan_temp  where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	rs = db.executeQuery(query_count);
	System.out.println("查询总数SQL-------》 "+query_count);
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	while(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	
	rs.close();
	db.close();
	int countSize = l_rent_list.size();//获取分期总数
	//System.out.println(getDateAdd("2009-01-31",1,"mm").substring(0,8)+"15");
 %>
<body style="overflow:auto;" >
<form name="form1" method="post" target="_black" action="rentplan_sc.jsp" ><!-- onSubmit="return checkdata(this);"  -->

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>市场本金</th>
        <th>市场利息</th>
        <th>市场本金余额</th>  
       
      </tr>
<%	  
	for ( int i=0;i<l_rent_list.size();i++){
%>
      <tr class="maintab_content_table_title">
		<td>
			<%= l_rent_list.get(i) %>
		</td> 
		<td>
			<%= l_plan_date.get(i) %>
		</td> 
		<td>
			<%=formatNumberStr(l_rent.get(i).toString(),"#,##0.00") %>
		</td> 
		<td>
			<%=formatNumberStr( l_corpus_market.get(i).toString(),"#,##0.00") %>
		</td> 
		<td>
			<%=formatNumberStr( l_interest_market.get(i).toString(),"#,##0.00") %>
		</td>
		<td>
			<%=formatNumberStr( l_corpus_overage_market.get(i).toString(),"#,##0.00") %>
		</td>
      </tr>
<%
	}
%>
		<tr class="maintab_content_table_title" > 
			<td colspan="">&nbsp;</td>
			<td colspan="">&nbsp;</td>
			<td colspan="">合计:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
			<td colspan="">合计:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
			<td colspan="">合计:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
			<td colspan="">&nbsp;</td>
		</tr>
    </table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function checkdata(obj){
	if(Validator.Validate(obj,3)){
		var arr=document.form1.input;
		var flag="";
		for (var i=0;i<arr.length;i++){
			if(arr[i].value!=""){
				flag="1";
				break;
			}
		}
		if(flag==""){
			alert("调整值不能全为空!");
			return false;
		}else{
			return true;
		}
	}else{
		return false;
	}
}
</script>