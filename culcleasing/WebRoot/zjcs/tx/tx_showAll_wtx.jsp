<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ - ����δ��Ϣ�б�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script>  
<script type="text/javascript">
//��������
function tiaoxi(){
//alert("join");
	var str_checkbos_list = '';
	var begin_id_list = '';
	var str_adjust_style = '';//��Ϣ��ʽ
	var selectedIndex = -1;
    var dataNav = document.getElementById("dataNav");
    var str = document.getElementsByName("checkbos_list");
    var i = 0;
    for (i = 0; i < str.length; i++)
    {
        if (str[i].checked)
        {
            selectedIndex = i;
            str_checkbos_list = str_checkbos_list + str[i].value + "#";
            str_adjust_style = str_adjust_style + str[i].attributes["adjust_style"].nodeValue + "#";
            begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";
        }
    }
    if (selectedIndex < 0 )
    {
        alert("����ѡ����Ҫ��Ϣ��������!");
        return false;
    }
   str_checkbos_list = str_checkbos_list.substring(0,str_checkbos_list.length-1);
   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
   str_adjust_style = str_adjust_style.substring(0,str_adjust_style.length-1);
    //window.open('tx_executeTx.jsp?all_checkbos_value='+str_checkbos_list,'���е�Ϣ','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
   //��ͬ���
   document.getElementById('all_checkbos_value').value = str_checkbos_list;
   document.getElementById('begin_id_list').value = begin_id_list;
   document.getElementById('adjust_style').value = str_adjust_style;
    //alert(str_checkbos_list);
    dataNav.action = "tx_executeTx.jsp";
    document.dataNav.target = "_blank";
    dataNav.submit();
	    dataNav.action = "tx_showAll_wtx.jsp";
    document.dataNav.target = "_self";
}
//checkbosȫѡ
function isSelectAll() {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
}
//��Ϣ֮δ��Ϣ��¼ģ����ѯ
function query(){
	//dataNav.action = "";
	//document.dataNav.target = "tx_showAll_wtx.jsp";
	dataNav.submit();
}
</script>
</head>
<body>
<%
	 //�������ʻ�׼���е�����,ͨ���������ڱ�fund_adjust_interest_contract�в�ѯ��Ӧ��contract_id
	String txId = getStr(request.getParameter("txId"));  
	String adjust_method = getStr(request.getParameter("adjust_method")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); 
	String adjustStyle = getStr(request.getParameter("adjustStyle")); 
	String start_date = getStr(request.getParameter("start_date"));
	//��ȡ��ѯ����
	String contract_id = getStr(request.getParameter("query_contract_id")); 
	String project_name = getStr(request.getParameter("query_project_name")); 
//	String start_date = getStr(request.getParameter("start_date")); //��Ϣ��ʼ����
	System.out.println("adjust_method<-123-->"+adjust_method);
	String str = "";
	ResultSet rs;
	//rate_float_type  rate_float_amt ajdustStyle
	// ���ʸ������͡����ʵ���ֵ����Ϣ��ʽ
	StringBuffer sql = new StringBuffer();
	sql.append(" select distinct vts.* from vi_tx_showAll_wtx vts left join fund_rent_plan frp on vts.begin_id=frp.begin_id ")
	   .append(" where frp.plan_date>= '"+start_date+"' and not exists ( ")
	   .append(" select contract_id from fund_adjust_interest_contract fa  ")
	   .append(" where fa.contract_id=vts.contract_id and fa.begin_id=vts.begin_id  ");
	   if(!txId.equals("") && txId != null){
		  sql.append(" and adjust_id = "+txId+" ");//�����ID��fund_standard_interest��ID
	    }   
	   sql.append(" ) ");
	   if(!contract_id.equals("") && contract_id != null){
		  sql.append(" and vts.contract_id like '%"+contract_id+"%' ");//
	   }   
	   if(!project_name.equals("") && project_name != null){
		  sql.append(" and project_name like '%"+project_name+"%' ");//
	   }  
	   if(!adjustStyle.equals("") && adjustStyle != null){
		  sql.append(" and adjust_style like '%"+adjustStyle+"%' ");//
	   }  
	   //����Ϣ����С����Ŀ�ڣ���������Ŀ���иôε�Ϣ����֮������
	   sql.append("  and  start_date<='"+start_date+"' ");
	   //���˵����յ�Ϣ
	   sql.append("   and settle_method='"+adjust_method+"'");
	   //���˵�ֻʣ���һ�ڵ�(�ε����һ�ڽ��д��ڵ�Ϣ������)
	   sql.append(" and vts.begin_id not in (select frp.begin_id from fund_rent_plan frp left join begin_info bi on frp.begin_id=bi.begin_id where plan_date>='"+start_date+"' and bi.adjust_style=2 group by frp.begin_id having count(rent_list)<=1)");
	   System.out.println("222222��ѯsql���==>> "+sql.toString());
	   //fund_standard_interest
	   //String quer_ = "  select * from fund_standard_interest where id = '"+custId+"' ";
