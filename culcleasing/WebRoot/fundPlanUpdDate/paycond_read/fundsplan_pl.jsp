<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�ƻ��ϱ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
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

<body onload="public_onload(0);">

<%
String contractIds="";
String onlycontractid = getStr( request.getParameter("contractids") );
String doc_id = getStr( request.getParameter("doc_id") );
String[] a =onlycontractid.split(",");
String selsql = "";
String inssql = "";
 for(int i=0;i<a.length;i++){
	selsql = "select * from fundsplan_contractid where contract_id ='"+a[i]+"'";
	rs = db.executeQuery(selsql);
	if ( !rs.next() ) {
		inssql="insert into fundsplan_contractid(contract_id,doc_id,create_time ) values('"+a[i]+"','"+doc_id+"',GETDATE())";
		
		db.executeUpdate(inssql);
	}
%><%=selsql%><%=inssql%>
<%
if(i==a.length-1){
contractIds += "'"+ a[i] +"'";
}else{
contractIds += "'"+ a[i] +"',";
}
}


String contract_id=getStr( request.getParameter("contract_id") );
String project_name = getStr( request.getParameter("project_name"));

String whereStr = "" ;
String condition = "" ;
if ( contract_id!=null && !contract_id.equals("") ) {
	whereStr = " and contract_id = '" + contract_id + "'";
}
if ( project_name!=null && !project_name.equals("") ) {
	whereStr = " and project_name = '" + project_name + "'";
}


whereStr=" and contract_id in(" + contractIds + ")";

//countSql = "select count(id) as amount from v_base_user where (role='��Ŀ����' or v_base_user.id in( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78')) and isnull(code,'')='' and status=1 " + whereStr ;
countSql = "select count(contract_id) as amount from vi_select_contract_info_ZJJHSB where 1=1"+whereStr;

%>

<form action="fundsplan_pl.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">�ʽ�ƻ��ϱ�</td>
  </tr>
</table>
<!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��ͬ���:&nbsp;<input name="contract_id"  type="text" size="13" value="<%=contract_id%>"></td>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="120" value="<%=project_name%>"></td>
</tr>
<tr>
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
		           
        			<input type="hidden" name="change_proj_id" id="change_proj_id">
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
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
        <th width="1%"></th>
	    <th>��ͬ���</th>
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
     	<th>��Ŀ����</th>
 		<th>��ҵ����</th>
		<th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_select_contract_info_ZJJHSB where contract_id not in (select top "+ (intPage-1)*intPageSize +" contract_id from vi_select_contract_info_ZJJHSB where 1=1"+whereStr+"order by contract_id)"+ whereStr +"order by contract_id" ; 
rs = db.executeQuery(sqlstr);
	%>
<%=sqlstr%>
<%
while ( rs.next() ) {

%>
      <tr>
        <td align="center"><input class="rd" type="checkbox" name="itemselect" value="<%=getDBStr( rs.getString("contract_id") )%>" 
		para1="<%=getDBStr( rs.getString("proj_id") )%>"
		para2="<%=getDBStr( rs.getString("project_name") )%>"
		para3="<%=getDBStr( rs.getString("leas_form") )%>"
		para4="<%=getDBStr( rs.getString("industry_name") )%>"
	
		</td>
        <td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("leas_form"))%></td>
		<td align="center"><%=getDBStr(rs.getString("industry_name"))%></td>
		<td align="center">
     	<a href='fundsplan_details.jsp?contract_id=<%=getDBStr(rs.getString("contract_id"))%>&doc_id=<%=doc_id%>' target="_blank">
	    ������Ϣ</a>
     	
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
