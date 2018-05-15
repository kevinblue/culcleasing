<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="com.*" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>

</head>

<BODY>
<%
	String dqczy = (String) session.getAttribute("czyid");
System.out.print("dqczy="+dqczy);
String sqlstr;
int i;
String contract_id;
String proj_id;
String sign_date;
String lineof_credit;
String credit_fact;
String credit_remain;
String guarantee_plan;
String plan_remain;
String income_remian;
String guarantee_income;
String remark;
String creator;
String create_date;
String modificator;
String modify_date;


String systemDate = getSystemDate(0);
String czy=(String) session.getAttribute("czyid");
System.out.print("czy="+czy);
proj_id=getStr(request.getParameter("proj_id"));
contract_id=getStr(request.getParameter("contract_id"));
System.out.print("contract_id="+contract_id);

//获取系统时间
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {          
		  // if(proj_id==null||"".equals(proj_id)){
		//		return; 
		//	}
          //  proj_id=getStr(request.getParameter("proj_id"));
            //contract_id=getStr(request.getParameter("contract_id"));
           // System.out.println("contract_id="+contract_id);
			sign_date=getStr(request.getParameter("sign_date"));
			lineof_credit=getStr(request.getParameter("lineof_credit"));
            credit_fact=getStr(request.getParameter("credit_fact"));
            credit_remain=getStr(request.getParameter("credit_remain"));
            guarantee_plan=getStr(request.getParameter("guarantee_plan"));
            plan_remain=getStr(request.getParameter("plan_remain"));
                  
            income_remian=getStr(request.getParameter("income_remian"));
            guarantee_income=getStr(request.getParameter("guarantee_income"));
            remark=getStr(request.getParameter("remark"));
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));  
      
            sqlstr="insert into mproj_guarantee_info(proj_id,contract_id,sign_date,lineof_credit,credit_fact,credit_remain,guarantee_plan,plan_remain,income_remian,guarantee_income,remark,creator,create_date,modificator,modify_date)";
            sqlstr+=" values ('"+proj_id+"','"+contract_id+"','"+sign_date+"','"+lineof_credit+"','"+credit_fact+"','"+credit_remain+"','"+guarantee_plan+"','"+plan_remain+"','"+income_remian+"','"+guarantee_income+"','"+remark+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
			System.out.println("ttt"+sqlstr);
            i=db.executeUpdate(sqlstr); 

%>
	<script>
	opener.window.location.href = "jsbzj_list.jsp";
		alert("增加成功!");
		this.close();
                //window.close();
               // opener.alert("添加成功!");
		//opener.location.reload();
	</script>
<%
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
            czy=getStr(request.getParameter("id"));
           contract_id=getStr(request.getParameter("contract_id"));
            contract_id=getStr(request.getParameter("lease_contract_num"));
           proj_id=getStr(request.getParameter("proj_id"));
            contract_id=getStr(request.getParameter("contract_id"));
			sign_date=getStr(request.getParameter("sign_date"));
			lineof_credit=getStr(request.getParameter("lineof_credit"));
            credit_fact=getStr(request.getParameter("credit_fact"));
            credit_remain=getStr(request.getParameter("credit_remain"));
            guarantee_plan=getStr(request.getParameter("guarantee_plan"));
            plan_remain=getStr(request.getParameter("plan_remain"));
                  
            income_remian=getStr(request.getParameter("income_remian"));
            guarantee_income=getStr(request.getParameter("guarantee_income"));
            remark=getStr(request.getParameter("remark"));
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));  
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));   
            
            sqlstr="update mproj_guarantee_info set sign_date='"+sign_date+"',lineof_credit='"+lineof_credit+"', credit_fact='"+credit_fact+"',credit_remain='"+credit_remain+"',guarantee_plan='"+guarantee_plan+"',plan_remain='"+plan_remain+"',income_remian='"+income_remian+"',guarantee_income='"+guarantee_income+"',remark='"+remark+"',creator='"+dqczy+"',create_date='"+systemDate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"'";
			sqlstr+=" where id="+czy;
			System.out.println(sqlstr);
            i=db.executeUpdate(sqlstr);
%>
	<script>
                ///window.close();
               /// opener.alert("修改成功!");
		///opener.location.reload();
		opener.window.location.href = "jsbzj_list.jsp";
		alert("修改成功!");
		this.close();
	</script>
<%

       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czy=getStr(request.getParameter("id"));
            sqlstr="delete from mproj_guarantee_info where id="+czy;
            i=db.executeUpdate(sqlstr); 
			

%>
	<script>
	opener.window.location.href = "jsbzj_list.jsp";
		alert("删除成功!");
		this.close();
               // window.close();
              //  opener.alert("删除成功!");
		//opener.location.reload();
	</script>
<%			
       }
}
db.close();
%>


</BODY>
</HTML>
