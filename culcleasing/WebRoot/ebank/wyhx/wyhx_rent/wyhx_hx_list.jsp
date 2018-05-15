<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="/func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ�����(���) - ��������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<%
String curr_date = getSystemDate(0);
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String proj_id = getStr(request.getParameter("proj_id"));
String prod_id = getStr(request.getParameter("prod_id"));
String dld_name = getStr(request.getParameter("dld_name"));
String account_name = getStr(request.getParameter("account_name"));
String bank = getStr(request.getParameter("bank"));
String punish_flag = getStr(request.getParameter("punish_flag"));
String exp_state = getStr(request.getParameter("exp_state"));

//String wherestr=" where 1=1 and a.show_amt>0";
wherestr=" and 1=1 ";

if(!exp_state.equals("")){
	if( "δ����".equals(exp_state) ){
		wherestr+=" and isnull(exp_state,0) = 0 ";
	}else{
		wherestr+=" and isnull(exp_state,0) > 0 ";
	}	
}
if(!start_date.equals("")){
	wherestr+=" and convert(varchar(10),qz_date,21)>='"+start_date+"' ";
}
if(!end_date.equals("")){
	wherestr+=" and convert(varchar(10),qz_date,21)<='"+end_date+"' ";
}
if(!proj_id.equals("")){
	wherestr +=" and proj_id like '%"+proj_id+"%'";
}
if(!prod_id.equals("")){
	wherestr +=" and prod_id = '"+prod_id+"'";
}

if(!dld_name.equals("")){
	wherestr +=" and dld like '%"+dld_name+"%'";
}
if(!account_name.equals("")){
	wherestr +=" and account_name like '%"+account_name+"%'";
}
if(!bank.equals("")){
	wherestr +=" and bank = '"+bank+"'";
}

sqlstr=" select item_id as memo, ";
sqlstr+=" proj_id,rent_list,isnull(costmoney,0) as costmoney, ";
sqlstr+=" fee_type,exp_state,khmc,account_name, account,bank,card_id ";
sqlstr+=" from vi_report_rent_invoice ";
sqlstr+=" where hire_status='δ����' ";
sqlstr+=" and item_method='����' and isnull(costmoney,0)>0 and";
sqlstr+=" (select case when CHARINDEX('_',item_id)>0 then substring(item_id,0,CHARINDEX('_',item_id)) else item_id end)";
sqlstr+=" in(select cast(id as varchar(16)) from fund_rent_plan where export_flag='1') ";
//sqlstr+=" and not exists( select id from apply_info_detail where plan_id=vi_report_rent_invoice.item_id) ";
sqlstr+=" and isnull(hg_remark,'')<>'�����̵��' ";
sqlstr+=" and plan_date <= dateadd(dd,0,getdate()) "+wherestr;
sqlstr+=" order by proj_id,rent_list,fee_type ";
%>

<body onload="public_onload(0);">
<form action="wyhx_hx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="sqlstr" value="<%=sqlstr %>" type="hidden">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		�ʲ�����(���)&gt; ��������</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>�ֿ���:<input name="account_name" type="text" size="11" value="<%=account_name %>"></td>
<td>��&nbsp;Ŀ��&nbsp;��:<input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>����������:<select name="prod_id" style="width:113px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%= prod_id_str%>"));</script>
     </select>
</td>
<td>��������:<select name="bank" style="width:90px;">
<script>w(mSetOpt('<%=bank%>',"<%=bank_str%>"));</script>
</select>
</td>
<td>
<input name="" type="button" value="��ѯ" onclick="xx_submit('');">
</td>
</tr>
<tr>
<td>������:<input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<!-- 
Υ Լ ��<select name="punish_flag">
 <script>w(mSetOpt('<%=punish_flag%>',"��|��"));</script>
 </select>
-->
<td>����ȷ����:<input name="start_date" type="text" size="11" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
---&nbsp;��&nbsp;---:<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
����״̬:<select name="exp_state" style="width:90px;">
 <script>w(mSetOpt('<%=exp_state%>',"|δ����|����ʧ��"));</script>
 </select>
