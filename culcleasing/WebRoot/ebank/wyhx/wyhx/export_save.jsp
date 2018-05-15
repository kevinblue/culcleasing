<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="java.io.*"%>  
<%@ page import="java.text.DecimalFormat"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="java.math.BigDecimal" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>
                                             
<html>                             
<head>                                          
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
DecimalFormat format = new DecimalFormat("#.00") ; 
String curr_date = getSystemDate(0);
String shdm = "305440359609931";//�̻�����

String sqlstr;
ResultSet rs;
sqlstr = getStr(request.getParameter("expsqlstr"));

String card_id="";
String cust_name="";
String account="";
String plan_money="";
String plan_money1="";
String memo="";
String i_row="0";
String bank="";
double totalMoney = 0;
int amount = 0;

List l_card_id = new ArrayList();
List l_cust_name = new ArrayList();
List l_account = new ArrayList();
List l_plan_money = new ArrayList();
List l_memo = new ArrayList();
List l_i_row = new ArrayList();
List l_bank = new ArrayList();

rs=db.executeQuery(sqlstr);
System.out.println("sql===="+sqlstr);
while(rs.next()){
	i_row=String.valueOf(Integer.parseInt(i_row)+1);
	cust_name=getDBStr( rs.getString("cust_name") );
	account=getDBStr( rs.getString("account") );
	plan_money1=getDBStr( rs.getString("plan_money") );
	int index=plan_money1.indexOf(".");
	plan_money=plan_money1.substring(0,index+3);
	memo=getDBStr( rs.getString("memo") );
	bank=getDBStr( rs.getString("bank") );
	card_id = getDBStr( rs.getString("card_id") );

	l_i_row.add(i_row);
	l_card_id.add(card_id);
	l_cust_name.add(cust_name);
	l_account.add(account);
	l_plan_money.add(plan_money);
	l_memo.add(memo);
	l_bank.add(bank);

	amount++;//�ܱ���
	totalMoney+=Double.parseDouble(plan_money);//�ܽ��
}
//rs.close();

//��������Ŀ�����ٵ���
String sqlstr_1="update fund_fund_charge_plan set export_flag='1' where proj_id in (select memo from ("+sqlstr+")a)";
db.executeUpdate(sqlstr_1);

//ȡ�õ�����ˮ��
String no="";
sqlstr="select count(*)+1 as no from export_no where export_type='�����ۿ�' and export_date='"+curr_date+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	no=getDBStr( rs.getString("no") );
}rs.close();
if(no.length()==1){
	no="0"+no;
}
sqlstr="insert into export_no select '�����ۿ�','"+curr_date+"','"+no+"'";
db.executeUpdate(sqlstr);

//====================����excel��txt==========================
//�жϺ�������
//����excel�ļ���������
String bank_name = request.getParameter("hxBank");
String partFileName = "";
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//�Խ���ģ�嵼��
	partFileName=curr_date.replaceAll("-","")+no;
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=headpayment"+partFileName+".xls");
}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){
	partFileName="DK"+shdm+"_"+curr_date.replaceAll("-","").substring(2)+"_"+no;
}
//����excel���ݵ��Ű���ʾ
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//�Խ���ģ�嵼��
	//------------ȡ����-----
	HSSFRow templateRow;
	HSSFCell cell;
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet templateSheet = wb.createSheet("sheet1"); 
	//��ʽ,��ʽ//begining
	HSSFCellStyle cellStyle = null;
	HSSFDataFormat df = null;
	HSSFFont font = null;
	cellStyle=wb.createCellStyle();
	df=wb.createDataFormat();
	font=wb.createFont();

	cellStyle.setDataFormat(df.getFormat("#,##0.00"));
	font.setFontHeightInPoints((short)9); 
	font.setFontName("����"); 

	// ��� �����˺� ���������� ��� ��ע1
	List list = new ArrayList();
	templateSheet.setColumnWidth((short)0,(short)1000);
	templateSheet.setColumnWidth((short)1,(short)6000);
	templateSheet.setColumnWidth((short)2,(short)3000);
	templateSheet.setColumnWidth((short)3,(short)3000);
	templateSheet.setColumnWidth((short)4,(short)5000);

	for(int i=0;i<l_i_row.size();i++){
		templateRow=templateSheet.createRow(i);
		list.clear();
		list.add(l_i_row.get(i));
		list.add(l_account.get(i));
		list.add(l_cust_name.get(i));
		list.add(l_plan_money.get(i));
		list.add(l_memo.get(i));
		for(int ii=0;ii<list.size();ii++){
			cell=templateRow.createCell((short)ii);
			if(ii==3){
				cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC); 
				cell.setCellStyle(cellStyle);
			}
			cell.setCellValue((String)list.get(ii));
		}
	}
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();
}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){//����������ģ�嵼��
    OutputStream os =null;
	PrintWriter pw = null;
    // д��������
    try
    {
		//os = response.getOutputStream();
		response.reset();
		response.setContentType("text/plain;charset=gbk");//application/OCTET-STREAM
		response.setHeader("Content-disposition","attachment; filename="+partFileName+".txt");
		pw = response.getWriter();
				
		//===�ļ�ͷ===
		//�̻�����|����|0||����|�ܽ��|�ܱ���||
		String titleStr = shdm+"|"+no+"|0||"+curr_date.replaceAll("-","")+"|"+format.format(totalMoney)+"|"+amount+"||";
		pw.print(titleStr);
		//����
		pw.println();
		//===�ļ���===
		String bodyContent = "";
		String mxxh = "";//��ϸ���
		String rmbdyh = "";//����Ҷ�Ӧ��
		String money = "";//���ʽ��
		String khyh = "";//��������
		String kh = "";//����
		String khmc = "";//����
		String priId = "";//������־�ֶ�
		String sfz = "";//���֤
		for(int i=0;i<l_i_row.size();i++){
			bodyContent = "";

			//ȡ�õ�����ˮ��
			String counProjNo="";
			sqlstr="select count(*)+1 as no from export_no where export_type='�������' and export_date='"+curr_date+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				counProjNo=getDBStr( rs.getString("no") );
			}rs.close();
			sqlstr="insert into export_no select '�������','"+curr_date+"','"+counProjNo+"'";
			db.executeUpdate(sqlstr);

			while(counProjNo.length()<8){//��0����
				counProjNo="0"+counProjNo;
			}
			
			mxxh = ""+shdm.substring(3,7)+shdm.substring(11,shdm.length())+counProjNo+"";
			money = l_plan_money.get(i)+"";
			khyh = l_bank.get(i)+"";
			kh = l_account.get(i)+"";
			khmc = l_cust_name.get(i)+"";
			priId = l_memo.get(i)+"";
			sfz = l_card_id.get(i)+"";
			bodyContent = mxxh+"|156|"+format.format(Double.parseDouble(money))+"||"+khyh+"|"+kh+"|"+khmc+"|���ڸ���:"+priId+"|01|"+sfz+"|"+curr_date.replaceAll("-","").substring(2)+"|||";

			pw.println(bodyContent);
		} 
    }	
    catch(Exception e) 
    {
    }
    finally
    {
		//os.flush();
		//os.close();
		pw.close();
    }
}
rs.close();
db.close();
if(true){
%>
<script>
	window.close();
	opener.location.reload(true);
</script>
<%}%>
</body></html>
