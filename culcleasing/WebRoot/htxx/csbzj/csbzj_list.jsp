<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body  onload="public_onload(0)">

<form action="khzygr_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				</td>
			</tr>
</table>
<%

String dqczy=(String)session.getAttribute("czyid");
String id = getStr( request.getParameter("id") );
System.out.println("##############id="+id);
ResultSet rs;
String wherestr = " where 1=1";

//String sqlstr="select *, (vi_mproj_info_cs.ensure_payment+vi_mproj_info_cs.deposit_amount-vi_mproj_info_cs.deposit_export) as leiji,dengjiren=dbo.GETUSERNAME(vi_mproj_info_cs.creator),xiugairen=dbo.GETUSERNAME(vi_mproj_info_cs.modificator)  from vi_mproj_info_cs left join contract_manuf on contract_manuf.id=vi_mproj_info_cs.uid  where 1=1 and uid='"+id+"' ";
String sqlstr="select *,(ensure_payment+deposit_amount-deposit_export) as leiji,dengjiren=dbo.GETUSERNAME(mproj_company.creator),xiugairen=dbo.GETUSERNAME(mproj_company.modificator) from mproj_company where 1=1 and uid='"+id+"'";

	
System.out.println("&*"+sqlstr);
%>
	
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<table border="0" cellspacing="0" cellpadding="0" >    
   <tr class="maintab">
				<%if(right.CheckRight("csbzj_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','csbzj_add.jsp?uid=<%=id%>',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td><%}%><input name="id" type="hidden" value="<%= id %>">
				<%if(right.CheckRight("csbzj_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','csbzj_mod.jsp?bid=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td><%}%>
				
		    </tr>
</table>
</td>
<td align="right" width="90%">
<%
int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
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
   rs=db.executeQuery(sqlstr); 
   

	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();

	rs.beforeFirst();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //������ҳ��
	if(intPage>intPageCount) intPage = intPageCount;            //��������ʾ��ҳ��
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);   
         //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0; %>

<input type="hidden" name="id" value="<%=id%>">
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

<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;height:500px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		 <th>���</th>
		
	    <th>�Ӻ�ͬ���</th>
	    <th>��֤�����</th>
	    <th>�����豸���</th>	
	  	<th>��ͱ�֤���</th>

		<th>��֤���ۼƽ��</th>
        <th>��֤�������</th>
		<th>��֤�����ʱ��</th>
		<th>��֤�����ԭ��</th>
		 <th>��֤�������</th>
		<th>��֤����ʱ��</th>
		<th>��֤����ԭ��</th>

		<th>������</th>
		<th>����ʱ��</th>
		<th>�޸���</th>
		<th>�޸�ʱ��</th>
      </tr>
<%
	
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){

%>
	  
      <tr class="cwDLRow" >
         <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("bid") )%>"></td>
       <td align="center"><a href="csbzj.jsp?bid=<%=getDBStr( rs.getString("bid") )  %>" target="_blank"><%=getDBStr( rs.getString("bid") )  %></a></td>
   
       <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
       
		<td><%=getDBStr(rs.getString("margin_per"))%>%</td>
		
		<td><%=formatNumberStr(rs.getString("vendor_payment"),"#,##0.00")%></td>
		<td><%=getDBStr(rs.getString("min_payment"))%></td>

		<td><%=getDBStr(rs.getString("leiji"))%></td>
		<td><%=getDBStr(rs.getString("deposit_amount"))%></td>
		<td><%=getDBDateStr(rs.getString("margin_time"))%></td>
		<td><%=getDBStr(rs.getString("margin_reason"))%></td>
		<td><%=getDBStr(rs.getString("deposit_export"))%></td>
		<td><%=getDBDateStr(rs.getString("export_time"))%></td>
        <td><%=getDBStr(rs.getString("export_reason"))%></td>

        <td align="center"><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("xiugairen") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td>
		
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


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->


</form>
<!-- end cwMain -->
</body>
</html>