</td>
<td>
<input type="button" value="���" onclick="clearQuery();">
</td>
</tr>
</table>
</fieldset>
</div>

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td nowrap>
				<a href="#" accesskey="n" onclick="xx_submit('����')">
				<img src="../../images/sbtn_new.gif" alt="�ϴ��ۿ��ִ" align="absmiddle">�ϴ��ۿ��ִ</a>
				</td>
				<td>
				<BUTTON class="btn_2" name="btnModify" value="����"  type="button" onclick="xx_submit('����') ">
				<img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">����</button>
				</td>
				<td>
					<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" type="checkbox">&nbsp;ȫѡ
				</td>
			</tr>
		</table><!--������ť����-->
		</td>
		<td align="right" width="90%">					 	
			<!--��ҳ���ƿ�ʼ-->
			<%@ include file="../../public/pageSplitNoCode.jsp" %>
			<!--��ҳ���ƽ���-->
		</td>
	</tr>
</table><!--������Ͳ���������-->


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>�ͻ����֤��</th>
		<th>������</th>
		<th>��������</th>
		<th>�ͻ��ʺ�</th>
		<th>���</th>
		<th>��Ŀ���</th>
		<th>�ڴ�</th>
		<th>���</th>
		<th>��ע</th>
		<th>״̬</th>
      </tr>
  
<tbody id="data">
<%	 
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("memo"))%>"></td>
        <td align="left"><%=getDBStr( rs.getString("card_id") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("account_name") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("bank") ) %></td>
        <td><%=getDBStr( rs.getString("account") ) %></td>
        <td align="right"><%=CurrencyUtil.convertFinance( rs.getDouble("costmoney") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("proj_id") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("rent_list") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("fee_type") ) %></td>
        <td><%=getDBStr( rs.getString("memo") ) %></td>
		<td align="center"><%="0".equals(rs.getString("exp_state"))?"δ����":"����ʧ��"+rs.getString("exp_state")+"��" %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
 </tbody>   </table>
</div>

<!--�������-->
</form>
</body>
</html>
<script language="javascript">
function xx_submit(str){
  	if(str=="����"){
  		dataNav.action="export_save.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}else if(str=="����"){
  		dataNav.action="wyhx_upload.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
	}else if(str=="����"){
		if (validate_sel()){ 
			dataNav.action="state_check.jsp";
			dataNav.target="_black";
			dataNav.submit();
		}
  	}else{
  		dataNav.action="wyhx_hx_list.jsp";
  		dataNav.target="";
  		dataNav.submit();
  	}
}
</script>

<script type="text/javascript">
String.prototype.trim = function()
{
    return this.replace(/(^\s*)|(\s*$)/g, "");
};
 
var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}

function stateChanged(){	
	if(xmlHttp.readyState == 4)	{
		var returnvalue=xmlHttp.responseText ;
		if(returnvalue!=""){
			if (returnvalue.trim()=="-1") {
				alert("�޸�״̬�ɹ�!");
				window.location.reload(true);
			} else {
				alert("�޸�״̬ʧ��!");
			}
		}
	}	
}
function updateState(){
  	xmlHttp = GetXmlHttpObject();
	if (validate_sel()){ 
		if (confirm("����:ȷ�Ϻ�Ὣ��ʷ��¼�޸�!")){
			var url = "state_check.jsp?sql_bh_ids='"+document.getElementById("sql_bh_ids").value+"'";
			xmlHttp.onreadystatechange = stateChanged;	
			xmlHttp.open("POST",url,false);
			xmlHttp.send(null);
		} 
  	}
}

String.prototype.ReplaceAll = function(stringToFind,stringToReplace)
{
		var result = this;
		var index = result.indexOf(stringToFind);
		while(index != -1){
				result = result.replace(stringToFind,stringToReplace);
				index = result.indexOf(stringToFind);
		}
		return result;
}

function validate_sel() {
	//�Ƿ���ѡ�еĸ����
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//������Ҫɾ���ĸ����
	sql_bh_ids="";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			str_bh+=fid+",";
			sql_bh_ids+=fid+",";
		}
	}

	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	document.getElementById("sql_bh_ids").value=sql_bh_ids;
	if (flag_bh==0) {
		alert("��ѡ����Ҫ���õ���Ŀ!");
		return false;
	}else {
		if (confirm("����:ȷ�Ϻ�Ὣ��ʷ��¼�޸�!")){
			return true;
		}
		return false;
	}
}
</script>

