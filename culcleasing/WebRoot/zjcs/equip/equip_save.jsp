<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("id") );
String contract_id = getStr( request.getParameter("contract_id") );

String eqip_name = getStr( request.getParameter("eqip_name") );
String equip_num = getStr( request.getParameter("equip_num") );
String equip_price = getStr( request.getParameter("equip_price") );
String total_price = getStr( request.getParameter("total_price") );
String distributor = getStr( request.getParameter("distributor") );
String equip_team = getStr( request.getParameter("equip_team") );
String equip_rent = getStr( request.getParameter("equip_rent") );
String equip_type = getStr( request.getParameter("equip_type") );
String equip_dispose = getStr( request.getParameter("equip_dispose") );
String memo = getStr( request.getParameter("memo") );



String stype = getStr( request.getParameter("savetype") );
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){    
    //添加操作
   sqlstr="insert into contract_equip_temp(contract_id,eqip_name,equip_num,equip_price,total_price,distributor,equip_team,equip_rent,equip_type,equip_dispose,memo,create_date) values ";
   sqlstr+="('"+contract_id+"','"+eqip_name+"','"+equip_num+"','"+equip_price+"','"+total_price+"','"+distributor+"','"+equip_team+"','"+equip_rent+"','"+equip_type+"','"+equip_dispose+"','"+memo+"',"+datestr+")" ;
		
		%>
       /// <script>
		//alert(<%=sqlstr %>);
		//</script>
        <%
		System.out.println("sqlstrsqlstr=="+sqlstr);
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
			sqlstr="select @@identity as id";
			rs = db.executeQuery(sqlstr);
			if(rs.next()){
				czid=rs.getString("id");
			}
			rs.close();
%>
		<script>
		 
			//window.location.href = "khzygr.jsp?czid=<%=czid%>";
			
			window.close();
		opener.alert("增加成功!");
		opener.location.reload();
			//--opener.location.reload();
	
		//	window.alert("添加成功!");
			//window.location.href = "khzygr.jsp?czid=<%=czid%>";
			//opener.window.location.href = "khzygr_list.jsp";
		//alert("添加成功!");
		//this.close();
		</script>
<%
		}else{
%>
		<script>
			window.close();
			opener.alert("添加失败!");
			opener.location.reload();
		
		</script>
<%			
		}
}
if ( stype.equals("mod") ){      //修改操作	
								//eqip_name,equip_num,equip_price,total_price,distributor,equip_team,equip_rent,equip_type,equip_dispose,memo,create_date
		sqlstr = "update contract_equip_temp set eqip_name='" + eqip_name + "',equip_num='" + equip_num + "',equip_price='" + equip_price + "',total_price='" + total_price + "',distributor='" + distributor + "',equip_team='" + equip_team  + "',equip_rent='" + equip_rent  + "',equip_type='" + equip_type  + "',equip_dispose='" + equip_dispose  + "',memo='"+memo+"',modify_date="+datestr+" where id='" + czid + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>
			//opener.location.reload();
			//window.alert("修改成功!");
			//window.location.href = "khzygr.jsp?czid=<%=czid%>";
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("修改失败!");
			window.history.go(-1);
		</script>
<%
		}
}
if ( stype.equals("del") ){         //删除操作
	sqlstr = "delete from contract_equip_temp where id='" + czid + "'";
	int i=0;
	i=db.executeUpdate(sqlstr); 
	if(i!=0){
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
		//opener.window.location.href = "khzygr_list.jsp";
		//alert("删除成功!");
		//this.close();
	</script>
<%	
	}else{
%>
	<script>
		window.alert("删除失败!");
		window.history.go(-1);
	</script>
<%		
	}
}
db.close();
%>


</BODY>
</HTML>
