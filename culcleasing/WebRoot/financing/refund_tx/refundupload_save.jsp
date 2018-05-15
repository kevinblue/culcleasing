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
String id="";
String refund_corpus="";
String refund_interest="";
String refund_money="";
String refund_subtotal="";

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
					
					id=objrow[1];
					refund_corpus=objrow[5];
					refund_interest=objrow[6];
					refund_money=objrow[7];
					refund_subtotal=objrow[10];
					System.out.println("输出"+id);
					//System.out.println("输出"+plan_date);
					//System.out.println("输出"+newPlan_date);
					//插入数据
					String sqlstr = " update financing_refund_plan set refund_corpus='"+refund_corpus+"',refund_interest='"+refund_interest+"',refund_money='"+refund_money+"',refund_subtotal='"+refund_subtotal+"' where refund_plan_id='"+id+"'";
					System.out.println("输出"+sqlstr);
					//sqlstr = "Update contract_fund_fund_charge_plan set plan_date='"+newPlan_date+"' where id='"+id+"'";
					

					//LogWriter.logDebug(request, "插入数据："+sqlstr);
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
<%if(null != db){db.close();}%>