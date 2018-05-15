<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="gcns" scope="page" class="com.service.GeneContractNetFlowService" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	String sqlstr;
	ResultSet rs;
	String dqczy = (String) session.getAttribute("czyid");
	String czid = getStr(request.getParameter("czid") );
	String curr_date = getSystemDate(0);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	
	String stype = getStr(request.getParameter("savetype") );
	String itemselect = getStr(request.getParameter("key_id") );//自增长ID
	
	String	contract_id = getStr(request.getParameter("contract_id") );
	//String	proj_id = getStr(request.getParameter("proj_id") );
	//String	doc_id = getStr(request.getParameter("doc_id") );
	
	String	rent_list = getStr( request.getParameter("rent_list") );//期项
	String	plan_date = getStr( request.getParameter("plan_date") );//偿还日期
	String	rent = getZeroStr(getStr( request.getParameter("rent") ));//租金
	String	corpus = getZeroStr(getStr( request.getParameter("corpus") ));//本金
	String	interest = getZeroStr(getStr( request.getParameter("interest") ));//利息
	String	plan_status = getStr( request.getParameter("plan_status") );//回笼状态
	String	id = getStr( request.getParameter("key_id") );//表的主键id
	
	//
	if(stype.equals("mod") || stype.equals("add")){
		//System.out.println("请确保租金=本金+利息"+(rnddouble(Double.parseDouble(corpus)+Double.parseDouble(interest),2)));
		if(rnddouble(Double.parseDouble(rent),2)!=(rnddouble(Double.parseDouble(corpus)+Double.parseDouble(interest),2))){
%>
			<script>
				window.close();
				opener.alert("操作失败：请确保租金=本金+利息!");
				opener.location.reload();
			</script>
<%
			db.close();
			return;
		}
	}
	
	int flag = 0;
	String repeat_flag = "0";
	String message = "";
	
	
	//###################################################################################################
	//											合同偿还计划手工调整
	//###################################################################################################
		if(!stype.equals("del")){
			//‘添加/修改’之前需要进行判断该租金加上表里的租金是否是小于等于‘租赁本金’
			String query_sql_projCT = " select * from  contract_condition where contract_id = '"+contract_id+"' ";
			rs = db.executeQuery(query_sql_projCT);
			String lease_money = "";//交易结构中对应的租赁本金
			String year_rate = "";//交易结构中对应的年利率
			String now_plan_date = "";//表中最大一条偿还计划数据对应的偿还日期
			while(rs.next()){
				lease_money = getDBStr(rs.getString("lease_money"));
				year_rate = getDBStr(rs.getString("year_rate"));
			}
			//System.out.println("join1偿还计划##################################$%$%$%$%$%$%");
			StringBuffer query_sql_projRent = new StringBuffer();
			query_sql_projRent.append("  select rent_list,plan_date from fund_rent_plan ")
			                  .append("  where contract_id = '"+contract_id+"' ") 
			                  .append("  and rent_list = ( ") 
			                  .append("  select max(rent_list) as  rent_list from  ") 
			                  .append("  fund_rent_plan_proj_temp  ") 
			                  .append("  where contract_id = '"+contract_id+"' ")
			                  .append("  )"); 
			
			String now_rent_list = "";//最大期项
			rs = db.executeQuery(query_sql_projRent.toString());
			while(rs.next()){
				now_rent_list = getDBStr(rs.getString("rent_list"));
				now_plan_date = getDBDateStr(rs.getString("plan_date"));//表中最大一条偿还计划数据对应的偿还日期
			}
			String now_corpus = "";//偿还计划表中对应主键的所有本金之和 用于和填写的本金相加同 租赁本金比较 
			
			//注意:查询本金总和的时候要排除掉当前这期的本金 当前这期本金是以输入的本金为准而不是数据库中原本的这期本金为准
			String query_sumRent = " select sum(corpus) as  corpus from fund_rent_plan where  contract_id = '"+contract_id+"' ";
			query_sumRent = query_sumRent + " and rent_list <> '"+rent_list+"' ";
			rs = db.executeQuery(query_sumRent);
			System.out.println("query_sumRent==合同偿还之所有本金总和（不包括修改期本金）SQL----->"+query_sumRent);
			while(rs.next()){
				now_corpus = getZeroStr(getDBStr(rs.getString("corpus")));
			}
			
			
			//System.out.println("join2合同偿还计划##################################$%$%$%$%$%$%rent_list"+rent_list);
			if(!rent_list.equals("1")){
				//判断修改或添加的偿还日期不能小于 ‘已经回笼’的租金的偿还日期
				StringBuffer query_hl_date = new StringBuffer();//查询回笼状态不为‘未回笼’的最大回笼日期
				query_hl_date.append("  select rent_list,plan_date from fund_rent_plan ")
			                  .append("  where contract_id = '"+contract_id+"' ") 
			                  .append("  and rent_list = ( ") 
			                  .append("  select max(rent_list) as  rent_list from  ") 
			                  .append("  fund_rent_plan  ") 
			                  .append("  where contract_id = '"+contract_id+"' ")
			                  .append("  and plan_status <> '未回笼'")//不等于未回笼的最大日期和期项
			                  .append("  )"); 
				rs = db.executeQuery(query_hl_date.toString());
				//System.out.println("joinquery_hl_date##################################$%$%$%$%$%$%query_hl_date==>"+query_hl_date);
				String yhl_date = "";//以回笼的最大期项和日期
				while(rs.next()){
					yhl_date = getDBDateStr(rs.getString("plan_date"));
				}
				int yhl_date_num = compare_date(yhl_date,plan_date);
				if(yhl_date_num > 0){//以回笼的偿还日期 大于 修改或者添加的数据对应的偿还日期
			%>
					<script>
						window.close();
						opener.alert("操作失败：偿还日期小于偿还计划中最大的已回笼数据的偿还日期!");
						opener.location.reload();
					</script>
			<% 			
					rs.close();
					db.close();
					return;
				}
				
				//修改时不需要判断是否日期一定要大于租金列表中最后一条租金的偿还日期
				if(!stype.equals("mod")){
					//添加之前要判断输入的日期是否是小于该期项的上一期日期，如果是第一期则不能小于服务器当前日期
					int num = compare_date(now_plan_date,plan_date);
					//System.out.println("now_plan_date的值为=======>"+now_plan_date);
					//System.out.println("plan_date的值为=======>"+plan_date);
					//System.out.println("num的值为=======>"+num);
						if(num > 0){//日期1大于日期二
				%>
							<script>
								window.close();
								opener.alert("操作失败：偿还日期小于偿还计划中最大的偿还日期!");
								opener.location.reload();
							</script>
				<% 			
								rs.close();
								db.close();
								return;
						}
				}
				
			//如果偿还期项为第一期 输入的日期不能小于服务器当前日期	
			}else{
				//System.out.println("join3偿还计划##################################$%$%$%$%$%$%");
				int i = compare_date(nowDateTime,plan_date);//服务器当前日期是第一个
				if(i > 0){
	%>
					<script>
						window.close();
						opener.alert("操作失败：偿还日期小于当前日期!");
						opener.location.reload();
					</script>
	<% 		
						rs.close();
						db.close();
						return;	
				}	
			}
			
			//--------------------------判断所有本金相加不能大于租赁本金		
			Double now_sumRent = 0.00;	
			//除去本期在数据库中的本金的所有合 + 页面输入的本期的本金
			now_sumRent = Double.valueOf(now_corpus) + Double.valueOf(corpus);
			
			Double now_lease_money = Double.valueOf(lease_money);//租赁本金
			if(now_sumRent > now_lease_money){
	%>
			<script>
				window.close();
				opener.alert("操作失败：添加的偿还计划本金金总和大于租赁本金，不合法!");
				opener.location.reload();
			</script>
	<%
				rs.close();
				db.close();
				return;
			}
		
		
		//-----------------添加判断重复--------------
	    if ( stype.equals("add") ){
	    //System.out.println("join4偿还计划##################################$%$%$%$%$%$%");
			String query_sql_projRents = " select * from  fund_rent_plan  where contract_id = '"+contract_id+"'  ";
			//判断需要‘添加‘这一期是否存在数据
			query_sql_projRents = query_sql_projRents + " and rent_list ='"+rent_list+"' ";
			rs = db.executeQuery(query_sql_projRents);
			if(rs.next()){
				repeat_flag = "1";
			}
			rs.close();
			//数据不重复才能添加
			if(!repeat_flag.equals("1")){
				//拼装添加语句
				sqlstr = "";
				sqlstr = "insert into fund_rent_plan "+
			       "(contract_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,year_rate) "+
			       "select '"+contract_id+"',"+rent_list+","+
			       "'"+plan_date+"','未回笼',"+rent+","+
			       ""+corpus+","+interest+","+year_rate+" ";
			    flag = db.executeUpdate(sqlstr);
			    System.out.println("偿还计划添加sqlst==> : r"+sqlstr);
			    message = "偿还计划添加";
			}
		}
		else if(stype.equals("mod")){
			//拼装修改语句
			StringBuffer sql = new StringBuffer();
			sql.append( " update fund_rent_plan ")
			   .append("  set plan_date = '"+plan_date+"'")//偿还日期
			   .append("  ,rent = '"+rent+"'")//租金
			   .append("  ,corpus = '"+corpus+"'")//本金
			   .append("  ,interest = '"+interest+"'")//利息
			   .append("  where  contract_id = '"+contract_id+"' ")
			   .append("  and rent_list ='"+rent_list+"' ");
			flag = db.executeUpdate(sql.toString());
			System.out.println("偿还计划修改sql==> : r"+sql.toString());
		    message = "偿还计划修改";
		    //sql = new StringBuffer();//清空
		}
	}//不为删除的操作才进入判断
	else{//删除操作
			String del_sql = " delete from  fund_rent_plan where  contract_id = '"+contract_id+"' and rent_list ='"+rent_list+"'";
			del_sql = del_sql + "   and id = "+itemselect+" ";//主键
			System.out.println("偿还计划删除sql==> : "+del_sql);
			flag = db.executeUpdate(del_sql);
		    message = "偿还计划删除";
		}
%>

<%
	if(repeat_flag.equals("1")){
%>
		<script>
			window.close();
			opener.alert("数据重复!");
			opener.location.reload();
		</script>
<%
		db.close();
		return;
	}

	if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}db.close();%>