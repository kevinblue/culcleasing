<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ѯ</title>
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
<form action="rentQuery_rentQuery_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- ������ڱ���-->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		����ѯ</td>
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

String page_date_start = getStr( request.getParameter("page_date_start") );
String page_date_end = getStr( request.getParameter("page_date_end") );
String plan_date_start = getStr( request.getParameter("plan_date_start") );
String plan_date_end = getStr( request.getParameter("plan_date_end") );
String last_hire_date_start = getStr( request.getParameter("last_hire_date_start") );
String last_hire_date_end = getStr( request.getParameter("last_hire_date_end") );
String dept_name = getStr( request.getParameter("dept_name") );//����
String project_name = getStr( request.getParameter("project_name") );
String manage_name = getStr( request.getParameter("manage_name") );
String proj_id = getStr( request.getParameter("proj_id") );
String board_name = getStr( request.getParameter("board_name") );
String leas_type = getStr( request.getParameter("leas_type") );
String qymc = getStr( request.getParameter("qymc") );
String qcmanage_name = getStr( request.getParameter("qcmanage_name") );
String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String receipt_bank = getStr( request.getParameter("receipt_bank") );

if(page_date_start!=null && !"".equals(page_date_start) && page_date_end!=null && !"".equals(page_date_end)){
	wherestr +=" and plan_date >= '"+page_date_start+"' and plan_date<='"+page_date_end+"'";
}
if(page_date_start!=null && !"".equals(page_date_start) && "".equals(page_date_end)){
	wherestr +=" and plan_date >= '"+page_date_start+"'";
}
if("".equals(page_date_start) && page_date_end!=null && !"".equals(page_date_end)){
	wherestr +=" and plan_date <='"+page_date_end+"'";
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
if(last_hire_date_start!=null && !"".equals(last_hire_date_start) && last_hire_date_end!=null && !"".equals(last_hire_date_end)){
	wherestr +=" and plan_date >= '"+last_hire_date_start+"' and plan_date<='"+last_hire_date_end+"'";
}
if(last_hire_date_start!=null && !"".equals(last_hire_date_start) && "".equals(last_hire_date_end)){
	wherestr +=" and plan_date >= '"+last_hire_date_start+"'";
}
if("".equals(last_hire_date_start) && last_hire_date_end!=null && !"".equals(last_hire_date_end)){
	wherestr +=" and plan_date <='"+last_hire_date_end+"'";
}
if(null !=dept_name &&!"".equals(dept_name)){
	wherestr += " and dept_name = '"+dept_name+"' "; 
}
if(null !=manage_name &&!"".equals(manage_name)){
	wherestr += " and manage_name = '"+manage_name+"' "; 
}
if(null !=board_name &&!"".equals(board_name)){
	wherestr += " and board_name = '"+board_name+"' "; 
}
if(null !=project_name &&!"".equals(project_name)){
	wherestr += " and project_name like '%"+project_name+"%' "; 
}
if(null !=proj_id &&!"".equals(proj_id)){
	wherestr += " and proj_id like '%"+proj_id+"%' "; 
}
if(null !=leas_type &&!"".equals(leas_type)){
	wherestr += " and leas_type = '"+leas_type+"' "; 
}
if(null !=qymc &&!"".equals(qymc)){
	wherestr += " and qymc = '"+qymc+"' "; 
}
if(null !=qcmanage_name &&!"".equals(qcmanage_name)){
	wherestr += " and qcmanage_name = '"+qcmanage_name+"' "; 
}
if(null !=plan_bank_name &&!"".equals(plan_bank_name)){
	wherestr += " and plan_bank_name = '"+plan_bank_name+"' "; 
}
if(null !=receipt_bank &&!"".equals(receipt_bank)){
	wherestr += " and receipt_bank = '"+receipt_bank+"' "; 
}
String expsqlstr = "select page_date as 'ҳ������', plan_date as 'Ӧ������',parent_deptname as '����',dept_name as '����',proj_id as '��Ŀ���',project_name as '��Ŀ����',rent_list as '����ڴ�' ,rent_diff as '������',rent as 'Ӧ�ս��',last_hire_date as 'ʵ������',fact_rent as 'ʵ�ս��',corpus_overage as 'ʣ�౾��',plan_bank_name as '������˻�',receipt_bank as '���ʵ�����˻�',rent_status as '�ʽ�״̬',manage_name as '��Ŀ����',qcmanage_name as '�ʿؾ���' from  vi_report_ZJCX_rent where 1=1 "+wherestr+"order by project_name,rent_list,id";
countSql = "select count(id) as amount from  vi_report_ZJCX_rent where 1=1 "+wherestr;

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
	<td scope="row">������
		<input style="width:150px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('dept.jsp',250,350)" >  
	</td>
	<td scope="row">��Ŀ����
		<input style="width:150px;" name="manage_name" id="manage_name" type="text" value="<%=manage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('manage.jsp',250,350)" >  
	</td>
	<td scope="row">��Ŀ���ƣ�
		<input style="width:150px;" name="project_name" id="project_name" type="text" value="<%=project_name %>" style="width: 100">
	</td>
	<td scope="row">ҳ��ʱ�䣺
����<input type="text" id="page_date_start" name="page_date_start"
	 readonly="readonly" 
	 value="<%=page_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 ����<input type="text" id="page_date_end" name="page_date_end"
	 readonly="readonly" 
	value="<%=page_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	</td>
</tr>
<tr>
	<td scope="row">��Ŀ��ţ�
		<input style="width:150px;" name="proj_id" id="proj_id" type="text" value="<%=proj_id %>" style="width: 100">
	</td>
	<td scope="row">��Ŀ������飺<input style="width:150px;" name="board_name" id="board_name" type="text" value="<%=board_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('board.jsp',250,350)" >  
	</td>
	<td scope="row">�������ͣ�<input style="width:150px;" name="leas_type" id="leas_type" type="text" value="<%=leas_type %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('rent_leas.jsp',250,350)" >  
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
	<td scope="row">����
		<input style="width:150px;" name="qymc" id="qymc" type="text" value="<%=qymc %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('qymc.jsp',250,350)" >  
	</td>
	<td scope="row">���Ӧ�����˻���<input style="width:130px;" name="plan_bank_name" id="plan_bank_name" type="text" value="<%=plan_bank_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('rent_plan_bank.jsp',250,350)" >  
	</td>
	<td scope="row">���ʵ�����˻���<input style="width:130px;" name="receipt_bank" id="receipt_bank" type="text" value="<%=receipt_bank %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('rent_receipt.jsp',250,350)" >  
	</td>
	<td scope="row">ʵ��ʱ�䣺
����<input type="text" id="last_hire_date_start" name="last_hire_date_start"
	 readonly="readonly" 
	 value="<%=last_hire_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 ����<input type="text" id="last_hire_date_end" name="last_hire_date_end"
	 readonly="readonly" 
	value="<%=last_hire_date_end %>"
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
		<input name="excel_name" type="hidden" value="rent_query">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','rentQuery_rentQuery_list.jsp');">
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
	    <th>ҳ������</th>
		<th>Ӧ������</th>
		<th>����</th>
		<th>����</th>
		<th>��Ŀ���</th>
		<th>��Ŀ����</th>
		<th>����ڴ�</th>
		<th>������</th>
		<th>Ӧ�ս��</th>
		<th>ʵ������</th>
		<th>ʵ�ս��</th>
		<th>ʣ�౾��</th>
		<th>������˻�</th>
		<th>���ʵ�����˻�</th>
		<th>�ʽ�״̬</th>
		<th>��Ŀ����</th>
		<th>�ʿؾ���</th>
      </tr>
   <tbody id="data">
<%
String col = " id,page_date,plan_date,parent_deptname,dept_name,proj_id,project_name,rent_list,rent_diff,rent,last_hire_date,fact_rent,corpus_overage,plan_bank_name,receipt_bank,rent_status,manage_name,qcmanage_name,qymc,sfmc,board_name,leas_type ";
sqlstr = "select top "+ intPageSize + col+" from vi_report_ZJCX_rent where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from  vi_report_ZJCX_rent where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by project_name,rent_list,id";

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
        <td align="left"><%=getDBDateStr(rs.getString("page_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_diff"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("last_hire_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fact_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("corpus_overage"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("receipt_bank"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_status"))%></td>
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
