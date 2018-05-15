<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>


<%
//分次确认金额上传保存
//当前登陆人
String czy = (String) session.getAttribute("czyid");

//基础变量
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String uid="";

//excel对应字段名称--分次确认
String refund_list="";
String refund_plan_date="";
String refund_corpus="";

String refund_interest="";
String refund_money="";
String refund_otherfee_money="";

String refund_otherfee_type="";
String refund_subtotal="";
String remark="";


//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\confirm_excel\\"+datestr+"\\";
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
String drawings_id = fileBean.getFieldValue("drawings_id");
String doc_id = fileBean.getFieldValue("doc_id");
//2.读取Excel插入新数据
if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){

		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
				
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					
					refund_list=objrow[1];
					refund_plan_date=objrow[2];
					refund_corpus=objrow[3];
					refund_interest=objrow[4];
					refund_money=objrow[5];
					refund_otherfee_money=objrow[6];
					refund_otherfee_type=objrow[7];
					refund_subtotal=objrow[8];
					remark=objrow[9];
					System.out.println("输出"+refund_list);
					System.out.println("输出"+refund_plan_date);
					System.out.println("输出"+refund_corpus);
					//插入数据
					String sqlstr = "update financing_refund_plan_temp set "+
					"refund_list='"+refund_list+"',refund_plan_date='"+refund_plan_date+"',refund_corpus='"+refund_corpus+"',refund_interest='"+refund_interest+"',"+
					"refund_money='"+refund_money+"',refund_otherfee_money='"+refund_otherfee_money+"',refund_otherfee_type='"+refund_otherfee_type+"',refund_subtotal='"
					+refund_subtotal+"',remark='"+remark+"' where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"'";
					flag = db.executeUpdate(sqlstr);
					System.out.println("输出sql"+sqlstr);
				} 
			}
		}
	}//for循环结束
}

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