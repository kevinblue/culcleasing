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

//excel��Ӧ�ֶ�����
String refund_list = "";//����
String refund_rate = ""; //��������
String refund_plan_date = ""; //��������
String refund_corpus = "";//����
String refund_interest = ""; //��Ϣ
String refund_money = "";//��Ϣ�ϼ�
String refund_otherfee_money = "";//�������ý��
String refund_otherfee_type = "";//������������
String refund_subtotal = "";//���λ���С��
String refund_remark = "";//��ע

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\financing_refund_excel\\"+datestr+"\\";
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
String doc_id = fileBean.getFieldValue("doc_id");

//1.�����ԭ����ƻ�����
sqlstr = "Delete from financing_refund_plan_temp where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "��Excelǰɾ��ԭ����ƻ���"+sqlstr);

//2.��ȡExcel�����»�������
if(saObjectFile!=null){
	System.out.println("0000000");
	for(int j=0;j<saObjectFile.length;j++){
	System.out.println("11111nnnn"+saObjectFile.length);
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				System.out.println("22222nnnnnnJJ[["+ j );
				String [][]obj = execlBean.getObject(); //����1��sheet
				LogWriter.logDebug(request, "��һ��sheet�У�"+ obj.length +"��");
				
				for(int row=0;row<obj.length;row++){//��������
					String []objrow = obj[row]; 
					LogWriter.logDebug(request, "��"+row+"�У�===��5��ֵ��"+objrow[4]+"��"+objrow.length+"��");
					
					if(objrow[4]==null || "".equals(objrow[4])){
						continue;
					}

					refund_list = objrow[0];
					refund_rate = objrow[1];
					refund_plan_date = objrow[2];
					refund_corpus = objrow[3];
					refund_interest = objrow[4];
					refund_money = objrow[5];//������Ӧ���Լ�����
					refund_otherfee_money = objrow[6];
					refund_otherfee_type = objrow[7];
					refund_subtotal = objrow[8];
					refund_remark = objrow[9];

					System.out.println("����="+refund_list);
					//�õ�plan_id
					if(refund_list.indexOf(".0")!=-1){//0.0�Ĵ���
						refund_list = refund_list.substring(0, refund_list.lastIndexOf(".0"));
					}	
					
					//�ж��������Ϊ������
					Pattern pattern = Pattern.compile("[0-9]+");  
					if(!pattern.matcher(refund_list).matches()){
						System.out.println("��"+row+"�У�===��1��ֵ��"+refund_list+"�����ݷǷ�");
						continue;
					} 

					//2012 Jaffe ���ϴ󣬽��д���
					refund_corpus = new BigDecimal(refund_corpus).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_interest = new BigDecimal(refund_interest).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_money = new BigDecimal(refund_money).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_otherfee_money = new BigDecimal(refund_otherfee_money).setScale(4,BigDecimal.ROUND_HALF_UP).toString();
					refund_subtotal = new BigDecimal(refund_subtotal).setScale(4,BigDecimal.ROUND_HALF_UP).toString();

					
					LogWriter.logDebug(request, "�ϴ�����ƻ����ݣ��ڴ�"+refund_list+" ����"+refund_corpus+" ��Ϣ��"+refund_interest);

					//��������
					sqlstr = "Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
					sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
					sqlstr+= "refund_subtotal,refund_status,remark)";
					sqlstr+= " Select '"+doc_id+"','"+drawings_id+"','"+refund_list+"','"+refund_plan_date+"','"+refund_rate+"','"+refund_corpus+"', ";
					sqlstr+= " '"+refund_interest+"','"+refund_money+"','"+refund_otherfee_money+"','"+refund_otherfee_type+"','"+refund_subtotal+"','δ����','"+refund_remark+"' ";
					
					LogWriter.logDebug(request, "���뻹��ƻ����ݣ�"+sqlstr);
					flag += db.executeUpdate(sqlstr);
				} 
				//��־����
				String sqlLog = LogWriter.getSqlIntoDB(request, "���ʻ���ƻ�����", "���ݵ���", "���ʻ���ƻ�����", sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				flag = 0;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//forѭ������
 }

System.out.println("flagflagflagflag:"+flag);
db.close();
if(flag>0){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("����ƻ��ϴ��ɹ���");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("����ƻ��ϴ�ʧ�ܣ���鿴��ʽ�Ƿ���ϣ�");
	window.opener.location.reload();
</script>
<%
}%>