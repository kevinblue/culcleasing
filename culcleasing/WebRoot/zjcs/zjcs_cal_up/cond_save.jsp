<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.container.*" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//��ǰ��½��
String czy = (String) session.getAttribute("czyid");

//��������
String datestr=getSystemDate(0); 
boolean bflag = true;
String errMsg = "";
String sqlstr;
ResultSet rs = null;
String uid="";

//excel��Ӧ�ֶ�����
String ebdata_id = "";
String own_bank = ""; //��������
String own_account = ""; //�����˻�
String own_acc_number = "";//�����˺�
String client_bank = ""; //�Է�����
String client_account = "";//�Է��˻�
String client_acc_number = "";//�Է��˺�
String client_name = "";//������
String money_type = "�����";//���˽������
String fact_money = "";//���˽��
String fact_date = "";//����ʱ��
String used_money = "0";//��ʹ�ý��
String left_money = "";//��Ч���
String sn = "";//��ˮ��
String status = "0";//״̬ 0���� ��Ч  1���� ��Ч
String business_flag = "0"; //�Ƿ�������� 0�й� 1�޹�
String summary = "";//��ע ��ժҪ
String upload_date = "";//�ϴ�ʱ��

double dalldata=0;
int iallcol=0;

//�ϴ�excel����
String filePath;
String message = "";


//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
filePath = "\\ebank_excel\\"+datestr+"\\";
String allpath =path + "\\ebank_excel\\"+datestr+"\\";
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
String ebank_date = fileBean.getFieldValue("ebank_date");
upload_date = ebank_date;
//�ж��Ƿ�һ��ֻ���ϴ�һ�� --��ʱ����
int dateflag=0;

