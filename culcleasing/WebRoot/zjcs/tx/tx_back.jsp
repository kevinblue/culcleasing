<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@page import="com.condition.Tx_Init"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
	//��Ϣ�ع�����
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
	//��ɾ��fund_rent_plan������ݣ����ݺ�ͬ�ţ���
	//�ٽ���his�����" and mod_reason = '��Ϣ'  and status = 'ǰ' and measure_id = '"+custId+"'  and  contract_id = ''"+contract_id+"'  ";
	//ץȡ��Ӧ�����ƻ����ݣ���ӵ�fund_rent_plan����

	//��һ�������ݺ�ͬ��ɾ��fund_rent_plan�������
	sql = " delete from fund_rent_plan where contract_id = '"+ contract_id + "' ";
	flag = db.executeUpdate(sql);
	System.out.println("in_sql�ع�ǰɾ��flag--->"+flag);
	System.out.println("in_sql�ع�ǰɾ��--->"+sql);
	//�ڶ��������ع���������fund_rent_plan_his
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
		System.out.println("in_sql�ع�--->"+in_sql);
	}
	String isHG = "";
	if(flag > 0){
		isHG = "��";
	}else{
		isHG = "��";
	}
	//�ֽ�������his �� ��ʽfund_contract_plan,und_contract_plan_mark ȡ״̬Ϊ��ǰ��
	Tx_Init tx_Init = new Tx_Init();
	tx_Init.insert_ZS_Table(contract_id,custId);
	//2011-01-06��������
	//�ع�������󣬸��ݺ�ͬ�ţ�adjust_id����fund_adjust_interest_contract�� isHG,hgCreateDate(ȡgetdate()),hgCreator(��ǰ��½�˵�id)
	sql = " update  fund_adjust_interest_contract set isHG = '"+isHG+"' ,hgCreateDate = '"+datestr+"',hgCreator = '"+czyid+"' ";
	sql = sql + " where  adjust_id = '"+custId+"'";
	sql = sql + " and  contract_id = '"+contract_id+"'";
	flag = db.executeUpdate(sql);
	System.out.println("�޸Ļع�״̬--->"+sql);
	
	//***********************************************************************
	//todo:�ع�ʱͬʱ�������´�his����ȡ�ֽ����ľ���������2��irr���½��׽ṹ 2011-01-12������� 
	tx_Init.js_irr(contract_id);
	//
	
	
	db.close();

	if(flag > 0){//�޸���ӳɹ�
%>
		        <script>
					alert("��Ϣ�ع������ɹ�!");
					opener.location.reload();
					window.close();
				</script>
<%
				
		}else{
%>
	        <script>
				alert("��Ϣ�ع�����ʧ��!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
%>