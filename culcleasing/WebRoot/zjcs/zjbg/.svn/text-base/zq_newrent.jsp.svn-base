<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 合同(市场)偿还计划变更</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>

<body style="overflow:auto;" >
<%
	String doc_id = getStr(request.getParameter("doc_id"));//项目编号
	String proj_id = getStr(request.getParameter("proj_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String sqlstr;
	ResultSet rs;
	

	
	//String start_list = "";//开始期项
	//String adjust_list = "";//调整后期项
	//从交易结构表中根据 proj_id 查询
	String handling_charge = "";//手续费
	String caution_money = "";//租赁保证金
	String equip_amt = "";//设备款
	String start_date = "";//起租日
	String income_day = "";//每月偿付日
	//String income_number = "";//交易结构表中的的总期数
	String year_rate = "";//年利率
	String lease_money = "";//本金总额
	String income_number_year = "";//付租方式
	String net_lease_money = "";//净融资额
	String period_type = "";//期初（期末）支付
	String consulting_fee = "";//咨询费

	String creator = "";//
	String create_date = "";//
	String modificator = "";//
	String modify_date = "";//

	//查询   【注意 从临时表查询】
	String sql = " select * from contract_condition_temp where contract_id = '"
			+ contract_id + "' and measure_id = '" + doc_id + "'";
	rs = db.executeQuery(sql);
	//System.out.println("变更后查询sql22222222222222222222222221111111111111111111111111111==>  "+sql);
	String measure_type = "";//租金计算方法 等额租金|等额本金|不规则|手工调整","1|2|0|3"
	if (rs.next()) {
		measure_type = getDBStr(rs.getString("measure_type"));
		handling_charge = getDBStr(rs.getString("handling_charge"));
		lease_money = getDBStr(rs.getString("lease_money"));
		year_rate = getDBStr(rs.getString("year_rate"));
		caution_money = getDBStr(rs.getString("caution_money"));
		equip_amt = getDBStr(rs.getString("equip_amt"));
		start_date = getDBDateStr(rs.getString("start_date"));
		income_day = getDBStr(rs.getString("income_day"));
		income_number_year = getDBStr(rs.getString("income_number_year"));
		net_lease_money = getDBStr(rs.getString("net_lease_money"));
		period_type = getDBStr(rs.getString("period_type"));
		consulting_fee = getDBStr(rs.getString("consulting_fee"));
		//income_number = getDBStr(rs.getString("income_number"));
		creator = getDBStr(rs.getString("creator"));
		create_date = getDBStr(rs.getString("create_date"));
		modificator = getDBStr(rs.getString("modificator"));
		modify_date = getDBStr(rs.getString("modify_date"));
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
	
	//取正式表的数据 因为之前做过核销的操作 
	sqlstr = "select * from fund_rent_plan_temp where contract_id='"
			+ contract_id +	"' and measure_id='" + doc_id
			+ "' order by rent_list";
	System.out.println("变更后查询sql==>  " + sqlstr);
	rs = db.executeQuery(sqlstr);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
%>
<!--  onSubmit="return checkdata(this);"  -->
<form name="form1" method="post" target="_black" action="adjust_save.jsp" >
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<input type="hidden" name="proj_id" value="<%=proj_id%>">
<input type="hidden" name="contract_id" value="<%=contract_id%>">
<!-- 年利率，本金总额，手续费，租金计算方法,租赁保证金,设备款,起租日,付租方式  -->
<input type="hidden" name="year_rate" value="<%=year_rate%>">
<input type="hidden" name="lease_money" value="<%=lease_money%>">
<input type="hidden" name="handling_charge" value="<%=handling_charge%>">
<input type="hidden" name="measure_type" value="<%=measure_type%>">
<input type="hidden" name="caution_money" value="<%=caution_money%>">
<input type="hidden" name="equip_amt" value="<%=equip_amt%>">
<input type="hidden" name="start_date" value="<%=start_date%>">
<input type="hidden" name="income_number_year" value="<%=income_number_year%>">
<!-- ,净融资额,期初（期末）支付,每月偿付日,咨询费  -->
<input type="hidden" name="net_lease_money" value="<%=net_lease_money%>">
<input type="hidden" name="period_type" value="<%=period_type%>">
<input type="hidden" name="income_day" value="<%=income_day%>">
<input type="hidden" name="consulting_fee" value="<%=consulting_fee%>">
<!-- 创建人，创建日期，修改人，修改日期 -->
<input type="hidden" name="creator" value="<%=creator%>">
<input type="hidden" name="create_date" value="<%=create_date%>">
<input type="hidden" name="modificator" value="<%=modificator%>">
<input type="hidden" name="modify_date" value="<%=modify_date%>">
<!-- end cwCellTop -->

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
		<th>回笼状态</th>
      </tr>
   
<%
   	int i = 1;//从1开始计算为了方便进行统计最终的期项
   	while (rs.next()) {
   		String num = String.valueOf(i);
   		String rent_list = getDBStr(rs.getString("rent_list"));//表中期数
   		String plan_status = getDBStr(rs.getString("plan_status"));//回笼状态
   		String plan_date_nameValue = "";//日期
   		String rent_list_nameValue = "";//期数
   		String rent_nameValue = "";//租金
   		String corpus_nameValue = "";//本金
   		String year_rate_nameValue = "";//利率
   		String interest_nameValue = "";//利息
   		String corpus_overage_nameValue = "";//
   		String nameValue = "";//最后一列
   		//如果该行数据已回笼，则不进行任何操作
   		//if(!plan_status.equals("未回笼")){

   		//}else{	
   		//隐藏域传值的属性 拼装输入框的‘name’‘id’属性
   		plan_date_nameValue = "plan_date" + num;//日期
   		rent_list_nameValue = "rent_list" + num;//期数
   		rent_nameValue = "rent" + num;//租金
   		corpus_nameValue = "corpus" + num;//本金
   		year_rate_nameValue = "year_rate" + num;//利率
   		interest_nameValue = "interest" + num;//利息
   		corpus_overage_nameValue = "corpus_overage" + num;//
   		nameValue = "zjbg" + num;//最后一列
   		//}
   %>
	<tr class="maintab_content_table_title" >
		<td align="center">
			<%=rent_list%>
			<input type="hidden" name="<%=rent_list_nameValue%>" value="<%=rent_list%>"/>
		</td>
		<td align="center">
			<%=getDBDateStr(rs.getString("plan_date"))%>
			<input type="hidden" name="<%=plan_date_nameValue%>" value="<%=getDBDateStr(rs.getString("plan_date"))%>"/>
		</td>
		<td align="center">
			<%=formatNumberStr(getDBStr(rs.getString("rent")),"#,##0.00")%>
			<input type="hidden" name="<%=rent_nameValue%>" value="<%=getDBStr(rs.getString("rent"))%>"/>
		</td>
		<td align="center">
			<%=formatNumberStr(getDBStr(rs.getString("corpus_market")),"#,##0.00")%>
			<input type="hidden" name="<%=corpus_nameValue%>" value="<%=getDBStr(rs.getString("corpus_market"))%>"/>
		</td>
		<td align="center">
			<%=formatNumberStr(getDBStr(rs.getString("interest_market")),"#,##0.00")%>
			<input type="hidden" name="<%=year_rate_nameValue%>" value="<%=getDBStr(rs.getString("year_rate"))%>"/>
		</td>
		<td align="center">
			<%=formatNumberStr(getDBStr(rs.getString("corpus_overage_market")),"#,##0.00")%>
			<input type="hidden" name="<%=corpus_overage_nameValue%>" value="<%=getDBStr(rs.getString("corpus_overage_market"))%>"/>
			<input type="hidden" name="<%=interest_nameValue%>" value="<%=getDBStr(rs.getString("interest_market"))%>"/>
		</td>
		<td>
			<%=plan_status%>
			<input name="<%=nameValue%>" id="<%=nameValue%>" type="hidden" 
				value="<%=plan_status%>" />
		</td>
<%
		//? ??????????????????????????
		i = i + 1;
%>
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
<%
	rs.close();
	db.close();
%>
    <!-- 将i的值传入保存页面用于判断取值,最后一次循环完毕后i做了加1操作这里该减去  -->
    <input type="hidden" name="count_rent_list" value="<%=i-1%>" />
</table>


</div>
</div>
</form>
</body>

</html>
<script language="javascript">
function checkdata(obj){
	if(Validator.Validate(obj,3)){
		
		if(typeof(document.form1.rent_adjust) == "undefined"){
			alert("没有调整项！");
			return false;
		}
		var arr=document.form1.rent_adjust;
		
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
<%
	db.close();
%>