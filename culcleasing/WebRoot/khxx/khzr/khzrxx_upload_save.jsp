<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>

<%@ page import="java.util.regex.Pattern"%>
<%@ page import="com.TestTest"%>
<%@ page import="java.io.*"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>

<%
		List<String[]> excelValueList = TestTest.begin(request,response);
	//	for(String[] aaa:excelValueList){
	//		for(String zzz:aaa){
	//			System.out.print(zzz+"    ");
	//		}
	//		System.out.println();
	//	}

String dqczy = (String) session.getAttribute("czyid");
//��ȡϵͳʱ��
String datestr=getSystemDate(0); 
String sqlstr="";
ResultSet rs;
String uid="";


String bank_flag="";//��ִ�ɹ�,ʧ�ܱ�־


String memo="";//��ע

String fail_reason="";//ʧ��ԭ��
String creator_dept="";
String creator_deptname="";
String hire_number="";
int flag = 0;//����ɹ�������
int flag1 = 0;//�����ظ�������
			String create_dept;

			sqlstr = "select a.id,a.name,b.dept_name,a.department from base_user a left join base_department b on a.department=b.id  where a.id='" + dqczy + "'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				creator_dept = getDBStr(rs.getString("department"));
				creator_deptname = getDBStr(rs.getString("dept_name"));
			}

			System.out.println("��������="+creator_dept);
			rs.close();
