<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%
String savetype =getStr( request.getParameter("savetype") );
String datestr=getSystemDate(0);
//��ȡϵͳʱ��
boolean bflag = true;
String message  ="";
String sqlstr;
ResultSet rs=null;

	String czy =(String) session.getAttribute("czyid");
	String errMsg ="";
	int iallcol =0;
	String uid=czy;
	String filePath;
	String fileName = "";
	//�趨�������·��
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\zjsz\\"+datestr+"\\";
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
	fileBean.setSourceFile(request);//�ļ��ϴ�
	String [] saSourceFile = fileBean.getSourceFile();
	String [] saObjectFile = fileBean.getObjectFileName();
	String [] saDescription = fileBean.getDescription();
	int iCount = fileBean.getCount();
	String sObjectPath = fileBean.getObjectPath();
    if(saObjectFile!=null){
	  for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){ 
		System.out.print(allpath+saObjectFile[j]);
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject();
				for(int row=0;row<obj.length;row++){
					String []objrow = obj[row];
					String id=formatNumberDoubleZero(objrow[0]);//ID��Ϊ�����в����ж�ȡ\
					String invoice_no =formatNumberDoubleZero(objrow[22]);//�豸�ͺ�
					sqlstr="update fund_fund_charge_hap set invoice_no='"+invoice_no+"' where id='"+id+"'";
					System.out.print(sqlstr);
					int fag=0;
					fag=db.executeUpdate(sqlstr);
					if(fag!=0){iallcol++;}
				} 
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		 }
	  }
    }
    db.close();
    db1.close();
	if(bflag&&message.equals("")){
	%>
	<script>
	window.close();
	alert("�����ѳɹ���ȡ!���ι��ϴ�<%=iallcol%>����¼!");
	<%
	if(errMsg!=""||(!errMsg.equals(""))){
		%>
		alert("��������ĳЩ���ݳ��������´���:<%=errMsg%>");
		<%
	}
	%>
	opener.location.reload();
	</script>
	<%
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	window.close();
	alert("�ϴ�����ʧ��,execl�ļ�<%=errMsg%>���ݸ�ʽ����");
	opener.location.reload();
	</script>
	<%
	}
	%>
    <script>
		opener.window.location.href = "zjsz_list.jsp";
		this.close();
	</script>