//=============�����ϴ���Ϣ================
//ȡ�õ�����ˮ��
String eup_id="";
sqlstr="select count(id)+1 as no from generate_no where generate_type='���������ϴ�'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	eup_id=getDBStr( rs.getString("no") );
}rs.close();
sqlstr="insert into generate_no select '���������ϴ�','"+datestr+"','"+eup_id+"'";
db.executeUpdate(sqlstr);
eup_id = "ebankup"+eup_id;
//�ϴ�������Ϣ			
sqlstr = "insert into fund_ebank_imp(up_id,upload_time,file_name,file_path,creator,create_date,modificator,modify_date)";
sqlstr+= "values('"+eup_id+"','"+ebank_date+"','"+saObjectFile[0]+"','"+filePath+"','"+czy+"','"+datestr+"','"+czy+"','"+datestr+"')";
db.executeUpdate(sqlstr);
//sqlstr="  select * from inter_finance_closeday where close_day>='"+ebank_date+"'";
//ResultSet rsCloseday = db1.executeQuery(sqlstr); 
//if(rsCloseday.next()){
//	dateflag=1;
//}
if(dateflag<1){
   if(saObjectFile!=null){
	for(int j=0;j<saObjectFile.length;j++){
		if(saObjectFile[j]!=null&&!saObjectFile[j].equals("")){
			execlBean.setExecl(allpath+saObjectFile[j]);
			if(execlBean.getFlag()){
				String [][]obj = execlBean.getObject(); //����1��sheet
				iallcol = obj.length;
				System.out.println("��һ��sheet�У�"+iallcol+"��");
				for(int row=0;row<obj.length;row++){//��������
					String []objrow = obj[row]; 
					
					LogWriter.logDebug(request, "��"+row+"�У�===��8��ֵ��"+objrow[7]+"��"+objrow.length+"��");
					System.out.println("��"+row+"�У�===��1��ֵ��"+objrow[0]+"��"+objrow.length+"��");
					
					own_bank = objrow[0];
					own_account = objrow[1];
					own_acc_number = objrow[2];
					client_bank = objrow[3];
					client_account = objrow[4];
					client_acc_number = objrow[5];
					client_name = objrow[6];
					fact_money = objrow[7];
					fact_date = objrow[8];
					sn=objrow[9];
					summary=objrow[10];
					left_money = fact_money;
					System.out.println("�ϴ��������ݣ�"+client_name);
					LogWriter.logDebug(request, "�ϴ���������,�����ˣ�"+client_name);
					//�ж���������˺�û������������
					if("".equals(client_acc_number)){
						iallcol--;
						System.out.println("��"+row+"�У�===��1��ֵ��"+objrow[0]+"��"+objrow.length+"�У����ݷǷ�");
						continue;
					}
//					ResultSet rsCount = null;
//					sqlstr = "select count(*) as count from fund_ebank_data where order_number="+order_number;
//					System.out.println(sqlstr);
//					rsCount = db2.executeQuery(sqlstr);
//					boolean flag = false;
//					if(rsCount.next()){
//						if(Integer.parseInt(rsCount.getString("count"))>0){
//							flag = true;
//						}
//					}
//					if(!flag){
					//�����������
					//sqlstr = "select dbo.wybhsc('"+client_acc_number+"') as xh";
					//rs = db.executeQuery(sqlstr); 
					//if ( rs.next() ) {
					//	ebdata_id = getDBStr( rs.getString("xh") );
					//}
					//rs.close();
					
					//�����������
					sqlstr="select count(id)+1 as no from generate_no where generate_type='"+client_acc_number+"��������'";
					rs=db.executeQuery(sqlstr);
					if(rs.next()){
						ebdata_id=getDBStr( rs.getString("no") );
					}rs.close();
					sqlstr="insert into generate_no select '"+client_acc_number+"��������','"+datestr+"','"+ebdata_id+"'";
					db.executeUpdate(sqlstr);
					ebdata_id = client_acc_number+"_"+ebdata_id;
					
					//��������
					if(ebdata_id!=null&&!ebdata_id.equals("")&&!ebdata_id.equals("null")){
						sqlstr = "insert into fund_ebank_data (ebdata_id,up_id,own_bank,own_account,own_acc_number,client_bank,client_account,";
						sqlstr +=" client_acc_number,client_name,money_type,fact_money,fact_date,used_money,left_money,sn,status,business_flag,";
						sqlstr +=" summary,upload_date,creator,create_date) values (";
						sqlstr += "'"+ebdata_id+"'";
						sqlstr += ",'"+eup_id+"'";
						sqlstr += ",'"+own_bank+"'";
						sqlstr += ",'"+own_account+"'";
						sqlstr += ",'"+own_acc_number+"'";
						sqlstr += ",'"+client_bank+"'";
						sqlstr += ",'"+client_account+"'";
						sqlstr += ",'"+client_acc_number+"'";
						sqlstr += ",'"+client_name+"'";
						sqlstr += ",'"+money_type+"'";
						sqlstr += ",'"+fact_money+"'";
						sqlstr += ",'"+fact_date+"'";
						sqlstr += ",'"+used_money+"'";
						sqlstr += ",'"+left_money+"'";
						sqlstr += ",'"+sn+"'";
						sqlstr += ",'"+status+"'";
						sqlstr += ",'"+business_flag+"'";
						sqlstr += ",'"+summary+"'";
						sqlstr += ",'"+upload_date+"'";
						sqlstr += ",'"+czy+"'";
						sqlstr += ",'"+datestr+"')";
						System.out.println("KKKKKKKKKKKK"+sqlstr);
						LogWriter.logDebug(request, "�����������ݣ�"+sqlstr.substring(0,15));
						db.executeUpdate(sqlstr);
						if(fact_money!=null&&!fact_money.equals("")){
							dalldata += Double.parseDouble(fact_money);
						}
						
					}else{
						iallcol--;
						message+=client_acc_number+";";
					}
				} 
				//�޸��ϴ���Ϣ����ܽ����������
				sqlstr = "update fund_ebank_imp set sum_fact_money='"+dalldata+"',count_fact_imp='"+iallcol+"' where up_id='"+eup_id+"'";
				db.executeUpdate(sqlstr);	
				//��־����
				String sqlLog = LogWriter.getSqlIntoDB(request, "�������ݵ���", "���ݵ���", "������Ŀ�ܽ��:"+dalldata+"����������"+iallcol, sqlstr);
				db.executeUpdate(sqlLog);
			}else{
				bflag = false;
				errMsg +=saObjectFile[j]+execlBean.getErrMsg()+";";
				execlBean.deleteFile(allpath+saObjectFile[j]);
			}
		}
	}//forѭ������
   }
}

db.close();

if(dateflag<1){
	if(bflag && message.equals("")){
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ϴ��������ݳɹ�!���ι��ϴ�<%=CurrencyUtil.convertIntAmount(iallcol) %>��������¼���ܽ��<%=CurrencyUtil.convertFinance(dalldata)%>");
	opener.location.reload();
</script>
<%
}else{
	if(message.equals("")){
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ϴ���������ʧ��,execl�ļ�<%=errMsg%>���ݸ�ʽ����");
	opener.location.reload();
</script>
<%
}else{
	message="���"+message+"�޷�����������ţ����޸����ݺ󵥶��ϴ�";
	if(!bflag){
%>
<script type="text/javascript">
	window.close();
	opener.alert("�ϴ���������ʧ��,execl�ļ�<%=errMsg%>���ݸ�ʽ����");
	opener.alert("<%=message%>");
	opener.location.reload();
</script>
<%
	}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("<%=message%>,���ι��ϴ�<%=CurrencyUtil.convertIntAmount(iallcol) %>��������¼���ܽ��<%=CurrencyUtil.convertFinance(dalldata)%>");
		opener.location.reload();
</script>
<%
		}
	}
}
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("�ϴ�����Ӧ�������һ�εĹ�����");
		opener.location.reload();
</script>
<%
}
%>