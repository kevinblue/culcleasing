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
<title>ÿ���ֽ����� - �ʽ���Ϣ����</title>
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
String czzh=getStr(request.getParameter("czzh"));
String czzhmc=getStr(request.getParameter("czzhmc"));
String czid=getStr(request.getParameter("czid"));
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
%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">ÿ���ֽ�����</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

<%

String sDate=getSystemDate(0); 
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf1.parse(sDate);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String sResult = sdf2.format(date);

BigDecimal total=new BigDecimal("0.00");
BigDecimal total1=new BigDecimal("0.00");
String wherestr="";
String searchKeyjlrq1="";//��¼����1
String searchKeyjlrq2="";//��¼����2

String rqstr1=request.getParameter("searchKeyjlrq1");
String rqstr2=request.getParameter("searchKeyjlrq2");
if ((rqstr1==null) && (rqstr2==null))
{	searchKeyjlrq1=sResult;
	rqstr1=sResult;
}


if (request.getParameter("czzh")!=null && request.getParameter("czzh").equals("")==false)
    wherestr=" where (zh='"+czzh+"') and (qcyewb IS NOT NULL OR dryewb IS NOT NULL)";
else
   {wherestr=" where (1=1) and (qcyewb IS NOT NULL OR dryewb IS NOT NULL)";}
 
   searchKeyjlrq1=rqstr1;
if ((searchKeyjlrq1==null) || (searchKeyjlrq1.equals("")))
{
}
else
{
    wherestr = wherestr+" and (drrq>='"+searchKeyjlrq1+"') "; 
}
searchKeyjlrq2=getStr(request.getParameter("searchKeyjlrq2"));
if ((searchKeyjlrq2==null) || (searchKeyjlrq2.equals("")))
{

}
else
{
    wherestr = wherestr+" and (drrq<='"+searchKeyjlrq2+" 23:59:59') "; 
}
 
expsqlstr="select zh �˺�,zhmc �˻�����,drrq ��������,qcyewb �ڳ�������,dtsr ��������,dtzc ����֧��,dryewb ���������� from v_zh_xjye"+wherestr+" order by drrq";
 
%>

<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
	   <td align="center">�˺ţ�<%=czzh%> �˻����ƣ�<%=czzhmc%></td>
   
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
        <form name="searchbar" action="yewb_list.jsp">
         
        	<td nowrap>����1<input name="searchKeyjlrq1" accesskey="r" type="text" size="9" value="<%=rqstr1%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
����2<input name="searchKeyjlrq2" accesskey="q" type="text" size="9" value="<%=searchKeyjlrq2%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
            <input name="czzhmc" type="hidden" value="<%=czzhmc%>">
              <input name="czzh"  type="hidden" value="<%=czzh%>">	

			 <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
        </td>
        
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
	    <th width="1%"></th>
	    <th>��������</th>
	    <th>�ڳ�������</th>
	 	  <th>��������</th>
		  <th>����֧��</th>
		  <th>���վ���仯</th>
		  <th>����������</th>
		  
<%

sqlstr = "select * from v_zh_xjye"+wherestr;

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
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
		<td><a href="yemx_report.jsp?zh=<%=getDBStr(rs.getString("zh"))%>&zhmc=<%=getDBStr(rs.getString("zhmc"))%>" target="_blank"><%=getDBDateStr(rs.getString("drrq"))%></a></td>
		<td align="center"><%=getDBStr(rs.getString("qcyewb"))%></td>
		<td align="center"><%=getDBStr(rs.getString("dtsr"))%></td>
		<td align="center"><%=getDBStr(rs.getString("dtzc"))%></td>
		<%  
      total=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
      total1=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
%>
	   <td align="center"><%=getDBDecStr(total.subtract(total1))%></td>
		<td align="center"><%=getDBStr(rs.getString("dryewb"))%></td>
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
<form action="yewb_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKeyjlrq1" type="hidden" value="<%=searchKeyjlrq1%>">
<input name="searchKeyjlrq2" type="hidden" value="<%=searchKeyjlrq2%>">
<input name="czzhmc" type="hidden" value="<%=czzhmc%>">
<input name="czzh"  type="hidden" value="<%=czzh%>">
<input name="czid" type="hidden" value="<%=czid%>">
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