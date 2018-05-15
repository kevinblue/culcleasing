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
//=======定义变量区======
String sqlstr="";
String partSql = "";
String agent_id = "";
String zzsmc = "";

List titleList=null;
List dataList=new ArrayList();
//-扣款笔数-
int rent_yk = 0;//租金应扣
int rent_succ = 0;//租金扣款成功
int rent_fail = 0;//租金扣款失败
double rent_fail_ratio = 0f;//租金扣款失败比率

DecimalFormat df=new DecimalFormat("#.##");
//----------------

//=======定义变量区======
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
		//<!-- 制造商小计 -->
		OneRow.add(zzsmc+"合计");
	}else { 
		OneRow.add(getDBStr(rs.getString("dld")));
	} 
}

//------------标题栏-----------
titleList=new ArrayList();
titleList.add("序号");
titleList.add("代理商");
titleList.add("款项内容");
titleList.add("5日应扣");
titleList.add("5日成功");
titleList.add("5日失败");
titleList.add("5日失败率");

titleList.add("10日成功");
titleList.add("10日失败");
titleList.add("10日失败率");

titleList.add("15日成功");
titleList.add("15日失败");
titleList.add("15日失败率");

//============start开始导出excel设置=================
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet("sheet1"); 

//创建ExportExcel实例
ExportExcel exportExcel = new ExportExcel(wb, sheet);

// 计算该报表的列数
int number = titleList.size();

//给工作表列定义列宽(实际应用自己更改列数)
for (int i = 0; i < number; i++) {
	sheet.setColumnWidth((short)i, (short)3000);
}

//创建报表头部
exportExcel.createNormalHead("5日网银扣款结果统计", number);
//设置第二行
 exportExcel.createTwoRow("导出日期："+getSystemDate(0), number);
//设置列头
exportExcel.createColumHeader(titleList);

// ####################################start#########################################
//设置cell数据
int rowIndex = 1;
int rowStart = 3;
HSSFRow row = null;
for(int i=0;i<dataList.size();i++){
	row = sheet.createRow((short) rowStart);
	//序号列
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

//导出excel
exportExcel.outputExcel("5r_wykk__"+curr_date, wb, response, pageContext);


out.clear();
out = pageContext.pushBody();

db.close();
db1.close();
%>
