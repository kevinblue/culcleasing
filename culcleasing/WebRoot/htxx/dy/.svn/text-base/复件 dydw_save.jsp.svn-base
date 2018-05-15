<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="com.*" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>

</head>

<BODY>
<%
	String dqczy = (String) session.getAttribute("czyid");
String sqlstr;
int i;
String contract_id;
String equip_guarantee_type;

String guarantor;
String ID_number;
String equip_num;
String total_price;
String equip_place;
String equip_sn;
String ownership_document;

String creator;
String create_date;
String modificator;
String modify_date;

String registraction_authority;
String zheng_hao;
String eqip_name;
String systemDate = getSystemDate(0);
String czy=(String) session.getAttribute("czyid");
contract_id=getStr(request.getParameter("contract_id"));


//获取系统时间
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {          
		   if(contract_id==null||"".equals(contract_id)){
				return; 
			}
            equip_guarantee_type=getStr(request.getParameter("equip_guarantee_type"));
             contract_id=getStr(request.getParameter("lease_contract_num"));
			eqip_name=getStr(request.getParameter("eqip_name"));
			registraction_authority=getStr(request.getParameter("registraction_authority"));
			zheng_hao=getStr(request.getParameter("zheng_hao"));
            guarantor=getStr(request.getParameter("guarantor"));
            ID_number=getStr(request.getParameter("ID_number"));
            equip_num=getStr(request.getParameter("equip_num"));
            total_price=getStr(request.getParameter("total_price"));
                  
            equip_place=getStr(request.getParameter("equip_place"));
            equip_sn=getStr(request.getParameter("equip_sn"));
            ownership_document=getStr(request.getParameter("ownership_document"));
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));       

            if (total_price.equals("")) total_price="0";
            sqlstr="insert into contract_guarantee_equip(contract_id,eqip_name,zheng_hao,registraction_authority,equip_guarantee_type,guarantor,ID_number,equip_num,total_price,equip_place,equip_sn , ownership_document,creator,create_date,modificator,modify_date)";
            sqlstr+=" values ('"+contract_id+"','"+eqip_name+"','"+zheng_hao+"','"+registraction_authority+"','"+equip_guarantee_type+"','"+guarantor+"','"+ID_number+"','"+equip_num+"','"+total_price+"','"+equip_place+"','"+equip_sn+"','"+ownership_document+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
			System.out.println("ttt"+sqlstr);
            i=db.executeUpdate(sqlstr); 

%>
	<script>
	opener.window.location.href = "dydw_list.jsp";
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
            equip_guarantee_type=getStr(request.getParameter("equip_guarantee_type"));
			eqip_name=getStr(request.getParameter("eqip_name"));
            guarantor=getStr(request.getParameter("guarantor"));
            ID_number=getStr(request.getParameter("ID_number"));
            equip_num=getStr(request.getParameter("equip_num"));
            total_price=getStr(request.getParameter("total_price"));
            registraction_authority=getStr(request.getParameter("registraction_authority"));
            equip_place=getStr(request.getParameter("equip_place"));
            equip_sn=getStr(request.getParameter("equip_sn"));
            ownership_document=getStr(request.getParameter("ownership_document"));
            zheng_hao=getStr(request.getParameter("zheng_hao"));
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));   
            
            sqlstr="update contract_guarantee_equip set zheng_hao='"+zheng_hao+"',registraction_authority='"+registraction_authority+"', equip_guarantee_type='"+equip_guarantee_type+"',eqip_name='"+eqip_name+"',guarantor='"+guarantor+"',ID_number='"+ID_number+"',equip_num='"+equip_num+"',total_price='"+total_price+"',equip_place='"+equip_place+"',equip_sn='"+equip_sn+"',ownership_document='"+ownership_document+"',creator='"+dqczy+"',create_date='"+systemDate+"',modificator='"+dqczy+"',modify_date='"+systemDate+"'";
			sqlstr+=" where id="+czy;
			System.out.println(sqlstr);
            i=db.executeUpdate(sqlstr);
%>
	<script>
                ///window.close();
               /// opener.alert("修改成功!");
		///opener.location.reload();
		opener.window.location.href = "dydw_list.jsp";
		alert("修改成功!");
		this.close();
	</script>
<%

       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czy=getStr(request.getParameter("id"));
            sqlstr="delete from contract_guarantee_equip where id="+czy;
            i=db.executeUpdate(sqlstr); 
			

%>
	<script>
	opener.window.location.href = "dydw_list.jsp";
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
