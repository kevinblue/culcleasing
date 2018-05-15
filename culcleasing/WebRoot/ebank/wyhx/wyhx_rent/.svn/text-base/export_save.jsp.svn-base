<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.*"%> 
<%@ page import="java.io.*"%>   
<%@ page import="java.text.DecimalFormat"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="java.math.BigDecimal" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>
                                                       
<%
String dqczy = (String) session.getAttribute("czyid");
DecimalFormat format = new DecimalFormat("#.00") ; 
String curr_date = getSystemDate(0);
String shdm = "305440359609931";//商户代码
String choiceType = getStr( request.getParameter("choiceType") );//判断是否全部操作
String sqldata = getStr( request.getParameter("sqldata") );//主键字段

String sqlstr = "";
ResultSet rs = null;

String i_row="0";
String card_id = "";
String cust_name = "";
String account = "";
String show_amt = "";
String memo = "";
String memo_projId = "";
String bank="";
double totalMoney = 0d;
int amount = 0;

List l_i_row = new ArrayList();
List l_card_id = new ArrayList();
List l_cust_name = new ArrayList();
List l_account = new ArrayList();
List l_show_amt = new ArrayList();
List l_memo = new ArrayList();
List l_memo_projId = new ArrayList();
List l_bank = new ArrayList();

String bank_name = request.getParameter("hxBank");

System.out.println("sqlstr000===========wyhx======================="+sqlstr);

if( choiceType!=null && !"".equals(choiceType) && "alldata".equals(choiceType) ){//全选
	sqlstr = getStr(request.getParameter("expsqlstr"));
}else{
	sqlstr = "select item_id as memo,proj_id,rent_list,isnull(costmoney,0) as costmoney,";
	sqlstr +=" fee_type,exp_state,khmc,account_name,account,bank,card_id,plan_date,proj_id as memo_projId,cust_type from vi_report_rent_invoice where item_id in ("+sqldata+")";	
}
rs=db.executeQuery(sqlstr);
String sql_upd="";

while(rs.next()){
		i_row=String.valueOf(Integer.parseInt(i_row)+1);
		card_id=getDBStr( rs.getString("card_id") );
		account=getDBStr( rs.getString("account") );
		cust_name=getDBStr( rs.getString("account_name") );
		bank = getDBStr( rs.getString("bank") );
		show_amt=formatNumberDoubleTwo( rs.getString("costmoney") );
		memo=getDBStr( rs.getString("memo") );
		memo_projId = getDBStr( rs.getString("memo_projId") );
	
		amount++;//总笔数
		totalMoney+=Double.parseDouble(show_amt);//总金额
	
	//构造项目的export_flag字段修改的字符串
		if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//以建行模板导出
			sql_upd+="  update fund_rent_plan set export_flag='1' where id in(select case when CHARINDEX('_','"+memo+"')>0 then substring('"+memo+"',0,CHARINDEX('_','"+memo+"')) else '"+memo+"' end)  ";
		}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){//以民生模板导出
			sql_upd+="  update fund_rent_plan set export_flag='1' where id in(select case when CHARINDEX('_','"+memo+"')>0 then substring('"+memo+"',0,CHARINDEX('_','"+memo+"')) else '"+memo+"' end)  ";
		}
		l_i_row.add(i_row);
		l_card_id.add(card_id);
		l_account.add(account);
		l_cust_name.add(cust_name);
		l_bank.add(bank);
		l_show_amt.add(show_amt);
		l_memo.add(memo);
		l_memo_projId.add(memo_projId);
	}
	rs.close();

//导出的项目不能再导出
System.out.println("sqlstr_1=============="+sql_upd);
//db.executeUpdate(sqlstr_1);
db.executeUpdate(sql_upd);

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

System.out.println("no===="+no+"=====bank_name:"+bank_name);
//====================导出excel或txt==========================
//判断核销银行
//导出excel文件名称设置

String partFileName = "";
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//以建行模板导出
	partFileName=curr_date.replaceAll("-","")+no;
	response.reset();
	response.setContentType("application/x-msexcel;charset=gbk");
	response.setHeader("Content-disposition","attachment; filename=rent"+partFileName+".xls");
}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){
	partFileName="DK"+shdm+"_"+curr_date.replaceAll("-","").substring(2)+"_"+no;
	//new String(partFileName.getBytes(), "gbk")+ 
}

//导出excel数据的排版显示
if( bank_name!=null && !"".equals(bank_name) && "jsBank".equals(bank_name.trim()) ){//以建行模板导出
	//------------取数据-----
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet templateSheet = wb.createSheet("sheet1"); 

	HSSFRow templateRow;
	HSSFCell cell;
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

	// 序号 付款账号 付款人姓名 金额 备注1 备注2
	List list = new ArrayList();
	templateSheet.setColumnWidth((short)0,(short)1000);
	templateSheet.setColumnWidth((short)1,(short)6000);
	templateSheet.setColumnWidth((short)2,(short)3000);
	templateSheet.setColumnWidth((short)3,(short)3000);
	templateSheet.setColumnWidth((short)4,(short)5000);
	templateSheet.setColumnWidth((short)5,(short)5000);

	for(int i=0;i<l_i_row.size();i++){
		templateRow=templateSheet.createRow(i);
		list.clear();
		list.add(l_i_row.get(i));
		list.add(l_account.get(i));
		list.add(l_cust_name.get(i));
		list.add(l_show_amt.get(i));
		list.add(l_memo.get(i));
		list.add(l_memo_projId.get(i));
		for(int ii=0;ii<list.size();ii++){
			cell=templateRow.createCell((short)ii);
			cell.setCellValue((String)list.get(ii));
		}
	}
	OutputStream os = response.getOutputStream();
	wb.write(os);
	os.close();

}else if( bank_name!=null && !"".equals(bank_name) && "msBank".equals(bank_name.trim()) ){//以民生银行模板导出
	System.out.println("bankname-:"+bank_name+"size"+l_i_row.size());

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
		String me_projId = "";//项目编号
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
			System.out.println(sqlstr+"====result"+counProjNo);

			while(counProjNo.length()<8){//补0操作
				counProjNo="0"+counProjNo;
			}

			mxxh = ""+shdm.substring(3,7)+shdm.substring(11,shdm.length())+counProjNo+"";
			money = l_show_amt.get(i)+"";
			khyh = l_bank.get(i)+"";
			kh = l_account.get(i)+"";
			khmc = l_cust_name.get(i)+"";
			priId = l_memo.get(i)+"";
			sfz = l_card_id.get(i)+"";
			me_projId = l_memo_projId.get(i)+"";
			bodyContent = mxxh+"|156|"+format.format(Double.parseDouble(money))+"||"+khyh+"|"+kh+"|"+khmc+"|租金扣划:"+priId+"|01|"+sfz+"|"+curr_date.replaceAll("-","").substring(2)+"||"+me_projId+"|";
			
			pw.println(bodyContent);
		} 
    }catch(Exception e) 
    {
    }finally
    {
		pw.close();
    }
}

out.clear();
out = pageContext.pushBody();

rs.close();
db.close();
%>
<script>
window.close();
window.opener.location.reload(true);
</script>