<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.container.*" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 交易结构及租金处理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
//当前登陆人
String czy = (String) session.getAttribute("czyid");

//基础变量
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";
String sqlstr = "";
String uid="";

//jsp变量
String proj_id= getStr(request.getParameter("proj_id"));
String measure_id= getStr(request.getParameter("doc_id"));

//excel对应字段名称

//proj_id,mesure_id,rent_list,plan_status,plan_date,
//rent,year_rate,corpus_market,interest_market,corpus_overage_market

String rent_list = "";//期项
String plan_status = "未回笼"; //状态
String plan_date = ""; //计划日期
String rent = "";//租金
String year_rate = ""; //年利率
String corpus_market = "";//本金
String interest_market = "";//利息
String corpus_overage_market = "";//本金余额


//上传excel参数
String message = "";

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\bgzzj_excel\\"+datestr+"\\";
fileBean.setObjectPath( allpath );
//设定上传附件总体大小限制 
fileBean.setSize(8*1024*1024);

//设定上传附件文件类型
fileBean.setSuffix(".xls");

//设定上传用户ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   uid=czy.substring(7);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
String sObjectPath = fileBean.getObjectPath();
//先删除该项目的租金计划临时表数据
sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+measure_id+"'";
System.out.println("上传不规则租金前，删除租金计划临时表数据："+proj_id);
db.executeUpdate(sqlstr);

int dateflag=0;
int iallcol= 0;

if(dateflag<1){
   if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				iallcol = obj.length;
				System.out.println("第一个sheet有："+iallcol+"行");
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					
					LogWriter.logDebug(request, "第"+row+"行，===第2列值："+objrow[3]+"共"+objrow.length+"列");
					System.out.println("第"+row+"行，===第1列值："+objrow[0]+"共"+objrow.length+"列");
					
					//proj_id,mesure_id,rent_list,plan_status,plan_date,
					//rent,year_rate,corpus_market,interest_market,corpus_overage_market
					
					rent_list = objrow[0];
					plan_date = objrow[1];
					rent = objrow[2];
					year_rate = objrow[3];
					corpus_market = objrow[4];
					interest_market = objrow[5];
					corpus_overage_market = objrow[6];
					
					System.out.println("上传不规则租金，期次"+rent_list+" 金额："+rent);
					LogWriter.logDebug(request, "上传不规则租金，期次"+rent_list+" 金额："+rent);
					//判断如果付款账号没有数据则跳过
					if("".equals(rent_list)){
						iallcol--;
						System.out.println("第"+row+"行，===第1列值："+objrow[0]+"共"+objrow.length+"列，数据非法");
						continue;
					}
					//期次 12.0 - 12	
					if(rent_list.indexOf(".0")!=-1){//0.0的处理
						rent_list = rent_list.substring(0, rent_list.lastIndexOf(".0"));
					}	
					
					//插入数据 - 项目租金计划临时表
					sqlstr = "insert into fund_rent_plan_proj_temp (proj_id,measure_id,rent_list,plan_status,plan_date,";
					sqlstr +=" rent,year_rate,corpus_market,interest_market,corpus_overage_market,creator,create_date)values (";
					sqlstr += "'"+proj_id+"'";
					sqlstr += ",'"+measure_id+"'";
					sqlstr += ",'"+rent_list+"'";
					sqlstr += ",'"+plan_status+"'";
					sqlstr += ",'"+plan_date+"'";
					sqlstr += ",'"+rent+"'";
					sqlstr += ",'"+year_rate+"'";
					sqlstr += ",'"+corpus_market+"'";
					sqlstr += ",'"+interest_market+"'";
					sqlstr += ",'"+corpus_overage_market+"'";
					sqlstr += ",'"+czy+"'";
					sqlstr += ",'"+datestr+"')";
					System.out.println("KKKKKKKKKKKK"+sqlstr);
					LogWriter.logDebug(request, "插入不规则租金数据："+sqlstr.substring(0,15));
					db.executeUpdate(sqlstr);
				} 
				//日志操作
				String sqlLog = LogWriter.getSqlIntoDB(request, "不规则租金", "数据导入", "项目："+proj_id+" 导入不规则租金数据数量"+iallcol, sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
   }
}

db.close();

if(dateflag<1){
	if(bflag && message.equals("")){
%>
<script type="text/javascript">
	window.close();
	window.alert("上传项目<%=proj_id %>不规则租金成功！");
	window.location="bgz_zjcs_div_list.jsp";
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.alert("上传项目<%=proj_id %>不规则租金数据,execl文件数据格式错误！");
	window.location="bgz_zj_upload.jsp";
</script>
<%
}}%>
</body></html>
