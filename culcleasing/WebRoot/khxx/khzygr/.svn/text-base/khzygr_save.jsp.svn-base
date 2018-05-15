<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

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
String cust_id = getStr( request.getParameter("cust_id") );
String name = getStr( request.getParameter("name") );
//2012-3-29
String msg_recieved=getStr( request.getParameter("msg_recieved") );
System.out.println("aaaaaaaaaaaaaaaaaaaa"+msg_recieved);
String sex = getStr( request.getParameter("sex") );
String person_character = getStr( request.getParameter("person_character") );
String age = getStr( request.getParameter("age") );
if ( age.equals("") ) age = "0";
String workyear = getStr( request.getParameter("workyear") );
if ( workyear.equals("") ) workyear = "0";
String certificate = getStr( request.getParameter("certificate") );
String certificate_no = getStr( request.getParameter("certificate_no") );
String main_person_flag = getStr( request.getParameter("main_person_flag") );
String birth_date = getStr( request.getParameter("birth_date") );
String native_place = getStr( request.getParameter("native_place") );
String phone = getStr( request.getParameter("phone") );
String mobile_number = getStr( request.getParameter("mobile_number") );
String fax = getStr( request.getParameter("fax") );
String graduate_school = getStr( request.getParameter("graduate_school") );
String major = getStr( request.getParameter("major") );
String e_mail = getStr( request.getParameter("e_mail") );
String hobbies = getStr( request.getParameter("hobbies") );
String jobposition = getStr( request.getParameter("jobposition") );
String subject_field = getStr( request.getParameter("subject_field") );
String social_duty = getStr( request.getParameter("social_duty") );
String academic_duty = getStr( request.getParameter("academic_duty") );
String spouse = getStr( request.getParameter("spouse") );
String children = getStr( request.getParameter("children") );
String managial_style = getStr( request.getParameter("managial_style") );
String memo = getStr( request.getParameter("memo") );
String domicile_place = getStr( request.getParameter("domicile_place") );
String work_unit = getStr( request.getParameter("work_unit") );
String unit_add = getStr( request.getParameter("unit_add") );
String unit_duty = getStr( request.getParameter("unit_duty") );
String education = getStr( request.getParameter("education") );

String id_card_no = getStr( request.getParameter("id_card_no") );

String id=getStr( request.getParameter("id"));
String service_life=getStr(request.getParameter("service_life"));
String Managial_style=getStr(request.getParameter("Managial_style"));
String creator=getStr(request.getParameter("creator"));
String create_date=getStr(request.getParameter("create_date"));
String modificator=getStr(request.getParameter("modificator"));
String modify_date=getStr(request.getParameter("modify_date"));
String res_project=getStr(request.getParameter("res_project"));
String stype = getStr( request.getParameter("savetype") );
String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){    
    //添加操作
   sqlstr="insert into cust_person(cust_id,name,msg_recieved,sex,person_character,age,service_life,main_person_flag,birth_date,native_place,phone,mobile_number,fax,graduate_school,major,education,e_mail,hobbies,jobposition,subject_field,academic_duty,spouse,children,managial_style,social_duty,memo,creator,create_date,modificator,modify_date,res_project) values('"+cust_id+"','"+name+"','"+msg_recieved+"','"+sex+"','"+person_character+"','"+age+"','"+service_life+"','"+main_person_flag+"','"+birth_date+"','"+native_place+"','"+phone+"','"+mobile_number+"','"+fax+"','"+graduate_school+"','"+major+"','"+education+"','"+e_mail+"','"+hobbies+"','"+jobposition+"','"+subject_field+"','"+academic_duty+"','"+spouse+"','"+children+"','"+managial_style+"','"+social_duty+"','"+memo+"','"+dqczy+"',"+datestr+",'"+dqczy+"',"+datestr+",'"+res_project+"')" ;
		
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
		sqlstr = "update cust_person set name='" + name + "',msg_recieved='"+msg_recieved+"',sex='" + sex + "',person_character='" + person_character + "',age='" + age + "',service_life='" + service_life + "',main_person_flag='" + main_person_flag  + "',birth_date='" + birth_date  + "',native_place='" + native_place  + "',phone='" + phone  + "',mobile_number='"+mobile_number+"',fax='" + fax  + "',graduate_school='" + graduate_school  + "',major='" + major  + "',education='"+education+"',e_mail='" + e_mail  + "',hobbies='" + hobbies  + "',jobposition='" + jobposition  + "',subject_field='" + subject_field  + "',academic_duty='" + academic_duty  + "',social_duty='" + social_duty  + "',spouse='" + spouse  + "',children='" + children  + "',managial_style='" + managial_style  + "',memo='" + memo  + "',modificator='" + dqczy  + "',modify_date="+datestr+",res_project='"+res_project+"' where id='" + czid + "'";
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
	sqlstr = "delete from cust_person where id='" + czid + "'";
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
