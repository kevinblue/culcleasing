<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.tenwa.culc.calc.tx.Tx_Init"%>
<%@page import="com.tenwa.culc.calc.tx.Tx_Process_BGZ"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 2010-08-05�޸�Ϊ��com.rent.calc.tx.TransRateNew ��ǰ��ֵΪ��com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ȶ�����Ϣ - ִ�е�Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	//System.out.println("=============>"+request.getParameter("all_checkbos_value"));
	String all_checkbos_value = getStr(request.getParameter("all_checkbos_value"));//��ȡ������Ҫ��Ϣ����Ŀ��� ��ͬ���
	String begin_id_list = getStr(request.getParameter("begin_id_list"));//��ȡ������Ҫ��Ϣ��������
	String str_settle_method = getStr(request.getParameter("str_settle_method"));//��ȡ������Ҫ��Ϣ�������㷽ʽ
	String str_adjust_style = getStr(request.getParameter("adjust_style"));//��ȡ������Ҫ��Ϣ�ĵ�Ϣ��ʽ������ �����ڣ����꣩
	//String all_checkbos_value = "001#002#003#004";
	
	String adjust_id = getStr(request.getParameter("txId")); //adjust_id ���л�׼���ʱ����� "56";//
	String save_type = getStr(request.getParameter("save_type"));//
	System.out.println("all_checkbos_value="+all_checkbos_value+"--begin_id_list="+begin_id_list);
	//System.out.println("======adjust_id>"+adjust_id);
	int flag = 0;
	ResultSet rs;
	String message = "";
	Tx_Process_BGZ  Process = new Tx_Process_BGZ();
	if("add".equals(save_type)){
	Tx_Init tx_init= new Tx_Init();
		flag += tx_init.Tx_Int_add(all_checkbos_value,begin_id_list,adjust_id,czyid,str_adjust_style);
			message= "����"+flag+"����ͬ";
	}else if("process".equals(save_type)){//��Ϣ����
			flag=Process.tx_ProcessInfo(all_checkbos_value,begin_id_list,str_settle_method,adjust_id,czyid,str_adjust_style);
			message = "��Ϣ����"+flag+"����ͬ";
	}else if("del".equals(save_type)){//��Ϣ����
			String [] contract_list = all_checkbos_value.split("#");//��ͬ�������
			String [] begin_list = begin_id_list.split("#");//��ͬ�������
			int flag2=0;//��ʶ������¼�Ƿ����ĺ�ͬ�з���������״̬
			for(int i=0;i<contract_list.length;i++){
			String sql = "select plan_status from fund_rent_plan where contract_id='"+contract_list[i]+"' and begin_id= '"+begin_list[i]+"' and ";
				   sql += " rent_list>(select rent_list_start from fund_adjust_interest_contract where ";
				   sql += "contract_id ='"+contract_list[i]+"' and begin_id= '"+begin_list[i]+"' and adjust_id='"+adjust_id+"') and plan_status<>'δ����'";
			rs = db.executeQuery(sql);
			if(rs.next()){
				message += "��ͬ"+contract_list[i]+"����ѻ���,����ʧ��";
				flag2+=1;
				break;
				}
			rs.close();
			}
			
			if(flag>0){//�������Ϣ����
				flag=0;//��Ϣʧ��
			}else{//���е�Ϣ����
				
				flag=Process.tx_CancleInfo(all_checkbos_value,begin_id_list,adjust_id,str_adjust_style);
				message = "��Ϣ����";
			}
	}
	//************************************************************************************************
	//�Ƚ��Բ����жϣ������׽ṹ�н��׽ṹ�� ���ʸ������� Ϊ�����̶����������͡����ֲ��䡯ʱ�����������㷽��Ϊ�����ȶ��ʱ�����е�Ϣ�ֽ��������
	 
	//���Ĳ��������Ϣ����ֽ���
	// �ֽ���
	//���ú�̨�������е�Ϣʱ��������	
	//flag = cashFlow.addCashFlow(list_contr, adjust_id);
	//System.out.println("��Ϣflag��ֵΪ==> :"+flag);
	//���岽����2��his�� fund_contract_plan_his fund_contract_plan_mark_his�������� ״̬Ϊ���󣩣����ݴ�fund_contract_plan,fund_contract_plan_mark��ȡ  ����֮ǰ��ɾ��
	//flag = tx_Init.insert_HisTable_End(list_contr,adjust_id);	
	
	//************************************************************************************************	
	
	db.close();
		if(flag > 0){
			String hrefStr="";
%>
		        <script>
					alert("<%=message%>�ɹ�!");
					opener.parent.location.reload();
					window.close();
				</script>
<%
		}else{
%>
	        <script>
				alert("<%=message%>ʧ��!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
%>