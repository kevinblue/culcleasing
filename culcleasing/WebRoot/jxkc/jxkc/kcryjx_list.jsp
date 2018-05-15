<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("inspecter-jxkc-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ҵ��ϵͳ - ������Ա��Ч</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0)">
<form action="kcryjx_list.jsp" name="dataNav" onSubmit="return goPage()">

<%
String cust_id = getStr( request.getParameter("cust_id") );
ResultSet rs;
String wherestr = " where 1=1";

if ( !cust_id.equals("") ){
	wherestr = wherestr + " and cust_id='" + cust_id + "'";
}
String sqlstr = "select inspecter,inspectCount=count(inspect_id),"+
				"marks5=count(case when inspect_marks=5 then inspect_marks end),"+
				"marks4_5=count(case when inspect_marks=4.5 then inspect_marks end),"+
				"marks4=count(case when inspect_marks=4 then inspect_marks end),"+
				"marks3_5=count(case when inspect_marks=3.5 then inspect_marks end),"+
				"marks3=count(case when inspect_marks=3 then inspect_marks end),"+
				"marks2_5=count(case when inspect_marks=2.5 then inspect_marks end),"+
				"marks2=count(case when inspect_marks=2 then inspect_marks end),"+
				"marks1_5=count(case when inspect_marks=1.5 then inspect_marks end),"+
				"marks1=count(case when inspect_marks=1 then inspect_marks end),"+
				"marksAvg=sum(inspect_marks)/count(inspect_id),"+
				"bhgCount=count(case when cast(cast(inspect_endtime as datetime)-cast(inspect_begintime as datetime) as int)>3 then inspect_id end),"+
				"tskcs=count(case when special_inspect=1 then special_inspect end)"+
				"from inspect_info "+ wherestr+
				" group by inspecter ";

%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td nowrap class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				ҵ��ϵͳ &gt; ������Ա��Ч</td>
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
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //������ҳ��
	if(intPage>intPageCount) intPage = intPageCount;            //��������ʾ��ҳ��
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0; %>

<input type="hidden" name="cust_id" value="<%=cust_id%>">
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
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		 <th>����Ա</td>
		 <th>������Ŀ����</th>
		 <th>5��</th>
		 <th>4.5��</th>
		 <th>4��</th>
		 <th>3.5��</th>
		 <th>3��</th>
		 <th>2.5��</th>
		 <th>2��</th>
		 <th>1.5��</th>
		 <th>1��</th>
		 <th>ƽ������÷�</th>
		 <th>��������</th>
		 <th>���ϸ񿼲���</th>
		 <th>�ϸ�ٷֱ�</th>
		 <th>ʱЧ����</th>
		 <th>���켨Ч</th>
		 <th>���⿼������</th>
		 <th>���⿼�켨Ч</th>
		 <th>�ܼ�Ч</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
		double kczl=0;		//��������
		int xmzs=0;			//��Ŀ����
		double marksAvg=0;	//ƽ�������
		int bhgCount=0;	//���ϸ������
		double hgbl=0;		//�ϸ����
		double timing=0;	//ʱЧ����
		double kcyj=0;		//����ҵ��
		int tskcs=0;		//���⿼����
		xmzs=rs.getInt("inspectCount");
		marksAvg=rs.getDouble("marksAvg");
		bhgCount=rs.getInt("bhgCount");
		
		tskcs=rs.getInt("tskcs");
		
		if(marksAvg<2){
			kczl=-0.5;
		}else if(marksAvg>=2 && marksAvg<3){
			kczl=0;
		}else if(marksAvg>=2 && marksAvg<3){
			kczl=0;
		}else if(marksAvg>=3 && marksAvg<3.5){
			kczl=0.5;
		}else if(marksAvg>=3.5 && marksAvg<4){
			kczl=1;
		}else if(marksAvg>=4){
			kczl=1.5;
		}
		
		hgbl=(1-((double)bhgCount/xmzs))*100;
		
		if(hgbl<70){
			timing=-0.5;
		}else if(hgbl>=70 && hgbl<80){
			timing=0;
		}else if(hgbl>=80 && hgbl<90){
			timing=0.5;
		}else if(hgbl>=90 && hgbl<100){
			timing=1;
		}else if(hgbl==100){
			timing=1.5;
		}
		kcyj=20*xmzs*(kczl+timing+1);
%>
	  
      <tr class="cwDLRow" >
		<td align="center"><%=getDBStr( rs.getString("inspecter") ) %></td>
		<td align="center"><%=xmzs %></td>
		<td align="center"><%=getDBStr( rs.getString("marks5") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks4_5") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks4") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks3_5") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks3") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks2_5") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks2") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks1_5") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("marks1") ) %></td>
		<td align="center"><%=formatNumberDoubleTwo( rs.getString("marksAvg") ) %></td>
		<td align="center"><%=kczl %></td>
		<td align="center"><%=bhgCount %></td>
		<td align="center"><%=formatNumberDoubleTwo(hgbl) %> %</td>
		<td align="center"><%=timing %></td>
		<td align="center"><%=kcyj %></td>
		<td align="center"><%=tskcs %></td>
		<td align="center"><%=tskcs*20 %></td>
		<td align="center"><%=kcyj+tskcs*20 %></td>
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
