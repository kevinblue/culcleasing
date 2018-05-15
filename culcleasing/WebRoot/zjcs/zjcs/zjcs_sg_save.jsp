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
	String temp = getStr(request.getParameter("temp") );//判断是否是项目还是合同
	String	contract_id = getStr(request.getParameter("contract_id") );
	String	proj_id = getStr(request.getParameter("proj_id") );
	String	doc_id = getStr(request.getParameter("doc_id") );
	
	
	String	rent_list = getStr( request.getParameter("rent_list") );//期项
	String	plan_date = nowDateTime;//getStr( request.getParameter("plan_date") );//偿还日期
	String	rent = getZeroStr(getStr( request.getParameter("rent") ));//租金
	String	corpus = getZeroStr(getStr( request.getParameter("corpus_market") ));//市场本金  //新输入的本金值
	String	interest = getZeroStr(getStr( request.getParameter("interest_market") ));//市场利息
	String	corpus_overage_market = getZeroStr(getStr( request.getParameter("corpus_overage_market") ));//市场本金余额
	String	plan_status = getStr( request.getParameter("plan_status") );//回笼状态
	String	id = getStr( request.getParameter("key_id") );//表的主键id
	String	join_ybcorpus = getZeroStr(getStr( request.getParameter("join_ybcorpus")));//【2011-03-16 新增取值字段 进入修改页面时候得到的本金】
	//原本－现本＝差值 每期本金余额＝原每期本金余额＋差值
	String ce_money = formatNumberDoubleSix(Double.valueOf(join_ybcorpus) - Double.valueOf(corpus));
	System.out.println("ce_money--->"+ce_money);
	//封装参数
	//List<String> args = new ArrayList<String>();
	//args.add(stype);//0
	//args.add(temp);//1
	//args.add(contract_id);//2
	//args.add(proj_id);//3
	//args.add(doc_id);//4
	//args.add(rent_list);//5
	//args.add(plan_date);//6
	//args.add(rent);//7
	//args.add(corpus);//8
	//args.add(interest);//9
	//args.add(plan_status);//10
	
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
	//											项目偿还计划手工调整
	//###################################################################################################
	if(temp.equals("proj_zjcs")){
	if(!stype.equals("del")){
		//‘添加/修改’之前需要进行判断该租金加上表里的租金是否是小于等于‘租赁本金’
		String query_sql_projCT = " select * from  proj_condition_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"'";
		System.out.println("查询交易结构中的租赁本金用于和下方的本金值和做比较-->"+query_sql_projCT);
		rs = db.executeQuery(query_sql_projCT);
		String lease_money = "";//交易结构中对应的租赁本金
		String year_rate = "";//交易结构中对应的年利率
		String now_plan_date = "";//表中最大一条偿还计划数据对应的偿还日期
		while(rs.next()){
			lease_money = getDBStr(rs.getString("lease_money"));
			year_rate = getDBStr(rs.getString("year_rate"));
		}
		System.out.println("join1偿还计划##################################$%$%$%$%$%$%");
		StringBuffer query_sql_projRent = new StringBuffer();
		query_sql_projRent.append("  select rent_list,plan_date from fund_rent_plan_proj_temp ")
		                  .append("  where proj_id = '"+proj_id+"' ") 
		                  .append("  and rent_list = ( ") 
		                  .append("  select max(rent_list) as  rent_list from  ") 
		                  .append("  fund_rent_plan_proj_temp  ") 
		                  .append("  where proj_id = '"+proj_id+"' ")
		                  .append("  and measure_id = '"+doc_id+"' ") 
		                  .append("  )")
		                  .append(" and measure_id = '"+doc_id+"'"); 
		
		String now_rent_list = "";//最大期项
		rs = db.executeQuery(query_sql_projRent.toString());
		while(rs.next()){
			now_rent_list = getDBStr(rs.getString("rent_list"));
			now_plan_date = getDBDateStr(rs.getString("plan_date"));//表中最大一条偿还计划数据对应的偿还日期
		}
		
		
		String now_corpus = "";//偿还计划表中对应主键的所有本金之和 用于和填写的本金相加同 租赁本金比较 
		String query_sumRent = " select sum(corpus) as  corpus from fund_rent_plan_proj_temp where  proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
		//注意:查询本金总和的时候要排除掉当前这期的本金 当前这期本金是以输入的本金为准而不是数据库中原本的这期本金为准
		query_sumRent = query_sumRent + " and rent_list <> '"+rent_list+"' ";
		System.out.println(":查询本金总和的时候要排除掉当前这期的本金--->"+query_sumRent);
		rs = db.executeQuery(query_sumRent);
		while(rs.next()){
			now_corpus = getZeroStr(getDBStr(rs.getString("corpus")));
		}
		
		System.out.println("join2偿还计划##################################$%$%$%$%$%$%");
		if(!rent_list.equals("1") && !stype.equals("mod")){//修改不需要进行日期大雨几多期的判断
		//添加之前要判断输入的日期是否是小于该期项的上一期日期，如果是第一期则不能小于服务器当前日期
		int num = compare_date(now_plan_date,plan_date);
		System.out.println("now_plan_date的值为=======>"+now_plan_date);
		System.out.println("plan_date的值为=======>"+plan_date);
		System.out.println("num的值为=======>"+num);
		
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
		}else{//如果偿还期项为第一期 输入的日期不能小于服务器当前日期
		System.out.println("join3偿还计划##################################$%$%$%$%$%$%");
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
		Double now_sumRent = 0.00;	
		//除去本期在数据库中的本金的所有总合 + 页面输入的本期的本金
		now_sumRent = Double.valueOf(now_corpus) + Double.valueOf(corpus);
		System.out.println("now_corpus--->"+now_corpus);
		System.out.println("corpus--->"+corpus);
		System.out.println("now_sumRent--->"+now_sumRent);
		Double now_lease_money = Double.valueOf(lease_money);
		System.out.println("now_lease_money--->"+now_lease_money);
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
	    System.out.println("join4偿还计划##################################$%$%$%$%$%$%");
			String query_sql_projRents = " select * from  fund_rent_plan_proj_temp  where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
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
				sqlstr = "insert into fund_rent_plan_proj_temp"+
			       "(measure_id,proj_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus_market,"+
			       "interest_market,year_rate,corpus_overage_market) "+
			       "select '"+doc_id+"','"+proj_id+"',"+rent_list+","+
			       "'"+plan_date+"','未回笼',"+rent+","+
			       ""+corpus+","+interest+","+year_rate+","+corpus_overage_market+" ";
			    flag = db.executeUpdate(sqlstr);
			    System.out.println("偿还计划添加sqlst==> : r"+sqlstr);
			    message = "偿还计划添加";
			}
		}
		else if(stype.equals("mod")){
			//拼装修改语句
			StringBuffer sql = new StringBuffer();
			sql.append( " update fund_rent_plan_proj_temp  ")
			   .append("  set plan_date = '"+plan_date+"'")//偿还日期
			   .append("  ,rent = '"+rent+"'")//租金
			   .append("  ,corpus_market = '"+corpus+"'")//本金
			   .append("  ,interest_market = '"+interest+"'")//利息
			   .append("  ,corpus_overage_market = '"+corpus_overage_market+"'")//剩余本金
			   .append("  where  proj_id = '"+proj_id+"' ")
			   .append("  and measure_id = '"+doc_id+"' ")
			   .append("  and rent_list ='"+rent_list+"' and id = "+id+" ");
			flag = db.executeUpdate(sql.toString());
			System.out.println("偿还计划修改sql==> : r"+sql.toString());
			//。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
			//【2011-03-16 新增需求 修改本期本金利息剩余本金后 需要修改余下所有期的剩余本金，具体修改规则是：每期本金余额＝原每期本金余额＋差值ce_money】
			String query_corpus_overage_market = " select isnull(corpus_overage_market,0) as corpus_overage_market,id from  fund_rent_plan_proj_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' and rent_list > '"+rent_list+"'  order by rent_list ";
			System.out.println("查询从大于第几期开始进行不规则测算的所有剩余本金和主键--》"+query_corpus_overage_market);
			ResultSet rs_com = db.executeQuery(query_corpus_overage_market);
			String corpus_overage_market_t = "";
			String com_id = "";//主键
			StringBuffer up_comSql = new StringBuffer(); 
			while(rs_com.next()){
				corpus_overage_market_t = getZeroStr(getStr(rs_com.getString("corpus_overage_market")));
				com_id = getZeroStr(getStr(rs_com.getString("id")));
				String sy_money = formatNumberDoubleSix(Double.valueOf(corpus_overage_market_t) + Double.valueOf(ce_money));
				up_comSql.append(" update fund_rent_plan_proj_temp ")
				         .append(" set corpus_overage_market = '"+sy_money+"' ")
				         .append(" where id = '"+com_id+"' ")
				         .append(" ; ");
			}rs_com.close();
			System.out.println("拼接修改从几期开始进行调整后的每一期的剩余本金sql--》"+up_comSql);
			flag = db.executeUpdate(up_comSql.toString()); 	
			//。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
		    message = "偿还计划修改";
		    //sql = new StringBuffer();//清空
		}
	}//不为删除的操作才进入判断
		else{//删除操作
			String del_sql = " delete from  fund_rent_plan_proj_temp where  proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
			del_sql = del_sql + "  and rent_list >= "+rent_list+" ";//
			flag = db.executeUpdate(del_sql);
			System.out.println("偿还计划删除sql==> : "+del_sql);
		    message = "偿还计划删除";
		}
	}//项目偿还计划手工调整判断结束
	
	
	
	
	//###################################################################################################
	//											合同偿还计划手工调整
	//###################################################################################################
	else if(temp.equals("contract_zjcs")){
		if(!stype.equals("del")){
			//‘添加/修改’之前需要进行判断该租金加上表里的租金是否是小于等于‘租赁本金’
			String query_sql_projCT = " select * from  contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
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
			query_sql_projRent.append("  select rent_list,plan_date from fund_rent_plan_temp ")
			                  .append("  where contract_id = '"+contract_id+"' ") 
			                  .append("  and rent_list = ( ") 
			                  .append("  select max(rent_list) as  rent_list from  ") 
			                  .append("  fund_rent_plan_temp  ") 
			                  .append("  where contract_id = '"+contract_id+"' ")
			                  .append("  and measure_id = '"+doc_id+"' ") 
			                  .append("  )")
			                  .append(" and measure_id = '"+doc_id+"'"); 
			
			String now_rent_list = "";//最大期项
			rs = db.executeQuery(query_sql_projRent.toString());
			while(rs.next()){
				now_rent_list = getDBStr(rs.getString("rent_list"));
				now_plan_date = getDBDateStr(rs.getString("plan_date"));//表中最大一条偿还计划数据对应的偿还日期
			}
			String now_corpus = "";//偿还计划表中对应主键的所有本金之和 用于和填写的本金相加同 租赁本金比较 
			String query_sumRent = " select sum(corpus) as  corpus from fund_rent_plan_temp where  contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
			//注意:查询本金总和的时候要排除掉当前这期的本金 当前这期本金是以输入的本金为准而不是数据库中原本的这期本金为准
			query_sumRent = query_sumRent + " and rent_list <> '"+rent_list+"' ";
			rs = db.executeQuery(query_sumRent);
			System.out.println("query_sumRent==合同偿还计划租金总和SQL----->"+query_sumRent);
			while(rs.next()){
				now_corpus = getZeroStr(getDBStr(rs.getString("corpus")));
			}
			
			System.out.println("join2合同偿还计划##################################$%$%$%$%$%$%");
			if(!rent_list.equals("1") && !stype.equals("mod")){
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
			}else{//如果偿还期项为第一期 输入的日期不能小于服务器当前日期
			System.out.println("join3偿还计划##################################$%$%$%$%$%$%");
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
			Double now_sumRent = 0.00;	
			//除去本期在数据库中的本金的所有总合 + 页面输入的本期的本金
			now_sumRent = Double.valueOf(now_corpus) + Double.valueOf(corpus);
			Double now_lease_money = Double.valueOf(lease_money);
			System.out.println("--------------------------------------------->");
			System.out.println("now_corpus=====------>"+now_corpus);
			System.out.println("corpus=====------>"+corpus);
			System.out.println("now_sumRent=====------>"+now_sumRent);
			System.out.println("now_lease_money=====------>"+now_lease_money);
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
	    System.out.println("join4偿还计划##################################$%$%$%$%$%$%");
			String query_sql_projRents = " select * from  fund_rent_plan_temp  where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
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
				sqlstr = "insert into fund_rent_plan_temp"+
			       "(measure_id,contract_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,year_rate) "+
			       "select '"+doc_id+"','"+contract_id+"',"+rent_list+","+
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
			sql.append( " update fund_rent_plan_temp  ")
			   .append("  set plan_date = '"+plan_date+"'")//偿还日期
			   .append("  ,rent = '"+rent+"'")//租金
			   .append("  ,corpus = '"+corpus+"'")//本金
			   .append("  ,interest = '"+interest+"'")//利息
			   .append("  ,corpus_overage_market = '"+corpus_overage_market+"'")//剩余本金
			   .append("  where  contract_id = '"+contract_id+"' ")
			   .append("  and measure_id = '"+doc_id+"' ")
			   .append("  and rent_list ='"+rent_list+"' and id = "+id+" ");
			flag = db.executeUpdate(sql.toString());
			System.out.println("合同偿还计划修改sql==> : "+sql.toString());
			//。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
			//【2011-03-16 新增需求 修改本期本金利息剩余本金后 需要修改余下所有期的剩余本金，具体修改规则是：每期本金余额＝原每期本金余额＋差值ce_money】
			String query_corpus_overage_market = " select isnull(corpus_overage_market,0) as corpus_overage_market,id from  fund_rent_plan_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' and rent_list > '"+rent_list+"'  order by rent_list ";
			System.out.println("合同查询从大于第几期开始进行不规则测算的所有剩余本金和主键--》"+query_corpus_overage_market);
			ResultSet rs_com = db.executeQuery(query_corpus_overage_market);
			String corpus_overage_market_t = "";
			String com_id = "";//主键
			StringBuffer up_comSql = new StringBuffer(); 
			while(rs_com.next()){
				corpus_overage_market_t = getZeroStr(getStr(rs_com.getString("corpus_overage_market")));
				com_id = getZeroStr(getStr(rs_com.getString("id")));
				String sy_money = formatNumberDoubleSix(Double.valueOf(corpus_overage_market_t) + Double.valueOf(ce_money));
				up_comSql.append(" update fund_rent_plan_temp ")
				         .append(" set corpus_overage_market = '"+sy_money+"' ")
				         .append(" where id = '"+com_id+"' ")
				         .append(" ; ");
			}rs_com.close();
			System.out.println("合同拼接修改从几期开始进行调整后的每一期的剩余本金sql--》"+up_comSql);
			flag = db.executeUpdate(up_comSql.toString()); 	
			//。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
		    message = "偿还计划修改";
		    //sql = new StringBuffer();//清空
		}
	}//不为删除的操作才进入判断
	else{//删除操作
			String del_sql = " delete from  fund_rent_plan_temp where  contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
			del_sql = del_sql + "  and id = "+id+" ";//主键
			flag = db.executeUpdate(del_sql);
			System.out.println("偿还计划删除sql==> : "+del_sql);
		    message = "偿还计划删除";
		}
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