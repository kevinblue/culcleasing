<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Ʊ�ݹ��� - Ʊ�ݹ���</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<style>
select{
width:50px;
}
</style>

<script type="text/javascript">
// �Ƿ�����ύ��������
function isSub(obj) {


	var fp_method=document.getElementById("fp_method").value;
	//alert(cust_name);
	


		//�õ���ѡ��ļ���
 	var names=document.getElementsByName("list");
 	var statu=0;
 	//var flag_fp=0;
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
				statu++;
				
				//�жϷ�Ʊ���뷢Ʊ����
				//flag
				var flag_value=names[i].attributes["flag"].nodeValue;
				if (flag_value>0) {
					//flag_fp++;
					alert("��Ŀ"+names[i].attributes["xmNum"].nodeValue+"û�з�Ʊ�Ż�Ʊ����!");
					return false;
				}
		}
	}
	if (statu==0) {
			alert("��ѡ����Ҫ�������Ŀ!");
			return false;
	}else if(fp_method==""||fp_method==null){
	alert("Ʊ�����Ͳ���Ϊ��");
	return false;
	}
	else{
	document.search.action="fund_fpgl_save.jsp?savetype=add";
	return confirm("�Ƿ�ȷ���ύ");
	} 
	
	return false;
	
}


function search_proj() {
	document.search.action="fpgl_add.jsp";
	document.search.submit();
}




</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;" class="linetype">
<form name="search" method="post" action="fund_fpgl_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��Ʊ���� &gt;��Ʊ����
</td>
</tr>

<tr valign="top">
<td  align=center width=100% height=100% style="padding: 0px;">
<div style="margin-top: 0px;">
<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">�ύ</button>




<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">�ر�</button>

	    	</td>
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">��Ʊ��Ϣ</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>

<div style="margin-top: 5px;">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;margin: 0px;">
<div id="TD_tab_0">


<%
String sqlstr;
//ResultSet rs;

//�õ���ǰ��½���û�
String dqczy = (String) session.getAttribute("czyid");

//��ѯ�����ж�
//String contract_id="";
//String cust_name="";
//String create_start_date="";
//String create_end_date="";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
String cust_name = getStr( request.getParameter("cust_name") );
String fp_method = getStr( request.getParameter("fp_method") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("������") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("��ͬ���") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("���") ) {
	searchFld_tmp = "rent";
}else if( searchFld.equals("�Ǽ���") ) {
	searchFld_tmp = "dbo.GETUSERNAME(creator)";
}else{
	searchFld_tmp = "";
}
if( !cust_name.equals("") && cust_name!=null){
	wherestr = wherestr + " and cust_name= '"+cust_name+"' ";
	
}
if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+create_end_date+"' ";
}
String where_str =wherestr;

String sql="select * from vi_fund_invoice " + where_str+" and vi_fund_invoice.id not in(select plan_id from proj_invoice_detail where proj_invoice_detail.proj_invoice_id in(select id from proj_invoice)) order by contract_id";
rs=db.executeQuery(sql);
System.out.println("sql="+sql);

sqlstr="select * from vi_fund_invoice where vi_fund_invoice.id not in(select plan_id from proj_invoice_detail) order by  contract_id desc";
System.out.println("sqlstr="+sqlstr);
String id="";
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 

	id=getDBStr(rs.getString("id"));
}
rs.close();

String contract_id1="";
String cust_name1="";
//������Ŀ������Ϣ�в�Ʒ����Ϊ���ĵ�ѡ��
String prod_id_str="";
sqlstr="select * from ifelc_conf_dictionary where name='EquipType'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	prod_id_str=prod_id_str+"|"+getDBStr(rs.getString("title"));
}rs.close();


%>


<input type="hidden" name="savetype" value="add">
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="plan_id" id="plan_id"/>
<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />
<input type="hidden" name="invoice_number" id="invoice_number"/>

