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
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("zdkk-zdkkjl-up",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%
String czy = (String) session.getAttribute("czyid");
String rent_id=getDBStr(request.getParameter("id"));

//��ȡϵͳʱ��
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";//������Ϣ
String sqlstr;//���ݿ��ֶ�

String cust_name = "";//�ͻ�����
String corde_id="";//����
String hire_date="";//�տ�����
double rent_all = 0.0;//�տ���
String ebank_number="";//���˴β�����¼������ʵ�ʻ�����

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
///////////////////����������////////////////////////////
/*��ʼͨ�����Ż���-----------------------------------------------------------------------------------------------------*/
			//���ݿ��Ų����м�����ͬ
			sqlstr="select count(contract_id) as size from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			ResultSet rs = db.executeQuery(sqlstr);
			int i=0;
			if(rs.next()){
			i=rs.getInt("size");
			}
			rs.close();
			//���ݿ��Ų��Һ�ͬ��� 
			sqlstr="select contract_id from contract_signatory where client_acc_number='"+corde_id+"'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);			
			if(i==0){
				errMsg+="û���ҵ�����:"+corde_id+"��Ӧ�ĺ�ͬ!";
				System.out.println(errMsg);
				continue;
			}
			String[] contract_ids=new String[i];//��ͬ��� һ�����ſ��ܶ�Ӧ�����ͬ���
			i=0;
			while(rs.next()){
				contract_ids[i]=rs.getString("contract_id");
				i++;
			}
			rs.close();

			sqlstr="select id,contract_id,rent_list,plan_status,rent,corpus,interest,plan_date from  fund_rent_plan where  ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" (contract_id='"+contract_ids[j]+"' and plan_status<>'�ѻ���' and plan_date<='"+datestr+"' )";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr +="  order by plan_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			//�������
			while(rs.next()){
				String id=rs.getString("id");
				String contract_id=rs.getString("contract_id");//��ͬ���
				int rent_list=rs.getInt("rent_list");//�ƻ�����
				String plan_status=rs.getString("plan_status");//����״̬
				double rent=rs.getDouble("rent");//�ƻ��������
				double corpus=rs.getDouble("corpus");//�ƻ���������
				double interest=rs.getDouble("interest");//�ƻ�������Ϣ
				if(rent_all<=0){
					break;
				}
				if(plan_status=="���ֻ���"||plan_status.equals("���ֻ���")){
					//��ѯ��һ�β��ֻ�������
					int hire_list=0;
					sqlstr="select hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					ResultSet rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
					hire_list=rs1.getInt("hire_list")+1;//������1Ϊ��λ�������
					}
					rs1.close();
					
					//��ѯ�����ѻ�
					double[] hire=new double[3];
					sqlstr="select sum(rent) as rent,sum(corpus) as corpus,sum(interest) as interest " +
					"from fund_rent_income where contract_id='"+contract_id+"' group by plan_list  having plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
						hire[0]=rs1.getDouble("rent");//���
						hire[1]=rs1.getDouble("corpus");//����
						hire[2]=rs1.getDouble("interest");//��Ϣ
					}
					rs1.close();

					if((rent_all-(rent-hire[0]))>=0){//�㹻��������
						//�����˴� ���ֻ�������
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(rent-hire[0])+"','CoinType1','"+(corpus-hire[1])+"','"+(interest-hire[2])+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='�ѻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-(rent-hire[0]);//���ܽ��ı�
					}else{
						//������������,���Ǯһ ��Ϣ ���� ��˳�����
						double temp_corpus=corpus-hire[1];//�˴�Ӧ������
						double temp_interest=interest-hire[2];//�˴�Ӧ����Ϣ
						double hire_interest=0;//�˴οɻ���Ϣ
						double hire_corpus=0;//�˴οɻ�����
						if(rent_all>=temp_interest){//��������Ϣ
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//ȥ����Ϣ���һ�����㻹����
							hire_corpus=rent_all;
							rent_all=0;
						}else{//���С����Ϣ
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
						sqlstr="update fund_rent_plan set plan_status='���ֻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
				if(plan_status=="δ����"||plan_status.equals("δ����")){
					if((rent_all-rent)>=0){//�㹻��������
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+rent+"','CoinType1','"+corpus+"','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='�ѻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-rent;//���ܽ��ı�
					}else {
						//������������,���Ǯһ ��Ϣ ���� ��˳�����
						double temp_corpus=corpus;//�˴�Ӧ������
						double temp_interest=interest;//�˴�Ӧ����Ϣ
						double hire_interest=0;//�˴οɻ���Ϣ
						double hire_corpus=0;//�˴οɻ�����
						if(rent_all>=temp_interest){//��������Ϣ
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//ȥ����Ϣ���һ�����㻹����
							hire_corpus=rent_all;
							rent_all=0;
						}else{//���С����Ϣ
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
						sqlstr="update fund_rent_plan set plan_status='���ֻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
			}//����������			
			//������Ϣ			
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
				String id=rs.getString("id");//����Ψһ��ʾ��������
				String contract_id=rs.getString("contract_id");//��ͬ���
				String hire_date_temp=rs.getString("hire_date");//������  ���ڼ��㷣Ϣ
				double penalty_hire=rs.getDouble("penalty");//�Ѿ����˵ķ�Ϣ 
				sqlstr="select dbo.bb_getPunishInterest('"+contract_id+"','"+hire_date_temp+"') as fx";
				System.out.println(sqlstr);
				ResultSet rs1 = db1.executeQuery(sqlstr);
				rs1.next();
				double penalty_plant=rs1.getDouble("fx");//������Ҫ���ķ�Ϣ
				System.out.println("������Ҫ���ķ�Ϣ"+penalty_plant);
				rs1.close();
				if(penalty_plant==0||penalty_hire==penalty_plant){//��ϢΪ�����ʵ����Ϣ���ڼ������÷�Ϣ������������Ϣ����
					System.out.println("������Ϣ");
					continue;
				}

				double penalty_plant_temp=penalty_plant-penalty_hire;//Ҫ����Ϣ
				if(rent_all<penalty_plant_temp){//����Ҫ���ķ�ϢС
					System.out.println("buzu");
					sqlstr="update fund_rent_income set penalty='"+(penalty_hire+rent_all)+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=0;
					break;
				}else{//�㹻������Ϣ
					System.out.println("zu");
					sqlstr="update fund_rent_income set penalty='"+penalty_plant+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=rent_all-penalty_plant_temp;
				}
			}
			rs.close();
			//������Ϣ����
			//+++++++++++++++++++++++++++++++++++++++++++++++++�޵�ɵ�Ӷ໹Ǯ��ʼ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
			if(rent_all>0){//���˷�Ϣ����Ǯ���ʣ�µ�Ǯ������
			errMsg+="�ͻ�:"+cust_name+"ʹ�ÿ���:"+corde_id+"�ܹ�����:"+temp_rent_all+"���������������ܶ�,��˶����Ǯ��������֮��δ���ڵ�������ȥ!";
				sqlstr="select id,contract_id,rent_list,plan_status,rent,corpus,interest,plan_date from  fund_rent_plan where  ";
			for (int j = 0; j < contract_ids.length; j++) {
				sqlstr+=" (contract_id='"+contract_ids[j]+"' and plan_status<>'�ѻ���')";
				if(j!=contract_ids.length-1){
					sqlstr+=" or ";
				}
			}
			sqlstr +="  order by plan_date,contract_id";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			//�������
			while(rs.next()){
				String id=rs.getString("id");
				String contract_id=rs.getString("contract_id");//��ͬ���
				int rent_list=rs.getInt("rent_list");//�ƻ�����
				String plan_status=rs.getString("plan_status");//����״̬
				double rent=rs.getDouble("rent");//�ƻ��������
				double corpus=rs.getDouble("corpus");//�ƻ���������
				double interest=rs.getDouble("interest");//�ƻ�������Ϣ
				if(rent_all<=0){
					break;
				}
				if(plan_status=="���ֻ���"||plan_status.equals("���ֻ���")){
					//��ѯ��һ�β��ֻ�������
					int hire_list=0;
					sqlstr="select hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					ResultSet rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
					hire_list=rs1.getInt("hire_list")+1;//������1Ϊ��λ�������
					}
					rs1.close();
					
					//��ѯ�����ѻ�
					double[] hire=new double[3];
					sqlstr="select sum(rent) as rent,sum(corpus) as corpus,sum(interest) as interest " +
					"from fund_rent_income where contract_id='"+contract_id+"' group by plan_list  having plan_list='"+rent_list+"'";
					System.out.println(sqlstr);
					rs1 = db1.executeQuery(sqlstr);
					if(rs1.next()){
						hire[0]=rs1.getDouble("rent");//���
						hire[1]=rs1.getDouble("corpus");//����
						hire[2]=rs1.getDouble("interest");//��Ϣ
					}
					rs1.close();

					if((rent_all-(rent-hire[0]))>=0){//�㹻��������
						//�����˴� ���ֻ�������
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','"+hire_list+"','BalanceWay1','"+hire_date+
						"','"+(rent-hire[0])+"','CoinType1','"+(corpus-hire[1])+"','"+(interest-hire[2])+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='�ѻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-(rent-hire[0]);//���ܽ��ı�
					}else{
						//������������,���Ǯһ ��Ϣ ���� ��˳�����
						double temp_corpus=corpus-hire[1];//�˴�Ӧ������
						double temp_interest=interest-hire[2];//�˴�Ӧ����Ϣ
						double hire_interest=0;//�˴οɻ���Ϣ
						double hire_corpus=0;//�˴οɻ�����
						if(rent_all>=temp_interest){//��������Ϣ
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//ȥ����Ϣ���һ�����㻹����
							hire_corpus=rent_all;
							rent_all=0;
						}else{//���С����Ϣ
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
						sqlstr="update fund_rent_plan set plan_status='���ֻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
				if(plan_status=="δ����"||plan_status.equals("δ����")){
					if((rent_all-rent)>=0){//�㹻��������
						sqlstr="insert into fund_rent_income " +
						"(contract_id,ebank_number,plan_list,hire_list,balance_mode,hire_date,rent,currency,corpus,interest,penalty," +
						"rent_adjust,corpus_adjust,interest_adjust,penalty_adjust,hire_object,hire_number,creator,create_date) values " +
						"('"+contract_id+"','"+ebank_number+"','"+rent_list+"','1','BalanceWay1','"+hire_date+
						"','"+rent+"','CoinType1','"+corpus+"','"+interest+"','0','0','0','0','0','"+
						cust_name+"','"+corde_id+"','"+czy+"','"+datestr+"')";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						sqlstr="update fund_rent_plan set plan_status='�ѻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
						rent_all=rent_all-rent;//���ܽ��ı�
					}else {
						//������������,���Ǯһ ��Ϣ ���� ��˳�����
						double temp_corpus=corpus;//�˴�Ӧ������
						double temp_interest=interest;//�˴�Ӧ����Ϣ
						double hire_interest=0;//�˴οɻ���Ϣ
						double hire_corpus=0;//�˴οɻ�����
						if(rent_all>=temp_interest){//��������Ϣ
							rent_all=rent_all-temp_interest;
							hire_interest=temp_interest;
							//ȥ����Ϣ���һ�����㻹����
							hire_corpus=rent_all;
							rent_all=0;
						}else{//���С����Ϣ
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
						sqlstr="update fund_rent_plan set plan_status='���ֻ���' where id='"+id+"'";
						System.out.println(sqlstr);
						db1.executeUpdate(sqlstr);
					}
				}
			}//����������			
			//������Ϣ			
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
				String id=rs.getString("id");//����Ψһ��ʾ��������
				String contract_id=rs.getString("contract_id");//��ͬ���
				String hire_date_temp=rs.getString("hire_date");//������  ���ڼ��㷣Ϣ
				double penalty_hire=rs.getDouble("penalty");//�Ѿ����˵ķ�Ϣ 
				sqlstr="select dbo.bb_getPunishInterest('"+contract_id+"','"+hire_date_temp+"') as fx";
				System.out.println(sqlstr);
				ResultSet rs1 = db1.executeQuery(sqlstr);
				rs1.next();
				double penalty_plant=rs1.getDouble("fx");//������Ҫ���ķ�Ϣ
				System.out.println("������Ҫ���ķ�Ϣ"+penalty_plant);
				rs1.close();
				if(penalty_plant==0||penalty_hire==penalty_plant){//��ϢΪ�����ʵ����Ϣ���ڼ������÷�Ϣ������������Ϣ����
					System.out.println("������Ϣ");
					continue;
				}

				double penalty_plant_temp=penalty_plant-penalty_hire;//Ҫ����Ϣ
				if(rent_all<penalty_plant_temp){//����Ҫ���ķ�ϢС
					System.out.println("buzu");
					sqlstr="update fund_rent_income set penalty='"+(penalty_hire+rent_all)+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=0;
					break;
				}else{//�㹻������Ϣ
					System.out.println("zu");
					sqlstr="update fund_rent_income set penalty='"+penalty_plant+"' where id='"+id+"'";
					System.out.println(sqlstr);
					db1.executeUpdate(sqlstr);
					rent_all=rent_all-penalty_plant_temp;
				}
			}
			}
			//+++++++++++++++++++++++++++++++++++++++++++++++++�޵�ɵ�Ӷ໹Ǯ����++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
			/*��������--------------------------------------------------------------------------------------------------------------*/
////////////////////////////////////////////////////////
			iallcol++;
		 }
	db.close();
	rs2.close();
	sqlstr="update rent_list set is_verification='1',remark='"+"�������ݳɹ�!���ι�����"+iallcol+"��������¼"+errMsg+"' where id='"+rent_id+"'";
	System.out.println(sqlstr);
	int fag=db2.executeUpdate(sqlstr);
	db2.close();
	if(fag!=0){
		%>
		<script>
		alert("�������ݳɹ�!���ι�����<%=iallcol%>��������¼,��ˢ��ҳ���ٴβ鿴!");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("��������ĳЩ���ݳ��������´���:<%=errMsg%>");
			<%
		}
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	alert("�������ݳɹ�ʧ��!");
	<%
	}
	%>
	//opener.parent.history.reload();
		window.history.go(-1);
		
		//window.location.reload();
	</script>
<%if(null != db1){db1.close();}%>