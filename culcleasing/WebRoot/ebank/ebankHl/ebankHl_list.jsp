<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������������ - ���������б�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0);">
<form action="ebankHl_list.jsp" name="searchbar" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				������������ &gt; ���������б�</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ebank-ebankHl-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------����ΪȨ�޿���--------
String sqlstr;
ResultSet rs;
ResultSet rs1;
ResultSet rs2;
String wherestr = " where 1=1 and vi_ebank_remMoney.ebank_money>0 and fund_ebank_data.status='��Ч' and fund_ebank_data.business_flag='��'";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String fact_money_start=getStr( request.getParameter("fact_money_start") );
String fact_money_end=getStr( request.getParameter("fact_money_end") );

//dominoǰ׺
String pre_url="http://leasing.utfinancing.com";

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
}
if (!fact_money_start.equals("")) {
	wherestr = wherestr + " and fund_ebank_data.fact_money>="+fact_money_start;
}
if (!fact_money_end.equals("")) {
	wherestr = wherestr + " and fund_ebank_data.fact_money<="+fact_money_end;
}

String contract_id="";	//��ͬ���
String contract_id_br="";	//��ͬ���
String contract_id_show="";	//���Ѻ�ͬ����б�
String contract_id_sql="";	//in ��ͬ��ż���
String contract_id_show_tmp="";	//���Ѻ�ͬ����б�_tmp
String contract_id_sql_tmp="";	//in ��ͬ��ż���_tmp
String client_name="";	//�ͻ�����
String client_accnumber="";	//�ͻ��ʺ�
String arrive_date="";	//��������
String fact_money="";	//���ʽ��
String badRent="";	//���ڽ��
String end_flag="";	//�жϽ�����־
String adjust_flag="";	//���ƥ���Ƿ�ɹ���־
String process_info="";	//������ִ����������
String proj_id="";	//������ʱ�����������
String cust_id="";	//������ʱ�����������
String cust_name="";	//������ʱ�����������
String flow_income="����������";	//������ʱ�����������
sqlstr = "select isnull(vi_ebank_remMoney.ebank_money,0) as remEbankMoney,fund_ebank_data.ebdata_id, fund_ebank_data.contract_id, fund_ebank_data.order_number, fund_ebank_data.arrive_date, fund_ebank_data.account_bank, fund_ebank_data.acc_number, fund_ebank_data.client_name, fund_ebank_data.client_accnumber, isnull(fund_ebank_data.fact_money,0) as fact_money_show, isnull(dbo.bb_getRemEbankMoney(fund_ebank_data.ebdata_id),0) as fact_money, fund_ebank_data.summary, fund_ebank_data.sn, fund_ebank_data.status, fund_ebank_data.business_flag from fund_ebank_data left join vi_ebank_remMoney on fund_ebank_data.ebdata_id=vi_ebank_remMoney.ebank_id" + wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
	    <td nowrap>&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|�������|��������|�ϴ�����|��ͬ���|��������|����ͻ�|�ͻ��ʺ�","|fund_ebank_data.ebdata_id|convert(varchar(10),fund_ebank_data.arrive_date,121)|convert(varchar(10),fund_ebank_data.upload_date,121)|fund_ebank_data.contract_id|fund_ebank_data.account_bank|fund_ebank_data.client_name|fund_ebank_data.client_accnumber"));</script></select>&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		����<input name="fact_money_start" type="text" size="10" value="<%= fact_money_start%>">��<input name="fact_money_end" type="text" size="10" value="<%= fact_money_end%>">
    	<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
		
		</td>
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
		var nf = document.forms[0];
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
</form>
</table>

<!--��ҳ���ƽ���-->






