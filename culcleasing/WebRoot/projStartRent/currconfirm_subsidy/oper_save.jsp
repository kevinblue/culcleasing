<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ִ�ȷ��</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<BODY>
<%
	//0.��������
	String user_id = (String)session.getAttribute("czyid");//��ǰ��½��
	String sysDate = getSystemDate(0);
	String saveType = getStr(request.getParameter("savetype")); //�������͡�insert��update
	String sqlstr="";
	ResultSet rs = null;
	//================1.��װConditionBean================
	//1.1==��ȡ����
    String contract_id = getStr(request.getParameter("contract_id")); //��ͬ���
    String begin_id = getStr(request.getParameter("begin_id")); //������
    String flow_date = getStr(request.getParameter("flow_date")); //����ʱ��
    String interest_money = getStr(request.getParameter("interest_money"));//���α�֤�����ֽ��
    String interest_num = getStr(request.getParameter("interest_num"));//������������
    String money_str = getStr(request.getParameter("money_str"));//����ַ���
    String confirm_type=getStr(request.getParameter("feeType"));
    System.out.println("confirm_type==========="+confirm_type);
    System.out.println("money_str=="+money_str);
	String [] money_list = 	money_str.split("#");
	//��ѯ��������
	String rentStartDate = "";
	sqlstr = "select rent_start_date from begin_info_temp where begin_id='"+begin_id+"'";//��ѯ������
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		rentStartDate = getDBDateStr(rs.getString("rent_start_date"));
	}
	
int flag = 0;
	if("add".equals(saveType)){//����������ı�֤����
		//���ӻ������¼
		sqlstr = "delete from begin_currconfirm_info where begin_id='"+begin_id+"'";
	
		sqlstr+="insert into begin_currconfirm_info(begin_id,currConfirm_money,currConfirm_term,confirm_type,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+confirm_type+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//������ϸ���¼
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//��ɾ���ɵ�����
		sqlstr = "delete from begin_currconfirm_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_currconfirm_subsidy(begin_id,plan_date,currconfirm_money,currconfirm_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"',dateadd(mm,"+(i-1)+",'"+rentStartDate+"'),'"+pre_money+"','"+i+"','"+sysDate+"','"+user_id+"')";
		}
		System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);
	}else{
			//���ӻ������¼
		sqlstr = "delete from begin_currconfirm_info where begin_id='"+begin_id+"'";
		sqlstr+="insert into begin_currconfirm_info(begin_id,currConfirm_money,currConfirm_term,confirm_type,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+confirm_type+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//������ϸ���¼
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//��ɾ���ɵ�����
		sqlstr = "delete from begin_currconfirm_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_currconfirm_subsidy(begin_id,plan_date,currconfirm_money,currconfirm_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"',dateadd(mm,"+(i-1)+",'"+rentStartDate+"'),'"+pre_money+"','"+i+"','"+sysDate+"','"+user_id+"')";
		}
		//System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);	
		
	}
db.close();
//���в����ɹ���ת��ҳ����ʱδ����ȷ����δ�� ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
    	opener.alert("�ִ�ȷ�ϼ���ɹ�!");	
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%
}else{
%>
    <script type="text/javascript">
        opener.alert("�ִ�ȷ�ϼ���ʧ��!");	
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%	
}
%>
