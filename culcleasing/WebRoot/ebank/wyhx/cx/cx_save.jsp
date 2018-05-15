<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl2" />
<%@ include file="../../func/common_simple.jsp"%>

<%
String czy = (String) session.getAttribute("czyid");
//��������
String sqlstr="";
ResultSet rs = null;
int flag = 0;
String id = request.getParameter("prId");

//�����ݿ�ȡ��excel�ļ�����
sqlstr = "select file_name,hire_bank from fund_rent_cx where id="+id;
System.out.println("ִ�г�����sql��"+sqlstr);
rs = db.executeQuery(sqlstr);
rs.next();
String fileName = rs.getString("file_name");
String hire_bank = rs.getString("hire_bank");
rs.close();

String path = pageContext.getServletContext().getRealPath("/");
String filePath =path + "\\rent_cx_upload\\"+fileName;
//--��־�ֶ�
String memo = "";
String plan_id = "";

//�ж��ǽ������л���ũҵ����
if("�й���������".equals(hire_bank)){//���еı����ļ�
	//����excel
	execlBean.setExecl(filePath);
	if(execlBean.getFlag()){
		String [][]obj = execlBean.getObject();
		for(int row=0;row<obj.length;row++){//�ӵ����п�ʼ
			String [] objrow = obj[row];	
			memo=objrow[4];//��ע��
			System.out.println("========"+memo);
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
			//�鿴���ΥԼ��
			if (memo.indexOf("_")>-1) {//��Ϣʱ
				//ɾ�����ʵ�ձ�����
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='ΥԼ��'";
				sqlstr += " where frp.id='"+plan_id+"')";
				System.out.println("========1"+sqlstr);
				//ִ�и���
				flag=db.executeUpdate(sqlstr);
			} else {//���ʱ
				//ɾ�����ʵ�ձ�����
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='���'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//�޸����ƻ����״̬�ֶ� status
				sqlstr += " update fund_rent_plan set plan_status=0,penalty_plan_date=null,penalty=null where id='"+plan_id+"'";
				//ִ�и���
				System.out.println("========2"+sqlstr);
				flag=db.executeUpdate(sqlstr);
			}
		}
	}
}else if("�й���������".equals(hire_bank)){
	List contentList = new ArrayList(0);
	File txtFile = new File(filePath);
	//��ȡ
	BufferedReader br = null;
	String titleStr = "";
	try {
		br=new BufferedReader(new FileReader(txtFile));
		//�ļ�ͷ
		titleStr = br.readLine();
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
		flag = 0;
		if( contStr!=null && !"".equals(contStr) ){
			String[] strSegment = contStr.trim().split("\\|");
			System.out.println(memo+"===habcTest======="+strSegment.length);
			//�ļ�ͷ����
			if(strSegment.length<10){
				continue;
			}
			String tempMemo=strSegment[7];//��־ֵ
			if(tempMemo.indexOf(":")==-1){
				continue;
			}
			memo = tempMemo.substring(tempMemo.indexOf(":")+1);
			//�õ�plan_id
			if(memo.indexOf(".0")!=-1){//0.0�Ĵ���
				memo = memo.substring(0, memo.lastIndexOf(".0"));
			}
			plan_id=memo.indexOf("_")>-1?memo.substring(0,memo.indexOf("_")):memo;			
			System.out.println("memo==================="+memo+"=="+plan_id);
			//�ж�plan_id�Ƿ�������
			Pattern pattern = Pattern.compile("[0-9]*");  
			if(!pattern.matcher(plan_id).matches()){
				continue;
			}
			
			//�鿴�Ƿ�Ϣ�������ĺ���
			if (memo.indexOf("_")>-1) {//��Ϣʱ
				//ɾ�����ʵ�ձ�����
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='ΥԼ��'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//ִ�и���
				flag=db.executeUpdate(sqlstr);
			} else {//���ʱ
				//ɾ�����ʵ�ձ�����
				sqlstr = " delete from fund_rent_income where id in(";
				sqlstr += " select fri.id from fund_rent_plan frp left join fund_rent_income fri";
				sqlstr += " on fri.proj_id=frp.proj_id and fri.plan_list=frp.rent_list and fri.rent_type='���'";
				sqlstr += " where frp.id='"+plan_id+"')";
				//�޸����ƻ����״̬�ֶ� status
				sqlstr += " update fund_rent_plan set plan_status=0,penalty_plan_date=null,penalty=null where id='"+plan_id+"'";
				//ִ�и���
				flag=db.executeUpdate(sqlstr);
			}
		}
	}
}
	
if(flag>0){
	//���¸������״̬
	sqlstr="update fund_rent_cx set cx_status=1,modifycator='"+czy+"',modify_date='"+getSystemDate(0)+"' where id="+id;
	System.out.println("������������ͨ��:"+sqlstr);
	db.executeUpdate(sqlstr);
%>
<script>
		window.close();
		opener.alert("��������");
		opener.location.reload();
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("�����ʧ��,�����ϴ��ļ����ݵĸ�ʽ�Ƿ�Ϸ�");
		opener.location.reload();
</script>
<% } %>