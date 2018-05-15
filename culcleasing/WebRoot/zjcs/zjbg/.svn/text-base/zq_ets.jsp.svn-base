<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 偿还计划变更</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript">
	function chaValue(){
		var obj = document.getElementById('start_list').value;
		var delay = document.getElementById('delay').value;//延迟期
		var grace = document.getElementById('grace').value;//宽限期
		var income_number = document.getElementById('income_number').value;
		if(obj == 1 || obj == '1'){
			if(delay > 0 || grace > 0){
				alert("由于涉及到宽限延迟特殊业务请选择其他其次进行变更!");
				return false;
			}
			//2011-03-28需求修改：可以随意输入期数
			else{//2010-12-07需求变更为，期数一直为交易结构中的总期数
			//	document.getElementById('adjust_list').value = income_number;
				return true;
			}
		}else{
		//	//var num =  income_number - obj + 1;
		//	document.getElementById('adjust_list').value = income_number;
			return true;
		}
	}
	function init_onload(){
		var income_number = document.getElementById('income_number').value;
		document.getElementById('adjust_list').value = income_number;
	}
</script>
</head>
<body onload="init_onload()">
<%
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String start_rent_list = getStr(request.getParameter("start_rent_list"));//期数
	String income_number = getStr(request.getParameter("income_number"));//
	String income_day = getStr(request.getParameter("income_day"));//
	String grace = getStr(request.getParameter("grace"));//宽限期
	String delay = getStr(request.getParameter("delay"));//延迟期
	String sqlstr;
	ResultSet rs;
	StringBuffer sql = new StringBuffer();
	String start_list = "";//开始期项
	String adjust_list = "";//调整后期项 用于计算调整几多期
	String year_rate = "";//年利率
	String lease_money = "";//本金总额
	String handling_charge = "";//手续费   
	String start_date = "";//对应期项的起租日期
	//String income_day = "";//每月偿付日
	String net_lease_money = "";//净融资额
	//String income_number = "";//还租次数
	int count_data = 0;
	

	
	
	System.out.println("join1==>==>  : "+start_rent_list);
	
	//首先根据传入的编号查询正式表，没有数据则提示
	String query_sql = " select * from  fund_rent_plan where contract_id = '"+contract_id+"'";
	ResultSet rs_o = db.executeQuery(query_sql);
	rs_o.last();
	count_data = rs_o.getRow();
	rs_o.beforeFirst();
	rs_o.close();
	//正式表存在数据则进行调整操作否则进行提示
	if(count_data > 0){
		//【2011-03-29 增加需求先查询新增的操作记录表：fund_rent_adjust 存在数据侧从这里取数据显示否则按原本需求操作】
		String q_s = "   select * from fund_rent_adjust where contract_id = '"+contract_id+"' and measure_id='"+doc_id+"'  ";
		ResultSet rsq = db.executeQuery(q_s);
		int c_num = 0;
		while(rsq.next()){
			c_num = c_num + 1;
			start_list = rsq.getString("start_list");//调整开始期数
			year_rate = getZeroStr(getStr(rsq.getString("year_rate")));//年利率
			lease_money = getZeroStr(getStr(rsq.getString("corpus_overage")));//剩余本金
			adjust_list = rsq.getString("income_number");//总期数调整为
			income_day = rsq.getString("income_day");//每月偿付日调整为
		}
		rsq.close();
		if(c_num <= 0){//【2011-03-29 增加需求 end
			//第一次进入页面初始化值时 start_rent_list是为空的
			if(start_rent_list.equals("") || start_rent_list == null){
				//拼装查询最早一期为‘未回笼’的数据SQL语句
				//项目编号,文档编号,期数,还租日期,本金余额 contract_id,measure_id,rent_list,plan_date,corpus_overage
				//年利率,租金,本金,利息 year_rate,rent,corpus,interest
				sql.append(" select * from fund_rent_plan  ")
				   .append(" where 1 = 1 ")
				   .append(" and contract_id = '"+contract_id+"' ")//项目编号
				   .append(" and plan_status = '未回笼' ")
				   .append(" and rent_list = ( ")//默认进入页面查询‘未回笼’数据中‘最小期数’的数据为初始化数据
				   					.append(" select min(rent_list) as rent_list from fund_rent_plan   ")
				   					.append(" where contract_id = '"+contract_id+"'  and plan_status = '未回笼'  ")
				   .append(" ) ");
				   	//.append(" and measure_id = '"+doc_id+"' ");
				//先判断是否正式租金列表存在已回笼数据，如果存在‘已回笼’的数据则查找期数最小一期'未回笼'的租金测算‘起租日’‘年利率’‘期数’
				rs = db.executeQuery(sql.toString());
				System.out.println("sql==>==>  : "+sql);
				while(rs.next()){
					start_list = getDBStr(rs.getString("rent_list"));//期数
					start_rent_list = start_list;
				}
				rs.close();
			}
		    System.out.println("start_list==>==>  : "+start_rent_list);
		    
			//如果传入的‘期项’是从第一期开始计算，则对应的租金测算条件就从交易结构中查询
			if( start_rent_list.equals("1")){//期数为空 或者 期数 为1
				//如果从第一期开始调整，则直接从‘合同交易结构正式表’中将租金测算对应的条件取出显示
				sqlstr = " select * from contract_condition where contract_id = '"+contract_id+"' "; 
				ResultSet rs_one = db.executeQuery(sqlstr);
				System.out.println("join3==>==>  : "+sqlstr);
				while(rs_one.next()){
					lease_money = getDBStr(rs_one.getString("lease_money"));//本金余额 = 租赁本金
					handling_charge = getDBStr(rs_one.getString("handling_charge"));//手续费 handling_charge
					year_rate = getDBStr(rs_one.getString("year_rate"));//年利率
					start_date = getDBStr(rs_one.getString("start_date"));//起租日
					income_day = getDBStr(rs_one.getString("income_day"));//每月偿付日
					//净融资额 【注：新增字段 2010-07-15】
					net_lease_money = getDBStr(rs_one.getString("net_lease_money"));
					income_number = getDBStr(rs_one.getString("income_number"));
					
					//根据每月偿付日和起租日计算正确的起租日期
					start_date = start_date.substring(0,8)+income_day;
				}
				System.out.println("income_day------>"+income_day);
				rs_one.close();
				start_list = "1";//从第一期开始进行调整
				sqlstr = " ";
			}else{//如果‘期项’不为空并且不是第一期，则根据传入的从第几期开始调整进行查询对应的租金测算条件
				//总的本金余额需要取上一期的本金余额
				int rent_listTemp = Integer.parseInt(start_rent_list) - 1;//计算上一期的期项 取上一期期项的本金余额
				sqlstr = " select corpus_overage_market,* from fund_rent_plan where contract_id = '"+contract_id+"' and rent_list = '"+rent_listTemp+"' ";
				ResultSet rs_two =  db.executeQuery(sqlstr);
				//System.out.println("join2222==>==>  : "+sqlstr);
				while(rs_two.next()){
					lease_money = getDBStr(rs_two.getString("corpus_overage_market"));//本金余额 = 上一期数的本金余额 【市场的 2010-12-08修改】
				}
				rs_two.close();
				//查询本期的 起租日，年利率，期项即为传入的期项 表示从这一期开始调整
				sqlstr = "  ";
				sqlstr = " select rent_list,plan_date,year_rate from fund_rent_plan where contract_id = '"+contract_id+"' and rent_list = '"+start_rent_list+"'";
				ResultSet rs_three  = db.executeQuery(sqlstr);
				System.out.println("join4==>==>  : "+sqlstr);
				if(rs_three.next()){
					start_date = getDBStr(rs_three.getString("plan_date"));
					year_rate = getDBStr(rs_three.getString("year_rate"));
				}
				rs_three.close();
				start_list = start_rent_list;
				System.out.println("join5==>==>  : "+start_rent_list);
			}
			lease_money = formatNumberDoubleTwo(lease_money);//格式化
		    System.out.println("join6==>==>  : "+lease_money);
		}
	}
	db.close();
	//onSubmit="return checkdata(this)"
 %>
