<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );
String curr_date = getSystemDate(0);
String startDate = "";
String xmidstr = getStr( request.getParameter("xmidstr") );

String sqlstr = "";
ResultSet rs = null;
ResultSet rs1 = null;
//-----------------判断重复--------------
String proj_arr[];
String proj_id;
proj_arr=xmidstr.split(",");

for(int i=0;i<proj_arr.length;i++){
	proj_id=proj_arr[i];
	if(stype.equals("process")){
		String status="";
		sqlstr = "select id from fund_rent_plan where plan_status=0 and plan_date<getdate() and proj_id='"+proj_id+"'";
		rs = db.executeQuery(sqlstr);
		status=rs.next()?"逾期":"正常";
		rs.close();
		//插入proj_change_tx
		sqlstr="insert into proj_change_tx(proj_id,left_rent,left_interest,left_corpus,un_receive_amount,";
		sqlstr+=" fund_status,adjust_date,adjust_id) ";
		sqlstr+=" select proj_id,left_rent,left_interest, ";
		sqlstr+=" left_corpus,un_received_amount,'"+status+"','"+curr_date+"','"+czid+"' from dbo.v_leftrent_info";
		sqlstr+=" where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
	    //准备做调息处理
		int lease_term=0;//总期次
		int lease_last=0;//最后一期没调息的期次
		double total_amt_old=0.00;//
		double total_corpus=0.00;//调息前已偿还本金
		double lease_money=0.00;//融资总额
		double year_rate=0.00;
		double rate=0.00;//调息后利率
		double rate_x=0.00;//复利现值系数
		double rate_x_all=0.00;//L61的值
		double rate_x_total=0.00;//M61的值
		double corpus_left=0.00;//调息后剩余总本金   等同于H63
		double rent_new=0.00;//调息后新的租金
		double interest_new=0.00;//调整后的每期利息
		double corpus_new=0.00;//调整后的每期本金
		double l_rent_overage_all=0.00;//调整后剩余租金
		// 旧的租金计划表里的数据
		String plan_date = "";//计划日期
		String item_method = "";//还款方式
		String rent_adjust = "0.00";//调整租金
		String rent_list="0";
		String rent="0.00";
		String corpus="0.00";
		String interest="0.00";
		String rent_overage="0.00";
		String corpus_overage="0.00";
		
		
		List l_plan_date = new ArrayList();//租金计划日期
		List l_item_method = new ArrayList();//还款方式
		List l_rent_adjust = new ArrayList();//调整租金额
		List l_rent_new = new ArrayList();//新租金
		List l_interest_new = new ArrayList();//新利息
		List l_corpus_new = new ArrayList();//新本金
		List l_corpus_overage = new ArrayList();//剩余本金
		List l_rent_overage = new ArrayList();//剩余租金
		List l_rent_list = new ArrayList();//
		//------------调整后租金计划表中各个值-----------
		
		
		
		//1.调整前偿还计划插入调息历史
		sqlstr="insert into fund_rent_adjust_interest_his(proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty,penalty_overage,rent_type,rent_adjust,modify_reason,adjust_id,adjust_flag)";
		sqlstr+="select proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty,penalty_overage,rent_type,rent_adjust,'调息','"+czid+"','前' from fund_rent_plan";
		sqlstr+=" where proj_id='"+proj_id+"'";
		System.out.println("调整前偿还计划插入调息历史"+sqlstr);
		db.executeUpdate(sqlstr);
		//2.开始调息处理
			//a.删除不符合条件的租金计划（不规则付款单独作为记录）
			sqlstr="select * from proj_condition where proj_id='"+proj_id+"'";
			System.out.println("调整前proj_condition==="+sqlstr);	
			rs1=db.executeQuery(sqlstr);
			if (rs1.next()){
			 lease_term=rs1.getInt("lease_term");
			 lease_money=rs1.getDouble("lease_money");
			 total_amt_old=rs1.getDouble("total_amt");
			 year_rate = rs1.getDouble("year_rate");
			} 
			rs1.close();
			sqlstr="select base_adjust_rate+rate_limit rate,start_date from base_adjust_interest where id='"+czid+"' ";
			System.out.println("利率查询");
			rs1=db.executeQuery(sqlstr);
			if(rs1.next()){
				rate=rs1.getDouble("rate");
				startDate = rs1.getString("start_date");
			}
			rs1.close();
			sqlstr="select rent,corpus,interest,rent_overage,corpus_overage,rent_list,plan_date,item_method,isnull(rent_adjust,0) rent_adjust from fund_rent_plan where proj_id='"+proj_id+"' order by rent_list";
			System.out.println("租金计划表查询");
			rs1=db.executeQuery(sqlstr);
			while(rs1.next()){
			
				plan_date=getDBDateStr(rs1.getString("plan_date"));
				item_method=getDBStr(rs1.getString("item_method"));
				rent_adjust=getDBStr(rs1.getString("rent_adjust"));
				rent = getDBStr(rs1.getString("rent"));
				interest = getDBStr(rs1.getString("interest"));
				corpus = getDBStr(rs1.getString("corpus"));
				rent_overage = getDBStr(rs1.getString("rent_overage"));
				corpus_overage = getDBStr(rs1.getString("corpus_overage"));
				rent_list = getDBStr(rs1.getString("rent_list"));
				l_plan_date.add(plan_date);
				l_item_method.add(item_method);
				l_rent_adjust.add(rent_adjust);
				l_rent_new.add(rent);
				l_corpus_new.add(corpus);
				l_interest_new.add(interest);
				l_rent_overage.add(rent_overage);
				l_corpus_overage.add(corpus_overage);
				l_rent_list.add(rent_list);
			   
			}	
			rs1.close();
			System.out.println("删除需要调整的期次以下的租金");
			//删除需要调整的期次以下的租金		
			sqlstr="delete from fund_rent_plan where proj_id='"+proj_id+"' and plan_date>'"+startDate+"' and plan_status='0' ";
			db.executeUpdate(sqlstr);
			sqlstr="select max(rent_list) rent_list,sum(corpus) total_corpus from fund_rent_plan where proj_id='"+proj_id+"'";
			rs1=db.executeQuery(sqlstr);
			if(rs1.next()){
			lease_last=rs1.getInt("rent_list");
			total_corpus=rs1.getDouble("total_corpus");
			}
			for(int j=0;j<lease_term;j++){
				//
				if(j<lease_last){
					System.out.println("不进行计算");
				}else{
				rate_x=1/Math.pow(1+rate/1200,j+1-lease_last);//复利现值系数
			    java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00000000");//小数点后8位
						 
		 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
			 BigDecimal bd=new BigDecimal(rate_x);
		     rate_x=Double.parseDouble(ft.format(bd));
				System.out.println("复利现值系数="+rate_x);	
					if(Double.parseDouble(l_rent_adjust.get(j).toString())<=0){
					//G13:G60*M13:M60=L61
					//N13:N60*M13:M60
						rate_x_total += rate_x;//M61的值
						System.out.println("M61的值===="+rate_x_total);
					}else{
					//N13:N60*M13:M60
					//G13:G60*M13:M60=L61
						rate_x_all += Double.parseDouble(l_rent_adjust.get(j).toString())*rate_x;//L61
						System.out.println("L61的值===="+rate_x_all);
					System.out.println("有进行不规则付款的值");
					}
				}
				
			}
			corpus_left=lease_money-total_corpus;//调息后剩余本金   等同于H63
			System.out.println("H61的值===="+corpus_left);
			//M62=L62/M61
			//	 =(H63-L61)/M61
			rent_new=Double.parseDouble(formatNumberDoubleZero((corpus_left-rate_x_all)/rate_x_total));//新的租金值
			System.out.println("新的租金值===="+rent_new);
			//进行插入租金计划表
			for(int j=0;j<lease_term;j++){
				if(j<lease_last){
					System.out.println("不进行插入计算");
				
				}else{
					if(Double.parseDouble(l_rent_adjust.get(j).toString())>0){
					//进行过不规则还款的期项
					l_rent_new.set(j,l_rent_adjust.get(j));
					l_rent_overage_all += Double.parseDouble(l_rent_new.get(j).toString());//循还计算剩余租金
					
					}else{
					l_rent_new.set(j,Double.valueOf(rent_new));
					l_rent_overage_all += Double.parseDouble(l_rent_new.get(j).toString());//循还计算剩余租金
					
					}
					//System.out.println("j="+j+"剩余本金="+l_rent_overage.get(j-1));
					
					if(j==lease_term-1){
					//最后一期的情况单独处理
					l_corpus_new.set(j,l_corpus_overage.get(j-1));//最后一期本金
					l_interest_new.set(j,formatNumberDoubleTwo(Double.parseDouble(l_rent_new.get(j).toString())-Double.parseDouble(l_corpus_new.get(j).toString())));
					l_corpus_overage.set(j,formatNumberDoubleTwo(Double.parseDouble(l_corpus_overage.get(j-1).toString())-Double.parseDouble(l_corpus_new.get(j).toString())));//剩余本金=上一期未偿还本金-本期本金
				//	l_rent_overage.set(j,formatNumberDoubleTwo(Double.parseDouble(l_rent_overage.get(j-1).toString())-Double.parseDouble(l_rent_new.get(j).toString())));
					}else{
					l_interest_new.set(j,formatNumberDoubleTwo(Double.parseDouble(l_corpus_overage.get(j-1).toString())*rate/1200));//本期利息
					l_corpus_new.set(j,formatNumberDoubleTwo(Double.parseDouble(l_rent_new.get(j).toString())-Double.parseDouble(l_interest_new.get(j).toString())));//本期本金=本期租金-利息
					l_corpus_overage.set(j,formatNumberDoubleTwo(Double.parseDouble(l_corpus_overage.get(j-1).toString())-Double.parseDouble(l_corpus_new.get(j).toString())));//剩余本金=上一期未偿还本金-本期本金
				//	l_rent_overage.set(j,formatNumberDoubleTwo(Double.parseDouble(l_rent_overage.get(j-1).toString())-Double.parseDouble(l_rent_new.get(j).toString())));
					}
					
					
					
				}
			}	
				//更新剩余租金
				for(int j=0;j<lease_term;j++){
				if(j<lease_last){
						System.out.println("不进行插入计算");
					if(j==lease_last-1)
						l_rent_overage.set(j,Double.valueOf(l_rent_overage_all));
					}else{
					l_rent_overage.set(j,formatNumberDoubleTwo(Double.parseDouble(l_rent_overage.get(j-1).toString())-Double.parseDouble(l_rent_new.get(j).toString())));				
					sqlstr="insert into fund_rent_plan(proj_id,rent_list,plan_status,plan_date,rent,corpus,interest,rent_adjust,rent_overage,corpus_overage,year_rate,item_method) ";
					sqlstr+="values('"+proj_id+"','"+l_rent_list.get(j)+"',0,'"+l_plan_date.get(j)+"','"+l_rent_new.get(j)+"','"+l_corpus_new.get(j)+"','"+l_interest_new.get(j)+"',+'"+l_rent_adjust.get(j)+"',";
					sqlstr+="'"+l_rent_overage.get(j)+"','"+l_corpus_overage.get(j)+"','"+rate+"','"+l_item_method.get(j)+"')";	
					//System.out.println("插入租金计划表SQL=="+sqlstr);
					db.executeUpdate(sqlstr);
				
				
			 		}
				
				
				}
			//b.计算新的租金计划
			
			
			//c.插入租金计划表（不规则付款单独处理（））
		
		//3.调整交易结构
			sqlstr="update proj_condition set year_rate='"+rate+"',total_amt=(select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt ";
			sqlstr+="where proj_id='"+proj_id+"'";
			//System.out.println("调整交易结构SQL=="+sqlstr);
		    db.executeUpdate(sqlstr);
		//3.调整交易结构临时表
			sqlstr="update proj_condition_temp set year_rate='"+rate+"',total_amt=(select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt ";
			sqlstr+="where proj_id='"+proj_id+"'";
			//System.out.println("调整交易结构SQL=="+sqlstr);
		    db.executeUpdate(sqlstr);
		//4.修改调息项目表
			sqlstr="update adjust_interest_proj set adjust_flag='是',adjust_amt=((select total_amt from proj_condition where proj_id='"+proj_id+"')-'"+total_amt_old+"'),before_rate='"+year_rate+"',after_rate='"+rate+"',rent_list_start=('"+lease_last+"'+1)";
		    sqlstr+="where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
		   // System.out.println("修改调息项目表SQL=="+sqlstr);
		    db.executeUpdate(sqlstr);
		//5.调整后偿还计划插入调息历史
		//sqlstr="exec tx '"+czid+"','"+proj_id+"'";
		
			sqlstr="insert into fund_rent_adjust_interest_his(proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty,penalty_overage,rent_type,rent_adjust,modify_reason,adjust_id,adjust_flag)";
		    sqlstr+="select proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty,penalty_overage,rent_type,rent_adjust,'调息','"+czid+"','后' from fund_rent_plan";
		    sqlstr+=" where proj_id='"+proj_id+"'";
		   //  System.out.println("调整后偿还计划插入调息历史SQL=="+sqlstr);
		    db.executeUpdate(sqlstr);
		
		
		
		//更新
		sqlstr = "update proj_change_tx set adjust_interest=";
		sqlstr += "(select adjust_amt from adjust_interest_proj where proj_id='"+proj_id+"' and adjust_id='"+czid+"')";
		sqlstr += "	where proj_id='"+proj_id+"' and adjust_id='"+czid+"'";
		//System.out.println("调整后更新SQL=="+sqlstr);
		db.executeUpdate(sqlstr);	
	}else if(stype.equals("del")){
		//调息前历史记录覆盖调息后偿还计划表
		sqlstr="delete from fund_rent_plan where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="insert into fund_rent_plan(proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,rent_adjust) select proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,rent_adjust from fund_rent_adjust_interest_his where adjust_id='"+czid+"' and proj_id='"+proj_id+"' and modify_reason='调息' and adjust_flag='前'";
		db.executeUpdate(sqlstr);
		//撤销处理
		sqlstr="delete from fund_rent_adjust_interest_his where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
		//sqlstr="update adjust_interest_proj set adjust_flag='否',adjsut_amt=0,before_rate=0,after_rate=0 where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
		sqlstr="delete from adjust_interest_proj where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
        sqlstr="delete from proj_change_tx where proj_id='"+proj_id+"' and adjust_id='"+czid+"'";
		db.executeUpdate(sqlstr);
		//调整交易机构中租金总额
		//sqlstr="update proj_condition set total_amt=((select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt) where proj_id='"+proj_id+"'";
		//db.executeUpdate(sqlstr);
		//调整交易结构中租金总额
		sqlstr="update proj_condition set year_rate=(select top 1 year_rate from fund_rent_plan where where proj_id='"+proj_id+"' order by year_rate desc),";
		sqlstr+=" total_amt=((select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt) where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
		//调整交易结构临时表中租金总额
		sqlstr="update proj_condition set year_rate=(select top 1 year_rate from fund_rent_plan where where proj_id='"+proj_id+"' order by year_rate desc),";
		sqlstr+=" total_amt=((select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt) where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
	}
}
db.close();
%>
<script>
	window.close();
	opener.alert("成功!");
	opener.parent.location.reload();
</script>
		