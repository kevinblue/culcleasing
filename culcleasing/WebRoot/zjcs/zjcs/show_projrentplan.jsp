<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目租金测算 - 租金测算展示页</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript">
function addText(proj_id,measure_type)
{
    //document.form1.textOne.value = proj_id;
    //alert(proj_id);
} 
</script>
</head>
<%
	ResultSet rs;
	String sqlstr = "";
	String wherestr = " where 1=1";
	
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String measure_type = getStr(request.getParameter("measure_type"));//租金计算方法
	String temp_type = getStr(request.getParameter("temp_type"));//用于判断是否是只读页面 zhiduPage
	if(temp_type.equals("") || temp_type == null){
		temp_type = "no_zhidu";
	}
	
//	String equip_amt = "";//设备款
//	String caution_money = "";//保证金
//	String handling_charge = "";//手续费
//	String start_date = "";//起租日
//	String year_rate = "";//年利率
//	String income_number = "";//期数
//	String lease_money = "";//租赁本金
//	String period_type = "";//付租类型
//	String income_number_year = "";//付租方式
//	String consulting_fee = "";//咨询费
	//String plan_status = "";//回笼状态
//	if(measure_type.equals("") && measure_type != null){
//		StringBuffer sql = new StringBuffer();
		//查询项目交易结构表
//		sql.append(" select *  from proj_condition_temp  ")
//		   .append(" where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ");
//		rs = db.executeQuery(sql.toString());
//		while(rs.next()){
//			measure_type = getDBStr(rs.getString("measure_type"));
//			equip_amt = getDBStr(rs.getString("equip_amt"));
//			caution_money = getDBStr(rs.getString("caution_money"));
//			handling_charge = getDBStr(rs.getString("handling_charge"));
//			start_date = getDBStr(rs.getString("start_date"));
//			year_rate = getDBStr(rs.getString("year_rate"));
//			income_number = getDBStr(rs.getString("income_number"));
//			lease_money = getDBStr(rs.getString("lease_money"));
//			period_type = getDBStr(rs.getString("period_type"));
//			income_number_year = getDBStr(rs.getString("income_number_year"));
//			consulting_fee = getDBStr(rs.getString("consulting_fee"));
//			//plan_status = getDBStr(rs.getString("plan_status"));
//		}
//	}
	
	//偿还计划
	String rent_list="";
	String plan_date="";
	String rent="";
	String corpus="";
	String interest="";
	String rent_adjust="";
	String rent_overage="";
	String corpus_overage="";
	String plan_status="";
	List l_rent_list = new ArrayList();
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_rent_overage = new ArrayList();//剩余租金
	List l_corpus_overage = new ArrayList();//剩余本金
	List l_plan_status = new ArrayList();//回笼状态
	//List l_rent_adjust = new ArrayList();
	//contract_id='"+contract_id+"' 暂时不用
	sqlstr = "select * from fund_rent_plan_proj_temp where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"' order by rent_list";
	
	rs = db.executeQuery(sqlstr);
//	rs.last(); 
//	int rowCount = rs.getRow();//判断临时表中是否有值
//	rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
//	if(rowCount <= 0){//临时表中无值则查询正式表，正式表存在值则将正式表中的数据插入到对应的租金临时表中
//		String query_sql =  "select * from fund_rent_plan_proj   where  proj_id = '"+proj_id+"' ";
//		StringBuffer insert_sql = new StringBuffer();
//		insert_sql.append(" INSERT INTO fund_rent_plan_proj_temp( ")
//		          .append(" proj_id,rent_list,plan_status,plan_date,eptd_rent, ")
//		          .append(" rent,corpus,year_rate,interest,rent_overage,corpus_overage, ")
//		          .append(" interest_overage,penalty_overage,penalty,rent_type ")
//		          .append(" ,creator,create_date,modificator,modify_date ")
//		          .append(" ,measure_id ")//该字段正式表中没有
//		          .append(" ,corpus_market ")//市场本金 【新增字段 2010-08-04】
//			      .append(" ,interest_market ")//市场利息 【新增字段 2010-08-04】
//			       .append(" ,corpus_overage_market) ")//市场本金余额【新增字段 2010-08-04】
//		          .append(" select ")
//		          .append(" proj_id,rent_list,plan_status,plan_date,eptd_rent ")
//		          .append(" ,rent,corpus,year_rate,interest,rent_overage,corpus_overage ")
//		          .append(" ,interest_overage,penalty_overage,penalty,rent_type ")
//		          .append(" ,creator,create_date,modificator,modify_date ")
//		          .append(" ,'"+doc_id+"'")
//		          .append(" ,corpus_market,interest_market,corpus_overage_market") //【新增字段 2010-08-04】
//		          .append(" from fund_rent_plan_proj ")
//		          .append("  where  proj_id = '"+proj_id+"'  ");
//		 db.executeUpdate(insert_sql.toString());
//		 rs = db.executeQuery(sqlstr);
//	}
	
