<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ - ���л�׼���� - ���ݲ���ҳ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<!-- ���ֶμ���Ӧ�������� �Ա��޸�ʹ�� 
start_date,rate_half,rate_one,rate_three,rate_five,rate_abovefive,
base_rate_half,base_rate_one,base_rate_three,base_rate_five,
base_rate_abovefive,creator,create_date,modificator,modify_date
���ʿ�ʼִ������,��Ϣ��������_����,��Ϣ��������_1��,��Ϣ��������_3��,��Ϣ��������_5��,��Ϣ��������_5������,
��Ϣ���л�׼_����,��Ϣ���л�׼_1��,��Ϣ���л�׼_3��,��Ϣ���л�׼_5��,
��Ϣ���л�׼_5������,�Ǽ���,�Ǽ�ʱ��,������,��������
 -->
<BODY>
<%
	String savaType = getStr(request.getParameter("model"));
	String key_id = getStr(request.getParameter("key_id"));//���л�׼���ʻ�׼�������
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
		//�Ӳ�
	    String start_date = getStr(request.getParameter("start_date")); //���ʿ�ʼִ������
//		String rate_half = "0";
	    String rate_half = getStr(request.getParameter("rate_half")); //��Ϣ��������_����
		String rate_one = getStr(request.getParameter("rate_one"));//��Ϣ��������_1��
		String rate_three = getStr(request.getParameter("rate_three"));//��Ϣ��������_3��
		String rate_five = getStr(request.getParameter("rate_five"));//��Ϣ��������_5��
		String rate_abovefive = getStr(request.getParameter("rate_abovefive"));//��Ϣ��������_5������
		
		String base_rate_half = getStr(request.getParameter("base_rate_half"));//��Ϣ���л�׼_����
