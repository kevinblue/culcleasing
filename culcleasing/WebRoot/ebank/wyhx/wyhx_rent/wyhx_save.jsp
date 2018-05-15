<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.util.regex.Pattern"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common_simple.jsp"%>

<%
String czy = (String) session.getAttribute("czyid");
//��ȡϵͳʱ��
String datestr=getSystemDate(0); 
String sqlstr="";
ResultSet rs;
String uid="";

String fact_date="";//�ۿ�����
String hxBank = "";//��������
String bank_flag="";//��ִ�ɹ�,ʧ�ܱ�־

hxBank = request.getParameter("hxBank");
String memo="";//��ע
String kk_amt="";//�ۿ���
String fail_reason="";//ʧ��ԭ��
String rem_amt="";//���
String hire_object="";//������
String hire_number="";

String rent_list[]=null;

boolean bflag = true;

String filePath = "";
String fileName = "";
String message = "";
String allpath = "";

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
//�趨�ϴ����������С����
//�ж��ϴ����е��ļ�����
if( "jsBank".equals(hxBank.trim()) ){
	allpath =path + "\\excel\\"+datestr+"\\";
	//�趨�ϴ������ļ�����
	fileBean.setSuffix(".xls");
}else if( "msBank".equals(hxBank.trim()) ){
	allpath =path + "\\txt\\"+datestr+"\\";
	//�趨�ϴ������ļ�����
	fileBean.setSuffix(".txt");
}
fileBean.setObjectPath( allpath );
fileBean.setSize(8*1024*1024);

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
fact_date=fileBean.getFieldValue("fact_date");
String plan_id="";
//==================�жϺ����������Բ�ͬ����===============
if( hxBank!=null && !"".equals(hxBank) && "jsBank".equals(hxBank.trim()) ){//�Խ���ģ�嵼��
	int flag = 0;
	plan_id="";
	for(int i=0;i<iCount;i++){
		plan_id="";
		execlBean.setExecl(allpath+saObjectFile[i]);
		if(execlBean.getFlag()){
			String [][]obj = execlBean.getObject();

			for(int row=0;row<obj.length;row++){//�ӵ����п�ʼ
				String [] objrow = obj[row];	
				
				LogWriter.logDebug(request, "��"+row+"�У�===��8��ֵ��"+objrow[7]+"��"+objrow.length+"��");

				if(objrow.length<8){//������Ϊ8�Ĳ���
					LogWriter.logDebug(request,"������"+row);
					continue;
				}
				memo=objrow[7];//��ע��
				if( memo==null ||  "".equals(memo) ){
					continue;
				}
				
				//�õ�plan_id
				if(memo.indexOf(".0")!=-1){//0.0�Ĵ���
					memo = memo.substring(0, memo.lastIndexOf(".0"));
				}	
				plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;	
				
				//�ж�plan_id�Ƿ�������
				Pattern pattern = Pattern.compile("[0-9]*");  
				if(!pattern.matcher(plan_id).matches()){
					continue;
				} 
									
				//ʧ��ԭ�����
				fail_reason=objrow[6];//ʧ��ԭ��
				//rem_amt=objrow[1];//���
				hire_number=objrow[1];//�ۿ��˻�
				bank_flag=objrow[5];

				if( bank_flag==null || "".equals(bank_flag) ){
					continue;
				}
				
				if(bank_flag!=null && !"".equals(bank_flag) && "�ɹ�".equals(bank_flag)){//��ִ�ۿ�ɹ�
					//�鿴�Ƿ�Ϣ�������ĺ���
					if (memo.indexOf("_")>-1) {//��Ϣʱ
						sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
						sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='ΥԼ��'";
						rs = db.executeQuery(sqlstr);
						boolean noData = !rs.next();
						System.out.print("ΥԼ��========"+noData);
						rs.close();
						if(noData){
							sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,penalty,rent_type,item_method)";
							sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',"+0+","+0+",penalty,b.account_name,'�й���������',b.account,penalty,'ΥԼ��','����' from fund_rent_plan a left ";
							sqlstr+=" join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
							System.out.println("sqlstr==================="+sqlstr);
							db.executeUpdate(sqlstr);
						}
						
					} else {//���ʱ
						sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
						sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='���'";
						rs = db.executeQuery(sqlstr);
						boolean noData = !rs.next();
						System.out.print("����========"+noData);
						rs.close();
						if(noData){
							sqlstr="insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method,remark) ";
							sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'�й���������',b.account,'���','����',a.hg_remark from fund_rent_plan a left ";
							sqlstr+=" join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
							sqlstr+="  update fund_rent_plan set plan_status='1' where  id='"+plan_id+"'  ";
							System.out.println("sqlstr==================="+sqlstr);
							db.executeUpdate(sqlstr);
						}
						
					}
					//�޸�״̬
					sqlstr =" update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='',exp_state=0,";
					sqlstr+=" modificator='"+czy+"',modify_date='"+datestr+"' where id='"+plan_id+"' ";
					flag = db.executeUpdate(sqlstr);
					System.out.println("wyhx_save.jsp================"+sqlstr);
					//���������������Ϣ�����÷�Ϣ�ƻ���ȡ����Ϊ��һ�տ�������ΥԼ����
					sqlstr="  exec rent_penalty_calculate '"+plan_id+"'";
					System.out.println("===��Ϣ��Ŀ======"+sqlstr);
					db.executeUpdate(sqlstr);
				}else{//�ۿ�ʧ��
					//��������������������������������ʧ�ܣ���������������������������������������
					//ʧ�ܴ�����1 = ʧ��ԭ�����
					sqlstr= " update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='"+fail_reason+"',modificator='"+czy+"',modify_date='"+fact_date+"',";
					sqlstr+=" exp_state=(select isnull(exp_state,0)+1 from fund_rent_plan where id=frp.id) from fund_rent_plan frp where frp.id='"+plan_id+"' ";		
					flag = db.executeUpdate(sqlstr);
				}
			}
		}else{
			bflag=false;
		}
	}
}else if( hxBank!=null && !"".equals(hxBank) && "msBank".equals(hxBank.trim()) ){
	List contentList = new ArrayList(0);
	File txtFile = new File(allpath+saObjectFile[0]);
	//��ȡ
	BufferedReader br = null;
	String titleStr = "";
	try {
		br=new BufferedReader(new FileReader(txtFile));
		//�ļ�ͷ
		titleStr = br.readLine();
		System.out.println("titleStr==========="+titleStr);
		//�ļ���һ��������
		String contentStr = ""; 
		while((contentStr=br.readLine())!=null) {
			contentList.add(contentStr);
		}
	}catch(FileNotFoundException e){
	   e.printStackTrace();
	}finally{//�ر���
	   try {
			br.close();
	   } catch (IOException e) {
			e.printStackTrace();
	   }
	}
	//ѭ������
	String contStr = "";
	plan_id="";
	for(int i=0;i<contentList.size();i++){
		plan_id="";
		contStr = contentList.get(i)+"";
		int flag = 0;
		if( contStr!=null && !"".equals(contStr) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(strSegment[13]+"===habcTest======="+strSegment.length);
			//�ļ�ͷ����
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[13];//��־ֵ
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//�õ�plan_id
			if(memo.indexOf(".0")!=-1){//0.0�Ĵ���
				memo = memo.substring(0, memo.lastIndexOf(".0"));
			}
			plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;			System.out.println("memo==================="+memo+"=="+plan_id);
			//�ж�plan_id�Ƿ�������
			Pattern pattern = Pattern.compile("[0-9]*");  
			if(!pattern.matcher(plan_id).matches()){
				continue;
			}
			 
			fail_reason=strSegment[19];//ʧ��ԭ��
			//rem_amt=objrow[1];//���
			bank_flag=strSegment[17];//�ɹ���־
			sqlstr = "";
			if(bank_flag!=null && !"".equals(bank_flag) && "1".equals(bank_flag)){//��ִ�ۿ�ɹ�
				//�鿴�Ƿ�Ϣ�������ĺ���
				if (memo.indexOf("_")>-1) {//��Ϣʱ
					sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
					sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='ΥԼ��'";
					rs = db.executeQuery(sqlstr);
					boolean noData = !rs.next();
					System.out.print("ΥԼ��========"+noData);
					rs.close();
					if(noData){
						sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,penalty,";
						sqlstr+=" rent_type,item_method) select a.proj_id,rent_list,'"+fact_date+"',"+0+","+0+",penalty,b.account_name,'�й���������',b.account,penalty,'ΥԼ��','����' from fund_rent_plan a ";
						sqlstr+=" left join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";	
						System.out.println("sqlstr==================="+sqlstr);
						flag = db.executeUpdate(sqlstr);
					}
				} else {//���ʱ
					sqlstr="select id from fund_rent_income where proj_id=(select proj_id from fund_rent_plan where id='"+plan_id+"')";
					sqlstr+="and plan_list=(select rent_list from fund_rent_plan where id='"+plan_id+"')and rent_type='���'";
					rs = db.executeQuery(sqlstr);
					boolean noData = !rs.next();
					System.out.print("���========"+noData);
					rs.close();
					if(noData){
						sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method,remark) ";
						sqlstr+=" select a.proj_id,rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'�й���������',b.account,'���','����',a.hg_remark from fund_rent_plan a ";
						sqlstr+=" left join proj_info b on a.proj_id=b.proj_id where a.id='"+plan_id+"'  ";
						sqlstr+=" update fund_rent_plan set plan_status='1' where  id='"+plan_id+"'  ";
						System.out.println("sqlstr==================="+sqlstr);
						flag = db.executeUpdate(sqlstr);
					}
				}
				sqlstr =" update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='',exp_state=0,";
				sqlstr+=" modificator='"+czy+"',modify_date='"+datestr+"' where id='"+plan_id+"' ";
				System.out.println("sqlstr==================="+sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				//���������������Ϣ�����÷�Ϣ�ƻ���ȡ����Ϊ��һ�տ�������ΥԼ����
				sqlstr="  exec rent_penalty_calculate '"+plan_id+"'";
				System.out.println("===��Ϣ��Ŀ======"+sqlstr);
				db.executeUpdate(sqlstr);
				
			}else{//�ۿ�ʧ��
				//System.out.println("ʧ�ܣ���������������������������������������");
				//ʧ�ܴ�����1 = ʧ��ԭ�����
				sqlstr= " update fund_rent_plan set show_flag=NULL,show_flag2=NULL,export_flag=NULL,fail_reason='"+fail_reason+"',modificator='"+czy+"',modify_date='"+fact_date+"',";
				sqlstr+=" exp_state=(select isnull(exp_state,0)+1 from fund_rent_plan where id=frp.id) from fund_rent_plan frp where frp.id='"+plan_id+"' ";		
				flag = db.executeUpdate(sqlstr);
			}
		}
		if(flag!=0){//
			bflag=false;
		}else{//
			bflag=true;
		}
	}
}
db.close();

if(bflag){
%>
<script>
		window.close();
		opener.alert("������ɣ��ۿ�ʧ����������������");
		opener.location.reload();
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("����ʧ��,�����ϴ��ļ����ݵĸ�ʽ�Ƿ�Ϸ�");
		opener.location.reload();
</script>
<% } %>