<!--����ʼ-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>�������</th>
		<th>��ͬ���</th>
        <th>���</th>
        <th>����ʱ��</th>
        <th>��������</th>
        <th>�����ʺ�</th>
        <th>����ͻ�</th>
        <th>�ͻ��ʺ�</th>
        <th>���</th>
        <th>ժҪ</th>
        <th>��ˮ��</th>
        <th>�ɺ������</th>
        <th>������ִ������</th>
        <th>��ͬ���</th>
        <th>������������</th>
        <th>�����տ�����</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	end_flag="0";
	contract_id=getDBStr( rs.getString("contract_id") );
	client_accnumber=getDBStr( rs.getString("client_accnumber") );
	client_name=getDBStr( rs.getString("client_name") );
	arrive_date=getDBDateStr( rs.getString("arrive_date") );
	fact_money=getDBStr( rs.getString("fact_money") );
	contract_id_show="";
	contract_id_sql="";
	contract_id_show_tmp="";
	contract_id_sql_tmp="";
	process_info="";
	sqlstr="select contract_id,process_name,start_date,isnull(process_amount,0) as process_amount from fund_ebank_process where ebdata_id='"+getDBStr( rs.getString("ebdata_id") )+"'";
	rs1=db1.executeQuery(sqlstr);
	while(rs1.next()){
		process_info+=getDBStr( rs1.getString("contract_id") );
		process_info+=" ���̣�"+getDBStr( rs1.getString("process_name") );
		process_info+=" ��ʼ���ڣ�"+getDBDateStr( rs1.getString("start_date") );
		process_info+=" ��"+formatNumberStr(getDBStr( rs1.getString("process_amount") ),"#,##0.00");
		process_info+="<br>";
	}rs1.close();
	
	if(!contract_id.equals("")){	//��ͬ���ƥ��
		end_flag="1";
		contract_id_show=contract_id;
		contract_id_sql="('"+contract_id+"')";
	}
	if(end_flag.equals("0")){	//�ͻ��ʺ�ƥ��
		if(!client_accnumber.equals("")){
			sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and acc_number like '%"+client_accnumber+"%'";
			System.out.println("sqlstr000==================================="+sqlstr);
			rs1=db1.executeQuery(sqlstr);
			while(rs1.next()){
				end_flag="1";
				contract_id=getDBStr( rs1.getString("contract_id") );
				contract_id_show_tmp+=contract_id+",";
				contract_id_sql_tmp+="'"+contract_id+"',";
				sqlstr="select * from ebank_pp where create_date='"+arrive_date+"' and contract_id='"+contract_id+"' and ebank_money="+fact_money;
				rs2=db2.executeQuery(sqlstr);
				if(rs2.next()){
						contract_id_show+=contract_id+",";
						contract_id_sql+="'"+contract_id+"',";
				}rs2.close();
			}rs1.close();
			if(contract_id_show.equals("")){
				contract_id_show=contract_id_show_tmp;
				contract_id_sql=contract_id_sql_tmp;
			}
			if(contract_id_show.length()>0){
				contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
				contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
			}
		}
	}
	
	if(end_flag.equals("0")){	//�ͻ�����ƥ��
		if(!client_name.equals("")){
			sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and cust_name like '%"+client_name+"%'";
			System.out.println("sqlstr001==================================="+sqlstr);
			rs1=db1.executeQuery(sqlstr);
			while(rs1.next()){
				end_flag="1";
				contract_id=getDBStr( rs1.getString("contract_id") );
				contract_id_show_tmp+=contract_id+",";
				contract_id_sql_tmp+="'"+contract_id+"',";
				sqlstr="select * from ebank_pp where create_date='"+arrive_date+"' and contract_id='"+contract_id+"' and ebank_money="+fact_money;
				rs2=db2.executeQuery(sqlstr);
				if(rs2.next()){
						contract_id_show+=contract_id+",";
						contract_id_sql+="'"+contract_id+"',";
				}rs2.close();
			}rs1.close();
			if(contract_id_show.equals("")){
				contract_id_show=contract_id_show_tmp;
				contract_id_sql=contract_id_sql_tmp;
			}
			if(contract_id_show.length()>0){
				contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
				contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
			}
		}
	}
	
	if(end_flag.equals("0")){	//���ƥ��
		
		sqlstr="select contract_id from ebank_pp where create_date='"+arrive_date+"' and ebank_money="+fact_money;
		System.out.println("sqlstr002==================================="+sqlstr);
		rs1=db1.executeQuery(sqlstr);
		while(rs1.next()){
			end_flag="1";
			contract_id=getDBStr( rs1.getString("contract_id") );
			contract_id_show+=contract_id+",";
			contract_id_sql+="'"+contract_id+"',";
		}rs1.close();
		if(contract_id_show.length()>0){
			contract_id_show=contract_id_show.substring(0,contract_id_show.length()-1);
			contract_id_sql="("+contract_id_sql.substring(0,contract_id_sql.length()-1)+")";
		}else{
			contract_id_sql="('')";
		}
	}
	contract_id_br=contract_id_show.replaceAll(",","<br>");
