<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ʵ�ձ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="rentQuery_rentPaid_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- ������ڱ���-->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		���ʵ�ձ���</td>
	</tr>
</table> 

<%
wherestr = "";

String parent_deptname = "";
sqlstr = "select parent_deptname from v_base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	parent_deptname = rs.getString("parent_deptname");
	wherestr = " and parent_deptname = '"+parent_deptname+"' ";
}else{
	wherestr = " and 1<>1 ";
}
rs.close();  

String qymc = getStr( request.getParameter("qymc") );
String sfmc = getStr( request.getParameter("sfmc") );
String dept_name = getStr( request.getParameter("dept_name") );//����
String project_name = getStr( request.getParameter("project_name") );
String board_name = getStr( request.getParameter("board_name") );
String manage_name = getStr( request.getParameter("manage_name") );
String qcmanage_name = getStr( request.getParameter("qcmanage_name") );
String plan_date_start = getStr( request.getParameter("plan_date_start") );
String plan_date_end = getStr( request.getParameter("plan_date_end") );
String hire_date_start = getStr( request.getParameter("hire_date_start") );
String hire_date_end = getStr( request.getParameter("hire_date_end") );

if(null !=qymc &&!"".equals(qymc)){
	wherestr += " and qymc = '"+qymc+"' "; 
}
if(null !=sfmc &&!"".equals(sfmc)){
	wherestr += " and sfmc = '"+sfmc+"' "; 
}
if(null !=dept_name &&!"".equals(dept_name)){
	wherestr += " and dept_name = '"+dept_name+"' "; 
}
if(null !=project_name &&!"".equals(project_name)){
	wherestr += " and project_name like '%"+project_name+"%' "; 
}
if(null !=board_name &&!"".equals(board_name)){
	wherestr += " and board_name = '"+board_name+"' "; 
}
if(null !=manage_name &&!"".equals(manage_name)){
	wherestr += " and manage_name = '"+manage_name+"' "; 
}
if(null !=qcmanage_name &&!"".equals(qcmanage_name)){
	wherestr += " and qcmanage_name = '"+qcmanage_name+"' "; 
}
if(plan_date_start!=null && !"".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"' and plan_date<='"+plan_date_end+"'";
}
if(plan_date_start!=null && !"".equals(plan_date_start) && "".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"'";
}
if("".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date <='"+plan_date_end+"'";
}
if(hire_date_start!=null && !"".equals(hire_date_start) && hire_date_end!=null && !"".equals(hire_date_end)){
	wherestr +=" and hire_date >= '"+hire_date_start+"' and hire_date<='"+hire_date_end+"'";
}
if(hire_date_start!=null && !"".equals(hire_date_start) && "".equals(hire_date_end)){
	wherestr +=" and hire_date >= '"+hire_date_start+"'";
}
if("".equals(plan_date_start) && hire_date_end!=null && !"".equals(hire_date_end)){
	wherestr +=" and hire_date <='"+hire_date_end+"'";
}
String expsqlstr = "select project_name as 'ʵ����Ŀ', plan_date as 'Ӧ������',plan_rent as 'Ӧ�ս��',hire_date as 'ʵ������',income_rent as 'ʵ�ս��',status as '״̬',parent_deptname as '��ҵ��',dept_name as '����',fund_status as '�ʽ�״̬',manage_name as '��Ŀ����',qcmanage_name as '�ʿؾ���' from  vi_report_ZJCX_rent_income where 1=1 "+wherestr+"order by project_name,id";
countSql = "select count(id) as amount from  vi_report_ZJCX_rent_income where 1=1 "+wherestr;

%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<!-- ��ѯ���� -->
<tr>
	<td scope="row">����
		<input style="width:150px;" name="qymc" id="qymc" type="text" value="<%=qymc %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('qymc.jsp',250,350)" >  
	</td>
	<td scope="row">ʡ�ݣ�<input style="width:150px;" name="sfmc" id="sfmc" type="text" value="<%=sfmc %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('sfmc.jsp',250,350)" >  
	</td>
	<td scope="row">������
		<input style="width:150px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('dept.jsp',250,350)" >  
	</td>
	<td scope="row">�ƻ�ʱ�䣺
����<input type="text" id="plan_date_start" name="plan_date_start"
	 readonly="readonly" 
	 value="<%=plan_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 ����<input type="text" id="plan_date_end" name="plan_date_end"
	 readonly="readonly" 
	value="<%=plan_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
</tr>
<tr>
	<td scope="row">��Ŀ���ƣ�
		<input style="width:150px;" name="project_name" id="project_name" type="text" value="<%=project_name %>" style="width: 100">
	</td>
	<td scope="row">ҵ���飺<input style="width:150px;" name="board_name" id="board_name" type="text" value="<%=board_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('board.jsp',250,350)" >  
	</td>
	<td scope="row">��Ŀ����
		<input style="width:150px;" name="manage_name" id="manage_name" type="text" value="<%=manage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('manage.jsp',250,350)" >  
	</td>
	<td scope="row">ʵ��ʱ�䣺
����<input type="text" id="hire_date_start" name="hire_date_start"
	 readonly="readonly" 
	 value="<%=hire_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 ����<input type="text" id="hire_date_end" name="hire_date_end"
	 readonly="readonly" 
	value="<%=hire_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
</tr>
<tr>
	<td scope="row">�ʿؾ���<input style="width:150px;" name="qcmanage_name" id="qcmanage_name" type="text" value="<%=qcmanage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('qcmanage.jsp',250,350)" >  
	</td>
<td align="right"> <input type="button" value="��ѯ" onclick="dataNav.submit();">
	<input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->
<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
		<td>
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="rent_paid">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','rentQuery_rentPaid_list.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
	    <!--������ť����-->
	    </td>
		
		<!-- ��ҳ���� -->
		<td width="60%" align="right"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->
		</td><!-- ��ҳ���� -->
</tr>
</table>

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>ʵ����Ŀ</th>
		<th>Ӧ������</th>
		<th>Ӧ�ս��</th>
		<th>ʵ������</th>
		<th>ʵ�ս��</th>
		<th>״̬</th>
		<th>��ҵ��</th>
		<th>����</th>
		<th>�ʽ�״̬</th>
		<th>��Ŀ����</th>
		<th>�ʿؾ���</th>
      </tr>
   <tbody id="data">
<%
String col = " id,project_name,plan_date,plan_rent,hire_date,income_rent,status,parent_deptname,dept_name,fund_status,manage_name,qcmanage_name,qymc,sfmc,board_name ";
sqlstr = "select top "+ intPageSize + col+" from vi_report_ZJCX_rent_income where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from  vi_report_ZJCX_rent_income where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by project_name,id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
%>
<%-- <tr><td>sqlstr</td><td colspan="100"><%=sqlstr %></td></tr>
<tr><td>expsqlstr</td><td colspan="100"><%=expsqlstr %></td></tr>
<tr><td>countSql</td><td colspan="100"><%=countSql %></td></tr> --%>
<%
while ( rs.next() ) {
%>   
     <tr >
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_rent"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("hire_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("income_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fund_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("qcmanage_name"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>  
     </tbody>
</table>
</div>
</form>

</body>
</html>
