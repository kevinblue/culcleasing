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
			document.search.action="save.jsp?savetype=add";
			
		 if (document.getElementById("pay_date").value.length==0) {
				alert("��ѡ��Ӧ������!");
				return false;
			}
			return confirm("�Ƿ�ȷ���ύ");
	}
	return false;
	
}


function search_proj() {
	document.search.action="t.jsp";
	document.search.submit();
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;">
<form name="search" method="post" action="t.jsp">
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
String sqlstr;
ResultSet rs;

//�õ���ǰ��½���û�
String dqczy = (String) session.getAttribute("czyid");

String wherestr=" where 1=1 ";
//��ѯ�����ж�
String contract_id="";
String cust_name="";
String create_start_date="";
String create_end_date="";
//String create_start_date = getStr( request.getParameter("create_start_date") );
//String create_end_date = getStr( request.getParameter("create_end_date") );
if ( !contract_id.equals("") ) {
	wherestr = wherestr + " and  contract_id  like '%" + contract_id + "%'";
}

if ( !cust_name.equals("") ) {
	wherestr = wherestr + " and cust_name  like '%" + cust_name + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}
String where_str =wherestr;

String sql="select * from vi_invoice "+where_str;
rs=db.executeQuery(sql);
System.out.println("sql="+sql);

//���ݵ�ǰ��½���û���ѯ������˾��ص���Ϣ
//sqlstr="select gs.bmmc as bmmc,yh.bm as bmid,dl.skyy,dl.skzh from jb_yhxx yh  ";
//sqlstr +=" left join jb_gsbm gs on gs.id = yh.bm left join dl_mpxx dl on dl.khbh=gs.bmbh where yh.id='"+dqczy+"' ";
sqlstr="select * from vi_invoice";

System.out.println("sqlstr="+sqlstr);
String id="";
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 

	id=getDBStr(rs.getString("id"));
}
rs.close();


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

<input type="hidden" name="where_str" id="where_str" value="<%=where_str%>" />


<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">

   <tr>
    <td scope="row">��ͬ���:</td>
    <td > 
    <input name="contract_id" type="text" size="12" value="<%=contract_id %>"    maxlength="10">
	</td>
	<tr>
	 <td scope="row">��Ʊ����ʱ��:</td>
    <td> 
   
    <input name=create_start_date type="text" size="12"   value="<%=create_start_date %>"   readonly maxlength="10" dataType="Date">
     <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="create_end_date" type="text" size="12"   value="<%=create_end_date %>"   readonly maxlength="10" dataType="Date">
     <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     &nbsp;
	</td>
</tr>
   <tr>
   
    <td  scope="row">�ͻ�����:</td>
    <td> 
    <input name="cust_name" type="text" size="12"   value="<%=cust_name %>"   maxlength="10">
	</td>   
	
	
  </tr>
  <tr>
 
	<td colspan="2">
		<input name="" type="button" value="��ѯ" onclick="search.submit();">&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ/��ѡ
	</td>
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
     <td scope="row">��Ʊ��������:</td>
    <td> 
    <input name="pay_date" type="text"  width="50px;"   readonly maxlength="10" dataType="Date" Require="true">
	<span class="biTian">*</span>
	<img  onClick="openCalendar(pay_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	 <td  scope="row">��Ʊ���:</td>
    <td > 
    <input name="pay_amt" id="pay_amt" type="text" width="50px;"    readonly maxlength="10">
	</td>
	 <td scope="row">��Ʊ��</td>
    <td>
  <input name="proj_number" id="proj_number" type="text" width="50px;"    readonly maxlength="10">
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
						</tr>
						<tbody id="data">
						<%
						String sqls="select * from vi_invoice";
						System.out.println("sqls"+sqls);
						rs=db.executeQuery(sql);
						int n=0;
						//��ѡ��id
						String ckid="";
						String je="";
						String pro_id="";
						String plan_id="";
						int flag=0;
						while(rs.next()){
						ckid="ck_"+n;
						pro_id=getDBStr(rs.getString("proj_id"));
					  //  plan_id=getDBStr(rs.getString("plan_id"));
					
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
		search.action="t.jsp";
	}
	return false;
}


 </script>
</form>


<!-- end cwMain -->
</body>
</html>
