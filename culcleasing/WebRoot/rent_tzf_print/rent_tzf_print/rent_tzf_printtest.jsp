<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<body>
<object codebase="http://leasing.tenwa.com/wsReport.cab#version=4,6,0,1" classid="clsid:08D91289-1761-4006-8294-FDE48B9F29BD" width="100%" height="100%" id="obj"></object>

<%
String dqczy=(String) session.getAttribute("czyid");

//--------����ΪȨ�޿���-----------------------------
String sqlstr;
ResultSet rs;
ResultSet rs1;

String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );



String s_date = getStr( request.getParameter("s_date") );	//��ʼ����
String e_date = getStr( request.getParameter("e_date") );	//��������
String bad_date = getStr( request.getParameter("bad_date") );	//���ڽ�������
String print_flag= getStr( request.getParameter("print_flag") );//��ӡ��־
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String end_date="";//���޺�ͬ�������ڣ����Ҫ���͵�����֪ͨ������ڣ���֤��ֿ۵���������ȡ������ĳ����ƻ�����
String c_punish="";//���ڷ�Ϣ
String hire_date="";//�����Ѿ�û��Ԥ���������������������ʱ���������Ľ�������Ӧ���Ǹ��ڻ��������һ������


String client_postcode="";
String client_address="";
String client_address1="";
String client_address2="";
String cust_name="";
String client_linkman="";
String phone="";
String contract_id="";
String curr_plan_date="";
String curr_rent="";
String curr_rent_list="";

String pena_rate="";
String lessor_name="";
String bank_name="";
String lease_acc_number="";

String total_money="";
String total_money_bad="";
String curr_badRent="";
String curr_punishInterest="";
String line_str1="";
String line_str2="";
String line_str3="";
String line_str4="";
String line_str5="";
String line_str6="";
String pre_rent_list="";
String pre_pre_rent_list="";
String pre_pre_pre_rent_list="";
String pre_rent="";
String pre_pre_rent="";
String pre_pre_pre_rent="";
String pre_days="";
String pre_pre_days="";
String pre_pre_pre_days="";
String pre_punish="";
String pre_pre_punish="";
String pre_pre_pre_punish="";

String nominalprice="";
String deduRent="";
String deduList="";
String deduList_money="";//�ɵֿ۱�֤�𣺽��׽ṹ�еĳ���ͻ��Ŀɵֿ۱�֤����ʣ�ౣ֤��֮�е�С��
String show_flag="";//�Ƿ���ʾ�������ĵ��к��ֲ���:1����ʾ������ʾ
//String filepath="d:/������ϵͳ����֪ͨ������96.jpg";
String filepath="http://192.168.1.21:9080/sealA4.jpg";

String notice_contact="";
String notice_content="";
String notice_explanation="";
String notice_note="";









//---------------------------
%>

<!--��ҳ���ƿ�ʼ-->


<script language="VBScript">
'obj.SetBackGround ("<%=filepath%>") '����Ʊ�ݱ���
obj.Init
obj.PageSize = 3	'A4
obj.SetTextColor RGB(0, 0, 0)
obj.SetOutline 0, 0, 2, 0, RGB(0, 0, 0)

obj.LeftMargin=107
obj.TopMargin=16

obj.SetFont "����", 1
obj.SetFontSize 15
obj.SetFontStyle 0,1,0

obj.DrawObject "", "http://192.168.1.21:9080/sealA4.jpg", 1, "", 5, "1,2,3,4", "", "false,1"

<% if(client_address.length()<=30){%>
obj.DrawObject "<%=client_postcode%>", "", 0, "", 1, "1,2,3,4", "0,84", "false,2"
obj.DrawObject "<%=client_address%>", "", 0, "", 1, "1,2,3,4", "0,108", "false,2"
<%}else{%>
obj.DrawObject "<%=client_postcode%>", "", 0, "", 1, "1,2,3,4", "0,60", "false,2"

obj.DrawObject "<%=client_address1%>", "", 0, "", 1, "1,2,3,4", "0,84", "false,2"
obj.DrawObject "<%=client_address2%>", "", 0, "", 1, "1,2,3,4", "0,108", "false,2"
<%}%>


