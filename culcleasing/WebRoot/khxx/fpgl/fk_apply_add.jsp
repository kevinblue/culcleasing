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
<title>���� - �ſ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

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
width:150px;
}
</style>

<script type="text/javascript">
// �Ƿ�����ύ��������
function isSub(obj) {
	//if (document.getElementById("proj_number").value=='')
//	{
		//alert("û�п������������!");
		//	return false;
	//}
		//return true;

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
	} else{
			document.search.action="fk_apply_save.jsp?savetype=add";
			
		 if (document.getElementById("pay_date").value.length==0) {
				alert("��ѡ��Ӧ������!");
				return false;
			}
			return confirm("�Ƿ�ȷ���ύ");
	}
	return false;
	
}


function search_proj() {
	document.search.action="fk_apply_add.jsp";
	document.search.submit();
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;">
<form name="search" method="post" action="fk_apply_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���� -�ſ�
</td>
</tr>

<tr valign="top">
<td  align=center width=100% height=100% style="padding: 0px;">
<div style="margin-top: 0px;">
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>

<BUTTON class="btn_2" name="btnExport" value="����"  type="submit"  onclick="return isExport();" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>


<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�޸���Ϣ</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>

<div style="margin-top: 5px;">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;margin: 0px;">
<div id="TD_tab_0">


<%



//�õ���ǰ��½���û�
String dqczy = (String) session.getAttribute("czyid");


System.out.println("1"+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
System.out.println("2"+searchFld);
String searchKey = getStr( request.getParameter("searchKey") );
System.out.println("3"+searchKey);
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("�ͻ�����") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("��ͬ���") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("�Ǽ���") ) {
	searchFld_tmp = "dbo.GETUSERNAME(creator)";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}
String sqlstr="select * from  vi_invoice" + wherestr +" order by create_date desc"; 
System.out.println("###"+sqlstr);

%>
<input type="hidden" name="savetype" value="add">

<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
 
    <td>��Ʊ��</td>
    <td><input name="invoice_number" type="text" size="20" maxB="50" Require="ture">
  <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>��Ʊ����</td>
    <td><input name="invoice_date" type="text" size="20" readonly maxlength="10" dataType="Date" Require="ture">
     <img  onClick="openCalendar(invoice_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
	</tr>
	<tr>
    <td>��Ʊ���</td>
    <td><input name="invoice_amt" type="text" size="20" maxB="100" dataType="Money">
  </td>
  </tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
		<tr class="maintab">
				<td align="left" colspan="2">  
            
					&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|��ͬ���|�ͻ�����|�Ǽ���"));</script></select>&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		�������<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
                </td>
    </tr>


</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:360px;"
				id="mydiv";>
				
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="2" cellspacing="1" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
							 <th width="1%"></th> 
							 						
       					  <th>���</th>
	    <th>��Ŀ����</th>
	    <th>��ͬ��</th>
	    <th>��ͬ���</th>
	    <th>��Ʊ̧ͷ</th>
	    <th>������</th>
	    <th>������</th>
	    <th>��������</th>
		<th>����</th>
		<th>��Ϣ</th>
							  <%--
							   <th>��Ʊ��</th>
      						  <th>��Ʊ����</th>
							  --%>
						</tr>
						<tbody id="data">
						<%

System.out.println("dqczy:"+dqczy);
String s="select count(*) as c,jb_yhxx.bmbh from jb_yhxx where id='"+dqczy+"' and isnull(bmbh,'')<>'' group by jb_yhxx.bmbh";

//ִ�в�ѯ
rs = db.executeQuery(s);
int count=0;
String ssjxs="";
if (rs.next()){
	count = rs.getInt("c");
	ssjxs=rs.getString("bmbh");
} 
if (count==0) {//�������޹�˾ʱ
	
	System.out.println("sqlstr==================0"+count);
}else {//���Ǿ�����ʱ
System.out.println("sqlstr==================1"+count);
//wherestr+="   and agent_id in (select jb_yhxx.bmbh from jb_yhxx where jb_yhxx.id='"+dqczy+"')";

}
%>


						
						<%
				
						ResultSet rs1=null;
						//sqlstr = "select * from vi_fk_sb   "+wherestr+" and status<>1 and  vi_fk_sb.plan_id not in( ";
						//sqlstr +=" select case when CHARINDEX('_',plan_id)>0 then substring(plan_id,0,CHARINDEX('_',plan_id)) else plan_id end ";
						//sqlstr +=" from dbo.apply_info_detail where apply_id in( select id from dbo.apply_info where pay_type='�ſ�' ";
						//sqlstr +=" ))order by vi_fk_sb.dld asc "; 
						//System.out.println("sqlstr=================="+sqlstr);
						//rs1 = db1.executeQuery(sqlstr); 
						int i=0;
							//��ѡ��id
							String ckid="";
							String je="";
							String pro_id="";
							//�ʽ�ƻ�id
							String plan_id="";
							
							//�����ж�����û�з�Ʊ���뷢Ʊ����
							int flag=0;
							
						while (rs1.next()){
							flag=0;
							ckid="ck_"+i;
							je=formatNumberDoubleTwo(rs1.getString("plan_money"));//�ſ���
							pro_id=getDBStr(rs1.getString("proj_id"));
							plan_id=getDBStr(rs1.getString("plan_id"));
							
							if (getDBStr(rs1.getString("invoice_no")).trim().length()==0 || getDBStr(rs1.getString("invoice_date")).trim().length()==0 ) {
								flag++;
							}
						
						 %>
						<tr>
							<td>
								<input  type="checkbox" name="list" value="" id="<%=ckid %>" onclick="makeValue();" je="<%=je %>" xmNum="<%=pro_id %>" plan_id=<%=plan_id %>  flag="<%=flag %>">
							</td>
	        				
	        				 	<td align="center"><%= getDBStr( rs.getString(("id") )) %></td>
		<td align="center"><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString(("rent") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("income_number") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest") ) %></td>
							<%-- 
								<td align="center"><%=getDBStr(rs1.getString("invoice_no")) %></td>
	        				<td align="center"><%=getDBDateStr(rs1.getString("invoice_date")) %></td>
							--%>
						</tr>
						
						<%
						i++;
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
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����
<script language="javascript">
ShowTabN(0);
reinitIframe();
//�ⲿdiv�߶�����Ӧ
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//�ڲ�Iframe�߶�����Ӧ
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
-->

<%
rs.close(); 
db.close();
rs1.close(); 
db1.close();
 %>
 
 <script type="text/javascript">
 
 //����������±�
 var icount=0;
 //�ܽ��
 var total=0;
 //����Ŀ��
 var xm_Number=0;
   //����һ��������,��Ŀ���
var myArr=new Array();
   //�õ���Ŀ����input����
var proj_number=document.getElementById("proj_number");
   //���������
var pay_amt=document.getElementById("pay_amt");
//�ʽ�ƻ�id
var plan_id=document.getElementById("plan_id");
var sid="";
   
 function makeValue(){
 total=0;
 icount=0;
 sid="";
myArr=new Array();
 	//�õ���ѡ��ļ���
 	var names=document.getElementsByName("list");
 	
 	//names[i].attributes["xmNum"].nodeValue;
 	
    for(i=0;i<names.length;i++){
    
    	
	    if (names[i].checked){
	    	var je=parseFloat(names[i].attributes["je"].nodeValue);
			var plan_id_1=names[i].attributes["plan_id"].nodeValue;
		   //�õ�������
		    total=total+je;
		    myArr[icount]=names[i].attributes["xmNum"].nodeValue;;
		    icount++;
		    sid=sid+plan_id_1+",";
	    }
	    
  	}
  	//��Ŀ����
  	proj_number.value=unique(myArr).length;
  	//������
  	pay_amt.value=total;
  	plan_id.value=sid.substring(0,sid.length-1);
  	
 }

//ȥ�������е��ظ�Ԫ��
function unique(data){
    data = data || [];
    var a = {};
    for ( var i=0; i<data.length; i++) {
        var v = data[i];
        if (typeof(a[v]) == 'undefined'){
                               a[v] = 1;
                               }
    };
    data.length=0; 
      for (var i in a){
               data[data.length] = i;
         }
        return data;
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
		search.action="fk_apply_add.jsp";
	}
	return false;
}


 </script>
</form>


<!-- end cwMain -->
</body>
</html>
