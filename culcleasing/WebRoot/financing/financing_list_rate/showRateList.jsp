<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������������ʱ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//��������
function newAdd(){
//alert("join");
//	var str = document.getElementsByName("name")[0].value;
	//�������ڽ�����������
	window.open('rate_add.jsp?model="add"','���л�׼������������','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}
//ɾ������
function newDel(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var i = 0;
    for (i = 0; i < form1.key_id.length; i++)
    {
        if (form1.key_id[i].checked)
        {
            selectedIndex = i;
            str_key_id = form1.key_id[i].value;
            break;
        }
    }
    alert(str_key_id);
    if (selectedIndex < 0)
    {
        alert("����ѡ����Ҫɾ����������!");
        return false;
    }
	window.open("rate_save.jsp?model=del&key_id="+str_key_id,'���л�׼����ɾ������','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<body>
<%
	//Ȩ�޴��� 
	String dqczy = (String) session.getAttribute("czyid");
	String str = "";
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//���л�׼���ʱ�
	String sqlstr = " select * from financing_list_rate order by id "; 
%>
<form name="form1" action="showRateList.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	������������ʱ�
      </td>
    </tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="3">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
            <!-- Ȩ�޿��� -->
         <% //if (right.CheckRight("zjcs-tx-add",dqczy)>0){ %>
	              <a href="#" accesskey="n" onClick="dataHander('add','rate_add.jsp?model=add',form1.key_id);">
	              		<img src="../../images/sbtn_new.gif" alt="����(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <%// } %>
	
            <%//if (right.CheckRight("zjcs-tx-del",dqczy)>0){ %>
			   <a href="#" accesskey="d" onClick="dataHander('del','rate_save.jsp?model=del&key_id=',form1.key_id);">
				<img src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        <%// }%>
	        
			</td>
          </tr>
        </table>
        </td>
    </tr>
 
    <tr class="maintab">
      <td align="center" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
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

<!--��ҳ���ƽ��� style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>����</th>
	    <th>����ʱ��</th>
		<th>��������һ�꣨��һ�꣩</th>
		<th>һ�����꣨�����꣩</th>
		<th>�������꣨�����꣩</th>
		<th>��������</th>
		<th>��ʼʱ��</th>
		<th>��ֹʱ��</th>
		<th>��ǰӦ������</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
		BigDecimal bignum = new BigDecimal("100");
%>
      <tr>
      	<!-- ��Ծ��������н����޸�ɾ������  -->
      	<td align="center" nowrap><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("id"))%>"/></td>
        <td align="center" nowrap><%= getDBStr(rs.getString("Adjust_time"))%></td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_one").multiply(bignum).doubleValue()%>%</td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_three").multiply(bignum).doubleValue()%>%</td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_five").multiply(bignum).doubleValue()%>%</td>
	    <td align="center" nowrap><%= rs.getBigDecimal("base_rate_abovefiv").multiply(bignum).doubleValue()%>%</td>
        <td align="center" nowrap><%= getDBStr(rs.getString("rate_start_date"))%></td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("rate_end_date"))%></td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("Rate_flag"))%></td>	
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
