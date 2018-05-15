<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ϸ - ��Ŀ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<body onload="public_onload(0);">

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ϸ - ��Ŀ���
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
<BUTTON class="btn_2" name="btnReset" value="�ر�" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">�ر�</button>
	    </td>
	    <!-- 
		 <td>
<BUTTON class="btn_2" name="btnExport" value="����"  type="submit"  onclick="return isExport();" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
	    </td>
	     -->
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">��ϸ��Ϣ</td>
  <td id="Form_tab_1" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">¼�����</td>
 
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<script language="javascript">
ShowTabN(0);
</script>

<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">

<%
//String sqlstr="";
//ResultSet rs = null;
//String oper = getStr( request.getParameter("oper") );
String proj_id = getStr( request.getParameter("proj_id") );

sqlstr = "select * from vi_proj_opinion_state where proj_id='"+proj_id+"'";
String proj_name="";
String opinion_amount="";
 
rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	proj_name=getDBStr(rs.getString("project_name"));
	opinion_amount=getDBStr(rs.getString("opinion_amount"));
}
rs.close();
//��ǰ��½�˵���������dqczy
String loginName = "";
sqlstr = "Select name from base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	loginName = rs.getString("name");
}
rs.close();
%>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td>��Ŀ���:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_id %></b></td>
    <td>&nbsp;</td>
    <td>��Ŀ����:&nbsp;&nbsp;<b style="color:#E46344;"><%=proj_name %></b></td>
    <td>&nbsp;</td>
	<td>�������:&nbsp;&nbsp;<b style="color:#E46344;"><%=CurrencyUtil.convertIntAmount(opinion_amount) %></b></td>
  </tr>
</table>
<br><br>
<form action="opinion_details.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
        <td align="left" width="1%"><!--������ť��ʼ-->
        </td>
        <!--������ť����-->
        
        <td align="right" width="95%"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%
			countSql = "select count(id) as amount from opinion_execution where proj_id='"+proj_id+"'";
		%>
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>
</form>

<!-- ����start -->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th>�����</th>
		<th>������ʵ��</th>
     	<th>���ʱ��</th>
		<th>Ԥ����ʵʱ��</th>
 		<th>���</th>
		<th>ִ�в���</th>
	 	<th>����</th>
	 	
	 	<th>�Ƿ����</th>
	    <th>ִ�н��</th>
	    <th>������</th>
	    <th>���ʱ��</th>
	    <th>�Ǽ���</th>
	    <th>�Ǽ�ʱ��</th>
	    
	    <th>����</th>

	</tr>
<tbody id="data">
<%
sqlstr = "select top "+ intPageSize +" oe.*,cjz=dbo.GETUSERNAME(oe.creator) from vi_opinion_execution oe where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_opinion_execution where proj_id='"+proj_id+"' order by id ) and proj_id='"+proj_id+"'";
sqlstr += " order by id ";

