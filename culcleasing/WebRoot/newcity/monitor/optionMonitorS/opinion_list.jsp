<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ʵ����б�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">���˴���ʵ����б�</td>
  </tr>
</table>
<!--�������-->

<%
//��ѯ�����˵�����
String loginName = "";
sqlstr = "Select name from base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	loginName = rs.getString("name");
}
rs.close();

//ֻ�ܲ�ѯ�Լ���ʵ����Ŀ���
wherestr = " and dutier = '"+ loginName +"' ";

String proj_name = getStr( request.getParameter("proj_name") );
String raiser = getStr( request.getParameter("raiser") );
String status = getStr( request.getParameter("has_opinion") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( raiser!=null && !raiser.equals("") ) {
	wherestr += " and raiser like '%" + raiser + "%'";
}
if ( status!=null && !status.equals("") ) {
	wherestr += " and status = '" + status + "'";
}

countSql = "select count(id) as amount from vi_opinion_list where 1=1 "+wherestr;

%>

<form action="opinion_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="proj_name"  type="text" size="13" value="<%=proj_name %>"></td>
<td>�����:&nbsp;<input name="raiser"  type="text" size="13" value="<%=raiser %>"></td>
<td>�Ƿ����:&nbsp;
 <select name="has_opinion">
    <script type="text/javascript">
     	w(mSetOpt('<%=status %>',"|��|��","|1|0"));
    </script>
 </select>
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
        <td align="left" width="1%"><!--������ť��ʼ-->
	        <table border="0" cellspacing="0" cellpadding="0" >
	        	<tr class="maintab">
		         <td align="left">
		          </td>
		         </tr>
	        </table>
        </td>
        <!--������ť����-->
        
        <td align="right" width="95%"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>

  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  
		class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>�����</th>
     	<th>���ʱ��</th>
 		<th>���</th>
		<th>������ʵ��</th>
		<th>ִ�в���</th>
	 	<th>��ʵ�׶�</th>
	 	<th>�����ʵ��Ա</th>

	 	<th>�Ƿ����</th>
	    <th>ִ�н��</th>
	    <th>������</th>
	    <th>���ʱ��</th>
	    <th>�Ǽ���</th>
	    <th>�Ǽ�ʱ��</th>
		
		<th></th>
      </tr>
      <tbody id="data">
<%
String col_str=" *,cjz=dbo.GETUSERNAME(creator) ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_opinion_list where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_opinion_list where 1=1 "+wherestr+" order by proj_id,id ) "+wherestr ;
sqlstr +=" order by proj_id,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left">
		<a href="http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=getDBStr( rs.getString("proj_id")) %>" target="_blank">
		<%=getDBStr( rs.getString("proj_id")) %></a>
		</td>	
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("raiser"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("raiser_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("idea")) %></td>
  
		<td><%=getDBStr(rs.getString("dutier")) %></td>
		<td><%=getDBStr(rs.getString("operation_dept")) %></td>
		<td><%=getDBStr(rs.getString("flow")) %></td>
    	<td><%=getDBStr(rs.getString("check_man")) %></td>

		<td align="center"><%=rs.getInt("status")==0?"��":"��" %></td>
		
		<td><%=getDBStr(rs.getString("result")) %></td>
		<td><%=getDBStr(rs.getString("remark")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("end_time")) %></td>
		<td><%=getDBStr(rs.getString("cjz")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
	

		<td align="center">
		<% if( rs.getInt("status")==0 ) { %>

		<a href="opinion_suc.jsp?item_id=<%=getDBStr( rs.getString("id"))%>" target="_blank">������</a>
		<% } else {%>
		�޲���
		<% } %>
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
