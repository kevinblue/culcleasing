<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%
String czy = (String) session.getAttribute("czyid");

//��ȡϵͳʱ��
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";
String sqlstr;
String uid="";
String order_number = "";//���
String arrive_date="";//����ʱ��
String account_bank = "";//��������
String acc_number="";//�����˺�
String client_accnumber = "";//�Է��˺�
String client_name = "";//�Է���λ
String fact_money = "";//���
String summary = "";//ժҪ
String sn = "";//��ˮ��
String ebdata_id="";//�������
String  sn_mes="";
ResultSet rs ;

int iallcol=0;

String filePath;
String fileName = "";
String message = "";

//�趨�������·��
	String path = pageContext.getServletContext().getRealPath("/");
	String allpath =path + "\\upload\\wydr\\"+datestr+"\\";
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
					try{
						String []objrow = obj[row];
						order_number=formatNumberDoubleZero(objrow[0]);
						arrive_date=objrow[1];
						account_bank=objrow[2];
						acc_number=formatNumberDoubleZero(objrow[3]);
						client_accnumber=formatNumberDoubleZero(objrow[4]);
						client_name=objrow[5];
						fact_money=formatNumberDoubleTwo(objrow[6]);
						summary=objrow[7];
						sn=formatNumberDoubleZero(objrow[8]);
						sqlstr="select sn from fund_ebank_data where sn='"+sn+"'";
						rs = db.executeQuery(sqlstr); 
						if ( rs.next() ) {
							sn_mes+=sn+",";
							continue;
						}
						//��������ID��ʼ
						sqlstr = "select top 1  ebdata_id from fund_ebank_data order by ebdata_id desc";
						System.out.println(sqlstr);
						String temp_id="";
						String temp_date=datestr.replaceAll("-", "");//��ȡ�������ղ�ȥ���м��-����continue
						rs = db.executeQuery(sqlstr); 
						if ( rs.next() ) {
							temp_id = getDBStr( rs.getString("ebdata_id") );//������һ��������ID
						}
						rs.close();
						if ( ( temp_id == null ) || ( temp_id.equals("") ) ) {
							//���������ʾ���ݿ⻹û����
							temp_id = temp_date + "0001";
						} else {
							//�����һ��ID�Ĳ�������
							String old_date=temp_id.substring(0,8);
							if(old_date.equals(temp_date)){//ͬһ������ݲ������ۼ�λ��
								//�����һ�β�����ID��β����(4λ)
								int temp_num=Integer.parseInt("1"+temp_id.substring(temp_id.length()-4,temp_id.length()));//Ϊ��ת����ǰ����㲻��ʧ������ǰ��1;
								temp_num++;//�����Լ�
								temp_id=String.valueOf(temp_num).substring(1);//��ȡ����λ����
								temp_id=String.valueOf(temp_date+temp_id);//����ȡ��ID
							}else{//����ͬһ������ݴ�1��ʼ��
								temp_id=temp_date+"0001";
							}
						}
						ebdata_id=temp_id;
						//��������ID����
						sqlstr="insert into fund_ebank_data (ebdata_id,order_number,upload_date,arrive_date,account_bank,acc_number,client_name,client_accnumber,fact_money,summary,sn) values ('"+ebdata_id+"','"+order_number+"','"+datestr+"','"+arrive_date+"','"+account_bank+"','"+acc_number+"','"+client_name+"','"+client_accnumber+"','"+fact_money+"','"+summary+"','"+sn+"')";
						int fag=0;
						fag=db.executeUpdate(sqlstr); 
						if(fag!=0){
							iallcol++;
						}
						if(!(sn_mes.equals("")||sn_mes=="")){
							sn_mes=sn_mes.substring(0,sn_mes.length()-1);
							errMsg+="��ˮ��Ϊ:"+sn_mes+"�����������Ѿ�����!";
						}
					}catch(Exception e){
							bflag = false;
							message+="\\n�����ļ�����!��ȷ�ϴ��ļ������ݸ�ʽ��ȷ!";
							break;
					}
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
	if(bflag&&message.equals("")){
		%>
<script>
		alert("�ϴ����ݳɹ�!���ι��ϴ�<%=iallcol%>��������¼");
		<%
		if(errMsg!=""||(!errMsg.equals(""))){
			%>
			alert("��������ĳЩ���ݳ��������´���:<%=errMsg%>");
			<%
		}
	}else{
		
		System.out.println("message:"+message);
	%>
	<script>
	alert("�ϴ���������ʧ��,���ܵ�ԭ��:<%=message%>");
	opener.location.reload();
	<%
	}
	%>
		opener.location.reload();
		this.close();
	</script>
<%
%>