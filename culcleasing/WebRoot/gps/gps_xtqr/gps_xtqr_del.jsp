<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS��ϵͳǰȷ�� - GPS����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-xtqr-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<body>


<form name="form1" method="post" action="gps_xtqr_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
GPS���� &gt;  GPS��ϵͳǰȷ��
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">ɾ��</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">ɾ ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<%
    String id = getStr( request.getParameter("id") );
	String sqlstr = "select * from vi_gps_sure where id='" + id + "'"; //SQL��ѯ���
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String machine_no="";
	String machine_type="";
	String sim_no="";
	String install_date="";
	String service_begindate="";
	String service_enddate="";
	String gpsinfo_id="";
	String yes_date="";
	String fixed_state="";
	String sfmc="";
	String csmc="";
	String address="";
	String memo="";
	String gps_index_type="";
	String cust_name="";//�ͻ���
	String expect_start_date="";//��������
	String term="";//����
	
	if ( rs.next() ) {
		cust_name=getDBStr( rs.getString("cust_name") );
		machine_no=getDBStr( rs.getString("machine_no") );
		machine_type=getDBStr( rs.getString("machine_type") );
		sim_no=getDBStr( rs.getString("sim_no") );
		install_date=getDBStr( rs.getString("install_date") );
		gpsinfo_id=getDBStr( rs.getString("gpsinfo_id") );
		csmc=getDBStr( rs.getString("csmc") );
		address=getDBStr( rs.getString("address") );
		service_begindate=getDBDateStr( rs.getString("service_begindate") );
		service_enddate=getDBDateStr( rs.getString("service_enddate") );
		expect_start_date=getDBDateStr( rs.getString("expect_start_date") );
		yes_date=getDBDateStr( rs.getString("yes_date") );
		fixed_state=getDBStr( rs.getString("fixed_state") );
		sfmc=getDBStr( rs.getString("sfmc") );
		gps_index_type=getDBStr( rs.getString("gps_index_type") );
		memo=getDBStr( rs.getString("memo") );
		term=getDBStr( rs.getString("term") );
	}
	rs.close(); 
	db.close();
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
              <tr>
               <td >SIM���ţ�</td>
                <td><%=sim_no%></td>
                <td >�ͻ�����</td>
                <td><%=cust_name  %></td>
               
              </tr>
              <tr>
                <td >�����: </td>
                <td><%= machine_no %></td>
                <td >�ͺ�: </td>
                <td><%= machine_type %></td>
              </tr>
              <tr>
                <td >�������ڣ�</td>
                <td><%=expect_start_date  %></td>
                <td >��ѯ���ڣ�</td>
                <td><%= install_date %></td>
              </tr>
              <tr>
                <td >GPS�����ն���ţ�</td>
                <td><%=gps_index_type%></td>
                
                <td >���ޣ�</td>
                <td><%=term %></td>
              </tr>
              <tr>
                <td >����ʱ�䣺</td>
                <td><%=service_begindate%></td>
                <td >�����ֹʱ�䣺</td>
                <td><%=service_enddate %></td>
              </tr>
              <tr>
                
                <td >�������ڣ�</td>
                <td><%=yes_date%></td>
                 <td >��λ״̬��</td>
                <td><%=fixed_state %></td>
              </tr>
              <tr>
                <td >ʡ�ݣ�</td>
                <td><%= sfmc %></td>
                <td >�У�</td>
                <td><%=csmc%></td>
              </tr>
              <tr>
                <td >����</td>
                <td><%= address %></td>
                <td >��ע��</td>
                <td><%=memo%></td>
              </tr>
            </table>
</div>
</div>
    </form>
</body>
</html>
