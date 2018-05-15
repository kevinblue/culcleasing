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

//excel对应字段名称
String refund_list = "";//期数
String refund_rate = ""; //还款利率
String refund_plan_date = ""; //还款日期
String refund_corpus = "";//本金
String refund_interest = ""; //利息
String refund_money = "";//本息合计
String refund_otherfee_money = "";//其他费用金额
String refund_otherfee_type = "";//其他费用类型
String refund_subtotal = "";//本次还款小计
String refund_remark = "";//备注

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\financing_refund_excel\\"+datestr+"\\";
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
String doc_id = fileBean.getFieldValue("doc_id");

//1.先清空原还款计划数据
sqlstr = "Delete from financing_refund_plan_temp where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "读Excel前删除原还款计划："+sqlstr);

//2.读取Excel插入新还款数据
if(saObjectFile!=null){
	System.out.println("0000000");
	for(int j=0;j<saObjectFile.length;j++){
	System.out.println("11111nnnn"+saObjectFile.length);
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				System.out.println("22222nnnnnnJJ[["+ j );
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
				
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					LogWriter.logDebug(request, "第"+row+"行，===第5列值："+objrow[4]+"共"+objrow.length+"列");
					
					if(objrow[4]==null || "".equals(objrow[4])){
						continue;
					}

					refund_list = objrow[0];
					refund_rate = objrow[1];
					refund_plan_date = objrow[2];
					refund_corpus = objrow[3];
					refund_interest = objrow[4];
					refund_money = objrow[5];//理论上应该自己计算
					refund_otherfee_money = objrow[6];
					refund_otherfee_type = objrow[7];
					refund_subtotal = objrow[8];
					refund_remark = objrow[9];

					System.out.println("期数="+refund_list);
					//得到plan_id
					if(refund_list.indexOf(".0")!=-1){//0.0的处理
						refund_list = refund_list.substring(0, refund_list.lastIndexOf(".0"));
					}	
					
					//判断如果期数为非数字
					Pattern pattern = Pattern.compile("[0-9]+");  
					if(!pattern.matcher(refund_list).matches()){
						System.out.println("第"+row+"行，===第1列值："+refund_list+"，数据非法");
						continue;
					} 

					//2012 Jaffe 金额较大，进行处理
					refund_corpus = new BigDecimal(refund_corpus).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_interest = new BigDecimal(refund_interest).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_money = new BigDecimal(refund_money).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_otherfee_money = new BigDecimal(refund_otherfee_money).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_subtotal = new BigDecimal(refund_subtotal).setScale(4,BigDecimal.ROUND_HALF_UP).toString();

					
					LogWriter.logDebug(request, "上传还款计划数据：期次"+refund_list+" 本金："+refund_corpus+" 利息："+refund_interest);

					//插入数据
					sqlstr = "Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
					sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
					sqlstr+= "refund_subtotal,refund_status,remark)";
					sqlstr+= " Select '"+doc_id+"','"+drawings_id+"','"+refund_list+"','"+refund_plan_date+"','"+refund_rate+"','"+refund_corpus+"', ";
					sqlstr+= " '"+refund_interest+"','"+refund_money+"','"+refund_otherfee_money+"','"+refund_otherfee_type+"','"+refund_subtotal+"','未还款','"+refund_remark+"' ";
					
					LogWriter.logDebug(request, "插入还款计划数据："+sqlstr);
					flag += db.executeUpdate(sqlstr);
				} 
				//日志操作
				String sqlLog = LogWriter.getSqlIntoDB(request, "融资还款计划导入", "数据导入", "融资还款计划导入", sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				flag = 0;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
 }

System.out.println("flagflagflagflag:"+flag);
db.close();
if(flag>0){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("还款计划上传成功！");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("还款计划上传失败，请查看格式是否符合！");
	window.opener.location.reload();
</script>
<%
}%>