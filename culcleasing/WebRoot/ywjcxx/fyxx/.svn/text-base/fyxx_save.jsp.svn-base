<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<%
String sqlstr;
ResultSet rs;
String czy_name="";
String czy=(String) session.getAttribute("czyid");
System.out.println(czy+"122222222222222");
sqlstr="select name from base_user where id='"+czy+"' ";
//sqlstr=" select xm from jb_yhxx where id='"+czy+"' ";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	//czy_name=getDBStr(rs.getString("xm"));
          czy_name=getDBStr(rs.getString("name"));
}
int i;
String czid;
String feetype_number="";
String feetype_number1;
String subject_number;
String cdigest;
String auxiliary_account;
String flow_name;
String handle_flag;
String modify_date;
String modificator;
			feetype_number1=getStr(request.getParameter("feetype_number"));
            subject_number=getStr(request.getParameter("subject_number"));
            cdigest=getStr(request.getParameter("cdigest"));
			flow_name=getStr(request.getParameter("flow_name"));
			handle_flag=getStr(request.getParameter("handle_flag"));
			
			
			String sqlt="select feetype_number from base_feetype where feetype_name='"+feetype_number1+"'";
			rs=db.executeQuery(sqlt); 
			if (rs.next()) {
			feetype_number=getDBStr(rs.getString("feetype_number"));
			}
			rs.close();
			System.out.println("feetype_number=="+feetype_number);
			if(handle_flag.equals("借")){
				handle_flag="1";
			}else{
				handle_flag="2";
			}
				
       		String a[]=request.getParameterValues("auxiliary_account");
       		String [] temp ={"0","0","0","0"};
       		for(int j=0;j<a.length;j++){
       			if(a[j].equals("1")){
       				temp[0] = "1";
       			}else if(a[j].equals("2")){
       				temp[1] = "1";
       			}else if(a[j].equals("3")){
       				temp[2] = "1";
       			}else if(a[j].equals("4")){
       				temp[3] = "1";
       			}
       		}
auxiliary_account=temp[0]+temp[1]+temp[2]+temp[3];
//获取系统时间
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {	

			
           
            sqlstr="insert into inter_fee_subject_join(feetype_number,subject_number,cdigest,auxiliary_account,flow_name,handle_flag,modify_date,modificator) values ('"+feetype_number+"','"+subject_number+"','"+cdigest+"','"+auxiliary_account+"','"+flow_name+"','"+handle_flag+"',"+datestr+",'"+czy_name+"')";
            System.out.println("======="+sqlstr);
            i=db.executeUpdate(sqlstr); 
			%>
				<script>
                window.close();
                opener.alert("添加成功!");
				opener.location.reload();
				</script>
            <%           
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
       			czid=getStr(request.getParameter("kid"));
 
            sqlstr="update inter_fee_subject_join set feetype_number='"+feetype_number+"',subject_number='"+subject_number+"',cdigest='"+cdigest+"',auxiliary_account='"+auxiliary_account+"',flow_name='"+flow_name+"',handle_flag='"+handle_flag+"',modify_date="+datestr+",modificator='"+czy_name+"' where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from inter_fee_subject_join where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("删除成功!");
				opener.location.reload();
				</script>
			<%
       }   
%>
<%
}
db.close();
%>
</BODY>
</HTML>