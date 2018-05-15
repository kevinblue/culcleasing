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
<title>增值税发票领取-新增</title>
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
// 是否可以提交付款申请
function isSub(obj) {
	var names=document.getElementsByName("list");
	var statu=0;
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			statu++;
		}
	}
	if (statu==0) {
		alert("请选择您要申请的款项!");
		return false;
	} else{
		document.dataNav.action="apply_save.jsp";
		if (document.getElementById("method").value.length==0) {
			alert("请选择结算方式!");
			return false;
		} 
		return confirm("是否确认提交？");
	}
	return false;
}
</script>
</head>



<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//进入新增之后，插入申请单
 dqczy = (String) session.getAttribute("czyid");
String systemDate = getSystemDate(0);
String glide_id="";
sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='增值税发票领取'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	glide_id=getDBStr( rs.getString("glide_id") );
}rs.close();
sqlstr="insert into generate_no select '增值税发票领取','"+systemDate+"','"+glide_id+"'";
db.executeUpdate(sqlstr);
glide_id = "FP"+systemDate+"-"+glide_id;
	
//插入申请信息 
sqlstr="insert into apply_info (glide_id,type,is_sub,flow_status,status,amt,amount,plan_date,creator,create_date) ";
sqlstr+="values(";
sqlstr+="'"+glide_id+"','增值税发票领取','未提交','未通过','未核销','0','0','"+systemDate+"',";
sqlstr+="'"+dqczy+"','"+systemDate+"') ";
LogWriter.logDebug(request, "新增付款单："+sqlstr);
//执行语句
db.executeUpdate(sqlstr);

%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <h1>申请增值税发票</h1>
   
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		资金增值税发票&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		资金收据&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
   
   
  
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		利息增值税发票&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		租金收据&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
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