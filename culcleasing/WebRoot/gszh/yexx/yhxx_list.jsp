<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ÿ��������֧һ�� - �ʽ���Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >�ʽ���Ϣ����</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%

String sqlstr;
String expsqlstr;
ResultSet rs;
String czy=(String) session.getAttribute("czyid");//ȡ�ò���ԱID
if ((czy==null) || (czy.equals(""))) czy="0";
//czy="AFEE-6A6CWE";//�ʽ�������Żݻ�
//czy="AFEE-6A6CW5";//����ҵ�񲿹�����
sqlstr="select bmbh from jb_gsbm where bmmc=(select bmmc from v_yhxx where id='"+czy+"')";
String bmid="";//����id
rs=db.executeQuery(sqlstr);
if (rs.next()) bmid=rs.getString("bmbh");
if ((bmid==null) || (bmid.equals(""))) bmid="0";

BigDecimal bz1=new BigDecimal("0.00");
BigDecimal bz2=new BigDecimal("0.00");
BigDecimal bz3=new BigDecimal("0.00");
BigDecimal bz4=new BigDecimal("0.00");
BigDecimal bz5=new BigDecimal("0.00");
BigDecimal bz11=new BigDecimal("0.00");
BigDecimal bz21=new BigDecimal("0.00");
BigDecimal bz31=new BigDecimal("0.00");
BigDecimal bz41=new BigDecimal("0.00");
BigDecimal bz51=new BigDecimal("0.00");

%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">ÿ��������֧һ��</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

<%


String sDate=getSystemDate(0); 
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf1.parse(sDate);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String sResult = sdf2.format(date);


String wherestr="";
String searchKeyjlrq1="";//��¼����1
 wherestr=" where (1=1)";

String rqstr1=request.getParameter("searchKeyjlrq1");

if ((rqstr1==null))
{	searchKeyjlrq1=sResult;
	rqstr1=sResult;
}
   searchKeyjlrq1=rqstr1;
if ((searchKeyjlrq1==null) || (searchKeyjlrq1.equals("")))
{
}
else
{
    wherestr = wherestr+" and (drrq='"+searchKeyjlrq1+"') "; 
}

expsqlstr="select yhmc ��������,drrq ��������,qcyebb �ڳ���������,qcyewb �ڳ�������,kyed ���ö�� from v_zhmx1"+wherestr+" order by drrq";
 
%>

<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
   <form name="expform" action="../../func/exp.jsp" target="_blank" method="post">
          <td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>"><input name="expsubmit" type="submit" value="������EXCEL" style=" border:none;background-image:url(../../images/expExcel.gif); padding:2px 0px 0px 20px; height:20px; width:110px ">
          </td>
        </form>
		
<%
//out.print(bmid);

if (bmid.equals("12"))//Ȩ�޿��ư�ť
{
%>
	
<%
}
%>
        <form name="searchbar" action="yhxx_list.jsp">
        	<td nowrap>����<input name="searchKeyjlrq1" accesskey="r" type="text" size="9" value="<%=rqstr1%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			 <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
       
        </form>
		
      </tr>
</table>


</div>
<!-- end cwCellTop -->
<% 
int intPageSize;   //һҳ��ʾ�ļ�¼��
int intRowCount=0;   //��¼����
int intPageCount;  //��ҳ��
int intPage;       //����ʾҳ��
int i;
java.lang.String strPage;

     //����һҳ��ʾ�ļ�¼��
	 intPageSize = 50;
	 intPageCount=1;
	 //ȡ�ô���ʾҳ��
	 strPage = request.getParameter("page");
	 if(strPage==null || strPage=="")
	 {//������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	     intPage = 1;
	 }
	 else
	 {//���ַ���ת��������
	      intPage = java.lang.Integer.parseInt(strPage);
		  if(intPage<1) intPage = 1;
	 } 
%>



<div id="cwCellContent">

    <form name="list">

    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	   
	    <th>��������</th>
		<th>����</th>
	    <th>���ö��</th>
	    <th>�ڳ���������</th>
	 	<th>�ڳ�������</th>
		 
<%

sqlstr = "select * from v_zhmx1"+wherestr;

//out.print(sqlstr);
//out.print(orderstr);
rs=db.executeQuery(sqlstr);

if (rs.next())
  {
     
	//��ȡ��¼����
	rs.last();
	intRowCount = rs.getRow();
	
	//������ҳ��
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;
	
	//��������ʾ��ҳ��
	if(intPage>intPageCount) intPage = intPageCount;
	
	if(intPageCount>0)
	//����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	   rs.absolute((intPage-1) * intPageSize + 1);
	
	//��ʾ����
	i=0;
		while(i<intPageSize && !rs.isAfterLast())
        {
%>
	  
      <tr class="cwDLRow" >
        
        <td align="center"><%=getDBStr(rs.getString("yhmc"))%></td>
        <td align="center"><%=getDBDateStr(rs.getString("drrq"))%></td>
		<td align="center"><%=getDBStr(rs.getString("kyed"))%></td>
		<td align="center"><%=getDBStr(rs.getString("qcyebb"))%></td>
		<td align="center"><%=getDBStr(rs.getString("qcyewb"))%></td>
	
		
<%
  //    total=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
  //    total1=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
%>
	  
<%
    //       bz1=(BigDecimal)getDBDecStr(rs.getBigDecimal("qcyebb",2));
  //      bz11=bz11.add(bz1);
//		bz2=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
     //   bz21=bz21.add(bz2);
	//	  bz3=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
      //  bz31=bz31.add(bz3);
		//  bz4=(BigDecimal)getDBDecStr(total);
      //  bz41=bz31.subtract(bz21);
	//	bz5=(BigDecimal)getDBDecStr(rs.getBigDecimal("dryebb",2));
  //      bz51=bz51.add(bz5);
%>
     		
     


      </tr>
	
	 <script>btnAdd.style.display="none"</script>  

<%
       rs.next();
       i++;
	}
  }
rs.close(); 
db.close();
%>

    </table>
</form>


<div id="cwDataNav">
<form action="yhxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKeyjlrq1" type="hidden" value="<%=searchKeyjlrq1%>">

<table border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td>
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
	<%if(intPage>1){%>	<img style="cursor:pointer; " onClick="goPage('first')" src="../../images/quick_back.gif" alt="��һҳ" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('prev')" src="../../images/back.gif" alt="��һҳ" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/quick_back.gif" alt="���ҳ" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/back.gif" alt="���ҳ" width="19" height="19" border="0"><% } %>
	<%if(intPage<intPageCount){%> <img style="cursor:pointer; " onClick="goPage('next')" src="../../images/forward.gif" alt="��һҳ" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('last')" src="../../images/quick_forward.gif" alt="���ҳ" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/forward.gif" alt="���ҳ" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/quick_forward.gif" alt="���ҳ" width="19" height="19" border="0"><% } %></td>
    <td>��<%=intRowCount%>�� ��<%=intPage%>ҳ/��<%=intPageCount%>ҳ </td>
    <td><img src="../../images/sbtn_split.gif"></td>
    <td>ת��<input name="page" type="text" size="2">ҳ<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" width="19" height="19" border="0" align="absmiddle"></td>
<!--     <td><img src="../../images/sbtn_split.gif"></td>
    <td>ÿҳ<input type="text" size="2">��<a href="#"><img src="../../images/ok.gif" alt="ȷ��" width="19" height="19" border="0" align="absmiddle"></a></td>
 -->  </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->






<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>