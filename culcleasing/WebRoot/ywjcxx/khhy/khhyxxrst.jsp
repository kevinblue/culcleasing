<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>


<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ҵ��Ϣ��ѯͳ�� - ��ҵ��Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>

<body>
<%
String sqlstr="";
String expsqlstr="";
String rsttitle="";
ResultSet rs;

String wherestr=" where (1=1)";



%>



<div id="cwMain" >



<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">��ҵ��Ϣ��ѯ</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">

<%

String hybh=getStr(request.getParameter("hybh"));
if ((hybh==null) || (hybh.equals("")))
{

}
else
{
    wherestr = wherestr+" and (hymlbh='"+hybh+"' or hydlbh='"+hybh+"' or hyzlbh='"+hybh+"' or hyxlbh='"+hybh+"') "; 
}

String hyml=getStr(request.getParameter("hyml"));
if ((hyml==null) || (hyml.equals("")))
{

}
else
{
    wherestr = wherestr+" and (hymlbh='"+hyml+"') "; 
}

String hydl=getStr(request.getParameter("hydl"));
if ((hydl==null) || (hydl.equals("")))
{

}
else
{
    wherestr = wherestr+" and (hydlmc like '%"+hydl+"%') "; 
}

String hyzl=getStr(request.getParameter("hyzl"));
if ((hyzl==null) || (hyzl.equals("")))
{

}
else
{
    wherestr = wherestr+" and (hyzlmc like '%"+hyzl+"%') "; 
}

String hyxl=getStr(request.getParameter("hyxl"));
if ((hyxl==null) || (hyxl.equals("")))
{

}
else
{
    wherestr = wherestr+" and (hyxlmc like '%"+hyxl+"%') "; 
}

sqlstr = "SELECT hyxlbh as ��ҵС����,hymlmc as ��ҵ��������,hydlmc as ��ҵ��������,hyzlmc as ��ҵ��������,hyxlmc as ��ҵС������ FROM v_hyxx_all "+wherestr+" order by hyxlbh "; 
expsqlstr = "SELECT hyxlbh as ��ҵС����,hymlmc as ��ҵ��������,hydlmc as ��ҵ��������,hyzlmc as ��ҵ��������,hyxlmc as ��ҵС������ FROM v_hyxx_all "+wherestr+" order by hyxlbh "; 
//out.print(hyml);
//out.print(hydl);
//out.print(hyzl);
//out.print(hyxl);
//out.print(sqlstr);
rs=db.executeQuery(sqlstr); 
ResultSetMetaData rsmd = rs.getMetaData();
int numberOfColumns = rsmd.getColumnCount();
%>



<div id="cwCellTop">

<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">��ҵ��Ϣ</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
	<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td></td>
        <form name="expform" action="../../func/exp.jsp" target="_blank" method="post">
          <td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>"><input name="expsubmit" type="submit" value="������EXCEL" style=" border:none;background-image:url(../../images/expExcel.gif); padding:2px 0px 0px 20px; height:20px; width:110px ">
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
	 intPageSize = 15;
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

   <table class="cwDataList"  border="0"  align="center" cellpadding="2" cellspacing="1" width="90%" >
      <tr class="cwDLHead">
      <%
      for (int j=1; j<=numberOfColumns; j++)
      {
     //dd=rsmd.getColumnLabel(j)+rsmd.getColumnName(j)+rsmd.getSchemaName(j)+rsmd.getColumnType(j)+rsmd.getColumnTypeName(j);
     //dd=rsmd.getColumnName(j+rsmd.getColumnTypeName(j);
          rsttitle=rsmd.getColumnName(j);
      %>
          <th><%=rsttitle%></th>
     <%
      }
     %>
     </tr>





<%
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
        String yxflag;
	while(i<intPageSize && !rs.isAfterLast())
        {
%>
     <tr class="cwDLRow" >
     <%
     for (int k=1; k<=numberOfColumns; k++)
     {
     %>
            <td><%=getDBStr(rs.getString(k))%></td>
     <% 
     }
     %>
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

	






<div id="cwDataNav" >

<form name="dataNav" action="khhyxxrst.jsp" method="post">
<input name="hybh" type="hidden" value="<%=hybh%>">
<input name="hyml" type="hidden" value="<%=hyml%>">
<input name="hydl" type="hidden" value="<%=hydl%>">
<input name="hyzl" type="hidden" value="<%=hyzl%>">
<input name="hyxl" type="hidden" value="<%=hyxl%>">
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
    <td>ת��<input name="page" type="text" onChange="this.value=this.value.replace(/\D/g,'')" onKeyPress="if(event.keyCode == 13){this.blur();goPage('jump');}" size="2">ҳ<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" width="19" height="19" border="0" align="absmiddle"></td>
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





<div id="cwToolbar">
<input class="btn" name="btnClose" value="�ر�" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->
	 
</div>
<!-- end cwMain -->
</body>
</html>