obj.DrawObject "<%=cust_name%>", "", 0, "", 1, "1,2,3,4", "0,134", "false,2"
obj.DrawObject "<%=client_linkman%>", "", 0, "", 1, "1,2,3,4", "0,158", "false,2"

obj.DrawObject "----------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "0,176", "false,2"
obj.DrawObject "----------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "3,176", "false,2"

obj.SetFontSize 28
obj.SetFontStyle 0,1,1
obj.DrawObject "�� �� ͨ ֪ ��", "", 0, "", 1, "1,2,3,4", "186,190", "false,2"


obj.SetFontSize 15
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=cust_name%>��", "", 0, "", 1, "1,2,3,4", "0,248", "false,2"

obj.LineInterval=1
obj.SetFontSize 13
obj.SetFontStyle 0,0,0
obj.DrawObject "���ݹ���˫��ǩ���ı��Ϊ <%=contract_id%> �����޺�ͬ�涨��", "", 0, "", 1, "1,2,3,4", "28,288", "false,2"

obj.DrawObject "��1����Ӧ��", "", 0, "", 1, "1,2,3,4", "0,310", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=curr_plan_date%>��<%=curr_plan_date%>��<%=curr_plan_date%>��", "", 0, "", 1, "1,2,3,4", "92,310", "false,2"

obj.SetFontStyle 0,0,0
obj.DrawObject "��Ӧ�����գ���ǰ���ҹ�˾�˻����뵱�ڿ��", "", 0, "", 1, "1,2,3,4", "192,310", "false,2"
obj.DrawObject "��<%=curr_rent_list%>����� ���Ϊ ��<%=curr_rent%>Ԫ", "", 0, "", 1, "1,2,3,4", "28,330", "false,2"
<%if(!line_str1.equals("")||!line_str3.equals("")||!line_str5.equals("")){%>
obj.DrawObject "��2������������˾֧���������ڿ��", "", 0, "", 1, "1,2,3,4", "0,370", "false,2"
<%}%>
<%if(!line_str1.equals("")){%>
obj.DrawObject "<%=line_str1%>", "", 0, "", 1, "1,2,3,4", "28,390", "false,2"
<%}%>
<%if(!line_str3.equals("")){%>
obj.DrawObject "<%=line_str3%>", "", 0, "", 1, "1,2,3,4", "28,410", "false,2"
<%}%>
<%if(!line_str5.equals("")){%>
obj.DrawObject "<%=line_str5%>", "", 0, "", 1, "1,2,3,4", "28,432", "false,2"
<%}%>



<%if(show_flag.equals("0")){%>
obj.DrawObject "��3����֧��", "", 0, "", 1, "1,2,3,4", "0,472", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "���������ۣ�<%=nominalprice%>Ԫ", "", 0, "", 1, "1,2,3,4", "70,472", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "������Լ��֧������ǰ��", "", 0, "", 1, "1,2,3,4", "212,472", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "��֤���վ�", "", 0, "", 1, "1,2,3,4", "358,472", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "�Ļ����ҹ�˾��", "", 0, "", 1, "1,2,3,4", "428,472", "false,2"
obj.DrawObject "�Ա�����豸����Ȩת��������", "", 0, "", 1, "1,2,3,4", "0,492", "false,2"
<%}%>

<%if(show_flag.equals("0")){%>
obj.SetFontStyle 0,1,0
obj.DrawObject "��ͬ�����ϼƣ�", "", 0, "", 1, "1,2,3,4", "0,532", "false,2"
obj.SetFontStyle 0,1,1
obj.DrawObject "��<%=total_money%>Ԫ  ", "", 0, "", 1, "1,2,3,4", "122,532", "false,2"
obj.SetFontStyle 0,0,0
<%}%>



'obj.DrawObject "", "", 0, "562,550", 1, "1,2,3,4", "", "true,1"
'obj.DrawObject "", "", 0, "564,124", 1, "", "", "true,1"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-8,562", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-5,562", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-8,726", "false,2"
obj.DrawObject "---------------------------------------------------------------------------------", "", 0, "", 1, "1,2,3,4", "-5,726", "false,2"

