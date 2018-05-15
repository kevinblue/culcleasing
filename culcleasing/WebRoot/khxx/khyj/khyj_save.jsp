<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>客户信息 - 客户移交</title>
</head>

<BODY>
<%
	//基础变量
	String sqlstr = "";
	ResultSet rs=null;
	String systemDate = getSystemDate(4); //获取系统时间,精确到秒
	
	//获取表单参数
	String dqczy = (String) session.getAttribute("czyid");
	String stype=getStr(request.getParameter("savetype"));
	
	String cust_code1=getStr(request.getParameter("cust_code"));
	String czid = getStr(request.getParameter("cust_id"));
	String yj_remark = getStr(request.getParameter("yj_remark"));
	String yhid=getStr(request.getParameter("yhid"));
	String khstr=getStr(request.getParameter("khstr"));
	LogWriter.logDebug(request, "移交用户："+czid+" 客户类型："+cust_code1+" 要移交给："+yhid);
	// System.out.println(cust_code+"cust_code");
	
	//在这判断
if (stype.equals("yj")){        //移交操作
	String djbm="";
	//sqlstr="select bm from v_yhxx where id='"+yhid+"'";
	sqlstr="select department from v_base_user where id='"+yhid+"'";
	rs=db.executeQuery(sqlstr); 
	if (rs.next())
    {
		djbm=rs.getString("department");
	}
	//插入客户转移信息
	sqlstr = "insert into cust_transfer(cust_id,old_manager,old_dept_no,now_manager,new_dept_no,transfer_date,ctmemo,creator,create_date)";
	sqlstr +="select cust_id,creator_code,creator_dept,'"+yhid+"','"+djbm+"','"+systemDate+"','"+yj_remark+"','"+dqczy+"','"+systemDate+"' from vi_cust_all_info_t where cust_id='"+czid+"'";
	db.executeUpdate(sqlstr);
	//修改客户的信息
	if(cust_code1.equals("法人"))
	{
//		sqlstr="update cust_info set creator='"+yhid+"',create_date='"+systemDate+"',creator_dept='"+djbm+"' "+khstr;
//		sqlstr="update cust_info set creator='"+yhid+"',create_date='"+systemDate+"' "+khstr;
		sqlstr="update cust_info set creator='"+yhid+"',creator_dept='"+djbm+"',create_date='"+systemDate+"' "+khstr;
		System.out.print("法人"+sqlstr);
		db.executeUpdate(sqlstr); 
	}else{
//		sqlstr="update cust_ewlp_info set creator='"+yhid+"',create_date='"+systemDate+"',creator_dept='"+djbm+"' "+khstr;
//代工原先说过客户项目经理转移，但客户所属部门是不允许转移的。
//		sqlstr="update cust_ewlp_info set creator='"+yhid+"',create_date='"+systemDate+"' "+khstr;
		sqlstr="update cust_ewlp_info set creator='"+yhid+"',creator_dept='"+djbm+"',create_date='"+systemDate+"' "+khstr;
		System.out.println("个人"+sqlstr);
		db.executeUpdate(sqlstr); 
	}
	//访问权限支持
	sqlstr = "insert into cust_query_power(cust_id,query_user_id) values('"+czid+"','"+yhid+"')";
	db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "客户关系管理", "客户转移", "移交用户："+czid+" 客户类型："+cust_code1+" 要移交给："+yhid, sqlstr);
	//System.out.println(sqlLog+"..........");
	db.executeUpdate(sqlLog);
	db.close();
}
%>

<script type="text/javascript">
//window.location.href = "khyj_list.jsp";
window.close();
opener.alert("移交成功!");
opener.location.reload();
//opener.location.reload();
   

///.//this.close();
///	opener.window.location.href = "khyj_list.jsp";
////alert("移交成功!");
////this.close();
      //- window.close();
      //- opener.alert("移交成功!");			 
	//-opener.location="khyj_list.jsp";
	//this.close();
          //opener.location="khmpxxyj_list.jsp";
	//opener.opener.location.reload();
         //window.location.href.reload();
	//opener.location.reload();
</script>
</body>
</html>