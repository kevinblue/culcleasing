<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��֤��������</title>
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
	//================1.��װConditionBean================
	//1.1==��ȡ����
    String contract_id = getStr(request.getParameter("contract_id")); //��ͬ���
    String begin_id = getStr(request.getParameter("begin_id")); //������
    String flow_date = getStr(request.getParameter("flow_date")); //����ʱ��
    String interest_money = getStr(request.getParameter("interest_money"));//���α�֤�����ֽ��
    String interest_num = getStr(request.getParameter("interest_num"));//������������
    String money_str = getStr(request.getParameter("money_str"));//����ַ���
    System.out.println("money_str=="+money_str);
	String [] money_list = 	money_str.split("#");
int flag = 0;
	if("add".equals(saveType)){//����������ı�֤����
		//���ӻ������¼
		sqlstr = "delete from begin_caution_info where begin_id='"+begin_id+"'";
		sqlstr+="insert into begin_caution_info(begin_id,caution_money,caution_term,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//������ϸ���¼
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//��ɾ���ɵ�����
		sqlstr = "delete from begin_caution_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_caution_subsidy(begin_id,subsidy_money,subsidy_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"','"+pre_money+"','"+i+"','"+sysDate+"','"+user_id+"')";
		}
		System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);
	}else{
			//���ӻ������¼
		sqlstr = "delete from begin_caution_info where begin_id='"+begin_id+"'";
		sqlstr+="insert into begin_caution_info(begin_id,caution_money,caution_term,flow_date,create_date,creator) values ";
		sqlstr+="('"+begin_id+"','"+interest_money+"','"+interest_num+"','"+flow_date+"','"+sysDate+"','"+user_id+"')";
		flag=db.executeUpdate(sqlstr);
		//������ϸ���¼
		String pre_money = String.valueOf(formatNumberDoubleTwo(Double.parseDouble(interest_money)/Integer.parseInt(interest_num)));
		//��ɾ���ɵ�����
		sqlstr = "delete from begin_caution_subsidy where begin_id='"+begin_id+"'";
		db.executeUpdate(sqlstr);
		sqlstr="";
		for(int i=1;i<=Integer.parseInt(interest_num);i++){
			sqlstr+=" insert into begin_caution_subsidy(begin_id,subsidy_money,subsidy_list,create_date,creator) values ";
			sqlstr+="('"+begin_id+"','"+money_list[i-1]+"','"+i+"','"+sysDate+"','"+user_id+"')";
		System.out.println(sqlstr);
		}
		//System.out.println(sqlstr);
		flag+=db.executeUpdate(sqlstr);	
		
	}
db.close();
//���в����ɹ���ת��ҳ����ʱδ����ȷ����δ�� ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("��֤��ʵ��������ɹ�!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("��֤��������ʧ��!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
