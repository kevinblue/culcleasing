<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��˰����Ϣά��</title>
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
<form action="taxpayer_info.jsp" name="dataNav">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	��˰����Ϣά��</td>
    </tr>
  </table>
  <!--�������-->

<%
wherestr = "";
String wh_userid=(String) session.getAttribute("czyid");
if(wh_userid.equals("ADMN-8GRBW4")){
	 
  wherestr += " ";
}else{
	wherestr += " and proj_dept in  (select department from base_user where id='"+wh_userid+"') ";
}
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String wh_status = getStr( request.getParameter("wh_status") );
if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}

if(wh_status!=null && !"".equals(wh_status)){
	wherestr+= " and wh_status like '%" + wh_status + "%'";
}

//Ȩ���ж�
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from vi_base_taxPayer_mod where 1=1 "+wherestr;

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
		�ͻ����&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		�ͻ�����&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>
	<td>ά��״̬:
	<select name="wh_status" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=wh_status%>',"|δ����|���˻�","|δ����|���˻�"));
		</script>
	 </select>
</td>	
	</tr>
	<tr>
     <td ><input type="button" value="���" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="button" value="��ѯ" onclick="dataNav.submit();"></td>
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
	    <th width="1%">���</th>	    
	    <th>�ͻ�����</th>
	    <th>�ͻ�����</th>
		<th>����</th>
	    <th>��˰��˰��</th>
	    <th>��ַ</th>
	    <th>�绰</th>
	    <th>��˰�˻���������</th>
	    <th>��˰���˺�</th>
	    <th>��Ʊ����</th>	  
	    <th>ά��״̬</th>
	    <th>��Ŀ����</th>  
	    <th>ά����</th>
		<th>ά��ʱ��</th>
		<th>����</th>		
      </tr>
      <tbody id="data">
   
<%
String col_str="id, cust_name,parent_deptname, cust_id,tax_payer_no,tax_type_invoice,address,tel,bank_name,bank_no,wh_status,wh_modificator,wh_modify_date,proj_assistant_name ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_base_taxPayer_mod where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_base_taxPayer_mod where 1=1 "+wherestr+" order by  id  desc ) "+wherestr ;
sqlstr += " order by id desc ";

LogWriter.logDebug(request, "���˿ͻ���Ϣ����###"+sqlstr);
int i=0;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>


      <tr>
        <td align="center"><%=i %></td>	
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>	
        <td align="center"><%=getDBStr( rs.getString("parent_deptname") ) %></td>			
		<td align="center"><%= getDBStr( rs.getString("tax_payer_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("address") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tel") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("bank_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tax_type_invoice") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_status") ) %></td>	
		<td align="center"><%= getDBStr( rs.getString("proj_assistant_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_modificator") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("wh_modify_date") ) %></td>
		<td align="center">
     	<a href='taxpayer_info_mod.jsp?id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�����</a>    	
     	</td>
		
      </tr>
<%
i++;
}
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
