<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ΥԼ����� - ֪ͨ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function penaltyInform(obj,penal){
	window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreatePenaltyPayNoticeN?openagent&id="+obj+"&penal="+penal,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="penalty_word_dept.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		ΥԼ����� &gt; ֪ͨ��</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = "";

//���ݲ�������������
String deptId = getStr(request.getParameter("deptId"));

//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );

if ( deptId!=null && !"".equals(deptId) ) {
	wherestr += " and proj_dept = '" + deptId + "'";
}else{
	//����ʾ
	wherestr += " and 1=2";
}

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}


countSql = "select count(id) as amount from vi_doc_inform_fx where 1=1 "+wherestr;

%>
 <input type="hidden" value="<%=deptId %>" name="deptId"/>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="20" value="<%=project_name %>"></td>

<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>��Ŀ����</th>
        <th>������</th>
        <th>������</th>
        
        <th>��������</th>
        <th>��Ŀ����</th>
        <th>��Ϣ�ܶ�</th>
        
        <th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_doc_inform_fx where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_doc_inform_fx where 1=1 "+wherestr+" order by begin_id ) "+wherestr ;
sqlstr += " order by begin_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("begin_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>
			
		<td align="left"><%=getDBStr( rs.getString("dept_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_penalty" )) %></td>	
		<td>
			<a onclick="Javascript:penaltyInform('<%=getDBStr( rs.getString("begin_id")) %>','<%=rs.getString("sum_curr_penalty") %>')" target="_blank" title="���ط�Ϣ����֪ͨ��">
			<b style="color:#E46344;">�����ط�Ϣ����֪ͨ�顷</b></a>
		</td>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
</body>
</html>
