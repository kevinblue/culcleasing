<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������� - ���ǩԼ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function changeOne(){
	var theArrBox=document.getElementsByName("itemselect");
	var tempStr="";
	for(i=0;i<theArrBox.length;i++){
		if(theArrBox[i].checked) { 
			tempStr=theArrBox[i].value; 
			break; 
		}
	}
	if(tempStr==""){
		alert("��ѡ��Ҫ���ǩԼ����Ŀ��");
		return false;
	}
	document.getElementById("change_proj_id").value=tempStr;
	document.dataNav.action="proj_more_sign.jsp";
	document.dataNav.target="_blank";
	document.dataNav.submit();
	document.dataNav.action="proj_more_sign_list.jsp";
	document.dataNav.target="_self";
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">��������&gt; ���ǩԼ����</td>
  </tr>
</table>
<!--�������-->

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and bu.name like '%" + proj_manage_name + "%'";
}

countSql = "select count(proj_id) as amount from proj_info pi left join base_user bu on bu.id=pi.proj_manage where proj_status=15 "+wherestr;

%>

<form action="proj_more_sign_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>��Ŀ����:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>"></td>
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
		           <BUTTON class="btn_2" name="btnHire" value="����"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="����(Alt+Y)" border="0">
        			&nbsp;����
        			</button>
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
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>������</th>
     	<th>��ҵ</th>
 		<th>��Ŀ����</th>
		<th>��Ŀ����</th>
		<th>�Ƿ���ǩԼ</th>
	 	<th>Ԥ��ǩԼ����</th>
      </tr>
      <tbody id="data">
<%
String col_str="proj_id,project_name,br.trade,vcai.cust_name,(select dept_name from base_department where id=pif.proj_dept) as proj_dept_name,";
col_str+=" bu.name as proj_manage_name,(select name from base_user where id=pif.proj_assistant) ";
col_str+=" as proj_assistant_name, isnull(is_more,'��') as is_more,isnull(start_amount,1) start_amount ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from proj_info pif left join base_trade br on pif.industry_type=br.code ";
sqlstr += "left join vi_cust_all_info vcai on vcai.cust_id=pif.cust_id left join base_user bu on bu.id=pif.proj_manage where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from proj_info  pi left join base_user bu on bu.id=pi.proj_manage where proj_status=15 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id ";
System.out.println("���ǩԼ��������SQL==="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("proj_id") )%>"></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("trade"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_assistant_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("is_more"))%></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getString("start_amount")) %></td>
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
