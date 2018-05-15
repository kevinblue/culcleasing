<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%!public String getMenoStr(String str)  //request�ַ������Ĵ���
{
	try
	{
		String temp_p=str;
		if(str.indexOf(".")==0||str.indexOf(".")==-1){
			return "";
		}else if(str.indexOf("��")==0||str.length()>1){
			return str.substring(1,str.length());
		}
	}
	catch(Exception e)
	{
	 
	}
	return "";
}%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-htxs-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ�ļ�&gt;��ͬ���� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0)">
<form action="htxs_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" 

valign="middle" id="cwCellTopTitTxt">
				��ͬ���� &gt; ��ͬ�ļ�</td>
			</tr>
</table>
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
ResultSet rs;
String wherestr = " where 1=1";
if( searchFld.equals("�ͻ�����") ) {
	wherestr += "and dbo.getcustnamebycontractid(info.contract_id) like '%"+searchKey+"%'";
}else if( searchFld.equals("��ͬ���") ) {
	wherestr += "and info.contract_id like '%"+searchKey+"%'";
}else{
	wherestr += " ";
}
String sqlstr="select distinct dbo.getcustnamebycontractid(info.contract_id) as cust_name,dbo.getcustcode(info.cust_id) as custcode,info.contract_id,UPPER(isnull(substring(contract_approve_status,0,charindex('_',contract_approve_status)),'')) as approve_place,dbo.fk_getname(info.vndr_id) as vndr_id,dbo.fk_getname(info.proj_dept) as proj_dept,filiale.province,(select top 1 isnull(rent,0)+isnull(rent_adjust,0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,getdate())<=0 order by id) as rent,(convert(varchar(2),(convert(decimal(2,0),first_payment_ratio)))+''+convert(varchar(2),(convert(decimal(2,0),income_number)))) as leas_mode,equip.equip_num,dbo.getmodelbyid(equip.device_type) as decive_type,equip.equip_sn,time.receive_date,condition.actual_start_date,condition.income_day,dbo.getapprovedstatus(info.contract_id) as approve_status,time.csmd_receive_date,dbo.getattach(info.contract_id) as attach_memo,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=037) as lease_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=037) as lease_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=038) as guarantor_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=038) as guarantor_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=039) as plan_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=039) as plan_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=040) as approve_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=040) as approve_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=042) as lease_con_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=042) as lease_con_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=043) as guaranty_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=043) as guaranty_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=044) as equip_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=044) as equip_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=045) as guarantee_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=045) as guarantee_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=046) as buy_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=046) as buy_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=047) as invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=047) as invoice_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=048) as confer_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=048) as confer_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=049) as code_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=049) as code_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=050) as payment_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=050) as payment_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=051) as product_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=051) as product_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=052) as gps_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=052) as gps_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=053) as consent_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=053) as consent_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=054) as insure_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=054) as insure_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=055) as insure_invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=055) as insure_invoice_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=056) as csa_confer_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=056) as csa_confer_fag_meno,(select case  list.head_contract when '0' then '��' when '1' then '��' else '��Ҫ' end from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=057) as csa_invoice_fag,(select list.attach_memo from contract_list_info as list where list.contract_id=info.contract_id and contract_list_ID=057) as csa_invoice_fag_meno,accep.accept_method,accep.memo,proj.approve_date,time.document_date,time.payment_date,time.fund_date,his.receive_date,time.send_date,time.receive_date,time.branch_expdate from contract_info as info left join base_filiale_province as filiale on (info.proj_dept=filiale.filiale_id) left join contract_equip as equip on (info.contract_id=equip.contract_id) left join contract_condition as condition on (info.contract_id=condition.contract_id) left join contract_time_info as time on (info.contract_id=time.contract_id) left join equip_acceptance as accep on (info.contract_id=accep.contract_id) left join proj_info as proj on (info.proj_id=proj.proj_id) left join fund_down_payment_his as his on (info.contract_id=his.contract_id) "+ wherestr +" order by contract_id desc";
System.out.println(sqlstr);
%>
	
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" colspan="2">
					&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|��ͬ���|�ͻ�����"));</script></select>&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
				</td>
			<!--</tr>
			<tr class="maintab">-->
				<td align="left" width="1%">
<!--������ť��ʼ-->
<!--������ť����-->
</td>
					 <td align="right" width="50%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->
<%
int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��

	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString

//��û��page��һ����������ʱ��ʾ��һҳ����
	 intPage = 1;
	}else{
	  intPage = java.lang.Integer.parseInt(strPage);
	  if(intPage<1) intPage = 1;
	} 
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //������ҳ��
	if(intPage>intPageCount) intPage = intPageCount;            //��������ʾ��ҳ��
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //����¼ָ�붨λ������ʾ

//ҳ�ĵ�һ����¼��
	int i = 0; %>

<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " 

onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" 

src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" 

src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " 

onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" 

src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" 

alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" 

src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img 

align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" 

src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; 

left: 0px; top: 0px"  id="mydiv";>

<form action="khmpxx_list.jsp" name="dataNav">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" 
		cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
