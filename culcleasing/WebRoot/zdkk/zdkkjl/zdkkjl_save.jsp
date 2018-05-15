<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("zdkk-zdkkjl-up",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%
String czy = (String) session.getAttribute("czyid");
String rent_id=getDBStr(request.getParameter("id"));

//获取系统时间
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";//错误消息
String sqlstr;//数据库字段

String cust_name = "";//客户名称
String corde_id="";//卡号
String hire_date="";//收款日期
double rent_all = 0.0;//收款金额
String ebank_number="";//将此次操作记录关联到实际回笼表

ResultSet rs2 ;
int iallcol=0;

String filePath;
String fileName = "";
String message = "";
String temp_rent_all="";
sqlstr="select * from fund_butten_list where rent_id='"+rent_id+"'";
rs2 = db2.executeQuery(sqlstr);
while(rs2.next()){
	cust_name=getDBStr(rs2.getString("cust_name"));
	corde_id=getDBStr(rs2.getString("acc_number"));
	hire_date=getDBDateStr(rs2.getString("receive_date"));
	rent_all=rs2.getDouble("receive_money");
	ebank_number=getDBStr(rs2.getString("id"));	
	temp_rent_all=rent_all+"";
///////////////////回笼操作区////////////////////////////
/*开始通过卡号回笼-----------------------------------------------------------------------------------------------------*/
			//根据卡号查找有几个合同
			sqlstr="select count(contract_id) as size from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			ResultSet rs = db.executeQuery(sqlstr);
			int i=0;
			if(rs.next()){
			i=rs.getInt("size");
			}
			rs.close();
			//根据卡号查找合同编号 
			sqlstr="select contract_id from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);			
			if(i==0){
				errMsg+="没有找到卡号:"+corde_id+"对应的合同!";
				System.out.println(errMsg);
				continue;
			}
			String[] contract_ids=new String[i];//合同编号 一个卡号可能对应多个合同编号
			i=0;
			while(rs.next()){
				contract_ids[i]=rs.getString("contract_id");
				i++;
			}
			rs.close();

			sqlstr="select id,contract_id,rent_list,plan_status,rent,corpus,interest,plan_date from  fund_rent_plan where  ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" (contract_id='"+contract_ids[j]+"' and plan_status<>'已回笼' and plan_date<='"+datestr+"' )";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr +="  order by plan_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			//回笼租金
			while(rs.next()){
				String id=rs.getString("id");
				String contract_id=rs.getString("contract_id");//合同编号
				int rent_list=rs.getInt("rent_list");//计划期项
				String plan_status=rs.getString("plan_status");//回笼状态
				double rent=rs.getDouble("rent");//计划回笼租金
				double corpus=rs.getDouble("corpus");//计划回笼本金
				double interest=rs.getDouble("interest");//计划回笼租息
				if(rent_all<=0){
					break;
				}
				if(plan_status=="部分回笼"||plan_status.equals("部分回笼")){
					//查询上一次部分回笼期数
					int hire_list=0;
					sqlstr="select hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					ResultSet rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
					hire_list=rs1.getInt("hire_list")+1;//期数加1为这次回笼期数
					}
					rs1.close();
					
					//查询此期已还
					double[] hire=new double[3];
					sqlstr="select sum(rent) as rent,sum(corpus) as corpus,sum(interest) as interest " +
					"from fund_rent_income where contract_id='"+contract_id+"' group by plan_list  having plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
						hire[0]=rs1.getDouble("rent");//租金
						hire[1]=rs1.getDouble("corpus");//本金
						hire[2]=rs1.getDouble("interest");//租息
					}
					rs1.close();

					if((rent_all-(rent-hire[0]))>=0){//足够回笼此期
						//回笼此次 部分回笼期项
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(rent-hire[0])+"','CoinType1','"+(corpus-hire[1])+"','"+(interest-hire[2])+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-(rent-hire[0]);//把总金额改变
					}else{
						//不够回笼此期,则把钱一 租息 本金 的顺序核销
						double temp_corpus=corpus-hire[1];//此次应还本金
						double temp_interest=interest-hire[2];//此次应还租息
						double hire_interest=0;//此次可还租息
						double hire_corpus=0;//此次可还本金
						if(rent_all>=temp_interest){//余额大于租息
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//去掉租息余额一定不足还本金
							hire_corpus=rent_all;
							rent_all=0;
						}else{//余额小于租息
							hire_interest=hire[2]+rent_all;							
							rent_all=0;
						}
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(hire_interest+hire_corpus)+"','CoinType1','"+(hire_corpus)+"','"+(hire_interest)+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='部分回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
				if(plan_status=="未回笼"||plan_status.equals("未回笼")){
					if((rent_all-rent)>=0){//足够回笼此期
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+rent+"','CoinType1','"+corpus+"','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-rent;//把总金额改变
					}else {
						//不够回笼此期,则把钱一 租息 本金 的顺序核销
						double temp_corpus=corpus;//此次应还本金
						double temp_interest=interest;//此次应还租息
						double hire_interest=0;//此次可还租息
						double hire_corpus=0;//此次可还本金
						if(rent_all>=temp_interest){//余额大于租息
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//去掉租息余额一定不足还本金
							hire_corpus=rent_all;
							rent_all=0;
						}else{//余额小于租息
							hire_interest=rent_all;							
							rent_all=0;
						}
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+(hire_interest+hire_corpus)+"','CoinType1','"+(hire_corpus)+"','"+(hire_interest)+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='部分回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
			}//回笼租金结束			
			//回笼罚息			
			sqlstr="select id,contract_id,hire_date,penalty from fund_rent_income where ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" contract_id='"+contract_ids[j]+"'";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr+="  order by hire_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			while(rs.next()){
				String id=rs.getString("id");//用来唯一表示此条数据
				String contract_id=rs.getString("contract_id");//合同编号
				String hire_date_temp=rs.getString("hire_date");//还款日  用于计算罚息
				double penalty_hire=rs.getDouble("penalty");//已经还了的罚息 
				sqlstr="select dbo.bb_getPunishInterest('"+contract_id+"','"+hire_date_temp+"') as fx";
				System.out.println(sqlstr);
				ResultSet rs1 = db1.executeQuery(sqlstr);
				rs1.next();
				double penalty_plant=rs1.getDouble("fx");//计算所要还的罚息
				System.out.println("计算所要还的罚息"+penalty_plant);
				rs1.close();
				if(penalty_plant==0||penalty_hire==penalty_plant){//罚息为零或者实还罚息等于计算所得罚息则跳过此条罚息回笼
					System.out.println("跳过罚息");
					continue;
				}

				double penalty_plant_temp=penalty_plant-penalty_hire;//要还罚息
				if(rent_all<penalty_plant_temp){//余额比要还的罚息小
					System.out.println("buzu");
					sqlstr="update fund_rent_income set penalty='"+(penalty_hire+rent_all)+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=0;
					break;
				}else{//足够偿还罚息
					System.out.println("zu");
					sqlstr="update fund_rent_income set penalty='"+penalty_plant+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=rent_all-penalty_plant_temp;
				}
			}
			rs.close();
			//回笼罚息结束
			//+++++++++++++++++++++++++++++++++++++++++++++++++无敌傻子多还钱开始++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
			if(rent_all>0){//还了罚息还有钱则把剩下的钱还本金
			errMsg+="客户:"+cust_name+"使用卡号:"+corde_id+"总共还款:"+temp_rent_all+"超出了他的逾期总额,因此多余的钱将回笼到之后未逾期的期项中去!";
				sqlstr="select id,contract_id,rent_list,plan_status,rent,corpus,interest,plan_date from  fund_rent_plan where  ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" (contract_id='"+contract_ids[j]+"' and plan_status<>'已回笼')";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr +="  order by plan_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			//回笼租金
			while(rs.next()){
				String id=rs.getString("id");
				String contract_id=rs.getString("contract_id");//合同编号
				int rent_list=rs.getInt("rent_list");//计划期项
				String plan_status=rs.getString("plan_status");//回笼状态
				double rent=rs.getDouble("rent");//计划回笼租金
				double corpus=rs.getDouble("corpus");//计划回笼本金
				double interest=rs.getDouble("interest");//计划回笼租息
				if(rent_all<=0){
					break;
				}
				if(plan_status=="部分回笼"||plan_status.equals("部分回笼")){
					//查询上一次部分回笼期数
					int hire_list=0;
					sqlstr="select hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					ResultSet rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
					hire_list=rs1.getInt("hire_list")+1;//期数加1为这次回笼期数
					}
					rs1.close();
					
					//查询此期已还
					double[] hire=new double[3];
					sqlstr="select sum(rent) as rent,sum(corpus) as corpus,sum(interest) as interest " +
					"from fund_rent_income where contract_id='"+contract_id+"' group by plan_list  having plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
						hire[0]=rs1.getDouble("rent");//租金
						hire[1]=rs1.getDouble("corpus");//本金
						hire[2]=rs1.getDouble("interest");//租息
					}
					rs1.close();

					if((rent_all-(rent-hire[0]))>=0){//足够回笼此期
						//回笼此次 部分回笼期项
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(rent-hire[0])+"','CoinType1','"+(corpus-hire[1])+"','"+(interest-hire[2])+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-(rent-hire[0]);//把总金额改变
					}else{
						//不够回笼此期,则把钱一 租息 本金 的顺序核销
						double temp_corpus=corpus-hire[1];//此次应还本金
						double temp_interest=interest-hire[2];//此次应还租息
						double hire_interest=0;//此次可还租息
						double hire_corpus=0;//此次可还本金
						if(rent_all>=temp_interest){//余额大于租息
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//去掉租息余额一定不足还本金
							hire_corpus=rent_all;
							rent_all=0;
						}else{//余额小于租息
							hire_interest=hire[2]+rent_all;							
							rent_all=0;
						}
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(hire_interest+hire_corpus)+"','CoinType1','"+(hire_corpus)+"','"+(hire_interest)+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='部分回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
				if(plan_status=="未回笼"||plan_status.equals("未回笼")){
					if((rent_all-rent)>=0){//足够回笼此期
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+rent+"','CoinType1','"+corpus+"','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='已回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-rent;//把总金额改变
					}else {
						//不够回笼此期,则把钱一 租息 本金 的顺序核销
						double temp_corpus=corpus;//此次应还本金
						double temp_interest=interest;//此次应还租息
						double hire_interest=0;//此次可还租息
						double hire_corpus=0;//此次可还本金
						if(rent_all>=temp_interest){//余额大于租息
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//去掉租息余额一定不足还本金
							hire_corpus=rent_all;
							rent_all=0;
						}else{//余额小于租息
							hire_interest=rent_all;							
							rent_all=0;
						}
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+(hire_interest+hire_corpus)+"','CoinType1','"+(hire_corpus)+"','"+(hire_interest)+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='部分回笼' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
			}//回笼租金结束			
			//回笼罚息			
			sqlstr="select id,contract_id,hire_date,penalty from fund_rent_income where ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" contract_id='"+contract_ids[j]+"'";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr+="  order by hire_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			while(rs.next()){
				String id=rs.getString("id");//用来唯一表示此条数据
				String contract_id=rs.getString("contract_id");//合同编号
				String hire_date_temp=rs.getString("hire_date");//还款日  用于计算罚息
				double penalty_hire=rs.getDouble("penalty");//已经还了的罚息 
				sqlstr="select dbo.bb_getPunishInterest('"+contract_id+"','"+hire_date_temp+"') as fx";
				System.out.println(sqlstr);
				ResultSet rs1 = db1.executeQuery(sqlstr);
				rs1.next();
				double penalty_plant=rs1.getDouble("fx");//计算所要还的罚息
				System.out.println("计算所要还的罚息"+penalty_plant);
				rs1.close();
				if(penalty_plant==0||penalty_hire==penalty_plant){//罚息为零或者实还罚息等于计算所得罚息则跳过此条罚息回笼
					System.out.println("跳过罚息");
					continue;
				}

				double penalty_plant_temp=penalty_plant-penalty_hire;//要还罚息
				if(rent_all<penalty_plant_temp){//余额比要还的罚息小
					System.out.println("buzu");
					sqlstr="update fund_rent_income set penalty='"+(penalty_hire+rent_all)+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=0;
					break;
				}else{//足够偿还罚息
					System.out.println("zu");
					sqlstr="update fund_rent_income set penalty='"+penalty_plant+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=rent_all-penalty_plant_temp;
				}
			}
			}
			//+++++++++++++++++++++++++++++++++++++++++++++++++无敌傻子多还钱结束++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
			/*回笼结束--------------------------------------------------------------------------------------------------------------*/
////////////////////////////////////////////////////////
			iallcol++;
		 }
	db.close();
	rs2.close();
	sqlstr="update rent_list set is_verification='1',remark='"+"核销数据成功!本次共核销"+iallcol+"条回笼记录"+errMsg+"' where id='"+rent_id+"'";
	System.out.println(sqlstr);
	int fag=db2.executeUpdate(sqlstr);
	db2.close();
	if(fag!=0){
		%>
		<script>
		alert("核销数据成功!本次共核销<%=iallcol%>条回笼记录,请刷新页面再次查看!");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("但是其中某些数据出现了如下错误:<%=errMsg%>");
			<%
		}
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	alert("核销数据成功失败!");
	<%
	}
	%>
	//opener.parent.history.reload();
		window.history.go(-1);
		
		//window.location.reload();
	</script>
<%if(null != db1){db1.close();}%>