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
System.out.println("czy="+czy);
//��������
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String sqlstr = "";
String uid="";

//excel��Ӧ�ֶ�����
String amortize_list = "";//̯�����
String amortize_type = ""; //̯�����
String amortize_date = "";//̯������
String amortize_money = ""; //̯�����
String non_amortization_balance = ""; //δ̯�����
String amortize_method = "";//̯������

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\financing_amortize_excel\\"+datestr+"\\";
System.out.println("allpath="+allpath);
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
String drawings_id = fileBean.getFieldValue("drawings_id");
//1.�����ԭ����ƻ�����
sqlstr = "Delete from financing_amortize_temp where drawings_id='"+drawings_id+"'" ;
System.out.println("test="+sqlstr);
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "��Excelǰɾ��ԭ̯����ϸ��"+sqlstr);

//2.��ȡExcel�����»�������
if(saObjectFile!=null){
	//System.out.println("1");
	for(int j=0;j<saObjectFile.length;j++){
		//System.out.println("2============="+saObjectFile[j]);
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				//System.out.println("3");
				String [][]obj = execlBean.getObject(); //����1��sheet
				//LogWriter.logDebug(request, "��һ��sheet�У�"+ obj.length +"��");
				
				for(int row=0;row<obj.length;row++){//��������
					String []objrow = obj[row]; 
					//LogWriter.logDebug(request, "��"+row+"�У�===��5��ֵ��"+objrow[4]+"��"+objrow.length+"��");
					
					//if(objrow[4]==null || "".equals(objrow[4])){
					//	continue;
					//}
					//System.out.println("4");
					
					amortize_list = objrow[0];//���
					amortize_type = objrow[1];//̯�����
					amortize_date = objrow[2];//ʱ�� 2016-03-03 00:00
					amortize_date = amortize_date.substring(0, 10);
					amortize_money = objrow[3];//���
					non_amortization_balance = objrow[4];//���
					amortize_method = objrow[5];
					
					java.util.regex.Pattern p=java.util.regex.Pattern.compile("[0-9]{4}-([0-9]{1}|[0-9]{2})-([0-9]{1}|[0-9]{2})*"); // �ж�С�����һλ�����ֵ�������ʽ
				    java.util.regex.Matcher m=p.matcher(amortize_date);
				        if(m.matches()==false) 
				       { 
				        	System.out.println("1��������");
				        	System.out.println(amortize_date+"δ�ϴ��ɹ�");
				        	flag=0;
				        	break; 
				        }
				        
					
					java.util.regex.Pattern pattern=java.util.regex.Pattern.compile("([0-9]*|0)(\\.[\\d]+)?"); // �ж�С�����һλ�����ֵ�������ʽ
				    java.util.regex.Matcher matcham=pattern.matcher(amortize_money);
				    java.util.regex.Matcher matchnab=pattern.matcher(non_amortization_balance);
				        if(matcham.matches()==false) 
				       { 
				        	System.out.println("2��������");
				        	System.out.println(amortize_money+"δ�ϴ��ɹ�");
				        	flag=0;
				        	break; 
				        }
				        if(matchnab.matches()==false) 
				        { 
				        	System.out.println("3��������");
				        	System.out.println(non_amortization_balance+"δ�ϴ��ɹ�");
				        	flag=0;
				        	break;
				        }
					
					
					//LogWriter.logDebug(request, "�ϴ�����ƻ����ݣ��ڴ�"+refund_list+" ����"+refund_corpus+" ��Ϣ��"+refund_interest);

					//��������
					sqlstr = "Insert into financing_amortize_temp(drawings_id,amortize_date,amortize_money,";
					sqlstr+= " non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type)values ";
					sqlstr+= " ( '"+drawings_id+"','"+amortize_date+"','"+amortize_money+"','"+non_amortization_balance+"','"+amortize_method+"','"+czy+"', ";
					sqlstr+= " '"+datestr+"','"+amortize_list+"','"+amortize_type+"')";
					
					LogWriter.logDebug(request, "���뻹��ƻ����ݣ�"+sqlstr);
					flag += db.executeUpdate(sqlstr);
				} 
				//System.out.println("5");
				//��־����
				String sqlLog = LogWriter.getSqlIntoDB(request, "��̯��ϸ����", "���ݵ���", "��̯��ϸ����", sqlstr);
				db.executeUpdate(sqlLog);
				//System.out.println("6");
			}else{
				flag = 0;
				//System.out.println("7");
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//forѭ������
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
	window.opener.alert("��̯��ϸ�ϴ��ɹ���");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("��̯��ϸ�ϴ�ʧ�ܣ���鿴��ʽ�Ƿ���ϣ�");
	window.opener.location.reload();
</script>
<%
}%>