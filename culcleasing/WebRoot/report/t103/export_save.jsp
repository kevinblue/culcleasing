<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.net.URL,java.util.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="org.apache.poi.hssf.util.*"%> 
<%@ page import="org.apache.poi.poifs.filesystem.*"%>  
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.io.*"%>   
<%@ page import="java.sql.*" %>  
<%@ page import="dbconn.*" %>    
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="com.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.tenwa.util.ExportExcel"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<%
int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2));
String curr_date = getSystemDate(3);

ResultSet rs = null;
ResultSet rs1 = null;
//=======���������======
String sqlstr="";
String partSql = "";
String agent_id = "";
String zzsmc = "";

List titleList=null;
List dataList=new ArrayList();
//-�ۿ����-
int rent_yk = 0;//���Ӧ��
int rent_succ = 0;//���ۿ�ɹ�
int rent_fail = 0;//���ۿ�ʧ��
double rent_fail_ratio = 0f;//���ۿ�ʧ�ܱ���

DecimalFormat df=new DecimalFormat("#.##");
//----------------

//=======���������======
int startIndex=1;
sqlstr = " select distinct dld,agent_id,manufacturer from v_zzs_dld_stat ";
sqlstr+= " where proj_id in( ";
sqlstr+= " select proj_id from fund_rent_plan ";
sqlstr+= " where year(plan_date)="+year+" and month(plan_date)="+month+" ";
sqlstr+= " and day(plan_date)=5 and rent_list<>1 ";
sqlstr+= " )union ";
sqlstr+= " select '' as dld,'0' as agent_id,zzsmc as manufacturer from jb_zlwjzzs ";
sqlstr+= " order by manufacturer ";
rs=db.executeQuery(sqlstr);
  while( rs.next() ) {
	agent_id = getDBStr(rs.getString("agent_id"));
	zzsmc = getDBStr(rs.getString("manufacturer"));
	List OneRow =new ArrayList();
	List OtherRow=new ArrayList();
	
	 if("0".equals(agent_id)){ 
		//<!-- ������С�� -->
		OneRow.add(zzsmc+"�ϼ�");
	}else { 
		OneRow.add(getDBStr(rs.getString("dld")));
	} 
}

//------------������-----------
titleList=new ArrayList();
titleList.add("���");
titleList.add("������");
titleList.add("��������");
titleList.add("5��Ӧ��");
titleList.add("5�ճɹ�");
titleList.add("5��ʧ��");
titleList.add("5��ʧ����");

titleList.add("10�ճɹ�");
titleList.add("10��ʧ��");
titleList.add("10��ʧ����");

titleList.add("15�ճɹ�");
titleList.add("15��ʧ��");
titleList.add("15��ʧ����");

//============start��ʼ����excel����=================
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet("sheet1"); 

//����ExportExcelʵ��
ExportExcel exportExcel = new ExportExcel(wb, sheet);

// ����ñ��������
int number = titleList.size();

//���������ж����п�(ʵ��Ӧ���Լ���������)
for (int i = 0; i < number; i++) {
	sheet.setColumnWidth((short)i, (short)3000);
}

//��������ͷ��
exportExcel.createNormalHead("5�������ۿ���ͳ��", number);
//���õڶ���
 exportExcel.createTwoRow("�������ڣ�"+getSystemDate(0), number);
//������ͷ
exportExcel.createColumHeader(titleList);

// ####################################start#########################################
//����cell����
int rowIndex = 1;
int rowStart = 3;
HSSFRow row = null;
for(int i=0;i<dataList.size();i++){
	row = sheet.createRow((short) rowStart);
	//�����
	exportExcel.createCell(wb, row, (short) 0,
							HSSFCellStyle.ALIGN_CENTER_SELECTION, 
							String.valueOf(rowIndex));
	rowIndex++;

	List dataRow = (List)dataList.get(i);
	for(int j=0;j<dataRow.size();j++){
		if(j==0||j==1||j==5||j==8||j==11){
			exportExcel.createCell(wb, row, (short)(j+1),
					HSSFCellStyle.ALIGN_CENTER_SELECTION, 
					String.valueOf(dataRow.get(j)+""));
		}else{
			exportExcel.createNumberCell(wb, row, (short)(j+1),
					HSSFCellStyle.ALIGN_CENTER_SELECTION, 
					String.valueOf(dataRow.get(j)+""));
		}
			
		
	}
	rowStart++;
}

//����excel
exportExcel.outputExcel("5r_wykk__"+curr_date, wb, response, pageContext);


out.clear();
out = pageContext.pushBody();

db.close();
db1.close();
%>
