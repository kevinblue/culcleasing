<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���չ��� - ��������Ŀ(����)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//������
function start_flow() {
	//�ж��Ƿ���ѡ��
	var priId = $(":input[name='list']:checked").val();
	var contrId = $(":input[name='list']:checked").attr("contrId");
	var flag = $(":input[name='list']:checked").attr("flag");
	var projName = $(":input[name='list']:checked").attr("projName");
	var projId = $(":input[name='list']:checked").attr("projId");

	if(	priId==undefined || priId==""){
																alert("��ѡ��ҪͶ������Ŀ��");
	}else if(flag!=0&&flag!=10){
		alert("�ñ������������У���ѡ���������գ�");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Insurance.nsf/OSNewWorkFlowFromBXXBZL?openagent&priId="+priId+"&contractId="+contrId+"&projId="+projId+"&projName="+projName);
	}
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="insur_unxb_ZL.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		���չ���&gt; ��������Ŀ(����)</td>
	</tr>
</table>
<!--�������-->

<%
String wherestr1=" insur_end_date asc";
//�������� - ��ǰ30��
wherestr = " and ((xbmonth_amount>=0) or(flag>=10)) and insur_end_date<=dateadd(dd,60,getdate()) and isnull(status,'')='' and insur_type in('��˾����','��˾����') and show_flag=0 ";

//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );
String cd=getStr( request.getParameter("CD") );
String start_date_t=getStr( request.getParameter("start_date_t") );
String insur_type=getStr( request.getParameter("insur_type") );

String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(!cd.equals("") || cd!=null){
	if(cd.equals("����")){
	wherestr1="cd_date asc";
	}else if (cd.equals("����")){
	wherestr1="cd_date desc";
	}
}
if(!start_date_t.equals("") || start_date_t!=null){
	if(start_date_t.equals("����")){
	wherestr1="insur_start_date asc";
	}else if (start_date_t.equals("����")){
	wherestr1="insur_start_date desc";
	}
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),insur_end_date,21)>='"+start_date+"' ";
}
if(insur_type!=null && !"".equals(insur_type)){
	wherestr+=" and insur_type ='"+insur_type+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),insur_end_date,21)<='"+end_date+"' ";
}

//��ǰ15����ʾ����������
countSql = "select count(id) as amount from vi_insur_unxb where 1=1 "+ wherestr;


//��������2--���ݵ���
String expsqlstr = "select insur_no ������,insur_money Ͷ�����,insur_charge_money ���ѽ��,insur_rate ����,insur_type_c ����,insur_period Ͷ��֧������,equip_amt ��Ŀ���,project_name ��Ŀ����,insur_type Ͷ����ʽ,insure_pay_type ������ȡ��ʽ,cust_name ����ͻ�,proj_manage_name ��Ŀ����,cd_date CD����ʱ��,insur_obj Ͷ����,insur_date Ͷ������,insur_start_date Ͷ����ʼ����,insur_term Ͷ������,insur_end_date Ͷ��������,leas_end_date ���޵�����,xbmonth_amount ���������� from vi_insur_unxb where 1=1"+wherestr;
%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>CD��������ʽ
<select name="CD" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=cd %>","|����|����","|����|����")); 
	</script>
</select>
</td>

<td>Ͷ����ʼ��������
<select name="start_date_t" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=start_date_t %>","|����|����","|����|����")); 
	</script>
</select>
</td>
<td>Ͷ����ʽ
<select name="insur_type" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=insur_type %>","|��˾����|��˾����","|��˾����|��˾����")); 
	</script>
</select>
</td>
</tr>
<tr>
<td>Ͷ��������:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
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
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	  		<td><a href="#" accesskey="m" onclick="start_flow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="����(Alt+M)" align="absmiddle">����</a></td>
			<td>
			<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
			<input name="excel_name" type="hidden" value="insur_unxb">
			
			<a href="#" accesskey="n" onclick="return validata_data_report('../../func/exp_report.jsp','fund_exec_list.jsp');">
		    <img align="absmiddle"  src="../../images/action_down.gif" alt="����" align="absmiddle">��������</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	<th width="1%"></th>
		<th>������</th>
		<th>Ͷ�����</th>
		<th>���ѽ��</th>
		<th>����</th>
		
		<th>����</th>
		<th>Ͷ��֧������</th>
		
		<th>��Ŀ���</th>
		<th>��Ŀ����</th>
		<th>Ͷ����ʽ</th>
		<th>������ȡ��ʽ</th>
		<th>����ͻ�</th>
        <th>�ĵ����</th>
		<th>��Ŀ����</th>
		<th>CD����ʱ��</th>
		
		<th>Ͷ����</th>
		<th>Ͷ������</th>
		<th>Ͷ����ʼ����</th>
        <th>Ͷ������</th>
        <th>Ͷ��������</th>
        <th>���޵�����</th>
        <th>����������</th>
        <th>״̬</th>
      </tr>
      <tbody id="data">
<%
String col_str=" *,(select top 1 archive_no from contract_archive where contract_id=vi_insur_unxb.contract_id) as archive_no  ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_insur_unxb where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_insur_unxb where 1=1 "+wherestr+" order by  "+wherestr1+" ) "+wherestr ;
sqlstr += " order by  "+wherestr1+" ";
System.out.println("aaaaa"+sqlstr);
String pFl = "";
int flag = 0;

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	pFl = getDBStr( rs.getString("flag") );
	flag= Integer.parseInt(pFl.isEmpty()?"0":pFl);
%>
      <tr>
      	<td>
			<input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("id"))%>" 
			contrId="<%=getDBStr( rs.getString("contract_id")) %>"
			flag="<%=flag %>" projName="<%=getDBStr( rs.getString("project_name")) %>" projId="<%=getDBStr( rs.getString("proj_id")) %>">
      	</td>
		<td align="left"><%=getDBStr( rs.getString("insur_no")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("insur_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("insur_charge_money" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_rate")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("insur_type_c")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_period")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("archive_no")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("cd_date")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("insur_obj")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_date")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_start_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("insur_term" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_end_date")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("leas_end_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("xbmonth_amount" )) %></td>
		<td align="center">
			<font color="blue">
			<%
				if( flag>0 && flag<10){
			%>
					������
			<%	
				}else if(flag==0){
			%>
					δ����
			<% 
				}else if(flag==10){
			%>
					<font color="red">��������Ŀδ������ ȷ��δ����������</font>
			<% 
				}else if(flag>10){
			%>
					<font color="red">��������Ŀ�����У� ȷ��δ����������</font>
			<% 
				}
			%>
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
