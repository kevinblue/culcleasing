<%@ page contentType="text/html; charset=gbk" language="java" %>

<%
//�ж�session�Ƿ�ʧ
if( dqczy!=null && !"".equals(dqczy) ){
	//�жϴ����̻������޹�˾
	String filterAgent = "";
	String loginBmbh = "";//��¼�û��Ĳ��ű��
	sqlstr="select bmbh from jb_yhxx where id='"+ dqczy +"'";
	//ִ�в�ѯ
	rs = db.executeQuery(sqlstr);
	if (rs.next()){
		loginBmbh = rs.getString("bmbh");
		try{
			Integer.parseInt(loginBmbh);
		}catch(Exception e){//������
			filterAgent ="  and bmbh = '"+ loginBmbh +"' ";
		}
		if( "".equals(loginBmbh) ){//�����﹫˾���ű��Ϊ���ֻ�""
			filterAgent = "";
		}
	}else {//�������
		System.out.println("++++Ȩ�޶�ʧ++++");
	}
}else{%>
	<script language="javascript">
	window.parent.parent.location.replace("http://online.strongflc.com/names.nsf?logout");
	</script> 
<%
}
%>