//		String base_rate_half="0";
		String base_rate_one = getStr(request.getParameter("base_rate_one"));//��Ϣ���л�׼_1��
		String base_rate_three = getStr(request.getParameter("base_rate_three"));//��Ϣ���л�׼_3��
		String base_rate_five = getStr(request.getParameter("base_rate_five"));//��Ϣ���л�׼_5
		
		String base_rate_abovefive = getStr(request.getParameter("base_rate_abovefive"));//��Ϣ���л�׼_5������
		String creator = getStr(request.getParameter("creator"));//�Ǽ���
		String create_date = getStr(request.getParameter("create_date"));//�Ǽ�ʱ��
		String modificator = getStr(request.getParameter("modificator"));//������
		String modify_date = getStr(request.getParameter("modify_date"));//��������
		String adjust_flag = getStr(request.getParameter("adjust_flag"));//�Ƿ�����ɵ�Ϣ ��2010-12-30�����ֶΡ�
		
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//��ʽ��ʱ��
	//String nowTime=sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	String repeat_flag = "";
	/* ���л�׼������Ӳ��� */
	String query_startDate = " select * from  fund_standard_interest where start_date = '"+start_date+"'  or  adjust_flag = '��' ";
	if(savaType.equals("add")){
		//����֮ǰҪ�ж�fund_standard_interest�����Ƿ���ں��������ڡ�start_date����ͬ�����ݣ����е�Ϣһ��ֻ��һ������
		rs = db.executeQuery(query_startDate);
		rs.last(); //�Ƶ����һ��
		int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
		rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
		if(rowCount > 0){
			repeat_flag = "1";//ϵͳ�л���û�д�����ĵ�Ϣ������ӵĵ�Ϣʱ��ϵͳ���Ѿ�����
		}else{
			sql.append(" INSERT INTO fund_standard_interest ")
	           .append(" (start_date,rate_half,rate_one,rate_three,rate_five,rate_abovefive ")
	           .append(" ,base_rate_half,base_rate_one,base_rate_three,base_rate_five ")
	           .append(" ,base_rate_abovefive,creator,create_date,modificator,modify_date,adjust_flag) ")
	     	   .append(" VALUES ")
	           .append(" ('"+start_date+"','"+rate_half+"' ")
	           .append(" ,'"+rate_one+"','"+rate_three+"','"+rate_five+"' ")
	           .append(" ,'"+rate_abovefive+"','"+base_rate_half+"','"+base_rate_one+"' ")
	           .append(" ,'"+base_rate_three+"','"+base_rate_five+"','"+base_rate_abovefive+"' ")
	           .append(" ,'"+creator+"','"+create_date+"','"+modificator+"','"+modify_date+"','"+adjust_flag+"') ");
	//System.out.println("�������л�׼������SQL-->   "+sql.toString());
			//ִ�����sql���
			flag = db.executeUpdate(sql.toString());
			message="�������л�׼����";
		}
		rs.close();
	} 
	/* ���л�׼�����޸Ĳ��� */
	if(savaType.equals("mod")){//�޸�2���ж�
		//�޸�ǰ��ѯ��fund_adjust_interest_contract��Ӧadjust_id�Ƿ�������ݣ������������޸ģ�ͬ���һ����Ҫ�ж�����
		//String query_faic_sql = " select * from fund_adjust_interest_contract where  adjust_id = '"+key_id+"' ";
		//System.out.println("query_faic_sql��Ϣ�޸�ǰ�ж�SQL���==�� "+query_faic_sql);
		//rs = db.executeQuery(query_faic_sql);
		//rs.last(); //�Ƶ����һ��
		//int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
		//rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
		//if(rowCount > 0){
		//	repeat_flag = "3";//������Ϣ��¼������δ��Ϣ����Ŀ�������޸�
		//}else{
		//	query_startDate = "";
			//��������Ӧ�µ����������ǿ����޸ĵ�
		//	query_startDate = " select * from  fund_standard_interest where start_date = '"+start_date+"' and id <>  '"+key_id+"' ";
		//	rs = db.executeQuery(query_startDate);
		//	rs.last(); //�Ƶ����һ��
		//	rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
		//	rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
		//	if(rowCount > 0){
		//		repeat_flag = "2";//ϵͳ�л���û�д�����ĵ�Ϣ������ӵĵ�Ϣʱ��ϵͳ���Ѿ�����
		//	}else{
			   //ƴװ�޸�SQL��� ��������Ŀ���
			   sql.append(" UPDATE fund_standard_interest ")
			      .append(" SET modificator = '"+modificator+"' ")
			      .append(" ,modify_date = '"+modify_date+"' ")
			      .append(" ,adjust_flag = '"+adjust_flag+"' ")
			      .append(" WHERE id = '"+key_id+"' ");
				System.out.println("���л�׼�����޸�SQL-->   "+sql.toString());
				flag = db.executeUpdate(sql.toString());
				if(adjust_flag.equals("��")){
						String sqlstr="exec Culc_Tool_Upd_InterestDiff";
						flag += db.executeUpdate(sqlstr);
					}
				
	//		}
	//	}
		message = "�޸����л�׼����";
	}
	if(savaType.equals("del")){//ɾ��
		//ɾ��ʱ����txid ��ѯdbo.fund_adjust_interest_contract ����м�¼�����Ѳ�����ɾ�������û�У���ɾ��
		String query_s = " select * from  fund_adjust_interest_contract where adjust_id = '"+key_id+"'";
		ResultSet rs1 = db.executeQuery(query_s);
		rs1.last(); //�Ƶ����һ��
		int rowCount = rs1.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
		rs1.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
		if(rowCount > 0){
			repeat_flag = "33";//������Ϣ��¼������δ��Ϣ����Ŀ������ɾ��
		}else{
			String del_sql = "delete from fund_standard_interest where id = '"+key_id+"'";
			flag = db.executeUpdate(del_sql);
			message = "���л�׼����ɾ��";
		}
		rs1.close();
	}
	db.close();

	//**********************************
	if(repeat_flag.equals("1")){
%>
	<script>
		alert("�ܱ�Ǹ�������,ϵͳ�л���û�д�����ĵ�Ϣ������ӵĵ�Ϣʱ��ϵͳ���Ѿ�����!");
		opener.location.reload();
		window.close();
		//window.history.back(-1);
	</script>
<%
	}
	else if(repeat_flag.equals("2")){
%>
	<script>
		alert("�ܱ�Ǹ�����޸ģ���������Ϣ��¼�Ѿ������ꡱ �� ��ϵͳ���Ѵ�������Ҫ�޸ĵ�Ϣʱ�䡱!");
		window.history.back(-1);
		window.close();
	</script>
<%
	}else if(repeat_flag.equals("3")){
%>
	<script>
		alert("������Ϣ��¼������δ��Ϣ����Ŀ�������޸�!");
		opener.location.reload();
		window.close();
	</script>	
<%
	}else if(repeat_flag.equals("33")){
%>
	<script>
		alert("������Ϣ��¼������δ��Ϣ����Ŀ������ɾ��!");
		opener.location.reload();
		window.close();
	</script>	
<%
	}else{
		if(flag > 0){
			String hrefStr="";
			if(savaType.equals("del")){//ɾ���ɹ�
%>
		        <script>
					//opener.window.location.href = "frkh_list.jsp";
					alert("<%=message%>�ɹ�!");
					opener.location.reload();
					this.close();
				</script>
<%
			}else{//�޸���ӳɹ�
%>
		        <script>
					alert("<%=message%>�ɹ�!");
					opener.location.reload();
					window.close();
				</script>
<%
			}	
		}else{
%>
	        <script>
				alert("<%=message%>ʧ��!");
				opener.location.reload();
				this.close();
			</script>
<%	
		}
	}
	db.close();
%>