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
System.out.println("czy="+czy);
//基础变量
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String sqlstr = "";
String uid="";

//excel对应字段名称
String amortize_list = "";//摊销序号
String amortize_type = ""; //摊销类别
String amortize_date = "";//摊销日期
String amortize_money = ""; //摊销金额
String non_amortization_balance = ""; //未摊销余额
String amortize_method = "";//摊销方法

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\financing_amortize_excel\\"+datestr+"\\";
System.out.println("allpath="+allpath);
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
String drawings_id = fileBean.getFieldValue("drawings_id");
//1.先清空原还款计划数据
sqlstr = "Delete from financing_amortize_temp where drawings_id='"+drawings_id+"'" ;
System.out.println("test="+sqlstr);
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "读Excel前删除原摊销明细："+sqlstr);

//2.读取Excel插入新还款数据
if(saObjectFile!=null){
	//System.out.println("1");
	for(int j=0;j<saObjectFile.length;j++){
		//System.out.println("2============="+saObjectFile[j]);
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				//System.out.println("3");
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				//LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
				
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					//LogWriter.logDebug(request, "第"+row+"行，===第5列值："+objrow[4]+"共"+objrow.length+"列");
					
					//if(objrow[4]==null || "".equals(objrow[4])){
					//	continue;
					//}
					//System.out.println("4");
					
					amortize_list = objrow[0];//序号
					amortize_type = objrow[1];//摊销类别
					amortize_date = objrow[2];//时间 2016-03-03 00:00
					amortize_date = amortize_date.substring(0, 10);
					amortize_money = objrow[3];//金额
					non_amortization_balance = objrow[4];//金额
					amortize_method = objrow[5];
					
					java.util.regex.Pattern p=java.util.regex.Pattern.compile("[0-9]{4}-([0-9]{1}|[0-9]{2})-([0-9]{1}|[0-9]{2})*"); // 判断小数点后一位的数字的正则表达式
				    java.util.regex.Matcher m=p.matcher(amortize_date);
				        if(m.matches()==false) 
				       { 
				        	System.out.println("1不是日期");
				        	System.out.println(amortize_date+"未上传成功");
				        	flag=0;
				        	break; 
				        }
				        
					
					java.util.regex.Pattern pattern=java.util.regex.Pattern.compile("([0-9]*|0)(\\.[\\d]+)?"); // 判断小数点后一位的数字的正则表达式
				    java.util.regex.Matcher matcham=pattern.matcher(amortize_money);
				    java.util.regex.Matcher matchnab=pattern.matcher(non_amortization_balance);
				        if(matcham.matches()==false) 
				       { 
				        	System.out.println("2不是数字");
				        	System.out.println(amortize_money+"未上传成功");
				        	flag=0;
				        	break; 
				        }
				        if(matchnab.matches()==false) 
				        { 
				        	System.out.println("3不是数字");
				        	System.out.println(non_amortization_balance+"未上传成功");
				        	flag=0;
				        	break;
				        }
					
					
					//LogWriter.logDebug(request, "上传还款计划数据：期次"+refund_list+" 本金："+refund_corpus+" 利息："+refund_interest);

					//插入数据
					sqlstr = "Insert into financing_amortize_temp(drawings_id,amortize_date,amortize_money,";
					sqlstr+= " non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type)values ";
					sqlstr+= " ( '"+drawings_id+"','"+amortize_date+"','"+amortize_money+"','"+non_amortization_balance+"','"+amortize_method+"','"+czy+"', ";
					sqlstr+= " '"+datestr+"','"+amortize_list+"','"+amortize_type+"')";
					
					LogWriter.logDebug(request, "插入还款计划数据："+sqlstr);
					flag += db.executeUpdate(sqlstr);
				} 
				//System.out.println("5");
				//日志操作
				String sqlLog = LogWriter.getSqlIntoDB(request, "分摊明细导入", "数据导入", "分摊明细导入", sqlstr);
				db.executeUpdate(sqlLog);
				//System.out.println("6");
			}else{
				flag = 0;
				//System.out.println("7");
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
 }
if(flag==0){
	sqlstr = "Delete from financing_amortize_temp where drawings_id='"+drawings_id+"'" ;
	//System.out.println("test="+sqlstr);
	db.executeUpdate(sqlstr);
}
db.close();
if(flag>0){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("分摊明细上传成功！");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("分摊明细上传失败，请查看格式是否符合！");
	window.opener.location.reload();
</script>
<%
}%>