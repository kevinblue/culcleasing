<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ֵ˰��Ʊ��ȡ-����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
// �Ƿ�����ύ��������
function isSub(obj) {
	var names=document.getElementsByName("list");
	var statu=0;
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			statu++;
		}
	}
	if (statu==0) {
		alert("��ѡ����Ҫ����Ŀ���!");
		return false;
	} else{
		document.dataNav.action="apply_save.jsp";
		if (document.getElementById("method").value.length==0) {
			alert("��ѡ����㷽ʽ!");
			return false;
		} 
		return confirm("�Ƿ�ȷ���ύ��");
	}
	return false;
}
</script>
</head>



<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<%
//��������֮�󣬲������뵥
 dqczy = (String) session.getAttribute("czyid");
String systemDate = getSystemDate(0);
String glide_id="";
sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='��ֵ˰��Ʊ��ȡ'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	glide_id=getDBStr( rs.getString("glide_id") );
}rs.close();
sqlstr="insert into generate_no select '��ֵ˰��Ʊ��ȡ','"+systemDate+"','"+glide_id+"'";
db.executeUpdate(sqlstr);
glide_id = "FP"+systemDate+"-"+glide_id;
	
//����������Ϣ 
sqlstr="insert into apply_info (glide_id,type,is_sub,flow_status,status,amt,amount,plan_date,creator,create_date) ";
sqlstr+="values(";
sqlstr+="'"+glide_id+"','��ֵ˰��Ʊ��ȡ','δ�ύ','δͨ��','δ����','0','0','"+systemDate+"',";
sqlstr+="'"+dqczy+"','"+systemDate+"') ";
LogWriter.logDebug(request, "���������"+sqlstr);
//ִ�����
db.executeUpdate(sqlstr);

%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <h1>������ֵ˰��Ʊ</h1>
   
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		�ʽ���ֵ˰��Ʊ&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		�ʽ��վ�&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
   
   
  
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		��Ϣ��ֵ˰��Ʊ&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		����վ�&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
</div>
</body>
</html>
<%if(null != db){db.close();}%>