obj.DrawObject "˵����", "", 0, "", 1, "1,2,3,4", "0,574", "false,2"
obj.DrawObject "1��	�����޺�ͬ�������涨�����������������밴��8%s%֧���Ӹ���Ϣ��", "", 0, "", 1, "1,2,3,4", "0,594", "false,2"
obj.DrawObject "2��	������֪ͨ����������������������ʼ������ӡ�ռǡ�", "", 0, "", 1, "1,2,3,4", "0,614", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "3��	����ȫ��֧����֪ͨ�����еĿ������Ա�֪ͨ�飻", "", 0, "", 1, "1,2,3,4", "0,634", "false,2"
obj.DrawObject "���Ѳ���֧������δ֧�����밴��֪ͨ������ʾ�����ݰ�ʱ���֧�����еĿ��", "", 0, "", 1, "1,2,3,4", "0,654", "false,2"
obj.SetFontStyle 0,0,0

<%if(show_flag.equals("0")){%>
obj.DrawObject "4��	�����޺�ͬԼ����", "", 0, "", 1, "1,2,3,4", "0,674", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=end_date%>������", "", 0, "", 1, "1,2,3,4", "136,674", "false,2"
obj.SetFontStyle 0,0,0
<%}%>

obj.DrawObject "��ܰ��ʾ���Ӽ��������ǻ������Ϊ���ṩÿ��Ӧ�����ֻ��������ѷ����������ʣ�����", "", 0, "", 1, "1,2,3,4", "0,694", "false,2"
obj.DrawObject "��˾�ͷ���ϵ����ϵ�绰��800-820-6213", "", 0, "", 1, "1,2,3,4", "0,714", "false,2"

obj.SetFontStyle 0,1,0
obj.DrawObject "���Ž����������޹�˾", "", 0, "", 1, "1,2,3,4", "438,756", "false,2"
obj.DrawObject "<%=bad_date%>��<%=bad_date%>��<%=bad_date%>��", "", 0, "", 1, "1,2,3,4", "466,778", "false,2"

obj.DrawObject "........................................................................", "", 0, "", 1, "1,2,3,4", "0,800", "false,2"

obj.SetFontStyle 0,0,0
obj.DrawObject "������", "", 0, "", 1, "1,2,3,4", "0,816", "false,2"
obj.DrawObject "�㣺<%=lessor_name%> <%=bank_name%>��<%=lease_acc_number%>", "", 0, "", 1, "1,2,3,4", "0,838", "false,2"

obj.DrawObject "������� ��<%=curr_rent%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,859", "false,2"
obj.DrawObject "���ڷ�Ϣ��<%=c_punish%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,878", "false,2"
obj.DrawObject "���ڿ��� ��<%=total_money_bad%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,897", "false,2"

obj.SetFontStyle 0,0,1
<%if(show_flag.equals("0")){%>
obj.DrawObject "������ ��<%=nominalprice%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,918", "false,2"
<%}else{%>
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "26,918", "false,2"
<%}%>

obj.SetFontStyle 0,1,0
obj.DrawObject "�ϼƣ�<%=total_money%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,938", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "���� RMB  ��            Ԫ", "", 0, "", 1, "1,2,3,4", "0,959", "false,2"
obj.DrawObject "��ע�� ֧����ͬ <%=contract_id%> ���ȡ�", "", 0, "", 1, "1,2,3,4", "0,979", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "����Ϣ��Ҫ����������룬лл����", "", 0, "", 1, "1,2,3,4", "260,979", "false,2"

obj.SetFontSize 8
obj.DrawObject "Unitrust Finance & leasing Corporation", "", 0, "", 1, "1,2,3,4", "450,1000", "false,2"

obj.DrawObject "", "", 2, "", 5, "1,2,3,4", "", "false,1"
obj.DrawObject "", "", 0, "", 5, "1,2,3,4", "", "true,3"
</script>


<script language="VBScript">
obj.PrintPreview
</script>
<%
db.close();
db1.close();
%>



</body>
</html>

