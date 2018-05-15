<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.regex.Pattern"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//还款计划上传保存
//当前登陆人
String czy = (String) session.getAttribute("czyid");

//基础变量
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String sqlstr = "";
String uid="";

//excel对应字段名称--预测现金流
String yc_month = "";//月份
String yc_hire_date = ""; //结算日
String yc_money = ""; //现金流

//excel对应字段名称--保底现金流
String bd_month = "";//月份
String bd_hire_date = ""; //结算日
String bd_money = ""; //现金流

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\cash_excel\\"+datestr+"\\";
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

//表单非文件类型参数
String proj_id = fileBean.getFieldValue("proj_id");
String doc_id = fileBean.getFieldValue("doc_id");
String type = fileBean.getFieldValue("type");
if(type!=null && !type.equals("") && type.equals("yc")){
	//1.先清空原数据
	sqlstr = "Delete from fund_cash_medi_yc_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "读Excel前删除数据："+sqlstr);
	
	//2.读取Excel插入新数据
	if(saObjectFile!=null){
		System.out.println("0000000");
		for(int j=0;j<saObjectFile.length;j++){
		System.out.println("11111");
			if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
				System.out.println("78778");
				execlBean.setExecl(allpath+saObjectFile[j]);
				if(execlBean.getFlag()){
				System.out.println("22222");
					String [][]obj = execlBean.getObject(); //遍历1个sheet
					LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
					
					for(int row=0;row<obj.length;row++){//遍历多行
						String []objrow = obj[row]; 
						yc_month = objrow[0];
						yc_hire_date = objrow[1];
						yc_money = objrow[2];
						
						LogWriter.logDebug(request, "上传预测现金流数据：月份"+yc_month);
	
						//插入数据
						sqlstr = "Insert into fund_cash_medi_yc_temp(doc_id,proj_id,yc_month,yc_hire_date,cash_money)";
						sqlstr+= " Select '"+doc_id+"','"+proj_id+"','"+yc_month+"','"+yc_hire_date+"','"+yc_money+"'";
						System.out.println("插入数据"+sqlstr);
						LogWriter.logDebug(request, "插入数据："+sqlstr.substring(0,15));
						flag += db.executeUpdate(sqlstr);
					} 
					//日志操作
					String sqlLog = LogWriter.getSqlIntoDB(request, "导入", "数据导入", "导入", sqlstr);
					db.executeUpdate(sqlLog);
				}else{
					flag = 0;
					errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
					execlBean.deleteFile(allpath+saObjectFile[j]);
				}
			}
		}//for循环结束
	 }
 }
 if(type!=null && !type.equals("") && type.equals("bd")){
 	//1.先清空原数据
	sqlstr = "Delete from fund_cash_medi_bd_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "读Excel前删除数据："+sqlstr);
	
	//2.读取Excel插入新还款数据
	if(saObjectFile!=null){
		System.out.println("0000000");
		for(int j=0;j<saObjectFile.length;j++){
		System.out.println("11111");
			if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
				System.out.println("78778");
				execlBean.setExecl(allpath+saObjectFile[j]);
				if(execlBean.getFlag()){
		System.out.println("22222");
					String [][]obj = execlBean.getObject(); //遍历1个sheet
					LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
					
					for(int row=0;row<obj.length;row++){//遍历多行
						String []objrow = obj[row]; 
						
						
						bd_month = objrow[0];
						bd_hire_date = objrow[1];
						bd_money = objrow[2];
						
						
						LogWriter.logDebug(request, "上传保底现金流数据：月份"+bd_month);
	
						//插入数据
						sqlstr = "Insert into fund_cash_medi_bd_temp(doc_id,proj_id,bd_month,bd_hire_date,cash_money)";
						sqlstr+= " Select '"+doc_id+"','"+proj_id+"','"+bd_month+"','"+bd_hire_date+"','"+bd_money+"'";
						
						LogWriter.logDebug(request, "插入数据："+sqlstr.substring(0,15));
						flag += db.executeUpdate(sqlstr);
					} 
					//日志操作
					String sqlLog = LogWriter.getSqlIntoDB(request, "导入", "数据导入", "导入", sqlstr);
					db.executeUpdate(sqlLog);
				}else{
					flag = 0;
					errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
					execlBean.deleteFile(allpath+saObjectFile[j]);
				}
			}
		}//for循环结束
	 }
 }

db.close();
if(flag>1){
%>
<script type="text/javascript">
	window.close();
	opener.alert("上传成功！");
	opener.parent.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("上传失败，请查看格式是否符合！");
	opener.parent.location.reload();
</script>
<%
}%>