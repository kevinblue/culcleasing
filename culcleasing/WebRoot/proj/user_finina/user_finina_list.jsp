<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ա��Ϣ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function changeOne(){
	//�ж��Ƿ���ѡ��
	var priId = $(":input[name='itemselect']:checkbox").val();
	var para1 = $(":input[name='itemselect']:checkbox").attr("para1");
	var para2 = $(":input[name='itemselect']:checkbox").attr("para2");
	var para3 = $(":input[name='itemselect']:checkbox").attr("para3");
	var flag = $(":input[name='itemselect']:checkbox").attr("flag");
	//var flag = 0;

	if(	priId==undefined || priId==""){
		alert("��ѡ������������Ŀ����");
	}else if(flag>0){
		alert("����Ŀ���������У���ѡ��������Ŀ��");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/LeaseAfterModify.nsf/OSNewWorkFlowFromNBBM?openagent&priId="+priId+"&para1="+para1+"&para2="+para2+"&para3="+para3);
	}
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<%
String user_name = getStr( request.getParameter("user_name") );

String whereStr = "" ;

if ( user_name!=null && !user_name.equals("") ) {
	whereStr = " and name like '%" + user_name + "%'";
}

countSql = "select count(id) as amount from v_base_user where (role='��Ŀ����' or v_base_user.id in( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78')) and isnull(code,'')='' and status=1 " + whereStr ;
%>

<form action="user_finina_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">��ͬ��������&gt; �����ʽ�ƻ��ϱ�����</td>
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
<td>��&nbsp;��:&nbsp;<input name="user_name"  type="text" size="13" value="<%=user_name %>"></td>
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
		           <BUTTON class="btn_2" name="btnHire" value="ת��"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="ת��(Alt+Y)" border="0">
        			&nbsp;�������
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
	    <th>ID</th>
	    <th>����</th>
	    <th>����</th>
     	<th>����</th>
 		<th>��ɫ</th>
		<th>״̬</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";
sqlstr = "select top "+ intPageSize +" "+col_str+" from v_base_user where id not in (select top "+ (intPage-1)*intPageSize +" id from v_base_user where  (role='��Ŀ����' or v_base_user.id in ( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78')) and isnull(code,'')='' and status=1 "+ whereStr +" order by id ) and (role='��Ŀ����' or v_base_user.id in ( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78'))  and isnull(code,'')='' and status=1 " + whereStr ;
sqlstr += " and  (role='��Ŀ����' or v_base_user.id in( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78')) order by id " ;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>" 
		para1="<%=getDBStr( rs.getString("name") )%>" para2="<%=getDBStr( rs.getString("parent_deptname") )%>"
		para3="<%=getDBStr( rs.getString("dept_name") )%>" flag="<%=getDBStr( rs.getString("flag") )%>"></td>
        <td align="center"><%=getDBStr(rs.getString("id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="center"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("role"))%></td>
		<td align="center">
			<font color="blue">
			<%
				String pFl = rs.getString("flag");
				if("0".equals(pFl)){%>
					δ����
				<%}else { %>
					������
			   <% } %>
			</font>
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
