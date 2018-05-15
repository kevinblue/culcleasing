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
String shdm = "305440359609931";//商户代码

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

	amount++;//总笔数
	totalMoney+=Double.parseDouble(plan_money);//总金额
}
//rs.close();

//导出的项目不能再导出
String sqlstr_1="update fund_fund_charge_plan set export_flag='1' where proj_id in (select memo from ("+sqlstr+")a)";
db.executeUpdate(sqlstr_1);

//取得导出流水号
String no="";
sqlstr="select count(*)+1 as no from export_no where export_type='网银扣款' and export_date='"+curr_date+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	no=getDBStr( rs.getString("no") );
}rs.close();
if(no.length()==1){
	no="0"+no;
}
sqlstr="insert into export_no select '网银扣款','"+curr_date+"','"+no+"'";
db.executeUpdate(sqlstr);

//====================导出excel或txt==========================
//判断核销银行
//导出excel文件名称设置
String bank_name = request.getParameter("hxBank");
String partFileName = "";
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//以建行模板导出
	partFileName=curr_date.replaceAll("-","")+no;
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=headpayment"+partFileName+".xls");
}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){
	partFileName="DK"+shdm+"_"+curr_date.replaceAll("-","").substring(2)+"_"+no;
}
//导出excel数据的排版显示
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//以建行模板导出
	//------------取数据-----
	HSSFRow templateRow;
	HSSFCell cell;
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet templateSheet = wb.createSheet("sheet1"); 
	//样式,格式//begining
	HSSFCellStyle cellStyle = null;
	HSSFDataFormat df = null;
	HSSFFont font = null;
	cellStyle=wb.createCellStyle();
	df=wb.createDataFormat();
	font=wb.createFont();

	cellStyle.setDataFormat(df.getFormat("#,##0.00"));
	font.setFontHeightInPoints((short)9); 
	font.setFontName("宋体"); 

	// 序号 付款账号 付款人姓名 金额 备注1
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
}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){//以民生银行模板导出
    OutputStream os =null;
	PrintWriter pw = null;
    // 写缓冲区：
    try
    {
		//os = response.getOutputStream();
		response.reset();
		response.setContentType("text/plain;charset=gbk");//application/OCTET-STREAM
		response.setHeader("Content-disposition","attachment; filename="+partFileName+".txt");
		pw = response.getWriter();
				
		//===文件头===
		//商户代码|批次|0||日期|总金额|总笔数||
		String titleStr = shdm+"|"+no+"|0||"+curr_date.replaceAll("-","")+"|"+format.format(totalMoney)+"|"+amount+"||";
		pw.print(titleStr);
		//换行
		pw.println();
		//===文件体===
		String bodyContent = "";
		String mxxh = "";//明细序号
		String rmbdyh = "";//人民币对应号
		String money = "";//单笔金额
		String khyh = "";//开户银行
		String kh = "";//卡号
		String khmc = "";//姓名
		String priId = "";//主键标志字段
		String sfz = "";//身份证
		for(int i=0;i<l_i_row.size();i++){
			bodyContent = "";

			//取得导出流水号
			String counProjNo="";
			sqlstr="select count(*)+1 as no from export_no where export_type='网银编号' and export_date='"+curr_date+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				counProjNo=getDBStr( rs.getString("no") );
			}rs.close();
			sqlstr="insert into export_no select '网银编号','"+curr_date+"','"+counProjNo+"'";
			db.executeUpdate(sqlstr);

			while(counProjNo.length()<8){//补0操作
				counProjNo="0"+counProjNo;
			}
			
			mxxh = ""+shdm.substring(3,7)+shdm.substring(11,shdm.length())+counProjNo+"";
			money = l_plan_money.get(i)+"";
			khyh = l_bank.get(i)+"";
			kh = l_account.get(i)+"";
			khmc = l_cust_name.get(i)+"";
			priId = l_memo.get(i)+"";
			sfz = l_card_id.get(i)+"";
			bodyContent = mxxh+"|156|"+format.format(Double.parseDouble(money))+"||"+khyh+"|"+kh+"|"+khmc+"|首期付款:"+priId+"|01|"+sfz+"|"+curr_date.replaceAll("-","").substring(2)+"|||";

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