rs = db.executeQuery(sqlstr); 
while (rs.next()){
%>
	<tr>
		<td align="left"><%=getDBStr(rs.getString("raiser"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dutier"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("raiser_date")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="left" class="autoNewLine" width="280px"><%=getDBStr(rs.getString("idea")) %></td>
		<td><%=getDBStr(rs.getString("operation_dept")) %></td>
		<td><%=getDBStr(rs.getString("flow")) %></td>
    				
		<td align="center"><%=rs.getInt("status")==0?"��":"��" %></td>
		
		<td><%=getDBStr(rs.getString("result")) %></td>
		<td><%=getDBStr(rs.getString("remark")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("end_time")) %></td>
		<td><%=getDBStr(rs.getString("cjz")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
		
	
	     <td align="center">
	    <%
	    //�жϵ�ǰ��½�������������һ��
	    	if (rs.getInt("status")==0){
	    		if(dqczy.equals(getDBStr(rs.getString("creator")))){
	    %>
	    <script type="text/javascript">
			function updItem(texVal){
				if(confirm("ȷ��Ҫ�޸ĸ������")){
					window.open('opinion_mod_t.jsp?savetype=mod&item_id='+texVal);
				}
			}
			
			function delItem(texVal){
				if(confirm("ȷ��Ҫɾ���������")){
					window.open('opinion_save.jsp?savetype=del&item_id='+texVal);
				}
			}
		</script>
		<a href='Javascript: delItem(<%=getDBStr(rs.getString("id"))%>)'>ɾ��</a> &nbsp;|&nbsp;
	    <a href='Javascript: updItem(<%=getDBStr(rs.getString("id"))%>)'>�޸�</a> 
			<%}
	    		if(loginName.equals(getDBStr(rs.getString("dutier")))){
		    		%>&nbsp;|&nbsp;<a href="opinion_suc_exec.jsp?item_id=<%=getDBStr( rs.getString("id"))%>" target="_blank">��ʵִ��</a>
		    		<% }
				%>
			<%}else if(rs.getInt("status")==2){
				
				if(loginName.equals(getDBStr(rs.getString("prower_man")))){
		    		%>&nbsp;|&nbsp;<a href="opinion_save.jsp?savetype=suc&kid=<%=getDBStr( rs.getString("id"))%>" >ȷ��ִ�����</a>
		    		<% }
		} else{ %>
		�޲���
		<%}  
		 %>
		</td>
	    
	</tr>
<%
} %>
</tbody>
</table>
</div>
</div>
<div id="TD_tab_1" style="display:none;"> 
<form name="form1" action="opinion_save.jsp" target="new" onSubmit="return Validator.Validate(this,3);">
	<input type="hidden" name="savetype" value="add">
	<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
	  <tr>
	    <td scope="row">��Ŀ���</td>
	    <td scope="row">
	      <input name="proj_id" style="width:150px;" type="text" value="<%=proj_id %>" readonly="readonly">
		</td>
		<td scope="row">�����</td>
	    <td scope="row">
	<input style="width:150px;" name="raiser" id="raiser" type="text" value="<%=loginName %>" readonly="readonly" style="width: 100" Require="ture">
	<input name="id" type="hidden" value="<%=dqczy %>">
	<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('base_user.jsp',250,350)" >  
		<span class="biTian">*</span>
	    </td>
	  </tr>
	
	  <tr>
	    <td scope="row">������ʵ��</td>
	    <td scope="row">
		<input style="width:150px;" name="dutier" id="dutier" type="text" readonly="readonly" style="width: 100" Require="ture">
		<input name="id1" type="hidden">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('base_user_dutier.jsp',250,350)" >  
		<span class="biTian">*</span>
	   	</td>
	     <td scope="row">��ʵ����</td>
	    <td scope="row">
	    <input style="width:150px;" name="operation_dept" id="operation_dept" type="text" readonly="readonly" >
	    <input name="dept_id" type="hidden">
	    </td>
	    
	  </tr>
	  
	  <tr>
	   <td scope="row">���ʱ��</td>
	    <td scope="row">
	     <input id="raiser_date" name="raiser_date" type="text" style="width:150px;" readonly Require="ture">
		<img onClick="openCalendar(raiser_date);return false;" style="cursor:pointer; " 
		src="../../images/fdmo_63.gif" border="0" align="absmiddle">
		<span class="biTian">*</span>
	    </td>
	     <td scope="row">Ԥ����ʵʱ��</td>
	    <td scope="row">
	     <input id="plan_date" name="plan_date" type="text" style="width:150px;" readonly Require="ture">
		<img onClick="openCalendar(plan_date);return false;" style="cursor:pointer; " 
		src="../../images/fdmo_63.gif" border="0" align="absmiddle">
		<span class="biTian">*</span>
	    </td>
	    
	  </tr>
	<tr>
	<td>�����ʵ��Ա</td>
	<td scope="row">
		<input style="width:150px;" name="check_man" id="check_man" type="text" readonly="readonly" Require="ture" style="width: 100">
		<input name="id2" type="hidden">
		<img src="../../images/fdmo_65.gif" alt="ѡ" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('base_user_checkMan.jsp',250,350)" > 
		<span class="biTian">*</span>
		    </td>
			<td scope="row">��ʵ�׶�</td>
	    <td scope="row">
	    <select name="flow" style="width:150px;">
   <%
  		//List list=new ArrayList();
  		String xmlc="";
  		String sqlStr2="SELECT title FROM ifelc_conf_dictionary WHERE parentid='root.flowNameDefi'";
  		rs=db.executeQuery(sqlStr2);
  		while(rs.next()){
  		xmlc=rs.getString("title");
  		//list.add(name);
  		%>
  		<script type="text/javascript">
     	w(mSetOpt('',"<%=xmlc %>","<%=xmlc %>")); 
   		 </script>
  		<%
  		}
  		rs.close();
  		db.close();
   %>
   
 	</select><span class="biTian">*</span>
	    </td>
	</tr>
	  <tr>
	    <td scope="row">���</td>
	    <td colspan="3">
	  		<textarea rows="6" cols="4" name="idea" Require="ture"></textarea>
	  		<span class="biTian">*ֻ����800��</span>
	    </td>
	  </tr>
	  
	</table>
	
	<div  style="margin:12px;text-align:right;">
	<table border="0" cellspacing="0" cellpadding="0">
	<tr valign="top"><td>
	<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>
	
	<td>
	<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
	</td>
	</tr>
	</table>
	</div>
	</form>
</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--��ӽ���-->
<%
rs.close(); 
db.close();
%>

<!-- end cwMain -->
</body>
</html>
