<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>


<%
//�ִ�ȷ�Ͻ���ϴ�����
//��ǰ��½��
String czy = (String) session.getAttribute("czyid");

//��������
String datestr=getSystemDate(0); 
int flag = 0;

String errMsg = "";
String uid="";

//excel��Ӧ�ֶ�����--�ִ�ȷ��
String refund_list="";
String refund_plan_date="";
String refund_corpus="";

String refund_interest="";
String refund_money="";
String refund_otherfee_money="";

String refund_otherfee_type="";
String refund_subtotal="";
String remark="";


//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
String allpath =path + "\\confirm_excel\\"+datestr+"\\";
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
String drawings_id = fileBean.getFieldValue("drawings_id");
String doc_id = fileBean.getFieldValue("doc_id");
//2.��ȡExcel����������
if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){

		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //����1��sheet
				LogWriter.logDebug(request, "��һ��sheet�У�"+ obj.length +"��");
				
				for(int row=0;row<obj.length;row++){//��������
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
					System.out.println("���"+refund_list);
					System.out.println("���"+refund_plan_date);
					System.out.println("���"+refund_corpus);
					//��������
					String sqlstr = "update financing_refund_plan_temp set "+
					"refund_list='"+refund_list+"',refund_plan_date='"+refund_plan_date+"',refund_corpus='"+refund_corpus+"',refund_interest='"+refund_interest+"',"+
					"refund_money='"+refund_money+"',refund_otherfee_money='"+refund_otherfee_money+"',refund_otherfee_type='"+refund_otherfee_type+"',refund_subtotal='"
					+refund_subtotal+"',remark='"+remark+"' where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"'";
					flag = db.executeUpdate(sqlstr);
					System.out.println("���sql"+sqlstr);
				} 
			}
		}
	}//forѭ������
}

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