%>
<form name="dataNav" action="tx_showAll_wtx.jsp" method="post" onSubmit="return goPage()">
<!-- �������ʻ�׼���е����� ,ѡ�еĺ�ͬ���  -->
<input type="hidden" name="txId" id="txId" value="<%=txId%>"/>
<input type="hidden" name="adjust_method" id="adjust_method" value="<%=adjust_method%>"/>
<input type="hidden" name="all_checkbos_value" id="all_checkbos_value"/>
<input type="hidden" name="adjust_style" id="adjust_style"/>
<input type="hidden" name="begin_id_list" id="begin_id_list"/>
<input type="hidden" name="save_type" value="add" />
<input type="hidden" name="adjust_flag" id="adjust_flag" value="<%=adjust_flag%>">
<input type="hidden" name="start_date" id="start_date" value="<%=start_date%>">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt"  valign="middle" id="cwCellTopTitTxt">
      	��Ϣ &gt; δ��Ϣ��¼�б�
      </td>
      <td></td>
    </tr>
    <tr class="maintab" style="height: 25px">
		<td align="left" >               
			&nbsp;��ͬ���&nbsp;
			<input type="text" name="query_contract_id" value="<%=contract_id%>" />
			&nbsp;��Ŀ����&nbsp;
			<input name="query_project_name" type="text" size="15" value="<%=project_name%>"/>
				��Ϣ��ʽ
			<select name="adjustStyle">
			  <script type="text/javascript">
			   	w(mSetOpt('<%=adjustStyle %>',"|����|����|����","|����|����|����"));
			  </script>
			</select>		
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="��ѯ" border="0" align="absmiddle" >
			</a>
		</td>
		<td nowrap="nowrap" align="left">
		<%	
			if("��".equals(adjust_flag)){
		%>	
			<a href="#" onclick="tiaoxi();">
			<!-- onClick="dataHander('mod','tx_fsi_add.jsp?model=mod&key_id=',dataNav.key_id);" -->
            	<img src="../../images/sbtn_new.gif" alt="����" border="0" align="absmiddle" >
          ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </a>
           <%
           }
           %>
       </td>
       
	</tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
 
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 50;   //һҳ��ʾ�ļ�¼��   
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr(request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sql.toString());

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
		var nf = document.dataNav;
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
<!--��ҳ���ƽ��� style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=80%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      <!-- hidefocus --> 
	    <th width="1%">
	    	<input name="ck_all" id="ck_all" type="checkbox"   onclick="isSelectAll();">ȫѡ
	    </th>
	  
	    <th>��ͬ���</th>
	    <th>������</th>
		<th>��Ŀ����</th>
		<th>����</th>
		<th>���ʸ�������</th>
		<th>���ʵ���ֵ</th>
		<th>�����㷽ʽ</th>
		<th>����/����</th>
		<th>��Ϣ��ʽ</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<!-- ��Ծ��������н����޸�ɾ������  -->
      	<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("contract_id"))%>" 
      		begin_id="<%=getDBStr(rs.getString("begin_id"))%>" adjust_style="<%=getDBStr(rs.getString("adjust_style"))%>"/></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("begin_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("project_name"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("dept_name"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("rate_float_type"))%></td>
		<td align="center" nowrap><%= rs.getDouble("rate_float_amt")%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_type"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("ratio_param"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_style"))%></td>
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
</form>
</body>
</html>
