<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ���� - ֪ͨ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function endInform(obj,objType){
	//1)��׼  2)��׼��������������  3)��׼�з�Ϣ�޲���  4)��׼�з�Ϣ�ֲ���
	if( objType=="1" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice01?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}else if( objType=="2" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice02?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
		
	}else if( objType=="3" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice03?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}else if( objType=="4" ){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreateClearPayNotice04?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
	}
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="rent_modify_dept.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��ͬ���� &gt; ֪ͨ��
		</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = "";//��ͬ������Ŀ

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


countSql = "select count(id) as amount from vi_doc_inform_jq where 1=1 "+wherestr;

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
        <th>��ͬ���</th>
        <th>��Ŀ����</th>
        <th>���</th>
        <th>����</th>
          
        <th>�˿����(��ֵ����+��֤�𷵻�)</th>
        <th>ʣ�����</th>
        <th>ʣ�౾��</th>
        <th>ʣ����Ϣ</th>
        
        <th>�����ڴ�</th>
        <th>��������</th>
        <th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_doc_inform_jq where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_doc_inform_jq where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr += " order by id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	

		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_bzj_money" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_rent" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_corpus" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("sum_curr_interest" )) %></td>	

		<td align="center"><%=getDBStr( rs.getString("hire_rent_list")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("hire_plan_date")) %></td>	
				
		<td>
			<a onclick="Javascript:endInform('<%=getDBStr( rs.getString("begin_id")) %>','<%=rs.getString("in_type") %>')" target="_blank" title="�������֪ͨ��">
			<b style="color:#E46344;">�����غ�ͬ����֪ͨ�顷</b></a>
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
