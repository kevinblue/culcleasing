<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@page import="com.condition.Tx_Init"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
	//调息回滚操作
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	String sql = "";
	int flag = 0;
	ResultSet rs = null;
	ResultSet rsStage = null;
	String sql_where = getStr(request.getParameter("sql_where"));
	String contract_id = getStr(request.getParameter("contract_id"));
	String custId = getStr(request.getParameter("custId"));
	String adjust_flag = getStr(request.getParameter("adjust_flag"));
	System.out.println("adjust_flag=====>"+adjust_flag);
	request.setAttribute("adjust_flag",adjust_flag);
	//先删除fund_rent_plan表的数据（根据合同号），
	//再将从his表根据" and mod_reason = '调息'  and status = '前' and measure_id = '"+custId+"'  and  contract_id = ''"+contract_id+"'  ";
	//抓取相应的租金计划数据，添加到fund_rent_plan表中

	//第一步：根据合同号删除fund_rent_plan表的数据
	sql = " delete from fund_rent_plan where contract_id = '"+ contract_id + "' ";
	flag = db.executeUpdate(sql);
	System.out.println("in_sql回滚前删除flag--->"+flag);
	System.out.println("in_sql回滚前删除--->"+sql);
	//第二步：租金回滚操作，从fund_rent_plan_his
	StringBuffer in_sql = new StringBuffer(); 
	if(flag > 0){
		in_sql.append(" insert into fund_rent_plan (contract_id,rent_list,plan_date, ")
			  .append(" rent,corpus,corpus_overage,interest, ")
			  .append(" corpus_market,corpus_overage_market,interest_market ")
			  .append(" ,year_rate,creator,create_date,plan_status")
			  .append("  ) select contract_id,rent_list,plan_date, ")
			  .append(" rent,corpus,corpus_overage,interest, ")
			  .append("  corpus_market,corpus_overage_market,interest_market ")
			  .append(" ,year_rate,'"+czyid+"','"+datestr+"',plan_status ")
			  .append("  from fund_rent_plan_his ")
			  .append(" where measure_id = '"+custId+"' "+sql_where)
		      .append("  ");
		flag = db.executeUpdate(in_sql.toString());
		System.out.println("in_sql回滚--->"+in_sql);
	}
	String isHG = "";
	if(flag > 0){
		isHG = "是";
	}else{
		isHG = "否";
	}
	//现金流：从his 到 正式fund_contract_plan,und_contract_plan_mark 取状态为‘前’
	Tx_Init tx_Init = new Tx_Init();
	tx_Init.insert_ZS_Table(contract_id,custId);
	//2011-01-06增加需求
	//回滚操作完后，根据合同号，adjust_id更新fund_adjust_interest_contract的 isHG,hgCreateDate(取getdate()),hgCreator(当前登陆人的id)
	sql = " update  fund_adjust_interest_contract set isHG = '"+isHG+"' ,hgCreateDate = '"+datestr+"',hgCreator = '"+czyid+"' ";
	sql = sql + " where  adjust_id = '"+custId+"'";
	sql = sql + " and  contract_id = '"+contract_id+"'";
	flag = db.executeUpdate(sql);
	System.out.println("修改回滚状态--->"+sql);
	
	//***********************************************************************
	//todo:回滚时同时进行重新从his表中取现金流的净流量计算2个irr更新交易结构 2011-01-12需求更改 
	tx_Init.js_irr(contract_id);
	//
	
	
	db.close();

	if(flag > 0){//修改添加成功
%>
		        <script>
					alert("调息回滚操作成功!");
					opener.location.reload();
					window.close();
				</script>
<%
				
		}else{
%>
	        <script>
				alert("调息回滚操作失败!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
%>