<input type="hidden" name=" invoice_date" id=" invoice_date"/>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
  <tr class="maintab">
   <td>  �� �� ��<input class="text" name="cust_name" accesskey="s" type="text" size="15" readonly="readonly" value="<%= cust_name %>">
   <img src="../../images/fdmo_65.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','������','vi_cust_all_info_t','cust_name','cust_id','cust_name','cust_name','asc','search.cust_name','search.cust_name');"><span class="biTian">*</span>
 
					&nbsp;��&nbsp;<select class="text" name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|��ͬ���|���"));</script></select>
					&nbsp;��ѯ&nbsp;<input class="text" name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
              
				
					
		�������<input class="text" name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input class="text" name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input  name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="invoice_submit();">
                </td>
			</tr>
	
  <tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
 <tr>
   
   
	
	<td scope="row" colspan="2">
		
		<input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ/��ѡ
	</td>
	<td>Ʊ������</td>
	<td>
	<select class="text" name="fp_method"><script>w(mSetOpt("<%= fp_method %>","|��Ʊ|�վ�"));</script></select>
	</td>
	
    <td>��Ʊ̧ͷ</td>
	<td>
	<input class="text" name="invoice_name" id="invoice_name" type="text"  readonly maxlength="20" size="10">
	</td>
	 <td scope="col">��Ʊ���:</td>
    <td> 
    <input class="text" name="invoice_total" id="invoice_total" type="text"  readonly maxlength="10" size="10">
	</td>
  </tr>


</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;left: 0px; top: 0px;"
				id="mydiv";>
				
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="0" cellspacing="0" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
							 <th width="1%"></th> 						
       						<th>���</th>
	    <th>��Ŀ����</th>
	    <th>��ͬ���</th>
	    <th>��Ʊ̧ͷ</th>
	    <th>��������</th>
	    <th>����</th>
	    <th>���</th>
	    <th>�ƻ��տ�����</th>
						</tr>
						<tbody id="data">
						<%
						String sqls="select * from vi_fund_invoice where vi_invoice.id not in(select plan_id from proj_invoice_detail) ";
						System.out.println("sqls"+sqls);
						rs=db.executeQuery(sql);
						int n=0;
						//��ѡ��id
						String ckid="";
						String pro_id="";
						String plan_id="";
						String rent="";
						String invoice_name="";
						int flag=0;
						while(rs.next()){
					    flag=0;
						ckid="ck_"+n;
						pro_id=getDBStr(rs.getString("contract_id"));
						rent=getDBStr(rs.getString("plan_money"));
					    plan_id=getDBStr(rs.getString("id"));
					   // if(getDBStr(rs.getString("invoice_number")).trim().length()==0||getDBStr(rs.getString("invoice_date")).trim().length()==0 ){
					  //  flag++;
					  //  }
						 %>
						
						<tr>
							<td>
								<input  type="checkbox"  name="list" id="<%=ckid %>" onclick="makeValue();"  rent="<%=rent%>" 
								plan_id=<%= getDBStr( rs.getString(("id") )) %> flag="<%=flag %>" invoice_name=<%=getDBStr( rs.getString("cust_name") )  %>>
							</td>
	        				
	        				<td align="center"><%= getDBStr( rs.getString(("id") )) %></td>
		<td align="center">
		<%= getDBStr( rs.getString("project_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("feetype_name") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("plan_list") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("plan_money") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("plan_date") ) %></td>
						</tr>
						
						<%
						n++;
						} %>
						
	</tbody>					
</table>

</div>
</div>
</div>
<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

</div>
</div>

<div style="margin-top: 5px;">
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</div>
</td>
</tr>
</table>  
</div>
<%
rs.close(); 
db.close();

 %>
 
 <script type="text/javascript">

var sid="";
var total=0.00;
var invoice_name="";
   
 function makeValue(){
 total=0;
 sid="";

 	//�õ���ѡ��ļ���
 	var names=document.getElementsByName("list");
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
	    	var plan_id=parseFloat(names[i].attributes["plan_id"].nodeValue);
	    	invoice_name=names[i].attributes["invoice_name"].nodeValue;
	    	//alert(cust_name);
			var rent=names[i].attributes["rent"].nodeValue;
		   //�õ�������
		    total=total+parseFloat(rent);
		    sid=sid+plan_id+",";
	    }
	    
  	}
  	document.getElementById("invoice_total").value=total;
  	if(total=="0"){
  	invoice_name="";
  	}
  	document.getElementById("invoice_name").value=invoice_name;
  	document.getElementById("plan_id").value=sid.substring(0,sid.length-1);
  	///plan_id.value=sid.substring(0,sid.length-1);
  	///alert(sid.substring(0,sid.length-1));
  	//alert(total+"=="+document.getElementById("plan_id").value);
 }

function isSelectAll () {

	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	makeValue();
}


//����Excel
function isExport() {
	if (confirm("�Ƿ�ȷ�ϵ���Excel!")) {
	
		search.action="export_save.jsp";
		document.getElementById("where_str").value="<%=wherestr%>";
  		search.submit();
		search.action="fpgl_add.jsp";
	}
	return false;
}
 </script>
 
 
</form>


<!-- end cwMain -->
</body>
</html>
