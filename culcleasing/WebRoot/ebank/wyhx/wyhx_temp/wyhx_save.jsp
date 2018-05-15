<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"  %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common.jsp"%>
<%
String czy = (String) session.getAttribute("czyid");
//��ȡϵͳʱ��
String datestr=getSystemDate(0); 

String errMsg = "";
String sqlstr="";
ResultSet rs;
String uid="";

String fact_date="";//�ۿ�����
String hxBank = "";//��������
String bank_flag="";//��ִ�ɹ�,ʧ�ܱ�־

hxBank = request.getParameter("hxBank");
String memo="";//��ע

String rent_list[]=null;
boolean bflag = true;

String filePath;
String fileName = "";
String message = "";
String allpath = "";
String hire_number="";

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
//�趨�ϴ����������С����
//�ж��ϴ����е��ļ�����
if( "jsBank".equals(hxBank.trim()) ){
	allpath =path + "\\execl\\"+datestr+"\\";
	//�趨�ϴ������ļ�����
	fileBean.setSuffix(".xls");
}else if( "msBank".equals(hxBank.trim()) ){
	allpath =path + "\\txt\\"+datestr+"\\";
	//�趨�ϴ������ļ�����
	fileBean.setSuffix(".txt");
}
fileBean.setObjectPath( allpath );
fileBean.setSize(10*1024*1024);

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
//==================�жϺ����������Բ�ͬ����===============
if( hxBank!=null && !"".equals(hxBank) && "jsBank".equals(hxBank.trim()) ){//�Խ���ģ�嵼��
	for(int i=0;i<iCount;i++){
		execlBean.setExecl(allpath+saObjectFile[i]);
		if(execlBean.getFlag()){
			String [][]obj = execlBean.getObject();
			System.out.println(obj.length+"========length======="+obj[0].length);
			for(int row=0;row<obj.length;row++){//�ӵ����п�ʼ
				String []objrow = obj[row];	
				if(objrow.length<8){//������Ϊ8�Ĳ���
					continue;
				}

				memo=objrow[7];
				System.out.println(row+"========length======="+memo);
				//����
				if( memo==null ||  "".equals(memo) ){
					continue;
				}
				//���memo�����ݿ��в���������
				sqlstr = "select id from fund_fund_charge_plan where proj_id='"+memo+"'";
				rs = db.executeQuery(sqlstr);
				if(!rs.next()){
					System.out.println("������===="+memo);
					continue;
				}

				hire_number=objrow[3];//�������
				bank_flag=objrow[5];//�ɹ���־
				System.out.println(row+"========length===5===="+bank_flag);
				if( bank_flag==null || "".equals(bank_flag) ){
					continue;
				}
				
				if(bank_flag!=null && !"".equals(bank_flag) && "�ɹ�".equals(bank_flag.trim())){
					sqlstr=" update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and status='0'";
					db.executeUpdate(sqlstr);
					sqlstr =" insert into fund_fund_charge(fact_date,fact_money,account_bank,account,acc_number,proj_id,funds_mode,";
					sqlstr+=" funds_type,funds_name,plan_date,plan_money,item_method,payer,payee,status,settle_mode,create_date,";
					sqlstr+=" creator,plan_id) select '"+fact_date+"' as fact_date,fund_fund_charge_plan.plan_money,'�й���������',";
					sqlstr+=" proj_info.account_name,proj_info.account, fund_fund_charge_plan.proj_id,";
					sqlstr+=" fund_fund_charge_plan.funds_mode,fund_fund_charge_plan.funds_type,fund_fund_charge_plan.funds_name, ";
					sqlstr+=" fund_fund_charge_plan.plan_date,fund_fund_charge_plan.plan_money,fund_fund_charge_plan.item_method,";
					sqlstr+=" proj_info.cust_id, fund_fund_charge_plan.payee,'1' as status,fund_fund_charge_plan.settle_mode,";
					sqlstr+=" '"+datestr+"','"+czy+"',fund_fund_charge_plan.id from fund_fund_charge_plan left join proj_info on ";
					sqlstr+=" fund_fund_charge_plan.proj_id=proj_info.proj_id where fund_fund_charge_plan.proj_id='"+memo+"' and ";
					sqlstr+=" funds_mode='�տ�' and item_method='����' and status='0'";
					//System.out.println("sqlstr2===hhhj======="+proj_id);
					db.executeUpdate(sqlstr);
					sqlstr="update fund_fund_charge_plan set status='1' where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and status='0'";
					db.executeUpdate(sqlstr);
					//System.out.println("sqlstr2===hhhj2======="+sqlstr);
					//�޸����ƻ����һ�����״̬
					sqlstr="update fund_rent_plan set plan_status='1',penalty=0 where proj_id='"+memo+"' and rent_list=1 ";
					db.executeUpdate(sqlstr);
					//System.out.println("sqlstr2===hhhj3======="+sqlstr);
					//���ʵ�ձ��������
					sqlstr=" insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,";
					sqlstr+=" hire_account,hire_number,rent_type,item_method) select a.proj_id,rent_list,";
					sqlstr+=" '"+fact_date+"',rent,corpus,interest,b.account_name,'�й���������',b.account,'���','����' from ";
					sqlstr+=" fund_rent_plan a left join proj_info b on a.proj_id=b.proj_id where a.proj_id='"+memo+"' ";
					sqlstr+=" and a.rent_list=1 ";

					db.executeUpdate(sqlstr);
				} else
				{
					sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and status='0'";
					db.executeUpdate(sqlstr);
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
			System.out.println("contentStr==========="+contentStr);
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
	for(int i=0;i<contentList.size();i++){
		contStr = contentList.get(i)+"";
		int flag = 0;
		if( contStr!=null && !"".equals(contStr.trim()) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(memo+"===habcTest======="+strSegment.length);
			//�ļ�ͷ����
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[13];//��־ֵ
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//���memo�����ݿ��в���������
			sqlstr = "select id from fund_fund_charge_plan where proj_id='"+memo+"'";
			rs = db.executeQuery(sqlstr);
			if(!rs.next()){
				System.out.println("������===="+memo);
				continue;
			}
				
			bank_flag=strSegment[17];//�ɹ���־
			System.out.println(memo+"===habcTest======="+tempMemo+"=="+bank_flag);
			
			if(bank_flag!=null && !"".equals(bank_flag) && "1".equals(bank_flag)){//��ִ�ۿ�ɹ�
				sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and status='0'";
				db.executeUpdate(sqlstr);
				sqlstr =" insert into fund_fund_charge(fact_date,fact_money,account_bank,account,acc_number,proj_id,funds_mode,";
				sqlstr+=" funds_type,funds_name,plan_date,plan_money,item_method,payer,payee,status,settle_mode,create_date,";
				sqlstr+=" creator,plan_id) select '"+fact_date+"' as fact_date,fund_fund_charge_plan.plan_money,'�й���������',";
				sqlstr+=" proj_info.account_name,proj_info.account, fund_fund_charge_plan.proj_id,";
				sqlstr+=" fund_fund_charge_plan.funds_mode,fund_fund_charge_plan.funds_type,fund_fund_charge_plan.funds_name, ";
				sqlstr+=" fund_fund_charge_plan.plan_date,fund_fund_charge_plan.plan_money,fund_fund_charge_plan.item_method,";
				sqlstr+=" proj_info.cust_id, fund_fund_charge_plan.payee,'1' as status,fund_fund_charge_plan.settle_mode,";
				sqlstr+=" '"+datestr+"','"+czy+"',fund_fund_charge_plan.id from fund_fund_charge_plan left join proj_info on ";
				sqlstr+=" fund_fund_charge_plan.proj_id=proj_info.proj_id where fund_fund_charge_plan.proj_id='"+memo+"' and ";
				sqlstr+=" funds_mode='�տ�' and item_method='����' and status='0'";

				//System.out.println("sqlstr2===hhhj======="+proj_id);
				db.executeUpdate(sqlstr);
				sqlstr="update fund_fund_charge_plan set status='1' where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and status='0'";
				db.executeUpdate(sqlstr);
				System.out.println("sqlstr2===hhhj2======="+sqlstr);
				//�޸����ƻ����һ�����״̬
				sqlstr="update fund_rent_plan set plan_status='1',penalty=0 where proj_id='"+memo+"' and rent_list=1 ";
				db.executeUpdate(sqlstr);
				//System.out.println("sqlstr2===hhhj3======="+sqlstr);
				//���ʵ�ձ��������
				sqlstr="insert into fund_rent_income(proj_id,plan_list,hire_date,rent,corpus,interest,hire_object,hire_account,hire_number,rent_type,item_method) select '"+memo+"',rent_list,'"+fact_date+"',rent,corpus,interest,b.account_name,'�й���������',b.account,'���','����' from fund_rent_plan a left join proj_info b on a.proj_id=b.proj_id where a.proj_id='"+memo+"' and a.rent_list=1 "; 

				flag = db.executeUpdate(sqlstr);
			}else{//�ۿ�ʧ��
				//System.out.println("ʧ�ܣ���������������������������������������");
				sqlstr="update fund_fund_charge_plan set export_flag=NULL where proj_id='"+memo+"' and funds_mode='�տ�' and item_method='����' and isnull(status,0)=0 ";
				flag = db.executeUpdate(sqlstr);
			}
		}else{//
			bflag=false;
		}
	}
}
db.close();

if(bflag){
%>
<script>
		window.close();
		opener.alert("������ɣ��ۿ�ʧ����������������");
		opener.location.reload(true);
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("��������,�����ϴ��ļ�����,��ʽ�Ƿ�");
		opener.location.reload(true);
</script>
<% } %>