//String rent_list[]=null;
String errMsg = "";
String s_cust_name="";
String s_parent_company="";
List<String> l_cust_name= new ArrayList<String>();
List<String> l_parent_company= new ArrayList<String>();
boolean bflag = true;
	sqlstr = "select cust_name,parent_company from cust_info ";
	rs = db.executeQuery(sqlstr);
	if (rs.next()){
		s_cust_name=getDBStr(rs.getString("cust_name"));
		s_parent_company=getDBStr(rs.getString("parent_company"));
		l_cust_name.add(s_cust_name);
		l_parent_company.add(s_parent_company);
	}
	rs.close();


	
	String cust_name="";//��Ӧ������
	String parent_company ="";//�����ֹ�˾
	String license_number="";//Ӫҵִ�պ�
	String cust_id="";//�û����
	String bank_name="";
	String acc_number="";
	String id_card_no="";
	String phone="";
	String work_add="";
	String account="";
	System.out.println("List����Ϊ==="+excelValueList.size());
	for(int i=2;i<excelValueList.size();i++){
		
		String [] a = excelValueList.get(i);
		for(int j=0;j<a.length;j++){


				if(j==1){//�����ֹ�˾
					parent_company =a[j].trim();
				}
				
				if(j==2){
					cust_name=a[j].trim().replace(" ","");
				}
				if(j==3){
				id_card_no=a[j].trim();//
				//license_number=a[j].trim();//Ӫҵִ�պ�
				
				}
				if( j==4 ){
				bank_name=a[j].trim();	
				}
				if(j==5){
				acc_number=a[j].replace(" ","");
				}
				if(j==6){
				license_number=a[j].trim();
				}
				if(j==7){
				phone=a[j].trim();
				}
				if(j==8){
				work_add=a[j].trim();
				}
			}
				//	if(l_cust_name.contains(a[2].toString())||l_parent_company.contains(a[1].toString()))
				//		continue;
				//	boolean l_flag_1=	l_cust_name.contains(a[2]);
				//	boolean l_flag_2=	l_cust_name.contains(a[2].toString());
				//	System.out.println("l_flag_1="+l_flag_1+"l_flag_2"+l_flag_2);
				//	for(int m=0;m<l_cust_name.size();m++){
				//	if(a[2].equalsIgnoreCase(l_cust_name.get(m)))
				//	continue for1;
				//	}
				//	for(int n=0;n<l_parent_company.size();n++){
				//	if(a[1].equalsIgnoreCase(l_parent_company.get(n)))
				//	continue for1;
				//	}
				//�ж��Ƿ����ݿ����Ѵ���
				sqlstr = "select * from cust_ewlp_info where cust_name='"+cust_name+"'";
				rs=db.executeQuery(sqlstr);
				if(rs.next())
				{
				flag1+=1;
				rs.close();
				continue;
				
				}else{
				rs.close();
				}
				//�����û�ID��ʼ
				sqlstr = "select top 1 cust_id from vi_cust_all_info_t order by cust_id desc";
				String temp_id = "";
                               
				System.out.println(sqlstr);
				rs = db.executeQuery(sqlstr);
				if (rs.next()) {
					temp_id = getDBStr(rs.getString("cust_id"));//������һ��������ID
                                     }
					if ((temp_id == null) || (temp_id.equals("")))
				temp_id = "00001";
                                     
					else {
				int num = 0;
				num = Integer.parseInt(temp_id);
				num++;
				String temp_id_max = String.valueOf(num);
				if (Integer.parseInt(temp_id_max) <= 9)
					temp_id_max = "0000"
					+ (Integer.parseInt(temp_id_max));
				else if (Integer.parseInt(temp_id_max) > 9
						&& Integer.parseInt(temp_id_max) <= 99)
					temp_id_max = "000"
					+ (Integer.parseInt(temp_id_max));
				else if (Integer.parseInt(temp_id_max) > 99
						&& Integer.parseInt(temp_id_max) <= 999)
					temp_id_max = "00"
					+ (Integer.parseInt(temp_id_max));
				else if (Integer.parseInt(temp_id_max) > 999
						&& Integer.parseInt(temp_id_max) <= 9999)
					temp_id_max = "0" + (Integer.parseInt(temp_id_max));
				else if (Integer.parseInt(temp_id_max) >= 100000)
					temp_id_max = "" + (Integer.parseInt(temp_id_max));

				temp_id = temp_id_max;
					}
                         
				
				rs.close();
   				System.out.println("2222222"+temp_id);
				cust_id = temp_id;
				if(cust_name==""||cust_name.equals(null))
				break;	
				sqlstr="insert into cust_ewlp_info(cust_id,cust_name,parent_company ,id_card_no,phone,work_add,license_number,creator,creator_dept,create_date,industry_type,industry_level1,industry_level2,industry_level3,industry_level4,cust_type,cust_type2) values(";
				sqlstr+="'"+cust_id+"','"+cust_name+"','"+parent_company +"','"+id_card_no+"','"+phone+"','"+work_add+"','"+license_number+"','"+dqczy+"','"+creator_dept+"','"+datestr+"','����','G','60','601','G6012','02','004')";
				
				System.out.print(sqlstr + "+++++++++++++++++");
				flag+= db.executeUpdate(sqlstr);
				//String sql2="insert into inter_cust_info(cust_id,cust_name) values('"+cust_id+"','"+cust_name+"')";
				//db.executeUpdate(sql2);
				
				sqlstr = "insert into cust_account (cust_id, acc_number, bank_name, account,  creator ,create_date,modificator,modify_date ) values ('" + cust_id + "','" + acc_number + "','" + bank_name + "','" + cust_name + "','" + dqczy + "','" + datestr +"','"+dqczy+"','"+datestr+"')";
				System.out.println("sqlstrsqlstr=="+sqlstr);
				db.executeUpdate(sqlstr); 
			//	message = "���˿ͻ��Ǽ�";	

				
	}

db.close();
if(flag1!=0){
errMsg="�ɹ�����"+flag+"������,�ظ�"+flag1+"������";
}else{
errMsg="�ɹ�����"+flag+"������";
}
System.out.println("errmsg:"+errMsg);

if(flag==0){
%>
<script>
		window.close();
		opener.alert("��Ǹ���ϴ����ִ���");
		opener.location.reload();
</script>

<%
}else{
%>
<script>
		window.close();
		opener.alert("�ϴ��ѳɹ�,<%=errMsg.substring(0, errMsg.length()-1) %>");
		opener.location.reload();
</script>

<% } %>