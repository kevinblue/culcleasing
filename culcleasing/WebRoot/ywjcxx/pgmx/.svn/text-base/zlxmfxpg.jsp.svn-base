<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租赁项目风险评估 - 项目信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script language="javascript">
function czrfxpfjs(i)
{ 
  var pos=5;
  var pow = Math.pow(10, pos);
  document.getElementById("czrfxjqdf"+i).value=Math.round(document.getElementById("czrfxpf"+i).value*document.getElementById("czrfxqz"+i).value/100*pow)/pow;
  var count=document.getElementById("zlrxfdhjdf").count;
  var hjdftemp=0;
  for(j=1;j<count;j++)
  {
     hjdftemp=document.getElementById("czrfxjqdf"+j).value*1+hjdftemp;
  }
  document.getElementById("zlrxfdhjdf").value=forcepos(hjdftemp,pos);
  document.getElementById("czrfxxs").value=forcepos(Math.round((100-hjdftemp)/100*pow)/pow,pos);
  document.getElementById("czrfxd").value=forcepos(document.getElementById("czrfxxs").value*100,pos);
}
  
function zlwfxpfjs(i)
{ 
  var pos=7;
  var pow = Math.pow(10, pos);
  var zlwkfxzstemp=0; 

  if ((i==1) || (i==2))
  {
     zlwkfxzstemp=Math.round(document.getElementById("zlwfxcsjg1").value*document.getElementById("zlwfxcsjg2").value*pow)/pow;
     document.getElementById("zlwkfxzs").value=forcepos(zlwkfxzstemp,pos);
     if (document.getElementById("zlwkfxzs").value*1>1.2)
     {
         document.getElementById("zlwfxcsjg3").value=0;
     }
     if (document.getElementById("zlwkfxzs").value*1==0) 
     { 
         document.getElementById("zlwfxcsjg3").value=1;
     }
     if ((document.getElementById("zlwkfxzs").value*1>0) && (document.getElementById("zlwkfxzs").value*1<=1.2)) 
     {
         document.getElementById("zlwfxcsjg3").value=Math.round((1.2-document.getElementById("zlwkfxzs").value)/1.2*pow)/pow;
     }
  }
  if (i==3)
  {
     document.getElementById("zlwfxd").value=forcepos(document.getElementById("zlwfxcsjg3").value*100,pos);
  }
}
</script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >项目信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
int canoperate=1;
String sqlstr;
String sqlstr2;
String sqlstr3;
ResultSet rs=null;
ResultSet rs2=null;
ResultSet rs3=null;
int i=0;
String project_name="";
String cust_name="";
String proj_id=getStr(request.getParameter("proj_id"));
if ((proj_id==null) || (proj_id.equals("")))
{
	canoperate=0;
}
else
{
	sqlstr = "SELECT proj_info.project_name, cust_info.cust_name FROM cust_info RIGHT OUTER JOIN proj_info ON cust_info.cust_id = proj_info.cust_id ";
	sqlstr+= "where proj_id='"+proj_id+"'"; 
	rs=db.executeQuery(sqlstr);
        if (rs.next())
	{
		project_name=getDBStr(rs.getString("project_name"));
		cust_name=getDBStr(rs.getString("cust_name"));
	}
        else
	{
		canoperate=0;
	}
}
%>
<script>
if (<%=canoperate%>==0){
	//window.close();
	//opener.alert("无该项目,或您无操作权限！");
}
</script>

<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">租赁项目风险评估</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>

		<td></td>


      </tr>
</table>


</div>
<!-- end cwCellTop -->


<div id="cwCellContent">

    <form name="list">
<center>承租人风险度评估</center>
    <table class="cwDataList" width="90%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	<th colspan="7" align="left">租赁项目名称：<%=project_name%></th>
      </tr>
      <tr class="cwDLHead">
	<th colspan="7" align="left">承租人名称：<%=cust_name%></th>
      </tr>
      <tr class="cwDLHead">
	<th>评价要素</th>
	<th>计算口径</th>
	<th width=40%>评分指导区间</th>
        <th>评分</th>
        <th>单项权重</th>
        <th>加权得分</th>
        <th>修正</th>
      </tr>
	  
<%
i=1; 
sqlstr = "SELECT * FROM jb_pgmx_pglxxl where pglxid=1 and his=0 order by xh asc"; 
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	while(!rs.isAfterLast())
        {
		if (!getDBStr(rs.getString("pglxxlmc")).trim().equals("*"))
                {
%>
      <tr class="cwDLHead">
	<th colspan="7" align="center"><%=getDBStr(rs.getString("pglxxlmc"))%></th>
      </tr>
<%
		}
		sqlstr2 = "SELECT * FROM jb_pgmx_tmxx where pglxxlid="+getDBStr(rs.getString("id"))+" and his=0 order by xh asc"; 
		rs2=db2.executeQuery(sqlstr2); 

		if (rs2.next())
		{
     			while(!rs2.isAfterLast())
			{
%>
	  
      <tr class="cwDLRow" >
        <td align="center"><%=getDBStr(rs2.getString("pjys"))%></td>
        <td align="center"><%=getDBStr(rs2.getString("jskj"))%>&nbsp;</td>
        <td align="left">
             <table border="0"  width=100% align="center" cellpadding="0" cellspacing="0">
<%
				sqlstr3 = "SELECT * FROM jb_pgmx_tmpfbz where tmid="+getDBStr(rs2.getString("id"))+" and his=0 order by xh asc"; 
				rs3=db3.executeQuery(sqlstr3); 
				if (rs3.next())
				{
					while(!rs3.isAfterLast())
        				{
%>
                  <tr style="font-size:0.75em" align="left"><td align="left"><%=getDBStr(rs3.getString("pfyj"))%>&nbsp&nbsp</td><td align="left"><%=getDBStr(rs3.getString("fz"))%></td></tr>
<%
						rs3.next();
					}
				}
%>
                  <tr style="font-size:0.75em"><td colspan=4 align="left"><%=getDBStr(rs2.getString("pfsm"))%></td></tr>
             </table>
        </td>
        <td align="center"><input name="czrfxpf<%=i%>" type="text" size="10" maxlength="20" dataType="Double" onPropertyChange="czrfxpfjs(<%=i%>);"></td>
        <td align="center"><input name="czrfxqz<%=i%>" type="text" size="10" readonly value="<%=getDBStr(rs2.getString("qz"))%>"></td>
        <td align="center"><input name="czrfxjqdf<%=i%>" type="text" size="10" maxlength="20" dataType="Double" readonly></td>
        <td align="center"><input name="czrfxxz<%=i%>" type="text" size="10" maxlength="20" dataType="Double"></td>
      </tr>
<%
				i+=1;
				rs2.next();
			}
		}
		rs.next();
	}
}

