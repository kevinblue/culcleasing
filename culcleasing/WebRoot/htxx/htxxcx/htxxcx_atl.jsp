<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ���ʵ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);" style="border:1px solid #8DB2E3;">
<form action="htzjss_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��ͬ��Ϣ &gt; ��ͬ���ʵ��</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%


ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchFld_tmp = "";

String contract_id = getStr( request.getParameter("contract_id") );
if(contract_id.equals("")){
	wherestr=" where 1=0";
}else{
	wherestr+=" and fund_rent_income.contract_id='"+contract_id+"'";
}

String sqlstr = "select fund_rent_income.contract_id,fund_rent_income.plan_list,fund_rent_income.hire_date,fund_rent_income.rent,fund_rent_income.corpus,fund_rent_income.interest,fund_rent_income.penalty,fund_rent_income.penalty_adjust from fund_rent_income " + wherestr; 
sqlstr+=" order by fund_rent_income.plan_list";
//System.out.println("sqlstr=================="+sqlstr);
%>



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
	</tr>
</table>
<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 1000;   //һҳ��ʾ�ļ�¼��
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




</td>
</tr>
</table>

<!--��ҳ���ƽ���-->


<!--����ʼ-->

<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>��ͬ���</th>
		<th>����</th>
		<th>ʵ������</th>
        <th>�������</th>
        <th>���ձ���</th>
        <th>������Ϣ</th>
        <th>���շ�Ϣ</th>
        <th>��Ϣ����</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	double allrent = 0;
	double allcorpus = 0;
	double allinterest = 0;
	double allpenalty = 0;
	double allacutalpenalty = 0;
	while( i < intPageSize && !rs.isAfterLast() ) {
	
	String return_rent = getDBStr( rs.getString("rent") );
	if(!return_rent.equals("")){
		allrent +=Double.parseDouble(return_rent);
	}
	String return_corpus = getDBStr( rs.getString("corpus") );
	if(!return_corpus.equals("")){
		allcorpus+=Double.parseDouble(return_corpus);
	}
	
	String return_interest = getDBStr(rs.getString("interest"));
	if(!return_interest.equals("")){
		allinterest+=Double.parseDouble(return_interest);
	}
	String penalty = getDBStr(rs.getString("penalty"));
	if(!penalty.equals("")){
		allpenalty+=Double.parseDouble(penalty);
	}
	String acutal_penalty = getDBStr(rs.getString("penalty_adjust"));
	if(!acutal_penalty.equals("")){
		allacutalpenalty+=Double.parseDouble(acutal_penalty);
	}
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") )  %></td> 
		<td><%= getDBStr( rs.getString("plan_list") ) %></td> 
		<td><%= getDBDateStr( rs.getString("hire_date") ) %></td> 	 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00") %></td> 	 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("penalty") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("penalty_adjust") ),"#,##0.00") %></td>
      </tr>
<%
		rs.next();
		i++;
	}
	%>
	<tr>
		<td></td> 
		<td></td> 
		<td></td> 
		<td  align="right"><%= formatNumberDoubleTwo(allrent) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allcorpus) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allinterest) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allpenalty) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allacutalpenalty) %></td> 
	</tr>
	<%
}
rs.close(); 
db.close();
%>
    </table>
</div>

<!--�������-->
</form>
</body>
</html>