<th>�ͻ���&nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>���֤��</th>
<th>��ͬ���</th>
<th>�ļ����ڵ�</th>
<th>��Ӧ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>�ֹ�˾</th>
<th>ʡ��</th>
<th>�����</th>
<th>����ģʽ</th>
<th>̨��</th>
<th>�ͺ�</th>
<th>�������</th>
<th>�յ��ļ�����</th>
<th>������ʼ��&nbsp;&nbsp;</th>
<th>�������֧����</th>
<th>�ļ�״̬</th>
<th>CSMD�ļ��Ǽ�</th>
<th>���ϸ��ļ�����</th>
<th>�ͻ���������</th>
<th>��ע</th>
<th>��������Ϣ��</th>
<th>��ע</th>
<th>����ƻ���</th>
<th>��ע</th>
<th>�����׼</th>
<th>��ע</th>
<th>���ʺ�ͬ</th>
<th>���ʺ�ͬ��ע</th>
<th>������</th>
<th>�����鱸ע</th>
<th>�����ｻ��֤����</th>
<th>�����ｻ��֤���鱸ע</th>
<th>��Ѻ��ͬ</th>
<th>��Ѻ��ͬ��ע</th>
<th>�����ͬ</th>
<th>�����ͬ��ע</th>
<th>�豸��Ʊ</th>
<th>�豸��Ʊ��ע</th>
<th>��Ȩ�ۿ�Э����</th>
<th>��Ȩ�ۿ�Э���鱸ע</th>
<th>���н�ǿ���ӡ��</th>
<th>��������</th>
<th>�ڳ������ļ�</th>
<th>�ڳ������ļ���ע</th>
<th>��Ʒ�ϸ�֤</th>
<th>��Ʒ�ϸ�֤��ע</th>
<th>GPS</th>
<th>GPS��ע</th>
<th>�������˳�ŵ��</th>
<th>�������˳�ŵ�鱸ע</th>
<th>����</th>
<th>������ע</th>
<th>��Ʊ</th>
<th>��Ʊ��ע</th>
<th>CSAЭ�鷢Ʊ</th>
<th>CSAЭ�鷢Ʊ��ע</th>
<th>CSA��Ʊ</th>
<th>CSA��Ʊ��ע</th>
<th>���ձ���</th>
<th>�豸���ձ�ע</th>
<th>��������</th>
<th>�ļ���������</th>
<th>�ݽ������ļ�����</th>
<th>��������</th>
<th>�׸���Ʊ</th>
<th>�ļ��ؼ�����</th>
<th>�ֹ�˾�յ��ļ�����</th>
<th>�ֹ�˾ת���ͻ�����</th>
</tr>
	  
<%
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
		<td><%=getDBStr( rs.getString("cust_name"))%></td>
        <td><%=getDBStr( rs.getString("custcode"))%></td>
        <td><%=getDBStr( rs.getString("contract_id"))%></td>
        <td><%=getDBStr( rs.getString("approve_place"))%></td>
        <td><%=getDBStr( rs.getString("vndr_id"))%></td>
        <td><%=getDBStr( rs.getString("proj_dept"))%></td>
        <td><%=getDBStr( rs.getString("province"))%></td>
        <td><%=formatNumberStr( rs.getString("rent"),"#,##0.00")%></td>
        <td><%=getDBStr( rs.getString("leas_mode"))%></td>
        <td><%=getDBStr( rs.getString("equip_num"))%></td>
        <td><%=getDBStr( rs.getString("decive_type"))%></td>
        <td><%=getDBStr( rs.getString("equip_sn"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("actual_start_date"))%></td>
        <td>ÿ��<%=getDBStr( rs.getString("income_day"))%>��</td>
        <td><%=getDBStr( rs.getString("approve_status"))%></td>
        <td><%=getDBDateStr( rs.getString("csmd_receive_date"))%></td>
        <td><%=getMenoStr( rs.getString("attach_memo"))%></td>
        <td><%=getDBStr( rs.getString("lease_fag"))%></td>
        <td><%=getMenoStr( rs.getString("lease_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guarantor_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guarantor_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("plan_fag"))%></td>
        <td><%=getMenoStr( rs.getString("plan_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("approve_fag"))%></td>
        <td><%=getMenoStr( rs.getString("approve_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("lease_con_fag"))%></td>
        <td><%=getMenoStr( rs.getString("lease_con_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guaranty_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guaranty_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("equip_fag"))%></td>
        <td><%=getMenoStr( rs.getString("equip_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("guarantee_fag"))%></td>
        <td><%=getMenoStr( rs.getString("guarantee_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("buy_fag"))%></td>
        <td><%=getMenoStr( rs.getString("buy_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("confer_fag"))%></td>
        <td><%=getMenoStr( rs.getString("confer_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("code_fag"))%></td>
        <td><%=getMenoStr( rs.getString("code_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("payment_fag"))%></td>
        <td><%=getMenoStr( rs.getString("payment_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("product_fag"))%></td>
        <td><%=getMenoStr( rs.getString("product_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("gps_fag"))%></td>
        <td><%=getMenoStr( rs.getString("gps_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("consent_fag"))%></td>
        <td><%=getMenoStr( rs.getString("consent_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("insure_fag"))%></td>
        <td><%=getMenoStr( rs.getString("insure_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("insure_invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("insure_invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("csa_confer_fag"))%></td>
        <td><%=getMenoStr( rs.getString("csa_confer_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("csa_invoice_fag"))%></td>
        <td><%=getMenoStr( rs.getString("csa_invoice_fag_meno"))%></td>
        <td><%=getDBStr( rs.getString("accept_method"))%></td>
        <td><%=getDBStr( rs.getString("memo"))%></td>
        <td><%=getDBDateStr( rs.getString("approve_date"))%></td>
        <td><%=getDBDateStr( rs.getString("document_date"))%></td>
        <td><%=getDBDateStr( rs.getString("payment_date"))%></td>
        <td><%=getDBDateStr( rs.getString("fund_date"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("send_date"))%></td>
        <td><%=getDBDateStr( rs.getString("receive_date"))%></td>
        <td><%=getDBDateStr( rs.getString("branch_expdate"))%></td>
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
	</form>


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->



<!-- end cwMain -->
</body>
</html>