<form  target="_blank" action="zq_save.jsp" method="post" name="form1">
<input type="hidden" name="income_number" id="income_number" value="<%=income_number %>"/> 
<input type="hidden" name="grace" id="grace" value="<%=grace %>"/> 
<input type="hidden" name="delay" id="delay" value="<%=delay %>"/> 
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
<%
	if(contract_id.equals("") || doc_id.equals("") || count_data > 0){ 
%>						
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap ><!--  type="submit" -->
									<BUTTON class="btn_2" name="btnSave" value="调整偿还计划" onclick="checkdata()">
									<img src="../../images/save.gif" align="absmiddle" border="0">调整偿还计划</button>
								</td>
							</tr>
						</table>
<%
	} 
%>						
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<input type="hidden" name="contract_id" value="<%=contract_id%>">
<input type="hidden" name="start_date" value="<%=start_date%>">
<div id="divH"  style="background:#ffffff;width:100%;height:200px;overflow:auto;">
<div id="TD_tab_0">
	<table  border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<%
	//如果编号为空 或者正式表数据为空
	if(contract_id.equals("") || doc_id.equals("") || count_data <= 0){ 
%>	
	 <tr>
	 	<td align="center" rowspan="3">
	 		当前偿还计划没有数据不能进行租金调整!
	    </td>	
	 </tr>
<%
	 }else{
%>
	  <tr>
	  	<td align="center">调整开始期数</td>
	  	<td><input name="start_list" type="text" value="<%=start_list%>"  dataType="Integer" size="10" maxB="4"  Require="true" readonly onPropertychange="chaValue()"></td>	 	
	    <td align="center">年利率</td>
	    <td>
	    	<input name="year_rate" type="text" value="<%=year_rate%>"  
	    	dataType="Rate" size="10" maxB="10"  Require="true">%
	    	<span class="biTian">*</span>
	    </td>	 	
		<td align="center">剩余本金</td>
		<td><input name="lease_money" type="text" value="<%=lease_money%>"  dataType="Money" size="15" maxB="15"  Require="true" readonly></td>	 	
	    <td align="center">总期数调整为</td>
	    <td>
	    	<input name="adjust_list" type="text" value="<%=adjust_list%>"  
	    		dataType="Integer" size="10" maxB="4"  Require="true" onchange="check_adjust_list()">
	    	期<span class="biTian">*</span>
	    </td>	 	
		<!-- 
	  	 -->
		<td align="center">每月偿付日调整为</td>
  		<td>
  			<%
  				String day_str = "";
  				for(int n = 1; n < 32;n++){ 
  					day_str = day_str + n+"|";
  				}
  				day_str = day_str.substring(0,day_str.length()-1);
  			%>
  	 			<select name="tz_date" id="tz_date"  >
				<script>
					var tz_date = "<%=income_day%>";
					if(tz_date != null && tz_date != ""){
						w(mSetOpt("<%=income_day%>","<%=day_str%>","<%=day_str%>")); 
					}else{
						w(mSetOpt("1","<%=day_str%>","<%=day_str%>")); 
					}
				</script>
				</select>
  				<span class="biTian">*</span>
		</td>
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

function check_adjust_list(){
	var start_list = parseInt(document.getElementById('start_list').value);
	var adjust_list = parseInt(document.getElementById('adjust_list').value);
	var income_number = document.getElementById('income_number').value;
	//alert(adjust_list);
	if(start_list > adjust_list){
		alert("调整的总期数小于调整开始期数!");
		document.getElementById('adjust_list').value = income_number;
		return false;
	}
}
function checkdata(){
	//alert(chaValue());
	if(chaValue()){
		form1.submit();
		return true;
	}
}

function getRent(){
	document.form1.rent.value=forcepos(document.form1.corpus.value*1+document.form1.interest.value*1,2)
}

</script>