<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ����񱨱��ϴ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->


<body onLoad="public_onload(0);">
<form action="khcbxx_upload.jsp" name="dataNav">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	�ͻ���Ϣ &gt; �Ʊ���Ϣ�ϴ�</td>
    </tr>
  </table>
  <!--�������-->

<%
wherestr = "";
String wh_userid=(String) session.getAttribute("czyid");
if("".equals(wh_userid)||wh_userid==null){
	wh_userid="111";
}
String cust_name = getStr( request.getParameter("cust_name") );
String project_name = getStr( request.getParameter("project_name") );
String proj_manage_name=getStr(request.getParameter("proj_manage_name"));
String proj_qmanage=getStr(request.getParameter("proj_qmanage"));
String upstatues = getStr( request.getParameter("upstatues") );

if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}
if(project_name!=null && !"".equals(project_name)){
	wherestr+= " and project_name like '%" + project_name + "%'";
}
if(proj_manage_name!=null && !"".equals(proj_manage_name)){
	wherestr+= " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(upstatues!=null && !"".equals(upstatues)){
	wherestr+= " and upstatues like '%" + upstatues + "%'";
}
if(proj_qmanage!=null && !"".equals(proj_qmanage)){
	wherestr+= " and proj_qmanage like '%" + proj_qmanage + "%'";
}
wherestr+= " and rentstartdate > '2017-02-01'";
//Ȩ���ж�
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from vi_financial_upload where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		��Ŀ����&nbsp;<input name="project_name" type="text" size="15" value="<%=project_name %>">
	</td>
	<td>
		�ͻ�����&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>	
	<td>
		��Ŀ����&nbsp;<input name="proj_manage_name" type="text" size="15" value="<%=proj_manage_name %>">
    </td>
	</tr>
	
	<tr>
	<td>
		��ؾ���&nbsp;<input name="proj_qmanage" type="text" size="15" value="<%=proj_qmanage %>">
    </td>
	<td>               
		�ϴ�״̬&nbsp;<input name="upstatues" type="text" size="15" value="<%=upstatues %>">
	</td>	
		<td>
		<input type="button" value="��ѯ" onclick="dataNav.submit();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="���" onclick="clearQuery();" >
		</td>
	</tr>
	</table>
	</fieldset>
	</div>
<!--���۵���ѯ����-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
    
      <td align="left" width="90%" rowspan="2"><!--������ť��ʼ-->
  
        <!--������ť����--></td>
        <td align="right" width="20%" colspan="2"><!--��ҳ���ƿ�ʼ-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--��ҳ���ƽ���-->
  
  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>��������</th>
	    <th>��Ŀ����</th>
		 <th>����</th>
		 <th>��Ŀ����</th>
		 <th>��ؾ���</th>
	    <th>�ͻ�����</th>
	    <th>ʡ��</th>
	    <th>����</th>
		 
		<th>�ͻ�������</th>
	    <th>�ϱ�����</th>
	    <th>�ϴ�״̬</th>
	    <th>�ϴ�����</th>
		<th>�ϴ�����</th>
      </tr>
<%


sqlstr = "select top "+ intPageSize +"* from vi_financial_upload where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financial_upload where 1=1 "+wherestr+" order by upstatues asc ) "+wherestr ;
sqlstr += " order by upstatues asc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center">
        <input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>" 
        custName="<%=getDBStr( rs.getString("cust_name") ) %>"></td>
        

		<td align="center"><%=getDBDateStr( rs.getString("rentstartdate") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("dept_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("proj_manage_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("proj_qmanage") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("sfmc") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("csmc") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("lbdlmc") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("finance_code") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("upstatues") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("upstdate") ) %></td>
		 <td align="center"><a href="../khfr/frkh.jsp?custId=<%=getDBStr( rs.getString("cust_id"))%>&userId=<%=wh_userid%>" target="_blank"><%=getDBStr( rs.getString("uploadname") )  %></a></td>
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- ������� -->

</form>
</body>
</html>