%>
      <tr class="cwDLHead">
	<th align="left">合计得分：</th>
	<th align="left" colspan="4">（满分100分）</th>
	<td colspan="2" align="right"><input name="zlrxfdhjdf" type="text" count=<%=i%> size="20" maxlength="20" dataType="Double"></td>
      </tr>
      <tr class="cwDLHead">
	<th align="left" colspan="5">承租人风险系数 = （ 100 — 合计得分）/ 100  </th>
	<td colspan="2" align="right"><input name="czrfxxs" type="text" size="20" maxlength="20" dataType="Double"></td>
      </tr>
      <tr class="cwDLHead">
	<th align="left" colspan="5">承租人风险度 = 承租人风险系数 * 100%   </th>
	<td colspan="2" align="right"><input name="czrfxd" type="text" size="20" maxlength="20" dataType="Double"></td>
      </tr>
    </table>
<p>
<center>租赁物风险度评估</center>
<p>
    <table class="cwDataList" width="90%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	<th colspan="7" align="left">租赁项目名称：<%=project_name%></th>
      </tr>
      <tr class="cwDLHead">
	<th colspan="7" align="left">承租物名称：<input type="text" name="lease_prod" size=50></th>
      </tr>
      <tr class="cwDLHead">
	<th>评价要素</th>
	<th>计算口径</th>
	<th width=40%>评分指导区间</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
        <th>测算结果</th>
        <th>修正</th>
      </tr>
<%
i=1; 
sqlstr = "SELECT * FROM jb_pgmx_pglxxl where pglxid=2 and his=0 order by xh asc"; 
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	while(!rs.isAfterLast())
        {
		if (!getDBStr(rs.getString("pglxxlmc")).trim().equals("*"))
                {
%>
      <tr class="cwDLHead">
	<th colspan="7" align="center"><%=getDBStr(rs.getString("pglxxlmc"))%></th>
      </tr>
<%
		}
		sqlstr2 = "SELECT * FROM jb_pgmx_tmxx where pglxxlid="+getDBStr(rs.getString("id"))+" and his=0 order by xh asc"; 
		rs2=db2.executeQuery(sqlstr2); 

		if (rs2.next())
		{
     			while(!rs2.isAfterLast())
			{
%>
	  
      <tr class="cwDLRow" >
        <td align="center"><%=getDBStr(rs2.getString("pjys"))%></td>
        <td align="center"><%=getDBStr(rs2.getString("jskj"))%>&nbsp;</td>
        <td align="left">
             <table border="0"  width=100% align="center" cellpadding="0" cellspacing="0">
<%
				sqlstr3 = "SELECT * FROM jb_pgmx_tmpfbz where tmid="+getDBStr(rs2.getString("id"))+" and his=0 order by xh asc"; 
				rs3=db3.executeQuery(sqlstr3); 
				if (rs3.next())
				{
					while(!rs3.isAfterLast())
        				{
%>
                  <tr style="font-size:0.75em" align="left"><td align="left"><%=getDBStr(rs3.getString("pfyj"))%>&nbsp&nbsp</td><td align="left"><%=getDBStr(rs3.getString("fz"))%></td></tr>
<%
						rs3.next();
					}
				}
%>
                  <tr style="font-size:0.75em"><td colspan=4 align="left"><%=getDBStr(rs2.getString("pfsm"))%></td></tr>
             </table>
        </td>
        <td align="center">&nbsp;</td>
        <td align="center">&nbsp;</td>
        <td align="center"><input name="zlwfxcsjg<%=i%>" type="text" size="10" maxlength="20" dataType="Double" onPropertyChange="zlwfxpfjs(<%=i%>);"></td>
        <td align="center"><input name="zlwfxxz<%=i%>" type="text" size="10" maxlength="20" dataType="Double"></td>
      </tr>
<%
                                if (i==2)
                                {
%>
      <tr class="cwDLRow" >
        <td align="left" colspan="5">租赁物抗风险指数 = 租赁物价值指数 *租赁物变现指数</td>
	<td colspan="2" align="right"><input name="zlwkfxzs" type="text" readonly size="20" maxlength="20" dataType="Double"></td>
      </tr>
<%
                                }
				i+=1;
				rs2.next();
			}
		}
		rs.next();
	}
}

%>
      <tr class="cwDLRow" >
        <td align="left" colspan="5">承租物风险度 = 承租物风险系数 * 100% </td>
	<td colspan="2" align="right"><input name="zlwfxd" type="text" readonly size="20" maxlength="20" dataType="Double"></td>
      </tr>

    </table>

</form>

<div id="cwDataNav" >

</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->


<%
rs.close(); 
rs2.close(); 
rs3.close(); 
db.close();
db2.close();
db3.close();
%>


<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
