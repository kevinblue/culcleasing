<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<!-- 租金变更计算页面不规则  -->
<%
	String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String sqlstr = "";
	ResultSet rs;
	String message = "";
	int flag = 0;
	
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));//
	String proj_id = getStr(request.getParameter("proj_id"));//
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金
	String year_rate = getZeroStr(getStr(request.getParameter("year_rate")));//年利率
	
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//手续费
	String caution_money = getZeroStr(getStr(request.getParameter("caution_money")) );//租赁保证金
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//设备款
	String start_date = getStr(request.getParameter("start_date"));//起租日
	String income_day = getStr(request.getParameter("income_day"));//每月偿付日
	String old_start_date = start_date;	//现金流使用
	start_date = start_date.substring(0,8)+income_day;
	
	String income_number_year = getStr(request.getParameter("income_number_year"));//付租方式
	String net_lease_money = getZeroStr(getStr(request.getParameter("net_lease_money")));//净融资额
	String period_type = getZeroStr(getStr(request.getParameter("period_type")));//期初1（期末0）支付
	String consulting_fee = getZeroStr(getStr(request.getParameter("consulting_fee")));//咨询费
	String num  = getStr(request.getParameter("count_rent_list"));//用于确定每一行input输入框的属性，也是原本有几多期的判断依据
	
	String zjbg0Value = getStr(request.getParameter("zjbg1"));//取出一个选项框的值 【从1开始拼的属性】
	//租金计算方法 等额租金|等额本金|不规则","1|2|0"
	String measure_type = getStr(request.getParameter("measure_type"));
	//现金流存入的需要
	String creator = getStr(request.getParameter("creator"));//创建人
	String create_date = getStr(request.getParameter("create_date"));//创建日期
	String modificator = getStr(request.getParameter("modificator"));//修改人
	String modify_date = getStr(request.getParameter("modify_date"));//修改日期
	System.out.println("join1==>==>  : ");
	int new_rent_list = 1;//最早一起'未回笼'的期项
	//编号为空则不做任何操作
	if(!contract_id.equals("") || !doc_id.equals("")){	
		String now_plan_date = ""; //最终的租金测算起始日期
		String now_corpus_overage = "";//最终的‘剩余本金总额’作为租金测算的条件之一
		String now_count_rent_list = "";//最终需要测算几期回笼计划 now_count_rent_list = num(总期数) - '已回笼总数'
		
	 	//取出最后一列input属性为'zjbg1'的值,如果第一期回笼计划就是未回笼的，则租金测算需要用到的剩余本金总额其实就是‘租赁本金’
		if(((zjbg0Value.equals("") || zjbg0Value == null) && !zjbg0Value.equals("已回笼"))){
			now_corpus_overage = lease_money;//‘本金余额’ == ‘租赁本金’
			now_plan_date = start_date;//‘回笼计划起始日期’ == ‘起租日’+‘每月偿付日’计算出来的值
			now_count_rent_list = num;//回笼期数 == num
			new_rent_list = 1;
		}
		//如果第一期回笼计划是‘已回笼’，则找出最早一起‘未回笼’的租金数据行 找出对应的‘剩余本金总额’以及‘新的起租日期’
		else{
		
			//‘新的起租日期’依据为：1期初取上一行数据的‘回笼日期’ 0期末取本行的‘回笼日期’
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from fund_rent_plan_temp  ")
			   .append(" where 1 = 1 ")
			   .append(" and contract_id = '"+contract_id+"' ")//项目编号 proj_id
			   .append(" and plan_status = '未回笼' ")
			   .append(" and rent_list = ( ")//最早未回笼的期数
			   					.append(" select min(rent_list) as rent_list from fund_rent_plan_temp   ")
			   					.append(" where contract_id = '"+contract_id+"'  and plan_status = '未回笼'  ")
			   	.append(" ) ")
			   	.append(" and measure_id = '"+doc_id+"' ");
			rs = db.executeQuery(sql.toString());
			
			String  now_rent_list = "";//表示最后一期‘已回笼’的期项是几多 等于：最早一起'未回笼'的期项减1
			if(rs.next()){
				new_rent_list = Integer.parseInt(getDBStr(rs.getString("rent_list")));//最早一起未回笼的期项
				now_rent_list = String.valueOf(new_rent_list - 1);//下方查询条件,用于查询‘剩余本金总额’和‘起租日’
				now_plan_date = getDBStr(rs.getString("plan_date"));//本行回笼计划的回笼日期 期末取本行
			}
			
			//查询最终的‘本金余额’以及‘回笼计划起始日期’ 用于租金测算
			String query_whlSql = " select plan_date,corpus_overage from  fund_rent_plan_temp where rent_list = '"+now_rent_list+"' ";
			query_whlSql = query_whlSql + " and contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
			rs = db.executeQuery(sql.toString());
			if(rs.next()){
				//1期初取上一行数据的‘回笼日期’ 0期末取本行的‘回笼日期’ 以及取出对应‘本金余额’
				if(period_type.equals("1")){
					now_plan_date = getDBStr(rs.getString("plan_date"));//上一行回笼计划的回笼日期
				}//如果是0期末则用上方以精确的日期为起租日期
				now_corpus_overage = getDBStr(rs.getString("corpus_overage"));//本金余额每次是取上一期回笼计划的本金余额
			}
			//最终需要测算几期回笼计划 计算方式：总期数 - 最后一期'已回笼'的期项  得出'未回笼'的租金需要测算多少期
			now_count_rent_list = String.valueOf(Integer.parseInt(num) - Integer.parseInt(now_rent_list));//
		}
			
		//封装资金流和日期的数组
		List<String> list_cash = new ArrayList<String>();
		List<String> list_date = new ArrayList<String>();
		list_cash.add(handling_charge);//手续费
		list_date.add(start_date);
		list_cash.add("-"+consulting_fee);//咨询费
		list_date.add(start_date);
		list_cash.add("-"+lease_money);//租赁本金
		list_date.add(start_date);
		
		//封装 ‘不规则’租金测算之租金列表  ‘租金’+‘调整租金’组成新的租金列表
		List<String> list_cashRent = new ArrayList<String>();	
		//循环取值  
		//System.out.println("join^^^^^^^^^^^^^new_rent_list^^^^^^^^^^^new_rent_list值为:"+new_rent_list);
		for(int i = 1;i <= Integer.parseInt(num);i++){
			String plan_date_NameValue = "plan_date"+i;//日期
			String rent_NameValue = "rent"+i;//原本租金
			String zjbg_NameValue = "zjbg"+i;//已更改租金
			//取原本租金和更改的租金 组成新的租金list 注意：只取‘未回笼’的租金组装新的租金list
			String zjbgValue = getStr(request.getParameter(zjbg_NameValue));
			
			if((zjbgValue.equals("") || zjbgValue == null)&& !zjbgValue.equals("已回笼")){
				String rentValue = getZeroStr(getStr(request.getParameter(rent_NameValue)));
				list_cashRent.add(rentValue);
			}else{
				if(zjbgValue.equals("已回笼") || zjbgValue.equals("部分回笼")){//如果等于已回笼的则取已回笼的租金和日期加入list list_cash和list_date中
					//已回笼的租金和日期需要装入另外的list中
					list_cash.add(getZeroStr(getStr(request.getParameter(rent_NameValue))));//已回笼租金
					list_date.add(getStr(request.getParameter(plan_date_NameValue)));//已回笼租金的日期
				}else{//否则加入新的租金list中
					list_cashRent.add(zjbgValue);
				}
			}
		}
		
	for(int i = 0;i < list_cashRent.size();i++){
		System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^list_cashRent值为:"+list_cashRent.get(i));
		System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^num值为:"+num);
	}	
		
		//租金测算程序
		List l_plan_date = new ArrayList();
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();
		//具体测算
		RentCalc rent = new RentCalc();
		//封装 资金流 例如 设备金额，手续费，保证金
		rent.setPreCash(list_cash);//
	    rent.setPreDate(list_date);//
		//封装租金测算的条件	
		rent.setYear_rate(year_rate); //年利率   
		rent.setFuture_money("0");//未来值 
		rent.setPeriod_type(period_type);//1,期初 0,期未的值 
		rent.setIrr_type("2");//1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		rent.setScale("8");//irr的小数位数 暂时就是8位
		rent.setLease_interval(income_number_year);//租金间隔 (付租方式)
		//以下三个参数比较特殊，详细看上方代码................
		rent.setIncome_number(now_count_rent_list);//期数  新的租金测算有多少期不包含已回笼的期数
		rent.setLease_money(now_corpus_overage);//租赁本金（这里有可能是上一期的剩余本金余额）
		rent.setPlan_date(now_plan_date);//起租日  
		
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^income_number_year:==>"+income_number_year);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^period_type:==>"+period_type);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^year_rate:==>"+year_rate);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_corpus_overage:租赁本金==>"+now_corpus_overage);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_plan_date起租日:==>"+now_plan_date);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_count_rent_list:期数==>"+now_count_rent_list);
	
	
		//‘不规则’情况下，租金具体测算如下：
		List rent_list = list_cashRent;// 得到租金list,注意不规则时的租金list (只是新的租金的LIST，不包含 手续费那些现金)
		//getPlanDateList(参数一,参数二)   参数一 上方数组，租金list 参数二 期初(1)or期末支付(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// 计划时间 
		//参数说明 getHashRentPlan(参数一,参数二,参数三) 
		//参数一代表：期初(1)or期末支付(0)，参数二代表：上方的list 封装的所有租金列表 
		//参数三 measure_type租金计算方法等额租金|等额本金|不规则","1|2|0" 上方数组 封装时间的结果集
		//******************************************************????????????????????????????????????????????????????
		//measure_type 暂时按等额租金计算
		String str_temp = measure_type;
		if(measure_type.equals("0")){
			str_temp = "1";
		}
		HashMap hm = rent.getHashRentPlan(str_temp, rent_list, l_plan_date_);
		//取值
		l_plan_date = (List)hm.get("plan_date");//租金偿还日期
		l_rent = (List)hm.get("rent");//租金
		l_corpus = (List)hm.get("corpus");//本金
		l_interest = (List)hm.get("interest");//利息
		l_corpus_overage = (List)hm.get("corpus_overage");//剩余本金
		
		//计算irr  
		Double getIrr = Double.parseDouble(rent.getV_irr())*100;
		//修改表contract_condition中的计划IRR的值
		String update_sqlstr = "update contract_condition_temp set plan_irr="+getIrr+" where contract_id='"+contract_id+"'";
		flag = db.executeUpdate(update_sqlstr);
		String  measure_id = doc_id;//文档编号
		//删除对应 ‘项目编号’和‘文档编号’在表fund_rent_plan_temp中以前的租金测算计划
		sqlstr = "";
		//删除时候注意不能删除以回笼的租金几期计划 
		sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+measure_id+"'";
		sqlstr = sqlstr + "  and rent_list >= '"+new_rent_list+"' ";
		flag = db.executeUpdate(sqlstr);
		sqlstr = "";
		//拼装新的租金测算增加语句，往表fund_rent_plan_temp中将测算后的值插入数据,成功后刷新该页面的父页
		for(int i=0;i<l_rent.size();i++){
		//文档编号(测算编号),合同编号,回笼状态,租金,本金,租息,本金余额,年利率
			sqlstr+="  insert into fund_rent_plan_temp"+
			       "(measure_id,contract_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate) "+
			       "select '"+measure_id+"','"+contract_id+"',"+(new_rent_list+i)+","+//期项接着已回笼的期项插入
			       "'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+"  ;  ";
		}
		//System.out.println("===sqlo===:==>"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		
		
		
		
		//************************************************************************************************
		//                                            现金流
		//************************************************************************************************
		//System.out.println("join1====>------->join1");
		//初始化6个数组：日期 plan_date_list,流入量 follow_in_list,流入量清单 follow_in_detail_list
		//流出量 follow_out_list,流出量清单 follow_out_detail_list,净流量 net_follow_list
		List<String> plan_date_list = new ArrayList<String>();//
		List<String> follow_in_list = new ArrayList<String>();//
		List<String> follow_in_detail_list = new ArrayList<String>();//
		List<String> follow_out_list = new ArrayList<String>();//
		List<String> follow_out_detail_list = new ArrayList<String>();//
		List<String> net_follow_list = new ArrayList<String>();//
		//判断期初期末，
		String l_money = "-"+lease_money;//租赁本金
		String l_consulting_fee = "-"+consulting_fee;//咨询费
		String l_handling_charge = handling_charge;//手续费
		Double count_money = 0.00;//净流量
		String follow_in_detailTemp = "";//流入量清单拼装
		String follow_out_detailTemp = "";//流出量清单拼装
		Double follow_out_money = 0.00;//流出量现金
		Double follow_in_money = 0.00;//流入量现金
		
		//期初：咨询费+租赁本金+手续费+第一期租金  (period_type 1,期初 0,期未的值)
		if(period_type.equals("1")){
			String first_rent = l_rent.get(0).toString();//第一期租金
			follow_in_money = Double.valueOf(l_handling_charge)+Double.valueOf(first_rent);//手续费+第一期租金 流入量
			follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//租赁本金+咨询费  流出量 
			count_money = follow_out_money+follow_in_money;//净流量
			plan_date_list.add(old_start_date);//第一个现金流对应日期，以起租日为准
			follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)).toString());//第一个现金流入量数据
			follow_in_detailTemp = "手续费:"+l_handling_charge+" 第一期租金:"+first_rent+" ";
			follow_in_detail_list.add(follow_in_detailTemp);//第一个现金流入量清单数据
			follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//第一个现金流出量
			follow_out_detailTemp = ":租赁本金"+lease_money+" 咨询费:"+consulting_fee+"";//第一个现金流出量清单
			follow_out_detail_list.add(follow_out_detailTemp);
			net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//第一个现金净流量
			//期初租金list从第二个开始取值下标为1
			for(int i = 1;i < l_rent.size();i++){
				plan_date_list.add(l_plan_date.get(i).toString());//日期
				follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()).toString());//租金
				follow_in_detailTemp = "租金:"+l_rent.get(i);
				follow_in_detail_list.add(follow_in_detailTemp);//流入清单
				follow_out_list.add("-0.00");//流出
				follow_out_detail_list.add("");//流出清单
				net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
			}
		}else{//期末不包括第一期租金 
			follow_in_money = Double.valueOf(l_handling_charge);//第一个流入量为：手续费
			plan_date_list.add(old_start_date);//第一个日期
			follow_in_list.add(formatNumberDoubleTwo(Double.valueOf(follow_in_money).toString()));//第一个流入
			follow_in_detailTemp = "手续费:"+l_handling_charge;//第一个清单
			follow_in_detail_list.add(follow_in_detailTemp);
			follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//租赁本金+咨询费
			follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//流出量
			follow_out_detailTemp = ":租赁本金"+lease_money+" 咨询费:"+consulting_fee+"";//第一个现金流出量清单
			follow_out_detail_list.add(follow_out_detailTemp);
			count_money = follow_in_money+follow_out_money;//
			net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//净流量
			for(int i = 0;i < l_rent.size();i++){
				plan_date_list.add(l_plan_date.get(i).toString());//日期
				follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//租金
				follow_in_detailTemp = "租金:"+l_rent.get(i);
				follow_in_detail_list.add(follow_in_detailTemp);//流入清单
				follow_out_list.add("-0.00");//流出
				follow_out_detail_list.add("");//流出清单
				net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//净流量
			}
		}
		//每次插入之前需删除之前插入的数据
		String del_sql = " delete from fund_contract_plan where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = db.executeUpdate(del_sql);
		flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,"fund_contract_plan");
		
	db.close();
	}
	
	if(flag > 0){
		message = "租金调整操作成功!";	
	}else{
		message = "租金调整失败!";
	}
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.parent.location.reload();
		</script>