//System.out.println("租金测算查询的页面查询SQL……………………"+sqlstr);
	while(rs.next()){
		rent_list = getDBStr(rs.getString("rent_list"));
		plan_date = getDBDateStr(rs.getString("plan_date"));
		rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
		corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus")));
		interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest")));
		rent_overage = formatNumberDoubleTwo(getDBStr(rs.getString("rent_overage")));
		corpus_overage = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage")));
		plan_status = getDBStr(getDBStr(rs.getString("plan_status")));
		//rent_adjust = formatNumberDoubleTwo(getDBStr(rs.getString("rent_adjust")));
		l_rent_list.add(rent_list);
		l_plan_date.add(plan_date);
		l_rent.add(rent);
		l_corpus.add(corpus);
		l_interest.add(interest);
		l_rent_overage.add(rent_overage);
		l_corpus_overage.add(corpus_overage);
		l_plan_status.add(plan_status);
		//l_rent_adjust.add(rent_adjust);
	}

	//查询租金本金利息的三个分别得总合
	String query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_proj_temp  where   proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
	rs = db.executeQuery(query_count);
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	while(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}

	int countSize = l_rent_list.size();//获取分期总数
	rs.close();
	db.close();
 %>
<body style="overflow:auto;" >
<form name="form1" method="post" target="_black" action="rentplan_sc.jsp" ><!-- onSubmit="return checkdata(this);"  -->
<!-- 隐藏域传值  -->

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>利息</th>
        <!-- 
        <th>租金余额</th>
         -->
        <th>本金余额</th>
      </tr>
<%	  
	for ( int i=0;i<l_rent_list.size();i++){
	String num = String.valueOf(i);
	String nameValue = "zjtz"+num;//拼装输入框的‘name’‘id’属性
	String rent_list_nameValue = "rent_list"+num;//期项
	String plan_date_nameValue = "plan_date"+num;//应收日期
	String rent_nameValue = "rent"+num;//租金
	String corpus_nameValue = "corpus"+num;//本金
	String interest_nameValue = "interest"+num;//利息
%>
      <tr class="maintab_content_table_title">
		<td>
			<%= l_rent_list.get(i) %>
			<input type="hidden" value="<%=l_rent_list.get(i)%>" name="<%=rent_list_nameValue%>" />
		</td> 
		<td>
			<%= l_plan_date.get(i) %>
			<input type="hidden" value="<%=l_plan_date.get(i)%>" name="<%=plan_date_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr(l_rent.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_rent.get(i).toString()%>" name="<%=rent_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr( l_corpus.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_corpus.get(i).toString()%>" name="<%=corpus_nameValue%>" />
		</td> 
		<td>
			<%=formatNumberStr( l_interest.get(i).toString(),"#,##0.00") %>
			<input type="hidden" value="<%=l_interest.get(i).toString()%>" name="<%=interest_nameValue%>" />
		</td>
		<td>
			<%=formatNumberStr( l_corpus_overage.get(i).toString(),"#,##0.00") %>
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