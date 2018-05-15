<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-info-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ��ѯ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

 
String industry_name = getStr( request.getParameter("industry_name") );
String model_id = getStr( request.getParameter("model_id") );
String model_name = getStr( request.getParameter("model_name") );
String contract_id = getStr( request.getParameter("contract_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String proj_manager_name = getStr( request.getParameter("proj_manager_name") );
String status_name = getStr( request.getParameter("status_name") );

if(!industry_name.equals("")){
	wherestr+=" and vi_contract_info.industry_typename ='"+industry_name+"'";
}
if(!model_id.equals("")){
	wherestr+=" and equip_model.model_id ='"+model_id+"'";
}
if(!contract_id.equals("")){
	wherestr+=" and vi_contract_info.contract_id like '%"+contract_id+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_contract_info.vi_cust like '%"+cust_name+"%'";
}
if(!proj_manager_name.equals("")){
	wherestr+=" and base_user.name like '%"+proj_manager_name+"%'";
}
if(!status_name.equals("")){
	wherestr+=" and vi_contract_info.status_name like '%"+status_name+"%'";
}
///sqlstr = "  select vi_contract_info.contract_id,vi_contract_info.vi_cust, industry_typename, leas_modename, vdeptname,vi_contract_info.status_name,vi_contract_info.vprojname, contract_condition.equip_amt ,vi_contract_info.docurl from vi_contract_info  left join contract_condition on vi_contract_info.contract_id=contract_condition.contract_id   " + wherestr; 
sqlstr="select vi_contract_info.contract_id,vi_contract_info.vi_cust as cust_name,vi_contract_info.industry_typename as industry_name, equip_model.model_name,contract_condition.actual_start_date, vi_contract_info.status_name,contract_condition.lease_money from vi_contract_info left join contract_condition on vi_contract_info.contract_id=contract_condition.contract_id left join contract_equip on vi_contract_info.contract_id=contract_equip.contract_id left join equip_model on contract_equip.device_type=equip_model.model_id left join proj_info on vi_contract_info.proj_id=proj_info.proj_id left join base_user on proj_info.proj_manage=base_user.id";
sqlstr+=wherestr;
System.out.println(sqlstr);
%>
<body onLoad="public_onload(0);">
<form name="form1" action="htxxcx_list.jsp">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��ͬ��Ϣ &gt; ��ͬ��ѯ</td>
			</tr>
</table>
<!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;�߼�����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onClick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">

<tr><td>�ڲ���ҵ&nbsp;&nbsp;<select name="industry_name"></select>
<script language="javascript">dict_list("industry_name","hapindustry","<%=industry_name%>","title");</script></td>

<td>�豸�ͺ�<input name="model_name" type="text" size="15" value="<%=model_name %>" readonly>
<input type="hidden" name="model_id" value="<%=model_id %>">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','�豸�ͺ�','equip_model','model_name','model_id','model_name','model_name','asc','form1.model_name','form1.model_id');"></td>
<td>��ͬ���<input name="contract_id" type="text" size="15" value="<%=contract_id %>"></td>
<td>����ͻ�<input name="cust_name" type="text"  size="15" value="<%=cust_name %>"></td>
</tr><tr>
<td>��Ŀ������<input name="proj_manager_name" type="text"  size="15" value="<%=proj_manager_name %>"></td>
<td>��ͬ״̬<input name="status_name" type="text" size="15" value="<%=status_name %>" readonly>
<input type="hidden" name="status">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','��ͬ״̬','base_contractstatus','status_name','status_code','status_name','status_name','asc','form1.status_name','form1.status');">
</td><td><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
</tr>

</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 




<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
	</tr>
</table>
<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 50;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.form1;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--��ҳ���ƽ���-->






<!--����ʼ-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>��ͬ��</th>
        <th>����ͻ�</th>
        <th>�ڲ���ҵ</th>
        <th>�豸�ͺ�</th>
        <th>ʵ����������</th>
        <th>��ͬ״̬</th>
        <th>�����ʶ�</th>
        <th>������Ϣ</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") ) %></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("industry_name") ) %></td>
		<td><%= getDBStr( rs.getString("model_name") ) %></td>
		<td><%= getDBDateStr( rs.getString("actual_start_date") ) %></td>
		<td><%= getDBStr( rs.getString("status_name") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("lease_money") ),"#,##0.00") %></td>
      	<td>
      		<a href="../../zjcs/ht_read/condition_frame_read.jsp?contract_id=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank">���׽ṹ</a>
      		<a href="../../zjcs/ht_read/rentplan_frame_read.jsp?contract_id=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank">�����ƻ�</a>
      		<a href="../../zjcs/ht_read/rent_income.jsp?contract_id=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank">ʵ�ʻ���</a>
      	</td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
</div>

<!--�������-->
</form>
</body>
</html>
