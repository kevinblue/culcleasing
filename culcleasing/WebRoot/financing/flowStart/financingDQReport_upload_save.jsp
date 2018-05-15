<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//当前登陆人
String czy = (String) session.getAttribute("czyid");
//基础变量
String datestr=getSystemDate(0); 
int flag = 0;
String uid="";
//excel对应字段名称--分次确认
String swap_start_date_t="";//起息日
String swap_delivery_date_t="";//交割日
String swap_currency_t="";//币种
String swap_nominal_money_t="";//掉期名义金额
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

//表单非文件类型参数
String doc_id = fileBean.getFieldValue("doc_id");
String drawings_id = fileBean.getFieldValue("drawings_id");

//2.读取Excel插入新数据
if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){

		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //遍历1个sheet
				LogWriter.logDebug(request, "第一个sheet有："+ obj.length +"行");
				
					String sqlstr = "delete from financing_change_date_info_temp where doc_id='"+doc_id+"' and drawings_id='"+drawings_id+"'";
					db.executeUpdate(sqlstr);
				for(int row=0;row<obj.length;row++){//遍历多行
					String []objrow = obj[row]; 
					swap_start_date_t=objrow[0];
					swap_delivery_date_t=objrow[1];
					swap_currency_t=objrow[2];
					swap_nominal_money_t=objrow[3];
					System.out.println("输出"+swap_start_date_t);
					System.out.println("输出"+swap_delivery_date_t);
					System.out.println("输出"+swap_currency_t);
					//插入数据
					 sqlstr = "insert into financing_change_date_info_temp(drawings_id,doc_id,swap_start_date_t,swap_delivery_date_t,swap_currency_t,swap_nominal_money_t)"
					+ " values('"+drawings_id+"','"+doc_id+"','"+swap_start_date_t+"','"+swap_delivery_date_t+"','"+swap_currency_t+"','"+swap_nominal_money_t+"')";
					flag += db.executeUpdate(sqlstr);
				} 
			}
		}
	}//for循环结束
}
if(flag>1){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("掉期时间表上传成功！");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("掉期时间表上传失败，请查看格式是否符合！");
	window.opener.location.reload();
</script>
<%
}%>
<%if(null != db){db.close();}%>