<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.regex.Pattern"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//����ƻ��ϴ�����
//��ǰ��½��
String czy = (String) session.getAttribute("czyid");

//��������
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String sqlstr = "";
String uid="";

//excel��Ӧ�ֶ�����--Ԥ���ֽ���
String yc_month = "";//�·�
String yc_hire_date = ""; //������
String yc_money = ""; //�ֽ���

//excel��Ӧ�ֶ�����--�����ֽ���
String bd_month = "";//�·�
String bd_hire_date = ""; //������
String bd_money = ""; //�ֽ���

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\cash_excel\\"+datestr+"\\";
fileBean.setObjectPath( allpath );
//�趨�ϴ����������С���� 
fileBean.setSize(8*1024*1024);

//�趨�ϴ������ļ�����
fileBean.setSuffix(".xls");

//�趨�ϴ��û�ID
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

//�����ļ����Ͳ���
String proj_id = fileBean.getFieldValue("proj_id");
String doc_id = fileBean.getFieldValue("doc_id");
String type = fileBean.getFieldValue("type");
if(type!=null && !type.equals("") && type.equals("yc")){
	//1.�����ԭ����
	sqlstr = "Delete from fund_cash_medi_yc_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "��Excelǰɾ�����ݣ�"+sqlstr);
	
	//2.��ȡExcel����������
	if(saObjectFile!=null){
		System.out.println("0000000");
		for(int j=0;j<saObjectFile.length;j++){
		System.out.println("11111");
			if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
				System.out.println("78778");
				execlBean.setExecl(allpath+saObjectFile[j]);
				if(execlBean.getFlag()){
				System.out.println("22222");
					String [][]obj = execlBean.getObject(); //����1��sheet
					LogWriter.logDebug(request, "��һ��sheet�У�"+ obj.length +"��");
					
					for(int row=0;row<obj.length;row++){//��������
						String []objrow = obj[row]; 
						yc_month = objrow[0];
						yc_hire_date = objrow[1];
						yc_money = objrow[2];
						
						LogWriter.logDebug(request, "�ϴ�Ԥ���ֽ������ݣ��·�"+yc_month);
	
						//��������
						sqlstr = "Insert into fund_cash_medi_yc_temp(doc_id,proj_id,yc_month,yc_hire_date,cash_money)";
						sqlstr+= " Select '"+doc_id+"','"+proj_id+"','"+yc_month+"','"+yc_hire_date+"','"+yc_money+"'";
						System.out.println("��������"+sqlstr);
						LogWriter.logDebug(request, "�������ݣ�"+sqlstr.substring(0,15));
						flag += db.executeUpdate(sqlstr);
					} 
					//��־����
					String sqlLog = LogWriter.getSqlIntoDB(request, "����", "���ݵ���", "����", sqlstr);
					db.executeUpdate(sqlLog);
				}else{
					flag = 0;
					errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
					execlBean.deleteFile(allpath+saObjectFile[j]);
				}
			}
		}//forѭ������
	 }
 }
 if(type!=null && !type.equals("") && type.equals("bd")){
 	//1.�����ԭ����
	sqlstr = "Delete from fund_cash_medi_bd_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "��Excelǰɾ�����ݣ�"+sqlstr);
	
	//2.��ȡExcel�����»�������
	if(saObjectFile!=null){
		System.out.println("0000000");
		for(int j=0;j<saObjectFile.length;j++){
		System.out.println("11111");
			if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
				System.out.println("78778");
				execlBean.setExecl(allpath+saObjectFile[j]);
				if(execlBean.getFlag()){
		System.out.println("22222");
					String [][]obj = execlBean.getObject(); //����1��sheet
					LogWriter.logDebug(request, "��һ��sheet�У�"+ obj.length +"��");
					
					for(int row=0;row<obj.length;row++){//��������
						String []objrow = obj[row]; 
						
						
						bd_month = objrow[0];
						bd_hire_date = objrow[1];
						bd_money = objrow[2];
						
						
						LogWriter.logDebug(request, "�ϴ������ֽ������ݣ��·�"+bd_month);
	
						//��������
						sqlstr = "Insert into fund_cash_medi_bd_temp(doc_id,proj_id,bd_month,bd_hire_date,cash_money)";
						sqlstr+= " Select '"+doc_id+"','"+proj_id+"','"+bd_month+"','"+bd_hire_date+"','"+bd_money+"'";
						
						LogWriter.logDebug(request, "�������ݣ�"+sqlstr.substring(0,15));
						flag += db.executeUpdate(sqlstr);
					} 
					//��־����
					String sqlLog = LogWriter.getSqlIntoDB(request, "����", "���ݵ���", "����", sqlstr);
					db.executeUpdate(sqlLog);
				}else{
					flag = 0;
					errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
					execlBean.deleteFile(allpath+saObjectFile[j]);
				}
			}
		}//forѭ������
	 }
 }

db.close();
if(flag>1){
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ϴ��ɹ���");
	opener.parent.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ϴ�ʧ�ܣ���鿴��ʽ�Ƿ���ϣ�");
	opener.parent.location.reload();
</script>
<%
}%>