%>

      <tr>
        <td><%= getDBStr(rs.getString("ebdata_id") ) %></td> 	
        <td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("order_number") ) %></td>
		<td><%= getDBDateStr( rs.getString("arrive_date") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("account_bank") ) %></td>
		<td><%= getDBStr( rs.getString("acc_number") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_name") ) %></td>
		<td><%= getDBStr( rs.getString("client_accnumber") ) %></td> 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("fact_money_show") ),"#,##0.00") %></td>
		<td><%= getDBStr( rs.getString("summary") ) %></td> 
		<td><%= getDBStr( rs.getString("sn") ) %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("remEbankMoney") ),"#,##0.00") %></td>
		<td><%= process_info %></td>
		<td><a href="ebankHl.jsp?arrive_date=<%= arrive_date %>&contract_id_show=<%= contract_id_show %>" target="_blank"><%= contract_id_br %></a></td> 
		<%
			if(contract_id_show.indexOf(",")>0 || contract_id_show.length()==0){
		 %>
		<td><a href="<%=pre_url%>/ELeasing/ProjectWF/ProjectEHire.nsf/NWorkFlowNewSelect5?OpenForm&ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=&projectNo=&custid=&cust_name=&flow=<%= flow_income %>" target="_blank">��������</a></td> 	 	 	
		<td><select name="flow_income<%=i %>"><script>w(mSetOpt("",'�տ�����|��Լ�տ�����|��ǰ�����տ�����|�ع��տ�����|�ܶ��ܿͻ��տ�����'));</script></select>
		<BUTTON class="btn_2" name="btnSave" value="����"  type="button" name="button<%=i %>" onclick="fun_save(<%=i %>)">
		<img src="../../images/save.gif" align="absmiddle" border="0" >����</button>
		<input name="hidden<%=i %>" type="hidden" value="ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=&projectNo=&custid=&cust_name=">
		</td> 	 	 		 	 	
		<%
			}else{
			proj_id="";
			cust_id="";
			cust_name="";
			sqlstr="select proj_id,cust_id,cust_name from vi_contract_info where contract_id='"+contract_id_show+"'";
			rs1=db1.executeQuery(sqlstr);
			if(rs1.next()){
				proj_id=getDBStr(rs1.getString("proj_id") );
				cust_id=getDBStr(rs1.getString("cust_id") );
				cust_name=getDBStr(rs1.getString("cust_name") );
			}rs1.close();
		 %>
		<td><a href="<%=pre_url%>/ELeasing/ProjectWF/ProjectEHire.nsf/NWorkFlowNewSelect5?OpenForm&ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=<%=contract_id_show %>&projectNo=<%=proj_id %>&custid=<%=cust_id %>&cust_name=<%=cust_name %>&flow=<%= flow_income %>" target="_blank">��������</a></td> 	 	 	
		<td><select name="flow_income<%=i %>"><script>w(mSetOpt("",'�տ�����|��Լ�տ�����|��ǰ�����տ�����|�ع��տ�����|�ܶ��ܿͻ��տ�����'));</script></select>
		<BUTTON class="btn_2" name="btnSave" value="����"  type="button" name="button<%=i %>" onclick="fun_save(<%=i %>)">
		<img src="../../images/save.gif" align="absmiddle" border="0" >����</button>
		<input name="hidden<%=i %>" type="hidden" value="ebdataid=<%= getDBStr(rs.getString("ebdata_id") ) %>&contractid=<%=contract_id_show %>&projectNo=<%=proj_id %>&custid=<%=cust_id %>&cust_name=<%=cust_name %>">
		</td> 	 	
		<%
			}
		 %>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
db1.close();
db2.close();
%>
    </table>
</div>

<!--�������-->

</body>
</html>
<script language="javascript">
function fun_save(obj){
	var url;
	var flow_income;
	var hidden;
	flow_income=document.getElementById("flow_income"+obj).value;
	hidden=document.getElementById("hidden"+obj).value;
	if(flow_income=="�ܶ��ܿͻ��տ�����"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect6?openform&flow=�ܶ��ܿͻ��տ�����&"+hidden;
	}else if(flow_income=="�տ�����"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=�տ�����&"+hidden;
	}else if(flow_income=="��Լ�տ�����"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=��Լ�տ�����&"+hidden;
	}else if(flow_income=="��ǰ�����տ�����"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=��ǰ�����տ�����&"+hidden;
	}else if(flow_income=="�ع��տ�����"){
		url="<%=pre_url%>/ELeasing/ProjectWF/ProjectDFund.nsf/NWorkFlowNewSelect5?openform&flow=�ع��տ�����&"+hidden;
	}else{}
	//alert(url);
	open(url,'','toolbar=no,location=no,directories=no,status=yes,menub ar=no,scrollbar=no,resizable=yes,copyhistory=no');
}
</script>