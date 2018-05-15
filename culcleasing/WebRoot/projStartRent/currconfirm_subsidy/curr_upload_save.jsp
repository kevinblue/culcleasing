<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.regex.Pattern"%>
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
String sqlstr = "";
String uid="";

//excel对应字段名称--分次确认
String qc = "";//期次
String rq = ""; //日期
String je = ""; //金额

int zQC = 0;//总期次
double zJE = 0d;//总金额


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
String begin_id = fileBean.getFieldValue("begin_id");
String contract_id = fileBean.getFieldValue("contract_id");
String flow_date = fileBean.getFieldValue("flow_date");
String type = fileBean.getFieldValue("type");

//1.先清空原数据
sqlstr = "delete from begin_currconfirm_info where begin_id='"+begin_id+"'";
db.executeUpdate(sqlstr);

//先删除旧的数据
sqlstr = "delete from begin_currconfirm_subsidy where begin_id='"+begin_id+"'";
db.executeUpdate(sqlstr);

LogWriter.logDebug(request, "读Excel前删除数据-begin_currconfirm_info："+sqlstr);


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
					zQC ++;
					zJE = zJE+(Double.parseDouble(objrow[2]));
					
					qc = objrow[0];
					rq = objrow[1];
					je = objrow[2];
					System.out.println("总期撒的次："+qc);
					//插入数据
					sqlstr="";
					sqlstr+=" insert into begin_currconfirm_subsidy(begin_id,plan_date,currconfirm_money,currconfirm_list,create_date,creator) values ";
					sqlstr+="('"+begin_id+"','"+rq+"','"+je+"','"+qc+"','"+datestr+"','"+czy+"')";

					LogWriter.logDebug(request, "插入数据："+sqlstr.substring(0,15));
					flag += db.executeUpdate(sqlstr);
				} 
			}else{
				flag = 0;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//for循环结束
	//c插入本次补贴
	sqlstr="";
	sqlstr+="insert into begin_currconfirm_info(begin_id,currConfirm_money,currConfirm_term,confirm_type,flow_date,create_date,creator) values ";
	sqlstr+="('"+begin_id+"','"+zJE+"','"+zQC+"','"+type+"','"+flow_date+"','"+datestr+"','"+czy+"')";
	flag+=db.executeUpdate(sqlstr);
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